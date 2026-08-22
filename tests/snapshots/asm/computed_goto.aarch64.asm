
computed_goto.aarch64:	file format elf64-littleaarch64

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

<direct>:
               	str	x0, [sp, #-0x10]!
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	w0, [x29, #0x10]
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	adr	x0, <addr>
               	stur	x0, [x29, #-0x8]
               	b	<addr>
               	adr	x0, <addr>
               	stur	x0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	stur	x0, [x29, #-0x8]
               	br	x0
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<interp>:
               	str	x0, [sp, #-0x10]!
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	stur	x0, [x29, #0x10]
               	sub	x0, x29, #0x18
               	mov	x1, #0x0                // =0
               	adr	x2, <addr>
               	str	x2, [x0]
               	adr	x2, <addr>
               	str	x2, [x0, #0x8]
               	adr	x2, <addr>
               	str	x2, [x0, #0x10]
               	stur	w1, [x29, #-0x20]
               	stur	w1, [x29, #-0x28]
               	ldur	x2, [x29, #0x10]
               	sxtw	x1, w1
               	add	x3, x1, #0x1
               	stur	w3, [x29, #-0x28]
               	ldrsw	x1, [x2, x1, lsl #2]
               	ldr	x1, [x0, x1, lsl #3]
               	br	x1
               	ldursw	x4, [x29, #-0x20]
               	ldur	x1, [x29, #0x10]
               	ldursw	x2, [x29, #-0x28]
               	add	x3, x2, #0x1
               	stur	w3, [x29, #-0x28]
               	ldrsw	x2, [x1, x2, lsl #2]
               	add	x2, x4, x2
               	stur	w2, [x29, #-0x20]
               	sxtw	x2, w3
               	add	x3, x2, #0x1
               	stur	w3, [x29, #-0x28]
               	ldrsw	x1, [x1, x2, lsl #2]
               	ldr	x1, [x0, x1, lsl #3]
               	br	x1
               	ldursw	x4, [x29, #-0x20]
               	ldur	x1, [x29, #0x10]
               	ldursw	x2, [x29, #-0x28]
               	add	x3, x2, #0x1
               	stur	w3, [x29, #-0x28]
               	ldrsw	x2, [x1, x2, lsl #2]
               	sub	x2, x4, x2
               	stur	w2, [x29, #-0x20]
               	sxtw	x2, w3
               	add	x3, x2, #0x1
               	stur	w3, [x29, #-0x28]
               	ldrsw	x1, [x1, x2, lsl #2]
               	ldr	x1, [x0, x1, lsl #3]
               	br	x1
               	ldursw	x0, [x29, #-0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<loop_to>:
               	str	x0, [sp, #-0x10]!
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	stur	w0, [x29, #0x10]
               	sub	x0, x29, #0x10
               	mov	x2, #0x0                // =0
               	adr	x1, <addr>
               	str	x1, [x0]
               	adr	x1, <addr>
               	str	x1, [x0, #0x8]
               	stur	w2, [x29, #-0x18]
               	ldursw	x1, [x29, #-0x18]
               	add	x1, x1, #0x1
               	stur	w1, [x29, #-0x18]
               	sxtw	x1, w1
               	ldursw	x3, [x29, #0x10]
               	cmp	x1, x3
               	b.ge	<addr>
               	b	<addr>
               	ldursw	x0, [x29, #-0x18]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret
               	stur	x2, [x29, #-0x20]
               	b	<addr>
               	mov	x1, #0x1                // =1
               	stur	x1, [x29, #-0x20]
               	ldur	x1, [x29, #-0x20]
               	ldr	x1, [x0, x1, lsl #3]
               	br	x1

<main>:
               	stp	x20, x21, [sp, #-0x50]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	mov	x20, #0x0               // =0
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x21, #0x1               // =1
               	mov	x0, x21
               	bl	<addr>
               	cmp	x0, #0x14
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	sub	x0, x29, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldrb	w10, [x1, #0x18]
               	strb	w10, [x0, #0x18]
               	ldrb	w10, [x1, #0x19]
               	strb	w10, [x0, #0x19]
               	ldrb	w10, [x1, #0x1a]
               	strb	w10, [x0, #0x1a]
               	ldrb	w10, [x1, #0x1b]
               	strb	w10, [x0, #0x1b]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	bl	<addr>
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x22, #0x5               // =5
               	mov	x0, x22
               	bl	<addr>
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x0, x21
               	bl	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, x22
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
