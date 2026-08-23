
inline_local_array_callee.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0xfff6             // =65526
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x1, #0x1f               // =31
               	mov	x0, #0x16               // =22
               	mov	x0, #0x2                // =2
               	mov	x1, #0x17               // =23
               	mov	x3, #0x0                // =0
               	mov	x0, x3
               	mov	x0, x3
               	mov	x0, #0xfffc             // =65532
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	b	<addr>
               	lsl	x2, x0, #1
               	sub	x1, x0, x2
               	sxtw	x1, w1
               	mov	x17, #0x4243            // =16963
               	movk	x17, #0xf, lsl #16
               	mul	x3, x3, x17
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	add	x1, x1, x0
               	sxtw	x1, w1
               	mov	w1, w1
               	add	x6, x3, x1
               	add	x1, x0, #0x1
               	sub	x3, x0, #0x1
               	sub	x4, x1, x3
               	sxtw	x4, w4
               	mov	x17, #0x4243            // =16963
               	movk	x17, #0xf, lsl #16
               	mul	x6, x6, x17
               	mov	x17, #0x7               // =7
               	mul	x4, x4, x17
               	add	x4, x4, x1
               	sxtw	x4, w4
               	mov	w4, w4
               	add	x6, x6, x4
               	sub	x4, x2, x0
               	sxtw	x4, w4
               	mov	x17, #0x4243            // =16963
               	movk	x17, #0xf, lsl #16
               	mul	x6, x6, x17
               	mov	x17, #0x7               // =7
               	mul	x4, x4, x17
               	add	x2, x4, x2
               	sxtw	x2, w2
               	mov	w2, w2
               	add	x4, x6, x2
               	sub	x2, x3, x1
               	sxtw	x2, w2
               	mov	x17, #0x4243            // =16963
               	movk	x17, #0xf, lsl #16
               	mul	x4, x4, x17
               	mov	x17, #0x7               // =7
               	mul	x2, x2, x17
               	add	x2, x2, x3
               	sxtw	x2, w2
               	mov	w2, w2
               	add	x3, x4, x2
               	add	x2, x0, x1
               	sxtw	x2, w2
               	mov	x17, #0x4243            // =16963
               	movk	x17, #0xf, lsl #16
               	mul	x3, x3, x17
               	mov	x17, #0x7               // =7
               	mul	x2, x2, x17
               	add	x2, x2, x0
               	sxtw	x2, w2
               	mov	w2, w2
               	add	x4, x3, x2
               	lsl	x2, x0, #1
               	add	x3, x1, x2
               	sxtw	x3, w3
               	mov	x17, #0x4243            // =16963
               	movk	x17, #0xf, lsl #16
               	mul	x4, x4, x17
               	mov	x17, #0x7               // =7
               	mul	x3, x3, x17
               	add	x1, x3, x1
               	sxtw	x1, w1
               	mov	w1, w1
               	add	x4, x4, x1
               	sub	x1, x0, #0x1
               	add	x3, x2, x1
               	sxtw	x3, w3
               	mov	x17, #0x4243            // =16963
               	movk	x17, #0xf, lsl #16
               	mul	x4, x4, x17
               	mov	x17, #0x7               // =7
               	mul	x3, x3, x17
               	add	x3, x3, x2
               	sxtw	x3, w3
               	mov	w3, w3
               	add	x4, x4, x3
               	add	x3, x1, x0
               	sxtw	x3, w3
               	mov	x17, #0x4243            // =16963
               	movk	x17, #0xf, lsl #16
               	mul	x4, x4, x17
               	mov	x17, #0x7               // =7
               	mul	x3, x3, x17
               	add	x1, x3, x1
               	sxtw	x1, w1
               	mov	w1, w1
               	add	x3, x4, x1
               	sxtw	x1, w2
               	mov	x17, #0x4243            // =16963
               	movk	x17, #0xf, lsl #16
               	mul	x3, x3, x17
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	add	x1, x1, x0
               	sxtw	x1, w1
               	mov	w1, w1
               	add	x4, x3, x1
               	add	x3, x0, #0x1
               	lsl	x1, x3, #1
               	sxtw	x1, w1
               	mov	x17, #0x4243            // =16963
               	movk	x17, #0xf, lsl #16
               	mul	x4, x4, x17
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	add	x1, x1, x3
               	sxtw	x1, w1
               	mov	w1, w1
               	add	x3, x4, x1
               	lsl	x1, x2, #1
               	sxtw	x1, w1
               	mov	x17, #0x4243            // =16963
               	movk	x17, #0xf, lsl #16
               	mul	x3, x3, x17
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	add	x1, x1, x2
               	sxtw	x1, w1
               	mov	w1, w1
               	add	x3, x3, x1
               	sub	x2, x0, #0x1
               	lsl	x1, x2, #1
               	sxtw	x1, w1
               	mov	x17, #0x4243            // =16963
               	movk	x17, #0xf, lsl #16
               	mul	x3, x3, x17
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	add	x1, x1, x2
               	sxtw	x1, w1
               	mov	w1, w1
               	add	x3, x3, x1
               	add	x0, x5, #0x1
               	sxtw	x5, w0
               	cmp	x5, #0x4
               	b.le	<addr>
               	mov	w0, w3
               	mov	x17, #0xf8d8            // =63704
               	movk	x17, #0x33f7, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	mov	x0, #0x0                // =0
               	ret
