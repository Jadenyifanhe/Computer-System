/**
 * @file tsh.c
 * @brief A tiny shell program with job control
 *
 * TODO: Delete this comment and replace it with your own.
 * <The line above is not a sufficient documentation.
 *  You will need to write your program documentation.
 *  Follow the 15-213/18-213/15-513 style guide at
 *  http://www.cs.cmu.edu/~213/codeStyle.html.>
 *
 * @author Yuchen Wu <yuchenwu@andrew.cmu.edu>
 * TODO: Include your name and Andrew ID here.
 */

#include "csapp.h"
#include "tsh_helper.h"

#include <assert.h>
#include <ctype.h>
#include <errno.h>
#include <fcntl.h>
#include <getopt.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h>
#include <unistd.h>

/*
 * If DEBUG is defined, enable contracts and printing on dbg_printf.
 */
#ifdef DEBUG
/* When debugging is enabled, these form aliases to useful functions */
#define dbg_printf(...) printf(__VA_ARGS__)
#define dbg_requires(...) assert(__VA_ARGS__)
#define dbg_assert(...) assert(__VA_ARGS__)
#define dbg_ensures(...) assert(__VA_ARGS__)
#else
/* When debugging is disabled, no code gets generated for these */
#define dbg_printf(...)
#define dbg_requires(...)
#define dbg_assert(...)
#define dbg_ensures(...)
#endif

/* Function prototypes */
void eval(const char *cmdline);

void sigchld_handler(int sig);
void sigtstp_handler(int sig);
void sigint_handler(int sig);
void sigquit_handler(int sig);
void cleanup(void);
/* Global variable to track if the foreground process has exited */
volatile sig_atomic_t fg_exit_flag;
/**
 * @brief <Write main's function header documentation. What does main do?>
 *
 * TODO: Delete this comment and replace it with your own.
 *
 * "Each function should be prefaced with a comment describing the purpose
 *  of the function (in a sentence or two), the function's arguments and
 *  return value, any error cases that are relevant to the caller,
 *  any pertinent side effects, and any assumptions that the function makes."
 */
int main(int argc, char **argv) {
    char c;
    char cmdline[MAXLINE_TSH]; // Cmdline for fgets
    bool emit_prompt = true;   // Emit prompt (default)

    // Redirect stderr to stdout (so that driver will get all output
    // on the pipe connected to stdout)
    if (dup2(STDOUT_FILENO, STDERR_FILENO) < 0) {
        perror("dup2 error");
        exit(1);
    }

    // Parse the command line
    while ((c = getopt(argc, argv, "hvp")) != EOF) {
        switch (c) {
        case 'h': // Prints help message
            usage();
            break;
        case 'v': // Emits additional diagnostic info
            verbose = true;
            break;
        case 'p': // Disables prompt printing
            emit_prompt = false;
            break;
        default:
            usage();
        }
    }

    // Create environment variable
    if (putenv("MY_ENV=42") < 0) {
        perror("putenv error");
        exit(1);
    }

    // Set buffering mode of stdout to line buffering.
    // This prevents lines from being printed in the wrong order.
    if (setvbuf(stdout, NULL, _IOLBF, 0) < 0) {
        perror("setvbuf error");
        exit(1);
    }

    // Initialize the job list
    init_job_list();

    // Register a function to clean up the job list on program termination.
    // The function may not run in the case of abnormal termination (e.g. when
    // using exit or terminating due to a signal handler), so in those cases,
    // we trust that the OS will clean up any remaining resources.
    if (atexit(cleanup) < 0) {
        perror("atexit error");
        exit(1);
    }

    // Install the signal handlers
    Signal(SIGINT, sigint_handler);   // Handles Ctrl-C
    Signal(SIGTSTP, sigtstp_handler); // Handles Ctrl-Z
    Signal(SIGCHLD, sigchld_handler); // Handles terminated or stopped child

    Signal(SIGTTIN, SIG_IGN);
    Signal(SIGTTOU, SIG_IGN);

    Signal(SIGQUIT, sigquit_handler);

    // Execute the shell's read/eval loop
    while (true) {
        if (emit_prompt) {
            printf("%s", prompt);

            // We must flush stdout since we are not printing a full line.
            fflush(stdout);
        }

        if ((fgets(cmdline, MAXLINE_TSH, stdin) == NULL) && ferror(stdin)) {
            perror("fgets error");
            exit(1);
        }

        if (feof(stdin)) {
            // End of file (Ctrl-D)
            printf("\n");
            return 0;
        }

        // Remove any trailing newline
        char *newline = strchr(cmdline, '\n');
        if (newline != NULL) {
            *newline = '\0';
        }

        // Evaluate the command line
        eval(cmdline);
    }

    return -1; // control never reaches here
}

void waitfg(pid_t pid) {
    sigset_t mask;
    sigemptyset(&mask);
    // Wait until foreground job end
    while (!fg_exit_flag) {
        sigsuspend(&mask);
    }
    return;
}

/**
 * @brief This function resumes a job by sending it a SIGCONT signal
 *
 * If the function receives a bg command, it resumes the job in the background.
 * If the function receives a fg command, it resumes the job in the foreground.
 *
 * @param[in] token Pointer to a cmdline_tokens structure with parsed tokens.
 */
