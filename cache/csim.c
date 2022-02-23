/*
 *           Name : Yuchen Wu
 *      Andrew id : yuchenwu
 */
#include "cachelab.h"
#include <getopt.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

struct line {
    int valid;         // valid bit
    int dirty;         // dirty bit
    unsigned long tag; // tag
    int LRU;           // LRU status, wheather it needs to be changed or not
};
struct line **cache = NULL; // declare 2D-array cache as a global variable
csim_stats_t *stats = NULL;

int max_bits = 64;                // global variables
int s = -1, E = 0, b = -1, S = 0; // global variables
unsigned long hits = 0, misses = 0, evictions = 0, dirty_bytes = 0,
              dirty_evictions = 0; // flags for each operation status

// initial function to initial the cache
void initial_cache(int S) {
    for (int i = 0; i < S; ++i) {
        for (int j = 0; j < E; ++j) {
            cache[i][j].valid = 0;
            cache[i][j].dirty = 0;
            cache[i][j].tag = 0xFFFFFFFFFFFFFFFF;
            cache[i][j].LRU = 0;
        }
    }
}

// find the highest LRU status cache index
int checkLRU(unsigned long set) {
    int high = -1; // the highest LRU value
    int index = -1;
    int i;
    for (i = 0; i < E; ++i) {
        if (cache[set][i].LRU > high) {
            high = cache[set][i].LRU;
            index = i;
        }
    }
    return index;
}

// add the value into the cache
int add_cache(char op, unsigned long tag, unsigned long set) {
    int flag = 0;
    for (int i = 0; i < E; ++i) {
        if (cache[set][i].valid == 0) {
            misses += 1;
            cache[set][i].valid = 1;
            cache[set][i].LRU = 0;
            cache[set][i].tag = tag;
            if (op == 'S') {
                dirty_bytes +=
                    (1 << b); // calculate the dirty bytes inside the cache
                cache[set][i].dirty = 1; // set the dirty flag equals to 1
            }
            flag = 1;
            break;
        }
    }
    return flag;
}

// access the cache
void access_cache(char op, unsigned long addr) {
    unsigned long tag = addr >> (s + b); // find the tag
    int t = max_bits - s - b;
    unsigned long set = (addr << t) >> (t + b); // find the set
    int flag = 0;
    if (s == 0) {
        set = addr & 0; // prevent the situation that there is no bit for set
    }
    for (int i = 0; i < E; ++i) {
        if (cache[set][i].tag == tag) {
            hits += 1;
            cache[set][i].LRU = 0;
            if (op == 'S' && cache[set][i].dirty == 0) {
                dirty_bytes += 1 << b;
                cache[set][i].dirty = 1;
            }
            flag = 1; // hit
            break;
        }
    }
    if (flag == 1) {
        return; // if hit, return
    }
    int flag2 =
        add_cache(op, tag, set); // flag for wethear can add it into the set.
    if (flag2 == 1) {
        return; // the set is not full, add into the set.
    }

    int LRU_index; // the set full, we need use LRU method to replace.
    LRU_index =
        checkLRU(set); // find the line inside the set that has the highest LRU
                       // value, which means less frequency to access.
    misses += 1;
    evictions += 1;

    if (cache[set][LRU_index].dirty == 1) {
        dirty_evictions += 1 << b; // calculate the dirty_evictions bytes
        dirty_bytes -=
            1 << b; // those bytes has been replaced, so we have to minus to
                    // calculate the dirty bytes inside the cache.
        cache[set][LRU_index].dirty = 0;
    }

    if (op == 'S') {
        dirty_bytes += 1 << b; // if store, then dirty sign for 1.
        cache[set][LRU_index].dirty = 1;
    }
    cache[set][LRU_index].tag = tag;
    cache[set][LRU_index].LRU = 0;
}

// update the LRU value in each iteration
void update_LRU(int S) {
    for (int i = 0; i < S; ++i) {
        for (int j = 0; j < E; ++j) {
            if (cache[i][j].valid) {
                cache[i][j].LRU++;
            }
        }
    }
}

int main(int argc, char *argv[]) {
    int flag = 0;
    int verbose = 0;
    char *t = NULL;
    while ((flag = getopt(argc, argv, "hvs:E:b:t:")) != -1)
    // parse commandline arguments
    {
        switch (flag) {
        case 'v':
            verbose = 1;
            break;
        case 'h':
            printf("Usage: ./csim [-hv] -s <s> -E <E> -b <b> -t <tracefile>\n");
            exit(0);
        case 's':
            s = atoi(optarg);
            if (s < 0 && s > max_bits) {
                printf("Error: s value must be in [0, word_length].\n");
                exit(-1);
            }
            break;
        case 'E':
            E = atoi(optarg);
            if (E <= 0) {
                printf("Error: E value must be larger than 0.\n");
                exit(-1);
            }
            break;
        case 'b':
            b = atoi(optarg);
            if (b < 0 || b > max_bits) {
                printf("Error: b value must be in [0, word_length].\n");
                exit(-1);
            }
            break;
        case 't':
            t = optarg;
            break;
        default:
            break;
        }
    }

    // check for extra arguments
    if (optind < argc) {
        fprintf(stderr, "Extra arguments passed.\n");
        fprintf(stderr,
                "Usage: ./csim [-hv] -s <s> -E <E> -b <b> -t <tracefile>\n");
        exit(1);
    }

    // check for mandatory arguments
    if (s == -1 || E == -1 || b == -1 || t == NULL) {
        fprintf(stderr, "Mandatory arguments missing or zero.\n");
        fprintf(stderr,
                "Usage: ./csim [-hv] -s <s> -E <E> -b <b> -t <tracefile>\n");
        exit(1);
    }

    int S = 1 << s; // the number of sets inside the cache

    // open trace file
    FILE *fp = fopen(t, "r");
    if (!fp) {
        fprintf(stderr, "Error opening trace file\n");
        exit(1);
    }

    cache = calloc((unsigned long)S,
                   sizeof(struct line *)); // allocate memory for cache
    for (int i = 0; i < S; ++i) {
        cache[i] = calloc(
            (unsigned long)E,
            sizeof(struct line)); // allocate memory for E cache lines in a set
    }
    initial_cache(S); // initialize cache
    stats = (csim_stats_t *)malloc(
        sizeof(csim_stats_t)); // allocate memory for stats
    stats->dirty_bytes = 0;
    stats->dirty_evictions = 0;

    // read trace file
    char op;
    unsigned long addr;
    size_t size;
    while (fscanf(fp, "%c %lx,%zu\n", &op, &addr, &size) == 3) {
        // initialize flags
        dirty_bytes = 0;
        dirty_evictions = 0;
        access_cache(op, addr); // update cache for current operation
        // verbose output
        if (verbose) {
            printf("%c %lx,%zu", op, addr, size);
            if (hits) {
                printf(" hit\n");
            }
            if (misses) {
                printf(" miss");
                if (evictions) {
                    printf(" eviction\n");
                } else {
                    printf("\n");
                }
            }
        }

        // update stats
        stats->dirty_bytes += dirty_bytes;
        stats->dirty_evictions += dirty_evictions;
        update_LRU(S); // increment LRU order after every operation
    }
    stats->hits = hits;
    stats->misses = misses;
    stats->evictions = evictions;
    printSummary(stats);

    // free memory
    for (int i = 0; i < S; ++i) {
        free(cache[i]); // free cache lines in a set
    }
    free(cache); // free cache
    free(stats); // free stats
    fclose(fp);

    return 0;
}
