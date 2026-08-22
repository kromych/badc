
inline_volatile_callee.aarch64:	file format elf64-littleaarch64

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

<local_pair>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0x3                // =3
               	stur	w0, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x8]
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	stur	w0, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x8]
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x8]
               	mov	x0, #0x1                // =1
               	stur	w0, [x29, #-0x8]
               	bl	<addr>
               	add	x0, x0, #0x3
               	sub	x0, x0, #0x7
               	sxtw	x0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
