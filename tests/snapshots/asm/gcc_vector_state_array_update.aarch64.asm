
gcc_vector_state_array_update.aarch64:	file format elf64-littleaarch64

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

<load16>:
               	ldrb	w1, [x0]
               	mov	x2, #0x0                // =0
               	fmov	d0, x2
               	mov	v0.b[0], w1
               	ldrb	w1, [x0, #0x1]
               	mov	v0.b[1], w1
               	ldrb	w1, [x0, #0x2]
               	mov	v0.b[2], w1
               	ldrb	w1, [x0, #0x3]
               	mov	v0.b[3], w1
               	ldrb	w1, [x0, #0x4]
               	mov	v0.b[4], w1
               	ldrb	w1, [x0, #0x5]
               	mov	v0.b[5], w1
               	ldrb	w1, [x0, #0x6]
               	mov	v0.b[6], w1
               	ldrb	w1, [x0, #0x7]
               	mov	v0.b[7], w1
               	ldrb	w1, [x0, #0x8]
               	mov	v0.b[8], w1
               	ldrb	w1, [x0, #0x9]
               	mov	v0.b[9], w1
               	ldrb	w1, [x0, #0xa]
               	mov	v0.b[10], w1
               	ldrb	w1, [x0, #0xb]
               	mov	v0.b[11], w1
               	ldrb	w1, [x0, #0xc]
               	mov	v0.b[12], w1
               	ldrb	w1, [x0, #0xd]
               	mov	v0.b[13], w1
               	ldrb	w1, [x0, #0xe]
               	mov	v0.b[14], w1
               	ldrb	w0, [x0, #0xf]
               	mov	v0.b[15], w0
               	ret

<store16>:
               	umov	w1, v0.b[0]
               	strb	w1, [x0]
               	umov	w1, v0.b[1]
               	strb	w1, [x0, #0x1]
               	umov	w1, v0.b[2]
               	strb	w1, [x0, #0x2]
               	umov	w1, v0.b[3]
               	strb	w1, [x0, #0x3]
               	umov	w1, v0.b[4]
               	strb	w1, [x0, #0x4]
               	umov	w1, v0.b[5]
               	strb	w1, [x0, #0x5]
               	umov	w1, v0.b[6]
               	strb	w1, [x0, #0x6]
               	umov	w1, v0.b[7]
               	strb	w1, [x0, #0x7]
               	umov	w1, v0.b[8]
               	strb	w1, [x0, #0x8]
               	umov	w1, v0.b[9]
               	strb	w1, [x0, #0x9]
               	umov	w1, v0.b[10]
               	strb	w1, [x0, #0xa]
               	umov	w1, v0.b[11]
               	strb	w1, [x0, #0xb]
               	umov	w1, v0.b[12]
               	strb	w1, [x0, #0xc]
               	umov	w1, v0.b[13]
               	strb	w1, [x0, #0xd]
               	umov	w1, v0.b[14]
               	strb	w1, [x0, #0xe]
               	umov	w1, v0.b[15]
               	strb	w1, [x0, #0xf]
               	ret

<mix>:
               	stp	x20, x21, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	umov	w0, v0.b[0]
               	lsl	x0, x0, #1
               	mov	x1, #0x0                // =0
               	fmov	d1, x1
               	mov	v1.b[0], w0
               	umov	w0, v0.b[1]
               	lsl	x0, x0, #1
               	mov	v1.b[1], w0
               	umov	w0, v0.b[2]
               	lsl	x0, x0, #1
               	mov	v1.b[2], w0
               	umov	w0, v0.b[3]
               	lsl	x0, x0, #1
               	mov	v1.b[3], w0
               	umov	w0, v0.b[4]
               	lsl	x0, x0, #1
               	mov	v1.b[4], w0
               	umov	w0, v0.b[5]
               	lsl	x0, x0, #1
               	mov	v1.b[5], w0
               	umov	w0, v0.b[6]
               	lsl	x0, x0, #1
               	mov	v1.b[6], w0
               	umov	w0, v0.b[7]
               	lsl	x0, x0, #1
               	mov	v1.b[7], w0
               	umov	w0, v0.b[8]
               	lsl	x0, x0, #1
               	mov	v1.b[8], w0
               	umov	w0, v0.b[9]
               	lsl	x0, x0, #1
               	mov	v1.b[9], w0
               	umov	w0, v0.b[10]
               	lsl	x0, x0, #1
               	mov	v1.b[10], w0
               	umov	w0, v0.b[11]
               	lsl	x0, x0, #1
               	mov	v1.b[11], w0
               	umov	w0, v0.b[12]
               	lsl	x0, x0, #1
               	mov	v1.b[12], w0
               	umov	w0, v0.b[13]
               	lsl	x0, x0, #1
               	mov	v1.b[13], w0
               	umov	w0, v0.b[14]
               	lsl	x0, x0, #1
               	mov	v1.b[14], w0
               	umov	w0, v0.b[15]
               	lsl	x0, x0, #1
               	mov	v1.b[15], w0
               	umov	w1, v0.b[0]
               	umov	w2, v0.b[1]
               	umov	w3, v0.b[2]
               	umov	w4, v0.b[3]
               	umov	w5, v0.b[4]
               	umov	w6, v0.b[5]
               	umov	w7, v0.b[6]
               	umov	w8, v0.b[7]
               	umov	w9, v0.b[8]
               	umov	w10, v0.b[9]
               	umov	w11, v0.b[10]
               	umov	w12, v0.b[11]
               	umov	w13, v0.b[12]
               	umov	w14, v0.b[13]
               	umov	w15, v0.b[14]
               	umov	w20, v0.b[15]
               	mov	x0, #0x1b               // =27
               	ubfx	x1, x1, #7, #8
               	mul	x1, x1, x0
               	mov	x21, #0x0               // =0
               	fmov	d0, x21
               	mov	v0.b[0], w1
               	ubfx	x1, x2, #7, #8
               	mul	x1, x1, x0
               	mov	v0.b[1], w1
               	ubfx	x1, x3, #7, #8
               	mul	x1, x1, x0
               	mov	v0.b[2], w1
               	ubfx	x1, x4, #7, #8
               	mul	x1, x1, x0
               	mov	v0.b[3], w1
               	ubfx	x1, x5, #7, #8
               	mul	x1, x1, x0
               	mov	v0.b[4], w1
               	ubfx	x1, x6, #7, #8
               	mul	x1, x1, x0
               	mov	v0.b[5], w1
               	ubfx	x1, x7, #7, #8
               	mul	x1, x1, x0
               	mov	v0.b[6], w1
               	ubfx	x1, x8, #7, #8
               	mul	x1, x1, x0
               	mov	v0.b[7], w1
               	ubfx	x1, x9, #7, #8
               	mul	x1, x1, x0
               	mov	v0.b[8], w1
               	ubfx	x1, x10, #7, #8
               	mul	x1, x1, x0
               	mov	v0.b[9], w1
               	ubfx	x1, x11, #7, #8
               	mul	x1, x1, x0
               	mov	v0.b[10], w1
               	ubfx	x1, x12, #7, #8
               	mul	x1, x1, x0
               	mov	v0.b[11], w1
               	ubfx	x1, x13, #7, #8
               	mul	x1, x1, x0
               	mov	v0.b[12], w1
               	ubfx	x1, x14, #7, #8
               	mul	x1, x1, x0
               	mov	v0.b[13], w1
               	ubfx	x1, x15, #7, #8
               	mul	x1, x1, x0
               	mov	v0.b[14], w1
               	ubfx	x1, x20, #7, #8
               	mul	x0, x1, x0
               	mov	v0.b[15], w0
               	eor	v0.16b, v1.16b, v0.16b
               	mov	x0, #0x63               // =99
               	umov	w1, v0.b[0]
               	eor	x1, x1, x0
               	mov	x2, #0x0                // =0
               	fmov	d1, x2
               	mov	v1.b[0], w1
               	umov	w1, v0.b[1]
               	eor	x1, x1, x0
               	mov	v1.b[1], w1
               	umov	w1, v0.b[2]
               	eor	x1, x1, x0
               	mov	v1.b[2], w1
               	umov	w1, v0.b[3]
               	eor	x1, x1, x0
               	mov	v1.b[3], w1
               	umov	w1, v0.b[4]
               	eor	x1, x1, x0
               	mov	v1.b[4], w1
               	umov	w1, v0.b[5]
               	eor	x1, x1, x0
               	mov	v1.b[5], w1
               	umov	w1, v0.b[6]
               	eor	x1, x1, x0
               	mov	v1.b[6], w1
               	umov	w1, v0.b[7]
               	eor	x1, x1, x0
               	mov	v1.b[7], w1
               	umov	w1, v0.b[8]
               	eor	x1, x1, x0
               	mov	v1.b[8], w1
               	umov	w1, v0.b[9]
               	eor	x1, x1, x0
               	mov	v1.b[9], w1
               	umov	w1, v0.b[10]
               	eor	x1, x1, x0
               	mov	v1.b[10], w1
               	umov	w1, v0.b[11]
               	eor	x1, x1, x0
               	mov	v1.b[11], w1
               	umov	w1, v0.b[12]
               	eor	x1, x1, x0
               	mov	v1.b[12], w1
               	umov	w1, v0.b[13]
               	eor	x1, x1, x0
               	mov	v1.b[13], w1
               	umov	w1, v0.b[14]
               	eor	x1, x1, x0
               	mov	v1.b[14], w1
               	umov	w1, v0.b[15]
               	eor	x0, x1, x0
               	mov	v0.16b, v1.16b
               	mov	v0.b[15], w0
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret

<update>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x90
               	stur	x8, [x29, #-0x8]
               	stur	x0, [x29, #-0x30]
               	str	q0, [sp, #0x50]
               	sub	x0, x29, #0x90
               	ldur	x1, [x29, #-0x30]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	ldp	x16, x17, [x1, #0x40]
               	stp	x16, x17, [x0, #0x40]
               	add	x7, x0, #0x40
               	ldr	q0, [x7]
               	bl	<addr>
               	ldr	q16, [sp, #0x50]
               	eor	v16.16b, v16.16b, v0.16b
               	str	q16, [sp, #0x50]
               	sub	x0, x29, #0x90
               	add	x7, x0, #0x30
               	ldr	q0, [x7]
               	bl	<addr>
               	ldur	q1, [x29, #-0x50]
               	eor	v0.16b, v1.16b, v0.16b
               	stur	q0, [x29, #-0x50]
               	sub	x0, x29, #0x90
               	add	x7, x0, #0x20
               	ldr	q0, [x7]
               	bl	<addr>
               	ldur	q1, [x29, #-0x60]
               	eor	v0.16b, v1.16b, v0.16b
               	stur	q0, [x29, #-0x60]
               	sub	x0, x29, #0x90
               	add	x7, x0, #0x10
               	ldr	q0, [x7]
               	bl	<addr>
               	ldur	q1, [x29, #-0x70]
               	eor	v0.16b, v1.16b, v0.16b
               	stur	q0, [x29, #-0x70]
               	sub	x7, x29, #0x90
               	ldr	q0, [x7]
               	bl	<addr>
               	ldur	q1, [x29, #-0x80]
               	eor	v0.16b, v1.16b, v0.16b
               	stur	q0, [x29, #-0x80]
               	sub	x0, x29, #0x90
               	ldur	q0, [x29, #-0x90]
               	ldr	q17, [sp, #0x50]
               	eor	v0.16b, v0.16b, v17.16b
               	stur	q0, [x29, #-0x90]
               	mov	x16, x0
               	ldur	x17, [x29, #-0x8]
               	ldp	x0, x1, [x16]
               	stp	x0, x1, [x17]
               	ldp	x0, x1, [x16, #0x10]
               	stp	x0, x1, [x17, #0x10]
               	ldp	x0, x1, [x16, #0x20]
               	stp	x0, x1, [x17, #0x20]
               	ldp	x0, x1, [x16, #0x30]
               	stp	x0, x1, [x17, #0x30]
               	ldp	x0, x1, [x16, #0x40]
               	stp	x0, x1, [x17, #0x40]
               	mov	x0, x17
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret

<update_scalar>:
               	stp	x20, x21, [sp, #-0x50]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	str	x26, [sp, #0x30]
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	ldrb	w4, [x1]
               	add	x2, x0, #0x40
               	ldrb	w3, [x2]
               	lsr	x5, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x5, x5, x17
               	eor	x3, x5, x3, lsl #1
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	and	x3, x3, #0xff
               	eor	x7, x4, x3
               	ldrb	w4, [x1, #0x1]
               	ldrb	w3, [x2, #0x1]
               	lsr	x5, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x5, x5, x17
               	eor	x3, x5, x3, lsl #1
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	and	x3, x3, #0xff
               	eor	x8, x4, x3
               	ldrb	w4, [x1, #0x2]
               	ldrb	w3, [x2, #0x2]
               	lsr	x5, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x5, x5, x17
               	eor	x3, x5, x3, lsl #1
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	and	x3, x3, #0xff
               	eor	x9, x4, x3
               	ldrb	w4, [x1, #0x3]
               	ldrb	w3, [x2, #0x3]
               	lsr	x5, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x5, x5, x17
               	eor	x3, x5, x3, lsl #1
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	and	x3, x3, #0xff
               	eor	x10, x4, x3
               	ldrb	w4, [x1, #0x4]
               	ldrb	w3, [x2, #0x4]
               	lsr	x5, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x5, x5, x17
               	eor	x3, x5, x3, lsl #1
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	and	x3, x3, #0xff
               	eor	x11, x4, x3
               	ldrb	w4, [x1, #0x5]
               	ldrb	w3, [x2, #0x5]
               	lsr	x5, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x5, x5, x17
               	eor	x3, x5, x3, lsl #1
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	and	x3, x3, #0xff
               	eor	x12, x4, x3
               	ldrb	w4, [x1, #0x6]
               	ldrb	w3, [x2, #0x6]
               	lsr	x5, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x5, x5, x17
               	eor	x3, x5, x3, lsl #1
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	and	x3, x3, #0xff
               	eor	x13, x4, x3
               	ldrb	w4, [x1, #0x7]
               	ldrb	w3, [x2, #0x7]
               	lsr	x5, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x5, x5, x17
               	eor	x3, x5, x3, lsl #1
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	and	x3, x3, #0xff
               	eor	x14, x4, x3
               	ldrb	w3, [x1, #0x8]
               	ldrb	w2, [x2, #0x8]
               	lsr	x4, x2, #7
               	mov	x17, #0x1b              // =27
               	mul	x4, x4, x17
               	eor	x2, x4, x2, lsl #1
               	mov	x17, #0x63              // =99
               	eor	x2, x2, x17
               	and	x2, x2, #0xff
               	eor	x15, x3, x2
               	ldrb	w4, [x1, #0x9]
               	add	x2, x0, #0x40
               	ldrb	w3, [x2, #0x9]
               	lsr	x5, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x5, x5, x17
               	eor	x3, x5, x3, lsl #1
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	and	x3, x3, #0xff
               	eor	x20, x4, x3
               	ldrb	w4, [x1, #0xa]
               	ldrb	w3, [x2, #0xa]
               	lsr	x5, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x5, x5, x17
               	eor	x3, x5, x3, lsl #1
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	and	x3, x3, #0xff
               	eor	x21, x4, x3
               	ldrb	w4, [x1, #0xb]
               	ldrb	w3, [x2, #0xb]
               	lsr	x5, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x5, x5, x17
               	eor	x3, x5, x3, lsl #1
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	and	x3, x3, #0xff
               	eor	x22, x4, x3
               	ldrb	w4, [x1, #0xc]
               	ldrb	w3, [x2, #0xc]
               	lsr	x5, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x5, x5, x17
               	eor	x3, x5, x3, lsl #1
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	and	x3, x3, #0xff
               	eor	x23, x4, x3
               	ldrb	w4, [x1, #0xd]
               	ldrb	w3, [x2, #0xd]
               	lsr	x5, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x5, x5, x17
               	eor	x3, x5, x3, lsl #1
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	and	x3, x3, #0xff
               	eor	x24, x4, x3
               	ldrb	w4, [x1, #0xe]
               	ldrb	w3, [x2, #0xe]
               	lsr	x5, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x5, x5, x17
               	eor	x3, x5, x3, lsl #1
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	and	x3, x3, #0xff
               	eor	x25, x4, x3
               	ldrb	w3, [x1, #0xf]
               	ldrb	w1, [x2, #0xf]
               	lsr	x2, x1, #7
               	mov	x17, #0x1b              // =27
               	mul	x2, x2, x17
               	eor	x1, x2, x1, lsl #1
               	mov	x17, #0x63              // =99
               	eor	x1, x1, x17
               	and	x1, x1, #0xff
               	eor	x26, x3, x1
               	mov	x1, #0x4                // =4
               	lsl	x2, x1, #4
               	add	x3, x0, x2
               	ldrb	w5, [x3]
               	sub	x4, x1, #0x1
               	add	x4, x0, x4, lsl #4
               	ldrb	w4, [x4]
               	lsr	x6, x4, #7
               	mov	x17, #0x1b              // =27
               	mul	x6, x6, x17
               	eor	x4, x6, x4, lsl #1
               	mov	x17, #0x63              // =99
               	eor	x4, x4, x17
               	and	x4, x4, #0xff
               	eor	x4, x5, x4
               	strb	w4, [x3]
               	add	x2, x0, x2
               	ldrb	w5, [x2, #0x1]
               	sub	x3, x1, #0x1
               	add	x4, x0, x3, lsl #4
               	ldrb	w4, [x4, #0x1]
               	lsr	x6, x4, #7
               	mov	x17, #0x1b              // =27
               	mul	x6, x6, x17
               	eor	x4, x6, x4, lsl #1
               	mov	x17, #0x63              // =99
               	eor	x4, x4, x17
               	and	x4, x4, #0xff
               	eor	x4, x5, x4
               	strb	w4, [x2, #0x1]
               	lsl	x2, x1, #4
               	add	x4, x0, x2
               	ldrb	w5, [x4, #0x2]
               	add	x3, x0, x3, lsl #4
               	ldrb	w3, [x3, #0x2]
               	lsr	x6, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x6, x6, x17
               	eor	x3, x6, x3, lsl #1
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	and	x3, x3, #0xff
               	eor	x3, x5, x3
               	strb	w3, [x4, #0x2]
               	add	x2, x0, x2
               	ldrb	w5, [x2, #0x3]
               	sub	x3, x1, #0x1
               	add	x4, x0, x3, lsl #4
               	ldrb	w4, [x4, #0x3]
               	lsr	x6, x4, #7
               	mov	x17, #0x1b              // =27
               	mul	x6, x6, x17
               	eor	x4, x6, x4, lsl #1
               	mov	x17, #0x63              // =99
               	eor	x4, x4, x17
               	and	x4, x4, #0xff
               	eor	x4, x5, x4
               	strb	w4, [x2, #0x3]
               	lsl	x2, x1, #4
               	add	x4, x0, x2
               	ldrb	w5, [x4, #0x4]
               	add	x3, x0, x3, lsl #4
               	ldrb	w3, [x3, #0x4]
               	lsr	x6, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x6, x6, x17
               	eor	x3, x6, x3, lsl #1
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	and	x3, x3, #0xff
               	eor	x3, x5, x3
               	strb	w3, [x4, #0x4]
               	add	x2, x0, x2
               	ldrb	w5, [x2, #0x5]
               	sub	x3, x1, #0x1
               	add	x4, x0, x3, lsl #4
               	ldrb	w4, [x4, #0x5]
               	lsr	x6, x4, #7
               	mov	x17, #0x1b              // =27
               	mul	x6, x6, x17
               	eor	x4, x6, x4, lsl #1
               	mov	x17, #0x63              // =99
               	eor	x4, x4, x17
               	and	x4, x4, #0xff
               	eor	x4, x5, x4
               	strb	w4, [x2, #0x5]
               	lsl	x2, x1, #4
               	add	x4, x0, x2
               	ldrb	w5, [x4, #0x6]
               	add	x3, x0, x3, lsl #4
               	ldrb	w3, [x3, #0x6]
               	lsr	x6, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x6, x6, x17
               	eor	x3, x6, x3, lsl #1
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	and	x3, x3, #0xff
               	eor	x3, x5, x3
               	strb	w3, [x4, #0x6]
               	add	x2, x0, x2
               	ldrb	w5, [x2, #0x7]
               	sub	x3, x1, #0x1
               	add	x4, x0, x3, lsl #4
               	ldrb	w4, [x4, #0x7]
               	lsr	x6, x4, #7
               	mov	x17, #0x1b              // =27
               	mul	x6, x6, x17
               	eor	x4, x6, x4, lsl #1
               	mov	x17, #0x63              // =99
               	eor	x4, x4, x17
               	and	x4, x4, #0xff
               	eor	x4, x5, x4
               	strb	w4, [x2, #0x7]
               	lsl	x2, x1, #4
               	add	x4, x0, x2
               	ldrb	w5, [x4, #0x8]
               	add	x3, x0, x3, lsl #4
               	ldrb	w3, [x3, #0x8]
               	lsr	x6, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x6, x6, x17
               	eor	x3, x6, x3, lsl #1
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	and	x3, x3, #0xff
               	eor	x3, x5, x3
               	strb	w3, [x4, #0x8]
               	add	x2, x0, x2
               	ldrb	w5, [x2, #0x9]
               	sub	x3, x1, #0x1
               	add	x4, x0, x3, lsl #4
               	ldrb	w4, [x4, #0x9]
               	lsr	x6, x4, #7
               	mov	x17, #0x1b              // =27
               	mul	x6, x6, x17
               	eor	x4, x6, x4, lsl #1
               	mov	x17, #0x63              // =99
               	eor	x4, x4, x17
               	and	x4, x4, #0xff
               	eor	x4, x5, x4
               	strb	w4, [x2, #0x9]
               	lsl	x2, x1, #4
               	add	x4, x0, x2
               	ldrb	w5, [x4, #0xa]
               	add	x3, x0, x3, lsl #4
               	ldrb	w3, [x3, #0xa]
               	lsr	x6, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x6, x6, x17
               	eor	x3, x6, x3, lsl #1
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	and	x3, x3, #0xff
               	eor	x3, x5, x3
               	strb	w3, [x4, #0xa]
               	add	x2, x0, x2
               	ldrb	w5, [x2, #0xb]
               	sub	x3, x1, #0x1
               	add	x4, x0, x3, lsl #4
               	ldrb	w4, [x4, #0xb]
               	lsr	x6, x4, #7
               	mov	x17, #0x1b              // =27
               	mul	x6, x6, x17
               	eor	x4, x6, x4, lsl #1
               	mov	x17, #0x63              // =99
               	eor	x4, x4, x17
               	and	x4, x4, #0xff
               	eor	x4, x5, x4
               	strb	w4, [x2, #0xb]
               	lsl	x2, x1, #4
               	add	x4, x0, x2
               	ldrb	w5, [x4, #0xc]
               	add	x3, x0, x3, lsl #4
               	ldrb	w3, [x3, #0xc]
               	lsr	x6, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x6, x6, x17
               	eor	x3, x6, x3, lsl #1
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	and	x3, x3, #0xff
               	eor	x3, x5, x3
               	strb	w3, [x4, #0xc]
               	add	x2, x0, x2
               	ldrb	w5, [x2, #0xd]
               	sub	x3, x1, #0x1
               	add	x4, x0, x3, lsl #4
               	ldrb	w4, [x4, #0xd]
               	lsr	x6, x4, #7
               	mov	x17, #0x1b              // =27
               	mul	x6, x6, x17
               	eor	x4, x6, x4, lsl #1
               	mov	x17, #0x63              // =99
               	eor	x4, x4, x17
               	and	x4, x4, #0xff
               	eor	x4, x5, x4
               	strb	w4, [x2, #0xd]
               	lsl	x2, x1, #4
               	add	x4, x0, x2
               	ldrb	w5, [x4, #0xe]
               	add	x3, x0, x3, lsl #4
               	ldrb	w3, [x3, #0xe]
               	lsr	x6, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x6, x6, x17
               	eor	x3, x6, x3, lsl #1
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	and	x3, x3, #0xff
               	eor	x3, x5, x3
               	strb	w3, [x4, #0xe]
               	add	x2, x0, x2
               	ldrb	w4, [x2, #0xf]
               	sub	x3, x1, #0x1
               	add	x3, x0, x3, lsl #4
               	ldrb	w3, [x3, #0xf]
               	lsr	x5, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x5, x5, x17
               	eor	x3, x5, x3, lsl #1
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	and	x3, x3, #0xff
               	eor	x3, x4, x3
               	strb	w3, [x2, #0xf]
               	sub	x1, x1, #0x1
               	cmp	w1, #0x0
               	b.gt	<addr>
               	ldrb	w1, [x0]
               	eor	x1, x1, x7
               	strb	w1, [x0]
               	ldrb	w1, [x0, #0x1]
               	eor	x1, x1, x8
               	strb	w1, [x0, #0x1]
               	ldrb	w1, [x0, #0x2]
               	eor	x1, x1, x9
               	strb	w1, [x0, #0x2]
               	ldrb	w1, [x0, #0x3]
               	eor	x1, x1, x10
               	strb	w1, [x0, #0x3]
               	ldrb	w1, [x0, #0x4]
               	eor	x1, x1, x11
               	strb	w1, [x0, #0x4]
               	ldrb	w1, [x0, #0x5]
               	eor	x1, x1, x12
               	strb	w1, [x0, #0x5]
               	ldrb	w1, [x0, #0x6]
               	eor	x1, x1, x13
               	strb	w1, [x0, #0x6]
               	ldrb	w1, [x0, #0x7]
               	eor	x1, x1, x14
               	strb	w1, [x0, #0x7]
               	ldrb	w1, [x0, #0x8]
               	eor	x1, x1, x15
               	strb	w1, [x0, #0x8]
               	ldrb	w1, [x0, #0x9]
               	eor	x1, x1, x20
               	strb	w1, [x0, #0x9]
               	ldrb	w1, [x0, #0xa]
               	eor	x1, x1, x21
               	strb	w1, [x0, #0xa]
               	ldrb	w1, [x0, #0xb]
               	eor	x1, x1, x22
               	strb	w1, [x0, #0xb]
               	ldrb	w1, [x0, #0xc]
               	eor	x1, x1, x23
               	strb	w1, [x0, #0xc]
               	ldrb	w1, [x0, #0xd]
               	eor	x1, x1, x24
               	strb	w1, [x0, #0xd]
               	ldrb	w1, [x0, #0xe]
               	eor	x1, x1, x25
               	strb	w1, [x0, #0xe]
               	ldrb	w1, [x0, #0xf]
               	eor	x1, x1, x26
               	strb	w1, [x0, #0xf]
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x26, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret

<run_chunk>:
               	stp	x20, x21, [sp, #-0x180]!
               	stp	x22, x23, [sp, #0x10]
               	str	x24, [sp, #0x20]
               	stp	x29, x30, [sp, #0x170]
               	add	x29, sp, #0x170
               	mov	x22, x0
               	mov	x24, x2
               	mov	x23, x1
               	sub	x0, x29, #0x50
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	stp	xzr, xzr, [x0, #0x30]
               	stp	xzr, xzr, [x0, #0x40]
               	mov	x0, x22
               	bl	<addr>
               	stur	q0, [x29, #-0x50]
               	add	x0, x22, #0x10
               	bl	<addr>
               	stur	q0, [x29, #-0x40]
               	add	x0, x22, #0x20
               	bl	<addr>
               	stur	q0, [x29, #-0x30]
               	add	x0, x22, #0x30
               	bl	<addr>
               	stur	q0, [x29, #-0x20]
               	add	x0, x22, #0x40
               	bl	<addr>
               	stur	q0, [x29, #-0x10]
               	sub	x0, x29, #0xf0
               	ldur	q0, [x29, #-0x50]
               	ldur	q1, [x29, #-0x40]
               	ldur	q2, [x29, #-0x30]
               	ldur	q3, [x29, #-0x20]
               	ldur	q4, [x29, #-0x10]
               	stur	q0, [x29, #-0xf0]
               	stur	q1, [x29, #-0xe0]
               	stur	q2, [x29, #-0xd0]
               	stur	q3, [x29, #-0xc0]
               	stur	q4, [x29, #-0xb0]
               	sub	x1, x29, #0x140
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	ldp	x16, x17, [x0, #0x40]
               	stp	x16, x17, [x1, #0x40]
               	mov	x20, #0x0               // =0
               	cmp	w20, w24
               	b.ge	<addr>
               	sub	x21, x29, #0x140
               	lsl	x0, x20, #4
               	sxtw	x0, w0
               	add	x0, x23, x0
               	bl	<addr>
               	stur	q0, [x29, #-0xf0]
               	sub	x7, x29, #0xf0
               	sub	x0, x29, #0xa0
               	ldp	x16, x17, [x21]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x21, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x21, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x21, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	ldp	x16, x17, [x21, #0x40]
               	stp	x16, x17, [x0, #0x40]
               	ldr	q0, [x7]
               	sub	x8, x29, #0x50
               	bl	<addr>
               	sub	x0, x29, #0x50
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x21]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x21, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x21, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x21, #0x30]
               	ldp	x16, x17, [x0, #0x40]
               	stp	x16, x17, [x21, #0x40]
               	add	x20, x20, #0x1
               	cmp	w20, w24
               	b.lt	<addr>
               	ldr	x0, [sp, #0x30]
               	ldr	x1, [sp, #0x38]
               	ldr	x2, [sp, #0x40]
               	ldr	x3, [sp, #0x48]
               	ldr	x4, [sp, #0x50]
               	ldr	x5, [sp, #0x58]
               	ldr	x6, [sp, #0x60]
               	ldr	x8, [sp, #0x68]
               	ldur	x9, [x29, #-0x100]
               	ldur	x10, [x29, #-0xf8]
               	sub	x7, x29, #0x50
               	stur	x0, [x29, #-0x50]
               	stur	x1, [x29, #-0x48]
               	stur	x2, [x29, #-0x40]
               	stur	x3, [x29, #-0x38]
               	stur	x4, [x29, #-0x30]
               	stur	x5, [x29, #-0x28]
               	stur	x6, [x29, #-0x20]
               	stur	x8, [x29, #-0x18]
               	stur	x9, [x29, #-0x10]
               	stur	x10, [x29, #-0x8]
               	ldr	q0, [x7]
               	mov	x0, x22
               	bl	<addr>
               	add	x0, x22, #0x10
               	sub	x1, x29, #0x50
               	add	x7, x1, #0x10
               	ldr	q0, [x7]
               	bl	<addr>
               	add	x0, x22, #0x20
               	sub	x1, x29, #0x50
               	add	x7, x1, #0x20
               	ldr	q0, [x7]
               	bl	<addr>
               	add	x0, x22, #0x30
               	sub	x1, x29, #0x50
               	add	x7, x1, #0x30
               	ldr	q0, [x7]
               	bl	<addr>
               	add	x0, x22, #0x40
               	sub	x1, x29, #0x50
               	add	x7, x1, #0x40
               	ldr	q0, [x7]
               	bl	<addr>
               	ldp	x29, x30, [sp, #0x170]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x180
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x330
               	stp	x20, x21, [sp]
               	stp	x22, x23, [sp, #0x10]
               	mov	x0, #0x0                // =0
               	mov	x1, #0x7                // =7
               	sub	x2, x29, #0x218
               	mul	x3, x0, x1
               	add	x3, x3, #0x1
               	and	x3, x3, #0xff
               	strb	w3, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x50
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	mov	x1, #0x1f               // =31
               	sub	x2, x29, #0xd8
               	mul	x3, x0, x1
               	add	x3, x3, #0x9
               	and	x3, x3, #0xff
               	strb	w3, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x80
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x1c8
               	lsl	x1, x0, #4
               	add	x2, x2, x1
               	sub	x3, x29, #0x218
               	ldrb	w4, [x3, x1]
               	strb	w4, [x2]
               	add	x4, x1, #0x1
               	ldrb	w4, [x3, x4]
               	strb	w4, [x2, #0x1]
               	add	x4, x1, #0x2
               	ldrb	w4, [x3, x4]
               	strb	w4, [x2, #0x2]
               	add	x1, x1, #0x3
               	ldrb	w1, [x3, x1]
               	strb	w1, [x2, #0x3]
               	sub	x3, x29, #0x218
               	lsl	x1, x0, #4
               	add	x4, x1, #0x4
               	ldrb	w4, [x3, x4]
               	strb	w4, [x2, #0x4]
               	sub	x2, x29, #0x1c8
               	add	x2, x2, x1
               	add	x4, x1, #0x5
               	ldrb	w4, [x3, x4]
               	strb	w4, [x2, #0x5]
               	add	x4, x1, #0x6
               	ldrb	w4, [x3, x4]
               	strb	w4, [x2, #0x6]
               	add	x4, x1, #0x7
               	ldrb	w4, [x3, x4]
               	strb	w4, [x2, #0x7]
               	add	x1, x1, #0x8
               	ldrb	w1, [x3, x1]
               	strb	w1, [x2, #0x8]
               	sub	x3, x29, #0x218
               	lsl	x1, x0, #4
               	add	x4, x1, #0x9
               	ldrb	w4, [x3, x4]
               	strb	w4, [x2, #0x9]
               	sub	x2, x29, #0x1c8
               	add	x2, x2, x1
               	add	x4, x1, #0xa
               	ldrb	w4, [x3, x4]
               	strb	w4, [x2, #0xa]
               	add	x4, x1, #0xb
               	ldrb	w4, [x3, x4]
               	strb	w4, [x2, #0xb]
               	add	x4, x1, #0xc
               	ldrb	w4, [x3, x4]
               	strb	w4, [x2, #0xc]
               	add	x1, x1, #0xd
               	ldrb	w1, [x3, x1]
               	strb	w1, [x2, #0xd]
               	sub	x3, x29, #0x218
               	lsl	x1, x0, #4
               	add	x4, x1, #0xe
               	ldrb	w4, [x3, x4]
               	strb	w4, [x2, #0xe]
               	sub	x2, x29, #0x1c8
               	add	x2, x2, x1
               	add	x1, x1, #0xf
               	ldrb	w1, [x3, x1]
               	strb	w1, [x2, #0xf]
               	add	x0, x0, #0x1
               	cmp	w0, #0x5
               	b.lt	<addr>
               	sub	x0, x29, #0x1c8
               	sub	x1, x29, #0xd8
               	bl	<addr>
               	sub	x0, x29, #0x1c8
               	sub	x1, x29, #0xd8
               	add	x1, x1, #0x10
               	bl	<addr>
               	sub	x0, x29, #0x1c8
               	sub	x1, x29, #0xd8
               	add	x1, x1, #0x20
               	bl	<addr>
               	sub	x0, x29, #0x1c8
               	sub	x1, x29, #0xd8
               	add	x1, x1, #0x30
               	bl	<addr>
               	sub	x0, x29, #0x1c8
               	sub	x1, x29, #0xd8
               	add	x1, x1, #0x40
               	bl	<addr>
               	sub	x0, x29, #0x1c8
               	sub	x1, x29, #0xd8
               	add	x1, x1, #0x50
               	bl	<addr>
               	sub	x0, x29, #0x1c8
               	sub	x1, x29, #0xd8
               	add	x1, x1, #0x60
               	bl	<addr>
               	sub	x21, x29, #0x1c8
               	sub	x0, x29, #0xd8
               	add	x1, x0, #0x70
               	mov	x0, x21
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x178
               	sub	x2, x29, #0x218
               	ldrb	w2, [x2, x0]
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x50
               	b.lt	<addr>
               	sub	x20, x29, #0x178
               	sub	x1, x29, #0xd8
               	mov	x2, #0x8                // =8
               	mov	x0, x20
               	bl	<addr>
               	mov	x2, #0x0                // =0
               	mov	x0, #0x0                // =0
               	lsl	x1, x2, #4
               	add	x3, x1, x0
               	ldrb	w3, [x20, x3]
               	add	x1, x21, x1
               	ldrb	w1, [x1, x0]
               	cmp	w3, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	add	x2, x2, #0x1
               	cmp	w2, #0x5
               	b.lt	<addr>
               	mov	x22, #0x0               // =0
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x128
               	sub	x2, x29, #0x218
               	ldrb	w2, [x2, x0]
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x50
               	b.lt	<addr>
               	sub	x21, x29, #0x128
               	sub	x23, x29, #0xd8
               	mov	x0, x21
               	mov	x2, x22
               	mov	x1, x23
               	bl	<addr>
               	add	x1, x23, x22, lsl #4
               	mov	x0, #0x8                // =8
               	sub	x2, x0, x22
               	mov	x0, x21
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldrb	w1, [x21, x0]
               	ldrb	w2, [x20, x0]
               	cmp	w1, w2
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x50
               	b.lt	<addr>
               	add	x22, x22, #0x1
               	cmp	w22, #0x8
               	b.le	<addr>
               	sub	x0, x29, #0x218
               	bl	<addr>
               	str	q0, [sp, #0x100]
               	sub	x0, x29, #0x218
               	add	x0, x0, #0x10
               	bl	<addr>
               	str	q0, [sp, #0xf0]
               	sub	x0, x29, #0x218
               	add	x0, x0, #0x20
               	bl	<addr>
               	str	q0, [sp, #0xe0]
               	sub	x0, x29, #0x218
               	add	x0, x0, #0x30
               	bl	<addr>
               	str	q0, [sp, #0xd0]
               	sub	x20, x29, #0x218
               	add	x0, x20, #0x40
               	bl	<addr>
               	sub	x0, x29, #0x310
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	stp	xzr, xzr, [x0, #0x30]
               	stp	xzr, xzr, [x0, #0x40]
               	ldr	q16, [sp, #0x100]
               	str	q16, [sp, #0x20]
               	ldr	q16, [sp, #0xf0]
               	str	q16, [sp, #0x30]
               	ldr	q16, [sp, #0xe0]
               	str	q16, [sp, #0x40]
               	ldr	q16, [sp, #0xd0]
               	str	q16, [sp, #0x50]
               	str	q0, [sp, #0x60]
               	sub	x0, x29, #0xd8
               	bl	<addr>
               	str	q0, [sp, #0x70]
               	sub	x7, x29, #0x2c0
               	sub	x0, x29, #0x2b0
               	sub	x1, x29, #0x310
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	ldp	x16, x17, [x1, #0x40]
               	stp	x16, x17, [x0, #0x40]
               	ldr	q0, [x7]
               	sub	x8, x29, #0x310
               	bl	<addr>
               	sub	x0, x29, #0x128
               	ldr	x1, [sp, #0x20]
               	ldr	x2, [sp, #0x28]
               	ldr	x3, [sp, #0x30]
               	ldr	x4, [sp, #0x38]
               	ldr	x5, [sp, #0x40]
               	ldr	x6, [sp, #0x48]
               	ldr	x8, [sp, #0x50]
               	ldr	x9, [sp, #0x58]
               	ldr	x10, [sp, #0x60]
               	ldr	x11, [sp, #0x68]
               	sub	x7, x29, #0x310
               	str	x1, [sp, #0x20]
               	str	x2, [sp, #0x28]
               	str	x3, [sp, #0x30]
               	str	x4, [sp, #0x38]
               	str	x5, [sp, #0x40]
               	str	x6, [sp, #0x48]
               	str	x8, [sp, #0x50]
               	str	x9, [sp, #0x58]
               	str	x10, [sp, #0x60]
               	str	x11, [sp, #0x68]
               	ldr	q0, [x7]
               	bl	<addr>
               	sub	x0, x29, #0x128
               	add	x0, x0, #0x10
               	sub	x1, x29, #0x310
               	add	x7, x1, #0x10
               	ldr	q0, [x7]
               	bl	<addr>
               	sub	x0, x29, #0x128
               	add	x0, x0, #0x20
               	sub	x1, x29, #0x310
               	add	x7, x1, #0x20
               	ldr	q0, [x7]
               	bl	<addr>
               	sub	x0, x29, #0x128
               	add	x0, x0, #0x30
               	sub	x1, x29, #0x310
               	add	x7, x1, #0x30
               	ldr	q0, [x7]
               	bl	<addr>
               	sub	x0, x29, #0x128
               	add	x0, x0, #0x40
               	sub	x1, x29, #0x310
               	add	x7, x1, #0x40
               	ldr	q0, [x7]
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x50
               	lsl	x1, x0, #4
               	add	x2, x2, x1
               	ldrb	w3, [x20, x1]
               	strb	w3, [x2]
               	add	x3, x1, #0x1
               	ldrb	w3, [x20, x3]
               	strb	w3, [x2, #0x1]
               	add	x3, x1, #0x2
               	ldrb	w3, [x20, x3]
               	strb	w3, [x2, #0x2]
               	add	x3, x1, #0x3
               	ldrb	w3, [x20, x3]
               	strb	w3, [x2, #0x3]
               	sub	x3, x29, #0x50
               	add	x4, x3, x1
               	sub	x2, x29, #0x218
               	add	x1, x1, #0x4
               	ldrb	w1, [x2, x1]
               	strb	w1, [x4, #0x4]
               	lsl	x1, x0, #4
               	add	x3, x3, x1
               	add	x4, x1, #0x5
               	ldrb	w4, [x2, x4]
               	strb	w4, [x3, #0x5]
               	add	x4, x1, #0x6
               	ldrb	w4, [x2, x4]
               	strb	w4, [x3, #0x6]
               	add	x4, x1, #0x7
               	ldrb	w2, [x2, x4]
               	strb	w2, [x3, #0x7]
               	sub	x2, x29, #0x218
               	add	x1, x1, #0x8
               	ldrb	w1, [x2, x1]
               	strb	w1, [x3, #0x8]
               	sub	x3, x29, #0x50
               	lsl	x1, x0, #4
               	add	x3, x3, x1
               	add	x4, x1, #0x9
               	ldrb	w4, [x2, x4]
               	strb	w4, [x3, #0x9]
               	add	x4, x1, #0xa
               	ldrb	w4, [x2, x4]
               	strb	w4, [x3, #0xa]
               	add	x4, x1, #0xb
               	ldrb	w2, [x2, x4]
               	strb	w2, [x3, #0xb]
               	sub	x2, x29, #0x218
               	add	x1, x1, #0xc
               	ldrb	w1, [x2, x1]
               	strb	w1, [x3, #0xc]
               	sub	x3, x29, #0x50
               	lsl	x1, x0, #4
               	add	x3, x3, x1
               	add	x4, x1, #0xd
               	ldrb	w4, [x2, x4]
               	strb	w4, [x3, #0xd]
               	add	x4, x1, #0xe
               	ldrb	w4, [x2, x4]
               	strb	w4, [x3, #0xe]
               	add	x1, x1, #0xf
               	ldrb	w1, [x2, x1]
               	strb	w1, [x3, #0xf]
               	add	x0, x0, #0x1
               	cmp	w0, #0x5
               	b.lt	<addr>
               	sub	x20, x29, #0x50
               	sub	x1, x29, #0xd8
               	mov	x0, x20
               	bl	<addr>
               	mov	x2, #0x0                // =0
               	mov	x0, #0x0                // =0
               	sub	x3, x29, #0x128
               	lsl	x1, x2, #4
               	add	x4, x1, x0
               	ldrb	w3, [x3, x4]
               	add	x1, x20, x1
               	ldrb	w1, [x1, x0]
               	cmp	w3, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	add	x2, x2, #0x1
               	cmp	w2, #0x5
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x330
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x14               // =20
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x330
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x22, #0x2
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x330
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x330
               	ldp	x29, x30, [sp], #0x10
               	ret
