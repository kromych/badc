
int128_overflow_builtin.aarch64:	file format elf64-littleaarch64

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

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0x7b               // =123
               	stur	w0, [x29, #-0x8]
               	ldur	w0, [x29, #-0x8]
               	cmp	w0, #0x7b
               	b.eq	<addr>
               	mov	x0, #0x38               // =56
               	cbz	x0, <addr>
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x8]
               	mov	x1, #-0x2               // =-2
               	stur	w1, [x29, #-0x8]
               	stur	w0, [x29, #-0x8]
               	mov	x1, #-0x1               // =-1
               	stur	x1, [x29, #-0x8]
               	mov	x1, #-0xf               // =-15
               	stur	x1, [x29, #-0x8]
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	stur	x1, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
