
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
               	ldr	w1, [x3]
               	ldr	w2, [x3, #0x4]
               	ldr	w4, [x3, #0x8]
               	ldr	w3, [x3, #0xc]
               	eor	x1, x1, x2
               	eor	x1, x1, x4
               	eor	x1, x1, x3
               	and	x1, x1, #0xff
               	strb	w1, [x0]
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	mov	x0, #0x0                // =0
               	sturb	w0, [x29, #-0x30]
               	mov	x1, #0x1                // =1
               	sturb	w1, [x29, #-0x2f]
               	mov	x1, #0x2                // =2
               	sturb	w1, [x29, #-0x2e]
               	mov	x1, #0x3                // =3
               	sturb	w1, [x29, #-0x2d]
               	mov	x1, #0x4                // =4
               	sturb	w1, [x29, #-0x2c]
               	mov	x1, #0x5                // =5
               	sturb	w1, [x29, #-0x2b]
               	mov	x1, #0x6                // =6
               	sturb	w1, [x29, #-0x2a]
               	mov	x1, #0x7                // =7
               	sturb	w1, [x29, #-0x29]
               	mov	x1, #0x8                // =8
               	sturb	w1, [x29, #-0x28]
               	mov	x1, #0x9                // =9
               	sturb	w1, [x29, #-0x27]
               	mov	x1, #0xa                // =10
               	sturb	w1, [x29, #-0x26]
               	mov	x1, #0xb                // =11
               	sturb	w1, [x29, #-0x25]
               	mov	x1, #0xc                // =12
               	sturb	w1, [x29, #-0x24]
               	mov	x1, #0xd                // =13
               	sturb	w1, [x29, #-0x23]
               	mov	x1, #0xe                // =14
               	sturb	w1, [x29, #-0x22]
               	mov	x1, #0xf                // =15
               	sturb	w1, [x29, #-0x21]
               	sub	x1, x29, #0x20
               	strb	w0, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x20
               	b.lt	<addr>
               	sub	x0, x29, #0x38
               	sub	x1, x29, #0x30
               	sub	x2, x29, #0x20
               	adrp	x3, <addr>
               	add	x3, x3, <lo12>
               	bl	<addr>
               	ldurb	w0, [x29, #-0x38]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
