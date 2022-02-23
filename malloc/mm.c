/**
 * @file mm.c
 * @brief A 64-bit struct-based implicit free list memory allocator
 *
 * 15-213: Introduction to Computer Systems
 *
 * TODO: insert your documentation here. :)
 *
 *************************************************************************
 *
 * ADVICE FOR STUDENTS.
 * - Step 0: Please read the writeup!
 * - Step 1: Write your heap checker.
 * - Step 2: Write contracts / debugging assert statements.
 * - Good luck, and have fun!
 *
 *************************************************************************
 *
 * @author Yuchen Wu <yuchenwu@andrew.cmu.edu>
 */

#include <assert.h>
#include <inttypes.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include "memlib.h"
#include "mm.h"

/* Do not change the following! */

#ifdef DRIVER
/* create aliases for driver tests */
#define malloc mm_malloc
#define free mm_free
#define realloc mm_realloc
#define calloc mm_calloc
#define memset mem_memset
#define memcpy mem_memcpy
#endif /* def DRIVER */

/* You can change anything from here onward */

/*
 *****************************************************************************
 * If DEBUG is defined (such as when running mdriver-dbg), these macros      *
 * are enabled. You can use them to print debugging output and to check      *
 * contracts only in debug mode.                                             *
 *                                                                           *
 * Only debugging macros with names beginning "dbg_" are allowed.            *
 * You may not define any other macros having arguments.                     *
 *****************************************************************************
 */
#ifdef DEBUG
/* When DEBUG is defined, these form aliases to useful functions */
#define dbg_printf(...) printf(__VA_ARGS__)
#define dbg_requires(expr) assert(expr)
#define dbg_assert(expr) assert(expr)
#define dbg_ensures(expr) assert(expr)
#define dbg_printheap(...) print_heap(__VA_ARGS__)
#else
/* When DEBUG is not defined, no code gets generated for these */
/* The sizeof() hack is used to avoid "unused variable" warnings */
#define dbg_printf(...) (sizeof(__VA_ARGS__), -1)
#define dbg_requires(expr) (sizeof(expr), 1)
#define dbg_assert(expr) (sizeof(expr), 1)
#define dbg_ensures(expr) (sizeof(expr), 1)
#define dbg_printheap(...) ((void)sizeof(__VA_ARGS__))
#endif

/* Basic constants */

typedef uint64_t word_t;

/** @brief Word and header size (bytes) */
static const size_t wsize = sizeof(word_t);

/** @brief Double word size (bytes) */
static const size_t dsize = 2 * wsize;

/** @brief Minimum regular block size (bytes) */
static const size_t min_block_size = 2 * dsize;

/** @brief size of Mini Block */
static const size_t mini_block_size = dsize;

/**
 * @brief First, chunksize must be divisible by dsize. The extension of the
 * empty heap is related with chunksize. chunksize should be large enough. 2**12
 * is enough for that size.
 */
static const size_t chunksize = (1 << 12);

/**
 * @brief extract the final bit of the headr, which shows whether the block is
 * allocated or not.' The allocated memory is the multiple of 16.
 */
static const word_t alloc_mask = 0x1;

/**
 * @brief extract the second bit of the headr, which shows whether the previous
 * block is allocated or not.' The allocated memory is the multiple of 16.
 */
static const word_t pre_alloc_mask = (1 << 1);

/**
 * @brief extract the third bit of the headr, which shows whether the block is
 * mini block or not.' The allocated memory is the multiple of 16.
 */
static const word_t mini_mask = (1 << 2);

/**
 * @brief extract the forth bit of the headr, which shows whether the previous
 * block is mini block or not.' The allocated memory is the multiple of 16.
 */
static const word_t pre_mini_mask = (1 << 3);

/**
 * @brief the size is the multiple of 16. We extract the upper bits, not the
 * lower four bits, presents the allocated size.
 */
static const word_t size_mask = ~(word_t)0xF;

