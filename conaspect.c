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
#elif __GNUC__
#define vec(t,n) typeof(t __attribute__((vector_size(sizeof(t) * n), __may_alias__)))
typedef vec(int32_t,2) vec2i;
typedef vec(float,2) vec2f;
#elif _MSC_VER
#include <intrin.h>
typedef __m64 vec2i;
typedef __m128 vec2f;
#else
#warning "Your compiler doens't support SIMD vector extensions!"
#endif


INLINE REGPARM static int gcd(int x, int y) { return y == 0 ? MAX(x, -x) : gcd(y, x % y); }

int main(int argc, char** argv)
{
	if(argc > 2)
	{
		vec2i res     = { atoi(argv[1])      , atoi(argv[2])       };
		vec2i ratio   = { gcd(res[0], res[1]), gcd(res[0], res[1]) }; 
		vec2i aspect  = { res[0] / ratio[0]  , res[1] / ratio[1]   };
		vec2i console = { (res[0] >> 3)      , (res[1] >> 4)       };
		vec2f scale   = { argc > 3 ? strtof(argv[3], NULL) : 1.0f,
		                  argc > 4 ? strtof(argv[4], NULL) : 1.0f  };

		console = __builtin_convertvector((vec(float,2)){ (float)console[0], (float)console[1] } * scale, vec2i);

		fprintf(stdout, "MODE: %dx%d %d:%d CONSOLE: %dx%d SCALE: %fx%f\n",
		                res[0], res[1],
				aspect[0], aspect[1],
				console[0], console[1], scale[0], scale[1]);

		exit(EXIT_SUCCESS);
	}

	fprintf(stderr, "Usage: %s <width> <height> [scale]...\nCalculate aspect ratio and kernel console parameters.\n\n  <width>  - integer screen width\n  <height> - integer screen height\n  [scale]  - optional floating point row multiplier\n\nExamples:\n%s 1024 768\n%s 1024 768 2.0\n\n", argv[0], argv[0], argv[0]);

	exit(EXIT_FAILURE);
}
