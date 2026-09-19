
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
               	mov	x10, x0
               	add	x0, x3, #0x0
               	ldr	w0, [x0]
               	ldr	w5, [x3, #0x4]
               	ldr	w7, [x3, #0x8]
               	ldr	w3, [x3, #0xc]
               	eor	x0, x0, x5
               	eor	x0, x0, x7
               	eor	x0, x0, x3
               	and	x0, x0, #0xff
               	strb	w0, [x10]
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
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
               	cmp	w0, #0x20
               	b.ge	<addr>
               	sub	x2, x29, #0x20
               	sxtw	x1, w0
               	and	x3, x1, #0xff
               	strb	w3, [x2, x1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x20
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
