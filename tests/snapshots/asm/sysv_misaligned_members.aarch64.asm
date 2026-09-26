
sysv_misaligned_members.aarch64:	file format elf64-littleaarch64

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

<take_p1>:
               	lsr	x2, x1, #8
               	mov	x17, #0x3e8             // =1000
               	mul	x0, x0, x17
               	and	x1, x1, #0xff
               	mov	x17, #0x64              // =100
               	mul	x1, x1, x17
               	sxtw	x1, w1
               	add	x0, x0, x1
               	sxtw	x1, w2
               	add	x0, x0, x1
               	ret

<take_p2>:
               	lsr	x1, x0, #16
               	sxth	x0, w0
               	mov	x17, #0x3e8             // =1000
               	mul	x0, x0, x17
               	mov	x17, #0xa               // =10
               	mul	x1, x1, x17
               	add	x0, x0, x1
               	sxtw	x0, w0
               	add	x0, x0, #0x3
               	ret

<take_p5>:
               	lsr	x1, x0, #16
               	and	x0, x0, #0xff
               	mov	x17, #0x3e8             // =1000
               	mul	x0, x0, x17
               	mov	x17, #0xa               // =10
               	mul	x1, x1, x17
               	add	x0, x0, x1
               	sxtw	x0, w0
               	add	x0, x0, #0x3
               	ret

<make_p1>:
               	mov	x0, #0x4d06             // =19718
               	ret

<make_p2>:
               	mov	x0, #0x4                // =4
               	movk	x0, #0xb, lsl #16
               	ret

<make_p3>:
               	mov	x0, #0x108              // =264
               	movk	x0, #0x302, lsl #16
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x0, x29, #0x20
               	mov	x1, #0x2                // =2
               	strh	w1, [x0]
               	mov	x1, #0x9                // =9
               	stur	w1, [x0, #0x2]
               	sub	x0, x29, #0x18
               	mov	x1, #0x4                // =4
               	strb	w1, [x0]
               	mov	x2, #0x5                // =5
               	strb	w2, [x0, #0x1]
               	mov	x1, #0x6                // =6
               	stur	w1, [x0, #0x2]
               	sub	x1, x29, #0x8
               	strb	w2, [x1]
               	mov	x0, #0x2a               // =42
               	stur	w0, [x1, #0x1]
               	sub	x3, x29, #0x10
               	ldr	w16, [x1]
               	str	w16, [x3]
               	ldrb	w16, [x1, #0x4]
               	strb	w16, [x3, #0x4]
               	strb	w2, [x1]
               	stur	w0, [x1, #0x1]
               	mov	x0, #0x3                // =3
               	ldr	x1, [x1]
               	bl	<addr>
               	cmp	x0, #0xdd6
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	mov	x1, #0x3                // =3
               	ldr	x0, [x0]
               	bl	<addr>
               	cmp	x0, #0x82d
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	mov	x1, #0x3                // =3
               	ldr	x0, [x0]
               	bl	<addr>
               	cmp	x0, #0xfdf
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x6                // =6
               	mov	x1, #0x4d               // =77
               	bl	<addr>
               	stur	w0, [x29, #-0x8]
               	lsr	x1, x0, #32
               	sub	x0, x29, #0x8
               	strb	w1, [x0, #0x4]
               	sub	x1, x29, #0x10
               	ldr	w16, [x0]
               	str	w16, [x1]
               	ldrb	w16, [x0, #0x4]
               	strb	w16, [x1, #0x4]
               	sub	x0, x29, #0x10
               	ldrb	w1, [x0]
               	eor	x1, x1, #0x6
               	cbnz	w1, <addr>
               	ldursw	x0, [x0, #0x1]
               	cmp	w0, #0x4d
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	mov	x1, #0xb                // =11
               	bl	<addr>
               	stur	w0, [x29, #-0x8]
               	lsr	x1, x0, #32
               	sub	x0, x29, #0x8
               	strh	w1, [x0, #0x4]
               	sub	x1, x29, #0x20
               	ldr	w16, [x0]
               	str	w16, [x1]
               	ldrh	w16, [x0, #0x4]
               	strh	w16, [x1, #0x4]
               	sub	x0, x29, #0x20
               	ldrsh	x1, [x0]
               	cmp	w1, #0x4
               	b.ne	<addr>
               	ldursw	x0, [x0, #0x2]
               	cmp	w0, #0xb
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x8                // =8
               	bl	<addr>
               	stur	w0, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	ldrb	w1, [x0]
               	ldrb	w0, [x0, #0x3]
               	eor	x1, x1, #0x8
               	cbnz	w1, <addr>
               	eor	x0, x0, #0x3
               	cbz	w0, <addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
