
inline_keyword_uncaps.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	add	x0, x0, #0x1
               	add	x0, x0, #0x2
               	add	x0, x0, #0x3
               	add	x0, x0, #0x4
               	add	x0, x0, #0x5
               	add	x0, x0, #0x6
               	add	x0, x0, #0x7
               	add	x0, x0, #0x8
               	add	x0, x0, #0x9
               	add	x0, x0, #0xa
               	add	x0, x0, #0xb
               	add	x0, x0, #0xc
               	add	x0, x0, #0xd
               	add	x0, x0, #0xe
               	add	x0, x0, #0xf
               	add	x0, x0, #0x10
               	ret

<main>:
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	ret
