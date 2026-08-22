
param_reg_swap.aarch64:	file format elf64-littleaarch64

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

<core>:
               	mov	x7, x0
               	add	x0, x3, #0x0
               	ldr	w0, [x0]
               	mov	w0, w0
               	ldr	w4, [x3, #0x4]
               	mov	w4, w4
               	ldr	w5, [x3, #0x8]
               	mov	w5, w5
               	ldr	w3, [x3, #0xc]
               	mov	w3, w3
               	mov	x1, #0x0                // =0
               	mov	w0, w0
               	mov	w2, w4
               	eor	x0, x0, x2
               	mov	w2, w5
               	eor	x0, x0, x2
               	mov	w2, w3
               	eor	x0, x0, x2
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	strb	w0, [x7]
               	mov	x0, x1
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	x0, x29, #0x30
               	add	x0, x0, #0x0
               	mov	x1, #0x0                // =0
               	strb	w1, [x0]
               	sub	x0, x29, #0x30
               	mov	x1, #0x1                // =1
               	strb	w1, [x0, #0x1]
               	sub	x0, x29, #0x30
               	mov	x1, #0x2                // =2
               	strb	w1, [x0, #0x2]
               	sub	x0, x29, #0x30
               	mov	x1, #0x3                // =3
               	strb	w1, [x0, #0x3]
               	sub	x0, x29, #0x30
               	mov	x1, #0x4                // =4
               	strb	w1, [x0, #0x4]
               	sub	x0, x29, #0x30
               	mov	x1, #0x5                // =5
               	strb	w1, [x0, #0x5]
               	sub	x0, x29, #0x30
               	mov	x1, #0x6                // =6
               	strb	w1, [x0, #0x6]
               	sub	x0, x29, #0x30
               	mov	x1, #0x7                // =7
               	strb	w1, [x0, #0x7]
               	sub	x0, x29, #0x30
               	mov	x1, #0x8                // =8
               	strb	w1, [x0, #0x8]
               	sub	x0, x29, #0x30
               	mov	x1, #0x9                // =9
               	strb	w1, [x0, #0x9]
               	sub	x0, x29, #0x30
               	mov	x1, #0xa                // =10
               	strb	w1, [x0, #0xa]
               	sub	x0, x29, #0x30
               	mov	x1, #0xb                // =11
               	strb	w1, [x0, #0xb]
               	sub	x0, x29, #0x30
               	mov	x1, #0xc                // =12
               	strb	w1, [x0, #0xc]
               	sub	x0, x29, #0x30
               	mov	x1, #0xd                // =13
               	strb	w1, [x0, #0xd]
               	sub	x0, x29, #0x30
               	mov	x1, #0xe                // =14
               	strb	w1, [x0, #0xe]
               	sub	x0, x29, #0x30
               	mov	x1, #0xf                // =15
               	strb	w1, [x0, #0xf]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x20
               	add	x2, x2, x1
               	mov	x17, #0xff              // =255
               	and	x3, x1, x17
               	strb	w3, [x2]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x20
               	b.lt	<addr>
               	sub	x0, x29, #0x38
               	sub	x1, x29, #0x30
               	sub	x2, x29, #0x20
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	bl	<addr>
               	sub	x0, x29, #0x38
               	ldrb	w0, [x0]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