/**
 * @brief the maxium number of segregate list, 120/8 = 15.
 */
static const int segnum = 15;

/** @brief Pointer to first block in the heap */

/** @brief forward declaration of block_t */
struct block;
typedef struct block block_t;

/*
 * The link for connecting between previous free block and the next free block.
 */
typedef struct {
    block_t *next;
    block_t *prev;
} link_t;

/*
 * Pointer and Payload union.
 */
typedef union {
    link_t node;
    char payload[0];
} mem_t;

struct block {
    word_t header;
    mem_t memory;
};

// Pointer to first block
static block_t *heap_start = NULL;
// Segregated free block lists
static block_t *list_head[segnum];

/*
 *****************************************************************************
 * The functions below are short wrapper functions to perform                *
 * bit manipulation, pointer arithmetic, and other helper operations.        *
 *                                                                           *
 * We've given you the function header comments for the functions below      *
 * to help you understand how this baseline code works.                      *
 *                                                                           *
 * Note that these function header comments are short since the functions    *
 * they are describing are short as well; you will need to provide           *
 * adequate details for the functions that you write yourself!               *
 *****************************************************************************
 */

/*
 * ---------------------------------------------------------------------------
 *                        BEGIN SHORT HELPER FUNCTIONS
 * ---------------------------------------------------------------------------
 */

/**
 * @brief Returns the maximum of two integers.
 * @param[in] x
 * @param[in] y
 * @return `x` if `x > y`, and `y` otherwise.
 */
static size_t max(size_t x, size_t y) {
    return (x > y) ? x : y;
}

/**
 * @brief Rounds `size` up to next multiple of n
 * @param[in] size
 * @param[in] n
 * @return The size after rounding up
 */
static size_t round_up(size_t size, size_t n) {
    return n * ((size + (n - 1)) / n);
}

/**
 * @brief Packs the `size` and `alloc` of a block into a word suitable for
 *        use as a packed value.
 *
 * Packed values are used for both headers and footers.
 *
 * The allocation status is packed into the lowest bit of the word.
 *
 * @param[in] size The size of the block being represented
 * @param[in] alloc True if the block is allocated
 * @return The packed value
 */
static word_t pack(size_t size, bool prev_mini, bool mini, bool prev_alloc,
                   bool alloc) {
    word_t word = size;
    if (alloc) {
        word |= alloc_mask;
    }
    if (prev_alloc) {
        word |= pre_alloc_mask;
    }
    if (mini) {
        word |= mini_mask;
    }
    if (prev_mini) {
        word |= pre_mini_mask;
    }
    return word;
}

/**
 * @brief Extracts the size represented in a packed word.
 *
 * This function simply clears the lowest 4 bits of the word, as the heap
 * is 16-byte aligned.
 *
 * @param[in] word
 * @return The size of the block represented by the word
 */
static size_t extract_size(word_t word) {
    return (word & size_mask);
}

/**
 * the previous block is allocate or not
 */
static bool ifprealloc(block_t *block) {
    return (bool)(block->header & pre_alloc_mask);
}

/**
 * the block is mini block or not
 */
static bool ifmini(block_t *block) {
    return (bool)(block->header & mini_mask);
}

/**
 * the previous block is mini block or not
 */
static bool ifpremini(block_t *block) {
    return (bool)(block->header & pre_mini_mask);
}

/**
 * @brief Extracts the size of a block from its header.
 * @param[in] block
 * @return The size of the block
 */
static size_t get_size(block_t *block) {
    return ifmini(block) ? mini_block_size : extract_size(block->header);
}

/**
 * @brief Given a payload pointer, returns a pointer to the corresponding
 *        block.
 * @param[in] bp A pointer to a block's payload
 * @return The corresponding block
 */
static block_t *payload_to_header(void *bp) {
    return (block_t *)((char *)bp - offsetof(block_t, memory));
}

