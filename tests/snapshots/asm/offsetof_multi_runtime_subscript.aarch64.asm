
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
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x2, w3
               	mov	x17, #0x7               // =7
               	mul	x4, x2, x17
               	sxtw	x1, w0
               	add	x4, x4, x1
               	lsl	x4, x4, #1
               	add	x4, x4, #0x2
               	mov	x17, #0xe               // =14
               	mul	x2, x2, x17
               	lsl	x5, x1, #1
               	add	x2, x2, x5
               	add	x2, x2, #0x2
               	cmp	x2, x4
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x7
               	b.lt	<addr>
               	sxtw	x0, w3
               	add	x3, x0, #0x1
               	cmp	w3, #0x5
               	b.lt	<addr>
               	mov	x5, #0x0                // =0
               	b	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x2, w5
               	mov	x17, #0x3               // =3
               	mul	x1, x2, x17
               	sxtw	x3, w4
               	add	x1, x1, x3
               	lsl	x6, x1, #1
               	sxtw	x1, w0
               	add	x6, x6, x1
               	lsl	x6, x6, #2
               	add	x6, x6, #0x48
               	mov	x17, #0x18              // =24
               	mul	x2, x2, x17
               	lsl	x3, x3, #3
               	add	x2, x2, x3
               	lsl	x3, x1, #2
               	add	x2, x2, x3
               	add	x2, x2, #0x48
               	cmp	x2, x6
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sxtw	x0, w4
               	add	x4, x0, #0x1
               	cmp	w4, #0x3
               	b.lt	<addr>
               	sxtw	x0, w5
               	add	x5, x0, #0x1
               	cmp	w5, #0x4
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x0, w0
               	add	x0, x0, #0x1
               	cmp	w0, #0x7
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x1, w0
               	mov	x17, #0xe               // =14
               	mul	x2, x1, x17
               	add	x2, x2, #0x8
               	mov	x17, #0x7               // =7
               	mul	x3, x1, x17
               	lsl	x3, x3, #1
               	add	x3, x3, #0x8
               	cmp	x2, x3
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x5
               	b.lt	<addr>
               	mov	x3, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x2, w3
               	mov	x17, #0x18              // =24
               	mul	x4, x2, x17
               	sxtw	x1, w0
               	lsl	x5, x1, #2
               	add	x4, x4, x5
               	add	x4, x4, #0x50
               	mov	x17, #0x6               // =6
               	mul	x2, x2, x17
               	add	x2, x2, x1
               	lsl	x2, x2, #2
               	add	x2, x2, #0x50
               	cmp	x4, x2
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sxtw	x0, w3
               	add	x3, x0, #0x1
               	cmp	w3, #0x4
               	b.lt	<addr>
               	mov	x5, #0x0                // =0
               	b	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x1, w5
               	mov	x17, #0x34              // =52
               	mul	x1, x1, x17
               	add	x6, x1, #0xac
               	sxtw	x3, w4
               	mov	x17, #0x3               // =3
               	mul	x7, x3, x17
               	sxtw	x2, w0
               	add	x7, x7, x2
               	lsl	x7, x7, #2
               	add	x6, x6, x7
               	mov	x17, #0xc               // =12
               	mul	x3, x3, x17
               	add	x1, x1, x3
               	lsl	x3, x2, #2
               	add	x1, x1, x3
               	add	x1, x1, #0xac
               	cmp	x1, x6
               	b.ne	<addr>
               	add	x0, x2, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	sxtw	x0, w4
               	add	x4, x0, #0x1
               	cmp	w4, #0x4
               	b.lt	<addr>
               	sxtw	x0, w5
               	add	x5, x0, #0x1
               	cmp	w5, #0x3
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
