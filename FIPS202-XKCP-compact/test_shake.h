#include "SimpleFIPS202.h"

#define TEST_SHAKE128(in, inlen, out, outlen) SHAKE128(out, outlen, in, inlen)
#define TEST_SHAKE256(in, inlen, out, outlen) SHAKE256(out, outlen, in, inlen)