void do_bgfg(struct cmdline_tokens *token) {
    sigset_t mask, prev_mask;
    sigfillset(&mask);
    // set mask
    pid_t pid = 0;
    jid_t jid = 0;
    if (!token->argv[1]) {
        sio_eprintf("%s command requires PID or %%jobid argument\n",
                    token->argv[0]);
        return;
    }
    // Block signals for the job list
    sigprocmask(SIG_BLOCK, &mask, &prev_mask);

    if (token->argv[1][0] == '%') {
        // '%' means for job id
        jid = atoi(&token->argv[1][1]);
        if (!jid) {
            sio_eprintf("%s: argument must be a PID or %%jobid\n",
                        token->argv[0]);
            // Unblock all signals
            sigprocmask(SIG_SETMASK, &prev_mask, NULL);
            return;
        }
        if (job_exists(jid)) {
            pid = job_get_pid(jid);
        } else {
            sio_eprintf("%s: No such job\n", token->argv[1]);
            // Unblock all signals
            sigprocmask(SIG_SETMASK, &prev_mask, NULL);
            return;
        }
    } else {
        // without '%', is pid
        pid = atoi(&token->argv[1][0]);
        if (!pid) {
            sio_eprintf("%s: argument must be a PID or %%jobid\n",
                        token->argv[0]);
            // Unblock all signals
            sigprocmask(SIG_SETMASK, &prev_mask, NULL);
            return;
        }
        jid = job_from_pid(pid);
        if (!job_exists(jid)) {
            sio_eprintf("%s: No such job\n", token->argv[1]);
            // Unblock all signals
            sigprocmask(SIG_SETMASK, &prev_mask, NULL);
            return;
        }
    }

    // resume background job
    if (token->builtin == BUILTIN_BG) {
        job_set_state(jid, BG);
        kill(-pid, SIGCONT);
        sio_printf("[%d] (%d) %s\n", jid, pid, job_get_cmdline(jid));
    }

    // resume foreground job
    if (token->builtin == BUILTIN_FG) {
        job_set_state(jid, FG);
        kill(-pid, SIGCONT);
        // Wait for foreground job to stop
        fg_exit_flag = 0;
        waitfg(pid);
    }

    // Unblock all signals
    sigprocmask(SIG_SETMASK, &prev_mask, NULL);

    return;
};

int builtin_command(struct cmdline_tokens *token) {
    int olderrno = errno;
    if (token->builtin == BUILTIN_QUIT) /* quit command */
        exit(0);
    if (token->builtin == BUILTIN_JOBS) {
        // Initialize the signal set to include all signals
        sigset_t mask, prev_mask;
        sigfillset(&mask);
        // Block all signals to access the job list
        sigprocmask(SIG_BLOCK, &mask, &prev_mask);
        if (token->outfile) {
            int output_fd =
                open(token->outfile, O_WRONLY | O_CREAT | O_TRUNC, DEF_MODE);
            if (output_fd < 0) {
                sio_eprintf("%s: %s\n", token->outfile, strerror(errno));
                sigprocmask(SIG_SETMASK, &prev_mask, NULL);
                errno = olderrno;
                return 1;
            } else {
                list_jobs(output_fd);
                close(output_fd);
            }
        } else {
            list_jobs(STDOUT_FILENO);
        }
        sigprocmask(SIG_SETMASK, &prev_mask, NULL);
        errno = olderrno;
        return 1;
    }
    // Handle the bg and fg commands
    if (token->builtin == BUILTIN_BG || token->builtin == BUILTIN_FG) {
        do_bgfg(token);
        return 1;
    }
    return 0; /* Not a builtin command */
}
/**
 * @brief This function generates a Unix-style error
 * @param[in] msg The error message.
 */
void unix_error(char *msg) {
    sio_eprintf("%s: %s\n", msg, strerror(errno));
    exit(-1);
}

/**
 * @brief <What does eval do?>
 * NOTE: The shell is supposed to be a long-running process, so this function
 *       (and its helpers) should avoid exiting on error.  This is not to say
 *       they shouldn't detect and print (or otherwise handle) errors!
 */