/**
 * @brief Given a block pointer, returns a pointer to the corresponding
 *        payload.
 * @param[in] block
 * @return A pointer to the block's payload
 * @pre The block must be a valid block, not a boundary tag.
 */
static void *header_to_payload(block_t *block) {
    dbg_requires(get_size(block) != 0);
    return (void *)(block->memory.payload);
}

/**
 * @brief Given a block pointer, returns a pointer to the corresponding
 *        footer.
 * @param[in] block
 * @return A pointer to the block's footer
 * @pre The block must be a valid block, not a boundary tag.
 */
static word_t *header_to_footer(block_t *block) {
    dbg_requires(get_size(block) != 0 &&
                 "Called header_to_footer on the epilogue block");
    return (word_t *)(block->memory.payload + get_size(block) - dsize);
}

/**
 * @brief Given a block footer, returns a pointer to the corresponding
 *        header.
 * @param[in] footer A pointer to the block's footer
 * @return A pointer to the start of the block
 * @pre The footer must be the footer of a valid block, not a boundary tag.
 */
static block_t *footer_to_header(word_t *footer) {
    size_t size = extract_size(*footer);
    dbg_assert(size != 0 && "Called footer_to_header on the prologue block");
    return (block_t *)((char *)footer + wsize - size);
}

/**
 * @brief Returns the payload size of a given block.
 *
 * The payload size is equal to the entire block size minus the sizes of the
 * block's header.
 *
 * @param[in] block
 * @return The size of the block's payload
 */
static size_t get_payload_size(block_t *block) {
    size_t asize = get_size(block);
    return asize - wsize;
}

/**
 * @brief Returns the allocation status of a given header value.
 *
 * This is based on the lowest bit of the header value.
 *
 * @param[in] word
 * @return The allocation status correpsonding to the word
 */
static bool extract_alloc(word_t word) {
    return (bool)(word & alloc_mask);
}

/**
 * @brief Returns the allocation status of a block, based on its header.
 * @param[in] block
 * @return The allocation status of the block
 */
static bool get_alloc(block_t *block) {
    return extract_alloc(block->header);
}

/**
 * @brief Writes an epilogue header at the given address.
 *
 * The epilogue header has size 0, and is marked as allocated.
 *
 * @param[out] block The location to write the epilogue header
 * @param[in] prev_mini The previous mini status of the epilogue
 * @param[in] prev_alloc The previous allocation status of the epilogue
 * @pre The block must be the epilogue
 */
static void write_epilogue(block_t *block, bool prev_mini, bool prev_alloc) {
    dbg_requires(block != NULL);
    dbg_requires((char *)block == mem_heap_hi() - 7);
    block->header = pack(0, prev_mini, false, prev_alloc, true);
}

/**
 * @brief Writes a block starting at the given address.
 *
 * This function writes both a header and footer, where the location of the
 * footer is computed in relation to the header.
 *
 * @param[out] block The location to begin writing the block header
 * @param[in] size The size of the new block
 * @param[in] prev_mini The previous mini status of the new block
 * @param[in] mini The mini status of the new block
 * @param[in] prev_alloc The previous allocation status of the new block
 * @param[in] alloc The allocation status of the new block
 * @pre The block must not be NULL and must have size > 0
 */
static void write_block(block_t *block, size_t size, bool prev_mini, bool mini,
                        bool prev_alloc, bool alloc) {
    dbg_requires(block != NULL);
    dbg_requires(size > 0);
    block->header = pack(size, prev_mini, mini, prev_alloc, alloc);
    // Allocated blocks and mini blocks do not have a footer
    if (!alloc && !mini) {
        word_t *footerp = header_to_footer(block);
        *footerp = pack(size, prev_mini, mini, prev_alloc, alloc);
    }
}

/**
 * @brief Finds the next consecutive block on the heap.
 *
 * This function accesses the next block in the "implicit list" of the heap
 * by adding the size of the block.
 *
 * @param[in] block A block in the heap
 * @return The next consecutive block on the heap
 * @pre The block is not the epilogue
 */
