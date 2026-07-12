
ssa_bail_fixup_rollback.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
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

<stream_xor>:
               	stp	x20, x21, [sp, #-0xb0]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0xa0]
               	add	x29, sp, #0xa0
               	mov	x21, x0
               	mov	x23, x4
               	mov	x22, x2
               	mov	x20, x1
               	cmp	x22, #0x0
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
               	mov	x2, x23
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	w1, w0
               	add	x2, x21, x1
               	cbz	x20, <addr>
               	mov	w1, w0
               	add	x1, x20, x1
               	ldrb	w1, [x1]
               	sub	x3, x29, #0x50
               	mov	w4, w0
               	add	x3, x3, x4
               	ldrb	w3, [x3]
               	eor	x1, x1, x3
               	strb	w1, [x2]
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	w0, w0
               	add	x0, x0, #0x1
               	mov	w1, w0
               	cmp	x1, #0x40
               	b.lo	<addr>
               	sub	x22, x22, #0x40
               	add	x21, x21, #0x40
               	cbz	x20, <addr>
               	add	x20, x20, #0x40
               	b	<addr>
               	cmp	x22, #0x40
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
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x68
               	add	x2, x2, x1
               	mov	x17, #0xff              // =255
               	and	x3, x1, x17
               	strb	w3, [x2]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x20
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
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
