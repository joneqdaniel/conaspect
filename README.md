# conaspect
calculate linux kernel console rows and columns for given resolution

## Build
```sh
CFLAGS="-march=<your architecture> -mfpmath=<your SIMD>" PREFIX="your destination prefix" make clean install
``
## Usage
```sh
Usage: conaspect <width> <height> [scale]...
Calculate aspect ratio and kernel console parameters.

  <width>  - integer screen width
  <height> - integer screen height
  [scale]  - optional floating point row multiplier

Examples:
./conaspect 1024 768
./conaspect 1024 768 2.0
```
