
divide_in_loop_live_values.aarch64:	file format elf64-littleaarch64

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

<sum_div_mod>:
               	mov	x4, x0
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	ldrsw	x3, [x4, x0, lsl #2]
               	sdiv	w5, w3, w2
               	sdiv	w17, w3, w2
               	msub	w3, w17, w2, w3
               	add	x3, x5, x3
               	add	x1, x1, x3
               	add	x0, x0, #0x1
               	cmp	w0, #0x40
               	b.lt	<addr>
               	mov	x0, x1
               	ret

<mix>:
               	mov	x4, x0
               	mov	x0, #0x1                // =1
               	mov	x1, #0x0                // =0
               	mov	x5, #0x1f               // =31
               	ldr	x3, [x4, x1, lsl #3]
               	udiv	x6, x3, x2
               	udiv	x17, x3, x2
               	msub	x3, x17, x2, x3
               	mul	x0, x0, x5
               	add	x3, x3, #0x1
               	udiv	x3, x6, x3
               	add	x0, x0, x3
               	add	x1, x1, #0x1
               	cmp	w1, #0x40
               	b.lt	<addr>
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x320
               	stp	x20, x21, [sp]
               	mov	x0, #0x7                // =7
               	stur	w0, [x29, #-0x10]
               	mov	x0, #0xd                // =13
               	stur	x0, [x29, #-0x8]
               	mov	x20, #0x0               // =0
               	mov	x21, #0x1               // =1
               	mov	x1, #0x25               // =37
               	mov	x2, #0x79b9             // =31161
               	movk	x2, #0x9e37, lsl #16
               	mov	x0, x20
               	sub	x3, x29, #0x310
               	mul	x4, x0, x1
               	sub	x4, x4, #0x384
               	str	w4, [x3, x0, lsl #2]
               	sub	x3, x29, #0x210
               	mul	x4, x0, x2
               	add	x4, x4, #0x5
               	str	x4, [x3, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x40
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	mov	x5, #0x7                // =7
               	mov	x6, #0xd                // =13
               	mov	x7, #0x1f               // =31
               	mov	x2, #0x2493             // =9363
               	movk	x2, #0x9249, lsl #16
               	mov	x3, #0x4ec5             // =20165
               	movk	x3, #0xc4ec, lsl #16
               	movk	x3, #0xec4e, lsl #32
               	movk	x3, #0x4ec4, lsl #48
               	sub	x1, x29, #0x310
               	ldrsw	x1, [x1, x0, lsl #2]
               	mul	x4, x1, x2
               	asr	x4, x4, #34
               	add	x8, x4, x4, lsr #63
               	mul	x4, x1, x2
               	asr	x4, x4, #34
               	add	x4, x4, x4, lsr #63
               	mul	x4, x4, x5
               	sub	x1, x1, x4
               	add	x1, x8, x1
               	add	x20, x20, x1
               	mul	x4, x21, x7
               	sub	x1, x29, #0x210
               	ldr	x1, [x1, x0, lsl #3]
               	umulh	x8, x1, x3
               	lsr	x8, x8, #2
               	umulh	x9, x1, x3
               	lsr	x9, x9, #2
               	mul	x9, x9, x6
               	sub	x1, x1, x9
               	add	x1, x1, #0x1
               	udiv	x1, x8, x1
               	add	x21, x4, x1
               	add	x0, x0, #0x1
               	cmp	w0, #0x40
               	b.lt	<addr>
               	sub	x0, x29, #0x310
               	mov	x1, #0x40               // =64
               	ldursw	x2, [x29, #-0x10]
               	bl	<addr>
               	cmp	w0, w20
               	cset	x20, ne
               	sub	x0, x29, #0x210
               	mov	x1, #0x40               // =64
               	ldur	x2, [x29, #-0x8]
               	bl	<addr>
               	cmp	x0, x21
               	cset	x0, ne
               	add	x0, x20, x0, lsl #1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x320
               	ldp	x29, x30, [sp], #0x10
               	ret
