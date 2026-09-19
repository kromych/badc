
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
               	mov	x17, #0x64              // =100
               	mul	x1, x1, x17
               	add	x0, x1, x0
               	sxtw	x0, w0
               	ret

<f2>:
               	add	x1, x0, #0x1
               	lsl	x2, x0, #1
               	add	x0, x1, x2
               	mov	x17, #0x64              // =100
               	mul	x0, x0, x17
               	add	x0, x0, x1
               	sxtw	x0, w0
               	ret

<f3>:
               	add	x1, x0, #0x1
               	lsl	x0, x1, #1
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
               	mov	x17, #-0x3de            // =-990
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
               	mov	x5, #0x0                // =0
               	mov	x0, #-0x4               // =-4
               	mov	x1, #0x7                // =7
               	mov	x2, #0x4243             // =16963
               	movk	x2, #0xf, lsl #16
               	cmp	w0, #0x4
               	b.gt	<addr>
               	lsl	x4, x0, #1
               	sub	x3, x0, x4
               	mul	x5, x5, x2
               	mul	x3, x3, x1
               	add	x3, x3, x0
               	add	x7, x5, x3
               	add	x3, x0, #0x1
               	sub	x5, x0, #0x1
               	sub	x6, x3, x5
               	mul	x7, x7, x2
               	mul	x6, x6, x1
               	add	x6, x6, x3
               	add	x7, x7, x6
               	sub	x6, x4, x0
               	mul	x7, x7, x2
               	mul	x6, x6, x1
               	add	x4, x6, x4
               	add	x6, x7, x4
               	sub	x4, x5, x3
               	mul	x6, x6, x2
               	mul	x4, x4, x1
               	add	x4, x4, x5
               	add	x4, x6, x4
               	add	x3, x0, x3
               	mul	x4, x4, x2
               	mul	x3, x3, x1
               	add	x3, x3, x0
               	add	x6, x4, x3
               	add	x4, x0, #0x1
               	lsl	x3, x0, #1
               	add	x5, x4, x3
               	mul	x6, x6, x2
               	mul	x5, x5, x1
               	add	x4, x5, x4
               	add	x6, x6, x4
               	sub	x4, x0, #0x1
               	add	x5, x3, x4
               	mul	x6, x6, x2
               	mul	x5, x5, x1
               	add	x5, x5, x3
               	add	x6, x6, x5
               	add	x5, x4, x0
               	mul	x6, x6, x2
               	mul	x5, x5, x1
               	add	x4, x5, x4
               	add	x4, x6, x4
               	mul	x4, x4, x2
               	mul	x3, x3, x1
               	add	x3, x3, x0
               	add	x5, x4, x3
               	add	x3, x0, #0x1
               	lsl	x4, x3, #1
               	mul	x5, x5, x2
               	mul	x4, x4, x1
               	add	x4, x4, x3
               	add	x6, x5, x4
               	lsl	x4, x0, #1
               	lsl	x5, x4, #1
               	mul	x6, x6, x2
               	mul	x5, x5, x1
               	add	x4, x5, x4
               	add	x6, x6, x4
               	sub	x4, x0, #0x1
               	lsl	x5, x4, #1
               	mul	x6, x6, x2
               	mul	x5, x5, x1
               	add	x4, x5, x4
               	add	x5, x6, x4
               	mov	x0, x3
               	cmp	w0, #0x4
               	b.le	<addr>
               	mov	x17, #0xf8d8            // =63704
               	movk	x17, #0x33f7, lsl #16
               	cmp	w5, w17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
