
bitop_common_type_sign_extend.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	w0, w0
               	orr	x0, x0, x1
               	sxtw	x0, w0
               	ret

<mix_iu>:
               	mov	w1, w1
               	orr	x0, x0, x1
               	sxtw	x0, w0
               	ret

<xor_ui>:
               	mov	w0, w0
               	eor	x0, x0, x1
               	sxtw	x0, w0
               	ret

<and_ui>:
               	mov	w0, w0
               	and	x0, x0, x1
               	sxtw	x0, w0
               	ret

<pc_advance>:
               	mov	x2, x1
               	ldrb	w1, [x0]
               	lsl	x1, x1, #24
               	mov	w3, w1
               	ldrb	w1, [x0, #0x1]
               	lsl	x1, x1, #16
               	orr	x3, x3, x1
               	ldrb	w1, [x0, #0x2]
               	lsl	x1, x1, #8
               	orr	x1, x3, x1
               	ldrb	w0, [x0, #0x3]
               	orr	x0, x1, x0
               	sxtw	x0, w0
               	add	x0, x2, x0
               	sub	x0, x0, x2
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x0, x29, #0x8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x1]
               	strb	w10, [x0]
               	ldrb	w10, [x1, #0x1]
               	strb	w10, [x0, #0x1]
               	ldrb	w10, [x1, #0x2]
               	strb	w10, [x0, #0x2]
               	ldrb	w10, [x1, #0x3]
               	strb	w10, [x0, #0x3]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x8
               	sub	x1, x29, #0x18
               	add	x2, x1, #0x8
               	ldrb	w1, [x0]
               	lsl	x1, x1, #24
               	mov	w3, w1
               	ldrb	w1, [x0, #0x1]
               	lsl	x1, x1, #16
               	orr	x3, x3, x1
               	ldrb	w1, [x0, #0x2]
               	lsl	x1, x1, #8
               	orr	x1, x3, x1
               	ldrb	w0, [x0, #0x3]
               	orr	x0, x1, x0
               	sxtw	x0, w0
               	add	x0, x2, x0
               	sub	x0, x0, x2
               	mov	x17, #0xfdc2            // =64962
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
