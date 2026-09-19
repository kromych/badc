
scalar_compound_literal_lvalue.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0x5                // =5
               	stur	w0, [x29, #-0x8]
               	sub	x1, x29, #0x8
               	ldrsw	x2, [x1]
               	cmp	w2, #0x5
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0xa                // =10
               	str	w2, [x1]
               	mov	x2, #0x9                // =9
               	stur	w2, [x29, #-0x8]
               	ldrsw	x2, [x1]
               	cmp	w2, #0x9
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d0, #2.50000000
               	stur	d0, [x29, #-0x8]
               	ldr	d1, [x1]
               	fcmp	d1, d0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x41               // =65
               	sturb	w2, [x29, #-0x8]
               	ldrb	w2, [x1]
               	mov	x17, #0x41              // =65
               	eor	x2, x2, x17
               	cbz	w2, <addr>
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	stur	w0, [x29, #-0x8]
               	ldrsw	x2, [x1]
               	cmp	w2, #0x7
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x2a               // =42
               	stur	w2, [x29, #-0x8]
               	ldrsw	x1, [x1]
               	cmp	w1, #0x2a
               	b.eq	<addr>
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldrb	w10, [x1, #0x8]
               	strb	w10, [x0, #0x8]
               	ldrb	w10, [x1, #0x9]
               	strb	w10, [x0, #0x9]
               	ldrb	w10, [x1, #0xa]
               	strb	w10, [x0, #0xa]
               	ldrb	w10, [x1, #0xb]
               	strb	w10, [x0, #0xb]
               	ldr	x10, [sp], #0x10
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
