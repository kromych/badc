
stack_protector_canary.aarch64:	file format elf64-littleaarch64

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

<fill>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	cmp	x1, #0x0
               	b.ls	<addr>
               	and	x2, x2, #0xff
               	mov	x16, x2
               	mov	x2, x1
               	mov	x1, x16
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret

<aggregate>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	adrp	x16, <page>
               	ldr	x16, [x16, <lo12>]
               	ldr	x16, [x16]
               	stur	x16, [x29, #-0x8]
               	mov	x16, #0x0               // =0
               	mov	x1, #0x5                // =5
               	sub	x0, x29, #0x20
               	str	w1, [x0]
               	add	x0, x0, #0x4
               	mov	x2, #0x8                // =8
               	bl	<addr>
               	sub	x0, x29, #0x20
               	ldr	w1, [x0]
               	ldrb	w0, [x0, #0xb]
               	add	x0, x1, x0
               	adrp	x16, <page>
               	ldr	x16, [x16, <lo12>]
               	ldr	x16, [x16]
               	ldur	x17, [x29, #-0x8]
               	cmp	x16, x17
               	b.eq	<addr>
               	bl	<addr>
               	mov	x16, #0x0               // =0
               	mov	x17, #0x0               // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<vla>:
               	str	x20, [sp, #-0x40]!
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	adrp	x16, <page>
               	ldr	x16, [x16, <lo12>]
               	ldr	x16, [x16]
               	stur	x16, [x29, #-0x8]
               	mov	x16, #0x0               // =0
               	mov	x1, #0x9                // =9
               	add	x17, x1, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x20, sp
               	sub	x20, x20, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x20
               	mov	x2, #0x9                // =9
               	mov	x0, x20
               	bl	<addr>
               	ldrb	w0, [x20, #0x8]
               	adrp	x16, <page>
               	ldr	x16, [x16, <lo12>]
               	ldr	x16, [x16]
               	ldur	x17, [x29, #-0x8]
               	cmp	x16, x17
               	b.eq	<addr>
               	bl	<addr>
               	mov	x16, #0x0               // =0
               	mov	x17, #0x0               // =0
               	sub	sp, x29, #0x30
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret

<over_aligned>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	adrp	x16, <page>
               	ldr	x16, [x16, <lo12>]
               	ldr	x16, [x16]
               	stur	x16, [x29, #-0x8]
               	mov	x16, #0x0               // =0
               	sub	sp, sp, #0x40
               	mov	x16, sp
               	and	sp, x16, #0xffffffffffffffe0
               	mov	x0, sp
               	mov	x1, #0x40               // =64
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	mov	x0, sp
               	ldrb	w0, [x0, #0x3f]
               	adrp	x16, <page>
               	ldr	x16, [x16, <lo12>]
               	ldr	x16, [x16]
               	ldur	x17, [x29, #-0x8]
               	cmp	x16, x17
               	b.eq	<addr>
               	bl	<addr>
               	mov	x16, #0x0               // =0
               	mov	x17, #0x0               // =0
               	sub	sp, x29, #0x10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<variadic>:
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
               	sub	sp, sp, #0x50
               	adrp	x16, <page>
               	ldr	x16, [x16, <lo12>]
               	ldr	x16, [x16]
               	stur	x16, [x29, #-0x8]
               	mov	x16, #0x0               // =0
               	sub	x0, x29, #0x48
               	mov	x1, #0x18               // =24
               	ldrsw	x2, [x29, #0x10]
               	and	x2, x2, #0xff
               	bl	<addr>
               	sub	x2, x29, #0x30
               	add	x0, x29, #0x10
               	mov	x16, x2
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
               	mov	x0, #0x0                // =0
               	mov	x1, #0x0                // =0
               	ldrsw	x3, [x29, #0x10]
               	cmp	w0, w3
               	b.ge	<addr>
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
               	mov	x3, x16
               	ldrsw	x3, [x3]
               	add	x1, x1, x3
               	add	x0, x0, #0x1
               	ldrsw	x3, [x29, #0x10]
               	cmp	w0, w3
               	b.lt	<addr>
               	sub	x0, x29, #0x30
               	ldurb	w0, [x29, #-0x48]
               	add	x0, x1, x0
               	adrp	x16, <page>
               	ldr	x16, [x16, <lo12>]
               	ldr	x16, [x16]
               	ldur	x17, [x29, #-0x8]
               	cmp	x16, x17
               	b.eq	<addr>
               	bl	<addr>
               	mov	x16, #0x0               // =0
               	mov	x17, #0x0               // =0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xc0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	adrp	x16, <page>
               	ldr	x16, [x16, <lo12>]
               	ldr	x16, [x16]
               	stur	x16, [x29, #-0x8]
               	mov	x16, #0x0               // =0
               	sub	x0, x29, #0x40
               	mov	x1, #0x20               // =32
               	mov	x2, #0x3                // =3
               	bl	<addr>
               	sub	x0, x29, #0x40
               	ldrb	w1, [x0]
               	ldrb	w0, [x0, #0x1f]
               	add	x0, x1, x0
               	cmp	w0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	adrp	x16, <page>
               	ldr	x16, [x16, <lo12>]
               	ldr	x16, [x16]
               	ldur	x17, [x29, #-0x8]
               	cmp	x16, x17
               	b.eq	<addr>
               	bl	<addr>
               	mov	x16, #0x0               // =0
               	mov	x17, #0x0               // =0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	mov	x1, #0x10               // =16
               	mov	x2, #0x1                // =1
               	bl	<addr>
               	sub	x0, x29, #0x20
               	ldrb	w1, [x0]
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	adrp	x16, <page>
               	ldr	x16, [x16, <lo12>]
               	ldr	x16, [x16]
               	ldur	x17, [x29, #-0x8]
               	cmp	x16, x17
               	b.eq	<addr>
               	bl	<addr>
               	mov	x16, #0x0               // =0
               	mov	x17, #0x0               // =0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x10               // =16
               	mov	x2, #0x2                // =2
               	bl	<addr>
               	sub	x0, x29, #0x20
               	ldrb	w1, [x0]
               	add	x1, x1, #0x1
               	cmp	w1, #0x3
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	adrp	x16, <page>
               	ldr	x16, [x16, <lo12>]
               	ldr	x16, [x16]
               	ldur	x17, [x29, #-0x8]
               	cmp	x16, x17
               	b.eq	<addr>
               	bl	<addr>
               	mov	x16, #0x0               // =0
               	mov	x17, #0x0               // =0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x10               // =16
               	mov	x2, #0x7                // =7
               	bl	<addr>
               	ldurb	w0, [x29, #-0x20]
               	add	x0, x0, #0x2
               	cmp	w0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	adrp	x16, <page>
               	ldr	x16, [x16, <lo12>]
               	ldr	x16, [x16]
               	ldur	x17, [x29, #-0x8]
               	cmp	x16, x17
               	b.eq	<addr>
               	bl	<addr>
               	mov	x16, #0x0               // =0
               	mov	x17, #0x0               // =0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	cmp	w0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	adrp	x16, <page>
               	ldr	x16, [x16, <lo12>]
               	ldr	x16, [x16]
               	ldur	x17, [x29, #-0x8]
               	cmp	x16, x17
               	b.eq	<addr>
               	bl	<addr>
               	mov	x16, #0x0               // =0
               	mov	x17, #0x0               // =0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x9                // =9
               	bl	<addr>
               	cmp	w0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	adrp	x16, <page>
               	ldr	x16, [x16, <lo12>]
               	ldr	x16, [x16]
               	ldur	x17, [x29, #-0x8]
               	cmp	x16, x17
               	b.eq	<addr>
               	bl	<addr>
               	mov	x16, #0x0               // =0
               	mov	x17, #0x0               // =0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	bl	<addr>
               	cmp	w0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	adrp	x16, <page>
               	ldr	x16, [x16, <lo12>]
               	ldr	x16, [x16]
               	ldur	x17, [x29, #-0x8]
               	cmp	x16, x17
               	b.eq	<addr>
               	bl	<addr>
               	mov	x16, #0x0               // =0
               	mov	x17, #0x0               // =0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	mov	x1, #0xa                // =10
               	mov	x2, #0x14               // =20
               	mov	x3, #0x1e               // =30
               	bl	<addr>
               	cmp	w0, #0x3f
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	adrp	x16, <page>
               	ldr	x16, [x16, <lo12>]
               	ldr	x16, [x16]
               	ldur	x17, [x29, #-0x8]
               	cmp	x16, x17
               	b.eq	<addr>
               	bl	<addr>
               	mov	x16, #0x0               // =0
               	mov	x17, #0x0               // =0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x29               // =41
               	stur	w0, [x29, #-0x48]
               	sub	x0, x29, #0x48
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	ldursw	x0, [x29, #-0x48]
               	cmp	w0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	adrp	x16, <page>
               	ldr	x16, [x16, <lo12>]
               	ldr	x16, [x16]
               	ldur	x17, [x29, #-0x8]
               	cmp	x16, x17
               	b.eq	<addr>
               	bl	<addr>
               	mov	x16, #0x0               // =0
               	mov	x17, #0x0               // =0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	adrp	x16, <page>
               	ldr	x16, [x16, <lo12>]
               	ldr	x16, [x16]
               	ldur	x17, [x29, #-0x8]
               	cmp	x16, x17
               	b.eq	<addr>
               	bl	<addr>
               	mov	x16, #0x0               // =0
               	mov	x17, #0x0               // =0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
