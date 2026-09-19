
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
               	mov	x1, #0x0                // =0
               	mov	x4, #0x7                // =7
               	mov	x5, #0xe                // =14
               	mul	x0, x1, x4
               	lsl	x2, x0, #1
               	add	x6, x2, #0x2
               	mul	x2, x1, x5
               	add	x3, x2, #0x2
               	cmp	x3, x6
               	b.ne	<addr>
               	add	x6, x0, #0x1
               	lsl	x6, x6, #1
               	add	x6, x6, #0x2
               	add	x3, x3, #0x2
               	cmp	x3, x6
               	b.ne	<addr>
               	add	x3, x0, #0x2
               	lsl	x3, x3, #1
               	add	x3, x3, #0x2
               	add	x6, x2, #0x4
               	add	x6, x6, #0x2
               	cmp	x6, x3
               	b.ne	<addr>
               	add	x3, x0, #0x3
               	lsl	x3, x3, #1
               	add	x3, x3, #0x2
               	add	x6, x2, #0x6
               	add	x6, x6, #0x2
               	cmp	x6, x3
               	b.ne	<addr>
               	add	x3, x0, #0x4
               	lsl	x3, x3, #1
               	add	x3, x3, #0x2
               	add	x6, x2, #0x8
               	add	x6, x6, #0x2
               	cmp	x6, x3
               	b.ne	<addr>
               	add	x3, x0, #0x5
               	lsl	x3, x3, #1
               	add	x3, x3, #0x2
               	add	x6, x2, #0xa
               	add	x6, x6, #0x2
               	cmp	x6, x3
               	b.ne	<addr>
               	add	x0, x0, #0x6
               	lsl	x0, x0, #1
               	add	x0, x0, #0x2
               	add	x2, x2, #0xc
               	add	x2, x2, #0x2
               	cmp	x2, x0
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x5
               	b.lt	<addr>
               	mov	x1, #0x0                // =0
               	mov	x4, #0x3                // =3
               	mov	x5, #0x18               // =24
               	mov	x0, #0x0                // =0
               	mul	x2, x1, x4
               	add	x2, x2, x0
               	lsl	x2, x2, #1
               	lsl	x3, x2, #2
               	add	x6, x3, #0x48
               	mul	x3, x1, x5
               	lsl	x7, x0, #3
               	add	x3, x3, x7
               	add	x7, x3, #0x48
               	cmp	x7, x6
               	b.ne	<addr>
               	add	x2, x2, #0x1
               	lsl	x2, x2, #2
               	add	x2, x2, #0x48
               	add	x3, x3, #0x4
               	add	x3, x3, #0x48
               	cmp	x3, x2
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x4
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	mov	x3, #0x6                // =6
               	mov	x4, #0x18               // =24
               	mul	x1, x0, x4
               	add	x5, x1, #0x50
               	mul	x2, x0, x3
               	lsl	x6, x2, #2
               	add	x6, x6, #0x50
               	cmp	x5, x6
               	b.ne	<addr>
               	add	x1, x1, #0x4
               	add	x1, x1, #0x50
               	add	x2, x2, #0x1
               	lsl	x2, x2, #2
               	add	x2, x2, #0x50
               	cmp	x1, x2
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	mov	x4, #0x0                // =0
               	mov	x5, #0x3                // =3
               	mov	x6, #0xc                // =12
               	mov	x7, #0x34               // =52
               	mov	x0, #0x0                // =0
               	mul	x3, x4, x7
               	add	x1, x3, #0xac
               	mul	x2, x0, x5
               	lsl	x8, x2, #2
               	add	x8, x1, x8
               	mul	x9, x0, x6
               	add	x3, x3, x9
               	add	x9, x3, #0xac
               	cmp	x9, x8
               	b.ne	<addr>
               	add	x8, x2, #0x1
               	lsl	x8, x8, #2
               	add	x8, x1, x8
               	add	x9, x3, #0x4
               	add	x9, x9, #0xac
               	cmp	x9, x8
               	b.ne	<addr>
               	add	x2, x2, #0x2
               	lsl	x2, x2, #2
               	add	x1, x1, x2
               	add	x2, x3, #0x8
               	add	x2, x2, #0xac
               	cmp	x2, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	add	x4, x4, #0x1
               	cmp	w4, #0x3
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x6                // =6
               	ret
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x1                // =1
               	ret
