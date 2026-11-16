
vla_parameter.aarch64:	file format elf64-littleaarch64

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

<rows>:
               	sxtw	x0, w0
               	add	x2, x1, x0
               	sub	x1, x2, x1
               	cmp	x1, x0
               	cset	x0, eq
               	ret

<sum>:
               	sxtw	x0, w0
               	lsl	x5, x0, #2
               	mov	x4, #0x0                // =0
               	mov	x3, x4
               	mov	x2, #0x0                // =0
               	cmp	w2, w0
               	b.ge	<addr>
               	madd	x6, x4, x5, x1
               	ldrsw	x6, [x6, x2, lsl #2]
               	add	x3, x3, x6
               	add	x2, x2, #0x1
               	cmp	w2, w0
               	b.lt	<addr>
               	add	x4, x4, #0x1
               	cmp	w4, #0x2
               	b.lt	<addr>
               	sxtw	x0, w5
               	add	x0, x0, x0, lsr #62
               	asr	x0, x0, #2
               	mov	x17, #0x3e8             // =1000
               	mul	x0, x0, x17
               	add	x0, x3, x0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	sub	x5, x29, #0x60
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x5]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x5, #0x10]
               	sub	x0, x29, #0x48
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	ldr	x16, [x1, #0x40]
               	str	x16, [x0, #0x40]
               	sub	x1, x29, #0x10
               	add	x0, x1, #0x5
               	sub	x1, x0, x1
               	cmp	x1, #0x5
               	cset	x1, eq
               	cmp	w1, #0x0
               	cset	x1, eq
               	add	x2, x0, #0x5
               	sub	x0, x2, x0
               	cmp	x0, #0x5
               	cset	x0, eq
               	cmp	w0, #0x0
               	cset	x0, eq
               	orr	x7, x1, x0, lsl #1
               	mov	x6, #0xc                // =12
               	mov	x4, #0x0                // =0
               	mov	x1, x4
               	mul	x0, x4, x6
               	add	x2, x5, x0
               	mov	x0, #0x0                // =0
               	ldrsw	x3, [x2, x0, lsl #2]
               	add	x1, x1, x3
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	add	x4, x4, #0x1
               	cmp	w4, #0x2
               	b.lt	<addr>
               	add	x0, x1, #0xbb8
               	cmp	w0, #0xbcd
               	cset	x0, ne
               	orr	x5, x7, x0, lsl #2
               	sub	x2, x29, #0x48
               	mov	x3, #0x18               // =24
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	mul	x4, x0, x3
               	add	x4, x2, x4
               	ldr	x4, [x4, x0, lsl #3]
               	add	x1, x1, x4
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	add	x0, x1, #0xc8
               	mov	x17, #0x7530            // =30000
               	add	x0, x0, x17
               	mov	x17, #0x75fe            // =30206
               	cmp	w0, w17
               	cset	x0, ne
               	orr	x0, x5, x0, lsl #3
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
