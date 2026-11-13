
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
               	str	b0, [x1]
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
               	ldr	q0, [x0, #0x10]
               	umov	w2, v0.b[0]
               	strb	w2, [x1, #0x10]
               	umov	w2, v0.b[1]
               	strb	w2, [x1, #0x11]
               	umov	w2, v0.b[2]
               	strb	w2, [x1, #0x12]
               	umov	w2, v0.b[3]
               	strb	w2, [x1, #0x13]
               	umov	w2, v0.b[4]
               	strb	w2, [x1, #0x14]
               	umov	w2, v0.b[5]
               	strb	w2, [x1, #0x15]
               	umov	w2, v0.b[6]
               	strb	w2, [x1, #0x16]
               	umov	w2, v0.b[7]
               	strb	w2, [x1, #0x17]
               	umov	w2, v0.b[8]
               	strb	w2, [x1, #0x18]
               	umov	w2, v0.b[9]
               	strb	w2, [x1, #0x19]
               	umov	w2, v0.b[10]
               	strb	w2, [x1, #0x1a]
               	umov	w2, v0.b[11]
               	strb	w2, [x1, #0x1b]
               	umov	w2, v0.b[12]
               	strb	w2, [x1, #0x1c]
               	umov	w2, v0.b[13]
               	strb	w2, [x1, #0x1d]
               	umov	w2, v0.b[14]
               	strb	w2, [x1, #0x1e]
               	umov	w2, v0.b[15]
               	strb	w2, [x1, #0x1f]
               	ldr	q0, [x0, #0x20]
               	umov	w2, v0.b[0]
               	strb	w2, [x1, #0x20]
               	umov	w2, v0.b[1]
               	strb	w2, [x1, #0x21]
               	umov	w2, v0.b[2]
               	strb	w2, [x1, #0x22]
               	umov	w2, v0.b[3]
               	strb	w2, [x1, #0x23]
               	umov	w2, v0.b[4]
               	strb	w2, [x1, #0x24]
               	umov	w2, v0.b[5]
               	strb	w2, [x1, #0x25]
               	umov	w2, v0.b[6]
               	strb	w2, [x1, #0x26]
               	umov	w2, v0.b[7]
               	strb	w2, [x1, #0x27]
               	umov	w2, v0.b[8]
               	strb	w2, [x1, #0x28]
               	umov	w2, v0.b[9]
               	strb	w2, [x1, #0x29]
               	umov	w2, v0.b[10]
               	strb	w2, [x1, #0x2a]
               	umov	w2, v0.b[11]
               	strb	w2, [x1, #0x2b]
               	umov	w2, v0.b[12]
               	strb	w2, [x1, #0x2c]
               	umov	w2, v0.b[13]
               	strb	w2, [x1, #0x2d]
               	umov	w2, v0.b[14]
               	strb	w2, [x1, #0x2e]
               	umov	w2, v0.b[15]
               	strb	w2, [x1, #0x2f]
               	ldr	q0, [x0, #0x30]
               	umov	w2, v0.b[0]
               	strb	w2, [x1, #0x30]
               	umov	w2, v0.b[1]
               	strb	w2, [x1, #0x31]
               	umov	w2, v0.b[2]
               	strb	w2, [x1, #0x32]
               	umov	w2, v0.b[3]
               	strb	w2, [x1, #0x33]
               	umov	w2, v0.b[4]
               	strb	w2, [x1, #0x34]
               	umov	w2, v0.b[5]
               	strb	w2, [x1, #0x35]
               	umov	w2, v0.b[6]
               	strb	w2, [x1, #0x36]
               	umov	w2, v0.b[7]
               	strb	w2, [x1, #0x37]
               	umov	w2, v0.b[8]
               	strb	w2, [x1, #0x38]
               	umov	w2, v0.b[9]
               	strb	w2, [x1, #0x39]
               	umov	w2, v0.b[10]
               	strb	w2, [x1, #0x3a]
               	umov	w2, v0.b[11]
               	strb	w2, [x1, #0x3b]
               	umov	w2, v0.b[12]
               	strb	w2, [x1, #0x3c]
               	umov	w2, v0.b[13]
               	strb	w2, [x1, #0x3d]
               	umov	w2, v0.b[14]
               	strb	w2, [x1, #0x3e]
               	umov	w2, v0.b[15]
               	strb	w2, [x1, #0x3f]
               	ldr	q0, [x0, #0x40]
               	umov	w0, v0.b[0]
               	strb	w0, [x1, #0x40]
               	umov	w0, v0.b[1]
               	strb	w0, [x1, #0x41]
               	umov	w0, v0.b[2]
               	strb	w0, [x1, #0x42]
               	umov	w0, v0.b[3]
               	strb	w0, [x1, #0x43]
               	umov	w0, v0.b[4]
               	strb	w0, [x1, #0x44]
               	umov	w0, v0.b[5]
               	strb	w0, [x1, #0x45]
               	umov	w0, v0.b[6]
               	strb	w0, [x1, #0x46]
               	umov	w0, v0.b[7]
               	strb	w0, [x1, #0x47]
               	umov	w0, v0.b[8]
               	strb	w0, [x1, #0x48]
               	umov	w0, v0.b[9]
               	strb	w0, [x1, #0x49]
               	umov	w0, v0.b[10]
               	strb	w0, [x1, #0x4a]
               	umov	w0, v0.b[11]
               	strb	w0, [x1, #0x4b]
               	umov	w0, v0.b[12]
               	strb	w0, [x1, #0x4c]
               	umov	w0, v0.b[13]
               	strb	w0, [x1, #0x4d]
               	umov	w0, v0.b[14]
               	strb	w0, [x1, #0x4e]
               	umov	w0, v0.b[15]
               	strb	w0, [x1, #0x4f]
               	ret

<update_scalar>:
               	stp	x20, x21, [sp, #-0x50]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	str	x26, [sp, #0x30]
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	ldrb	w3, [x1]
               	ldrb	w2, [x0, #0x40]
               	lsr	x4, x2, #7
               	mov	x17, #0x1b              // =27
               	mul	x4, x4, x17
               	eor	x2, x4, x2, lsl #1
               	mov	x17, #0x63              // =99
               	eor	x2, x2, x17
               	and	x2, x2, #0xff
               	eor	x7, x3, x2
               	ldrb	w3, [x1, #0x1]
               	ldrb	w2, [x0, #0x41]
               	lsr	x4, x2, #7
               	mov	x17, #0x1b              // =27
               	mul	x4, x4, x17
               	eor	x2, x4, x2, lsl #1
               	mov	x17, #0x63              // =99
               	eor	x2, x2, x17
               	and	x2, x2, #0xff
               	eor	x8, x3, x2
               	ldrb	w3, [x1, #0x2]
               	ldrb	w2, [x0, #0x42]
               	lsr	x4, x2, #7
               	mov	x17, #0x1b              // =27
               	mul	x4, x4, x17
               	eor	x2, x4, x2, lsl #1
               	mov	x17, #0x63              // =99
               	eor	x2, x2, x17
               	and	x2, x2, #0xff
               	eor	x9, x3, x2
               	ldrb	w3, [x1, #0x3]
               	ldrb	w2, [x0, #0x43]
               	lsr	x4, x2, #7
               	mov	x17, #0x1b              // =27
               	mul	x4, x4, x17
               	eor	x2, x4, x2, lsl #1
               	mov	x17, #0x63              // =99
               	eor	x2, x2, x17
               	and	x2, x2, #0xff
               	eor	x10, x3, x2
               	ldrb	w3, [x1, #0x4]
               	ldrb	w2, [x0, #0x44]
               	lsr	x4, x2, #7
               	mov	x17, #0x1b              // =27
               	mul	x4, x4, x17
               	eor	x2, x4, x2, lsl #1
               	mov	x17, #0x63              // =99
               	eor	x2, x2, x17
               	and	x2, x2, #0xff
               	eor	x11, x3, x2
               	ldrb	w3, [x1, #0x5]
               	ldrb	w2, [x0, #0x45]
               	lsr	x4, x2, #7
               	mov	x17, #0x1b              // =27
               	mul	x4, x4, x17
               	eor	x2, x4, x2, lsl #1
               	mov	x17, #0x63              // =99
               	eor	x2, x2, x17
               	and	x2, x2, #0xff
               	eor	x12, x3, x2
               	ldrb	w3, [x1, #0x6]
               	ldrb	w2, [x0, #0x46]
               	lsr	x4, x2, #7
               	mov	x17, #0x1b              // =27
               	mul	x4, x4, x17
               	eor	x2, x4, x2, lsl #1
               	mov	x17, #0x63              // =99
               	eor	x2, x2, x17
               	and	x2, x2, #0xff
               	eor	x13, x3, x2
               	ldrb	w3, [x1, #0x7]
               	ldrb	w2, [x0, #0x47]
               	lsr	x4, x2, #7
               	mov	x17, #0x1b              // =27
               	mul	x4, x4, x17
               	eor	x2, x4, x2, lsl #1
               	mov	x17, #0x63              // =99
               	eor	x2, x2, x17
               	and	x2, x2, #0xff
               	eor	x14, x3, x2
               	ldrb	w3, [x1, #0x8]
               	ldrb	w2, [x0, #0x48]
               	lsr	x4, x2, #7
               	mov	x17, #0x1b              // =27
               	mul	x4, x4, x17
               	eor	x2, x4, x2, lsl #1
               	mov	x17, #0x63              // =99
               	eor	x2, x2, x17
               	and	x2, x2, #0xff
               	eor	x15, x3, x2
               	ldrb	w3, [x1, #0x9]
               	ldrb	w2, [x0, #0x49]
               	lsr	x4, x2, #7
               	mov	x17, #0x1b              // =27
               	mul	x4, x4, x17
               	eor	x2, x4, x2, lsl #1
               	mov	x17, #0x63              // =99
               	eor	x2, x2, x17
               	and	x2, x2, #0xff
               	eor	x20, x3, x2
               	ldrb	w3, [x1, #0xa]
               	ldrb	w2, [x0, #0x4a]
               	lsr	x4, x2, #7
               	mov	x17, #0x1b              // =27
               	mul	x4, x4, x17
               	eor	x2, x4, x2, lsl #1
               	mov	x17, #0x63              // =99
               	eor	x2, x2, x17
               	and	x2, x2, #0xff
               	eor	x21, x3, x2
               	ldrb	w3, [x1, #0xb]
               	ldrb	w2, [x0, #0x4b]
               	lsr	x4, x2, #7
               	mov	x17, #0x1b              // =27
               	mul	x4, x4, x17
               	eor	x2, x4, x2, lsl #1
               	mov	x17, #0x63              // =99
               	eor	x2, x2, x17
               	and	x2, x2, #0xff
               	eor	x22, x3, x2
               	ldrb	w3, [x1, #0xc]
               	ldrb	w2, [x0, #0x4c]
               	lsr	x4, x2, #7
               	mov	x17, #0x1b              // =27
               	mul	x4, x4, x17
               	eor	x2, x4, x2, lsl #1
               	mov	x17, #0x63              // =99
               	eor	x2, x2, x17
               	and	x2, x2, #0xff
               	eor	x23, x3, x2
               	ldrb	w3, [x1, #0xd]
               	ldrb	w2, [x0, #0x4d]
               	lsr	x4, x2, #7
               	mov	x17, #0x1b              // =27
               	mul	x4, x4, x17
               	eor	x2, x4, x2, lsl #1
               	mov	x17, #0x63              // =99
               	eor	x2, x2, x17
               	and	x2, x2, #0xff
               	eor	x24, x3, x2
               	ldrb	w3, [x1, #0xe]
               	ldrb	w2, [x0, #0x4e]
               	lsr	x4, x2, #7
               	mov	x17, #0x1b              // =27
               	mul	x4, x4, x17
               	eor	x2, x4, x2, lsl #1
               	mov	x17, #0x63              // =99
               	eor	x2, x2, x17
               	and	x2, x2, #0xff
               	eor	x25, x3, x2
               	ldrb	w2, [x1, #0xf]
               	ldrb	w1, [x0, #0x4f]
               	lsr	x3, x1, #7
               	mov	x17, #0x1b              // =27
               	mul	x3, x3, x17
               	eor	x1, x3, x1, lsl #1
               	mov	x17, #0x63              // =99
               	eor	x1, x1, x17
               	and	x1, x1, #0xff
               	eor	x26, x2, x1
               	mov	x1, #0x4                // =4
               	lsl	x2, x1, #4
               	ldrb	w4, [x0, x2]
               	sub	x3, x1, #0x1
               	lsl	x3, x3, #4
               	ldrb	w3, [x0, x3]
               	lsr	x5, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x5, x5, x17
               	eor	x3, x5, x3, lsl #1
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	and	x3, x3, #0xff
               	eor	x3, x4, x3
               	strb	w3, [x0, x2]
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
               	stp	x20, x21, [sp, #-0x190]!
               	stp	x22, x23, [sp, #0x10]
               	str	x24, [sp, #0x20]
               	stp	x29, x30, [sp, #0x180]
               	add	x29, sp, #0x180
               	mov	x20, x0
               	mov	x24, x2
               	mov	x23, x1
               	ld1	{ v0.b }[0], [x20]
               	ldrb	w0, [x20, #0x1]
               	mov	v0.b[1], w0
               	ldrb	w0, [x20, #0x2]
               	mov	v0.b[2], w0
               	ldrb	w0, [x20, #0x3]
               	mov	v0.b[3], w0
               	ldrb	w0, [x20, #0x4]
               	mov	v0.b[4], w0
               	ldrb	w0, [x20, #0x5]
               	mov	v0.b[5], w0
               	ldrb	w0, [x20, #0x6]
               	mov	v0.b[6], w0
               	ldrb	w0, [x20, #0x7]
               	mov	v0.b[7], w0
               	ldrb	w0, [x20, #0x8]
               	mov	v0.b[8], w0
               	ldrb	w0, [x20, #0x9]
               	mov	v0.b[9], w0
               	ldrb	w0, [x20, #0xa]
               	mov	v0.b[10], w0
               	ldrb	w0, [x20, #0xb]
               	mov	v0.b[11], w0
               	ldrb	w0, [x20, #0xc]
               	mov	v0.b[12], w0
               	ldrb	w0, [x20, #0xd]
               	mov	v0.b[13], w0
               	ldrb	w0, [x20, #0xe]
               	mov	v0.b[14], w0
               	ldrb	w0, [x20, #0xf]
               	mov	v0.b[15], w0
               	stur	q0, [x29, #-0xb0]
               	ldrb	w0, [x20, #0x10]
               	mov	v0.b[0], w0
               	ldrb	w0, [x20, #0x11]
               	mov	v0.b[1], w0
               	ldrb	w0, [x20, #0x12]
               	mov	v0.b[2], w0
               	ldrb	w0, [x20, #0x13]
               	mov	v0.b[3], w0
               	ldrb	w0, [x20, #0x14]
               	mov	v0.b[4], w0
               	ldrb	w0, [x20, #0x15]
               	mov	v0.b[5], w0
               	ldrb	w0, [x20, #0x16]
               	mov	v0.b[6], w0
               	ldrb	w0, [x20, #0x17]
               	mov	v0.b[7], w0
               	ldrb	w0, [x20, #0x18]
               	mov	v0.b[8], w0
               	ldrb	w0, [x20, #0x19]
               	mov	v0.b[9], w0
               	ldrb	w0, [x20, #0x1a]
               	mov	v0.b[10], w0
               	ldrb	w0, [x20, #0x1b]
               	mov	v0.b[11], w0
               	ldrb	w0, [x20, #0x1c]
               	mov	v0.b[12], w0
               	ldrb	w0, [x20, #0x1d]
               	mov	v0.b[13], w0
               	ldrb	w0, [x20, #0x1e]
               	mov	v0.b[14], w0
               	ldrb	w0, [x20, #0x1f]
               	mov	v0.b[15], w0
               	stur	q0, [x29, #-0xa0]
               	ldrb	w0, [x20, #0x20]
               	mov	v0.b[0], w0
               	ldrb	w0, [x20, #0x21]
               	mov	v0.b[1], w0
               	ldrb	w0, [x20, #0x22]
               	mov	v0.b[2], w0
               	ldrb	w0, [x20, #0x23]
               	mov	v0.b[3], w0
               	ldrb	w0, [x20, #0x24]
               	mov	v0.b[4], w0
               	ldrb	w0, [x20, #0x25]
               	mov	v0.b[5], w0
               	ldrb	w0, [x20, #0x26]
               	mov	v0.b[6], w0
               	ldrb	w0, [x20, #0x27]
               	mov	v0.b[7], w0
               	ldrb	w0, [x20, #0x28]
               	mov	v0.b[8], w0
               	ldrb	w0, [x20, #0x29]
               	mov	v0.b[9], w0
               	ldrb	w0, [x20, #0x2a]
               	mov	v0.b[10], w0
               	ldrb	w0, [x20, #0x2b]
               	mov	v0.b[11], w0
               	ldrb	w0, [x20, #0x2c]
               	mov	v0.b[12], w0
               	ldrb	w0, [x20, #0x2d]
               	mov	v0.b[13], w0
               	ldrb	w0, [x20, #0x2e]
               	mov	v0.b[14], w0
               	ldrb	w0, [x20, #0x2f]
               	mov	v0.b[15], w0
               	stur	q0, [x29, #-0x90]
               	ldrb	w0, [x20, #0x30]
               	mov	v0.b[0], w0
               	ldrb	w0, [x20, #0x31]
               	mov	v0.b[1], w0
               	ldrb	w0, [x20, #0x32]
               	mov	v0.b[2], w0
               	ldrb	w0, [x20, #0x33]
               	mov	v0.b[3], w0
               	ldrb	w0, [x20, #0x34]
               	mov	v0.b[4], w0
               	ldrb	w0, [x20, #0x35]
               	mov	v0.b[5], w0
               	ldrb	w0, [x20, #0x36]
               	mov	v0.b[6], w0
               	ldrb	w0, [x20, #0x37]
               	mov	v0.b[7], w0
               	ldrb	w0, [x20, #0x38]
               	mov	v0.b[8], w0
               	ldrb	w0, [x20, #0x39]
               	mov	v0.b[9], w0
               	ldrb	w0, [x20, #0x3a]
               	mov	v0.b[10], w0
               	ldrb	w0, [x20, #0x3b]
               	mov	v0.b[11], w0
               	ldrb	w0, [x20, #0x3c]
               	mov	v0.b[12], w0
               	ldrb	w0, [x20, #0x3d]
               	mov	v0.b[13], w0
               	ldrb	w0, [x20, #0x3e]
               	mov	v0.b[14], w0
               	ldrb	w0, [x20, #0x3f]
               	mov	v0.b[15], w0
               	stur	q0, [x29, #-0x80]
               	ldrb	w0, [x20, #0x40]
               	mov	v0.b[0], w0
               	ldrb	w0, [x20, #0x41]
               	mov	v0.b[1], w0
               	ldrb	w0, [x20, #0x42]
               	mov	v0.b[2], w0
               	ldrb	w0, [x20, #0x43]
               	mov	v0.b[3], w0
               	ldrb	w0, [x20, #0x44]
               	mov	v0.b[4], w0
               	ldrb	w0, [x20, #0x45]
               	mov	v0.b[5], w0
               	ldrb	w0, [x20, #0x46]
               	mov	v0.b[6], w0
               	ldrb	w0, [x20, #0x47]
               	mov	v0.b[7], w0
               	ldrb	w0, [x20, #0x48]
               	mov	v0.b[8], w0
               	ldrb	w0, [x20, #0x49]
               	mov	v0.b[9], w0
               	ldrb	w0, [x20, #0x4a]
               	mov	v0.b[10], w0
               	ldrb	w0, [x20, #0x4b]
               	mov	v0.b[11], w0
               	ldrb	w0, [x20, #0x4c]
               	mov	v0.b[12], w0
               	ldrb	w0, [x20, #0x4d]
               	mov	v0.b[13], w0
               	ldrb	w0, [x20, #0x4e]
               	mov	v0.b[14], w0
               	ldrb	w0, [x20, #0x4f]
               	mov	v0.b[15], w0
               	stur	q0, [x29, #-0x70]
               	sub	x0, x29, #0x100
               	ldur	q1, [x29, #-0xb0]
               	ldur	q2, [x29, #-0xa0]
               	ldur	q3, [x29, #-0x90]
               	ldur	q4, [x29, #-0x80]
               	stur	q1, [x29, #-0x100]
               	stur	q2, [x29, #-0xf0]
               	stur	q3, [x29, #-0xe0]
               	stur	q4, [x29, #-0xd0]
               	stur	q0, [x29, #-0xc0]
               	sub	x1, x29, #0x150
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
               	mov	x22, #0x0               // =0
               	cmp	w22, w24
               	b.ge	<addr>
               	sub	x0, x29, #0x150
               	lsl	x1, x22, #4
               	sxtw	x1, w1
               	add	x3, x23, x1
               	ld1	{ v0.b }[0], [x3]
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
               	str	q16, [sp, #0x170]
               	sub	x21, x29, #0xb0
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
               	add	x7, x21, #0x40
               	ldr	q0, [x7]
               	bl	<addr>
               	ldr	q16, [sp, #0x170]
               	eor	v16.16b, v16.16b, v0.16b
               	str	q16, [sp, #0x170]
               	add	x7, x21, #0x30
               	ldr	q0, [x7]
               	bl	<addr>
               	ldur	q1, [x29, #-0x70]
               	eor	v0.16b, v1.16b, v0.16b
               	stur	q0, [x29, #-0x70]
               	add	x7, x21, #0x20
               	ldr	q0, [x7]
               	bl	<addr>
               	ldur	q1, [x29, #-0x80]
               	eor	v0.16b, v1.16b, v0.16b
               	stur	q0, [x29, #-0x80]
               	add	x7, x21, #0x10
               	ldr	q0, [x7]
               	bl	<addr>
               	ldur	q1, [x29, #-0x90]
               	eor	v0.16b, v1.16b, v0.16b
               	stur	q0, [x29, #-0x90]
               	ldr	q0, [x21]
               	bl	<addr>
               	ldur	q1, [x29, #-0xa0]
               	eor	v0.16b, v1.16b, v0.16b
               	stur	q0, [x29, #-0xa0]
               	ldur	q1, [x29, #-0xb0]
               	ldr	q17, [sp, #0x170]
               	eor	v1.16b, v1.16b, v17.16b
               	stur	q1, [x29, #-0xb0]
               	ldur	q2, [x29, #-0x90]
               	ldur	q3, [x29, #-0x80]
               	ldur	q4, [x29, #-0x70]
               	str	q1, [sp, #0x30]
               	str	q0, [sp, #0x40]
               	str	q2, [sp, #0x50]
               	str	q3, [sp, #0x60]
               	str	q4, [sp, #0x70]
               	add	x22, x22, #0x1
               	cmp	w22, w24
               	b.lt	<addr>
               	sub	x1, x29, #0x150
               	sub	x0, x29, #0x60
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
               	mov	x1, x20
               	bl	<addr>
               	ldp	x29, x30, [sp, #0x180]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x190
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
               	sub	x3, x29, #0x1c8
               	lsl	x1, x0, #4
               	sub	x2, x29, #0x218
               	ldrb	w4, [x2, x1]
               	strb	w4, [x3, x1]
               	add	x3, x3, x1
               	add	x4, x1, #0x1
               	ldrb	w4, [x2, x4]
               	strb	w4, [x3, #0x1]
               	add	x4, x1, #0x2
               	ldrb	w4, [x2, x4]
               	strb	w4, [x3, #0x2]
               	add	x4, x1, #0x3
               	ldrb	w4, [x2, x4]
               	strb	w4, [x3, #0x3]
               	add	x4, x1, #0x4
               	ldrb	w2, [x2, x4]
               	strb	w2, [x3, #0x4]
               	sub	x3, x29, #0x1c8
               	add	x4, x3, x1
               	sub	x2, x29, #0x218
               	lsl	x1, x0, #4
               	add	x5, x1, #0x5
               	ldrb	w5, [x2, x5]
               	strb	w5, [x4, #0x5]
               	add	x3, x3, x1
               	add	x4, x1, #0x6
               	ldrb	w4, [x2, x4]
               	strb	w4, [x3, #0x6]
               	add	x4, x1, #0x7
               	ldrb	w4, [x2, x4]
               	strb	w4, [x3, #0x7]
               	add	x4, x1, #0x8
               	ldrb	w4, [x2, x4]
               	strb	w4, [x3, #0x8]
               	add	x1, x1, #0x9
               	ldrb	w1, [x2, x1]
               	strb	w1, [x3, #0x9]
               	sub	x2, x29, #0x218
               	lsl	x1, x0, #4
               	add	x4, x1, #0xa
               	ldrb	w4, [x2, x4]
               	strb	w4, [x3, #0xa]
               	sub	x3, x29, #0x1c8
               	add	x3, x3, x1
               	add	x4, x1, #0xb
               	ldrb	w4, [x2, x4]
               	strb	w4, [x3, #0xb]
               	add	x4, x1, #0xc
               	ldrb	w4, [x2, x4]
               	strb	w4, [x3, #0xc]
               	add	x4, x1, #0xd
               	ldrb	w4, [x2, x4]
               	strb	w4, [x3, #0xd]
               	add	x1, x1, #0xe
               	ldrb	w1, [x2, x1]
               	strb	w1, [x3, #0xe]
               	sub	x1, x29, #0x218
               	lsl	x2, x0, #4
               	add	x2, x2, #0xf
               	ldrb	w1, [x1, x2]
               	strb	w1, [x3, #0xf]
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
               	ldrb	w0, [sp, #0x128]
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
               	ldrb	w0, [sp, #0x138]
               	mov	v1.b[0], w0
               	ldrb	w0, [sp, #0x139]
               	mov	v1.b[1], w0
               	ldrb	w0, [sp, #0x13a]
               	mov	v1.b[2], w0
               	ldrb	w0, [sp, #0x13b]
               	mov	v1.b[3], w0
               	ldrb	w0, [sp, #0x13c]
               	mov	v1.b[4], w0
               	ldrb	w0, [sp, #0x13d]
               	mov	v1.b[5], w0
               	ldrb	w0, [sp, #0x13e]
               	mov	v1.b[6], w0
               	ldrb	w0, [sp, #0x13f]
               	mov	v1.b[7], w0
               	ldrb	w0, [sp, #0x140]
               	mov	v1.b[8], w0
               	ldrb	w0, [sp, #0x141]
               	mov	v1.b[9], w0
               	ldrb	w0, [sp, #0x142]
               	mov	v1.b[10], w0
               	ldrb	w0, [sp, #0x143]
               	mov	v1.b[11], w0
               	ldrb	w0, [sp, #0x144]
               	mov	v1.b[12], w0
               	ldrb	w0, [sp, #0x145]
               	mov	v1.b[13], w0
               	ldrb	w0, [sp, #0x146]
               	mov	v1.b[14], w0
               	ldrb	w0, [sp, #0x147]
               	mov	v1.b[15], w0
               	ldrb	w0, [sp, #0x148]
               	mov	v2.b[0], w0
               	ldrb	w0, [sp, #0x149]
               	mov	v2.b[1], w0
               	ldrb	w0, [sp, #0x14a]
               	mov	v2.b[2], w0
               	ldrb	w0, [sp, #0x14b]
               	mov	v2.b[3], w0
               	ldrb	w0, [sp, #0x14c]
               	mov	v2.b[4], w0
               	ldrb	w0, [sp, #0x14d]
               	mov	v2.b[5], w0
               	ldrb	w0, [sp, #0x14e]
               	mov	v2.b[6], w0
               	ldrb	w0, [sp, #0x14f]
               	mov	v2.b[7], w0
               	ldrb	w0, [sp, #0x150]
               	mov	v2.b[8], w0
               	ldrb	w0, [sp, #0x151]
               	mov	v2.b[9], w0
               	ldrb	w0, [sp, #0x152]
               	mov	v2.b[10], w0
               	ldrb	w0, [sp, #0x153]
               	mov	v2.b[11], w0
               	ldrb	w0, [sp, #0x154]
               	mov	v2.b[12], w0
               	ldrb	w0, [sp, #0x155]
               	mov	v2.b[13], w0
               	ldrb	w0, [sp, #0x156]
               	mov	v2.b[14], w0
               	ldrb	w0, [sp, #0x157]
               	mov	v2.b[15], w0
               	ldrb	w0, [sp, #0x158]
               	mov	v3.b[0], w0
               	ldrb	w0, [sp, #0x159]
               	mov	v3.b[1], w0
               	ldrb	w0, [sp, #0x15a]
               	mov	v3.b[2], w0
               	ldrb	w0, [sp, #0x15b]
               	mov	v3.b[3], w0
               	ldrb	w0, [sp, #0x15c]
               	mov	v3.b[4], w0
               	ldrb	w0, [sp, #0x15d]
               	mov	v3.b[5], w0
               	ldrb	w0, [sp, #0x15e]
               	mov	v3.b[6], w0
               	ldrb	w0, [sp, #0x15f]
               	mov	v3.b[7], w0
               	ldrb	w0, [sp, #0x160]
               	mov	v3.b[8], w0
               	ldrb	w0, [sp, #0x161]
               	mov	v3.b[9], w0
               	ldrb	w0, [sp, #0x162]
               	mov	v3.b[10], w0
               	ldrb	w0, [sp, #0x163]
               	mov	v3.b[11], w0
               	ldrb	w0, [sp, #0x164]
               	mov	v3.b[12], w0
               	ldrb	w0, [sp, #0x165]
               	mov	v3.b[13], w0
               	ldrb	w0, [sp, #0x166]
               	mov	v3.b[14], w0
               	ldrb	w0, [sp, #0x167]
               	mov	v3.b[15], w0
               	ldrb	w0, [sp, #0x168]
               	mov	v4.b[0], w0
               	ldrb	w0, [sp, #0x169]
               	mov	v4.b[1], w0
               	ldrb	w0, [sp, #0x16a]
               	mov	v4.b[2], w0
               	ldrb	w0, [sp, #0x16b]
               	mov	v4.b[3], w0
               	ldrb	w0, [sp, #0x16c]
               	mov	v4.b[4], w0
               	ldrb	w0, [sp, #0x16d]
               	mov	v4.b[5], w0
               	ldrb	w0, [sp, #0x16e]
               	mov	v4.b[6], w0
               	ldrb	w0, [sp, #0x16f]
               	mov	v4.b[7], w0
               	ldrb	w0, [sp, #0x170]
               	mov	v4.b[8], w0
               	ldrb	w0, [sp, #0x171]
               	mov	v4.b[9], w0
               	ldrb	w0, [sp, #0x172]
               	mov	v4.b[10], w0
               	ldrb	w0, [sp, #0x173]
               	mov	v4.b[11], w0
               	ldrb	w0, [sp, #0x174]
               	mov	v4.b[12], w0
               	ldrb	w0, [sp, #0x175]
               	mov	v4.b[13], w0
               	ldrb	w0, [sp, #0x176]
               	mov	v4.b[14], w0
               	ldrb	w0, [sp, #0x177]
               	mov	v4.b[15], w0
               	sub	x1, x29, #0x320
               	str	q0, [sp, #0x20]
               	str	q1, [sp, #0x30]
               	str	q2, [sp, #0x40]
               	str	q3, [sp, #0x50]
               	str	q4, [sp, #0x60]
               	ldurb	w0, [x29, #-0xd8]
               	mov	v0.b[0], w0
               	ldurb	w0, [x29, #-0xd7]
               	mov	v0.b[1], w0
               	ldurb	w0, [x29, #-0xd6]
               	mov	v0.b[2], w0
               	ldurb	w0, [x29, #-0xd5]
               	mov	v0.b[3], w0
               	ldurb	w0, [x29, #-0xd4]
               	mov	v0.b[4], w0
               	ldurb	w0, [x29, #-0xd3]
               	mov	v0.b[5], w0
               	ldurb	w0, [x29, #-0xd2]
               	mov	v0.b[6], w0
               	ldurb	w0, [x29, #-0xd1]
               	mov	v0.b[7], w0
               	ldurb	w0, [x29, #-0xd0]
               	mov	v0.b[8], w0
               	ldurb	w0, [x29, #-0xcf]
               	mov	v0.b[9], w0
               	ldurb	w0, [x29, #-0xce]
               	mov	v0.b[10], w0
               	ldurb	w0, [x29, #-0xcd]
               	mov	v0.b[11], w0
               	ldurb	w0, [x29, #-0xcc]
               	mov	v0.b[12], w0
               	ldurb	w0, [x29, #-0xcb]
               	mov	v0.b[13], w0
               	ldurb	w0, [x29, #-0xca]
               	mov	v0.b[14], w0
               	ldurb	w0, [x29, #-0xc9]
               	mov	v16.16b, v0.16b
               	mov	v16.b[15], w0
               	str	q16, [sp, #0x110]
               	sub	x0, x29, #0x2d0
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
               	sub	x3, x29, #0x50
               	lsl	x1, x0, #4
               	sub	x2, x29, #0x218
               	ldrb	w4, [x2, x1]
               	strb	w4, [x3, x1]
               	add	x3, x3, x1
               	add	x4, x1, #0x1
               	ldrb	w4, [x2, x4]
               	strb	w4, [x3, #0x1]
               	add	x4, x1, #0x2
               	ldrb	w4, [x2, x4]
               	strb	w4, [x3, #0x2]
               	add	x4, x1, #0x3
               	ldrb	w4, [x2, x4]
               	strb	w4, [x3, #0x3]
               	add	x4, x1, #0x4
               	ldrb	w2, [x2, x4]
               	strb	w2, [x3, #0x4]
               	sub	x3, x29, #0x50
               	add	x4, x3, x1
               	sub	x2, x29, #0x218
               	lsl	x1, x0, #4
               	add	x5, x1, #0x5
               	ldrb	w5, [x2, x5]
               	strb	w5, [x4, #0x5]
               	add	x3, x3, x1
               	add	x4, x1, #0x6
               	ldrb	w4, [x2, x4]
               	strb	w4, [x3, #0x6]
               	add	x4, x1, #0x7
               	ldrb	w4, [x2, x4]
               	strb	w4, [x3, #0x7]
               	add	x4, x1, #0x8
               	ldrb	w4, [x2, x4]
               	strb	w4, [x3, #0x8]
               	add	x1, x1, #0x9
               	ldrb	w1, [x2, x1]
               	strb	w1, [x3, #0x9]
               	sub	x2, x29, #0x218
               	lsl	x1, x0, #4
               	add	x4, x1, #0xa
               	ldrb	w4, [x2, x4]
               	strb	w4, [x3, #0xa]
               	sub	x3, x29, #0x50
               	add	x3, x3, x1
               	add	x4, x1, #0xb
               	ldrb	w4, [x2, x4]
               	strb	w4, [x3, #0xb]
               	add	x4, x1, #0xc
               	ldrb	w4, [x2, x4]
               	strb	w4, [x3, #0xc]
               	add	x4, x1, #0xd
               	ldrb	w4, [x2, x4]
               	strb	w4, [x3, #0xd]
               	add	x1, x1, #0xe
               	ldrb	w1, [x2, x1]
               	strb	w1, [x3, #0xe]
               	sub	x1, x29, #0x218
               	lsl	x2, x0, #4
               	add	x2, x2, #0xf
               	ldrb	w1, [x1, x2]
               	strb	w1, [x3, #0xf]
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
