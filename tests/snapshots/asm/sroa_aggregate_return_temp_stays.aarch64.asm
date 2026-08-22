
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
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x16, x29, #0x10
               	str	x0, [x16]
               	sub	x0, x29, #0x10
               	ldr	w2, [x0]
               	ldr	w1, [x0, #0x4]
               	mov	w2, w2
               	lsl	x2, x2, #2
               	mov	w3, w2
               	mov	w2, w1
               	lsr	x4, x2, #30
               	orr	x3, x3, x4
               	lsl	x1, x2, #2
               	mov	w1, w1
               	mov	w2, w3
               	mov	w1, w1
               	mov	w2, w2
               	mov	w1, w1
               	ldr	w3, [x0]
               	ldr	w0, [x0, #0x4]
               	mov	w2, w2
               	mov	w3, w3
               	add	x2, x2, x3
               	mov	w3, w2
               	mov	w2, w1
               	mov	w0, w0
               	add	x0, x2, x0
               	mov	w0, w0
               	mov	w3, w3
               	mov	w4, w0
               	mov	w0, w3
               	mov	w3, w4
               	mov	w4, w3
               	cmp	x4, x2
               	b.hs	<addr>
               	mov	w0, w0
               	add	x0, x0, #0x1
               	sub	x1, x29, #0x8
               	mov	w0, w0
               	mov	w2, w3
               	str	w0, [x1]
               	str	w2, [x1, #0x4]
               	mov	x16, x1
               	ldr	x0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret
               	b	<addr>

<times9>:
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x16, x29, #0x10
               	str	x0, [x16]
               	sub	x0, x29, #0x10
               	ldr	w2, [x0]
               	ldr	w1, [x0, #0x4]
               	mov	w2, w2
               	lsl	x2, x2, #3
               	mov	w3, w2
               	mov	w2, w1
               	lsr	x4, x2, #29
               	orr	x3, x3, x4
               	lsl	x1, x2, #3
               	mov	w1, w1
               	mov	w2, w3
               	mov	w1, w1
               	mov	w2, w2
               	mov	w1, w1
               	ldr	w3, [x0]
               	ldr	w0, [x0, #0x4]
               	mov	w2, w2
               	mov	w3, w3
               	add	x2, x2, x3
               	mov	w3, w2
               	mov	w2, w1
               	mov	w0, w0
               	add	x0, x2, x0
               	mov	w0, w0
               	mov	w3, w3
               	mov	w4, w0
               	mov	w0, w3
               	mov	w3, w4
               	mov	w4, w3
               	cmp	x4, x2
               	b.hs	<addr>
               	mov	w0, w0
               	add	x0, x0, #0x1
               	sub	x1, x29, #0x8
               	mov	w0, w0
               	mov	w2, w3
               	str	w0, [x1]
               	str	w2, [x1, #0x4]
               	mov	x16, x1
               	ldr	x0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret
               	b	<addr>

<step>:
               	stp	x20, x21, [sp, #-0x50]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	mov	x20, x0
               	add	x21, x20, #0x8
               	mov	x0, x21
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x10
               	str	x0, [x16]
               	sub	x22, x29, #0x10
               	ldr	w0, [x22]
               	ldr	w1, [x22, #0x4]
               	mov	w2, w0
               	lsl	x3, x2, #7
               	mov	w4, w3
               	mov	w3, w1
               	lsr	x5, x3, #25
               	orr	x4, x4, x5
               	lsr	x0, x2, #25
               	lsl	x1, x3, #7
               	mov	w1, w1
               	orr	x0, x0, x1
               	mov	w1, w4
               	mov	w2, w0
               	sub	x0, x29, #0x18
               	mov	w1, w1
               	mov	w2, w2
               	str	w1, [x0]
               	str	w2, [x0, #0x4]
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x10
               	str	x0, [x16]
               	sub	x2, x29, #0x8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x22]
               	str	x10, [x2]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	ldr	w1, [x21]
               	ldr	w0, [x21, #0x4]
               	mov	w1, w1
               	lsl	x1, x1, #17
               	mov	w3, w1
               	mov	w1, w0
               	lsr	x4, x1, #15
               	orr	x3, x3, x4
               	lsl	x0, x1, #17
               	mov	w0, w0
               	mov	w1, w3
               	mov	w0, w0
               	mov	w3, w1
               	mov	w4, w0
               	add	x0, x20, #0x10
               	ldr	w1, [x20]
               	ldr	w7, [x20, #0x4]
               	ldr	w8, [x0]
               	mov	w1, w1
               	eor	x1, x8, x1
               	str	w1, [x0]
               	ldr	w1, [x0, #0x4]
               	mov	w7, w7
               	eor	x1, x1, x7
               	str	w1, [x0, #0x4]
               	add	x1, x20, #0x18
               	ldr	w7, [x21]
               	ldr	w8, [x21, #0x4]
               	ldr	w9, [x1]
               	mov	w7, w7
               	eor	x7, x9, x7
               	str	w7, [x1]
               	ldr	w7, [x1, #0x4]
               	mov	w8, w8
               	eor	x7, x7, x8
               	str	w7, [x1, #0x4]
               	ldr	w7, [x0]
               	ldr	w8, [x0, #0x4]
               	ldr	w9, [x21]
               	mov	w7, w7
               	eor	x7, x9, x7
               	str	w7, [x21]
               	ldr	w7, [x21, #0x4]
               	mov	w8, w8
               	eor	x7, x7, x8
               	str	w7, [x21, #0x4]
               	ldr	w7, [x1]
               	ldr	w8, [x1, #0x4]
               	ldr	w9, [x20]
               	mov	w7, w7
               	eor	x7, x9, x7
               	str	w7, [x20]
               	ldr	w7, [x20, #0x4]
               	mov	w8, w8
               	eor	x7, x7, x8
               	str	w7, [x20, #0x4]
               	ldr	w5, [x0]
               	mov	w3, w3
               	eor	x3, x5, x3
               	str	w3, [x0]
               	ldr	w3, [x0, #0x4]
               	mov	w4, w4
               	eor	x3, x3, x4
               	str	w3, [x0, #0x4]
               	ldr	w0, [x1]
               	ldr	w3, [x1, #0x4]
               	mov	w4, w0
               	lsr	x6, x4, #19
               	mov	w5, w3
               	lsl	x7, x5, #13
               	mov	w7, w7
               	orr	x6, x6, x7
               	lsl	x0, x4, #13
               	mov	w0, w0
               	lsr	x3, x5, #19
               	orr	x0, x0, x3
               	mov	w3, w6
               	mov	w4, w0
               	sub	x0, x29, #0x10
               	mov	w3, w3
               	mov	w4, w4
               	str	w3, [x0]
               	str	w4, [x0, #0x4]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x16, x2
               	ldr	x0, [x16]
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x60]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	sub	x2, x29, #0x20
               	sub	x0, x29, #0x28
               	mov	x1, #0x0                // =0
               	str	w1, [x0]
               	mov	x3, #0x3ef              // =1007
               	str	w3, [x0, #0x4]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [sp], #0x10
               	mov	x3, x2
               	add	x3, x2, #0x8
               	str	w1, [x0]
               	mov	x4, #0xff               // =255
               	str	w4, [x0, #0x4]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [sp], #0x10
               	add	x3, x2, #0x10
               	str	w1, [x0]
               	str	w1, [x0, #0x4]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [sp], #0x10
               	add	x2, x2, #0x18
               	str	w1, [x0]
               	mov	x22, #0x0               // =0
               	str	w22, [x0, #0x4]
               	sub	x21, x29, #0x28
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x21]
               	str	x10, [x2]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	sub	x20, x29, #0x20
               	mov	x0, x20
               	bl	<addr>
               	sub	x16, x29, #0x28
               	str	x0, [x16]
               	mov	x0, x20
               	bl	<addr>
               	sub	x16, x29, #0x28
               	str	x0, [x16]
               	mov	x0, x20
               	bl	<addr>
               	sub	x16, x29, #0x28
               	str	x0, [x16]
               	mov	x0, x20
               	bl	<addr>
               	sub	x16, x29, #0x28
               	str	x0, [x16]
               	mov	x0, x20
               	bl	<addr>
               	sub	x16, x29, #0x28
               	str	x0, [x16]
               	mov	x0, x20
               	bl	<addr>
               	sub	x16, x29, #0x28
               	str	x0, [x16]
               	sub	x20, x29, #0x20
               	mov	x0, x20
               	bl	<addr>
               	sub	x16, x29, #0x28
               	str	x0, [x16]
               	mov	x0, x20
               	bl	<addr>
               	sub	x16, x29, #0x28
               	str	x0, [x16]
               	mov	x0, x20
               	bl	<addr>
               	sub	x16, x29, #0x28
               	str	x0, [x16]
               	mov	x0, x20
               	bl	<addr>
               	sub	x16, x29, #0x28
               	str	x0, [x16]
               	mov	x0, x20
               	bl	<addr>
               	sub	x16, x29, #0x28
               	str	x0, [x16]
               	mov	x0, x20
               	bl	<addr>
               	sub	x16, x29, #0x28
               	str	x0, [x16]
               	sub	x20, x29, #0x20
               	mov	x0, x20
               	bl	<addr>
               	sub	x16, x29, #0x28
               	str	x0, [x16]
               	mov	x0, x20
               	bl	<addr>
               	sub	x16, x29, #0x28
               	str	x0, [x16]
               	mov	x0, x20
               	bl	<addr>
               	sub	x16, x29, #0x28
               	str	x0, [x16]
               	mov	x0, x20
               	bl	<addr>
               	sub	x16, x29, #0x28
               	str	x0, [x16]
               	mov	x0, x20
               	bl	<addr>
               	sub	x16, x29, #0x28
               	str	x0, [x16]
               	ldr	w0, [x21]
               	lsl	x0, x0, #31
               	lsl	x0, x0, #1
               	ldr	w1, [x21, #0x4]
               	orr	x0, x0, x1
               	mov	x17, #0xc9d6            // =51670
               	movk	x17, #0xa323, lsl #16
               	movk	x17, #0x40a5, lsl #32
               	movk	x17, #0x7a70, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
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
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
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
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, x22
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
