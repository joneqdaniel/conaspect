# conaspect
calculate linux kernel console rows and columns for given resolution

## Build
```sh
CFLAGS="-march=<your architecture> -mfpmath=<your SIMD>" PREFIX="your destination prefix" make clean install
```
## Usage
```sh
Usage: conaspect <width> <height> [col scale] [row scale]...
Calculate aspect ratio and kernel console parameters.

  <width>  - integer screen width
  <height> - integer screen height
  [col scale]  - optional floating point column multiplier
  [row scale]  - optional floating point row multiplier

Examples:
conaspect 1920 1080
conaspect 1920 1080 2.0
conaspect 1920 1080 1.0 2.0
```
## Output
```sh
MODE: 1920x1080 16:9 CONSOLE: 240x67 SCALE: 1.000000x1.000000
MODE: 1920x1080 16:9 CONSOLE: 480x67 SCALE: 2.000000x1.000000
MODE: 1920x1080 16:9 CONSOLE: 240x134 SCALE: 1.000000x2.000000
```
