#include "fips202.h"

#define TEST_SHAKE128(in, inlen, out, outlen) shake128(out, outlen, in, inlen)
#define TEST_SHAKE256(in, inlen, out, outlen) shake256(out, outlen, in, inlen)