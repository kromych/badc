
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
               	sub	x6, x29, #0x40
               	mov	x17, #0x5               // =5
               	mul	x7, x5, x17
               	sxtw	x7, w7
               	lsl	x8, x5, #2
               	sxtw	x8, w8
               	add	x8, x3, x8
               	ldrb	w9, [x8, #0x3]
               	mov	w9, w9
               	lsl	x9, x9, #8
               	mov	w9, w9
               	ldrb	w10, [x8, #0x2]
               	orr	x9, x9, x10
               	mov	w9, w9
               	lsl	x9, x9, #8
               	mov	w9, w9
               	ldrb	w10, [x8, #0x1]
               	orr	x9, x9, x10
               	mov	w9, w9
               	lsl	x9, x9, #8
               	mov	w9, w9
               	ldrb	w8, [x8]
               	orr	x8, x9, x8
               	str	w8, [x6, x7, lsl #2]
               	sub	x6, x29, #0x40
               	add	x7, x5, #0x1
               	sxtw	x7, w7
               	lsl	x8, x5, #2
               	sxtw	x8, w8
               	add	x8, x2, x8
               	ldrb	w9, [x8, #0x3]
               	mov	w9, w9
               	lsl	x9, x9, #8
               	mov	w9, w9
               	ldrb	w10, [x8, #0x2]
               	orr	x9, x9, x10
               	mov	w9, w9
               	lsl	x9, x9, #8
               	mov	w9, w9
               	ldrb	w10, [x8, #0x1]
               	orr	x9, x9, x10
               	mov	w9, w9
               	lsl	x9, x9, #8
               	mov	w9, w9
               	ldrb	w8, [x8]
               	orr	x8, x9, x8
               	str	w8, [x6, x7, lsl #2]
               	sub	x6, x29, #0x40
               	add	x7, x5, #0x6
               	sxtw	x7, w7
               	lsl	x8, x5, #2
               	sxtw	x8, w8
               	add	x8, x1, x8
               	ldrb	w9, [x8, #0x3]
               	mov	w9, w9
               	lsl	x9, x9, #8
               	mov	w9, w9
               	ldrb	w10, [x8, #0x2]
               	orr	x9, x9, x10
               	mov	w9, w9
               	lsl	x9, x9, #8
               	mov	w9, w9
               	ldrb	w10, [x8, #0x1]
               	orr	x9, x9, x10
               	mov	w9, w9
               	lsl	x9, x9, #8
               	mov	w9, w9
               	ldrb	w8, [x8]
               	orr	x8, x9, x8
               	str	w8, [x6, x7, lsl #2]
               	sub	x6, x29, #0x40
               	add	x7, x5, #0xb
               	sxtw	x7, w7
               	add	x8, x2, #0x10
               	lsl	x9, x5, #2
               	sxtw	x9, w9
               	add	x8, x8, x9
               	ldrb	w9, [x8, #0x3]
               	mov	w9, w9
               	lsl	x9, x9, #8
               	mov	w9, w9
               	ldrb	w10, [x8, #0x2]
               	orr	x9, x9, x10
               	mov	w9, w9
               	lsl	x9, x9, #8
               	mov	w9, w9
               	ldrb	w10, [x8, #0x1]
               	orr	x9, x9, x10
               	mov	w9, w9
               	lsl	x9, x9, #8
               	mov	w9, w9
               	ldrb	w8, [x8]
               	orr	x8, x9, x8
               	str	w8, [x6, x7, lsl #2]
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
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x0
               	mov	x1, #0x0                // =0
               	strb	w1, [x0]
               	sub	x0, x29, #0x18
               	mov	x1, #0x1                // =1
               	strb	w1, [x0, #0x1]
               	sub	x0, x29, #0x18
               	mov	x1, #0x2                // =2
               	strb	w1, [x0, #0x2]
               	sub	x0, x29, #0x18
               	mov	x1, #0x3                // =3
               	strb	w1, [x0, #0x3]
               	sub	x0, x29, #0x18
               	mov	x1, #0x4                // =4
               	strb	w1, [x0, #0x4]
               	sub	x0, x29, #0x18
               	mov	x1, #0x5                // =5
               	strb	w1, [x0, #0x5]
               	sub	x0, x29, #0x18
               	mov	x1, #0x6                // =6
               	strb	w1, [x0, #0x6]
               	sub	x0, x29, #0x18
               	mov	x1, #0x7                // =7
               	strb	w1, [x0, #0x7]
               	sub	x0, x29, #0x18
               	mov	x1, #0x8                // =8
               	strb	w1, [x0, #0x8]
               	sub	x0, x29, #0x18
               	mov	x1, #0x9                // =9
               	strb	w1, [x0, #0x9]
               	sub	x0, x29, #0x18
               	mov	x1, #0xa                // =10
               	strb	w1, [x0, #0xa]
               	sub	x0, x29, #0x18
               	mov	x1, #0xb                // =11
               	strb	w1, [x0, #0xb]
               	sub	x0, x29, #0x18
               	mov	x1, #0xc                // =12
               	strb	w1, [x0, #0xc]
               	sub	x0, x29, #0x18
               	mov	x1, #0xd                // =13
               	strb	w1, [x0, #0xd]
               	sub	x0, x29, #0x18
               	mov	x1, #0xe                // =14
               	strb	w1, [x0, #0xe]
               	sub	x0, x29, #0x18
               	mov	x1, #0xf                // =15
               	strb	w1, [x0, #0xf]
               	mov	x1, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x38
               	add	x2, x2, x0
               	mov	x17, #0xff              // =255
               	and	x3, x0, x17
               	strb	w3, [x2]
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