static block_t *find_next(block_t *block) {
    dbg_requires(block != NULL);
    dbg_requires(get_size(block) != 0 &&
                 "Called find_next on the last block in the heap");
    return (block_t *)((char *)block + get_size(block));
}

/**
 * @brief Finds the footer of the previous block on the heap.
 * @param[in] block A block in the heap
 * @return The location of the previous block's footer
 */
static word_t *find_prev_footer(block_t *block) {
    // Compute previous footer position as one word before the header
    return &(block->header) - 1;
}

/**
 * @brief Finds the previous consecutive block on the heap.
 *
 * This is the previous block in the "implicit list" of the heap.
 *
 * If the function is called on the first block in the heap, NULL will be
 * returned, since the first block in the heap has no previous block!
 *
 * The position of the previous block is found by reading the previous
 * block's footer to determine its size, then calculating the start of the
 * previous block based on its size.
 *
 * @param[in] block A block in the heap
 * @return The previous consecutive block in the heap.
 */
static block_t *find_prev(block_t *block) {
    dbg_requires(block != NULL);
    if (ifpremini(block)) {
        // The size of mini block is stationary
        return (block_t *)((char *)block - mini_block_size);
    } else {
        // Mini block does not have footer
        word_t *footerp = find_prev_footer(block);
        if (extract_size(*footerp) == 0) {
            return NULL;
        }
        return footer_to_header(footerp);
    }
}

/**
 * @brief Finds the position in the seglist.
 *
 */
static int findlist(size_t size) {
    if (size == mini_block_size) {
        return 0;
    }
    size_t block_size = min_block_size;
    int i = 1;
    while (size > block_size << 1 && i < 14) {
        i++;
        block_size <<= 1;
    }
    return i;
}

/**
 * @brief Sets the `prev` pointer of a free block.
 *
 */
static void set_pointer(block_t *block, block_t *prev_block) {
    if (ifmini(block)) {
        block->header = (((word_t)prev_block << 1) & size_mask) +
                        (block->header & ~size_mask);
    } else {
        block->memory.node.prev = prev_block;
    }
}

/**
 * @brief Remove the block if allocated.
 */
static void remove_list(block_t *block) {
    size_t block_size = get_size(block);
    int index = findlist(block_size);
    if (list_head[index] == block) {
        if (block->memory.node.next == block) {
            list_head[index] = NULL;
            return;
        } else {
            list_head[index] = block->memory.node.next;
        }
    }
    block_t *prev_block;
    if (ifmini(block)) {
        // because the mini block size is stationary, so we save in the address
        // in the header.
        prev_block =
            (block_t *)((extract_size(block->header) & 0xFFFFFFFFFFFFFFFE) >>
                        1);
    } else {
        prev_block = block->memory.node.prev;
    }
    set_pointer(block->memory.node.next, prev_block);
    prev_block->memory.node.next = block->memory.node.next;
}

/**
 * @brief Insert the block if freed.
 */
static void insert_free_block(block_t *block) {
    size_t block_size = get_size(block);
    int index = findlist(block_size);
    // If seglist is empty, make block the only node in the seglist
    if (list_head[index] == NULL) {
        list_head[index] = block;
        list_head[index]->memory.node.next = block;
        set_pointer(list_head[index], block);
    } else {
        block_t *prev_block;
        // Insert block at the beginning/end of the seglist
        if (ifmini(block)) {
            // because the mini block size is stationary, so we save in the
            // address in the header.
            prev_block = (block_t *)((extract_size(list_head[index]->header) &
                                      0xFFFFFFFFFFFFFFFE) >>
                                     1);
        } else {
            prev_block = (list_head[index])->memory.node.prev;
        }
        block->memory.node.next = list_head[index];
        set_pointer(block, prev_block);
        prev_block->memory.node.next = block;
        set_pointer(list_head[index], block);
    }
}

