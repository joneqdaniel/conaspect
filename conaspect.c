#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <sys/param.h>

#define INLINE __attribute__((nothrow,always_inline,flatten,const)) inline

#ifdef __x86_64__
#define REGPARM __attribute__((sseregparm))
#elif defined(__i386__)
#define REGPARM __attribute__((regparm(8)))
#else
#define REGPARM
#endif

#ifdef __clang__
#define vec(t,n) typeof(t __attribute__((ext_vector_type(n), __may_alias__)))
typedef vec(int32_t,2) vec2i;
typedef vec(float,2) vec2f;
#define round_to_vec2i(a) __builtin_convertvector(a,vec2i)
#elif __GNUC__
#define vec(t,n) typeof(t __attribute__((vector_size(sizeof(t) * n), __may_alias__)))
typedef vec(int32_t,2) vec2i;
typedef vec(float,2) vec2f;
#define round_to_vec2i(a) __builtin_convertvector(a,vec2i)
#elif defined(_MSC_VER) && (defined(__x86_64__) || defined(__i386__))
#include <intrin.h>
typedef __m64 vec2i;
typedef __m128 vec2f;
#define round_to_vec2i(a) _mm_cvtps_epi32(a)
#else
#warning "Your compiler doens't support SIMD vector extensions!"
#endif


INLINE REGPARM static void usage(int argc, char** argv)
{
	fprintf(stderr, "Usage: %s <width> <height> [scale]...\nCalculate aspect ratio and kernel console parameters.\n\n  <width>  - integer screen width\n  <height> - integer screen height\n  [col scale]  - optional floating point column multiplier\n  [row scale]  - optional floating point row multiplier\n\nExamples:\n%s 1920 1080\n%s 1920 1080 2.0\n%s 1920 1080 1.0 2.0\n\n", argv[0], argv[0], argv[0], argv[0]);
}
INLINE REGPARM static int gcd(int x, int y) { return y == 0 ? MAX(x, -x) : gcd(y, x % y); }
INLINE REGPARM static bool conaspect(int argc, char** argv)
{
	if(argc > 2)
	{
		vec2i res     = { atoi(argv[1]), atoi(argv[2]) };
		vec2i ratio   = {  gcd( res[0] , res[1])       };
		vec2f scale   = { argc > 3 ? strtof(argv[3], NULL) : 1.0f,
		                  argc > 4 ? strtof(argv[4], NULL) : 1.0f  };
		vec2i console = round_to_vec2i(((vec2f){
		                (float)(res[0] >> 3),
				(float)(res[1] >> 4) 
				} * scale));
		vec2i aspect  = res / ratio;

		fprintf(stdout, "MODE: %dx%d %d:%d CONSOLE: %dx%d SCALE: %fx%f\n",
		                res[0], res[1], aspect[0], aspect[1],
				console[0], console[1], scale[0], scale[1]);
		return true;
	}
	usage(argc, argv);
	return false;
}

int main(int argc, char** argv)
{
	exit(conaspect(argc,argv) ? EXIT_SUCCESS : EXIT_FAILURE);
}
