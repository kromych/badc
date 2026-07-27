
ssa_bail_fixup_rollback.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<core>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	mov	x6, x0
               	sub	x0, x29, #0x40
               	add	x5, x0, #0x0
               	add	x0, x3, #0x0
               	ldrb	w4, [x0, #0x3]
               	mov	w4, w4
               	lsl	x4, x4, #8
               	mov	w4, w4
               	ldrb	w7, [x0, #0x2]
               	orr	x4, x4, x7
               	mov	w4, w4
               	lsl	x4, x4, #8
               	mov	w4, w4
               	ldrb	w7, [x0, #0x1]
               	orr	x4, x4, x7
               	mov	w4, w4
               	lsl	x4, x4, #8
               	mov	w4, w4
               	ldrb	w0, [x0]
               	orr	x0, x4, x0
               	mov	w0, w0
               	str	w0, [x5]
               	sub	x4, x29, #0x40
               	add	x0, x2, #0x0
               	ldrb	w5, [x0, #0x3]
               	mov	w5, w5
               	lsl	x5, x5, #8
               	mov	w5, w5
               	ldrb	w7, [x0, #0x2]
               	orr	x5, x5, x7
               	mov	w5, w5
               	lsl	x5, x5, #8
               	mov	w5, w5
               	ldrb	w7, [x0, #0x1]
               	orr	x5, x5, x7
               	mov	w5, w5
               	lsl	x5, x5, #8
               	mov	w5, w5
               	ldrb	w0, [x0]
               	orr	x0, x5, x0
               	mov	w0, w0
               	str	w0, [x4, #0x4]
               	sub	x4, x29, #0x40
               	add	x0, x1, #0x0
               	ldrb	w5, [x0, #0x3]
               	mov	w5, w5
               	lsl	x5, x5, #8
               	mov	w5, w5
               	ldrb	w7, [x0, #0x2]
               	orr	x5, x5, x7
               	mov	w5, w5
               	lsl	x5, x5, #8
               	mov	w5, w5
               	ldrb	w7, [x0, #0x1]
               	orr	x5, x5, x7
               	mov	w5, w5
               	lsl	x5, x5, #8
               	mov	w5, w5
               	ldrb	w0, [x0]
               	orr	x0, x5, x0
               	mov	w0, w0
               	str	w0, [x4, #0x18]
               	sub	x4, x29, #0x40
               	add	x0, x2, #0x10
               	add	x0, x0, #0x0
               	ldrb	w5, [x0, #0x3]
               	mov	w5, w5
               	lsl	x5, x5, #8
               	mov	w5, w5
               	ldrb	w7, [x0, #0x2]
               	orr	x5, x5, x7
               	mov	w5, w5
               	lsl	x5, x5, #8
               	mov	w5, w5
               	ldrb	w7, [x0, #0x1]
               	orr	x5, x5, x7
               	mov	w5, w5
               	lsl	x5, x5, #8
               	mov	w5, w5
               	ldrb	w0, [x0]
               	orr	x0, x5, x0
               	mov	w0, w0
               	str	w0, [x4, #0x2c]
               	sub	x4, x29, #0x40
               	add	x0, x3, #0x4
               	ldrb	w5, [x0, #0x3]
               	mov	w5, w5
               	lsl	x5, x5, #8
               	mov	w5, w5
               	ldrb	w7, [x0, #0x2]
               	orr	x5, x5, x7
               	mov	w5, w5
               	lsl	x5, x5, #8
               	mov	w5, w5
               	ldrb	w7, [x0, #0x1]
               	orr	x5, x5, x7
               	mov	w5, w5
               	lsl	x5, x5, #8
               	mov	w5, w5
               	ldrb	w0, [x0]
               	orr	x0, x5, x0
               	mov	w0, w0
               	str	w0, [x4, #0x14]
               	sub	x4, x29, #0x40
               	add	x0, x2, #0x4
               	ldrb	w5, [x0, #0x3]
               	mov	w5, w5
               	lsl	x5, x5, #8
               	mov	w5, w5
               	ldrb	w7, [x0, #0x2]
               	orr	x5, x5, x7
               	mov	w5, w5
               	lsl	x5, x5, #8
               	mov	w5, w5
               	ldrb	w7, [x0, #0x1]
               	orr	x5, x5, x7
               	mov	w5, w5
               	lsl	x5, x5, #8
               	mov	w5, w5
               	ldrb	w0, [x0]
               	orr	x0, x5, x0
               	mov	w0, w0
               	str	w0, [x4, #0x8]
               	sub	x4, x29, #0x40
               	add	x0, x1, #0x4
               	ldrb	w5, [x0, #0x3]
               	mov	w5, w5
               	lsl	x5, x5, #8
               	mov	w5, w5
               	ldrb	w7, [x0, #0x2]
               	orr	x5, x5, x7
               	mov	w5, w5
               	lsl	x5, x5, #8
               	mov	w5, w5
               	ldrb	w7, [x0, #0x1]
               	orr	x5, x5, x7
               	mov	w5, w5
               	lsl	x5, x5, #8
               	mov	w5, w5
               	ldrb	w0, [x0]
               	orr	x0, x5, x0
               	mov	w0, w0
               	str	w0, [x4, #0x1c]
               	sub	x4, x29, #0x40
               	add	x0, x2, #0x10
               	add	x0, x0, #0x4
               	ldrb	w5, [x0, #0x3]
               	mov	w5, w5
               	lsl	x5, x5, #8
               	mov	w5, w5
               	ldrb	w7, [x0, #0x2]
               	orr	x5, x5, x7
               	mov	w5, w5
               	lsl	x5, x5, #8
               	mov	w5, w5
               	ldrb	w7, [x0, #0x1]
               	orr	x5, x5, x7
               	mov	w5, w5
               	lsl	x5, x5, #8
               	mov	w5, w5
               	ldrb	w0, [x0]
               	orr	x0, x5, x0
               	mov	w0, w0
               	str	w0, [x4, #0x30]
               	sub	x4, x29, #0x40
               	add	x0, x3, #0x8
               	ldrb	w5, [x0, #0x3]
               	mov	w5, w5
               	lsl	x5, x5, #8
               	mov	w5, w5
               	ldrb	w7, [x0, #0x2]
               	orr	x5, x5, x7
               	mov	w5, w5
               	lsl	x5, x5, #8
               	mov	w5, w5
               	ldrb	w7, [x0, #0x1]
               	orr	x5, x5, x7
               	mov	w5, w5
               	lsl	x5, x5, #8
               	mov	w5, w5
               	ldrb	w0, [x0]
               	orr	x0, x5, x0
               	mov	w0, w0
               	str	w0, [x4, #0x28]
               	sub	x4, x29, #0x40
               	add	x0, x2, #0x8
               	ldrb	w5, [x0, #0x3]
               	mov	w5, w5
               	lsl	x5, x5, #8
               	mov	w5, w5
               	ldrb	w7, [x0, #0x2]
               	orr	x5, x5, x7
               	mov	w5, w5
               	lsl	x5, x5, #8
               	mov	w5, w5
               	ldrb	w7, [x0, #0x1]
               	orr	x5, x5, x7
               	mov	w5, w5
               	lsl	x5, x5, #8
               	mov	w5, w5
               	ldrb	w0, [x0]
               	orr	x0, x5, x0
               	mov	w0, w0
               	str	w0, [x4, #0xc]
               	sub	x4, x29, #0x40
               	add	x0, x1, #0x8
               	ldrb	w5, [x0, #0x3]
               	mov	w5, w5
               	lsl	x5, x5, #8
               	mov	w5, w5
               	ldrb	w7, [x0, #0x2]
               	orr	x5, x5, x7
               	mov	w5, w5
               	lsl	x5, x5, #8
               	mov	w5, w5
               	ldrb	w7, [x0, #0x1]
               	orr	x5, x5, x7
               	mov	w5, w5
               	lsl	x5, x5, #8
               	mov	w5, w5
               	ldrb	w0, [x0]
               	orr	x0, x5, x0
               	mov	w0, w0
               	str	w0, [x4, #0x20]
               	sub	x4, x29, #0x40
               	add	x0, x2, #0x10
               	add	x0, x0, #0x8
               	ldrb	w5, [x0, #0x3]
               	mov	w5, w5
               	lsl	x5, x5, #8
               	mov	w5, w5
               	ldrb	w7, [x0, #0x2]
               	orr	x5, x5, x7
               	mov	w5, w5
               	lsl	x5, x5, #8
               	mov	w5, w5
               	ldrb	w7, [x0, #0x1]
               	orr	x5, x5, x7
               	mov	w5, w5
               	lsl	x5, x5, #8
               	mov	w5, w5
               	ldrb	w0, [x0]
               	orr	x0, x5, x0
               	mov	w0, w0
               	str	w0, [x4, #0x34]
               	sub	x4, x29, #0x40
               	add	x0, x3, #0xc
               	ldrb	w3, [x0, #0x3]
               	mov	w3, w3
               	lsl	x3, x3, #8
               	mov	w3, w3
               	ldrb	w5, [x0, #0x2]
               	orr	x3, x3, x5
               	mov	w3, w3
               	lsl	x3, x3, #8
               	mov	w3, w3
               	ldrb	w5, [x0, #0x1]
               	orr	x3, x3, x5
               	mov	w3, w3
               	lsl	x3, x3, #8
               	mov	w3, w3
               	ldrb	w0, [x0]
               	orr	x0, x3, x0
               	mov	w0, w0
               	str	w0, [x4, #0x3c]
               	sub	x3, x29, #0x40
               	add	x0, x2, #0xc
               	ldrb	w4, [x0, #0x3]
               	mov	w4, w4
               	lsl	x4, x4, #8
               	mov	w4, w4
               	ldrb	w5, [x0, #0x2]
               	orr	x4, x4, x5
               	mov	w4, w4
               	lsl	x4, x4, #8
               	mov	w4, w4
               	ldrb	w5, [x0, #0x1]
               	orr	x4, x4, x5
               	mov	w4, w4
               	lsl	x4, x4, #8
               	mov	w4, w4
               	ldrb	w0, [x0]
               	orr	x0, x4, x0
               	mov	w0, w0
               	str	w0, [x3, #0x10]
               	sub	x3, x29, #0x40
               	add	x0, x1, #0xc
               	ldrb	w1, [x0, #0x3]
               	mov	w1, w1
               	lsl	x1, x1, #8
               	mov	w1, w1
               	ldrb	w4, [x0, #0x2]
               	orr	x1, x1, x4
               	mov	w1, w1
               	lsl	x1, x1, #8
               	mov	w1, w1
               	ldrb	w4, [x0, #0x1]
               	orr	x1, x1, x4
               	mov	w1, w1
               	lsl	x1, x1, #8
               	mov	w1, w1
               	ldrb	w0, [x0]
               	orr	x0, x1, x0
               	mov	w0, w0
               	str	w0, [x3, #0x24]
               	sub	x1, x29, #0x40
               	add	x0, x2, #0x10
               	add	x0, x0, #0xc
               	ldrb	w2, [x0, #0x3]
               	mov	w2, w2
               	lsl	x2, x2, #8
               	mov	w2, w2
               	ldrb	w3, [x0, #0x2]
               	orr	x2, x2, x3
               	mov	w2, w2
               	lsl	x2, x2, #8
               	mov	w2, w2
               	ldrb	w3, [x0, #0x1]
               	orr	x2, x2, x3
               	mov	w2, w2
               	lsl	x2, x2, #8
               	mov	w2, w2
               	ldrb	w0, [x0]
               	orr	x0, x2, x0
               	mov	w0, w0
               	str	w0, [x1, #0x38]
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
               	strb	w0, [x6]
               	mov	x0, x1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<stream_xor>:
               	stp	x20, x21, [sp, #-0x90]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x80]
               	add	x29, sp, #0x80
               	mov	x21, x0
               	mov	x23, x4
               	mov	x20, #0x0               // =0
               	mov	x22, #0x40              // =64
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
               	ldp	x29, x30, [sp, #0x80]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	sub	x0, x29, #0x68
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
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
               	sub	x0, x29, #0x60
               	mov	x1, #0x0                // =0
               	mov	x2, #0x40               // =64
               	sub	x3, x29, #0x68
               	sub	x4, x29, #0x20
               	bl	<addr>
               	sub	x0, x29, #0x60
               	ldrb	w0, [x0]
               	mov	x17, #0x4d              // =77
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
