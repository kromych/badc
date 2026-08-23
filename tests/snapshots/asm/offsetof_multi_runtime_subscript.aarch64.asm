
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
               	mul	x6, x2, x4
               	add	x6, x6, x1
               	lsl	x6, x6, #1
               	add	x6, x6, #0x2
               	mul	x7, x2, x5
               	lsl	x8, x1, #1
               	add	x7, x7, x8
               	add	x7, x7, #0x2
               	cmp	x7, x6
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x7
               	b.lt	<addr>
               	add	x3, x2, #0x1
               	sxtw	x2, w3
               	cmp	x2, #0x5
               	b.lt	<addr>
               	mov	x5, #0x0                // =0
               	mov	x6, #0x3                // =3
               	mov	x7, #0x18               // =24
               	b	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mul	x8, x3, x6
               	add	x8, x8, x2
               	lsl	x8, x8, #1
               	add	x8, x8, x1
               	lsl	x8, x8, #2
               	add	x8, x8, #0x48
               	mul	x9, x3, x7
               	lsl	x10, x2, #3
               	add	x9, x9, x10
               	lsl	x10, x1, #2
               	add	x9, x9, x10
               	add	x9, x9, #0x48
               	cmp	x9, x8
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x2
               	b.lt	<addr>
               	add	x4, x2, #0x1
               	sxtw	x2, w4
               	cmp	x2, #0x3
               	b.lt	<addr>
               	add	x5, x3, #0x1
               	sxtw	x3, w5
               	cmp	x3, #0x4
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x7
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	mov	x2, #0x7                // =7
               	mov	x3, #0xe                // =14
               	b	<addr>
               	mul	x4, x1, x3
               	add	x4, x4, #0x8
               	mul	x5, x1, x2
               	lsl	x5, x5, #1
               	add	x5, x5, #0x8
               	cmp	x4, x5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x5
               	b.lt	<addr>
               	mov	x3, #0x0                // =0
               	mov	x4, #0x6                // =6
               	mov	x5, #0x18               // =24
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mul	x6, x2, x5
               	lsl	x7, x1, #2
               	add	x6, x6, x7
               	add	x6, x6, #0x50
               	mul	x7, x2, x4
               	add	x7, x7, x1
               	lsl	x7, x7, #2
               	add	x7, x7, #0x50
               	cmp	x6, x7
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x2
               	b.lt	<addr>
               	add	x3, x2, #0x1
               	sxtw	x2, w3
               	cmp	x2, #0x4
               	b.lt	<addr>
               	mov	x5, #0x0                // =0
               	mov	x7, #0x3                // =3
               	mov	x8, #0xc                // =12
               	mov	x9, #0x34               // =52
               	b	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mul	x2, x6, x9
               	add	x10, x2, #0xac
               	mul	x11, x3, x7
               	add	x11, x11, x1
               	lsl	x11, x11, #2
               	add	x10, x10, x11
               	mul	x11, x3, x8
               	add	x2, x2, x11
               	lsl	x11, x1, #2
               	add	x2, x2, x11
               	add	x2, x2, #0xac
               	cmp	x2, x10
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x3
               	b.lt	<addr>
               	add	x4, x3, #0x1
               	sxtw	x3, w4
               	cmp	x3, #0x4
               	b.lt	<addr>
               	add	x5, x6, #0x1
               	sxtw	x6, w5
               	cmp	x6, #0x3
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