/*
 * ---------------------------------------------------------------------------
 *                        END SHORT HELPER FUNCTIONS
 * ---------------------------------------------------------------------------
 */

/**
 * @brief Coalesce free block with previous and next blocks if they are free.
 *
 * Insert the coalesced block into the seglists.
 *
 * Remove other free blocks from the seglists.
 *
 * @param[in] block The free block to be coalesced
 * @return The coalesced free block.
 * @pre The block must be free
 */
static block_t *coalesce_block(block_t *block) {
    size_t block_size = get_size(block);
    block_t *block_next = find_next(block);

    bool prev_alloc = ifprealloc(block);
    bool next_alloc = get_alloc(block_next);
    // four situation for the block coalescing
    // The pre block and next block is allocated
    if (prev_alloc && next_alloc) {
    } 
    // The pre block is allocated and next block is free
    else if (prev_alloc && !next_alloc) {
        block_size += get_size(block_next);
        remove_list(block_next);
    // The next block is allocated and pre block is free
    } else if (!prev_alloc && next_alloc) {
        block_t *block_prev = find_prev(block);
        block_size += get_size(block_prev);
        remove_list(block_prev);
        block = block_prev;
    // The pre block and next block is free
    } else {
        block_size += get_size(block_next);
        remove_list(block_next);
        block_t *block_prev = find_prev(block);
        block_size += get_size(block_prev);
        remove_list(block_prev);
        block = block_prev;
    }
    // Write the new block on the heap
    bool mini = (block_size == mini_block_size);
    write_block(block, block_size, ifpremini(block), mini, ifprealloc(block),
                false);
    insert_free_block(block);
    // Update previous mini flag of the next block
    block_next = find_next(block);
    size_t block_next_size = get_size(block_next);
    if (block_next_size > 0) {
        write_block(block_next, extract_size(block_next->header), mini,
                    ifmini(block_next), false, get_alloc(block_next));
    } else {
        write_epilogue(block_next, mini, false);
    }

    return block;
}

/**
 * @brief
 *
 * <What does this function do?>
 * <What are the function's arguments?>
 * <What is the function's return value?>
 * <Are there any preconditions or postconditions?>
 *
 * @param[in] size
 * @return
 */
static block_t *extend_heap(size_t size) {
    void *bp;

    // Allocate an even number of words to maintain alignment
    size = round_up(size, dsize);
    if ((bp = mem_sbrk(size)) == (void *)-1) {
        return NULL;
    }

    // Initialize free block header/footer
    block_t *block = payload_to_header(bp);
    write_block(block, size, ifpremini(block), false, ifprealloc(block), false);
    // Create new epilogue header
    block_t *block_next = find_next(block);
    write_epilogue(block_next, false, false);

    // Coalesce in case the previous block was free
    block = coalesce_block(block);

    return block;
}

/**
 * @brief
 *split block if it is too large.
 *
 * @param[in] block
 * @param[in] asize
 */
static void split_block(block_t *block, size_t asize) {
    dbg_requires(get_alloc(block));

    size_t block_size = get_size(block);

    if ((block_size - asize) >= mini_block_size) {
        // Write the allocated block
        block_t *block_next;
        if (asize == mini_block_size) {
            write_block(block, asize, ifpremini(block), true, ifprealloc(block),
                        true);
        } else {
            write_block(block, asize, ifpremini(block), false,
                        ifprealloc(block), true);
        }
        // Write the remaining free block

        block_next = find_next(block);
        bool mini = ((block_size - asize) == mini_block_size);
        if ((block_size - asize) == mini_block_size) {
            write_block(block_next, (block_size - asize), ifpremini(block_next),
                        true, true, false);
        } else {
            write_block(block_next, (block_size - asize), ifpremini(block_next),
                        false, true, false);
        }
        insert_free_block(block_next);
        // Update previous mini flag of the next block of the remaining block

        block_t *block_next_next = find_next(block_next);
        size_t block_next_size = get_size(block_next_next);
        if (block_next_size > 0) {
            write_block(block_next_next, extract_size(block_next_next->header),
                        mini, ifmini(block_next_next), false,
                        get_alloc(block_next_next));
        } else {
            write_epilogue(block_next_next, mini, false);
        }
    }

    dbg_ensures(get_alloc(block));
}

