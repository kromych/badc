
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
               	mov	x0, #0x0                // =0
               	mov	x3, #0x7                // =7
               	mov	x4, #0xe                // =14
               	cmp	w0, #0x5
               	b.ge	<addr>
               	mul	x1, x0, x3
               	add	x2, x1, #0x0
               	lsl	x2, x2, #1
               	add	x5, x2, #0x2
               	mul	x2, x0, x4
               	add	x6, x2, #0x0
               	add	x6, x6, #0x2
               	cmp	x6, x5
               	b.ne	<addr>
               	add	x5, x1, #0x1
               	lsl	x5, x5, #1
               	add	x5, x5, #0x2
               	add	x6, x2, #0x2
               	add	x6, x6, #0x2
               	cmp	x6, x5
               	b.ne	<addr>
               	add	x5, x1, #0x2
               	lsl	x5, x5, #1
               	add	x5, x5, #0x2
               	add	x6, x2, #0x4
               	add	x6, x6, #0x2
               	cmp	x6, x5
               	b.ne	<addr>
               	add	x5, x1, #0x3
               	lsl	x5, x5, #1
               	add	x5, x5, #0x2
               	add	x6, x2, #0x6
               	add	x6, x6, #0x2
               	cmp	x6, x5
               	b.ne	<addr>
               	add	x5, x1, #0x4
               	lsl	x5, x5, #1
               	add	x5, x5, #0x2
               	add	x6, x2, #0x8
               	add	x6, x6, #0x2
               	cmp	x6, x5
               	b.ne	<addr>
               	add	x5, x1, #0x5
               	lsl	x5, x5, #1
               	add	x5, x5, #0x2
               	add	x6, x2, #0xa
               	add	x6, x6, #0x2
               	cmp	x6, x5
               	b.ne	<addr>
               	add	x1, x1, #0x6
               	lsl	x1, x1, #1
               	add	x1, x1, #0x2
               	add	x2, x2, #0xc
               	add	x2, x2, #0x2
               	cmp	x2, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x5
               	b.lt	<addr>
               	mov	x1, #0x0                // =0
               	mov	x8, #0x3                // =3
               	mov	x9, #0x18               // =24
               	cmp	w1, #0x4
               	b.ge	<addr>
               	mov	x0, #0x0                // =0
               	cmp	w0, #0x3
               	b.ge	<addr>
               	mul	x2, x1, x8
               	add	x3, x2, x0
               	lsl	x4, x3, #1
               	add	x5, x4, #0x0
               	lsl	x5, x5, #2
               	add	x10, x5, #0x48
               	mul	x5, x1, x9
               	lsl	x6, x0, #3
               	add	x7, x5, x6
               	add	x11, x7, #0x0
               	add	x11, x11, #0x48
               	cmp	x11, x10
               	b.ne	<addr>
               	add	x2, x4, #0x1
               	lsl	x2, x2, #2
               	add	x2, x2, #0x48
               	add	x3, x7, #0x4
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
               	cmp	w0, #0x4
               	b.ge	<addr>
               	mul	x1, x0, x4
               	add	x2, x1, #0x0
               	add	x5, x2, #0x50
               	mul	x2, x0, x3
               	add	x6, x2, #0x0
               	lsl	x6, x6, #2
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
               	mov	x2, #0x0                // =0
               	mov	x7, #0x3                // =3
               	mov	x8, #0xc                // =12
               	mov	x9, #0x34               // =52
               	cmp	w2, #0x3
               	b.ge	<addr>
               	mov	x0, #0x0                // =0
               	cmp	w0, #0x4
               	b.ge	<addr>
               	mul	x1, x2, x9
               	add	x3, x1, #0xac
               	mul	x4, x0, x7
               	add	x5, x4, #0x0
               	lsl	x5, x5, #2
               	add	x10, x3, x5
               	mul	x5, x0, x8
               	add	x6, x1, x5
               	add	x11, x6, #0x0
               	add	x11, x11, #0xac
               	cmp	x11, x10
               	b.ne	<addr>
               	add	x10, x4, #0x1
               	lsl	x10, x10, #2
               	add	x10, x3, x10
               	add	x11, x6, #0x4
               	add	x11, x11, #0xac
               	cmp	x11, x10
               	b.ne	<addr>
               	add	x4, x4, #0x2
               	lsl	x4, x4, #2
               	add	x3, x3, x4
               	add	x1, x6, #0x8
               	add	x1, x1, #0xac
               	cmp	x1, x3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	add	x2, x2, #0x1
               	cmp	w2, #0x3
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
