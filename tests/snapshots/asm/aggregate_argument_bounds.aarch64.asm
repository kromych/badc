
aggregate_argument_bounds.aarch64:	file format elf64-littleaarch64

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

<page_end>:
               	stp	x20, x21, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x0, #0x1e               // =30
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #0x0                // =0
               	lsl	x1, x20, #1
               	mov	x2, #0x3                // =3
               	mov	x3, #0x22               // =34
               	mov	x4, #-0x1               // =-1
               	mov	x5, x0
               	bl	<addr>
               	mov	x21, x0
               	mov	x17, #-0x1              // =-1
               	cmp	x21, x17
               	b.eq	<addr>
               	add	x0, x21, x20
               	mov	x2, #0x0                // =0
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	add	x0, x21, x20
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret

<back7>:
               	ldrb	w1, [x0]
               	ldrb	w2, [x0, #0x1]
               	lsl	x2, x2, #8
               	orr	x1, x1, x2
               	ldrb	w2, [x0, #0x2]
               	lsl	x2, x2, #16
               	orr	x1, x1, x2
               	ldrb	w2, [x0, #0x3]
               	lsl	x2, x2, #24
               	orr	x1, x1, x2
               	ldrb	w2, [x0, #0x4]
               	lsl	x2, x2, #32
               	orr	x1, x1, x2
               	ldrb	w2, [x0, #0x5]
               	lsl	x2, x2, #40
               	orr	x1, x1, x2
               	ldrb	w0, [x0, #0x6]
               	lsl	x0, x0, #48
               	orr	x0, x1, x0
               	ret

<backf3>:
               	ldr	s0, [x0]
               	ldr	s1, [x0, #0x4]
               	ldr	s2, [x0, #0x8]
               	ret

<va>:
               	sub	sp, sp, #0xc0
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	str	x2, [sp, #0x10]
               	str	x3, [sp, #0x18]
               	str	x4, [sp, #0x20]
               	str	x5, [sp, #0x28]
               	str	x6, [sp, #0x30]
               	str	x7, [sp, #0x38]
               	str	q0, [sp, #0x40]
               	str	q1, [sp, #0x50]
               	str	q2, [sp, #0x60]
               	str	q3, [sp, #0x70]
               	str	q4, [sp, #0x80]
               	str	q5, [sp, #0x90]
               	str	q6, [sp, #0xa0]
               	str	q7, [sp, #0xb0]
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x0, x29, #0x20
               	add	x1, x29, #0x10
               	mov	x16, x0
               	add	x17, x29, #0xd0
               	str	x17, [x16]
               	add	x17, x29, #0x50
               	str	x17, [x16, #0x8]
               	add	x17, x29, #0xd0
               	str	x17, [x16, #0x10]
               	mov	x17, #-0x38             // =-56
               	str	w17, [x16, #0x18]
               	mov	x17, #-0x80             // =-128
               	str	w17, [x16, #0x1c]
               	sub	x0, x29, #0x20
               	mov	x17, x0
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x8]
               	add	x9, x9, x16
               	add	x16, x16, #0x8
               	str	w16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x0, x16
               	ldrb	w0, [x0, #0x2]
               	sub	x1, x29, #0x20
               	mov	x17, x1
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x8]
               	add	x9, x9, x16
               	add	x16, x16, #0x8
               	str	w16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x1, x16
               	ldrb	w1, [x1, #0x4]
               	sub	x2, x29, #0x20
               	mov	x17, x2
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x8]
               	add	x9, x9, x16
               	add	x16, x16, #0x8
               	str	w16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x2, x16
               	ldrh	w2, [x2, #0x4]
               	sub	x3, x29, #0x20
               	mov	x17, x3
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x8]
               	add	x9, x9, x16
               	add	x16, x16, #0x8
               	str	w16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x3, x16
               	ldrb	w3, [x3, #0x6]
               	sub	x4, x29, #0x20
               	mov	x17, x4
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x8]
               	add	x9, x9, x16
               	add	x16, x16, #0x10
               	str	w16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x10
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x4, x16
               	ldrb	w4, [x4, #0xa]
               	sub	x5, x29, #0x20
               	ldrsw	x5, [x29, #0x10]
               	add	x0, x5, x0
               	add	x0, x0, x1
               	sxth	x1, w2
               	add	x0, x0, x1
               	add	x0, x0, x3
               	add	x0, x0, x4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xc0
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x70]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x29, x30, [sp, #0x60]
               	add	x29, sp, #0x60
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	sub	x1, x29, #0x30
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x16, [x2]
               	str	x16, [x1]
               	ldr	w16, [x2, #0x8]
               	str	w16, [x1, #0x8]
               	sub	x22, x0, #0x3
               	sub	x23, x0, #0x5
               	sub	x24, x0, #0x6
               	sub	x20, x0, #0x7
               	sub	x25, x0, #0xb
               	sub	x21, x0, #0xc
               	mov	x2, #0xc                // =12
               	mov	x0, x21
               	bl	<addr>
               	ldrb	w0, [x22]
               	ldrb	w1, [x22, #0x2]
               	add	x0, x0, x1
               	cmp	w0, #0x16
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	ldrb	w0, [x23]
               	ldrb	w1, [x23, #0x4]
               	add	x0, x0, x1
               	cmp	w0, #0x14
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	ldrsh	x0, [x24]
               	ldrsh	x1, [x24, #0x4]
               	add	x0, x0, x1
               	mov	x17, #0x1412            // =5138
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	ldrb	w0, [x20]
               	ldrb	w1, [x20, #0x6]
               	add	x0, x0, x1
               	cmp	w0, #0x12
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	ldrb	w0, [x25]
               	ldrb	w1, [x25, #0xa]
               	add	x0, x0, x1
               	cmp	w0, #0xe
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, x20
               	bl	<addr>
               	stur	w0, [x29, #-0x8]
               	lsr	x2, x0, #32
               	sub	x1, x29, #0x8
               	strh	w2, [x1, #0x4]
               	lsr	x0, x0, #48
               	strb	w0, [x1, #0x6]
               	ldrb	w0, [x1, #0x6]
               	eor	x0, x0, #0xc
               	cbz	w0, <addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, #0x1                // =1
               	ldrh	w1, [x22]
               	ldrb	w2, [x22, #0x2]
               	lsl	x2, x2, #16
               	orr	x1, x1, x2
               	ldr	w2, [x23]
               	ldrb	w3, [x23, #0x4]
               	lsl	x3, x3, #32
               	orr	x2, x2, x3
               	ldr	w3, [x24]
               	ldrh	w4, [x24, #0x4]
               	lsl	x4, x4, #32
               	orr	x3, x3, x4
               	ldr	w4, [x20]
               	ldrh	w5, [x20, #0x4]
               	lsl	x5, x5, #32
               	orr	x4, x4, x5
               	ldrb	w5, [x20, #0x6]
               	lsl	x5, x5, #48
               	orr	x4, x4, x5
               	mov	x5, x25
               	ldrh	w6, [x5, #0x8]
               	ldrb	w16, [x5, #0xa]
               	lsl	x16, x16, #16
               	orr	x6, x6, x16
               	ldr	x5, [x5]
               	bl	<addr>
               	cmp	w0, #0xc3c
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	sub	x1, x29, #0x20
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldr	w16, [x0, #0x8]
               	str	w16, [x1, #0x8]
               	mov	x2, #0xc                // =12
               	mov	x0, x21
               	bl	<addr>
               	ldr	s0, [x21]
               	ldr	s1, [x21, #0x8]
               	fadd	s0, s0, s1
               	fmov	s1, #5.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, x21
               	bl	<addr>
               	stur	s0, [x29, #-0x10]
               	sub	x0, x29, #0x10
               	str	s1, [x0, #0x4]
               	str	s2, [x0, #0x8]
               	ldr	s0, [x0, #0x8]
               	fmov	s1, #3.50000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
