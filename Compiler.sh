#!/bin/bash

# Requires GCC 8 or later

set +v

GCC_FOLDER_NAME=/usr
BINUTILS_FOLDER_NAME=/usr

export PATH=$BINUTILS_FOLDER_NAME/bin:$PATH

# Compile
for f in $PWD/*.c; do
  echo "$GCC_FOLDER_NAME/bin/gcc" -ffreestanding -march=skylake -mavx2 -O3 -fpie -fomit-frame-pointer -fno-common -fno-zero-initialized-in-bss -fno-exceptions -fno-unwind-tables -fno-asynchronous-unwind-tables -fno-stack-protector -fno-stack-check -fno-strict-aliasing -fno-merge-all-constants -fno-merge-constants -mno-stack-arg-probe -m64 -mno-red-zone -maccumulate-outgoing-args --std=gnu11 -g3 -Wall -Wextra -Wdouble-promotion -Wpedantic -fmessage-length=0 -ffunction-sections -c -MMD -MP -Wa,-adghlmns="${f%.*}.out" -MF"${f%.*}.d" -MT"${f%.*}.o" -o "${f%.*}.o" "${f%.*}.c"
  "$GCC_FOLDER_NAME/bin/gcc" -ffreestanding -march=skylake -mavx2 -O3 -fpie -fomit-frame-pointer -fno-common -fno-zero-initialized-in-bss -fno-exceptions -fno-unwind-tables -fno-asynchronous-unwind-tables -fno-stack-protector -fno-stack-check -fno-strict-aliasing -fno-merge-all-constants -fno-merge-constants -mno-stack-arg-probe -m64 -mno-red-zone -maccumulate-outgoing-args --std=gnu11 -g3 -Wall -Wextra -Wdouble-promotion -Wpedantic -fmessage-length=0 -ffunction-sections -c -MMD -MP -Wa,-adghlmns="${f%.*}.out" -MF"${f%.*}.d" -MT"${f%.*}.o" -o "${f%.*}.o" "${f%.*}.c"
done

# Link
"$GCC_FOLDER_NAME/bin/gcc" -march=skylake -mavx2 -static-pie -nostdlib -s -Wl,--warn-common -Wl,--no-undefined -Wl,-z,text -Wl,-z,norelro -Wl,-z,max-page-size=0x1000 -Wl,-Map=output.map -Wl,--gc-sections -o "Output.elf" memmove.o memcpy.o memset.o memcmp.o #(Your file with main).o
