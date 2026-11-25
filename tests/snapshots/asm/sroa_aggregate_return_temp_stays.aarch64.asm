
sroa_aggregate_return_temp_stays.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<times5>:
               	lsr	x1, x0, #32
               	lsl	x2, x0, #2
               	orr	x3, x2, x1, lsr #30
               	lsl	x2, x1, #2
               	add	x0, x3, x0
               	add	x1, x2, x1
               	cmp	w1, w2
               	cinc	x0, x0, lo
               	mov	w0, w0
               	orr	x0, x0, x1, lsl #32
               	ret

<times9>:
               	lsr	x1, x0, #32
               	lsl	x2, x0, #3
               	orr	x3, x2, x1, lsr #29
               	lsl	x2, x1, #3
               	add	x0, x3, x0
               	add	x1, x2, x1
               	cmp	w1, w2
               	cinc	x0, x0, lo
               	mov	w0, w0
               	orr	x0, x0, x1, lsl #32
               	ret

<step>:
               	str	x20, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, x0
               	add	x0, x20, #0x8
               	ldr	x0, [x0]
               	bl	<addr>
               	lsr	x1, x0, #32
               	lsl	x2, x0, #7
               	orr	x2, x2, x1, lsr #25
               	mov	w0, w0
               	lsr	x0, x0, #25
               	orr	x1, x0, x1, lsl #7
               	sub	x0, x29, #0x8
               	stur	w2, [x29, #-0x8]
               	stur	w1, [x29, #-0x4]
               	ldr	x0, [x0]
               	bl	<addr>
               	lsr	x6, x0, #32
               	ldr	w2, [x20, #0x8]
               	ldr	w1, [x20, #0xc]
               	lsl	x3, x2, #17
               	orr	x7, x3, x1, lsr #15
               	ldr	w3, [x20]
               	ldr	w4, [x20, #0x4]
               	ldr	w5, [x20, #0x10]
               	eor	x3, x5, x3
               	str	w3, [x20, #0x10]
               	ldr	w5, [x20, #0x14]
               	eor	x4, x5, x4
               	str	w4, [x20, #0x14]
               	ldr	w5, [x20, #0x18]
               	eor	x2, x5, x2
               	str	w2, [x20, #0x18]
               	ldr	w5, [x20, #0x1c]
               	eor	x5, x5, x1
               	str	w5, [x20, #0x1c]
               	ldr	w8, [x20, #0x8]
               	eor	x3, x8, x3
               	str	w3, [x20, #0x8]
               	ldr	w3, [x20, #0xc]
               	eor	x3, x3, x4
               	str	w3, [x20, #0xc]
               	ldr	w3, [x20]
               	eor	x2, x3, x2
               	str	w2, [x20]
               	ldr	w2, [x20, #0x4]
               	eor	x2, x2, x5
               	str	w2, [x20, #0x4]
               	ldr	w2, [x20, #0x10]
               	eor	x2, x2, x7
               	str	w2, [x20, #0x10]
               	ldr	w2, [x20, #0x14]
               	eor	x1, x2, x1, lsl #17
               	str	w1, [x20, #0x14]
               	ldr	w1, [x20, #0x18]
               	ldr	w2, [x20, #0x1c]
               	lsr	x3, x1, #19
               	orr	x3, x3, x2, lsl #13
               	lsl	x1, x1, #13
               	orr	x1, x1, x2, lsr #19
               	str	w3, [x20, #0x18]
               	str	w1, [x20, #0x1c]
               	mov	w0, w0
               	orr	x0, x0, x6, lsl #32
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x0, x29, #0x20
               	mov	x1, #0x3ef00000000      // =4325032067072
               	stur	x1, [x29, #-0x20]
               	mov	x1, #0xff00000000       // =1095216660480
               	stur	x1, [x29, #-0x18]
               	stur	xzr, [x29, #-0x10]
               	stur	xzr, [x29, #-0x8]
               	bl	<addr>
               	sub	x0, x29, #0x20
               	bl	<addr>
               	sub	x0, x29, #0x20
               	bl	<addr>
               	sub	x0, x29, #0x20
               	bl	<addr>
               	sub	x0, x29, #0x20
               	bl	<addr>
               	sub	x0, x29, #0x20
               	bl	<addr>
               	sub	x0, x29, #0x20
               	bl	<addr>
               	sub	x0, x29, #0x20
               	bl	<addr>
               	sub	x0, x29, #0x20
               	bl	<addr>
               	sub	x0, x29, #0x20
               	bl	<addr>
               	sub	x0, x29, #0x20
               	bl	<addr>
               	sub	x0, x29, #0x20
               	bl	<addr>
               	sub	x0, x29, #0x20
               	bl	<addr>
               	sub	x0, x29, #0x20
               	bl	<addr>
               	sub	x0, x29, #0x20
               	bl	<addr>
               	sub	x0, x29, #0x20
               	bl	<addr>
               	sub	x0, x29, #0x20
               	bl	<addr>
               	mov	w1, w0
               	lsl	x1, x1, #31
               	lsl	x1, x1, #1
               	orr	x0, x1, x0, lsr #32
               	mov	x17, #0xc9d6            // =51670
               	movk	x17, #0xa323, lsl #16
               	movk	x17, #0x40a5, lsl #32
               	movk	x17, #0x7a70, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
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
               	add	sp, sp, #0x20
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
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
