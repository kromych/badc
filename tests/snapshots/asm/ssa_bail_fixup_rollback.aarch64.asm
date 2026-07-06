
ssa_bail_fixup_rollback.aarch64:	file format elf64-littleaarch64

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

<stream_xor>:
               	stp	x20, x21, [sp, #-0xb0]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0xa0]
               	add	x29, sp, #0xa0
               	mov	x21, x0
               	mov	x20, x4
               	mov	x23, x2
               	mov	x22, x1
               	cmp	x23, #0x0
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0xa0]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xb0
               	ret
               	sub	x0, x29, #0x10
               	add	x0, x0, #0x0
               	mov	x1, #0x0                // =0
               	strb	w1, [x0]
               	sub	x0, x29, #0x10
               	mov	x1, #0x0                // =0
               	strb	w1, [x0, #0x1]
               	sub	x0, x29, #0x10
               	mov	x1, #0x0                // =0
               	strb	w1, [x0, #0x2]
               	sub	x0, x29, #0x10
               	mov	x1, #0x0                // =0
               	strb	w1, [x0, #0x3]
               	sub	x0, x29, #0x10
               	mov	x1, #0x0                // =0
               	strb	w1, [x0, #0x4]
               	sub	x0, x29, #0x10
               	mov	x1, #0x0                // =0
               	strb	w1, [x0, #0x5]
               	sub	x0, x29, #0x10
               	mov	x1, #0x0                // =0
               	strb	w1, [x0, #0x6]
               	sub	x0, x29, #0x10
               	mov	x1, #0x0                // =0
               	strb	w1, [x0, #0x7]
               	sub	x0, x29, #0x10
               	mov	x1, #0x0                // =0
               	strb	w1, [x0, #0x8]
               	sub	x0, x29, #0x10
               	mov	x1, #0x0                // =0
               	strb	w1, [x0, #0x9]
               	sub	x0, x29, #0x10
               	mov	x1, #0x0                // =0
               	strb	w1, [x0, #0xa]
               	sub	x0, x29, #0x10
               	mov	x1, #0x0                // =0
               	strb	w1, [x0, #0xb]
               	sub	x0, x29, #0x10
               	mov	x1, #0x0                // =0
               	strb	w1, [x0, #0xc]
               	sub	x0, x29, #0x10
               	mov	x1, #0x0                // =0
               	strb	w1, [x0, #0xd]
               	sub	x0, x29, #0x10
               	mov	x1, #0x0                // =0
               	strb	w1, [x0, #0xe]
               	sub	x0, x29, #0x10
               	mov	x1, #0x0                // =0
               	strb	w1, [x0, #0xf]
               	sub	x0, x29, #0x10
               	add	x0, x0, #0x0
               	add	x1, x3, #0x0
               	ldrb	w1, [x1]
               	strb	w1, [x0]
               	sub	x0, x29, #0x10
               	ldrb	w1, [x3, #0x1]
               	strb	w1, [x0, #0x1]
               	sub	x0, x29, #0x10
               	ldrb	w1, [x3, #0x2]
               	strb	w1, [x0, #0x2]
               	sub	x0, x29, #0x10
               	ldrb	w1, [x3, #0x3]
               	strb	w1, [x0, #0x3]
               	sub	x0, x29, #0x10
               	ldrb	w1, [x3, #0x4]
               	strb	w1, [x0, #0x4]
               	sub	x0, x29, #0x10
               	ldrb	w1, [x3, #0x5]
               	strb	w1, [x0, #0x5]
               	sub	x0, x29, #0x10
               	ldrb	w1, [x3, #0x6]
               	strb	w1, [x0, #0x6]
               	sub	x0, x29, #0x10
               	ldrb	w1, [x3, #0x7]
               	strb	w1, [x0, #0x7]
               	b	<addr>
               	sub	x0, x29, #0x50
               	sub	x1, x29, #0x10
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x2, x20
               	bl	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	w0, w1
               	add	x0, x21, x0
               	cbz	x22, <addr>
               	mov	w2, w1
               	add	x2, x22, x2
               	ldrb	w3, [x2]
               	sub	x2, x29, #0x50
               	mov	w4, w1
               	add	x2, x2, x4
               	ldrb	w2, [x2]
               	eor	x2, x3, x2
               	strb	w2, [x0]
               	b	<addr>
               	mov	x3, #0x0                // =0
               	b	<addr>
               	mov	w0, w1
               	add	x1, x0, #0x1
               	mov	w0, w1
               	cmp	x0, #0x40
               	b.lo	<addr>
               	sub	x23, x23, #0x40
               	add	x21, x21, #0x40
               	cbz	x22, <addr>
               	add	x22, x22, #0x40
               	b	<addr>
               	cmp	x23, #0x40
               	b.hs	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0xa0]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xb0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xa0
               	sub	x0, x29, #0x48
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	mov	x1, #0x0                // =0
               	b	<addr>
               	sub	x0, x29, #0x68
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
               	sub	x0, x29, #0x40
               	mov	x1, #0x0                // =0
               	mov	x2, #0x40               // =64
               	sub	x3, x29, #0x48
               	sub	x4, x29, #0x68
               	bl	<addr>
               	sub	x0, x29, #0x40
               	ldrb	w0, [x0]
               	mov	x17, #0x4d              // =77
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x1                // =1
               	b	<addr>
