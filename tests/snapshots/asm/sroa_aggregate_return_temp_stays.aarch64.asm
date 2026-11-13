
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
               	ldur	w1, [x29, #-0x8]
               	ldur	w0, [x29, #-0x4]
               	lsl	x2, x1, #2
               	orr	x3, x2, x0, lsr #30
               	lsl	x2, x0, #2
               	add	x1, x3, x1
               	add	x0, x2, x0
               	cmp	w0, w2
               	cinc	x1, x1, lo
               	mov	w1, w1
               	orr	x0, x1, x0, lsl #32
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<times9>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	x0, [x29, #-0x8]
               	ldur	w1, [x29, #-0x8]
               	ldur	w0, [x29, #-0x4]
               	lsl	x2, x1, #3
               	orr	x3, x2, x0, lsr #29
               	lsl	x2, x0, #3
               	add	x1, x3, x1
               	add	x0, x2, x0
               	cmp	w0, w2
               	cinc	x1, x1, lo
               	mov	w1, w1
               	orr	x0, x1, x0, lsl #32
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
               	ldur	w1, [x29, #-0x8]
               	ldur	w2, [x29, #-0x4]
               	lsl	x3, x1, #7
               	orr	x3, x3, x2, lsr #25
               	lsr	x1, x1, #25
               	orr	x1, x1, x2, lsl #7
               	stur	w3, [x29, #-0x8]
               	stur	w1, [x29, #-0x4]
               	ldr	x0, [x0]
               	bl	<addr>
               	stur	x0, [x29, #-0x8]
               	ldur	w3, [x29, #-0x8]
               	ldur	w4, [x29, #-0x4]
               	ldr	w1, [x20, #0x8]
               	ldr	w0, [x20, #0xc]
               	lsl	x2, x1, #17
               	orr	x5, x2, x0, lsr #15
               	ldr	w2, [x20]
               	ldr	w6, [x20, #0x4]
               	ldr	w7, [x20, #0x10]
               	eor	x2, x7, x2
               	str	w2, [x20, #0x10]
               	ldr	w2, [x20, #0x14]
               	eor	x2, x2, x6
               	str	w2, [x20, #0x14]
               	ldr	w2, [x20, #0x18]
               	eor	x1, x2, x1
               	str	w1, [x20, #0x18]
               	ldr	w1, [x20, #0x1c]
               	eor	x1, x1, x0
               	str	w1, [x20, #0x1c]
               	ldr	w1, [x20, #0x10]
               	ldr	w2, [x20, #0x14]
               	ldr	w6, [x20, #0x8]
               	eor	x1, x6, x1
               	str	w1, [x20, #0x8]
               	ldr	w1, [x20, #0xc]
               	eor	x1, x1, x2
               	str	w1, [x20, #0xc]
               	ldr	w1, [x20, #0x18]
               	ldr	w2, [x20, #0x1c]
               	ldr	w6, [x20]
               	eor	x6, x6, x1
               	str	w6, [x20]
               	ldr	w6, [x20, #0x4]
               	eor	x6, x6, x2
               	str	w6, [x20, #0x4]
               	ldr	w6, [x20, #0x10]
               	eor	x5, x6, x5
               	str	w5, [x20, #0x10]
               	ldr	w5, [x20, #0x14]
               	eor	x0, x5, x0, lsl #17
               	str	w0, [x20, #0x14]
               	lsr	x0, x1, #19
               	orr	x0, x0, x2, lsl #13
               	lsl	x1, x1, #13
               	orr	x1, x1, x2, lsr #19
               	str	w0, [x20, #0x18]
               	str	w1, [x20, #0x1c]
               	orr	x0, x3, x4, lsl #32
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x0, x29, #0x20
               	mov	x1, #0x3ef00000000      // =4325032067072
               	stur	x1, [x29, #-0x20]
               	mov	x1, #0xff00000000       // =1095216660480
               	stur	x1, [x29, #-0x18]
               	stur	xzr, [x29, #-0x10]
               	stur	xzr, [x29, #-0x8]
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
               	ldur	w0, [x29, #-0x28]
               	lsl	x0, x0, #31
               	ldur	w1, [x29, #-0x24]
               	orr	x0, x1, x0, lsl #1
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
               	ldur	w0, [x29, #-0x20]
               	lsl	x0, x0, #31
               	ldur	w1, [x29, #-0x1c]
               	orr	x0, x1, x0, lsl #1
               	mov	x17, #0x27f9            // =10233
               	movk	x17, #0x6cb2, lsl #16
               	movk	x17, #0x8b51, lsl #32
               	movk	x17, #0xba1, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w0, [x29, #-0x8]
               	lsl	x0, x0, #31
               	ldur	w1, [x29, #-0x4]
               	orr	x0, x1, x0, lsl #1
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
