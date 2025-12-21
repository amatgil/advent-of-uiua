#!/bin/sh

set -e

js="elm.js"
min="elm.min.js"

if [ "$#" -eq 0 ]; then echo "You forgot the args; try './optimize.sh src/Main.elm'"; exit 1; fi

echo "Compiling.."
elm make --optimize --output="$js" "$@"
echo "Compiled!"

echo "Minimizing.."
uglifyjs "$js" --compress 'pure_funcs=[F2,F3,F4,F5,F6,F7,F8,F9,A2,A3,A4,A5,A6,A7,A8,A9],pure_getters,keep_fargs=false,unsafe_comps,unsafe' | uglifyjs --mangle --output "$min"
echo "Minimized"

echo "Compiled size:$(wc $js -c) bytes  ($js)"
echo "Minified size:$(wc $min -c) bytes  ($min)"
echo "Gzipped size: $(gzip $min -c | wc -c) bytes"

mv "$min" "$js"
echo "Final result has been moved to: ($js)"
