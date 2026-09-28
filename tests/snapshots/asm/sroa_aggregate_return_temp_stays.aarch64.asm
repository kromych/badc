
sroa_aggregate_return_temp_stays.aarch64:	file format elf64-littleaarch64

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

<times5>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	x0, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	ldr	w2, [x0]
               	ldr	w1, [x0, #0x4]
               	lsl	x2, x2, #2
               	lsr	x3, x1, #30
               	orr	x2, x2, x3
               	lsl	x1, x1, #2
               	ldr	w3, [x0]
               	ldr	w4, [x0, #0x4]
               	add	x0, x2, x3
               	add	x2, x1, x4
               	cmp	w2, w1
               	b.hs	<addr>
               	add	x0, x0, #0x1
               	mov	w0, w0
               	mov	w1, w2
               	lsl	x1, x1, #32
               	orr	x0, x0, x1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<times9>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	x0, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	ldr	w2, [x0]
               	ldr	w1, [x0, #0x4]
               	lsl	x2, x2, #3
               	lsr	x3, x1, #29
               	orr	x2, x2, x3
               	lsl	x1, x1, #3
               	ldr	w3, [x0]
               	ldr	w4, [x0, #0x4]
               	add	x0, x2, x3
               	add	x2, x1, x4
               	cmp	w2, w1
               	b.hs	<addr>
               	add	x0, x0, #0x1
               	mov	w0, w0
               	mov	w1, w2
               	lsl	x1, x1, #32
               	orr	x0, x0, x1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<step>:
               	str	x20, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, x0
               	add	x0, x20, #0x8
               	ldr	x0, [x0]
               	bl	<addr>
               	stur	x0, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	ldr	w1, [x0]
               	ldr	w2, [x0, #0x4]
               	lsl	x3, x1, #7
               	lsr	x4, x2, #25
               	orr	x3, x3, x4
               	lsr	x1, x1, #25
               	lsl	x2, x2, #7
               	orr	x1, x1, x2
               	str	w3, [x0]
               	str	w1, [x0, #0x4]
               	ldr	x0, [x0]
               	bl	<addr>
               	stur	x0, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	ldr	w3, [x0]
               	ldr	w4, [x0, #0x4]
               	add	x2, x20, #0x8
               	ldr	w1, [x2]
               	ldr	w0, [x2, #0x4]
               	lsl	x1, x1, #17
               	lsr	x5, x0, #15
               	orr	x5, x1, x5
               	lsl	x6, x0, #17
               	add	x0, x20, #0x10
               	ldr	w1, [x20]
               	ldr	w7, [x20, #0x4]
               	ldr	w8, [x0]
               	eor	x1, x8, x1
               	str	w1, [x0]
               	ldr	w1, [x0, #0x4]
               	eor	x1, x1, x7
               	str	w1, [x0, #0x4]
               	add	x1, x20, #0x18
               	ldr	w7, [x2]
               	ldr	w8, [x2, #0x4]
               	ldr	w9, [x1]
               	eor	x7, x9, x7
               	str	w7, [x1]
               	ldr	w7, [x1, #0x4]
               	eor	x7, x7, x8
               	str	w7, [x1, #0x4]
               	ldr	w7, [x0]
               	ldr	w8, [x0, #0x4]
               	ldr	w9, [x2]
               	eor	x7, x9, x7
               	str	w7, [x2]
               	ldr	w7, [x2, #0x4]
               	eor	x7, x7, x8
               	str	w7, [x2, #0x4]
               	ldr	w2, [x1]
               	ldr	w7, [x1, #0x4]
               	ldr	w8, [x20]
               	eor	x2, x8, x2
               	str	w2, [x20]
               	ldr	w2, [x20, #0x4]
               	eor	x2, x2, x7
               	str	w2, [x20, #0x4]
               	ldr	w2, [x0]
               	eor	x2, x2, x5
               	str	w2, [x0]
               	ldr	w2, [x0, #0x4]
               	eor	x2, x2, x6
               	str	w2, [x0, #0x4]
               	ldr	w0, [x1]
               	ldr	w2, [x1, #0x4]
               	lsr	x5, x0, #19
               	lsl	x6, x2, #13
               	orr	x5, x5, x6
               	lsl	x0, x0, #13
               	lsr	x2, x2, #19
               	orr	x0, x0, x2
               	str	w5, [x1]
               	str	w0, [x1, #0x4]
               	lsl	x0, x4, #32
               	orr	x0, x3, x0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x0, x29, #0x20
               	mov	x2, #0x3ef              // =1007
               	str	wzr, [x0]
               	str	w2, [x0, #0x4]
               	add	x2, x0, #0x8
               	mov	x3, #0xff               // =255
               	str	wzr, [x2]
               	str	w3, [x2, #0x4]
               	add	x2, x0, #0x10
               	str	wzr, [x2]
               	str	wzr, [x2, #0x4]
               	add	x2, x0, #0x18
               	str	wzr, [x2]
               	str	wzr, [x2, #0x4]
               	bl	<addr>
               	stur	x0, [x29, #-0x28]
               	sub	x0, x29, #0x20
               	bl	<addr>
               	stur	x0, [x29, #-0x28]
               	sub	x0, x29, #0x20
               	bl	<addr>
               	stur	x0, [x29, #-0x28]
               	sub	x0, x29, #0x20
               	bl	<addr>
               	stur	x0, [x29, #-0x28]
               	sub	x0, x29, #0x20
               	bl	<addr>
               	stur	x0, [x29, #-0x28]
               	sub	x0, x29, #0x20
               	bl	<addr>
               	stur	x0, [x29, #-0x28]
               	sub	x0, x29, #0x20
               	bl	<addr>
               	stur	x0, [x29, #-0x28]
               	sub	x0, x29, #0x20
               	bl	<addr>
               	stur	x0, [x29, #-0x28]
               	sub	x0, x29, #0x20
               	bl	<addr>
               	stur	x0, [x29, #-0x28]
               	sub	x0, x29, #0x20
               	bl	<addr>
               	stur	x0, [x29, #-0x28]
               	sub	x0, x29, #0x20
               	bl	<addr>
               	stur	x0, [x29, #-0x28]
               	sub	x0, x29, #0x20
               	bl	<addr>
               	stur	x0, [x29, #-0x28]
               	sub	x0, x29, #0x20
               	bl	<addr>
               	stur	x0, [x29, #-0x28]
               	sub	x0, x29, #0x20
               	bl	<addr>
               	stur	x0, [x29, #-0x28]
               	sub	x0, x29, #0x20
               	bl	<addr>
               	stur	x0, [x29, #-0x28]
               	sub	x0, x29, #0x20
               	bl	<addr>
               	stur	x0, [x29, #-0x28]
               	sub	x0, x29, #0x20
               	bl	<addr>
               	stur	x0, [x29, #-0x28]
               	sub	x0, x29, #0x28
               	ldr	w1, [x0]
               	lsl	x1, x1, #31
               	lsl	x1, x1, #1
               	ldr	w0, [x0, #0x4]
               	orr	x0, x1, x0
               	mov	x17, #0xc9d6            // =51670
               	movk	x17, #0xa323, lsl #16
               	movk	x17, #0x40a5, lsl #32
               	movk	x17, #0x7a70, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	ldr	w1, [x0]
               	lsl	x1, x1, #31
               	lsl	x1, x1, #1
               	ldr	w2, [x0, #0x4]
               	orr	x1, x1, x2
               	mov	x17, #0x27f9            // =10233
               	movk	x17, #0x6cb2, lsl #16
               	movk	x17, #0x8b51, lsl #32
               	movk	x17, #0xba1, lsl #48
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x0, #0x18
               	ldr	w1, [x0]
               	lsl	x1, x1, #31
               	lsl	x1, x1, #1
               	ldr	w0, [x0, #0x4]
               	orr	x0, x1, x0
               	mov	x17, #0xcb5a            // =52058
               	movk	x17, #0x3210, lsl #16
               	movk	x17, #0x95cf, lsl #32
               	movk	x17, #0x194f, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
