
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
               	sub	sp, sp, #0x40
               	sub	x1, x29, #0x8
               	sub	x2, x29, #0x30
               	str	w0, [x2]
               	sub	x3, x29, #0x30
               	add	x2, x0, #0x1
               	str	w2, [x3, #0x4]
               	sub	x3, x29, #0x30
               	lsl	x2, x0, #1
               	str	w2, [x3, #0x8]
               	sub	x2, x29, #0x30
               	sub	x0, x0, #0x1
               	str	w0, [x2, #0xc]
               	sub	x0, x29, #0x30
               	add	x0, x0, #0x0
               	ldrsw	x2, [x0]
               	sub	x0, x29, #0x30
               	ldrsw	x0, [x0, #0x8]
               	sub	x0, x2, x0
               	sxtw	x0, w0
               	str	w0, [x1]
               	sub	x0, x29, #0x30
               	add	x0, x0, #0x0
               	ldrsw	x0, [x0]
               	str	w0, [x1, #0x4]
               	sub	x0, x29, #0x8
               	ldrsw	x0, [x0]
               	mov	x17, #0x64              // =100
               	mul	x0, x0, x17
               	sub	x1, x29, #0x8
               	ldrsw	x1, [x1, #0x4]
               	add	x0, x0, x1
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<f2>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	x1, x29, #0x8
               	sub	x2, x29, #0x30
               	str	w0, [x2]
               	sub	x3, x29, #0x30
               	add	x2, x0, #0x1
               	str	w2, [x3, #0x4]
               	sub	x3, x29, #0x30
               	lsl	x2, x0, #1
               	str	w2, [x3, #0x8]
               	sub	x2, x29, #0x30
               	sub	x0, x0, #0x1
               	str	w0, [x2, #0xc]
               	sub	x0, x29, #0x30
               	ldrsw	x2, [x0, #0x4]
               	sub	x0, x29, #0x30
               	ldrsw	x0, [x0, #0x8]
               	add	x0, x2, x0
               	sxtw	x0, w0
               	str	w0, [x1]
               	sub	x0, x29, #0x30
               	ldrsw	x0, [x0, #0x4]
               	str	w0, [x1, #0x4]
               	sub	x0, x29, #0x8
               	ldrsw	x0, [x0]
               	mov	x17, #0x64              // =100
               	mul	x0, x0, x17
               	sub	x1, x29, #0x8
               	ldrsw	x1, [x1, #0x4]
               	add	x0, x0, x1
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<f3>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	x1, x29, #0x8
               	sub	x2, x29, #0x30
               	str	w0, [x2]
               	sub	x3, x29, #0x30
               	add	x2, x0, #0x1
               	str	w2, [x3, #0x4]
               	sub	x3, x29, #0x30
               	lsl	x2, x0, #1
               	str	w2, [x3, #0x8]
               	sub	x2, x29, #0x30
               	sub	x0, x0, #0x1
               	str	w0, [x2, #0xc]
               	sub	x0, x29, #0x30
               	ldrsw	x0, [x0, #0x4]
               	lsl	x0, x0, #1
               	sxtw	x0, w0
               	str	w0, [x1]
               	sub	x0, x29, #0x30
               	ldrsw	x0, [x0, #0x4]
               	str	w0, [x1, #0x4]
               	sub	x0, x29, #0x8
               	ldrsw	x0, [x0]
               	mov	x17, #0x64              // =100
               	mul	x0, x0, x17
               	sub	x1, x29, #0x8
               	ldrsw	x1, [x1, #0x4]
               	add	x0, x0, x1
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x220
               	mov	x0, #0xa                // =10
               	bl	<addr>
               	mov	x17, #0xfc22            // =64546
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa                // =10
               	bl	<addr>
               	cmp	x0, #0xc27
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa                // =10
               	bl	<addr>
               	cmp	x0, #0x8a3
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x8
               	mov	x0, #0x3                // =3
               	sub	x2, x29, #0x68
               	str	w0, [x2]
               	sub	x0, x29, #0x68
               	mov	x2, #0x4                // =4
               	str	w2, [x0, #0x4]
               	sub	x0, x29, #0x68
               	mov	x2, #0x6                // =6
               	str	w2, [x0, #0x8]
               	sub	x0, x29, #0x68
               	mov	x2, #0x2                // =2
               	str	w2, [x0, #0xc]
               	sub	x0, x29, #0x68
               	ldrsw	x2, [x0, #0x4]
               	sub	x0, x29, #0x68
               	ldrsw	x0, [x0, #0xc]
               	sub	x0, x2, x0
               	sxtw	x0, w0
               	str	w0, [x1]
               	sub	x0, x29, #0x68
               	ldrsw	x0, [x0, #0x4]
               	str	w0, [x1, #0x4]
               	sub	x0, x29, #0x10
               	mov	x1, #0x8                // =8
               	sub	x2, x29, #0x88
               	str	w1, [x2]
               	sub	x1, x29, #0x88
               	mov	x2, #0x9                // =9
               	str	w2, [x1, #0x4]
               	sub	x1, x29, #0x88
               	mov	x2, #0x10               // =16
               	str	w2, [x1, #0x8]
               	sub	x1, x29, #0x88
               	mov	x2, #0x7                // =7
               	str	w2, [x1, #0xc]
               	sub	x1, x29, #0x88
               	ldrsw	x2, [x1, #0x8]
               	sub	x1, x29, #0x88
               	ldrsw	x1, [x1, #0xc]
               	add	x1, x2, x1
               	sxtw	x1, w1
               	str	w1, [x0]
               	sub	x1, x29, #0x88
               	ldrsw	x1, [x1, #0x8]
               	str	w1, [x0, #0x4]
               	sub	x0, x29, #0x8
               	ldrsw	x0, [x0]
               	cmp	x0, #0x2
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x8
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x4
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldrsw	x0, [x0]
               	cmp	x0, #0x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x10
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x10
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x0                // =0
               	mov	x0, #0xfffc             // =65532
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	b	<addr>
               	sub	x3, x29, #0x28
               	sub	x1, x29, #0xa8
               	str	w0, [x1]
               	sub	x5, x29, #0xa8
               	add	x1, x0, #0x1
               	str	w1, [x5, #0x4]
               	sub	x5, x29, #0xa8
               	lsl	x1, x0, #1
               	str	w1, [x5, #0x8]
               	sub	x5, x29, #0xa8
               	sub	x1, x0, #0x1
               	str	w1, [x5, #0xc]
               	sub	x1, x29, #0xa8
               	add	x1, x1, #0x0
               	ldrsw	x5, [x1]
               	sub	x1, x29, #0xa8
               	ldrsw	x1, [x1, #0x8]
               	sub	x1, x5, x1
               	sxtw	x1, w1
               	str	w1, [x3]
               	sub	x1, x29, #0xa8
               	add	x1, x1, #0x0
               	ldrsw	x1, [x1]
               	str	w1, [x3, #0x4]
               	mov	x17, #0x4243            // =16963
               	movk	x17, #0xf, lsl #16
               	mul	x3, x2, x17
               	sub	x1, x29, #0x28
               	ldrsw	x1, [x1]
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	sub	x2, x29, #0x28
               	ldrsw	x2, [x2, #0x4]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	mov	w1, w1
               	add	x5, x3, x1
               	sub	x2, x29, #0x28
               	sub	x1, x29, #0xc8
               	str	w0, [x1]
               	sub	x3, x29, #0xc8
               	add	x1, x0, #0x1
               	str	w1, [x3, #0x4]
               	sub	x3, x29, #0xc8
               	lsl	x1, x0, #1
               	str	w1, [x3, #0x8]
               	sub	x3, x29, #0xc8
               	sub	x1, x0, #0x1
               	str	w1, [x3, #0xc]
               	sub	x1, x29, #0xc8
               	ldrsw	x3, [x1, #0x4]
               	sub	x1, x29, #0xc8
               	ldrsw	x1, [x1, #0xc]
               	sub	x1, x3, x1
               	sxtw	x1, w1
               	str	w1, [x2]
               	sub	x1, x29, #0xc8
               	ldrsw	x1, [x1, #0x4]
               	str	w1, [x2, #0x4]
               	mov	x17, #0x4243            // =16963
               	movk	x17, #0xf, lsl #16
               	mul	x3, x5, x17
               	sub	x1, x29, #0x28
               	ldrsw	x1, [x1]
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	sub	x2, x29, #0x28
               	ldrsw	x2, [x2, #0x4]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	mov	w1, w1
               	add	x5, x3, x1
               	sub	x2, x29, #0x28
               	sub	x1, x29, #0xe8
               	str	w0, [x1]
               	sub	x3, x29, #0xe8
               	add	x1, x0, #0x1
               	str	w1, [x3, #0x4]
               	sub	x3, x29, #0xe8
               	lsl	x1, x0, #1
               	str	w1, [x3, #0x8]
               	sub	x3, x29, #0xe8
               	sub	x1, x0, #0x1
               	str	w1, [x3, #0xc]
               	sub	x1, x29, #0xe8
               	ldrsw	x1, [x1, #0x8]
               	sub	x3, x29, #0xe8
               	add	x3, x3, #0x0
               	ldrsw	x3, [x3]
               	sub	x1, x1, x3
               	sxtw	x1, w1
               	str	w1, [x2]
               	sub	x1, x29, #0xe8
               	ldrsw	x1, [x1, #0x8]
               	str	w1, [x2, #0x4]
               	mov	x17, #0x4243            // =16963
               	movk	x17, #0xf, lsl #16
               	mul	x3, x5, x17
               	sub	x1, x29, #0x28
               	ldrsw	x1, [x1]
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	sub	x2, x29, #0x28
               	ldrsw	x2, [x2, #0x4]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	mov	w1, w1
               	add	x5, x3, x1
               	sub	x2, x29, #0x28
               	sub	x1, x29, #0x108
               	str	w0, [x1]
               	sub	x3, x29, #0x108
               	add	x1, x0, #0x1
               	str	w1, [x3, #0x4]
               	sub	x3, x29, #0x108
               	lsl	x1, x0, #1
               	str	w1, [x3, #0x8]
               	sub	x3, x29, #0x108
               	sub	x1, x0, #0x1
               	str	w1, [x3, #0xc]
               	sub	x1, x29, #0x108
               	ldrsw	x3, [x1, #0xc]
               	sub	x1, x29, #0x108
               	ldrsw	x1, [x1, #0x4]
               	sub	x1, x3, x1
               	sxtw	x1, w1
               	str	w1, [x2]
               	sub	x1, x29, #0x108
               	ldrsw	x1, [x1, #0xc]
               	str	w1, [x2, #0x4]
               	mov	x17, #0x4243            // =16963
               	movk	x17, #0xf, lsl #16
               	mul	x3, x5, x17
               	sub	x1, x29, #0x28
               	ldrsw	x1, [x1]
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	sub	x2, x29, #0x28
               	ldrsw	x2, [x2, #0x4]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	mov	w1, w1
               	add	x5, x3, x1
               	sub	x1, x29, #0x28
               	sub	x2, x29, #0x128
               	str	w0, [x2]
               	sub	x3, x29, #0x128
               	add	x2, x0, #0x1
               	str	w2, [x3, #0x4]
               	sub	x3, x29, #0x128
               	lsl	x2, x0, #1
               	str	w2, [x3, #0x8]
               	sub	x3, x29, #0x128
               	sub	x2, x0, #0x1
               	str	w2, [x3, #0xc]
               	sub	x2, x29, #0x128
               	add	x2, x2, #0x0
               	ldrsw	x3, [x2]
               	sub	x2, x29, #0x128
               	ldrsw	x2, [x2, #0x4]
               	add	x2, x3, x2
               	sxtw	x2, w2
               	str	w2, [x1]
               	sub	x2, x29, #0x128
               	add	x2, x2, #0x0
               	ldrsw	x2, [x2]
               	str	w2, [x1, #0x4]
               	mov	x17, #0x4243            // =16963
               	movk	x17, #0xf, lsl #16
               	mul	x3, x5, x17
               	sub	x1, x29, #0x28
               	ldrsw	x1, [x1]
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	sub	x2, x29, #0x28
               	ldrsw	x2, [x2, #0x4]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	mov	w1, w1
               	add	x5, x3, x1
               	sub	x1, x29, #0x28
               	sub	x2, x29, #0x148
               	str	w0, [x2]
               	sub	x3, x29, #0x148
               	add	x2, x0, #0x1
               	str	w2, [x3, #0x4]
               	sub	x3, x29, #0x148
               	lsl	x2, x0, #1
               	str	w2, [x3, #0x8]
               	sub	x3, x29, #0x148
               	sub	x2, x0, #0x1
               	str	w2, [x3, #0xc]
               	sub	x2, x29, #0x148
               	ldrsw	x3, [x2, #0x4]
               	sub	x2, x29, #0x148
               	ldrsw	x2, [x2, #0x8]
               	add	x2, x3, x2
               	sxtw	x2, w2
               	str	w2, [x1]
               	sub	x2, x29, #0x148
               	ldrsw	x2, [x2, #0x4]
               	str	w2, [x1, #0x4]
               	mov	x17, #0x4243            // =16963
               	movk	x17, #0xf, lsl #16
               	mul	x3, x5, x17
               	sub	x1, x29, #0x28
               	ldrsw	x1, [x1]
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	sub	x2, x29, #0x28
               	ldrsw	x2, [x2, #0x4]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	mov	w1, w1
               	add	x5, x3, x1
               	sub	x1, x29, #0x28
               	sub	x2, x29, #0x168
               	str	w0, [x2]
               	sub	x3, x29, #0x168
               	add	x2, x0, #0x1
               	str	w2, [x3, #0x4]
               	sub	x3, x29, #0x168
               	lsl	x2, x0, #1
               	str	w2, [x3, #0x8]
               	sub	x3, x29, #0x168
               	sub	x2, x0, #0x1
               	str	w2, [x3, #0xc]
               	sub	x2, x29, #0x168
               	ldrsw	x3, [x2, #0x8]
               	sub	x2, x29, #0x168
               	ldrsw	x2, [x2, #0xc]
               	add	x2, x3, x2
               	sxtw	x2, w2
               	str	w2, [x1]
               	sub	x2, x29, #0x168
               	ldrsw	x2, [x2, #0x8]
               	str	w2, [x1, #0x4]
               	mov	x17, #0x4243            // =16963
               	movk	x17, #0xf, lsl #16
               	mul	x3, x5, x17
               	sub	x1, x29, #0x28
               	ldrsw	x1, [x1]
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	sub	x2, x29, #0x28
               	ldrsw	x2, [x2, #0x4]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	mov	w1, w1
               	add	x5, x3, x1
               	sub	x1, x29, #0x28
               	sub	x2, x29, #0x188
               	str	w0, [x2]
               	sub	x3, x29, #0x188
               	add	x2, x0, #0x1
               	str	w2, [x3, #0x4]
               	sub	x3, x29, #0x188
               	lsl	x2, x0, #1
               	str	w2, [x3, #0x8]
               	sub	x3, x29, #0x188
               	sub	x2, x0, #0x1
               	str	w2, [x3, #0xc]
               	sub	x2, x29, #0x188
               	ldrsw	x2, [x2, #0xc]
               	sub	x3, x29, #0x188
               	add	x3, x3, #0x0
               	ldrsw	x3, [x3]
               	add	x2, x2, x3
               	sxtw	x2, w2
               	str	w2, [x1]
               	sub	x2, x29, #0x188
               	ldrsw	x2, [x2, #0xc]
               	str	w2, [x1, #0x4]
               	mov	x17, #0x4243            // =16963
               	movk	x17, #0xf, lsl #16
               	mul	x3, x5, x17
               	sub	x1, x29, #0x28
               	ldrsw	x1, [x1]
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	sub	x2, x29, #0x28
               	ldrsw	x2, [x2, #0x4]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	mov	w1, w1
               	add	x5, x3, x1
               	sub	x2, x29, #0x28
               	sub	x1, x29, #0x1a8
               	str	w0, [x1]
               	sub	x3, x29, #0x1a8
               	add	x1, x0, #0x1
               	str	w1, [x3, #0x4]
               	sub	x3, x29, #0x1a8
               	lsl	x1, x0, #1
               	str	w1, [x3, #0x8]
               	sub	x3, x29, #0x1a8
               	sub	x1, x0, #0x1
               	str	w1, [x3, #0xc]
               	sub	x1, x29, #0x1a8
               	add	x1, x1, #0x0
               	ldrsw	x1, [x1]
               	lsl	x1, x1, #1
               	sxtw	x1, w1
               	str	w1, [x2]
               	sub	x1, x29, #0x1a8
               	add	x1, x1, #0x0
               	ldrsw	x1, [x1]
               	str	w1, [x2, #0x4]
               	mov	x17, #0x4243            // =16963
               	movk	x17, #0xf, lsl #16
               	mul	x3, x5, x17
               	sub	x1, x29, #0x28
               	ldrsw	x1, [x1]
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	sub	x2, x29, #0x28
               	ldrsw	x2, [x2, #0x4]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	mov	w1, w1
               	add	x5, x3, x1
               	sub	x2, x29, #0x28
               	sub	x1, x29, #0x1c8
               	str	w0, [x1]
               	sub	x3, x29, #0x1c8
               	add	x1, x0, #0x1
               	str	w1, [x3, #0x4]
               	sub	x3, x29, #0x1c8
               	lsl	x1, x0, #1
               	str	w1, [x3, #0x8]
               	sub	x3, x29, #0x1c8
               	sub	x1, x0, #0x1
               	str	w1, [x3, #0xc]
               	sub	x1, x29, #0x1c8
               	ldrsw	x1, [x1, #0x4]
               	lsl	x1, x1, #1
               	sxtw	x1, w1
               	str	w1, [x2]
               	sub	x1, x29, #0x1c8
               	ldrsw	x1, [x1, #0x4]
               	str	w1, [x2, #0x4]
               	mov	x17, #0x4243            // =16963
               	movk	x17, #0xf, lsl #16
               	mul	x3, x5, x17
               	sub	x1, x29, #0x28
               	ldrsw	x1, [x1]
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	sub	x2, x29, #0x28
               	ldrsw	x2, [x2, #0x4]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	mov	w1, w1
               	add	x5, x3, x1
               	sub	x2, x29, #0x28
               	sub	x1, x29, #0x1e8
               	str	w0, [x1]
               	sub	x3, x29, #0x1e8
               	add	x1, x0, #0x1
               	str	w1, [x3, #0x4]
               	sub	x3, x29, #0x1e8
               	lsl	x1, x0, #1
               	str	w1, [x3, #0x8]
               	sub	x3, x29, #0x1e8
               	sub	x1, x0, #0x1
               	str	w1, [x3, #0xc]
               	sub	x1, x29, #0x1e8
               	ldrsw	x1, [x1, #0x8]
               	lsl	x1, x1, #1
               	sxtw	x1, w1
               	str	w1, [x2]
               	sub	x1, x29, #0x1e8
               	ldrsw	x1, [x1, #0x8]
               	str	w1, [x2, #0x4]
               	mov	x17, #0x4243            // =16963
               	movk	x17, #0xf, lsl #16
               	mul	x3, x5, x17
               	sub	x1, x29, #0x28
               	ldrsw	x1, [x1]
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	sub	x2, x29, #0x28
               	ldrsw	x2, [x2, #0x4]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	mov	w1, w1
               	add	x5, x3, x1
               	sub	x2, x29, #0x28
               	sub	x1, x29, #0x208
               	str	w0, [x1]
               	sub	x3, x29, #0x208
               	add	x1, x0, #0x1
               	str	w1, [x3, #0x4]
               	sub	x3, x29, #0x208
               	lsl	x1, x0, #1
               	str	w1, [x3, #0x8]
               	sub	x3, x29, #0x208
               	sub	x1, x0, #0x1
               	str	w1, [x3, #0xc]
               	sub	x1, x29, #0x208
               	ldrsw	x1, [x1, #0xc]
               	lsl	x1, x1, #1
               	sxtw	x1, w1
               	str	w1, [x2]
               	sub	x1, x29, #0x208
               	ldrsw	x1, [x1, #0xc]
               	str	w1, [x2, #0x4]
               	mov	x17, #0x4243            // =16963
               	movk	x17, #0xf, lsl #16
               	mul	x3, x5, x17
               	sub	x1, x29, #0x28
               	ldrsw	x1, [x1]
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	sub	x2, x29, #0x28
               	ldrsw	x2, [x2, #0x4]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	mov	w1, w1
               	add	x2, x3, x1
               	add	x0, x4, #0x1
               	sxtw	x4, w0
               	cmp	x4, #0x4
               	b.le	<addr>
               	mov	w0, w2
               	mov	x17, #0xf8d8            // =63704
               	movk	x17, #0x33f7, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
