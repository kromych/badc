
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

<mix>:
               	shl	v1.16b, v0.16b, #0x1
               	ushr	v0.16b, v0.16b, #0x7
               	mov	x0, #0x1b               // =27
               	umov	w1, v0.b[0]
               	mul	x1, x1, x0
               	mov	x2, #0x0                // =0
               	fmov	d2, x2
               	mov	v2.b[0], w1
               	umov	w1, v0.b[1]
               	mul	x1, x1, x0
               	mov	v2.b[1], w1
               	umov	w1, v0.b[2]
               	mul	x1, x1, x0
               	mov	v2.b[2], w1
               	umov	w1, v0.b[3]
               	mul	x1, x1, x0
               	mov	v2.b[3], w1
               	umov	w1, v0.b[4]
               	mul	x1, x1, x0
               	mov	v2.b[4], w1
               	umov	w1, v0.b[5]
               	mul	x1, x1, x0
               	mov	v2.b[5], w1
               	umov	w1, v0.b[6]
               	mul	x1, x1, x0
               	mov	v2.b[6], w1
               	umov	w1, v0.b[7]
               	mul	x1, x1, x0
               	mov	v2.b[7], w1
               	umov	w1, v0.b[8]
               	mul	x1, x1, x0
               	mov	v2.b[8], w1
               	umov	w1, v0.b[9]
               	mul	x1, x1, x0
               	mov	v2.b[9], w1
               	umov	w1, v0.b[10]
               	mul	x1, x1, x0
               	mov	v2.b[10], w1
               	umov	w1, v0.b[11]
               	mul	x1, x1, x0
               	mov	v2.b[11], w1
               	umov	w1, v0.b[12]
               	mul	x1, x1, x0
               	mov	v2.b[12], w1
               	umov	w1, v0.b[13]
               	mul	x1, x1, x0
               	mov	v2.b[13], w1
               	umov	w1, v0.b[14]
               	mul	x1, x1, x0
               	mov	v2.b[14], w1
               	umov	w1, v0.b[15]
               	mul	x0, x1, x0
               	mov	v0.16b, v2.16b
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
               	ret

