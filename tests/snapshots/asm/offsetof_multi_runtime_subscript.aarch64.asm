
offsetof_multi_runtime_subscript.aarch64:	file format elf64-littleaarch64

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

<main>:
               	mov	x3, #0x0                // =0
               	mov	x4, #0x7                // =7
               	mov	x5, #0xe                // =14
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x2, w3
               	mul	x6, x2, x4
               	sxtw	x1, w0
               	add	x6, x6, x1
               	lsl	x6, x6, #1
               	add	x6, x6, #0x2
               	mul	x2, x2, x5
               	lsl	x7, x1, #1
               	add	x2, x2, x7
               	add	x2, x2, #0x2
               	cmp	w2, w6
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	x0, #0x7
               	b.lt	<addr>
               	sxtw	x0, w3
               	add	x3, x0, #0x1
               	cmp	x3, #0x5
               	b.lt	<addr>
               	mov	x5, #0x0                // =0
               	mov	x6, #0x3                // =3
               	mov	x7, #0x18               // =24
               	b	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x2, w5
               	mul	x1, x2, x6
               	sxtw	x3, w4
               	add	x1, x1, x3
               	lsl	x8, x1, #1
               	sxtw	x1, w0
               	add	x8, x8, x1
               	lsl	x8, x8, #2
               	add	x8, x8, #0x48
               	mul	x2, x2, x7
               	lsl	x3, x3, #3
               	add	x2, x2, x3
               	lsl	x3, x1, #2
               	add	x2, x2, x3
               	add	x2, x2, #0x48
               	cmp	w2, w8
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	x0, #0x2
               	b.lt	<addr>
               	sxtw	x0, w4
               	add	x4, x0, #0x1
               	cmp	x4, #0x3
               	b.lt	<addr>
               	sxtw	x0, w5
               	add	x5, x0, #0x1
               	cmp	x5, #0x4
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x0, w0
               	add	x0, x0, #0x1
               	cmp	x0, #0x7
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	mov	x2, #0x7                // =7
               	mov	x3, #0xe                // =14
               	b	<addr>
               	sxtw	x1, w0
               	mul	x4, x1, x3
               	add	x4, x4, #0x8
               	mul	x5, x1, x2
               	lsl	x5, x5, #1
               	add	x5, x5, #0x8
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	x0, #0x5
               	b.lt	<addr>
               	mov	x3, #0x0                // =0
               	mov	x4, #0x6                // =6
               	mov	x5, #0x18               // =24
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x2, w3
               	mul	x6, x2, x5
               	sxtw	x1, w0
               	lsl	x7, x1, #2
               	add	x6, x6, x7
               	add	x6, x6, #0x50
               	mul	x2, x2, x4
               	add	x2, x2, x1
               	lsl	x2, x2, #2
               	add	x2, x2, #0x50
               	cmp	x6, x2
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	x0, #0x2
               	b.lt	<addr>
               	sxtw	x0, w3
               	add	x3, x0, #0x1
               	cmp	x3, #0x4
               	b.lt	<addr>
               	mov	x5, #0x0                // =0
               	mov	x6, #0x3                // =3
               	mov	x7, #0xc                // =12
               	mov	x8, #0x34               // =52
               	b	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x1, w5
               	mul	x1, x1, x8
               	add	x9, x1, #0xac
               	sxtw	x3, w4
               	mul	x10, x3, x6
               	sxtw	x2, w0
               	add	x10, x10, x2
               	lsl	x10, x10, #2
               	add	x9, x9, x10
               	mul	x3, x3, x7
               	add	x1, x1, x3
               	lsl	x3, x2, #2
               	add	x1, x1, x3
               	add	x1, x1, #0xac
               	cmp	x1, x9
               	b.ne	<addr>
               	add	x0, x2, #0x1
               	cmp	x0, #0x3
               	b.lt	<addr>
               	sxtw	x0, w4
               	add	x4, x0, #0x1
               	cmp	x4, #0x4
               	b.lt	<addr>
               	sxtw	x0, w5
               	add	x5, x0, #0x1
               	cmp	x5, #0x3
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x6                // =6
               	ret
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x1                // =1
               	ret