/**
 * @brief Find the best block to allocate using best-fit policy.
 *
 * Start from the seglist with at least `asize` and search all bigger seglists
 * Return after looking through `maximum_block` blocks.
 *
 * @param[in] asize The allocate size
 * @return The best block to allocate.
 */
static block_t *find_fit(size_t asize) {
    // Find the seglist with at least `asize`
    int index = findlist(asize);
    int i = index;


    while (i < segnum) {
        block_t *block = list_head[i];
        if (block != NULL) {
            do {
                if (asize <= get_size(block)) {
                    return block;
                }
                block = block->memory.node.next;
            } while (block != list_head[i]);
        }
        i++;
    }

    return NULL;
}

/**
 * @brief Check the heap and the free seglists for consistency.
 *
 * @param[in] line The line number of the source code where the function is
 * called
 * @return True if the all the blocks on the heap and in the seglists are
 * consistent.
 */
bool mm_checkheap(int line) {
    block_t *prologue = (block_t *)mem_heap_lo();
    block_t *block = heap_start;
    long free_counts = 0;
    block_t *block_prev = NULL;
    if ((get_size(prologue) != 0) || (!get_alloc(prologue))) {
        printf("Prologue error\n");
        return false;
    }
    bool prev_alloc = ifprealloc(prologue);
    bool prev_mini = ifpremini(prologue);
    while (get_size(block) > 0) {
        // check if the allocated space is the multiple of dsize or not.
        if ((get_size(block) % dsize) != 0) {
            printf("block size error\n");
            return false;
        }

        // calculate the number of free blocks
        if (!get_alloc(block)) {
            free_counts++;
        }

        // check the block if inside the heap boundaries
        if (block < (block_t *)mem_heap_lo() ||
            block > (block_t *)mem_heap_hi()) {
            printf("blocks outside the boundaries\n");
            return false;
        }
        // Check previous allocation bit consistency
        if (ifprealloc(block) != prev_alloc) {
            printf("Previous allocation flag mismatch");
            return false;
        }
        // Check previous mini bit consistency
        if (ifpremini(block) != prev_mini) {
            printf("Line %d: Block %p: Previous mini flag mismatch\n", line,
                   block);
            return false;
        }
        // check the block size, it must be large than the mini_block_size
        if (get_size(block) < mini_block_size) {
            printf("block too small");
            return false;
        }

        // Check if prev block and next block are connected correctly with the
        // current block
        if (block_prev && block_prev != block && get_size(block_prev) > 0) {
            if (block != find_next(block_prev)) {
                printf("block not connected");
                return false;
            }
        }

        // Check coalescing: no consecutive free blocks in the heap
        if (!get_alloc(block_prev) && !get_alloc(block)) {
            printf("coalesce error");
            return false;
        }
        block_prev = block;
        block = find_next(block);
    }
    // Free blocks count
    // Check epilogue block
    block_t *epilogue = block;
    if (get_size(epilogue) != 0) {
        printf("Epilogue size is not 0");
        return false;
    }
    if (!get_alloc(epilogue)) {
        printf("Epilogue is not allocated");
        return false;
    }

    // Iterate over the seglist and check every free block
    for (int i = 0; i < segnum; ++i) {
        block = list_head[i];
        if (block) {
            do {
                // Count free blocks
                --free_counts;
                // Check free block
                if (get_alloc(block)) {
                    printf("Allocated block on free seglists");
                }
                // Check next and previous pointers consistency
                block_t *prev_block = find_prev(block);
                if (prev_block->payload.node.next != block) {
                    printf("Next and previous pointers mismatch");
                    return false;
                }
                // Check pointers lie within heap boundaries
                if (prev_block < (block_t *)mem_heap_lo() ||
                    prev_block > (block_t *)mem_heap_hi() ||
                    block->payload.node.next < (block_t *)mem_heap_lo() ||
                    block->payload.node.next > (block_t *)mem_heap_hi()) {
                    printf("Pointers lie outside of heap boundaries");
                    return false;
                }
                // Check block size falls within size range
                if ((i == 0 && !get_mini(block)) ||
                    (i > 0 && (get_mini(block) ||
                               get_size(block) < min_block_size << (i - 1) ||
                               (i < segnum - 1 &&
                                get_size(block) >= min_block_size << i)))) {
                    printf("Block size out of size range");
                    return false;
                }
                block = block->payload.node.next;
            } while (block != list_head[i]);
        }
    }

    // Check free blocks count consistency
    if (free_counts != 0) {
        printf("Heap and seglists free blocks mismatch");
        return false;
    }
    return true;
}

