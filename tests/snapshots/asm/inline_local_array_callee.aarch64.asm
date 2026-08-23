
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
               	mov	x5, #0x0                // =0
               	mov	x0, x5
               	mov	x0, x5
               	mov	x0, #0xfffc             // =65532
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x1, #0x7                // =7
               	mov	x2, #0x4243             // =16963
               	movk	x2, #0xf, lsl #16
               	b	<addr>
               	lsl	x4, x0, #1
               	sub	x3, x0, x4
               	sxtw	x3, w3
               	mul	x5, x5, x2
               	mul	x3, x3, x1
               	add	x3, x3, x0
               	sxtw	x3, w3
               	mov	w3, w3
               	add	x8, x5, x3
               	add	x3, x0, #0x1
               	sub	x5, x0, #0x1
               	sub	x6, x3, x5
               	sxtw	x6, w6
               	mul	x8, x8, x2
               	mul	x6, x6, x1
               	add	x6, x6, x3
               	sxtw	x6, w6
               	mov	w6, w6
               	add	x8, x8, x6
               	sub	x6, x4, x0
               	sxtw	x6, w6
               	mul	x8, x8, x2
               	mul	x6, x6, x1
               	add	x4, x6, x4
               	sxtw	x4, w4
               	mov	w4, w4
               	add	x6, x8, x4
               	sub	x4, x5, x3
               	sxtw	x4, w4
               	mul	x6, x6, x2
               	mul	x4, x4, x1
               	add	x4, x4, x5
               	sxtw	x4, w4
               	mov	w4, w4
               	add	x5, x6, x4
               	add	x4, x0, x3
               	sxtw	x4, w4
               	mul	x5, x5, x2
               	mul	x4, x4, x1
               	add	x4, x4, x0
               	sxtw	x4, w4
               	mov	w4, w4
               	add	x6, x5, x4
               	lsl	x4, x0, #1
               	add	x5, x3, x4
               	sxtw	x5, w5
               	mul	x6, x6, x2
               	mul	x5, x5, x1
               	add	x3, x5, x3
               	sxtw	x3, w3
               	mov	w3, w3
               	add	x6, x6, x3
               	sub	x3, x0, #0x1
               	add	x5, x4, x3
               	sxtw	x5, w5
               	mul	x6, x6, x2
               	mul	x5, x5, x1
               	add	x5, x5, x4
               	sxtw	x5, w5
               	mov	w5, w5
               	add	x6, x6, x5
               	add	x5, x3, x0
               	sxtw	x5, w5
               	mul	x6, x6, x2
               	mul	x5, x5, x1
               	add	x3, x5, x3
               	sxtw	x3, w3
               	mov	w3, w3
               	add	x5, x6, x3
               	sxtw	x3, w4
               	mul	x5, x5, x2
               	mul	x3, x3, x1
               	add	x3, x3, x0
               	sxtw	x3, w3
               	mov	w3, w3
               	add	x6, x5, x3
               	add	x5, x0, #0x1
               	lsl	x3, x5, #1
               	sxtw	x3, w3
               	mul	x6, x6, x2
               	mul	x3, x3, x1
               	add	x3, x3, x5
               	sxtw	x3, w3
               	mov	w3, w3
               	add	x5, x6, x3
               	lsl	x3, x4, #1
               	sxtw	x3, w3
               	mul	x5, x5, x2
               	mul	x3, x3, x1
               	add	x3, x3, x4
               	sxtw	x3, w3
               	mov	w3, w3
               	add	x5, x5, x3
               	sub	x4, x0, #0x1
               	lsl	x3, x4, #1
               	sxtw	x3, w3
               	mul	x5, x5, x2
               	mul	x3, x3, x1
               	add	x3, x3, x4
               	sxtw	x3, w3
               	mov	w3, w3
               	add	x5, x5, x3
               	add	x0, x7, #0x1
               	sxtw	x7, w0
               	cmp	x7, #0x4
               	b.le	<addr>
               	mov	w0, w5
               	mov	x17, #0xf8d8            // =63704
               	movk	x17, #0x33f7, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	mov	x0, #0x0                // =0
               	ret
