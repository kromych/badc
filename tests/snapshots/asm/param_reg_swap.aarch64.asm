
param_reg_swap.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	ldrb	w1, [x0, #0x3]
               	mov	w1, w1
               	lsl	x1, x1, #8
               	mov	w1, w1
               	ldrb	w2, [x0, #0x2]
               	orr	x1, x1, x2
               	mov	w1, w1
               	lsl	x1, x1, #8
               	mov	w1, w1
               	ldrb	w2, [x0, #0x1]
               	orr	x1, x1, x2
               	mov	w1, w1
               	lsl	x1, x1, #8
               	mov	w1, w1
               	ldrb	w0, [x0]
               	orr	x0, x1, x0
               	ret

<core>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	mov	x5, #0x0                // =0
               	b	<addr>
               	sub	x4, x29, #0x40
               	mov	x17, #0x5               // =5
               	mul	x6, x5, x17
               	sxtw	x6, w6
               	lsl	x7, x5, #2
               	sxtw	x7, w7
               	add	x7, x3, x7
               	ldrb	w8, [x7, #0x3]
               	mov	w8, w8
               	lsl	x8, x8, #8
               	mov	w8, w8
               	ldrb	w9, [x7, #0x2]
               	orr	x8, x8, x9
               	mov	w8, w8
               	lsl	x8, x8, #8
               	mov	w8, w8
               	ldrb	w9, [x7, #0x1]
               	orr	x8, x8, x9
               	mov	w8, w8
               	lsl	x8, x8, #8
               	mov	w8, w8
               	ldrb	w7, [x7]
               	orr	x7, x8, x7
               	str	w7, [x4, x6, lsl #2]
               	sub	x4, x29, #0x40
               	add	x6, x5, #0x1
               	sxtw	x6, w6
               	lsl	x7, x5, #2
               	sxtw	x7, w7
               	add	x7, x2, x7
               	ldrb	w8, [x7, #0x3]
               	mov	w8, w8
               	lsl	x8, x8, #8
               	mov	w8, w8
               	ldrb	w9, [x7, #0x2]
               	orr	x8, x8, x9
               	mov	w8, w8
               	lsl	x8, x8, #8
               	mov	w8, w8
               	ldrb	w9, [x7, #0x1]
               	orr	x8, x8, x9
               	mov	w8, w8
               	lsl	x8, x8, #8
               	mov	w8, w8
               	ldrb	w7, [x7]
               	orr	x7, x8, x7
               	str	w7, [x4, x6, lsl #2]
               	sub	x4, x29, #0x40
               	add	x6, x5, #0x6
               	sxtw	x6, w6
               	lsl	x7, x5, #2
               	sxtw	x7, w7
               	add	x7, x1, x7
               	ldrb	w8, [x7, #0x3]
               	mov	w8, w8
               	lsl	x8, x8, #8
               	mov	w8, w8
               	ldrb	w9, [x7, #0x2]
               	orr	x8, x8, x9
               	mov	w8, w8
               	lsl	x8, x8, #8
               	mov	w8, w8
               	ldrb	w9, [x7, #0x1]
               	orr	x8, x8, x9
               	mov	w8, w8
               	lsl	x8, x8, #8
               	mov	w8, w8
               	ldrb	w7, [x7]
               	orr	x7, x8, x7
               	str	w7, [x4, x6, lsl #2]
               	sub	x4, x29, #0x40
               	add	x6, x5, #0xb
               	sxtw	x6, w6
               	add	x7, x2, #0x10
               	lsl	x8, x5, #2
               	sxtw	x8, w8
               	add	x7, x7, x8
               	ldrb	w8, [x7, #0x3]
               	mov	w8, w8
               	lsl	x8, x8, #8
               	mov	w8, w8
               	ldrb	w9, [x7, #0x2]
               	orr	x8, x8, x9
               	mov	w8, w8
               	lsl	x8, x8, #8
               	mov	w8, w8
               	ldrb	w9, [x7, #0x1]
               	orr	x8, x8, x9
               	mov	w8, w8
               	lsl	x8, x8, #8
               	mov	w8, w8
               	ldrb	w7, [x7]
               	orr	x7, x8, x7
               	str	w7, [x4, x6, lsl #2]
               	sxtw	x4, w5
               	add	x5, x4, #0x1
               	sxtw	x4, w5
               	cmp	x4, #0x4
               	b.lt	<addr>
               	mov	x1, #0x0                // =0
               	sub	x2, x29, #0x40
               	ldr	w2, [x2]
               	sub	x3, x29, #0x40
               	ldr	w3, [x3, #0x14]
               	eor	x2, x2, x3
               	sub	x3, x29, #0x40
               	ldr	w3, [x3, #0x28]
               	eor	x2, x2, x3
               	sub	x3, x29, #0x40
               	ldr	w3, [x3, #0x3c]
               	eor	x2, x2, x3
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	strb	w2, [x0]
               	mov	x0, x1
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	mov	x1, #0x0                // =0
               	b	<addr>
               	sub	x0, x29, #0x18
               	sxtw	x2, w1
               	add	x0, x0, x2
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	strb	w2, [x0]
               	sxtw	x0, w1
               	add	x1, x0, #0x1
               	sxtw	x0, w1
               	cmp	x0, #0x10
               	b.lt	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	sub	x0, x29, #0x38
               	sxtw	x2, w1
               	add	x0, x0, x2
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	strb	w2, [x0]
               	sxtw	x0, w1
               	add	x1, x0, #0x1
               	sxtw	x0, w1
               	cmp	x0, #0x20
               	b.lt	<addr>
               	sub	x0, x29, #0x8
               	sub	x1, x29, #0x18
               	sub	x2, x29, #0x38
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	bl	<addr>
               	sub	x0, x29, #0x8
               	ldrb	w0, [x0]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