/**
 * @brief Perform any necessary initializations, such as allocating the initial
 * heap area and empty seglists of free blocks.
 *
 * @return False if there was a problem in performing the initialization, True
 * otherwise
 */
bool mm_init(void) {
    // Create the initial empty heap
    word_t *start = (word_t *)(mem_sbrk(2 * wsize));
    int i;

    if (start == (void *)-1) {
        return false;
    }

    start[0] =
        pack(0, false, false, false, true); // Heap prologue (block footer)
    start[1] =
        pack(0, false, false, true, true); // Heap epilogue (block header)

    // Heap starts with first "block header", currently the epilogue
    heap_start = (block_t *)&(start[1]);

    // Extend the empty heap with a free block of chunksize bytes
    if (extend_heap(chunksize) == NULL) {
        return false;
    }

    // Initialize the segrate list
    for (i = 0; i < segnum; i++) {
        list_head[i] = NULL;
    }
    return true;
}

/**
 * @brief Return a pointer to an allocated block payload of at least `size`
 * bytes.
 *
 * @param[in] size The size of the block payload to allocate on the heap
 * @return A pointer to the allocated block payload.
 */
void *malloc(size_t size) {
    dbg_requires(mm_checkheap(__LINE__));

    size_t asize;      // Adjusted block size
    size_t extendsize; // Amount to extend heap if no fit is found
    block_t *block;
    void *bp = NULL;

    // Initialize heap if it isn't initialized
    if (heap_start == NULL) {
        mm_init();
    }

    // Ignore spurious request
    if (size == 0) {
        dbg_ensures(mm_checkheap(__LINE__));
        return bp;
    }

    // Adjust block size to include overhead and to meet alignment requirements
    asize = round_up(size + wsize, dsize);

    // Search the free list for a fit
    block = find_fit(asize);

    // If no fit is found, request more memory, and then and place the block
    if (block == NULL) {
        // Always request at least chunksize
        extendsize = max(asize, chunksize);
        block = extend_heap(extendsize);
        // extend_heap returns an error
        if (block == NULL) {
            return bp;
        }
    }

    // The block should be marked as free
    dbg_assert(!get_alloc(block));
    remove_list(block);

    // Mark block as allocated
    size_t block_size = get_size(block);
    write_block(block, block_size, ifpremini(block),
                (block_size == mini_block_size), ifprealloc(block), true);

    // Try to split the block if too large
    split_block(block, asize);

    // Update mini flag after split
    block_size = get_size(block);

    // Update the status of the next block
    block_t *block_next = find_next(block);
    size_t block_next_size = get_size(block_next);
    if (block_next_size > 0) {
        write_block(block_next, extract_size(block_next->header),
                    (block_size == mini_block_size), ifmini(block_next), true,
                    get_alloc(block_next));
    } else {
        write_epilogue(block_next, (block_size == mini_block_size), true);
    }

    bp = header_to_payload(block);

    dbg_ensures(mm_checkheap(__LINE__));
    return bp;
}

