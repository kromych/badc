
inline_local_array_callee.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x1, x29, #0x18
               	str	w0, [x1]
               	sub	x2, x29, #0x18
               	add	x1, x0, #0x1
               	str	w1, [x2, #0x4]
               	sub	x2, x29, #0x18
               	lsl	x1, x0, #1
               	str	w1, [x2, #0x8]
               	sub	x1, x29, #0x18
               	sub	x0, x0, #0x1
               	str	w0, [x1, #0xc]
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x0
               	ldrsw	x1, [x0]
               	sub	x0, x29, #0x18
               	ldrsw	x0, [x0, #0x8]
               	sub	x0, x1, x0
               	sxtw	x0, w0
               	sub	x1, x29, #0x18
               	add	x1, x1, #0x0
               	ldrsw	x1, [x1]
               	mov	x17, #0x64              // =100
               	mul	x0, x0, x17
               	add	x0, x0, x1
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<f2>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x1, x29, #0x18
               	str	w0, [x1]
               	sub	x2, x29, #0x18
               	add	x1, x0, #0x1
               	str	w1, [x2, #0x4]
               	sub	x2, x29, #0x18
               	lsl	x1, x0, #1
               	str	w1, [x2, #0x8]
               	sub	x1, x29, #0x18
               	sub	x0, x0, #0x1
               	str	w0, [x1, #0xc]
               	sub	x0, x29, #0x18
               	ldrsw	x1, [x0, #0x4]
               	sub	x0, x29, #0x18
               	ldrsw	x0, [x0, #0x8]
               	add	x0, x1, x0
               	sxtw	x0, w0
               	sub	x1, x29, #0x18
               	ldrsw	x1, [x1, #0x4]
               	mov	x17, #0x64              // =100
               	mul	x0, x0, x17
               	add	x0, x0, x1
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<f3>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x1, x29, #0x18
               	str	w0, [x1]
               	sub	x2, x29, #0x18
               	add	x1, x0, #0x1
               	str	w1, [x2, #0x4]
               	sub	x2, x29, #0x18
               	lsl	x1, x0, #1
               	str	w1, [x2, #0x8]
               	sub	x1, x29, #0x18
               	sub	x0, x0, #0x1
               	str	w0, [x1, #0xc]
               	sub	x0, x29, #0x18
               	ldrsw	x0, [x0, #0x4]
               	lsl	x0, x0, #1
               	sxtw	x0, w0
               	sub	x1, x29, #0x18
               	ldrsw	x1, [x1, #0x4]
               	mov	x17, #0x64              // =100
               	mul	x0, x0, x17
               	add	x0, x0, x1
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	mov	x0, #0xa                // =10
               	bl	<addr>
               	mov	x17, #0xfc22            // =64546
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa                // =10
               	bl	<addr>
               	cmp	x0, #0xc27
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa                // =10
               	bl	<addr>
               	cmp	x0, #0x8a3
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	sub	x2, x29, #0x18
               	str	w0, [x2]
               	sub	x0, x29, #0x18
               	mov	x2, #0x4                // =4
               	str	w2, [x0, #0x4]
               	sub	x0, x29, #0x18
               	mov	x2, #0x6                // =6
               	str	w2, [x0, #0x8]
               	sub	x0, x29, #0x18
               	mov	x2, #0x2                // =2
               	str	w2, [x0, #0xc]
               	sub	x0, x29, #0x18
               	ldrsw	x2, [x0, #0x4]
               	sub	x0, x29, #0x18
               	ldrsw	x0, [x0, #0xc]
               	sub	x0, x2, x0
               	sxtw	x0, w0
               	sxtw	x3, w0
               	sub	x0, x29, #0x18
               	ldrsw	x1, [x0, #0x4]
               	mov	x0, #0x8                // =8
               	sub	x4, x29, #0x18
               	str	w0, [x4]
               	sub	x0, x29, #0x18
               	mov	x4, #0x9                // =9
               	str	w4, [x0, #0x4]
               	sub	x0, x29, #0x18
               	mov	x4, #0x10               // =16
               	str	w4, [x0, #0x8]
               	sub	x0, x29, #0x18
               	mov	x4, #0x7                // =7
               	str	w4, [x0, #0xc]
               	sub	x0, x29, #0x18
               	ldrsw	x4, [x0, #0x8]
               	sub	x0, x29, #0x18
               	ldrsw	x0, [x0, #0xc]
               	add	x0, x4, x0
               	sxtw	x0, w0
               	sxtw	x4, w0
               	sub	x0, x29, #0x18
               	ldrsw	x2, [x0, #0x8]
               	sxtw	x0, w3
               	cmp	x0, #0x2
               	cset	x0, ne
               	cbnz	x0, <addr>
               	cmp	x1, #0x4
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x0, w4
               	cmp	x0, #0x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	cmp	x2, #0x10
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x0                // =0
               	mov	x0, #0xfffc             // =65532
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	b	<addr>
               	sub	x1, x29, #0x18
               	str	w0, [x1]
               	sub	x4, x29, #0x18
               	add	x1, x0, #0x1
               	str	w1, [x4, #0x4]
               	sub	x4, x29, #0x18
               	lsl	x1, x0, #1
               	str	w1, [x4, #0x8]
               	sub	x4, x29, #0x18
               	sub	x1, x0, #0x1
               	str	w1, [x4, #0xc]
               	sub	x1, x29, #0x18
               	add	x1, x1, #0x0
               	ldrsw	x4, [x1]
               	sub	x1, x29, #0x18
               	ldrsw	x1, [x1, #0x8]
               	sub	x1, x4, x1
               	sxtw	x1, w1
               	sub	x4, x29, #0x18
               	add	x4, x4, #0x0
               	ldrsw	x4, [x4]
               	mov	x17, #0x4243            // =16963
               	movk	x17, #0xf, lsl #16
               	mul	x2, x2, x17
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	add	x1, x1, x4
               	sxtw	x1, w1
               	mov	w1, w1
               	add	x4, x2, x1
               	sub	x1, x29, #0x18
               	str	w0, [x1]
               	sub	x2, x29, #0x18
               	add	x1, x0, #0x1
               	str	w1, [x2, #0x4]
               	sub	x2, x29, #0x18
               	lsl	x1, x0, #1
               	str	w1, [x2, #0x8]
               	sub	x2, x29, #0x18
               	sub	x1, x0, #0x1
               	str	w1, [x2, #0xc]
               	sub	x1, x29, #0x18
               	ldrsw	x2, [x1, #0x4]
               	sub	x1, x29, #0x18
               	ldrsw	x1, [x1, #0xc]
               	sub	x1, x2, x1
               	sxtw	x1, w1
               	sub	x2, x29, #0x18
               	ldrsw	x2, [x2, #0x4]
               	mov	x17, #0x4243            // =16963
               	movk	x17, #0xf, lsl #16
               	mul	x4, x4, x17
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	add	x1, x1, x2
               	sxtw	x1, w1
               	mov	w1, w1
               	add	x4, x4, x1
               	sub	x1, x29, #0x18
               	str	w0, [x1]
               	sub	x2, x29, #0x18
               	add	x1, x0, #0x1
               	str	w1, [x2, #0x4]
               	sub	x2, x29, #0x18
               	lsl	x1, x0, #1
               	str	w1, [x2, #0x8]
               	sub	x2, x29, #0x18
               	sub	x1, x0, #0x1
               	str	w1, [x2, #0xc]
               	sub	x1, x29, #0x18
               	ldrsw	x1, [x1, #0x8]
               	sub	x2, x29, #0x18
               	add	x2, x2, #0x0
               	ldrsw	x2, [x2]
               	sub	x1, x1, x2
               	sxtw	x1, w1
               	sub	x2, x29, #0x18
               	ldrsw	x2, [x2, #0x8]
               	mov	x17, #0x4243            // =16963
               	movk	x17, #0xf, lsl #16
               	mul	x4, x4, x17
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	add	x1, x1, x2
               	sxtw	x1, w1
               	mov	w1, w1
               	add	x4, x4, x1
               	sub	x1, x29, #0x18
               	str	w0, [x1]
               	sub	x2, x29, #0x18
               	add	x1, x0, #0x1
               	str	w1, [x2, #0x4]
               	sub	x2, x29, #0x18
               	lsl	x1, x0, #1
               	str	w1, [x2, #0x8]
               	sub	x2, x29, #0x18
               	sub	x1, x0, #0x1
               	str	w1, [x2, #0xc]
               	sub	x1, x29, #0x18
               	ldrsw	x2, [x1, #0xc]
               	sub	x1, x29, #0x18
               	ldrsw	x1, [x1, #0x4]
               	sub	x1, x2, x1
               	sxtw	x1, w1
               	sub	x2, x29, #0x18
               	ldrsw	x2, [x2, #0xc]
               	mov	x17, #0x4243            // =16963
               	movk	x17, #0xf, lsl #16
               	mul	x4, x4, x17
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	add	x1, x1, x2
               	sxtw	x1, w1
               	mov	w1, w1
               	add	x4, x4, x1
               	sub	x1, x29, #0x18
               	str	w0, [x1]
               	sub	x2, x29, #0x18
               	add	x1, x0, #0x1
               	str	w1, [x2, #0x4]
               	sub	x2, x29, #0x18
               	lsl	x1, x0, #1
               	str	w1, [x2, #0x8]
               	sub	x2, x29, #0x18
               	sub	x1, x0, #0x1
               	str	w1, [x2, #0xc]
               	sub	x1, x29, #0x18
               	add	x1, x1, #0x0
               	ldrsw	x2, [x1]
               	sub	x1, x29, #0x18
               	ldrsw	x1, [x1, #0x4]
               	add	x1, x2, x1
               	sxtw	x1, w1
               	sub	x2, x29, #0x18
               	add	x2, x2, #0x0
               	ldrsw	x2, [x2]
               	mov	x17, #0x4243            // =16963
               	movk	x17, #0xf, lsl #16
               	mul	x4, x4, x17
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	add	x1, x1, x2
               	sxtw	x1, w1
               	mov	w1, w1
               	add	x4, x4, x1
               	sub	x1, x29, #0x18
               	str	w0, [x1]
               	sub	x2, x29, #0x18
               	add	x1, x0, #0x1
               	str	w1, [x2, #0x4]
               	sub	x2, x29, #0x18
               	lsl	x1, x0, #1
               	str	w1, [x2, #0x8]
               	sub	x2, x29, #0x18
               	sub	x1, x0, #0x1
               	str	w1, [x2, #0xc]
               	sub	x1, x29, #0x18
               	ldrsw	x2, [x1, #0x4]
               	sub	x1, x29, #0x18
               	ldrsw	x1, [x1, #0x8]
               	add	x1, x2, x1
               	sxtw	x1, w1
               	sub	x2, x29, #0x18
               	ldrsw	x2, [x2, #0x4]
               	mov	x17, #0x4243            // =16963
               	movk	x17, #0xf, lsl #16
               	mul	x4, x4, x17
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	add	x1, x1, x2
               	sxtw	x1, w1
               	mov	w1, w1
               	add	x4, x4, x1
               	sub	x1, x29, #0x18
               	str	w0, [x1]
               	sub	x2, x29, #0x18
               	add	x1, x0, #0x1
               	str	w1, [x2, #0x4]
               	sub	x2, x29, #0x18
               	lsl	x1, x0, #1
               	str	w1, [x2, #0x8]
               	sub	x2, x29, #0x18
               	sub	x1, x0, #0x1
               	str	w1, [x2, #0xc]
               	sub	x1, x29, #0x18
               	ldrsw	x2, [x1, #0x8]
               	sub	x1, x29, #0x18
               	ldrsw	x1, [x1, #0xc]
               	add	x1, x2, x1
               	sxtw	x1, w1
               	sub	x2, x29, #0x18
               	ldrsw	x2, [x2, #0x8]
               	mov	x17, #0x4243            // =16963
               	movk	x17, #0xf, lsl #16
               	mul	x4, x4, x17
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	add	x1, x1, x2
               	sxtw	x1, w1
               	mov	w1, w1
               	add	x4, x4, x1
               	sub	x1, x29, #0x18
               	str	w0, [x1]
               	sub	x2, x29, #0x18
               	add	x1, x0, #0x1
               	str	w1, [x2, #0x4]
               	sub	x2, x29, #0x18
               	lsl	x1, x0, #1
               	str	w1, [x2, #0x8]
               	sub	x2, x29, #0x18
               	sub	x1, x0, #0x1
               	str	w1, [x2, #0xc]
               	sub	x1, x29, #0x18
               	ldrsw	x1, [x1, #0xc]
               	sub	x2, x29, #0x18
               	add	x2, x2, #0x0
               	ldrsw	x2, [x2]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	sub	x2, x29, #0x18
               	ldrsw	x2, [x2, #0xc]
               	mov	x17, #0x4243            // =16963
               	movk	x17, #0xf, lsl #16
               	mul	x4, x4, x17
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	add	x1, x1, x2
               	sxtw	x1, w1
               	mov	w1, w1
               	add	x4, x4, x1
               	sub	x1, x29, #0x18
               	str	w0, [x1]
               	sub	x2, x29, #0x18
               	add	x1, x0, #0x1
               	str	w1, [x2, #0x4]
               	sub	x2, x29, #0x18
               	lsl	x1, x0, #1
               	str	w1, [x2, #0x8]
               	sub	x2, x29, #0x18
               	sub	x1, x0, #0x1
               	str	w1, [x2, #0xc]
               	sub	x1, x29, #0x18
               	add	x1, x1, #0x0
               	ldrsw	x1, [x1]
               	lsl	x1, x1, #1
               	sxtw	x1, w1
               	sub	x2, x29, #0x18
               	add	x2, x2, #0x0
               	ldrsw	x2, [x2]
               	mov	x17, #0x4243            // =16963
               	movk	x17, #0xf, lsl #16
               	mul	x4, x4, x17
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	add	x1, x1, x2
               	sxtw	x1, w1
               	mov	w1, w1
               	add	x4, x4, x1
               	sub	x1, x29, #0x18
               	str	w0, [x1]
               	sub	x2, x29, #0x18
               	add	x1, x0, #0x1
               	str	w1, [x2, #0x4]
               	sub	x2, x29, #0x18
               	lsl	x1, x0, #1
               	str	w1, [x2, #0x8]
               	sub	x2, x29, #0x18
               	sub	x1, x0, #0x1
               	str	w1, [x2, #0xc]
               	sub	x1, x29, #0x18
               	ldrsw	x1, [x1, #0x4]
               	lsl	x1, x1, #1
               	sxtw	x1, w1
               	sub	x2, x29, #0x18
               	ldrsw	x2, [x2, #0x4]
               	mov	x17, #0x4243            // =16963
               	movk	x17, #0xf, lsl #16
               	mul	x4, x4, x17
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	add	x1, x1, x2
               	sxtw	x1, w1
               	mov	w1, w1
               	add	x4, x4, x1
               	sub	x1, x29, #0x18
               	str	w0, [x1]
               	sub	x2, x29, #0x18
               	add	x1, x0, #0x1
               	str	w1, [x2, #0x4]
               	sub	x2, x29, #0x18
               	lsl	x1, x0, #1
               	str	w1, [x2, #0x8]
               	sub	x2, x29, #0x18
               	sub	x1, x0, #0x1
               	str	w1, [x2, #0xc]
               	sub	x1, x29, #0x18
               	ldrsw	x1, [x1, #0x8]
               	lsl	x1, x1, #1
               	sxtw	x1, w1
               	sub	x2, x29, #0x18
               	ldrsw	x2, [x2, #0x8]
               	mov	x17, #0x4243            // =16963
               	movk	x17, #0xf, lsl #16
               	mul	x4, x4, x17
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	add	x1, x1, x2
               	sxtw	x1, w1
               	mov	w1, w1
               	add	x4, x4, x1
               	sub	x1, x29, #0x18
               	str	w0, [x1]
               	sub	x2, x29, #0x18
               	add	x1, x0, #0x1
               	str	w1, [x2, #0x4]
               	sub	x2, x29, #0x18
               	lsl	x1, x0, #1
               	str	w1, [x2, #0x8]
               	sub	x2, x29, #0x18
               	sub	x1, x0, #0x1
               	str	w1, [x2, #0xc]
               	sub	x1, x29, #0x18
               	ldrsw	x1, [x1, #0xc]
               	lsl	x1, x1, #1
               	sxtw	x1, w1
               	sub	x2, x29, #0x18
               	ldrsw	x2, [x2, #0xc]
               	mov	x17, #0x4243            // =16963
               	movk	x17, #0xf, lsl #16
               	mul	x4, x4, x17
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	add	x1, x1, x2
               	sxtw	x1, w1
               	mov	w1, w1
               	add	x2, x4, x1
               	add	x0, x3, #0x1
               	sxtw	x3, w0
               	cmp	x3, #0x4
               	b.le	<addr>
               	mov	w0, w2
               	mov	x17, #0xf8d8            // =63704
               	movk	x17, #0x33f7, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
