
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
               	b	<addr>
               	sxtw	x0, w1
               	mul	x2, x0, x4
               	add	x3, x2, #0x0
               	lsl	x3, x3, #1
               	add	x6, x3, #0x2
               	mul	x3, x0, x5
               	add	x7, x3, #0x0
               	add	x7, x7, #0x2
               	cmp	x7, x6
               	b.ne	<addr>
               	add	x6, x2, #0x1
               	lsl	x6, x6, #1
               	add	x6, x6, #0x2
               	add	x7, x3, #0x2
               	add	x7, x7, #0x2
               	cmp	x7, x6
               	b.ne	<addr>
               	add	x6, x2, #0x2
               	lsl	x6, x6, #1
               	add	x6, x6, #0x2
               	add	x7, x3, #0x4
               	add	x7, x7, #0x2
               	cmp	x7, x6
               	b.ne	<addr>
               	add	x6, x2, #0x3
               	lsl	x6, x6, #1
               	add	x6, x6, #0x2
               	add	x7, x3, #0x6
               	add	x7, x7, #0x2
               	cmp	x7, x6
               	b.ne	<addr>
               	add	x6, x2, #0x4
               	lsl	x6, x6, #1
               	add	x6, x6, #0x2
               	add	x7, x3, #0x8
               	add	x7, x7, #0x2
               	cmp	x7, x6
               	b.ne	<addr>
               	add	x6, x2, #0x5
               	lsl	x6, x6, #1
               	add	x6, x6, #0x2
               	add	x7, x3, #0xa
               	add	x7, x7, #0x2
               	cmp	x7, x6
               	b.ne	<addr>
               	add	x2, x2, #0x6
               	lsl	x2, x2, #1
               	add	x2, x2, #0x2
               	add	x3, x3, #0xc
               	add	x3, x3, #0x2
               	cmp	x3, x2
               	b.ne	<addr>
               	add	x1, x0, #0x1
               	cmp	w1, #0x5
               	b.lt	<addr>
               	mov	x3, #0x0                // =0
               	mov	x10, #0x3               // =3
               	mov	x11, #0x18              // =24
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x2, w3
               	mul	x4, x2, x10
               	sxtw	x1, w0
               	add	x5, x4, x1
               	lsl	x6, x5, #1
               	add	x7, x6, #0x0
               	lsl	x7, x7, #2
               	add	x12, x7, #0x48
               	mul	x7, x2, x11
               	lsl	x8, x1, #3
               	add	x9, x7, x8
               	add	x13, x9, #0x0
               	add	x13, x13, #0x48
               	cmp	x13, x12
               	b.ne	<addr>
               	add	x4, x6, #0x1
               	lsl	x4, x4, #2
               	add	x4, x4, #0x48
               	add	x2, x9, #0x4
               	add	x2, x2, #0x48
               	cmp	x2, x4
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	sxtw	x0, w3
               	add	x3, x0, #0x1
               	cmp	w3, #0x4
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	mov	x4, #0x6                // =6
               	mov	x5, #0x18               // =24
               	b	<addr>
               	sxtw	x1, w0
               	mul	x2, x1, x5
               	add	x3, x2, #0x0
               	add	x6, x3, #0x50
               	mul	x3, x1, x4
               	add	x7, x3, #0x0
               	lsl	x7, x7, #2
               	add	x7, x7, #0x50
               	cmp	x6, x7
               	b.ne	<addr>
               	add	x2, x2, #0x4
               	add	x2, x2, #0x50
               	add	x3, x3, #0x1
               	lsl	x3, x3, #2
               	add	x3, x3, #0x50
               	cmp	x2, x3
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	mov	x3, #0x0                // =0
               	mov	x9, #0x3                // =3
               	mov	x10, #0xc               // =12
               	mov	x11, #0x34              // =52
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	sxtw	x4, w3
               	mul	x0, x4, x11
               	add	x5, x0, #0xac
               	sxtw	x2, w1
               	mul	x6, x2, x9
               	add	x7, x6, #0x0
               	lsl	x7, x7, #2
               	add	x12, x5, x7
               	mul	x7, x2, x10
               	add	x8, x0, x7
               	add	x13, x8, #0x0
               	add	x13, x13, #0xac
               	cmp	x13, x12
               	b.ne	<addr>
               	add	x12, x6, #0x1
               	lsl	x12, x12, #2
               	add	x12, x5, x12
               	add	x13, x8, #0x4
               	add	x13, x13, #0xac
               	cmp	x13, x12
               	b.ne	<addr>
               	add	x4, x6, #0x2
               	lsl	x4, x4, #2
               	add	x4, x5, x4
               	add	x0, x8, #0x8
               	add	x0, x0, #0xac
               	cmp	x0, x4
               	b.ne	<addr>
               	add	x1, x2, #0x1
               	cmp	w1, #0x4
               	b.lt	<addr>
               	sxtw	x0, w3
               	add	x3, x0, #0x1
               	cmp	w3, #0x3
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
