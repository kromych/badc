
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
               	sub	x0, x29, #0x8
               	mov	x1, #0x2a               // =42
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	str	w1, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x2, [x0]
               	mov	x2, #0x400c000000000000 // =4615063718147915776
               	fmov	d16, x2
               	str	d16, [x0]
               	ldr	d0, [x0]
               	mov	x2, #0x3333             // =13107
               	movk	x2, #0x3333, lsl #16
               	movk	x2, #0x3333, lsl #32
               	movk	x2, #0x400b, lsl #48
               	fmov	d17, x2
               	fcmp	d0, d17
               	b.pl	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	d0, [x0]
               	mov	x0, #0xcccd             // =52429
               	movk	x0, #0xcccc, lsl #16
               	movk	x0, #0xcccc, lsl #32
               	movk	x0, #0x400c, lsl #48
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.le	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
