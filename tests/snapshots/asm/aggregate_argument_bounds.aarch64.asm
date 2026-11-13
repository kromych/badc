
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
               	stp	x20, x21, [sp, #-0x50]!
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
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
               	cmn	x21, #0x1
               	b.eq	<addr>
               	add	x0, x21, x20
               	mov	x2, #0x0                // =0
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	add	x4, x21, x20
               	cbz	x4, <addr>
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldr	w16, [x1, #0x8]
               	str	w16, [x0, #0x8]
               	sub	x5, x4, #0xb
               	sub	x6, x4, #0xc
               	ldr	x16, [x0]
               	str	x16, [x6]
               	ldr	w16, [x0, #0x8]
               	str	w16, [x6, #0x8]
               	ldurb	w1, [x4, #-0x3]
               	ldurb	w0, [x4, #-0x1]
               	add	x1, x1, x0
               	cmp	w1, #0x16
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	ldurb	w1, [x4, #-0x5]
               	add	x1, x1, x0
               	cmp	w1, #0x14
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	ldursh	x1, [x4, #-0x6]
               	ldursh	x2, [x4, #-0x2]
               	add	x1, x1, x2
               	mov	x17, #0x1412            // =5138
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	ldurb	w1, [x4, #-0x7]
               	add	x0, x1, x0
               	cmp	w0, #0x12
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	ldrb	w0, [x5]
               	ldrb	w1, [x5, #0xa]
               	add	x0, x0, x1
               	cmp	w0, #0xe
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	ldurb	w2, [x4, #-0x1]
               	cmp	w2, #0xc
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x0, #0x1                // =1
               	ldurh	w7, [x4, #-0x3]
               	orr	x1, x7, x2, lsl #16
               	ldur	w3, [x4, #-0x5]
               	orr	x2, x3, x2, lsl #32
               	ldur	w3, [x4, #-0x6]
               	ldurh	w8, [x4, #-0x2]
               	orr	x3, x3, x8, lsl #32
               	ldur	w8, [x4, #-0x7]
               	orr	x7, x8, x7, lsl #32
               	ldurb	w4, [x4, #-0x1]
               	orr	x4, x7, x4, lsl #48
               	str	x6, [sp, #0x18]
               	ldrh	w6, [x5, #0x8]
               	ldrb	w16, [x5, #0xa]
               	orr	x6, x6, x16, lsl #16
               	ldr	x5, [x5]
               	bl	<addr>
               	ldr	x6, [sp, #0x18]
               	cmp	w0, #0xc3c
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x0, #0x3fc00000         // =1069547520
               	movk	x0, #0x4020, lsl #48
               	str	x0, [x6]
               	mov	x0, #0x40600000         // =1080033280
               	str	w0, [x6, #0x8]
               	ldr	s0, [x6]
               	ldr	s1, [x6, #0x8]
               	fadd	s0, s0, s1
               	fmov	s1, #5.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	stur	w0, [x29, #-0x18]
               	ldur	s0, [x29, #-0x18]
               	fmov	s1, #3.50000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x20, x21, [sp], #0x50
               	ret
