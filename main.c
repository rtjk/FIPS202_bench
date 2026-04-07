#include <assert.h>
#include <stdalign.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#include "cpucycles.h"
#include "test_shake.h"

#define SEED    42
#define TESTS   1000
#define NMAX    10000

/* fill an array of n bytes with random values */
void u8_arr_rand(uint8_t *arr, size_t n) {
    for (size_t i = 0; i < n; i++) arr[i] = rand() % 256;
}

int main() {

    srand(SEED);

    setvbuf(stdout, NULL, _IONBF, 0);

    uint64_t count_1, count_2, avg;
    uint64_t sum = 0;

    uint8_t checksum = 0;

    for(uint64_t test = 0; test < TESTS; test++) {

        uint64_t inlen = (rand() % NMAX) + 1;
        uint64_t outlen = (rand() % NMAX) + 1;
        uint8_t in[inlen];
        uint8_t out[outlen];

        memset(out, 0, outlen);

        u8_arr_rand(in, inlen);

        count_1 = cpucycles();
        TEST_SHAKE128(in, inlen, out, outlen);
        // TEST_SHAKE256(in, inlen, out, outlen);
        count_2 = cpucycles();

        for(uint64_t i = 0; i < outlen; i++) {
            checksum ^= out[i];
        }

        sum += count_2 - count_1;
    }

    avg = sum / TESTS;
    sum = 0;

    printf("[%d] %lu \t", checksum, avg);

}