/**
 * @brief Free the block pointed to by `bp`.
 *
 * @param[in] bp Pointer to the payload of the block to be freed
 * @pre `bp` was returned by an earlier call to `malloc`, `calloc`, or `realloc`
 * and has not yet been freed
 */
void free(void *bp) {
    dbg_requires(mm_checkheap(__LINE__));

    if (bp == NULL) {
        return;
    }

    block_t *block = payload_to_header(bp);
    size_t size = get_size(block);

    // The block should be marked as allocated
    dbg_assert(get_alloc(block));

    // Mark the block as free
    if (size == mini_block_size) {
        write_block(block, size, ifpremini(block), true, ifprealloc(block),
                    false);
    } else {
        write_block(block, size, ifpremini(block), false, ifprealloc(block),
                    false);
    }

    block_t *block_next = find_next(block);
    if (get_size(block_next) > 0) {
        write_block(block_next, extract_size(block_next->header),
                    ifpremini(block_next), ifmini(block_next), false,
                    get_alloc(block_next));
    } else {
        write_epilogue(block_next, ifpremini(block_next), false);
    }

    // Try to coalesce the block with its neighbors
    block = coalesce_block(block);

    dbg_ensures(mm_checkheap(__LINE__));
}

/**
 *
 * @param[in] ptr
 * @param[in] size
 * @return
 */
void *realloc(void *ptr, size_t size) {
    block_t *block = payload_to_header(ptr);
    size_t copysize;
    void *newptr;

    // If size == 0, then free block and return NULL
    if (size == 0) {
        free(ptr);
        return NULL;
    }

    // If ptr is NULL, then equivalent to malloc
    if (ptr == NULL) {
        return malloc(size);
    }

    // Otherwise, proceed with reallocation
    newptr = malloc(size);

    // If malloc fails, the original block is left untouched
    if (newptr == NULL) {
        return NULL;
    }

    // Copy the old data
    copysize = get_payload_size(block); // gets size of old payload
    if (size < copysize) {
        copysize = size;
    }
    memcpy(newptr, ptr, copysize);

    // Free the old block
    free(ptr);

    return newptr;
}

/**
 * @brief
 * @param[in] elements
 * @param[in] size
 * @return
 */
void *calloc(size_t elements, size_t size) {
    void *bp;
    size_t asize = elements * size;

    if (elements == 0) {
        return NULL;
    }
    if (asize / elements != size) {
        // Multiplication overflowed
        return NULL;
    }

    bp = malloc(asize);
    if (bp == NULL) {
        return NULL;
    }

    // Initialize all bits to 0
    memset(bp, 0, asize);

    return bp;
}
/*
 *****************************************************************************
 * Do not delete the following super-secret(tm) lines!                       *
 *                                                                           *
 * 53 6f 20 79 6f 75 27 72 65 20 74 72 79 69 6e 67 20 74 6f 20               *
 *                                                                           *
 * 66 69 67 75 72 65 20 6f 75 74 20 77 68 61 74 20 74 68 65 20               *
 * 68 65 78 61 64 65 63 69 6d 61 6c 20 64 69 67 69 74 73 20 64               *
 * 6f 2e 2e 2e 20 68 61 68 61 68 61 21 20 41 53 43 49 49 20 69               *
 *                                                                           *
 * 73 6e 27 74 20 74 68 65 20 72 69 67 68 74 20 65 6e 63 6f 64               *
 * 69 6e 67 21 20 4e 69 63 65 20 74 72 79 2c 20 74 68 6f 75 67               *
 * 68 21 20 2d 44 72 2e 20 45 76 69 6c 0a c5 7c fc 80 6e 57 0a               *
 *                                                                           *
 *****************************************************************************
 */
