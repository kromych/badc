
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

<shl>:
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x16, x29, #0x10
               	str	x0, [x16]
               	sxtw	x1, w1
               	sub	x0, x29, #0x10
               	ldr	w2, [x0]
               	lsl	x2, x2, x1
               	mov	w4, w2
               	ldr	w2, [x0, #0x4]
               	mov	x3, #0x20               // =32
               	sub	x3, x3, x1
               	sxtw	x3, w3
               	lsr	x3, x2, x3
               	orr	x3, x4, x3
               	lsl	x0, x2, x1
               	mov	w1, w0
               	sub	x0, x29, #0x8
               	mov	w2, w3
               	str	w2, [x0]
               	mov	w1, w1
               	str	w1, [x0, #0x4]
               	mov	x16, x0
               	ldr	x0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret

<xorinto>:
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x16, x29, #0x8
               	str	x1, [x16]
               	ldr	w2, [x0]
               	sub	x1, x29, #0x8
               	ldr	w3, [x1]
               	eor	x2, x2, x3
               	str	w2, [x0]
               	ldr	w2, [x0, #0x4]
               	ldr	w1, [x1, #0x4]
               	eor	x1, x2, x1
               	str	w1, [x0, #0x4]
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret

<add>:
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x16, x29, #0x18
               	str	x0, [x16]
               	sub	x16, x29, #0x10
               	str	x1, [x16]
               	sub	x1, x29, #0x18
               	ldr	w2, [x1]
               	sub	x0, x29, #0x10
               	ldr	w3, [x0]
               	add	x2, x2, x3
               	mov	w3, w2
               	ldr	w2, [x1, #0x4]
               	ldr	w0, [x0, #0x4]
               	add	x0, x2, x0
               	mov	w0, w0
               	sub	x2, x29, #0x20
               	mov	w3, w3
               	str	w3, [x2]
               	mov	w0, w0
               	str	w0, [x2, #0x4]
               	sub	x0, x29, #0x8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	mov	x2, x0
               	ldr	w2, [x0, #0x4]
               	ldr	w1, [x1, #0x4]
               	cmp	w2, w1
               	b.hs	<addr>
               	ldr	w1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x16, x0
               	ldr	x0, [x16]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret

<times5>:
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x16, x29, #0x20
               	str	x0, [x16]
               	sub	x0, x29, #0x20
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
               	cmp	w4, w2
               	b.hs	<addr>
               	mov	w0, w0
               	add	x0, x0, #0x1
               	sub	x1, x29, #0x10
               	mov	w0, w0
               	mov	w2, w3
               	str	w0, [x1]
               	str	w2, [x1, #0x4]
               	mov	x16, x1
               	ldr	x0, [x16]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret
               	b	<addr>

<times9>:
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x16, x29, #0x20
               	str	x0, [x16]
               	sub	x0, x29, #0x20
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
               	cmp	w4, w2
               	b.hs	<addr>
               	mov	w0, w0
               	add	x0, x0, #0x1
               	sub	x1, x29, #0x10
               	mov	w0, w0
               	mov	w2, w3
               	str	w0, [x1]
               	str	w2, [x1, #0x4]
               	mov	x16, x1
               	ldr	x0, [x16]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret
               	b	<addr>

<rot>:
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x16, x29, #0x10
               	str	x0, [x16]
               	sub	x0, x29, #0x10
               	ldr	w1, [x0]
               	lsl	x2, x1, #7
               	mov	w2, w2
               	ldr	w3, [x0, #0x4]
               	lsr	x3, x3, #25
               	orr	x2, x2, x3
               	lsr	x1, x1, #25
               	ldr	w0, [x0, #0x4]
               	lsl	x0, x0, #7
               	mov	w0, w0
               	orr	x1, x1, x0
               	sub	x0, x29, #0x8
               	mov	w2, w2
               	str	w2, [x0]
               	mov	w1, w1
               	str	w1, [x0, #0x4]
               	mov	x16, x0
               	ldr	x0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret

<rot_hi>:
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x16, x29, #0x10
               	str	x0, [x16]
               	sub	x0, x29, #0x10
               	ldr	w1, [x0]
               	lsr	x2, x1, #19
               	ldr	w3, [x0, #0x4]
               	lsl	x3, x3, #13
               	mov	w3, w3
               	orr	x2, x2, x3
               	lsl	x1, x1, #13
               	mov	w1, w1
               	ldr	w0, [x0, #0x4]
               	lsr	x0, x0, #19
               	orr	x1, x1, x0
               	sub	x0, x29, #0x8
               	mov	w2, w2
               	str	w2, [x0]
               	mov	w1, w1
               	str	w1, [x0, #0x4]
               	mov	x16, x0
               	ldr	x0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret

<main>:
               	stp	x20, x21, [sp, #-0xd0]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x29, x30, [sp, #0xc0]
               	add	x29, sp, #0xc0
               	sub	x2, x29, #0x30
               	sub	x0, x29, #0x38
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
               	mov	x1, #0x0                // =0
               	str	w1, [x0, #0x4]
               	sub	x23, x29, #0x38
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x23]
               	str	x10, [x2]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	sub	x20, x29, #0x30
               	add	x21, x20, #0x8
               	sub	x22, x29, #0x60
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x21]
               	str	x10, [x22]
               	ldr	x10, [sp], #0x10
               	mov	x0, x22
               	mov	x1, #0x2                // =2
               	mov	x0, x22
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x58
               	str	x0, [x16]
               	sub	x0, x29, #0x58
               	mov	x1, x22
               	ldr	x0, [x0]
               	ldr	x1, [x1]
               	bl	<addr>
               	sub	x16, x29, #0x50
               	str	x0, [x16]
               	sub	x1, x29, #0x50
               	sub	x0, x29, #0x88
               	ldr	w2, [x1]
               	ldr	w1, [x1, #0x4]
               	str	w2, [x0]
               	str	w1, [x0, #0x4]
               	ldr	w1, [x0]
               	ldr	w0, [x0, #0x4]
               	mov	w2, w1
               	lsl	x3, x2, #7
               	mov	w4, w3
               	mov	w3, w0
               	lsr	x5, x3, #25
               	orr	x4, x4, x5
               	lsr	x1, x2, #25
               	lsl	x0, x3, #7
               	mov	w0, w0
               	orr	x0, x1, x0
               	mov	w1, w4
               	mov	w2, w0
               	sub	x0, x29, #0x80
               	mov	w1, w1
               	mov	w2, w2
               	str	w1, [x0]
               	str	w2, [x0, #0x4]
               	sub	x22, x29, #0x48
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x22]
               	ldr	x10, [sp], #0x10
               	mov	x0, x22
               	mov	x1, #0x3                // =3
               	mov	x0, x22
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x40
               	str	x0, [x16]
               	sub	x0, x29, #0x40
               	mov	x1, x22
               	ldr	x0, [x0]
               	ldr	x1, [x1]
               	bl	<addr>
               	sub	x16, x29, #0x38
               	str	x0, [x16]
               	sub	x22, x29, #0x78
               	ldr	w0, [x23]
               	ldr	w1, [x23, #0x4]
               	str	w0, [x22]
               	str	w1, [x22, #0x4]
               	ldr	w1, [x21]
               	ldr	w0, [x21, #0x4]
               	mov	w1, w1
               	lsl	x1, x1, #17
               	mov	w2, w1
               	mov	w1, w0
               	lsr	x3, x1, #15
               	orr	x2, x2, x3
               	lsl	x0, x1, #17
               	mov	w0, w0
               	mov	w1, w2
               	mov	w2, w0
               	sub	x0, x29, #0x70
               	mov	w1, w1
               	mov	w2, w2
               	str	w1, [x0]
               	str	w2, [x0, #0x4]
               	sub	x2, x29, #0x90
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	add	x0, x20, #0x10
               	ldr	w1, [x20]
               	ldr	w3, [x20, #0x4]
               	ldr	w4, [x0]
               	mov	w1, w1
               	eor	x1, x4, x1
               	str	w1, [x0]
               	ldr	w1, [x0, #0x4]
               	mov	w3, w3
               	eor	x1, x1, x3
               	str	w1, [x0, #0x4]
               	add	x1, x20, #0x18
               	ldr	w3, [x21]
               	ldr	w4, [x21, #0x4]
               	ldr	w7, [x1]
               	mov	w3, w3
               	eor	x3, x7, x3
               	str	w3, [x1]
               	ldr	w3, [x1, #0x4]
               	mov	w4, w4
               	eor	x3, x3, x4
               	str	w3, [x1, #0x4]
               	ldr	w3, [x0]
               	ldr	w4, [x0, #0x4]
               	ldr	w7, [x21]
               	mov	w3, w3
               	eor	x3, x7, x3
               	str	w3, [x21]
               	ldr	w3, [x21, #0x4]
               	mov	w4, w4
               	eor	x3, x3, x4
               	str	w3, [x21, #0x4]
               	ldr	w3, [x1]
               	ldr	w4, [x1, #0x4]
               	ldr	w7, [x20]
               	mov	w3, w3
               	eor	x3, x7, x3
               	str	w3, [x20]
               	ldr	w3, [x20, #0x4]
               	mov	w4, w4
               	eor	x3, x3, x4
               	str	w3, [x20, #0x4]
               	ldr	w3, [x2]
               	ldr	w2, [x2, #0x4]
               	ldr	w4, [x0]
               	mov	w3, w3
               	eor	x3, x4, x3
               	str	w3, [x0]
               	ldr	w3, [x0, #0x4]
               	mov	w2, w2
               	eor	x2, x3, x2
               	str	w2, [x0, #0x4]
               	ldr	w0, [x1]
               	ldr	w2, [x1, #0x4]
               	mov	w3, w0
               	lsr	x7, x3, #19
               	mov	w4, w2
               	lsl	x8, x4, #13
               	mov	w8, w8
               	orr	x7, x7, x8
               	lsl	x0, x3, #13
               	mov	w0, w0
               	lsr	x2, x4, #19
               	orr	x0, x0, x2
               	mov	w2, w7
               	mov	w3, w0
               	sub	x0, x29, #0x68
               	mov	w2, w2
               	mov	w3, w3
               	str	w2, [x0]
               	str	w3, [x0, #0x4]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x20, x29, #0x30
               	add	x21, x20, #0x8
               	sub	x23, x29, #0x60
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x21]
               	str	x10, [x23]
               	ldr	x10, [sp], #0x10
               	mov	x0, x23
               	mov	x1, #0x2                // =2
               	mov	x0, x23
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x58
               	str	x0, [x16]
               	sub	x0, x29, #0x58
               	mov	x1, x23
               	ldr	x0, [x0]
               	ldr	x1, [x1]
               	bl	<addr>
               	sub	x16, x29, #0x50
               	str	x0, [x16]
               	sub	x1, x29, #0x50
               	sub	x0, x29, #0x88
               	ldr	w2, [x1]
               	ldr	w1, [x1, #0x4]
               	str	w2, [x0]
               	str	w1, [x0, #0x4]
               	ldr	w1, [x0]
               	ldr	w0, [x0, #0x4]
               	mov	w2, w1
               	lsl	x3, x2, #7
               	mov	w4, w3
               	mov	w3, w0
               	lsr	x5, x3, #25
               	orr	x4, x4, x5
               	lsr	x1, x2, #25
               	lsl	x0, x3, #7
               	mov	w0, w0
               	orr	x0, x1, x0
               	mov	w1, w4
               	mov	w2, w0
               	sub	x0, x29, #0x80
               	mov	w1, w1
               	mov	w2, w2
               	str	w1, [x0]
               	str	w2, [x0, #0x4]
               	sub	x23, x29, #0x48
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x23]
               	ldr	x10, [sp], #0x10
               	mov	x0, x23
               	mov	x1, #0x3                // =3
               	mov	x0, x23
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x40
               	str	x0, [x16]
               	sub	x0, x29, #0x40
               	mov	x1, x23
               	ldr	x0, [x0]
               	ldr	x1, [x1]
               	bl	<addr>
               	sub	x16, x29, #0x38
               	str	x0, [x16]
               	sub	x23, x29, #0x38
               	ldr	w0, [x23]
               	ldr	w1, [x23, #0x4]
               	str	w0, [x22]
               	str	w1, [x22, #0x4]
               	ldr	w1, [x21]
               	ldr	w0, [x21, #0x4]
               	mov	w1, w1
               	lsl	x1, x1, #17
               	mov	w2, w1
               	mov	w1, w0
               	lsr	x3, x1, #15
               	orr	x2, x2, x3
               	lsl	x0, x1, #17
               	mov	w0, w0
               	mov	w1, w2
               	mov	w2, w0
               	sub	x0, x29, #0x70
               	mov	w1, w1
               	mov	w2, w2
               	str	w1, [x0]
               	str	w2, [x0, #0x4]
               	sub	x2, x29, #0x90
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	add	x0, x20, #0x10
               	ldr	w1, [x20]
               	ldr	w3, [x20, #0x4]
               	ldr	w4, [x0]
               	mov	w1, w1
               	eor	x1, x4, x1
               	str	w1, [x0]
               	ldr	w1, [x0, #0x4]
               	mov	w3, w3
               	eor	x1, x1, x3
               	str	w1, [x0, #0x4]
               	add	x1, x20, #0x18
               	ldr	w3, [x21]
               	ldr	w4, [x21, #0x4]
               	ldr	w7, [x1]
               	mov	w3, w3
               	eor	x3, x7, x3
               	str	w3, [x1]
               	ldr	w3, [x1, #0x4]
               	mov	w4, w4
               	eor	x3, x3, x4
               	str	w3, [x1, #0x4]
               	ldr	w3, [x0]
               	ldr	w4, [x0, #0x4]
               	ldr	w7, [x21]
               	mov	w3, w3
               	eor	x3, x7, x3
               	str	w3, [x21]
               	ldr	w3, [x21, #0x4]
               	mov	w4, w4
               	eor	x3, x3, x4
               	str	w3, [x21, #0x4]
               	ldr	w3, [x1]
               	ldr	w4, [x1, #0x4]
               	ldr	w7, [x20]
               	mov	w3, w3
               	eor	x3, x7, x3
               	str	w3, [x20]
               	ldr	w3, [x20, #0x4]
               	mov	w4, w4
               	eor	x3, x3, x4
               	str	w3, [x20, #0x4]
               	ldr	w3, [x2]
               	ldr	w2, [x2, #0x4]
               	ldr	w4, [x0]
               	mov	w3, w3
               	eor	x3, x4, x3
               	str	w3, [x0]
               	ldr	w3, [x0, #0x4]
               	mov	w2, w2
               	eor	x2, x3, x2
               	str	w2, [x0, #0x4]
               	ldr	w0, [x1]
               	ldr	w2, [x1, #0x4]
               	mov	w3, w0
               	lsr	x7, x3, #19
               	mov	w4, w2
               	lsl	x8, x4, #13
               	mov	w8, w8
               	orr	x7, x7, x8
               	lsl	x0, x3, #13
               	mov	w0, w0
               	lsr	x2, x4, #19
               	orr	x0, x0, x2
               	mov	w2, w7
               	mov	w3, w0
               	sub	x0, x29, #0x68
               	mov	w2, w2
               	mov	w3, w3
               	str	w2, [x0]
               	str	w3, [x0, #0x4]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x20, x29, #0x30
               	add	x21, x20, #0x8
               	sub	x22, x29, #0x60
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x21]
               	str	x10, [x22]
               	ldr	x10, [sp], #0x10
               	mov	x0, x22
               	mov	x1, #0x2                // =2
               	mov	x0, x22
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x58
               	str	x0, [x16]
               	sub	x0, x29, #0x58
               	mov	x1, x22
               	ldr	x0, [x0]
               	ldr	x1, [x1]
               	bl	<addr>
               	sub	x16, x29, #0x50
               	str	x0, [x16]
               	sub	x1, x29, #0x50
               	sub	x0, x29, #0x88
               	ldr	w2, [x1]
               	ldr	w1, [x1, #0x4]
               	str	w2, [x0]
               	str	w1, [x0, #0x4]
               	ldr	w1, [x0]
               	ldr	w0, [x0, #0x4]
               	mov	w2, w1
               	lsl	x3, x2, #7
               	mov	w4, w3
               	mov	w3, w0
               	lsr	x5, x3, #25
               	orr	x4, x4, x5
               	lsr	x1, x2, #25
               	lsl	x0, x3, #7
               	mov	w0, w0
               	orr	x0, x1, x0
               	mov	w1, w4
               	mov	w2, w0
               	sub	x0, x29, #0x80
               	mov	w1, w1
               	mov	w2, w2
               	str	w1, [x0]
               	str	w2, [x0, #0x4]
               	sub	x22, x29, #0x48
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x22]
               	ldr	x10, [sp], #0x10
               	mov	x0, x22
               	mov	x1, #0x3                // =3
               	mov	x0, x22
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x40
               	str	x0, [x16]
               	sub	x0, x29, #0x40
               	mov	x1, x22
               	ldr	x0, [x0]
               	ldr	x1, [x1]
               	bl	<addr>
               	sub	x16, x29, #0x38
               	str	x0, [x16]
               	sub	x22, x29, #0x78
               	ldr	w0, [x23]
               	ldr	w1, [x23, #0x4]
               	str	w0, [x22]
               	str	w1, [x22, #0x4]
               	ldr	w1, [x21]
               	ldr	w0, [x21, #0x4]
               	mov	w1, w1
               	lsl	x1, x1, #17
               	mov	w2, w1
               	mov	w1, w0
               	lsr	x3, x1, #15
               	orr	x2, x2, x3
               	lsl	x0, x1, #17
               	mov	w0, w0
               	mov	w1, w2
               	mov	w2, w0
               	sub	x0, x29, #0x70
               	mov	w1, w1
               	mov	w2, w2
               	str	w1, [x0]
               	str	w2, [x0, #0x4]
               	sub	x2, x29, #0x90
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	add	x0, x20, #0x10
               	ldr	w1, [x20]
               	ldr	w3, [x20, #0x4]
               	ldr	w4, [x0]
               	mov	w1, w1
               	eor	x1, x4, x1
               	str	w1, [x0]
               	ldr	w1, [x0, #0x4]
               	mov	w3, w3
               	eor	x1, x1, x3
               	str	w1, [x0, #0x4]
               	add	x1, x20, #0x18
               	ldr	w3, [x21]
               	ldr	w4, [x21, #0x4]
               	ldr	w7, [x1]
               	mov	w3, w3
               	eor	x3, x7, x3
               	str	w3, [x1]
               	ldr	w3, [x1, #0x4]
               	mov	w4, w4
               	eor	x3, x3, x4
               	str	w3, [x1, #0x4]
               	ldr	w3, [x0]
               	ldr	w4, [x0, #0x4]
               	ldr	w7, [x21]
               	mov	w3, w3
               	eor	x3, x7, x3
               	str	w3, [x21]
               	ldr	w3, [x21, #0x4]
               	mov	w4, w4
               	eor	x3, x3, x4
               	str	w3, [x21, #0x4]
               	ldr	w3, [x1]
               	ldr	w4, [x1, #0x4]
               	ldr	w7, [x20]
               	mov	w3, w3
               	eor	x3, x7, x3
               	str	w3, [x20]
               	ldr	w3, [x20, #0x4]
               	mov	w4, w4
               	eor	x3, x3, x4
               	str	w3, [x20, #0x4]
               	ldr	w3, [x2]
               	ldr	w2, [x2, #0x4]
               	ldr	w4, [x0]
               	mov	w3, w3
               	eor	x3, x4, x3
               	str	w3, [x0]
               	ldr	w3, [x0, #0x4]
               	mov	w2, w2
               	eor	x2, x3, x2
               	str	w2, [x0, #0x4]
               	ldr	w0, [x1]
               	ldr	w2, [x1, #0x4]
               	mov	w3, w0
               	lsr	x7, x3, #19
               	mov	w4, w2
               	lsl	x8, x4, #13
               	mov	w8, w8
               	orr	x7, x7, x8
               	lsl	x0, x3, #13
               	mov	w0, w0
               	lsr	x2, x4, #19
               	orr	x0, x0, x2
               	mov	w2, w7
               	mov	w3, w0
               	sub	x0, x29, #0x68
               	mov	w2, w2
               	mov	w3, w3
               	str	w2, [x0]
               	str	w3, [x0, #0x4]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x20, x29, #0x30
               	add	x21, x20, #0x8
               	sub	x23, x29, #0x60
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x21]
               	str	x10, [x23]
               	ldr	x10, [sp], #0x10
               	mov	x0, x23
               	mov	x1, #0x2                // =2
               	mov	x0, x23
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x58
               	str	x0, [x16]
               	sub	x0, x29, #0x58
               	mov	x1, x23
               	ldr	x0, [x0]
               	ldr	x1, [x1]
               	bl	<addr>
               	sub	x16, x29, #0x50
               	str	x0, [x16]
               	sub	x1, x29, #0x50
               	sub	x0, x29, #0x88
               	ldr	w2, [x1]
               	ldr	w1, [x1, #0x4]
               	str	w2, [x0]
               	str	w1, [x0, #0x4]
               	ldr	w1, [x0]
               	ldr	w0, [x0, #0x4]
               	mov	w2, w1
               	lsl	x3, x2, #7
               	mov	w4, w3
               	mov	w3, w0
               	lsr	x5, x3, #25
               	orr	x4, x4, x5
               	lsr	x1, x2, #25
               	lsl	x0, x3, #7
               	mov	w0, w0
               	orr	x0, x1, x0
               	mov	w1, w4
               	mov	w2, w0
               	sub	x0, x29, #0x80
               	mov	w1, w1
               	mov	w2, w2
               	str	w1, [x0]
               	str	w2, [x0, #0x4]
               	sub	x23, x29, #0x48
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x23]
               	ldr	x10, [sp], #0x10
               	mov	x0, x23
               	mov	x1, #0x3                // =3
               	mov	x0, x23
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x40
               	str	x0, [x16]
               	sub	x0, x29, #0x40
               	mov	x1, x23
               	ldr	x0, [x0]
               	ldr	x1, [x1]
               	bl	<addr>
               	sub	x16, x29, #0x38
               	str	x0, [x16]
               	sub	x23, x29, #0x38
               	ldr	w0, [x23]
               	ldr	w1, [x23, #0x4]
               	str	w0, [x22]
               	str	w1, [x22, #0x4]
               	ldr	w1, [x21]
               	ldr	w0, [x21, #0x4]
               	mov	w1, w1
               	lsl	x1, x1, #17
               	mov	w2, w1
               	mov	w1, w0
               	lsr	x3, x1, #15
               	orr	x2, x2, x3
               	lsl	x0, x1, #17
               	mov	w0, w0
               	mov	w1, w2
               	mov	w2, w0
               	sub	x0, x29, #0x70
               	mov	w1, w1
               	mov	w2, w2
               	str	w1, [x0]
               	str	w2, [x0, #0x4]
               	sub	x2, x29, #0x90
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	add	x0, x20, #0x10
               	ldr	w1, [x20]
               	ldr	w3, [x20, #0x4]
               	ldr	w4, [x0]
               	mov	w1, w1
               	eor	x1, x4, x1
               	str	w1, [x0]
               	ldr	w1, [x0, #0x4]
               	mov	w3, w3
               	eor	x1, x1, x3
               	str	w1, [x0, #0x4]
               	add	x1, x20, #0x18
               	ldr	w3, [x21]
               	ldr	w4, [x21, #0x4]
               	ldr	w7, [x1]
               	mov	w3, w3
               	eor	x3, x7, x3
               	str	w3, [x1]
               	ldr	w3, [x1, #0x4]
               	mov	w4, w4
               	eor	x3, x3, x4
               	str	w3, [x1, #0x4]
               	ldr	w3, [x0]
               	ldr	w4, [x0, #0x4]
               	ldr	w7, [x21]
               	mov	w3, w3
               	eor	x3, x7, x3
               	str	w3, [x21]
               	ldr	w3, [x21, #0x4]
               	mov	w4, w4
               	eor	x3, x3, x4
               	str	w3, [x21, #0x4]
               	ldr	w3, [x1]
               	ldr	w4, [x1, #0x4]
               	ldr	w7, [x20]
               	mov	w3, w3
               	eor	x3, x7, x3
               	str	w3, [x20]
               	ldr	w3, [x20, #0x4]
               	mov	w4, w4
               	eor	x3, x3, x4
               	str	w3, [x20, #0x4]
               	ldr	w3, [x2]
               	ldr	w2, [x2, #0x4]
               	ldr	w4, [x0]
               	mov	w3, w3
               	eor	x3, x4, x3
               	str	w3, [x0]
               	ldr	w3, [x0, #0x4]
               	mov	w2, w2
               	eor	x2, x3, x2
               	str	w2, [x0, #0x4]
               	ldr	w0, [x1]
               	ldr	w2, [x1, #0x4]
               	mov	w3, w0
               	lsr	x7, x3, #19
               	mov	w4, w2
               	lsl	x8, x4, #13
               	mov	w8, w8
               	orr	x7, x7, x8
               	lsl	x0, x3, #13
               	mov	w0, w0
               	lsr	x2, x4, #19
               	orr	x0, x0, x2
               	mov	w2, w7
               	mov	w3, w0
               	sub	x0, x29, #0x68
               	mov	w2, w2
               	mov	w3, w3
               	str	w2, [x0]
               	str	w3, [x0, #0x4]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x20, x29, #0x30
               	add	x21, x20, #0x8
               	sub	x22, x29, #0x60
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x21]
               	str	x10, [x22]
               	ldr	x10, [sp], #0x10
               	mov	x0, x22
               	mov	x1, #0x2                // =2
               	mov	x0, x22
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x58
               	str	x0, [x16]
               	sub	x0, x29, #0x58
               	mov	x1, x22
               	ldr	x0, [x0]
               	ldr	x1, [x1]
               	bl	<addr>
               	sub	x16, x29, #0x50
               	str	x0, [x16]
               	sub	x1, x29, #0x50
               	sub	x0, x29, #0x88
               	ldr	w2, [x1]
               	ldr	w1, [x1, #0x4]
               	str	w2, [x0]
               	str	w1, [x0, #0x4]
               	ldr	w1, [x0]
               	ldr	w0, [x0, #0x4]
               	mov	w2, w1
               	lsl	x3, x2, #7
               	mov	w4, w3
               	mov	w3, w0
               	lsr	x5, x3, #25
               	orr	x4, x4, x5
               	lsr	x1, x2, #25
               	lsl	x0, x3, #7
               	mov	w0, w0
               	orr	x0, x1, x0
               	mov	w1, w4
               	mov	w2, w0
               	sub	x0, x29, #0x80
               	mov	w1, w1
               	mov	w2, w2
               	str	w1, [x0]
               	str	w2, [x0, #0x4]
               	sub	x22, x29, #0x48
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x22]
               	ldr	x10, [sp], #0x10
               	mov	x0, x22
               	mov	x1, #0x3                // =3
               	mov	x0, x22
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x40
               	str	x0, [x16]
               	sub	x0, x29, #0x40
               	mov	x1, x22
               	ldr	x0, [x0]
               	ldr	x1, [x1]
               	bl	<addr>
               	sub	x16, x29, #0x38
               	str	x0, [x16]
               	sub	x0, x29, #0x78
               	ldr	w1, [x23]
               	ldr	w2, [x23, #0x4]
               	str	w1, [x0]
               	str	w2, [x0, #0x4]
               	ldr	w1, [x21]
               	ldr	w0, [x21, #0x4]
               	mov	w1, w1
               	lsl	x1, x1, #17
               	mov	w2, w1
               	mov	w1, w0
               	lsr	x3, x1, #15
               	orr	x2, x2, x3
               	lsl	x0, x1, #17
               	mov	w0, w0
               	mov	w1, w2
               	mov	w2, w0
               	sub	x22, x29, #0x70
               	mov	w0, w1
               	mov	w1, w2
               	str	w0, [x22]
               	str	w1, [x22, #0x4]
               	sub	x2, x29, #0x90
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x22]
               	str	x10, [x2]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	add	x0, x20, #0x10
               	ldr	w1, [x20]
               	ldr	w3, [x20, #0x4]
               	ldr	w4, [x0]
               	mov	w1, w1
               	eor	x1, x4, x1
               	str	w1, [x0]
               	ldr	w1, [x0, #0x4]
               	mov	w3, w3
               	eor	x1, x1, x3
               	str	w1, [x0, #0x4]
               	add	x1, x20, #0x18
               	ldr	w3, [x21]
               	ldr	w4, [x21, #0x4]
               	ldr	w7, [x1]
               	mov	w3, w3
               	eor	x3, x7, x3
               	str	w3, [x1]
               	ldr	w3, [x1, #0x4]
               	mov	w4, w4
               	eor	x3, x3, x4
               	str	w3, [x1, #0x4]
               	ldr	w3, [x0]
               	ldr	w4, [x0, #0x4]
               	ldr	w7, [x21]
               	mov	w3, w3
               	eor	x3, x7, x3
               	str	w3, [x21]
               	ldr	w3, [x21, #0x4]
               	mov	w4, w4
               	eor	x3, x3, x4
               	str	w3, [x21, #0x4]
               	ldr	w3, [x1]
               	ldr	w4, [x1, #0x4]
               	ldr	w7, [x20]
               	mov	w3, w3
               	eor	x3, x7, x3
               	str	w3, [x20]
               	ldr	w3, [x20, #0x4]
               	mov	w4, w4
               	eor	x3, x3, x4
               	str	w3, [x20, #0x4]
               	ldr	w3, [x2]
               	ldr	w2, [x2, #0x4]
               	ldr	w4, [x0]
               	mov	w3, w3
               	eor	x3, x4, x3
               	str	w3, [x0]
               	ldr	w3, [x0, #0x4]
               	mov	w2, w2
               	eor	x2, x3, x2
               	str	w2, [x0, #0x4]
               	ldr	w0, [x1]
               	ldr	w2, [x1, #0x4]
               	mov	w3, w0
               	lsr	x7, x3, #19
               	mov	w4, w2
               	lsl	x8, x4, #13
               	mov	w8, w8
               	orr	x7, x7, x8
               	lsl	x0, x3, #13
               	mov	w0, w0
               	lsr	x2, x4, #19
               	orr	x0, x0, x2
               	mov	w2, w7
               	mov	w3, w0
               	sub	x0, x29, #0x68
               	mov	w2, w2
               	mov	w3, w3
               	str	w2, [x0]
               	str	w3, [x0, #0x4]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x20, x29, #0x30
               	add	x21, x20, #0x8
               	mov	x0, x21
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x88
               	str	x0, [x16]
               	sub	x0, x29, #0x88
               	ldr	w1, [x0]
               	ldr	w0, [x0, #0x4]
               	mov	w2, w1
               	lsl	x3, x2, #7
               	mov	w4, w3
               	mov	w3, w0
               	lsr	x5, x3, #25
               	orr	x4, x4, x5
               	lsr	x1, x2, #25
               	lsl	x0, x3, #7
               	mov	w0, w0
               	orr	x0, x1, x0
               	mov	w1, w4
               	mov	w2, w0
               	sub	x0, x29, #0x80
               	mov	w1, w1
               	mov	w2, w2
               	str	w1, [x0]
               	str	w2, [x0, #0x4]
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x78
               	str	x0, [x16]
               	ldr	w1, [x21]
               	ldr	w0, [x21, #0x4]
               	mov	w1, w1
               	lsl	x1, x1, #17
               	mov	w2, w1
               	mov	w1, w0
               	lsr	x3, x1, #15
               	orr	x2, x2, x3
               	lsl	x0, x1, #17
               	mov	w0, w0
               	mov	w1, w2
               	mov	w2, w0
               	mov	w0, w1
               	mov	w1, w2
               	str	w0, [x22]
               	str	w1, [x22, #0x4]
               	sub	x23, x29, #0x90
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x22]
               	str	x10, [x23]
               	ldr	x10, [sp], #0x10
               	mov	x0, x23
               	add	x0, x20, #0x10
               	ldr	w1, [x20]
               	ldr	w2, [x20, #0x4]
               	ldr	w3, [x0]
               	mov	w1, w1
               	eor	x1, x3, x1
               	str	w1, [x0]
               	ldr	w1, [x0, #0x4]
               	mov	w2, w2
               	eor	x1, x1, x2
               	str	w1, [x0, #0x4]
               	add	x1, x20, #0x18
               	ldr	w2, [x21]
               	ldr	w3, [x21, #0x4]
               	ldr	w4, [x1]
               	mov	w2, w2
               	eor	x2, x4, x2
               	str	w2, [x1]
               	ldr	w2, [x1, #0x4]
               	mov	w3, w3
               	eor	x2, x2, x3
               	str	w2, [x1, #0x4]
               	ldr	w2, [x0]
               	ldr	w3, [x0, #0x4]
               	ldr	w4, [x21]
               	mov	w2, w2
               	eor	x2, x4, x2
               	str	w2, [x21]
               	ldr	w2, [x21, #0x4]
               	mov	w3, w3
               	eor	x2, x2, x3
               	str	w2, [x21, #0x4]
               	ldr	w2, [x1]
               	ldr	w3, [x1, #0x4]
               	ldr	w4, [x20]
               	mov	w2, w2
               	eor	x2, x4, x2
               	str	w2, [x20]
               	ldr	w2, [x20, #0x4]
               	mov	w3, w3
               	eor	x2, x2, x3
               	str	w2, [x20, #0x4]
               	ldr	w2, [x23]
               	ldr	w3, [x23, #0x4]
               	ldr	w4, [x0]
               	mov	w2, w2
               	eor	x2, x4, x2
               	str	w2, [x0]
               	ldr	w2, [x0, #0x4]
               	mov	w3, w3
               	eor	x2, x2, x3
               	str	w2, [x0, #0x4]
               	ldr	w0, [x1]
               	ldr	w2, [x1, #0x4]
               	mov	w3, w0
               	lsr	x7, x3, #19
               	mov	w4, w2
               	lsl	x8, x4, #13
               	mov	w8, w8
               	orr	x7, x7, x8
               	lsl	x0, x3, #13
               	mov	w0, w0
               	lsr	x2, x4, #19
               	orr	x0, x0, x2
               	mov	w2, w7
               	mov	w3, w0
               	sub	x0, x29, #0x68
               	mov	w2, w2
               	mov	w3, w3
               	str	w2, [x0]
               	str	w3, [x0, #0x4]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x20, x29, #0x30
               	add	x21, x20, #0x8
               	mov	x0, x21
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x88
               	str	x0, [x16]
               	sub	x0, x29, #0x88
               	ldr	w1, [x0]
               	ldr	w0, [x0, #0x4]
               	mov	w2, w1
               	lsl	x3, x2, #7
               	mov	w4, w3
               	mov	w3, w0
               	lsr	x5, x3, #25
               	orr	x4, x4, x5
               	lsr	x1, x2, #25
               	lsl	x0, x3, #7
               	mov	w0, w0
               	orr	x0, x1, x0
               	mov	w1, w4
               	mov	w2, w0
               	sub	x0, x29, #0x80
               	mov	w1, w1
               	mov	w2, w2
               	str	w1, [x0]
               	str	w2, [x0, #0x4]
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x78
               	str	x0, [x16]
               	ldr	w1, [x21]
               	ldr	w0, [x21, #0x4]
               	mov	w1, w1
               	lsl	x1, x1, #17
               	mov	w2, w1
               	mov	w1, w0
               	lsr	x3, x1, #15
               	orr	x2, x2, x3
               	lsl	x0, x1, #17
               	mov	w0, w0
               	mov	w1, w2
               	mov	w2, w0
               	sub	x22, x29, #0x70
               	mov	w0, w1
               	mov	w1, w2
               	str	w0, [x22]
               	str	w1, [x22, #0x4]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x22]
               	str	x10, [x23]
               	ldr	x10, [sp], #0x10
               	mov	x0, x23
               	add	x0, x20, #0x10
               	ldr	w1, [x20]
               	ldr	w2, [x20, #0x4]
               	ldr	w3, [x0]
               	mov	w1, w1
               	eor	x1, x3, x1
               	str	w1, [x0]
               	ldr	w1, [x0, #0x4]
               	mov	w2, w2
               	eor	x1, x1, x2
               	str	w1, [x0, #0x4]
               	add	x1, x20, #0x18
               	ldr	w2, [x21]
               	ldr	w3, [x21, #0x4]
               	ldr	w4, [x1]
               	mov	w2, w2
               	eor	x2, x4, x2
               	str	w2, [x1]
               	ldr	w2, [x1, #0x4]
               	mov	w3, w3
               	eor	x2, x2, x3
               	str	w2, [x1, #0x4]
               	ldr	w2, [x0]
               	ldr	w3, [x0, #0x4]
               	ldr	w4, [x21]
               	mov	w2, w2
               	eor	x2, x4, x2
               	str	w2, [x21]
               	ldr	w2, [x21, #0x4]
               	mov	w3, w3
               	eor	x2, x2, x3
               	str	w2, [x21, #0x4]
               	ldr	w2, [x1]
               	ldr	w3, [x1, #0x4]
               	ldr	w4, [x20]
               	mov	w2, w2
               	eor	x2, x4, x2
               	str	w2, [x20]
               	ldr	w2, [x20, #0x4]
               	mov	w3, w3
               	eor	x2, x2, x3
               	str	w2, [x20, #0x4]
               	sub	x2, x29, #0x90
               	ldr	w3, [x2]
               	ldr	w2, [x2, #0x4]
               	ldr	w4, [x0]
               	mov	w3, w3
               	eor	x3, x4, x3
               	str	w3, [x0]
               	ldr	w3, [x0, #0x4]
               	mov	w2, w2
               	eor	x2, x3, x2
               	str	w2, [x0, #0x4]
               	ldr	w0, [x1]
               	ldr	w2, [x1, #0x4]
               	mov	w3, w0
               	lsr	x7, x3, #19
               	mov	w4, w2
               	lsl	x8, x4, #13
               	mov	w8, w8
               	orr	x7, x7, x8
               	lsl	x0, x3, #13
               	mov	w0, w0
               	lsr	x2, x4, #19
               	orr	x0, x0, x2
               	mov	w2, w7
               	mov	w3, w0
               	sub	x0, x29, #0x68
               	mov	w2, w2
               	mov	w3, w3
               	str	w2, [x0]
               	str	w3, [x0, #0x4]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x20, x29, #0x30
               	add	x21, x20, #0x8
               	mov	x0, x21
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x88
               	str	x0, [x16]
               	sub	x0, x29, #0x88
               	ldr	w1, [x0]
               	ldr	w0, [x0, #0x4]
               	mov	w2, w1
               	lsl	x3, x2, #7
               	mov	w4, w3
               	mov	w3, w0
               	lsr	x5, x3, #25
               	orr	x4, x4, x5
               	lsr	x1, x2, #25
               	lsl	x0, x3, #7
               	mov	w0, w0
               	orr	x0, x1, x0
               	mov	w1, w4
               	mov	w2, w0
               	sub	x0, x29, #0x80
               	mov	w1, w1
               	mov	w2, w2
               	str	w1, [x0]
               	str	w2, [x0, #0x4]
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x78
               	str	x0, [x16]
               	ldr	w1, [x21]
               	ldr	w0, [x21, #0x4]
               	mov	w1, w1
               	lsl	x1, x1, #17
               	mov	w2, w1
               	mov	w1, w0
               	lsr	x3, x1, #15
               	orr	x2, x2, x3
               	lsl	x0, x1, #17
               	mov	w0, w0
               	mov	w1, w2
               	mov	w2, w0
               	mov	w0, w1
               	mov	w1, w2
               	str	w0, [x22]
               	str	w1, [x22, #0x4]
               	sub	x23, x29, #0x90
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x22]
               	str	x10, [x23]
               	ldr	x10, [sp], #0x10
               	mov	x0, x23
               	add	x0, x20, #0x10
               	ldr	w1, [x20]
               	ldr	w2, [x20, #0x4]
               	ldr	w3, [x0]
               	mov	w1, w1
               	eor	x1, x3, x1
               	str	w1, [x0]
               	ldr	w1, [x0, #0x4]
               	mov	w2, w2
               	eor	x1, x1, x2
               	str	w1, [x0, #0x4]
               	add	x1, x20, #0x18
               	ldr	w2, [x21]
               	ldr	w3, [x21, #0x4]
               	ldr	w4, [x1]
               	mov	w2, w2
               	eor	x2, x4, x2
               	str	w2, [x1]
               	ldr	w2, [x1, #0x4]
               	mov	w3, w3
               	eor	x2, x2, x3
               	str	w2, [x1, #0x4]
               	ldr	w2, [x0]
               	ldr	w3, [x0, #0x4]
               	ldr	w4, [x21]
               	mov	w2, w2
               	eor	x2, x4, x2
               	str	w2, [x21]
               	ldr	w2, [x21, #0x4]
               	mov	w3, w3
               	eor	x2, x2, x3
               	str	w2, [x21, #0x4]
               	ldr	w2, [x1]
               	ldr	w3, [x1, #0x4]
               	ldr	w4, [x20]
               	mov	w2, w2
               	eor	x2, x4, x2
               	str	w2, [x20]
               	ldr	w2, [x20, #0x4]
               	mov	w3, w3
               	eor	x2, x2, x3
               	str	w2, [x20, #0x4]
               	ldr	w2, [x23]
               	ldr	w3, [x23, #0x4]
               	ldr	w4, [x0]
               	mov	w2, w2
               	eor	x2, x4, x2
               	str	w2, [x0]
               	ldr	w2, [x0, #0x4]
               	mov	w3, w3
               	eor	x2, x2, x3
               	str	w2, [x0, #0x4]
               	ldr	w0, [x1]
               	ldr	w2, [x1, #0x4]
               	mov	w3, w0
               	lsr	x7, x3, #19
               	mov	w4, w2
               	lsl	x8, x4, #13
               	mov	w8, w8
               	orr	x7, x7, x8
               	lsl	x0, x3, #13
               	mov	w0, w0
               	lsr	x2, x4, #19
               	orr	x0, x0, x2
               	mov	w2, w7
               	mov	w3, w0
               	sub	x0, x29, #0x68
               	mov	w2, w2
               	mov	w3, w3
               	str	w2, [x0]
               	str	w3, [x0, #0x4]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x20, x29, #0x30
               	add	x21, x20, #0x8
               	mov	x0, x21
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x88
               	str	x0, [x16]
               	sub	x0, x29, #0x88
               	ldr	w1, [x0]
               	ldr	w0, [x0, #0x4]
               	mov	w2, w1
               	lsl	x3, x2, #7
               	mov	w4, w3
               	mov	w3, w0
               	lsr	x5, x3, #25
               	orr	x4, x4, x5
               	lsr	x1, x2, #25
               	lsl	x0, x3, #7
               	mov	w0, w0
               	orr	x0, x1, x0
               	mov	w1, w4
               	mov	w2, w0
               	sub	x0, x29, #0x80
               	mov	w1, w1
               	mov	w2, w2
               	str	w1, [x0]
               	str	w2, [x0, #0x4]
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x78
               	str	x0, [x16]
               	ldr	w1, [x21]
               	ldr	w0, [x21, #0x4]
               	mov	w1, w1
               	lsl	x1, x1, #17
               	mov	w2, w1
               	mov	w1, w0
               	lsr	x3, x1, #15
               	orr	x2, x2, x3
               	lsl	x0, x1, #17
               	mov	w0, w0
               	mov	w1, w2
               	mov	w2, w0
               	sub	x22, x29, #0x70
               	mov	w0, w1
               	mov	w1, w2
               	str	w0, [x22]
               	str	w1, [x22, #0x4]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x22]
               	str	x10, [x23]
               	ldr	x10, [sp], #0x10
               	mov	x0, x23
               	add	x0, x20, #0x10
               	ldr	w1, [x20]
               	ldr	w2, [x20, #0x4]
               	ldr	w3, [x0]
               	mov	w1, w1
               	eor	x1, x3, x1
               	str	w1, [x0]
               	ldr	w1, [x0, #0x4]
               	mov	w2, w2
               	eor	x1, x1, x2
               	str	w1, [x0, #0x4]
               	add	x1, x20, #0x18
               	ldr	w2, [x21]
               	ldr	w3, [x21, #0x4]
               	ldr	w4, [x1]
               	mov	w2, w2
               	eor	x2, x4, x2
               	str	w2, [x1]
               	ldr	w2, [x1, #0x4]
               	mov	w3, w3
               	eor	x2, x2, x3
               	str	w2, [x1, #0x4]
               	ldr	w2, [x0]
               	ldr	w3, [x0, #0x4]
               	ldr	w4, [x21]
               	mov	w2, w2
               	eor	x2, x4, x2
               	str	w2, [x21]
               	ldr	w2, [x21, #0x4]
               	mov	w3, w3
               	eor	x2, x2, x3
               	str	w2, [x21, #0x4]
               	ldr	w2, [x1]
               	ldr	w3, [x1, #0x4]
               	ldr	w4, [x20]
               	mov	w2, w2
               	eor	x2, x4, x2
               	str	w2, [x20]
               	ldr	w2, [x20, #0x4]
               	mov	w3, w3
               	eor	x2, x2, x3
               	str	w2, [x20, #0x4]
               	sub	x2, x29, #0x90
               	ldr	w3, [x2]
               	ldr	w2, [x2, #0x4]
               	ldr	w4, [x0]
               	mov	w3, w3
               	eor	x3, x4, x3
               	str	w3, [x0]
               	ldr	w3, [x0, #0x4]
               	mov	w2, w2
               	eor	x2, x3, x2
               	str	w2, [x0, #0x4]
               	ldr	w0, [x1]
               	ldr	w2, [x1, #0x4]
               	mov	w3, w0
               	lsr	x7, x3, #19
               	mov	w4, w2
               	lsl	x8, x4, #13
               	mov	w8, w8
               	orr	x7, x7, x8
               	lsl	x0, x3, #13
               	mov	w0, w0
               	lsr	x2, x4, #19
               	orr	x0, x0, x2
               	mov	w2, w7
               	mov	w3, w0
               	sub	x0, x29, #0x68
               	mov	w2, w2
               	mov	w3, w3
               	str	w2, [x0]
               	str	w3, [x0, #0x4]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x20, x29, #0x30
               	add	x21, x20, #0x8
               	mov	x0, x21
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x88
               	str	x0, [x16]
               	sub	x0, x29, #0x88
               	ldr	w1, [x0]
               	ldr	w0, [x0, #0x4]
               	mov	w2, w1
               	lsl	x3, x2, #7
               	mov	w4, w3
               	mov	w3, w0
               	lsr	x5, x3, #25
               	orr	x4, x4, x5
               	lsr	x1, x2, #25
               	lsl	x0, x3, #7
               	mov	w0, w0
               	orr	x0, x1, x0
               	mov	w1, w4
               	mov	w2, w0
               	sub	x0, x29, #0x80
               	mov	w1, w1
               	mov	w2, w2
               	str	w1, [x0]
               	str	w2, [x0, #0x4]
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x78
               	str	x0, [x16]
               	ldr	w1, [x21]
               	ldr	w0, [x21, #0x4]
               	mov	w1, w1
               	lsl	x1, x1, #17
               	mov	w2, w1
               	mov	w1, w0
               	lsr	x3, x1, #15
               	orr	x2, x2, x3
               	lsl	x0, x1, #17
               	mov	w0, w0
               	mov	w1, w2
               	mov	w2, w0
               	mov	w0, w1
               	mov	w1, w2
               	str	w0, [x22]
               	str	w1, [x22, #0x4]
               	sub	x23, x29, #0x90
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x22]
               	str	x10, [x23]
               	ldr	x10, [sp], #0x10
               	mov	x0, x23
               	add	x0, x20, #0x10
               	ldr	w1, [x20]
               	ldr	w2, [x20, #0x4]
               	ldr	w3, [x0]
               	mov	w1, w1
               	eor	x1, x3, x1
               	str	w1, [x0]
               	ldr	w1, [x0, #0x4]
               	mov	w2, w2
               	eor	x1, x1, x2
               	str	w1, [x0, #0x4]
               	add	x1, x20, #0x18
               	ldr	w2, [x21]
               	ldr	w3, [x21, #0x4]
               	ldr	w4, [x1]
               	mov	w2, w2
               	eor	x2, x4, x2
               	str	w2, [x1]
               	ldr	w2, [x1, #0x4]
               	mov	w3, w3
               	eor	x2, x2, x3
               	str	w2, [x1, #0x4]
               	ldr	w2, [x0]
               	ldr	w3, [x0, #0x4]
               	ldr	w4, [x21]
               	mov	w2, w2
               	eor	x2, x4, x2
               	str	w2, [x21]
               	ldr	w2, [x21, #0x4]
               	mov	w3, w3
               	eor	x2, x2, x3
               	str	w2, [x21, #0x4]
               	ldr	w2, [x1]
               	ldr	w3, [x1, #0x4]
               	ldr	w4, [x20]
               	mov	w2, w2
               	eor	x2, x4, x2
               	str	w2, [x20]
               	ldr	w2, [x20, #0x4]
               	mov	w3, w3
               	eor	x2, x2, x3
               	str	w2, [x20, #0x4]
               	ldr	w2, [x23]
               	ldr	w3, [x23, #0x4]
               	ldr	w4, [x0]
               	mov	w2, w2
               	eor	x2, x4, x2
               	str	w2, [x0]
               	ldr	w2, [x0, #0x4]
               	mov	w3, w3
               	eor	x2, x2, x3
               	str	w2, [x0, #0x4]
               	ldr	w0, [x1]
               	ldr	w2, [x1, #0x4]
               	mov	w3, w0
               	lsr	x7, x3, #19
               	mov	w4, w2
               	lsl	x8, x4, #13
               	mov	w8, w8
               	orr	x7, x7, x8
               	lsl	x0, x3, #13
               	mov	w0, w0
               	lsr	x2, x4, #19
               	orr	x0, x0, x2
               	mov	w2, w7
               	mov	w3, w0
               	sub	x0, x29, #0x68
               	mov	w2, w2
               	mov	w3, w3
               	str	w2, [x0]
               	str	w3, [x0, #0x4]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x20, x29, #0x30
               	add	x21, x20, #0x8
               	mov	x0, x21
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x88
               	str	x0, [x16]
               	sub	x0, x29, #0x88
               	ldr	w1, [x0]
               	ldr	w0, [x0, #0x4]
               	mov	w2, w1
               	lsl	x3, x2, #7
               	mov	w4, w3
               	mov	w3, w0
               	lsr	x5, x3, #25
               	orr	x4, x4, x5
               	lsr	x1, x2, #25
               	lsl	x0, x3, #7
               	mov	w0, w0
               	orr	x0, x1, x0
               	mov	w1, w4
               	mov	w2, w0
               	sub	x0, x29, #0x80
               	mov	w1, w1
               	mov	w2, w2
               	str	w1, [x0]
               	str	w2, [x0, #0x4]
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x78
               	str	x0, [x16]
               	ldr	w1, [x21]
               	ldr	w0, [x21, #0x4]
               	mov	w1, w1
               	lsl	x1, x1, #17
               	mov	w2, w1
               	mov	w1, w0
               	lsr	x3, x1, #15
               	orr	x2, x2, x3
               	lsl	x0, x1, #17
               	mov	w0, w0
               	mov	w1, w2
               	mov	w2, w0
               	sub	x22, x29, #0x70
               	mov	w0, w1
               	mov	w1, w2
               	str	w0, [x22]
               	str	w1, [x22, #0x4]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x22]
               	str	x10, [x23]
               	ldr	x10, [sp], #0x10
               	mov	x0, x23
               	add	x0, x20, #0x10
               	ldr	w1, [x20]
               	ldr	w2, [x20, #0x4]
               	ldr	w3, [x0]
               	mov	w1, w1
               	eor	x1, x3, x1
               	str	w1, [x0]
               	ldr	w1, [x0, #0x4]
               	mov	w2, w2
               	eor	x1, x1, x2
               	str	w1, [x0, #0x4]
               	add	x1, x20, #0x18
               	ldr	w2, [x21]
               	ldr	w3, [x21, #0x4]
               	ldr	w4, [x1]
               	mov	w2, w2
               	eor	x2, x4, x2
               	str	w2, [x1]
               	ldr	w2, [x1, #0x4]
               	mov	w3, w3
               	eor	x2, x2, x3
               	str	w2, [x1, #0x4]
               	ldr	w2, [x0]
               	ldr	w3, [x0, #0x4]
               	ldr	w4, [x21]
               	mov	w2, w2
               	eor	x2, x4, x2
               	str	w2, [x21]
               	ldr	w2, [x21, #0x4]
               	mov	w3, w3
               	eor	x2, x2, x3
               	str	w2, [x21, #0x4]
               	ldr	w2, [x1]
               	ldr	w3, [x1, #0x4]
               	ldr	w4, [x20]
               	mov	w2, w2
               	eor	x2, x4, x2
               	str	w2, [x20]
               	ldr	w2, [x20, #0x4]
               	mov	w3, w3
               	eor	x2, x2, x3
               	str	w2, [x20, #0x4]
               	sub	x2, x29, #0x90
               	ldr	w3, [x2]
               	ldr	w2, [x2, #0x4]
               	ldr	w4, [x0]
               	mov	w3, w3
               	eor	x3, x4, x3
               	str	w3, [x0]
               	ldr	w3, [x0, #0x4]
               	mov	w2, w2
               	eor	x2, x3, x2
               	str	w2, [x0, #0x4]
               	ldr	w0, [x1]
               	ldr	w2, [x1, #0x4]
               	mov	w3, w0
               	lsr	x7, x3, #19
               	mov	w4, w2
               	lsl	x8, x4, #13
               	mov	w8, w8
               	orr	x7, x7, x8
               	lsl	x0, x3, #13
               	mov	w0, w0
               	lsr	x2, x4, #19
               	orr	x0, x0, x2
               	mov	w2, w7
               	mov	w3, w0
               	sub	x0, x29, #0x68
               	mov	w2, w2
               	mov	w3, w3
               	str	w2, [x0]
               	str	w3, [x0, #0x4]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x20, x29, #0x30
               	add	x21, x20, #0x8
               	mov	x0, x21
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x88
               	str	x0, [x16]
               	sub	x0, x29, #0x88
               	ldr	w1, [x0]
               	ldr	w0, [x0, #0x4]
               	mov	w2, w1
               	lsl	x3, x2, #7
               	mov	w4, w3
               	mov	w3, w0
               	lsr	x5, x3, #25
               	orr	x4, x4, x5
               	lsr	x1, x2, #25
               	lsl	x0, x3, #7
               	mov	w0, w0
               	orr	x0, x1, x0
               	mov	w1, w4
               	mov	w2, w0
               	sub	x0, x29, #0x80
               	mov	w1, w1
               	mov	w2, w2
               	str	w1, [x0]
               	str	w2, [x0, #0x4]
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x78
               	str	x0, [x16]
               	ldr	w1, [x21]
               	ldr	w0, [x21, #0x4]
               	mov	w1, w1
               	lsl	x1, x1, #17
               	mov	w2, w1
               	mov	w1, w0
               	lsr	x3, x1, #15
               	orr	x2, x2, x3
               	lsl	x0, x1, #17
               	mov	w0, w0
               	mov	w1, w2
               	mov	w2, w0
               	mov	w0, w1
               	mov	w1, w2
               	str	w0, [x22]
               	str	w1, [x22, #0x4]
               	sub	x23, x29, #0x90
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x22]
               	str	x10, [x23]
               	ldr	x10, [sp], #0x10
               	mov	x0, x23
               	add	x0, x20, #0x10
               	ldr	w1, [x20]
               	ldr	w2, [x20, #0x4]
               	ldr	w3, [x0]
               	mov	w1, w1
               	eor	x1, x3, x1
               	str	w1, [x0]
               	ldr	w1, [x0, #0x4]
               	mov	w2, w2
               	eor	x1, x1, x2
               	str	w1, [x0, #0x4]
               	add	x1, x20, #0x18
               	ldr	w2, [x21]
               	ldr	w3, [x21, #0x4]
               	ldr	w4, [x1]
               	mov	w2, w2
               	eor	x2, x4, x2
               	str	w2, [x1]
               	ldr	w2, [x1, #0x4]
               	mov	w3, w3
               	eor	x2, x2, x3
               	str	w2, [x1, #0x4]
               	ldr	w2, [x0]
               	ldr	w3, [x0, #0x4]
               	ldr	w4, [x21]
               	mov	w2, w2
               	eor	x2, x4, x2
               	str	w2, [x21]
               	ldr	w2, [x21, #0x4]
               	mov	w3, w3
               	eor	x2, x2, x3
               	str	w2, [x21, #0x4]
               	ldr	w2, [x1]
               	ldr	w3, [x1, #0x4]
               	ldr	w4, [x20]
               	mov	w2, w2
               	eor	x2, x4, x2
               	str	w2, [x20]
               	ldr	w2, [x20, #0x4]
               	mov	w3, w3
               	eor	x2, x2, x3
               	str	w2, [x20, #0x4]
               	ldr	w2, [x23]
               	ldr	w3, [x23, #0x4]
               	ldr	w4, [x0]
               	mov	w2, w2
               	eor	x2, x4, x2
               	str	w2, [x0]
               	ldr	w2, [x0, #0x4]
               	mov	w3, w3
               	eor	x2, x2, x3
               	str	w2, [x0, #0x4]
               	ldr	w0, [x1]
               	ldr	w2, [x1, #0x4]
               	mov	w3, w0
               	lsr	x7, x3, #19
               	mov	w4, w2
               	lsl	x8, x4, #13
               	mov	w8, w8
               	orr	x7, x7, x8
               	lsl	x0, x3, #13
               	mov	w0, w0
               	lsr	x2, x4, #19
               	orr	x0, x0, x2
               	mov	w2, w7
               	mov	w3, w0
               	sub	x0, x29, #0x68
               	mov	w2, w2
               	mov	w3, w3
               	str	w2, [x0]
               	str	w3, [x0, #0x4]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x20, x29, #0x30
               	add	x21, x20, #0x8
               	mov	x0, x21
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x88
               	str	x0, [x16]
               	sub	x0, x29, #0x88
               	ldr	w1, [x0]
               	ldr	w0, [x0, #0x4]
               	mov	w2, w1
               	lsl	x3, x2, #7
               	mov	w4, w3
               	mov	w3, w0
               	lsr	x5, x3, #25
               	orr	x4, x4, x5
               	lsr	x1, x2, #25
               	lsl	x0, x3, #7
               	mov	w0, w0
               	orr	x0, x1, x0
               	mov	w1, w4
               	mov	w2, w0
               	sub	x0, x29, #0x80
               	mov	w1, w1
               	mov	w2, w2
               	str	w1, [x0]
               	str	w2, [x0, #0x4]
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x78
               	str	x0, [x16]
               	ldr	w1, [x21]
               	ldr	w0, [x21, #0x4]
               	mov	w1, w1
               	lsl	x1, x1, #17
               	mov	w2, w1
               	mov	w1, w0
               	lsr	x3, x1, #15
               	orr	x2, x2, x3
               	lsl	x0, x1, #17
               	mov	w0, w0
               	mov	w1, w2
               	mov	w2, w0
               	sub	x0, x29, #0x70
               	mov	w1, w1
               	mov	w2, w2
               	str	w1, [x0]
               	str	w2, [x0, #0x4]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x23]
               	ldr	x10, [sp], #0x10
               	mov	x0, x23
               	add	x22, x20, #0x10
               	mov	x0, x22
               	mov	x1, x20
               	ldr	x1, [x1]
               	bl	<addr>
               	add	x23, x20, #0x18
               	mov	x0, x23
               	mov	x1, x21
               	ldr	x1, [x1]
               	bl	<addr>
               	mov	x0, x21
               	mov	x1, x22
               	ldr	x1, [x1]
               	bl	<addr>
               	mov	x0, x20
               	mov	x1, x23
               	ldr	x1, [x1]
               	bl	<addr>
               	sub	x23, x29, #0x90
               	mov	x0, x22
               	mov	x1, x23
               	ldr	x1, [x1]
               	bl	<addr>
               	add	x20, x20, #0x18
               	mov	x1, #0x2d               // =45
               	mov	x0, x20
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x68
               	str	x0, [x16]
               	sub	x0, x29, #0x68
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x20]
               	ldr	x10, [sp], #0x10
               	mov	x0, x20
               	sub	x20, x29, #0x30
               	add	x21, x20, #0x8
               	mov	x0, x21
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x88
               	str	x0, [x16]
               	sub	x0, x29, #0x88
               	mov	x1, #0x7                // =7
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x80
               	str	x0, [x16]
               	sub	x0, x29, #0x80
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x78
               	str	x0, [x16]
               	mov	x1, #0x11               // =17
               	mov	x0, x21
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x70
               	str	x0, [x16]
               	sub	x0, x29, #0x70
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x23]
               	ldr	x10, [sp], #0x10
               	mov	x0, x23
               	add	x22, x20, #0x10
               	mov	x0, x22
               	mov	x1, x20
               	ldr	x1, [x1]
               	bl	<addr>
               	add	x23, x20, #0x18
               	mov	x0, x23
               	mov	x1, x21
               	ldr	x1, [x1]
               	bl	<addr>
               	mov	x0, x21
               	mov	x1, x22
               	ldr	x1, [x1]
               	bl	<addr>
               	mov	x0, x20
               	mov	x1, x23
               	ldr	x1, [x1]
               	bl	<addr>
               	sub	x23, x29, #0x90
               	mov	x0, x22
               	mov	x1, x23
               	ldr	x1, [x1]
               	bl	<addr>
               	add	x20, x20, #0x18
               	mov	x1, #0x2d               // =45
               	mov	x0, x20
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x68
               	str	x0, [x16]
               	sub	x0, x29, #0x68
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x20]
               	ldr	x10, [sp], #0x10
               	mov	x0, x20
               	sub	x20, x29, #0x30
               	add	x21, x20, #0x8
               	mov	x0, x21
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x88
               	str	x0, [x16]
               	sub	x0, x29, #0x88
               	mov	x1, #0x7                // =7
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x80
               	str	x0, [x16]
               	sub	x0, x29, #0x80
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x78
               	str	x0, [x16]
               	mov	x1, #0x11               // =17
               	mov	x0, x21
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x70
               	str	x0, [x16]
               	sub	x0, x29, #0x70
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x23]
               	ldr	x10, [sp], #0x10
               	mov	x0, x23
               	add	x22, x20, #0x10
               	mov	x0, x22
               	mov	x1, x20
               	ldr	x1, [x1]
               	bl	<addr>
               	add	x23, x20, #0x18
               	mov	x0, x23
               	mov	x1, x21
               	ldr	x1, [x1]
               	bl	<addr>
               	mov	x0, x21
               	mov	x1, x22
               	ldr	x1, [x1]
               	bl	<addr>
               	mov	x0, x20
               	mov	x1, x23
               	ldr	x1, [x1]
               	bl	<addr>
               	sub	x23, x29, #0x90
               	mov	x0, x22
               	mov	x1, x23
               	ldr	x1, [x1]
               	bl	<addr>
               	add	x20, x20, #0x18
               	mov	x1, #0x2d               // =45
               	mov	x0, x20
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x68
               	str	x0, [x16]
               	sub	x0, x29, #0x68
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x20]
               	ldr	x10, [sp], #0x10
               	mov	x0, x20
               	sub	x20, x29, #0x30
               	add	x21, x20, #0x8
               	mov	x0, x21
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x88
               	str	x0, [x16]
               	sub	x0, x29, #0x88
               	mov	x1, #0x7                // =7
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x80
               	str	x0, [x16]
               	sub	x0, x29, #0x80
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x78
               	str	x0, [x16]
               	mov	x1, #0x11               // =17
               	mov	x0, x21
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x70
               	str	x0, [x16]
               	sub	x0, x29, #0x70
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x23]
               	ldr	x10, [sp], #0x10
               	mov	x0, x23
               	add	x22, x20, #0x10
               	mov	x0, x22
               	mov	x1, x20
               	ldr	x1, [x1]
               	bl	<addr>
               	add	x23, x20, #0x18
               	mov	x0, x23
               	mov	x1, x21
               	ldr	x1, [x1]
               	bl	<addr>
               	mov	x0, x21
               	mov	x1, x22
               	ldr	x1, [x1]
               	bl	<addr>
               	mov	x0, x20
               	mov	x1, x23
               	ldr	x1, [x1]
               	bl	<addr>
               	sub	x23, x29, #0x90
               	mov	x0, x22
               	mov	x1, x23
               	ldr	x1, [x1]
               	bl	<addr>
               	add	x20, x20, #0x18
               	mov	x1, #0x2d               // =45
               	mov	x0, x20
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x68
               	str	x0, [x16]
               	sub	x0, x29, #0x68
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x20]
               	ldr	x10, [sp], #0x10
               	mov	x0, x20
               	sub	x20, x29, #0x30
               	add	x21, x20, #0x8
               	mov	x0, x21
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x88
               	str	x0, [x16]
               	sub	x0, x29, #0x88
               	mov	x1, #0x7                // =7
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x80
               	str	x0, [x16]
               	sub	x0, x29, #0x80
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x78
               	str	x0, [x16]
               	sub	x0, x29, #0x78
               	ldr	w24, [x0]
               	ldr	w25, [x0, #0x4]
               	mov	x1, #0x11               // =17
               	mov	x0, x21
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x70
               	str	x0, [x16]
               	sub	x0, x29, #0x70
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x23]
               	ldr	x10, [sp], #0x10
               	mov	x0, x23
               	add	x22, x20, #0x10
               	mov	x0, x22
               	mov	x1, x20
               	ldr	x1, [x1]
               	bl	<addr>
               	add	x23, x20, #0x18
               	mov	x0, x23
               	mov	x1, x21
               	ldr	x1, [x1]
               	bl	<addr>
               	mov	x0, x21
               	mov	x1, x22
               	ldr	x1, [x1]
               	bl	<addr>
               	mov	x0, x20
               	mov	x1, x23
               	ldr	x1, [x1]
               	bl	<addr>
               	sub	x1, x29, #0x90
               	mov	x0, x22
               	ldr	x1, [x1]
               	bl	<addr>
               	add	x20, x20, #0x18
               	mov	x1, #0x2d               // =45
               	mov	x0, x20
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x68
               	str	x0, [x16]
               	sub	x0, x29, #0x68
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x20]
               	ldr	x10, [sp], #0x10
               	mov	x0, x20
               	mov	w0, w24
               	mov	w1, w25
               	mov	w0, w0
               	lsl	x0, x0, #31
               	lsl	x0, x0, #1
               	mov	w1, w1
               	orr	x0, x0, x1
               	mov	x17, #0xc9d6            // =51670
               	movk	x17, #0xa323, lsl #16
               	movk	x17, #0x40a5, lsl #32
               	movk	x17, #0x7a70, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0xc0]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xd0
               	ret
               	sub	x0, x29, #0x30
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
               	ldp	x29, x30, [sp, #0xc0]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xd0
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
               	ldp	x29, x30, [sp, #0xc0]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xd0
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0xc0]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xd0
               	ret
