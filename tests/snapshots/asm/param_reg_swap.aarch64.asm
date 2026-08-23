
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
               	str	x20, [sp, #-0x60]!
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	sub	x1, x29, #0x30
               	add	x2, x1, #0x0
               	mov	x0, #0x0                // =0
               	strb	w0, [x2]
               	mov	x2, #0x1                // =1
               	strb	w2, [x1, #0x1]
               	mov	x2, #0x2                // =2
               	strb	w2, [x1, #0x2]
               	mov	x2, #0x3                // =3
               	strb	w2, [x1, #0x3]
               	mov	x2, #0x4                // =4
               	strb	w2, [x1, #0x4]
               	mov	x2, #0x5                // =5
               	strb	w2, [x1, #0x5]
               	mov	x2, #0x6                // =6
               	strb	w2, [x1, #0x6]
               	mov	x2, #0x7                // =7
               	strb	w2, [x1, #0x7]
               	mov	x2, #0x8                // =8
               	strb	w2, [x1, #0x8]
               	mov	x2, #0x9                // =9
               	strb	w2, [x1, #0x9]
               	mov	x2, #0xa                // =10
               	strb	w2, [x1, #0xa]
               	mov	x2, #0xb                // =11
               	strb	w2, [x1, #0xb]
               	mov	x2, #0xc                // =12
               	strb	w2, [x1, #0xc]
               	mov	x2, #0xd                // =13
               	strb	w2, [x1, #0xd]
               	mov	x2, #0xe                // =14
               	strb	w2, [x1, #0xe]
               	mov	x2, #0xf                // =15
               	strb	w2, [x1, #0xf]
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
               	sub	x20, x29, #0x38
               	sub	x1, x29, #0x30
               	sub	x2, x29, #0x20
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x0, x20
               	bl	<addr>
               	ldrb	w0, [x20]
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
