
unions_basic.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0x2a               // =42
               	stur	w0, [x29, #-0x8]
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x8]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	stur	x1, [x29, #-0x8]
               	fmov	d0, #3.50000000
               	stur	d0, [x29, #-0x8]
               	ldur	d0, [x29, #-0x8]
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x8]
               	fcmp	d0, d1
               	b.pl	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	d0, [x29, #-0x8]
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x10]
               	fcmp	d0, d1
               	b.le	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
