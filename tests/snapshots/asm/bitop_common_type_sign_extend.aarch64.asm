
bitop_common_type_sign_extend.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sxtw	x1, w1
               	mov	w0, w0
               	orr	x0, x0, x1
               	sxtw	x0, w0
               	ret

<mix_iu>:
               	sxtw	x0, w0
               	mov	w1, w1
               	orr	x0, x0, x1
               	sxtw	x0, w0
               	ret

<xor_ui>:
               	sxtw	x1, w1
               	mov	w0, w0
               	eor	x0, x0, x1
               	sxtw	x0, w0
               	ret

<and_ui>:
               	sxtw	x1, w1
               	mov	w0, w0
               	and	x0, x0, x1
               	sxtw	x0, w0
               	ret

<pc_advance>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldrb	w2, [x0]
               	lsl	x2, x2, #24
               	mov	w2, w2
               	ldrb	w3, [x0, #0x1]
               	lsl	x3, x3, #16
               	sxtw	x3, w3
               	orr	x2, x2, x3
               	ldrb	w3, [x0, #0x2]
               	lsl	x3, x3, #8
               	sxtw	x3, w3
               	orr	x2, x2, x3
               	ldrb	w0, [x0, #0x3]
               	orr	x0, x2, x0
               	sxtw	x0, w0
               	sxtw	x0, w0
               	add	x0, x1, x0
               	sub	x0, x0, x1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	mov	x0, #0xfdc2             // =64962
               	movk	x0, #0xffff, lsl #16
               	mov	x1, #0x0                // =0
               	mov	w0, w0
               	orr	x0, x0, x1
               	sxtw	x0, w0
               	mov	x17, #0xfdc2            // =64962
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x1, #0xfdc2             // =64962
               	movk	x1, #0xffff, lsl #16
               	mov	w1, w1
               	orr	x0, x0, x1
               	sxtw	x0, w0
               	mov	x17, #0xfdc2            // =64962
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xfdc2             // =64962
               	movk	x0, #0xffff, lsl #16
               	mov	x1, #0x0                // =0
               	mov	w0, w0
               	eor	x0, x0, x1
               	sxtw	x0, w0
               	mov	x17, #0xfdc2            // =64962
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	mov	x1, #0xfdc2             // =64962
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	mov	w0, w0
               	and	x0, x0, x1
               	sxtw	x0, w0
               	mov	x17, #0xfdc2            // =64962
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
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
               	add	x1, x1, #0x8
               	ldrb	w2, [x0]
               	lsl	x2, x2, #24
               	mov	w2, w2
               	ldrb	w3, [x0, #0x1]
               	lsl	x3, x3, #16
               	sxtw	x3, w3
               	orr	x2, x2, x3
               	ldrb	w3, [x0, #0x2]
               	lsl	x3, x3, #8
               	sxtw	x3, w3
               	orr	x2, x2, x3
               	ldrb	w0, [x0, #0x3]
               	orr	x0, x2, x0
               	sxtw	x0, w0
               	sxtw	x0, w0
               	add	x0, x1, x0
               	sub	x0, x0, x1
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