void eval(const char *cmdline) {
    parseline_return parse_result;
    struct cmdline_tokens token;
    int bg;
    jid_t jid;
    pid_t pid;
    sigset_t mask, prev_mask;
    sigemptyset(&mask);
    sigaddset(&mask, SIGCHLD);
    sigaddset(&mask, SIGINT);
    sigaddset(&mask, SIGTSTP);

    // Parse command line
    parse_result = parseline(cmdline, &token);

    if (parse_result == PARSELINE_ERROR || parse_result == PARSELINE_EMPTY) {
        return;
    }

    // wether it is a background process
    bg = (parse_result == PARSELINE_BG);

    // Initialize the signal set to include SIGCHLD, SIGINT, SIGTSTP

    if (!builtin_command(&token)) {
        sigprocmask(SIG_BLOCK, &mask, &prev_mask); /* block signal */
        if ((pid = fork()) == 0) {                 /* Child runs user job */
            sigprocmask(SIG_SETMASK, &prev_mask,
                        NULL); /* unblock signal in child */
            setpgid(0,
                    0); /* puts the child in a new process group, GID = PID */
            if (token.infile) {
                // Input file descriptor
                int input_fd = open(token.infile, O_RDONLY, DEF_MODE);
                if (input_fd < 0) {
                    unix_error(token.infile);
                }
                // Redirect stdin to input_fd
                dup2(input_fd, STDIN_FILENO);
                close(input_fd);
            }
            // Redirect output
            if (token.outfile) {
                // Output file descriptor
                int output_fd =
                    open(token.outfile, O_WRONLY | O_CREAT | O_TRUNC, DEF_MODE);
                if (output_fd < 0) {
                    unix_error(token.outfile);
                }
                // Redirect stdout to output_fd
                dup2(output_fd, STDOUT_FILENO);
                close(output_fd);
            }
            if (execve(token.argv[0], token.argv, environ) < 0) {
                unix_error(token.argv[0]);
            }
        }
        /* adds the child to job list */
        jid = add_job(pid, bg ? BG : FG, cmdline);
        /* Parent waits for foreground job to terminate */
        if (!bg) {
            // Parent process waits for foreground job to stop or terminate
            fg_exit_flag = 0;
            waitfg(pid);
        } else {
            // Print backgroud job
            sio_printf("[%d] (%d) %s\n", jid, pid, cmdline);
        }
        sigprocmask(SIG_SETMASK, &prev_mask, NULL); /* unblock SIGCHLD */
    }

    return;
}

/*****************
 * Signal handlers
 *****************/

/**
 * @brief <What does sigchld_handler do?>
 *
 * TODO: Delete this comment and replace it with your own.
 */

void sigchld_handler(int sig) {
    // Save errno
    int olderrno = errno;
    jid_t jid;
    pid_t pid;
    int status;
    sigset_t mask, prev_mask;
    sigfillset(&mask);
    // Block all signals for the job list
    sigprocmask(SIG_BLOCK, &mask, &prev_mask);
    while ((pid = waitpid(-1, &status, WNOHANG | WUNTRACED)) > 0) {
        jid = job_from_pid(pid);
        if (job_get_state(jid) == FG) {
            // Mark the foreground process terminated
            fg_exit_flag = 1;
        }
        if (WIFEXITED(status)) {
            /* process terminated normaly */
            delete_job(jid);
        }
        if (WIFSIGNALED(status)) {
            /* process terminated by signals e.g., ctrl-c */
            delete_job(jid);
            sio_printf("Job [%d] (%d) terminated by signal %d\n", jid, pid,
                       WTERMSIG(status));
        }

        /* process stopped by signals e.g., ctrl-z */
        if (WIFSTOPPED(status)) {
            job_set_state(jid, ST);
            sio_printf("Job [%d] (%d) stopped by signal %d\n", jid, pid,
                       WSTOPSIG(status));
        }
    }
    // Unblock all signals
    sigprocmask(SIG_SETMASK, &prev_mask, NULL);
    // Restore errno
    errno = olderrno;
    return;
}

/**
 * @brief The interrupt signal, sends SIGINT to the job running in
 * the foreground.
 */
void sigint_handler(int sig) {
    int olderrno = errno;
    sigset_t prev_mask, mask;

    sigfillset(&mask);
    // Block all signals for the job list
    pid_t pid = 0;
    jid_t jid = 0;

    sigprocmask(SIG_BLOCK, &mask, &prev_mask);
    // Find the foreground job

    jid = fg_job();
    if (job_exists(jid)) {
        pid = job_get_pid(jid);
    }
    // Send the SIGINT signal if exit
    if (pid) {
        kill(-pid, sig);
    }
    // Unblock signals
    sigprocmask(SIG_SETMASK, &prev_mask, NULL);
    // Restore errno
    errno = olderrno;
    return;
}

/**
 * @brief The suspend signal, sends a SIGTSTP to a running program, thus
 * stopping it and returning control to the shell.
 */
void sigtstp_handler(int sig) {
    int olderrno = errno;
    sigset_t prev_mask, mask;
    sigfillset(&mask);
    // Block all signals for the job list
    pid_t pid = 0;
    jid_t jid = 0;

    sigprocmask(SIG_BLOCK, &mask, &prev_mask);
    // Find the foreground job
    jid = fg_job();
    if (jid) {
        pid = job_get_pid(jid);
    }
    // Send the SIGTSTP signal, if exit
    if (pid) {
        kill(-pid, sig);
    }
    // Unblock all signals
    sigprocmask(SIG_SETMASK, &prev_mask, NULL);
    // Restore errno
    errno = olderrno;
    return;
}

void cleanup(void) {
    // Signals handlers need to be removed before destroying the joblist
    Signal(SIGINT, SIG_DFL);  // Handles Ctrl-C
    Signal(SIGTSTP, SIG_DFL); // Handles Ctrl-Z
    Signal(SIGCHLD, SIG_DFL); // Handles terminated or stopped child

    destroy_job_list();
}
