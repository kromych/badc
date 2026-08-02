
inline_local_array_callee.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<f1>:
               	lsl	x1, x0, #1
               	sub	x1, x0, x1
               	sxtw	x1, w1
               	mov	x17, #0x64              // =100
               	mul	x1, x1, x17
               	add	x0, x1, x0
               	sxtw	x0, w0
               	ret

<f2>:
               	add	x1, x0, #0x1
               	lsl	x2, x0, #1
               	add	x0, x1, x2
               	sxtw	x0, w0
               	mov	x17, #0x64              // =100
               	mul	x0, x0, x17
               	add	x0, x0, x1
               	sxtw	x0, w0
               	ret

<f3>:
               	add	x1, x0, #0x1
               	lsl	x0, x1, #1
               	sxtw	x0, w0
               	mov	x17, #0x64              // =100
               	mul	x0, x0, x17
               	add	x0, x0, x1
               	sxtw	x0, w0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0xa                // =10
               	bl	<addr>
               	mov	x17, #0xfc22            // =64546
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa                // =10
               	bl	<addr>
               	cmp	x0, #0xc27
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa                // =10
               	bl	<addr>
               	cmp	x0, #0x8a3
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	mov	x1, #0x17               // =23
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x2, #0x0                // =0
               	mov	x0, #0xfffc             // =65532
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	b	<addr>
               	lsl	x1, x0, #1
               	sub	x1, x0, x1
               	sxtw	x1, w1
               	mov	x17, #0x4243            // =16963
               	movk	x17, #0xf, lsl #16
               	mul	x2, x2, x17
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	add	x1, x1, x0
               	sxtw	x1, w1
               	mov	w1, w1
               	add	x4, x2, x1
               	add	x1, x0, #0x1
               	sub	x2, x0, #0x1
               	sub	x2, x1, x2
               	sxtw	x2, w2
               	mov	x17, #0x4243            // =16963
               	movk	x17, #0xf, lsl #16
               	mul	x4, x4, x17
               	mov	x17, #0x7               // =7
               	mul	x2, x2, x17
               	add	x1, x2, x1
               	sxtw	x1, w1
               	mov	w1, w1
               	add	x4, x4, x1
               	lsl	x1, x0, #1
               	sub	x2, x1, x0
               	sxtw	x2, w2
               	mov	x17, #0x4243            // =16963
               	movk	x17, #0xf, lsl #16
               	mul	x4, x4, x17
               	mov	x17, #0x7               // =7
               	mul	x2, x2, x17
               	add	x1, x2, x1
               	sxtw	x1, w1
               	mov	w1, w1
               	add	x4, x4, x1
               	add	x2, x0, #0x1
               	sub	x1, x0, #0x1
               	sub	x2, x1, x2
               	sxtw	x2, w2
               	mov	x17, #0x4243            // =16963
               	movk	x17, #0xf, lsl #16
               	mul	x4, x4, x17
               	mov	x17, #0x7               // =7
               	mul	x2, x2, x17
               	add	x1, x2, x1
               	sxtw	x1, w1
               	mov	w1, w1
               	add	x4, x4, x1
               	add	x1, x0, #0x1
               	add	x1, x0, x1
               	sxtw	x1, w1
               	mov	x17, #0x4243            // =16963
               	movk	x17, #0xf, lsl #16
               	mul	x2, x4, x17
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	add	x1, x1, x0
               	sxtw	x1, w1
               	mov	w1, w1
               	add	x5, x2, x1
               	add	x1, x0, #0x1
               	lsl	x2, x0, #1
               	add	x2, x1, x2
               	sxtw	x2, w2
               	mov	x17, #0x4243            // =16963
               	movk	x17, #0xf, lsl #16
               	mul	x4, x5, x17
               	mov	x17, #0x7               // =7
               	mul	x2, x2, x17
               	add	x1, x2, x1
               	sxtw	x1, w1
               	mov	w1, w1
               	add	x4, x4, x1
               	lsl	x1, x0, #1
               	sub	x2, x0, #0x1
               	add	x2, x1, x2
               	sxtw	x2, w2
               	mov	x17, #0x4243            // =16963
               	movk	x17, #0xf, lsl #16
               	mul	x4, x4, x17
               	mov	x17, #0x7               // =7
               	mul	x2, x2, x17
               	add	x1, x2, x1
               	sxtw	x1, w1
               	mov	w1, w1
               	add	x4, x4, x1
               	sub	x1, x0, #0x1
               	add	x2, x1, x0
               	sxtw	x2, w2
               	mov	x17, #0x4243            // =16963
               	movk	x17, #0xf, lsl #16
               	mul	x4, x4, x17
               	mov	x17, #0x7               // =7
               	mul	x2, x2, x17
               	add	x1, x2, x1
               	sxtw	x1, w1
               	mov	w1, w1
               	add	x2, x4, x1
               	lsl	x1, x0, #1
               	sxtw	x1, w1
               	mov	x17, #0x4243            // =16963
               	movk	x17, #0xf, lsl #16
               	mul	x2, x2, x17
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	add	x1, x1, x0
               	sxtw	x1, w1
               	mov	w1, w1
               	add	x4, x2, x1
               	add	x1, x0, #0x1
               	lsl	x2, x1, #1
               	sxtw	x2, w2
               	mov	x17, #0x4243            // =16963
               	movk	x17, #0xf, lsl #16
               	mul	x4, x4, x17
               	mov	x17, #0x7               // =7
               	mul	x2, x2, x17
               	add	x1, x2, x1
               	sxtw	x1, w1
               	mov	w1, w1
               	add	x4, x4, x1
               	lsl	x1, x0, #1
               	lsl	x2, x1, #1
               	sxtw	x2, w2
               	mov	x17, #0x4243            // =16963
               	movk	x17, #0xf, lsl #16
               	mul	x4, x4, x17
               	mov	x17, #0x7               // =7
               	mul	x2, x2, x17
               	add	x1, x2, x1
               	sxtw	x1, w1
               	mov	w1, w1
               	add	x4, x4, x1
               	sub	x1, x0, #0x1
               	lsl	x2, x1, #1
               	sxtw	x2, w2
               	mov	x17, #0x4243            // =16963
               	movk	x17, #0xf, lsl #16
               	mul	x4, x4, x17
               	mov	x17, #0x7               // =7
               	mul	x2, x2, x17
               	add	x1, x2, x1
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
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
