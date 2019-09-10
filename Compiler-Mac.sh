#!/bin/bash

# Requires MacOS Sierra or later with XCode command line tools

set +v

# Compile
for f in $PWD/*.c; do
  echo "gcc" -ffreestanding -march=skylake -mavx2 -O3 -fpie -fomit-frame-pointer -fno-common -fno-zero-initialized-in-bss -fno-stack-protector -m64 -mno-red-zone -g3 -Wall -Wextra -Wdouble-promotion -Wpedantic -fmessage-length=0 -ffunction-sections -c -MMD -MP -MF"${f%.*}.d" -MT"${f%.*}.o" -o "${f%.*}.o" "${f%.*}.c"
  "gcc" -ffreestanding -march=skylake -mavx2 -O3 -fpie -fomit-frame-pointer -fno-common -fno-zero-initialized-in-bss -fno-stack-protector -m64 -mno-red-zone -g3 -Wall -Wextra -Wdouble-promotion -Wpedantic -fmessage-length=0 -ffunction-sections -c -MMD -MP -MF"${f%.*}.d" -MT"${f%.*}.o" -o "${f%.*}.o" "${f%.*}.c"
done

# Link
"gcc" -nostdlib -Wl,-dead_strip -Wl,-pie -Wl,-static -Wl,-map,output.map -Wl,-pagezero_size,0x0 -o "Output.mach64" memmove.o memcpy.o memset.o memcmp.o #(Your file with main).o
