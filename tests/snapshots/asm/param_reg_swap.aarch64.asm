
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
               	mov	x10, x0
               	mov	x8, x3
               	mov	x7, x1
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x4, x29, #0x40
               	mov	x17, #0x5               // =5
               	mul	x1, x0, x17
               	sxtw	x5, w1
               	lsl	x1, x0, #2
               	sxtw	x1, w1
               	add	x1, x8, x1
               	ldrb	w6, [x1, #0x3]
               	mov	w6, w6
               	lsl	x6, x6, #8
               	mov	w6, w6
               	ldrb	w9, [x1, #0x2]
               	orr	x6, x6, x9
               	mov	w6, w6
               	lsl	x6, x6, #8
               	mov	w6, w6
               	ldrb	w9, [x1, #0x1]
               	orr	x6, x6, x9
               	mov	w6, w6
               	lsl	x6, x6, #8
               	mov	w6, w6
               	ldrb	w1, [x1]
               	orr	x1, x6, x1
               	str	w1, [x4, x5, lsl #2]
               	sub	x4, x29, #0x40
               	add	x1, x0, #0x1
               	sxtw	x5, w1
               	lsl	x1, x0, #2
               	sxtw	x1, w1
               	add	x1, x2, x1
               	ldrb	w6, [x1, #0x3]
               	mov	w6, w6
               	lsl	x6, x6, #8
               	mov	w6, w6
               	ldrb	w9, [x1, #0x2]
               	orr	x6, x6, x9
               	mov	w6, w6
               	lsl	x6, x6, #8
               	mov	w6, w6
               	ldrb	w9, [x1, #0x1]
               	orr	x6, x6, x9
               	mov	w6, w6
               	lsl	x6, x6, #8
               	mov	w6, w6
               	ldrb	w1, [x1]
               	orr	x1, x6, x1
               	str	w1, [x4, x5, lsl #2]
               	sub	x4, x29, #0x40
               	add	x1, x0, #0x6
               	sxtw	x5, w1
               	lsl	x1, x0, #2
               	sxtw	x1, w1
               	add	x1, x7, x1
               	ldrb	w6, [x1, #0x3]
               	mov	w6, w6
               	lsl	x6, x6, #8
               	mov	w6, w6
               	ldrb	w9, [x1, #0x2]
               	orr	x6, x6, x9
               	mov	w6, w6
               	lsl	x6, x6, #8
               	mov	w6, w6
               	ldrb	w9, [x1, #0x1]
               	orr	x6, x6, x9
               	mov	w6, w6
               	lsl	x6, x6, #8
               	mov	w6, w6
               	ldrb	w1, [x1]
               	orr	x1, x6, x1
               	str	w1, [x4, x5, lsl #2]
               	sub	x4, x29, #0x40
               	add	x1, x0, #0xb
               	sxtw	x5, w1
               	add	x6, x2, #0x10
               	lsl	x1, x0, #2
               	sxtw	x1, w1
               	add	x1, x6, x1
               	ldrb	w6, [x1, #0x3]
               	mov	w6, w6
               	lsl	x6, x6, #8
               	mov	w6, w6
               	ldrb	w9, [x1, #0x2]
               	orr	x6, x6, x9
               	mov	w6, w6
               	lsl	x6, x6, #8
               	mov	w6, w6
               	ldrb	w9, [x1, #0x1]
               	orr	x6, x6, x9
               	mov	w6, w6
               	lsl	x6, x6, #8
               	mov	w6, w6
               	ldrb	w1, [x1]
               	orr	x1, x6, x1
               	str	w1, [x4, x5, lsl #2]
               	add	x0, x3, #0x1
               	sxtw	x3, w0
               	cmp	x3, #0x4
               	b.lt	<addr>
               	mov	x1, #0x0                // =0
               	sub	x0, x29, #0x40
               	ldr	w2, [x0]
               	sub	x0, x29, #0x40
               	ldr	w0, [x0, #0x14]
               	eor	x2, x2, x0
               	sub	x0, x29, #0x40
               	ldr	w0, [x0, #0x28]
               	eor	x2, x2, x0
               	sub	x0, x29, #0x40
               	ldr	w0, [x0, #0x3c]
               	eor	x0, x2, x0
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	strb	w0, [x10]
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
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x38
               	add	x2, x2, x1
               	mov	x17, #0xff              // =255
               	and	x3, x1, x17
               	strb	w3, [x2]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x20
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