<save_state>:
               	ldr	q0, [x0]
               	umov	w2, v0.b[0]
               	strb	w2, [x1]
               	umov	w2, v0.b[1]
               	strb	w2, [x1, #0x1]
               	umov	w2, v0.b[2]
               	strb	w2, [x1, #0x2]
               	umov	w2, v0.b[3]
               	strb	w2, [x1, #0x3]
               	umov	w2, v0.b[4]
               	strb	w2, [x1, #0x4]
               	umov	w2, v0.b[5]
               	strb	w2, [x1, #0x5]
               	umov	w2, v0.b[6]
               	strb	w2, [x1, #0x6]
               	umov	w2, v0.b[7]
               	strb	w2, [x1, #0x7]
               	umov	w2, v0.b[8]
               	strb	w2, [x1, #0x8]
               	umov	w2, v0.b[9]
               	strb	w2, [x1, #0x9]
               	umov	w2, v0.b[10]
               	strb	w2, [x1, #0xa]
               	umov	w2, v0.b[11]
               	strb	w2, [x1, #0xb]
               	umov	w2, v0.b[12]
               	strb	w2, [x1, #0xc]
               	umov	w2, v0.b[13]
               	strb	w2, [x1, #0xd]
               	umov	w2, v0.b[14]
               	strb	w2, [x1, #0xe]
               	umov	w2, v0.b[15]
               	strb	w2, [x1, #0xf]
               	add	x2, x1, #0x10
               	ldr	q0, [x0, #0x10]
               	umov	w3, v0.b[0]
               	strb	w3, [x2]
               	umov	w3, v0.b[1]
               	strb	w3, [x2, #0x1]
               	umov	w3, v0.b[2]
               	strb	w3, [x2, #0x2]
               	umov	w3, v0.b[3]
               	strb	w3, [x2, #0x3]
               	umov	w3, v0.b[4]
               	strb	w3, [x2, #0x4]
               	umov	w3, v0.b[5]
               	strb	w3, [x2, #0x5]
               	umov	w3, v0.b[6]
               	strb	w3, [x2, #0x6]
               	umov	w3, v0.b[7]
               	strb	w3, [x2, #0x7]
               	umov	w3, v0.b[8]
               	strb	w3, [x2, #0x8]
               	umov	w3, v0.b[9]
               	strb	w3, [x2, #0x9]
               	umov	w3, v0.b[10]
               	strb	w3, [x2, #0xa]
               	umov	w3, v0.b[11]
               	strb	w3, [x2, #0xb]
               	umov	w3, v0.b[12]
               	strb	w3, [x2, #0xc]
               	umov	w3, v0.b[13]
               	strb	w3, [x2, #0xd]
               	umov	w3, v0.b[14]
               	strb	w3, [x2, #0xe]
               	umov	w3, v0.b[15]
               	strb	w3, [x2, #0xf]
               	add	x2, x1, #0x20
               	ldr	q0, [x0, #0x20]
               	umov	w3, v0.b[0]
               	strb	w3, [x2]
               	umov	w3, v0.b[1]
               	strb	w3, [x2, #0x1]
               	umov	w3, v0.b[2]
               	strb	w3, [x2, #0x2]
               	umov	w3, v0.b[3]
               	strb	w3, [x2, #0x3]
               	umov	w3, v0.b[4]
               	strb	w3, [x2, #0x4]
               	umov	w3, v0.b[5]
               	strb	w3, [x2, #0x5]
               	umov	w3, v0.b[6]
               	strb	w3, [x2, #0x6]
               	umov	w3, v0.b[7]
               	strb	w3, [x2, #0x7]
               	umov	w3, v0.b[8]
               	strb	w3, [x2, #0x8]
               	umov	w3, v0.b[9]
               	strb	w3, [x2, #0x9]
               	umov	w3, v0.b[10]
               	strb	w3, [x2, #0xa]
               	umov	w3, v0.b[11]
               	strb	w3, [x2, #0xb]
               	umov	w3, v0.b[12]
               	strb	w3, [x2, #0xc]
               	umov	w3, v0.b[13]
               	strb	w3, [x2, #0xd]
               	umov	w3, v0.b[14]
               	strb	w3, [x2, #0xe]
               	umov	w3, v0.b[15]
               	strb	w3, [x2, #0xf]
               	add	x2, x1, #0x30
               	ldr	q0, [x0, #0x30]
               	umov	w3, v0.b[0]
               	strb	w3, [x2]
               	umov	w3, v0.b[1]
               	strb	w3, [x2, #0x1]
               	umov	w3, v0.b[2]
               	strb	w3, [x2, #0x2]
               	umov	w3, v0.b[3]
               	strb	w3, [x2, #0x3]
               	umov	w3, v0.b[4]
               	strb	w3, [x2, #0x4]
               	umov	w3, v0.b[5]
               	strb	w3, [x2, #0x5]
               	umov	w3, v0.b[6]
               	strb	w3, [x2, #0x6]
               	umov	w3, v0.b[7]
               	strb	w3, [x2, #0x7]
               	umov	w3, v0.b[8]
               	strb	w3, [x2, #0x8]
               	umov	w3, v0.b[9]
               	strb	w3, [x2, #0x9]
               	umov	w3, v0.b[10]
               	strb	w3, [x2, #0xa]
               	umov	w3, v0.b[11]
               	strb	w3, [x2, #0xb]
               	umov	w3, v0.b[12]
               	strb	w3, [x2, #0xc]
               	umov	w3, v0.b[13]
               	strb	w3, [x2, #0xd]
               	umov	w3, v0.b[14]
               	strb	w3, [x2, #0xe]
               	umov	w3, v0.b[15]
               	strb	w3, [x2, #0xf]
               	add	x1, x1, #0x40
               	ldr	q0, [x0, #0x40]
               	umov	w0, v0.b[0]
               	strb	w0, [x1]
               	umov	w0, v0.b[1]
               	strb	w0, [x1, #0x1]
               	umov	w0, v0.b[2]
               	strb	w0, [x1, #0x2]
               	umov	w0, v0.b[3]
               	strb	w0, [x1, #0x3]
               	umov	w0, v0.b[4]
               	strb	w0, [x1, #0x4]
               	umov	w0, v0.b[5]
               	strb	w0, [x1, #0x5]
               	umov	w0, v0.b[6]
               	strb	w0, [x1, #0x6]
               	umov	w0, v0.b[7]
               	strb	w0, [x1, #0x7]
               	umov	w0, v0.b[8]
               	strb	w0, [x1, #0x8]
               	umov	w0, v0.b[9]
               	strb	w0, [x1, #0x9]
               	umov	w0, v0.b[10]
               	strb	w0, [x1, #0xa]
               	umov	w0, v0.b[11]
               	strb	w0, [x1, #0xb]
               	umov	w0, v0.b[12]
               	strb	w0, [x1, #0xc]
               	umov	w0, v0.b[13]
               	strb	w0, [x1, #0xd]
               	umov	w0, v0.b[14]
               	strb	w0, [x1, #0xe]
               	umov	w0, v0.b[15]
               	strb	w0, [x1, #0xf]
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
               	stp	x20, x21, [sp, #-0x1a0]!
               	stp	x22, x23, [sp, #0x10]
               	str	x24, [sp, #0x20]
               	stp	x29, x30, [sp, #0x190]
               	add	x29, sp, #0x190
               	mov	x22, x0
               	mov	x24, x2
               	mov	x23, x1
               	sub	x0, x29, #0xc0
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	stp	xzr, xzr, [x0, #0x30]
               	stp	xzr, xzr, [x0, #0x40]
               	ldrb	w0, [x22]
               	mov	x1, #0x0                // =0
               	fmov	d0, x1
               	mov	v0.b[0], w0
               	ldrb	w0, [x22, #0x1]
               	mov	v0.b[1], w0
               	ldrb	w0, [x22, #0x2]
               	mov	v0.b[2], w0
               	ldrb	w0, [x22, #0x3]
               	mov	v0.b[3], w0
               	ldrb	w0, [x22, #0x4]
               	mov	v0.b[4], w0
               	ldrb	w0, [x22, #0x5]
               	mov	v0.b[5], w0
               	ldrb	w0, [x22, #0x6]
               	mov	v0.b[6], w0
               	ldrb	w0, [x22, #0x7]
               	mov	v0.b[7], w0
               	ldrb	w0, [x22, #0x8]
               	mov	v0.b[8], w0
               	ldrb	w0, [x22, #0x9]
               	mov	v0.b[9], w0
               	ldrb	w0, [x22, #0xa]
               	mov	v0.b[10], w0
               	ldrb	w0, [x22, #0xb]
               	mov	v0.b[11], w0
               	ldrb	w0, [x22, #0xc]
               	mov	v0.b[12], w0
               	ldrb	w0, [x22, #0xd]
               	mov	v0.b[13], w0
               	ldrb	w0, [x22, #0xe]
               	mov	v0.b[14], w0
               	ldrb	w0, [x22, #0xf]
               	mov	v0.b[15], w0
               	stur	q0, [x29, #-0xc0]
               	add	x0, x22, #0x10
               	ldrb	w1, [x0]
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
               	stur	q0, [x29, #-0xb0]
               	add	x0, x22, #0x20
               	ldrb	w1, [x0]
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
               	stur	q0, [x29, #-0xa0]
               	add	x0, x22, #0x30
               	ldrb	w1, [x0]
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
               	stur	q0, [x29, #-0x90]
               	add	x0, x22, #0x40
               	ldrb	w1, [x0]
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
               	stur	q0, [x29, #-0x80]
               	sub	x0, x29, #0x110
               	ldur	q1, [x29, #-0xc0]
               	ldur	q2, [x29, #-0xb0]
               	ldur	q3, [x29, #-0xa0]
               	ldur	q4, [x29, #-0x90]
               	str	q1, [sp, #0x80]
               	stur	q2, [x29, #-0x100]
               	stur	q3, [x29, #-0xf0]
               	stur	q4, [x29, #-0xe0]
               	stur	q0, [x29, #-0xd0]
               	sub	x1, x29, #0x160
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
               	mov	x21, #0x0               // =0
               	cmp	w21, w24
               	b.ge	<addr>
               	sub	x0, x29, #0x160
               	lsl	x1, x21, #4
               	sxtw	x1, w1
               	add	x3, x23, x1
               	ldrb	w1, [x3]
               	ldr	q0, [sp, #0x180]
               	mov	v0.b[0], w1
               	ldrb	w1, [x3, #0x1]
               	mov	v0.b[1], w1
               	ldrb	w1, [x3, #0x2]
               	mov	v0.b[2], w1
               	ldrb	w1, [x3, #0x3]
               	mov	v0.b[3], w1
               	ldrb	w1, [x3, #0x4]
               	mov	v0.b[4], w1
               	ldrb	w1, [x3, #0x5]
               	mov	v0.b[5], w1
               	ldrb	w1, [x3, #0x6]
               	mov	v0.b[6], w1
               	ldrb	w1, [x3, #0x7]
               	mov	v0.b[7], w1
               	ldrb	w1, [x3, #0x8]
               	mov	v0.b[8], w1
               	ldrb	w1, [x3, #0x9]
               	mov	v0.b[9], w1
               	ldrb	w1, [x3, #0xa]
               	mov	v0.b[10], w1
               	ldrb	w1, [x3, #0xb]
               	mov	v0.b[11], w1
               	ldrb	w1, [x3, #0xc]
               	mov	v0.b[12], w1
               	ldrb	w1, [x3, #0xd]
               	mov	v0.b[13], w1
               	ldrb	w1, [x3, #0xe]
               	mov	v0.b[14], w1
               	ldrb	w1, [x3, #0xf]
               	mov	v16.16b, v0.16b
               	mov	v16.b[15], w1
               	str	q16, [sp, #0x180]
               	sub	x20, x29, #0xc0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x20]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x20, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x20, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x20, #0x30]
               	ldp	x16, x17, [x0, #0x40]
               	stp	x16, x17, [x20, #0x40]
               	add	x7, x20, #0x40
               	ldr	q0, [x7]
               	bl	<addr>
               	ldr	q16, [sp, #0x180]
               	eor	v16.16b, v16.16b, v0.16b
               	str	q16, [sp, #0x170]
               	add	x7, x20, #0x30
               	ldr	q0, [x7]
               	bl	<addr>
               	ldur	q1, [x29, #-0x80]
               	eor	v0.16b, v1.16b, v0.16b
               	stur	q0, [x29, #-0x80]
               	add	x7, x20, #0x20
               	ldr	q0, [x7]
               	bl	<addr>
               	ldur	q1, [x29, #-0x90]
               	eor	v0.16b, v1.16b, v0.16b
               	stur	q0, [x29, #-0x90]
               	add	x7, x20, #0x10
               	ldr	q0, [x7]
               	bl	<addr>
               	ldur	q1, [x29, #-0xa0]
               	eor	v0.16b, v1.16b, v0.16b
               	stur	q0, [x29, #-0xa0]
               	ldr	q0, [x20]
               	bl	<addr>
               	ldur	q1, [x29, #-0xb0]
               	eor	v0.16b, v1.16b, v0.16b
               	stur	q0, [x29, #-0xb0]
               	ldur	q1, [x29, #-0xc0]
               	ldr	q17, [sp, #0x170]
               	eor	v1.16b, v1.16b, v17.16b
               	stur	q1, [x29, #-0xc0]
               	ldur	q2, [x29, #-0xa0]
               	ldur	q3, [x29, #-0x90]
               	ldur	q4, [x29, #-0x80]
               	str	q1, [sp, #0x30]
               	str	q0, [sp, #0x40]
               	str	q2, [sp, #0x50]
               	str	q3, [sp, #0x60]
               	str	q4, [sp, #0x70]
               	add	x21, x21, #0x1
               	cmp	w21, w24
               	b.lt	<addr>
               	sub	x1, x29, #0x160
               	sub	x0, x29, #0x70
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
               	mov	x1, x22
               	bl	<addr>
               	ldp	x29, x30, [sp, #0x190]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1a0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x340
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
               	mov	x5, #0x0                // =0
               	mov	x0, #0x0                // =0
               	lsl	x1, x5, #4
               	add	x2, x21, x1
               	add	x3, x1, x0
               	ldrb	w3, [x20, x3]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	add	x5, x5, #0x1
               	cmp	w5, #0x5
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
               	sub	x1, x29, #0x218
               	ldrb	w0, [sp, #0x128]
               	mov	x2, #0x0                // =0
               	fmov	d0, x2
               	mov	v0.b[0], w0
               	ldrb	w0, [sp, #0x129]
               	mov	v0.b[1], w0
               	ldrb	w0, [sp, #0x12a]
               	mov	v0.b[2], w0
               	ldrb	w0, [sp, #0x12b]
               	mov	v0.b[3], w0
               	ldrb	w0, [sp, #0x12c]
               	mov	v0.b[4], w0
               	ldrb	w0, [sp, #0x12d]
               	mov	v0.b[5], w0
               	ldrb	w0, [sp, #0x12e]
               	mov	v0.b[6], w0
               	ldrb	w0, [sp, #0x12f]
               	mov	v0.b[7], w0
               	ldrb	w0, [sp, #0x130]
               	mov	v0.b[8], w0
               	ldrb	w0, [sp, #0x131]
               	mov	v0.b[9], w0
               	ldrb	w0, [sp, #0x132]
               	mov	v0.b[10], w0
               	ldrb	w0, [sp, #0x133]
               	mov	v0.b[11], w0
               	ldrb	w0, [sp, #0x134]
               	mov	v0.b[12], w0
               	ldrb	w0, [sp, #0x135]
               	mov	v0.b[13], w0
               	ldrb	w0, [sp, #0x136]
               	mov	v0.b[14], w0
               	ldrb	w0, [sp, #0x137]
               	mov	v0.b[15], w0
               	add	x0, x1, #0x10
               	ldrb	w2, [x0]
               	mov	v1.16b, v0.16b
               	mov	v1.b[0], w2
               	ldrb	w2, [x0, #0x1]
               	mov	v1.b[1], w2
               	ldrb	w2, [x0, #0x2]
               	mov	v1.b[2], w2
               	ldrb	w2, [x0, #0x3]
               	mov	v1.b[3], w2
               	ldrb	w2, [x0, #0x4]
               	mov	v1.b[4], w2
               	ldrb	w2, [x0, #0x5]
               	mov	v1.b[5], w2
               	ldrb	w2, [x0, #0x6]
               	mov	v1.b[6], w2
               	ldrb	w2, [x0, #0x7]
               	mov	v1.b[7], w2
               	ldrb	w2, [x0, #0x8]
               	mov	v1.b[8], w2
               	ldrb	w2, [x0, #0x9]
               	mov	v1.b[9], w2
               	ldrb	w2, [x0, #0xa]
               	mov	v1.b[10], w2
               	ldrb	w2, [x0, #0xb]
               	mov	v1.b[11], w2
               	ldrb	w2, [x0, #0xc]
               	mov	v1.b[12], w2
               	ldrb	w2, [x0, #0xd]
               	mov	v1.b[13], w2
               	ldrb	w2, [x0, #0xe]
               	mov	v1.b[14], w2
               	ldrb	w0, [x0, #0xf]
               	mov	v1.b[15], w0
               	add	x0, x1, #0x20
               	ldrb	w1, [x0]
               	mov	v2.16b, v1.16b
               	mov	v2.b[0], w1
               	ldrb	w1, [x0, #0x1]
               	mov	v2.b[1], w1
               	ldrb	w1, [x0, #0x2]
               	mov	v2.b[2], w1
               	ldrb	w1, [x0, #0x3]
               	mov	v2.b[3], w1
               	ldrb	w1, [x0, #0x4]
               	mov	v2.b[4], w1
               	ldrb	w1, [x0, #0x5]
               	mov	v2.b[5], w1
               	ldrb	w1, [x0, #0x6]
               	mov	v2.b[6], w1
               	ldrb	w1, [x0, #0x7]
               	mov	v2.b[7], w1
               	ldrb	w1, [x0, #0x8]
               	mov	v2.b[8], w1
               	ldrb	w1, [x0, #0x9]
               	mov	v2.b[9], w1
               	ldrb	w1, [x0, #0xa]
               	mov	v2.b[10], w1
               	ldrb	w1, [x0, #0xb]
               	mov	v2.b[11], w1
               	ldrb	w1, [x0, #0xc]
               	mov	v2.b[12], w1
               	ldrb	w1, [x0, #0xd]
               	mov	v2.b[13], w1
               	ldrb	w1, [x0, #0xe]
               	mov	v2.b[14], w1
               	ldrb	w0, [x0, #0xf]
               	mov	v2.b[15], w0
               	sub	x1, x29, #0x218
               	add	x0, x1, #0x30
               	ldrb	w2, [x0]
               	mov	v3.16b, v2.16b
               	mov	v3.b[0], w2
               	ldrb	w2, [x0, #0x1]
               	mov	v3.b[1], w2
               	ldrb	w2, [x0, #0x2]
               	mov	v3.b[2], w2
               	ldrb	w2, [x0, #0x3]
               	mov	v3.b[3], w2
               	ldrb	w2, [x0, #0x4]
               	mov	v3.b[4], w2
               	ldrb	w2, [x0, #0x5]
               	mov	v3.b[5], w2
               	ldrb	w2, [x0, #0x6]
               	mov	v3.b[6], w2
               	ldrb	w2, [x0, #0x7]
               	mov	v3.b[7], w2
               	ldrb	w2, [x0, #0x8]
               	mov	v3.b[8], w2
               	ldrb	w2, [x0, #0x9]
               	mov	v3.b[9], w2
               	ldrb	w2, [x0, #0xa]
               	mov	v3.b[10], w2
               	ldrb	w2, [x0, #0xb]
               	mov	v3.b[11], w2
               	ldrb	w2, [x0, #0xc]
               	mov	v3.b[12], w2
               	ldrb	w2, [x0, #0xd]
               	mov	v3.b[13], w2
               	ldrb	w2, [x0, #0xe]
               	mov	v3.b[14], w2
               	ldrb	w0, [x0, #0xf]
               	mov	v3.b[15], w0
               	add	x0, x1, #0x40
               	ldrb	w1, [x0]
               	mov	v4.16b, v3.16b
               	mov	v4.b[0], w1
               	ldrb	w1, [x0, #0x1]
               	mov	v4.b[1], w1
               	ldrb	w1, [x0, #0x2]
               	mov	v4.b[2], w1
               	ldrb	w1, [x0, #0x3]
               	mov	v4.b[3], w1
               	ldrb	w1, [x0, #0x4]
               	mov	v4.b[4], w1
               	ldrb	w1, [x0, #0x5]
               	mov	v4.b[5], w1
               	ldrb	w1, [x0, #0x6]
               	mov	v4.b[6], w1
               	ldrb	w1, [x0, #0x7]
               	mov	v4.b[7], w1
               	ldrb	w1, [x0, #0x8]
               	mov	v4.b[8], w1
               	ldrb	w1, [x0, #0x9]
               	mov	v4.b[9], w1
               	ldrb	w1, [x0, #0xa]
               	mov	v4.b[10], w1
               	ldrb	w1, [x0, #0xb]
               	mov	v4.b[11], w1
               	ldrb	w1, [x0, #0xc]
               	mov	v4.b[12], w1
               	ldrb	w1, [x0, #0xd]
               	mov	v4.b[13], w1
               	ldrb	w1, [x0, #0xe]
               	mov	v4.b[14], w1
               	ldrb	w0, [x0, #0xf]
               	mov	v4.b[15], w0
               	sub	x0, x29, #0x320
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	stp	xzr, xzr, [x0, #0x30]
               	stp	xzr, xzr, [x0, #0x40]
               	str	q0, [sp, #0x20]
               	str	q1, [sp, #0x30]
               	str	q2, [sp, #0x40]
               	str	q3, [sp, #0x50]
               	str	q4, [sp, #0x60]
               	ldurb	w1, [x29, #-0xd8]
               	mov	v0.16b, v4.16b
               	mov	v0.b[0], w1
               	ldurb	w1, [x29, #-0xd7]
               	mov	v0.b[1], w1
               	ldurb	w1, [x29, #-0xd6]
               	mov	v0.b[2], w1
               	ldurb	w1, [x29, #-0xd5]
               	mov	v0.b[3], w1
               	ldurb	w1, [x29, #-0xd4]
               	mov	v0.b[4], w1
               	ldurb	w1, [x29, #-0xd3]
               	mov	v0.b[5], w1
               	ldurb	w1, [x29, #-0xd2]
               	mov	v0.b[6], w1
               	ldurb	w1, [x29, #-0xd1]
               	mov	v0.b[7], w1
               	ldurb	w1, [x29, #-0xd0]
               	mov	v0.b[8], w1
               	ldurb	w1, [x29, #-0xcf]
               	mov	v0.b[9], w1
               	ldurb	w1, [x29, #-0xce]
               	mov	v0.b[10], w1
               	ldurb	w1, [x29, #-0xcd]
               	mov	v0.b[11], w1
               	ldurb	w1, [x29, #-0xcc]
               	mov	v0.b[12], w1
               	ldurb	w1, [x29, #-0xcb]
               	mov	v0.b[13], w1
               	ldurb	w1, [x29, #-0xca]
               	mov	v0.b[14], w1
               	ldurb	w1, [x29, #-0xc9]
               	mov	v16.16b, v0.16b
               	mov	v16.b[15], w1
               	str	q16, [sp, #0x110]
               	sub	x1, x29, #0x2d0
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
               	add	x7, x1, #0x40
               	ldr	q0, [x7]
               	bl	<addr>
               	ldr	q16, [sp, #0x110]
               	eor	v16.16b, v16.16b, v0.16b
               	str	q16, [sp, #0x110]
               	sub	x0, x29, #0x2d0
               	add	x7, x0, #0x30
               	ldr	q0, [x7]
               	bl	<addr>
               	ldr	q1, [sp, #0xb0]
               	eor	v0.16b, v1.16b, v0.16b
               	str	q0, [sp, #0xb0]
               	sub	x0, x29, #0x2d0
               	add	x7, x0, #0x20
               	ldr	q0, [x7]
               	bl	<addr>
               	ldr	q1, [sp, #0xa0]
               	eor	v0.16b, v1.16b, v0.16b
               	str	q0, [sp, #0xa0]
               	sub	x0, x29, #0x2d0
               	add	x7, x0, #0x10
               	ldr	q0, [x7]
               	bl	<addr>
               	ldr	q1, [sp, #0x90]
               	eor	v0.16b, v1.16b, v0.16b
               	str	q0, [sp, #0x90]
               	sub	x7, x29, #0x2d0
               	ldr	q0, [x7]
               	bl	<addr>
               	ldr	q1, [sp, #0x80]
               	eor	v0.16b, v1.16b, v0.16b
               	str	q0, [sp, #0x80]
               	ldr	q1, [sp, #0x70]
               	ldr	q17, [sp, #0x110]
               	eor	v1.16b, v1.16b, v17.16b
               	str	q1, [sp, #0x70]
               	sub	x2, x29, #0x320
               	ldr	q2, [sp, #0x90]
               	ldr	q3, [sp, #0xa0]
               	ldr	q4, [sp, #0xb0]
               	str	q1, [sp, #0x20]
               	str	q0, [sp, #0x30]
               	str	q2, [sp, #0x40]
               	str	q3, [sp, #0x50]
               	str	q4, [sp, #0x60]
               	sub	x1, x29, #0x128
               	sub	x0, x29, #0x280
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x2, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	ldp	x16, x17, [x2, #0x40]
               	stp	x16, x17, [x0, #0x40]
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x50
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
               	sub	x2, x29, #0x50
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
               	sub	x2, x29, #0x50
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
               	sub	x2, x29, #0x50
               	add	x2, x2, x1
               	add	x1, x1, #0xf
               	ldrb	w1, [x3, x1]
               	strb	w1, [x2, #0xf]
               	add	x0, x0, #0x1
               	cmp	w0, #0x5
               	b.lt	<addr>
               	sub	x20, x29, #0x50
               	sub	x1, x29, #0xd8
               	mov	x0, x20
               	bl	<addr>
               	mov	x5, #0x0                // =0
               	mov	x0, #0x0                // =0
               	lsl	x1, x5, #4
               	add	x2, x20, x1
               	sub	x3, x29, #0x128
               	add	x4, x1, x0
               	ldrb	w3, [x3, x4]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	add	x5, x5, #0x1
               	cmp	w5, #0x5
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x340
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x14               // =20
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x340
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x22, #0x2
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x340
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x340
               	ldp	x29, x30, [sp], #0x10
               	ret
