
constfold_or_dispatch_inline.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<c0>:
               	add	x0, x0, #0x1
               	lsl	x0, x0, #1
               	add	x0, x0, #0x0
               	sxtw	x0, w0
               	ret

<c1>:
               	add	x0, x0, #0x2
               	lsl	x0, x0, #1
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	ret

<c2>:
               	add	x0, x0, #0x1
               	lsl	x0, x0, #1
               	add	x0, x0, #0x2
               	sxtw	x0, w0
               	ret

<c3>:
               	add	x0, x0, #0x4
               	lsl	x0, x0, #1
               	add	x0, x0, #0x3
               	sxtw	x0, w0
               	ret

<main>:
               	mov	x0, #0x0                // =0
               	ret
