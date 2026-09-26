
by_reference_arguments.aarch64:	file format elf64-littleaarch64

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

<write_big>:
               	ldr	x9, [x0, #0x8]
               	add	x9, x9, x1
               	mov	x10, #-0x1              // =-1
               	str	x10, [x0]
               	and	x11, x0, #0x7
               	add	x0, x9, x11, lsl #8
               	ret

<keep>:
               	ret

<va_mixed>:
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
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x20
               	add	x2, x29, #0x10
               	mov	x16, x1
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
               	mov	x4, #0xa                // =10
               	mov	x5, #0x64               // =100
               	mov	x6, #0x3e8              // =1000
               	mov	x1, x0
               	ldrsw	x2, [x29, #0x10]
               	cmp	w0, w2
               	b.ge	<addr>
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
               	mov	x3, x16
               	ldrb	w7, [x3]
               	ldrb	w3, [x3, #0x2]
               	mov	x17, x2
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
               	mov	x2, x16
               	ldr	w2, [x2, #0x8]
               	sub	x8, x29, #0x20
               	mov	x17, x8
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
               	ldr	x16, [x16]
               	ldr	x9, [sp], #0x10
               	mov	x8, x16
               	ldr	x8, [x8, #0x8]
               	mul	x1, x1, x6
               	mul	x7, x7, x5
               	sxtw	x7, w7
               	add	x1, x1, x7
               	mul	x3, x3, x4
               	sxtw	x3, w3
               	add	x1, x1, x3
               	sxtw	x2, w2
               	add	x1, x1, x2
               	add	x1, x1, x8
               	add	x0, x0, #0x1
               	ldrsw	x2, [x29, #0x10]
               	cmp	w0, w2
               	b.lt	<addr>
               	sub	x0, x29, #0x20
               	mov	x0, x1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xc0
               	ret

<main>:
               	str	x20, [sp, #-0xe0]!
               	stp	x29, x30, [sp, #0xd0]
               	add	x29, sp, #0xd0
               	mov	x2, #0x1                // =1
               	mov	x3, #0x2                // =2
               	mov	x4, #0x3                // =3
               	mov	x1, #0x4                // =4
               	sub	x0, x29, #0x78
               	str	x2, [x0]
               	str	x3, [x0, #0x8]
               	str	x4, [x0, #0x10]
               	bl	<addr>
               	cmp	x0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0xd0]
               	ldr	x20, [sp], #0xe0
               	ret
               	sub	x2, x29, #0x90
               	mov	x0, #0x5                // =5
               	str	x0, [x2]
               	mov	x0, #0x6                // =6
               	str	x0, [x2, #0x8]
               	mov	x0, #0x7                // =7
               	str	x0, [x2, #0x10]
               	mov	x1, #0x1                // =1
               	sub	x0, x29, #0x60
               	ldr	x3, [x2]
               	str	x3, [x0]
               	ldr	x3, [x2, #0x8]
               	str	x3, [x0, #0x8]
               	ldr	x2, [x2, #0x10]
               	str	x2, [x0, #0x10]
               	bl	<addr>
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0xd0]
               	ldr	x20, [sp], #0xe0
               	ret
               	ldur	x0, [x29, #-0x90]
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0xd0]
               	ldr	x20, [sp], #0xe0
               	ret
               	mov	x2, #0xa                // =10
               	mov	x3, #0xb                // =11
               	mov	x4, #0xc                // =12
               	mov	x1, #0x1                // =1
               	sub	x0, x29, #0x48
               	str	x2, [x0]
               	str	x3, [x0, #0x8]
               	str	x4, [x0, #0x10]
               	bl	<addr>
               	cmp	x0, #0xc
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0xd0]
               	ldr	x20, [sp], #0xe0
               	ret
               	sub	x0, x29, #0xc0
               	mov	x3, #0x1                // =1
               	str	x3, [x0]
               	mov	x4, #0x2                // =2
               	str	x4, [x0, #0x8]
               	mov	x2, #0x3                // =3
               	str	x2, [x0, #0x10]
               	sub	x1, x29, #0xa8
               	str	x3, [x1]
               	str	x4, [x1, #0x8]
               	str	x2, [x1, #0x10]
               	ldr	x3, [x0]
               	mov	x17, #0xa               // =10
               	mul	x3, x3, x17
               	add	x20, x3, x2
               	mov	x2, #-0x1               // =-1
               	str	x2, [x1]
               	str	x2, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	blr	x1
               	sub	x0, x29, #0xa8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	blr	x1
               	cmp	x20, #0xd
               	b.ne	<addr>
               	sub	x0, x29, #0xc0
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	mov	x2, #0x2                // =2
               	str	x2, [x0, #0x8]
               	mov	x3, #0x3                // =3
               	str	x3, [x0, #0x10]
               	mov	x17, #0x64              // =100
               	mul	x1, x1, x17
               	mov	x17, #0xa               // =10
               	mul	x2, x2, x17
               	add	x1, x1, x2
               	add	x1, x1, x3
               	add	x1, x1, #0x1
               	add	x20, x1, #0x8
               	mov	x1, #-0x1               // =-1
               	str	x1, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	blr	x1
               	add	x0, x20, #0x2
               	add	x0, x0, #0x3
               	add	x0, x0, #0x4
               	add	x0, x0, #0x5
               	add	x0, x0, #0x6
               	add	x0, x0, #0x7
               	cmp	x0, #0x9f
               	b.ne	<addr>
               	sub	x0, x29, #0xb0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrh	w16, [x1]
               	strh	w16, [x0]
               	ldrb	w16, [x1, #0x2]
               	strb	w16, [x0, #0x2]
               	sub	x2, x29, #0xa0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x16, [x0]
               	str	x16, [x2]
               	ldr	w16, [x0, #0x8]
               	str	w16, [x2, #0x8]
               	mov	x0, #0x2                // =2
               	mov	x1, #0x201              // =513
               	movk	x1, #0x3, lsl #16
               	sub	x4, x29, #0x30
               	mov	x5, #0x1                // =1
               	str	x5, [x4]
               	mov	x6, #0x2                // =2
               	str	x6, [x4, #0x8]
               	mov	x7, #0x3                // =3
               	str	x7, [x4, #0x10]
               	sub	x3, x29, #0x18
               	str	x5, [x3]
               	str	x6, [x3, #0x8]
               	str	x7, [x3, #0x10]
               	sub	sp, sp, #0x10
               	str	x3, [sp]
               	mov	x5, x1
               	mov	x6, x2
               	ldr	w3, [x2, #0x8]
               	ldr	x2, [x2]
               	ldr	w7, [x6, #0x8]
               	ldr	x6, [x6]
               	bl	<addr>
               	add	sp, sp, #0x10
               	mov	x17, #0x1b9a            // =7066
               	movk	x17, #0x2, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0xd0]
               	ldr	x20, [sp], #0xe0
               	ret
               	ldurb	w0, [x29, #-0xb0]
               	eor	x0, x0, #0x1
               	cbnz	w0, <addr>
               	ldursw	x0, [x29, #-0xa0]
               	cmp	w0, #0x4
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0xd0]
               	ldr	x20, [sp], #0xe0
               	ret
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0xd0]
               	ldr	x20, [sp], #0xe0
               	ret
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0xd0]
               	ldr	x20, [sp], #0xe0
               	ret
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0xd0]
               	ldr	x20, [sp], #0xe0
               	ret
