
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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x1, x29, #0x10
               	ldrb	w2, [x0]
               	sturb	w2, [x29, #-0x10]
               	ldrb	w2, [x0, #0x1]
               	sturb	w2, [x29, #-0xf]
               	ldrb	w2, [x0, #0x2]
               	sturb	w2, [x29, #-0xe]
               	ldrb	w2, [x0, #0x3]
               	sturb	w2, [x29, #-0xd]
               	ldrb	w2, [x0, #0x4]
               	sturb	w2, [x29, #-0xc]
               	ldrb	w2, [x0, #0x5]
               	sturb	w2, [x29, #-0xb]
               	ldrb	w2, [x0, #0x6]
               	sturb	w2, [x29, #-0xa]
               	ldrb	w2, [x0, #0x7]
               	sturb	w2, [x29, #-0x9]
               	ldrb	w2, [x0, #0x8]
               	sturb	w2, [x29, #-0x8]
               	ldrb	w2, [x0, #0x9]
               	sturb	w2, [x29, #-0x7]
               	ldrb	w2, [x0, #0xa]
               	sturb	w2, [x29, #-0x6]
               	ldrb	w2, [x0, #0xb]
               	sturb	w2, [x29, #-0x5]
               	ldrb	w2, [x0, #0xc]
               	sturb	w2, [x29, #-0x4]
               	ldrb	w2, [x0, #0xd]
               	sturb	w2, [x29, #-0x3]
               	ldrb	w2, [x0, #0xe]
               	sturb	w2, [x29, #-0x2]
               	ldrb	w0, [x0, #0xf]
               	sturb	w0, [x29, #-0x1]
               	mov	x16, x1
               	ldr	q0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<store16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	q0, [x29, #-0x10]
               	ldurb	w1, [x29, #-0x10]
               	strb	w1, [x0]
               	ldurb	w1, [x29, #-0xf]
               	strb	w1, [x0, #0x1]
               	ldurb	w1, [x29, #-0xe]
               	strb	w1, [x0, #0x2]
               	ldurb	w1, [x29, #-0xd]
               	strb	w1, [x0, #0x3]
               	ldurb	w1, [x29, #-0xc]
               	strb	w1, [x0, #0x4]
               	ldurb	w1, [x29, #-0xb]
               	strb	w1, [x0, #0x5]
               	ldurb	w1, [x29, #-0xa]
               	strb	w1, [x0, #0x6]
               	ldurb	w1, [x29, #-0x9]
               	strb	w1, [x0, #0x7]
               	ldurb	w1, [x29, #-0x8]
               	strb	w1, [x0, #0x8]
               	ldurb	w1, [x29, #-0x7]
               	strb	w1, [x0, #0x9]
               	ldurb	w1, [x29, #-0x6]
               	strb	w1, [x0, #0xa]
               	ldurb	w1, [x29, #-0x5]
               	strb	w1, [x0, #0xb]
               	ldurb	w1, [x29, #-0x4]
               	strb	w1, [x0, #0xc]
               	ldurb	w1, [x29, #-0x3]
               	strb	w1, [x0, #0xd]
               	ldurb	w1, [x29, #-0x2]
               	strb	w1, [x0, #0xe]
               	ldurb	w1, [x29, #-0x1]
               	strb	w1, [x0, #0xf]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<mix>:
               	stp	x20, x21, [sp, #-0x80]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x70]
               	add	x29, sp, #0x70
               	stur	q0, [x29, #-0x50]
               	sub	x0, x29, #0x40
               	ldurb	w1, [x29, #-0x50]
               	lsl	x1, x1, #1
               	sturb	w1, [x29, #-0x40]
               	ldurb	w1, [x29, #-0x4f]
               	lsl	x1, x1, #1
               	sturb	w1, [x29, #-0x3f]
               	ldurb	w1, [x29, #-0x4e]
               	lsl	x1, x1, #1
               	sturb	w1, [x29, #-0x3e]
               	ldurb	w1, [x29, #-0x4d]
               	lsl	x1, x1, #1
               	sturb	w1, [x29, #-0x3d]
               	ldurb	w1, [x29, #-0x4c]
               	lsl	x1, x1, #1
               	sturb	w1, [x29, #-0x3c]
               	ldurb	w1, [x29, #-0x4b]
               	lsl	x1, x1, #1
               	sturb	w1, [x29, #-0x3b]
               	ldurb	w1, [x29, #-0x4a]
               	lsl	x1, x1, #1
               	sturb	w1, [x29, #-0x3a]
               	ldurb	w1, [x29, #-0x49]
               	lsl	x1, x1, #1
               	sturb	w1, [x29, #-0x39]
               	ldurb	w1, [x29, #-0x48]
               	lsl	x2, x1, #1
               	add	x1, x0, #0x8
               	strb	w2, [x1]
               	ldurb	w0, [x29, #-0x47]
               	lsl	x0, x0, #1
               	sturb	w0, [x29, #-0x37]
               	ldurb	w0, [x29, #-0x46]
               	lsl	x0, x0, #1
               	sturb	w0, [x29, #-0x36]
               	ldurb	w0, [x29, #-0x45]
               	lsl	x0, x0, #1
               	sturb	w0, [x29, #-0x35]
               	ldurb	w0, [x29, #-0x44]
               	lsl	x0, x0, #1
               	sturb	w0, [x29, #-0x34]
               	ldurb	w0, [x29, #-0x43]
               	lsl	x0, x0, #1
               	sturb	w0, [x29, #-0x33]
               	ldurb	w0, [x29, #-0x42]
               	lsl	x0, x0, #1
               	sturb	w0, [x29, #-0x32]
               	ldurb	w0, [x29, #-0x41]
               	lsl	x0, x0, #1
               	sturb	w0, [x29, #-0x31]
               	ldurb	w0, [x29, #-0x50]
               	lsr	x2, x0, #7
               	ldurb	w0, [x29, #-0x4f]
               	lsr	x3, x0, #7
               	ldurb	w0, [x29, #-0x4e]
               	lsr	x4, x0, #7
               	ldurb	w0, [x29, #-0x4d]
               	lsr	x5, x0, #7
               	ldurb	w0, [x29, #-0x4c]
               	lsr	x6, x0, #7
               	ldurb	w0, [x29, #-0x4b]
               	lsr	x7, x0, #7
               	ldurb	w0, [x29, #-0x4a]
               	lsr	x8, x0, #7
               	ldurb	w0, [x29, #-0x49]
               	lsr	x9, x0, #7
               	ldurb	w0, [x29, #-0x48]
               	lsr	x10, x0, #7
               	ldurb	w0, [x29, #-0x47]
               	lsr	x11, x0, #7
               	ldurb	w0, [x29, #-0x46]
               	lsr	x12, x0, #7
               	ldurb	w0, [x29, #-0x45]
               	lsr	x13, x0, #7
               	ldurb	w0, [x29, #-0x44]
               	lsr	x14, x0, #7
               	ldurb	w0, [x29, #-0x43]
               	lsr	x15, x0, #7
               	ldurb	w0, [x29, #-0x42]
               	lsr	x20, x0, #7
               	ldurb	w0, [x29, #-0x41]
               	lsr	x21, x0, #7
               	mov	x0, #0x1b               // =27
               	sub	x22, x29, #0x30
               	mul	x2, x2, x0
               	sturb	w2, [x29, #-0x30]
               	mul	x2, x3, x0
               	sturb	w2, [x29, #-0x2f]
               	mul	x2, x4, x0
               	sturb	w2, [x29, #-0x2e]
               	mul	x2, x5, x0
               	sturb	w2, [x29, #-0x2d]
               	mul	x2, x6, x0
               	sturb	w2, [x29, #-0x2c]
               	mul	x2, x7, x0
               	sturb	w2, [x29, #-0x2b]
               	mul	x2, x8, x0
               	sturb	w2, [x29, #-0x2a]
               	mul	x2, x9, x0
               	sturb	w2, [x29, #-0x29]
               	mul	x3, x10, x0
               	add	x2, x22, #0x8
               	strb	w3, [x2]
               	mul	x3, x11, x0
               	sturb	w3, [x29, #-0x27]
               	mul	x3, x12, x0
               	sturb	w3, [x29, #-0x26]
               	mul	x3, x13, x0
               	sturb	w3, [x29, #-0x25]
               	mul	x3, x14, x0
               	sturb	w3, [x29, #-0x24]
               	mul	x3, x15, x0
               	sturb	w3, [x29, #-0x23]
               	mul	x3, x20, x0
               	sturb	w3, [x29, #-0x22]
               	mul	x0, x21, x0
               	sturb	w0, [x29, #-0x21]
               	sub	x0, x29, #0x20
               	ldur	x3, [x29, #-0x40]
               	ldur	x4, [x29, #-0x30]
               	eor	x3, x3, x4
               	stur	x3, [x29, #-0x20]
               	add	x3, x0, #0x8
               	ldr	x0, [x1]
               	ldr	x1, [x2]
               	eor	x0, x0, x1
               	str	x0, [x3]
               	mov	x1, #0x63               // =99
               	sub	x0, x29, #0x10
               	ldurb	w2, [x29, #-0x20]
               	eor	x2, x2, x1
               	sturb	w2, [x29, #-0x10]
               	ldurb	w2, [x29, #-0x1f]
               	eor	x2, x2, x1
               	sturb	w2, [x29, #-0xf]
               	ldurb	w2, [x29, #-0x1e]
               	eor	x2, x2, x1
               	sturb	w2, [x29, #-0xe]
               	ldurb	w2, [x29, #-0x1d]
               	eor	x2, x2, x1
               	sturb	w2, [x29, #-0xd]
               	ldurb	w2, [x29, #-0x1c]
               	eor	x2, x2, x1
               	sturb	w2, [x29, #-0xc]
               	ldurb	w2, [x29, #-0x1b]
               	eor	x2, x2, x1
               	sturb	w2, [x29, #-0xb]
               	ldurb	w2, [x29, #-0x1a]
               	eor	x2, x2, x1
               	sturb	w2, [x29, #-0xa]
               	ldurb	w2, [x29, #-0x19]
               	eor	x2, x2, x1
               	sturb	w2, [x29, #-0x9]
               	ldrb	w2, [x3]
               	eor	x2, x2, x1
               	sturb	w2, [x29, #-0x8]
               	ldurb	w2, [x29, #-0x17]
               	eor	x2, x2, x1
               	sturb	w2, [x29, #-0x7]
               	ldurb	w2, [x29, #-0x16]
               	eor	x2, x2, x1
               	sturb	w2, [x29, #-0x6]
               	ldurb	w2, [x29, #-0x15]
               	eor	x2, x2, x1
               	sturb	w2, [x29, #-0x5]
               	ldurb	w2, [x29, #-0x14]
               	eor	x2, x2, x1
               	sturb	w2, [x29, #-0x4]
               	ldurb	w2, [x29, #-0x13]
               	eor	x2, x2, x1
               	sturb	w2, [x29, #-0x3]
               	ldurb	w2, [x29, #-0x12]
               	eor	x2, x2, x1
               	sturb	w2, [x29, #-0x2]
               	ldurb	w2, [x29, #-0x11]
               	eor	x1, x2, x1
               	sturb	w1, [x29, #-0x1]
               	mov	x16, x0
               	ldr	q0, [x16]
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x80
               	ret

<update>:
               	stp	x20, x21, [sp, #-0xc0]!
               	stp	x29, x30, [sp, #0xb0]
               	add	x29, sp, #0xb0
               	stur	x8, [x29, #-0x8]
               	stur	x0, [x29, #-0x30]
               	stur	q0, [x29, #-0x50]
               	sub	x0, x29, #0xa0
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
               	stur	q0, [x29, #-0x40]
               	ldur	x0, [x29, #-0x50]
               	ldur	x1, [x29, #-0x40]
               	eor	x20, x0, x1
               	ldur	x0, [x29, #-0x48]
               	ldur	x1, [x29, #-0x38]
               	eor	x21, x0, x1
               	stur	x20, [x29, #-0x50]
               	stur	x21, [x29, #-0x48]
               	sub	x0, x29, #0xa0
               	add	x7, x0, #0x30
               	ldr	q0, [x7]
               	bl	<addr>
               	stur	q0, [x29, #-0x40]
               	ldur	x0, [x29, #-0x60]
               	ldur	x1, [x29, #-0x40]
               	eor	x1, x0, x1
               	ldur	x0, [x29, #-0x58]
               	ldur	x2, [x29, #-0x38]
               	eor	x2, x0, x2
               	sub	x0, x29, #0xa0
               	add	x0, x0, #0x40
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	sub	x0, x29, #0xa0
               	add	x7, x0, #0x20
               	ldr	q0, [x7]
               	bl	<addr>
               	stur	q0, [x29, #-0x40]
               	ldur	x0, [x29, #-0x70]
               	ldur	x1, [x29, #-0x40]
               	eor	x1, x0, x1
               	ldur	x0, [x29, #-0x68]
               	ldur	x2, [x29, #-0x38]
               	eor	x2, x0, x2
               	sub	x0, x29, #0xa0
               	add	x0, x0, #0x30
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	sub	x0, x29, #0xa0
               	add	x7, x0, #0x10
               	ldr	q0, [x7]
               	bl	<addr>
               	stur	q0, [x29, #-0x40]
               	ldur	x0, [x29, #-0x80]
               	ldur	x1, [x29, #-0x40]
               	eor	x1, x0, x1
               	ldur	x0, [x29, #-0x78]
               	ldur	x2, [x29, #-0x38]
               	eor	x2, x0, x2
               	sub	x0, x29, #0xa0
               	add	x0, x0, #0x20
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	sub	x7, x29, #0xa0
               	ldr	q0, [x7]
               	bl	<addr>
               	stur	q0, [x29, #-0x40]
               	ldur	x0, [x29, #-0x90]
               	ldur	x1, [x29, #-0x40]
               	eor	x1, x0, x1
               	ldur	x0, [x29, #-0x88]
               	ldur	x2, [x29, #-0x38]
               	eor	x2, x0, x2
               	sub	x0, x29, #0xa0
               	add	x0, x0, #0x10
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	sub	x0, x29, #0xa0
               	ldur	x1, [x29, #-0xa0]
               	eor	x1, x1, x20
               	ldur	x2, [x29, #-0x98]
               	eor	x2, x2, x21
               	stur	x1, [x29, #-0xa0]
               	stur	x2, [x29, #-0x98]
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
               	ldp	x29, x30, [sp, #0xb0]
               	ldp	x20, x21, [sp], #0xc0
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
               	lsl	x5, x3, #1
               	lsr	x3, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x3, x3, x17
               	eor	x3, x5, x3
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	and	x3, x3, #0xff
               	eor	x7, x4, x3
               	ldrb	w4, [x1, #0x1]
               	ldrb	w3, [x2, #0x1]
               	lsl	x5, x3, #1
               	lsr	x3, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x3, x3, x17
               	eor	x3, x5, x3
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	and	x3, x3, #0xff
               	eor	x8, x4, x3
               	ldrb	w4, [x1, #0x2]
               	ldrb	w3, [x2, #0x2]
               	lsl	x5, x3, #1
               	lsr	x3, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x3, x3, x17
               	eor	x3, x5, x3
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	and	x3, x3, #0xff
               	eor	x9, x4, x3
               	ldrb	w4, [x1, #0x3]
               	ldrb	w3, [x2, #0x3]
               	lsl	x5, x3, #1
               	lsr	x3, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x3, x3, x17
               	eor	x3, x5, x3
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	and	x3, x3, #0xff
               	eor	x10, x4, x3
               	ldrb	w4, [x1, #0x4]
               	ldrb	w3, [x2, #0x4]
               	lsl	x5, x3, #1
               	lsr	x3, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x3, x3, x17
               	eor	x3, x5, x3
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	and	x3, x3, #0xff
               	eor	x11, x4, x3
               	ldrb	w4, [x1, #0x5]
               	ldrb	w3, [x2, #0x5]
               	lsl	x5, x3, #1
               	lsr	x3, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x3, x3, x17
               	eor	x3, x5, x3
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	and	x3, x3, #0xff
               	eor	x12, x4, x3
               	ldrb	w4, [x1, #0x6]
               	ldrb	w3, [x2, #0x6]
               	lsl	x5, x3, #1
               	lsr	x3, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x3, x3, x17
               	eor	x3, x5, x3
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	and	x3, x3, #0xff
               	eor	x13, x4, x3
               	ldrb	w4, [x1, #0x7]
               	ldrb	w3, [x2, #0x7]
               	lsl	x5, x3, #1
               	lsr	x3, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x3, x3, x17
               	eor	x3, x5, x3
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	and	x3, x3, #0xff
               	eor	x14, x4, x3
               	ldrb	w3, [x1, #0x8]
               	ldrb	w2, [x2, #0x8]
               	lsl	x4, x2, #1
               	lsr	x2, x2, #7
               	mov	x17, #0x1b              // =27
               	mul	x2, x2, x17
               	eor	x2, x4, x2
               	mov	x17, #0x63              // =99
               	eor	x2, x2, x17
               	and	x2, x2, #0xff
               	eor	x15, x3, x2
               	ldrb	w4, [x1, #0x9]
               	add	x2, x0, #0x40
               	ldrb	w3, [x2, #0x9]
               	lsl	x5, x3, #1
               	lsr	x3, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x3, x3, x17
               	eor	x3, x5, x3
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	and	x3, x3, #0xff
               	eor	x20, x4, x3
               	ldrb	w4, [x1, #0xa]
               	ldrb	w3, [x2, #0xa]
               	lsl	x5, x3, #1
               	lsr	x3, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x3, x3, x17
               	eor	x3, x5, x3
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	and	x3, x3, #0xff
               	eor	x21, x4, x3
               	ldrb	w4, [x1, #0xb]
               	ldrb	w3, [x2, #0xb]
               	lsl	x5, x3, #1
               	lsr	x3, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x3, x3, x17
               	eor	x3, x5, x3
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	and	x3, x3, #0xff
               	eor	x22, x4, x3
               	ldrb	w4, [x1, #0xc]
               	ldrb	w3, [x2, #0xc]
               	lsl	x5, x3, #1
               	lsr	x3, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x3, x3, x17
               	eor	x3, x5, x3
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	and	x3, x3, #0xff
               	eor	x23, x4, x3
               	ldrb	w4, [x1, #0xd]
               	ldrb	w3, [x2, #0xd]
               	lsl	x5, x3, #1
               	lsr	x3, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x3, x3, x17
               	eor	x3, x5, x3
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	and	x3, x3, #0xff
               	eor	x24, x4, x3
               	ldrb	w4, [x1, #0xe]
               	ldrb	w3, [x2, #0xe]
               	lsl	x5, x3, #1
               	lsr	x3, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x3, x3, x17
               	eor	x3, x5, x3
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	and	x3, x3, #0xff
               	eor	x25, x4, x3
               	ldrb	w3, [x1, #0xf]
               	ldrb	w1, [x2, #0xf]
               	lsl	x2, x1, #1
               	lsr	x1, x1, #7
               	mov	x17, #0x1b              // =27
               	mul	x1, x1, x17
               	eor	x1, x2, x1
               	mov	x17, #0x63              // =99
               	eor	x1, x1, x17
               	and	x1, x1, #0xff
               	eor	x26, x3, x1
               	mov	x1, #0x4                // =4
               	lsl	x2, x1, #4
               	add	x3, x0, x2
               	ldrb	w5, [x3]
               	sub	x4, x1, #0x1
               	lsl	x4, x4, #4
               	add	x4, x0, x4
               	ldrb	w4, [x4]
               	lsl	x6, x4, #1
               	lsr	x4, x4, #7
               	mov	x17, #0x1b              // =27
               	mul	x4, x4, x17
               	eor	x4, x6, x4
               	mov	x17, #0x63              // =99
               	eor	x4, x4, x17
               	and	x4, x4, #0xff
               	eor	x4, x5, x4
               	strb	w4, [x3]
               	add	x2, x0, x2
               	ldrb	w5, [x2, #0x1]
               	sub	x3, x1, #0x1
               	lsl	x4, x3, #4
               	add	x4, x0, x4
               	ldrb	w4, [x4, #0x1]
               	lsl	x6, x4, #1
               	lsr	x4, x4, #7
               	mov	x17, #0x1b              // =27
               	mul	x4, x4, x17
               	eor	x4, x6, x4
               	mov	x17, #0x63              // =99
               	eor	x4, x4, x17
               	and	x4, x4, #0xff
               	eor	x4, x5, x4
               	strb	w4, [x2, #0x1]
               	lsl	x2, x1, #4
               	add	x4, x0, x2
               	ldrb	w5, [x4, #0x2]
               	lsl	x3, x3, #4
               	add	x3, x0, x3
               	ldrb	w3, [x3, #0x2]
               	lsl	x6, x3, #1
               	lsr	x3, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x3, x3, x17
               	eor	x3, x6, x3
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	and	x3, x3, #0xff
               	eor	x3, x5, x3
               	strb	w3, [x4, #0x2]
               	add	x2, x0, x2
               	ldrb	w5, [x2, #0x3]
               	sub	x3, x1, #0x1
               	lsl	x4, x3, #4
               	add	x4, x0, x4
               	ldrb	w4, [x4, #0x3]
               	lsl	x6, x4, #1
               	lsr	x4, x4, #7
               	mov	x17, #0x1b              // =27
               	mul	x4, x4, x17
               	eor	x4, x6, x4
               	mov	x17, #0x63              // =99
               	eor	x4, x4, x17
               	and	x4, x4, #0xff
               	eor	x4, x5, x4
               	strb	w4, [x2, #0x3]
               	lsl	x2, x1, #4
               	add	x4, x0, x2
               	ldrb	w5, [x4, #0x4]
               	lsl	x3, x3, #4
               	add	x3, x0, x3
               	ldrb	w3, [x3, #0x4]
               	lsl	x6, x3, #1
               	lsr	x3, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x3, x3, x17
               	eor	x3, x6, x3
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	and	x3, x3, #0xff
               	eor	x3, x5, x3
               	strb	w3, [x4, #0x4]
               	add	x2, x0, x2
               	ldrb	w5, [x2, #0x5]
               	sub	x3, x1, #0x1
               	lsl	x4, x3, #4
               	add	x4, x0, x4
               	ldrb	w4, [x4, #0x5]
               	lsl	x6, x4, #1
               	lsr	x4, x4, #7
               	mov	x17, #0x1b              // =27
               	mul	x4, x4, x17
               	eor	x4, x6, x4
               	mov	x17, #0x63              // =99
               	eor	x4, x4, x17
               	and	x4, x4, #0xff
               	eor	x4, x5, x4
               	strb	w4, [x2, #0x5]
               	lsl	x2, x1, #4
               	add	x4, x0, x2
               	ldrb	w5, [x4, #0x6]
               	lsl	x3, x3, #4
               	add	x3, x0, x3
               	ldrb	w3, [x3, #0x6]
               	lsl	x6, x3, #1
               	lsr	x3, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x3, x3, x17
               	eor	x3, x6, x3
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	and	x3, x3, #0xff
               	eor	x3, x5, x3
               	strb	w3, [x4, #0x6]
               	add	x2, x0, x2
               	ldrb	w5, [x2, #0x7]
               	sub	x3, x1, #0x1
               	lsl	x4, x3, #4
               	add	x4, x0, x4
               	ldrb	w4, [x4, #0x7]
               	lsl	x6, x4, #1
               	lsr	x4, x4, #7
               	mov	x17, #0x1b              // =27
               	mul	x4, x4, x17
               	eor	x4, x6, x4
               	mov	x17, #0x63              // =99
               	eor	x4, x4, x17
               	and	x4, x4, #0xff
               	eor	x4, x5, x4
               	strb	w4, [x2, #0x7]
               	lsl	x2, x1, #4
               	add	x4, x0, x2
               	ldrb	w5, [x4, #0x8]
               	lsl	x3, x3, #4
               	add	x3, x0, x3
               	ldrb	w3, [x3, #0x8]
               	lsl	x6, x3, #1
               	lsr	x3, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x3, x3, x17
               	eor	x3, x6, x3
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	and	x3, x3, #0xff
               	eor	x3, x5, x3
               	strb	w3, [x4, #0x8]
               	add	x2, x0, x2
               	ldrb	w5, [x2, #0x9]
               	sub	x3, x1, #0x1
               	lsl	x4, x3, #4
               	add	x4, x0, x4
               	ldrb	w4, [x4, #0x9]
               	lsl	x6, x4, #1
               	lsr	x4, x4, #7
               	mov	x17, #0x1b              // =27
               	mul	x4, x4, x17
               	eor	x4, x6, x4
               	mov	x17, #0x63              // =99
               	eor	x4, x4, x17
               	and	x4, x4, #0xff
               	eor	x4, x5, x4
               	strb	w4, [x2, #0x9]
               	lsl	x2, x1, #4
               	add	x4, x0, x2
               	ldrb	w5, [x4, #0xa]
               	lsl	x3, x3, #4
               	add	x3, x0, x3
               	ldrb	w3, [x3, #0xa]
               	lsl	x6, x3, #1
               	lsr	x3, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x3, x3, x17
               	eor	x3, x6, x3
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	and	x3, x3, #0xff
               	eor	x3, x5, x3
               	strb	w3, [x4, #0xa]
               	add	x2, x0, x2
               	ldrb	w5, [x2, #0xb]
               	sub	x3, x1, #0x1
               	lsl	x4, x3, #4
               	add	x4, x0, x4
               	ldrb	w4, [x4, #0xb]
               	lsl	x6, x4, #1
               	lsr	x4, x4, #7
               	mov	x17, #0x1b              // =27
               	mul	x4, x4, x17
               	eor	x4, x6, x4
               	mov	x17, #0x63              // =99
               	eor	x4, x4, x17
               	and	x4, x4, #0xff
               	eor	x4, x5, x4
               	strb	w4, [x2, #0xb]
               	lsl	x2, x1, #4
               	add	x4, x0, x2
               	ldrb	w5, [x4, #0xc]
               	lsl	x3, x3, #4
               	add	x3, x0, x3
               	ldrb	w3, [x3, #0xc]
               	lsl	x6, x3, #1
               	lsr	x3, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x3, x3, x17
               	eor	x3, x6, x3
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	and	x3, x3, #0xff
               	eor	x3, x5, x3
               	strb	w3, [x4, #0xc]
               	add	x2, x0, x2
               	ldrb	w5, [x2, #0xd]
               	sub	x3, x1, #0x1
               	lsl	x4, x3, #4
               	add	x4, x0, x4
               	ldrb	w4, [x4, #0xd]
               	lsl	x6, x4, #1
               	lsr	x4, x4, #7
               	mov	x17, #0x1b              // =27
               	mul	x4, x4, x17
               	eor	x4, x6, x4
               	mov	x17, #0x63              // =99
               	eor	x4, x4, x17
               	and	x4, x4, #0xff
               	eor	x4, x5, x4
               	strb	w4, [x2, #0xd]
               	lsl	x2, x1, #4
               	add	x4, x0, x2
               	ldrb	w5, [x4, #0xe]
               	lsl	x3, x3, #4
               	add	x3, x0, x3
               	ldrb	w3, [x3, #0xe]
               	lsl	x6, x3, #1
               	lsr	x3, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x3, x3, x17
               	eor	x3, x6, x3
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	and	x3, x3, #0xff
               	eor	x3, x5, x3
               	strb	w3, [x4, #0xe]
               	add	x2, x0, x2
               	ldrb	w4, [x2, #0xf]
               	sub	x3, x1, #0x1
               	lsl	x3, x3, #4
               	add	x3, x0, x3
               	ldrb	w3, [x3, #0xf]
               	lsl	x5, x3, #1
               	lsr	x3, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x3, x3, x17
               	eor	x3, x5, x3
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
               	stur	q0, [x29, #-0xf0]
               	sub	x0, x29, #0xf0
               	sub	x1, x29, #0x50
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	add	x0, x22, #0x10
               	bl	<addr>
               	stur	q0, [x29, #-0xf0]
               	sub	x0, x29, #0xf0
               	sub	x1, x29, #0x50
               	add	x1, x1, #0x10
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	add	x0, x22, #0x20
               	bl	<addr>
               	stur	q0, [x29, #-0xf0]
               	sub	x0, x29, #0xf0
               	sub	x1, x29, #0x50
               	add	x1, x1, #0x20
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	add	x0, x22, #0x30
               	bl	<addr>
               	stur	q0, [x29, #-0xf0]
               	sub	x0, x29, #0xf0
               	sub	x1, x29, #0x50
               	add	x1, x1, #0x30
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	add	x0, x22, #0x40
               	bl	<addr>
               	stur	q0, [x29, #-0xf0]
               	sub	x0, x29, #0xf0
               	sub	x1, x29, #0x50
               	add	x1, x1, #0x40
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
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
               	lsl	x0, x22, #4
               	add	x1, x23, x0
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
               	str	q0, [sp, #0x70]
               	sub	x0, x29, #0x2c0
               	sub	x1, x29, #0x310
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x0, x29, #0x218
               	add	x0, x0, #0x10
               	bl	<addr>
               	str	q0, [sp, #0x70]
               	sub	x0, x29, #0x2c0
               	sub	x1, x29, #0x300
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x0, x29, #0x218
               	add	x0, x0, #0x20
               	bl	<addr>
               	str	q0, [sp, #0x70]
               	sub	x0, x29, #0x2c0
               	sub	x1, x29, #0x2f0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x0, x29, #0x218
               	add	x0, x0, #0x30
               	bl	<addr>
               	str	q0, [sp, #0x70]
               	sub	x0, x29, #0x2c0
               	sub	x1, x29, #0x2e0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x20, x29, #0x218
               	add	x0, x20, #0x40
               	bl	<addr>
               	str	q0, [sp, #0x70]
               	sub	x0, x29, #0x2c0
               	sub	x1, x29, #0x2d0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x0, x29, #0x2c0
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	stp	xzr, xzr, [x0, #0x30]
               	stp	xzr, xzr, [x0, #0x40]
               	sub	x2, x29, #0x310
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	sub	x2, x29, #0x300
               	add	x3, x0, #0x10
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x3]
               	sub	x2, x29, #0x2f0
               	add	x3, x0, #0x20
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x3]
               	sub	x2, x29, #0x2e0
               	add	x3, x0, #0x30
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x3]
               	add	x0, x0, #0x40
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0xd8
               	bl	<addr>
               	str	q0, [sp, #0x60]
               	sub	x7, x29, #0x2d0
               	sub	x0, x29, #0x270
               	sub	x1, x29, #0x2c0
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
               	sub	x8, x29, #0x2c0
               	bl	<addr>
               	sub	x0, x29, #0x128
               	ldr	x1, [sp, #0x70]
               	ldr	x2, [sp, #0x78]
               	ldr	x3, [sp, #0x80]
               	ldr	x4, [sp, #0x88]
               	ldr	x5, [sp, #0x90]
               	ldr	x6, [sp, #0x98]
               	ldr	x8, [sp, #0xa0]
               	ldr	x9, [sp, #0xa8]
               	ldr	x10, [sp, #0xb0]
               	ldr	x11, [sp, #0xb8]
               	sub	x7, x29, #0x2c0
               	str	x1, [sp, #0x70]
               	str	x2, [sp, #0x78]
               	str	x3, [sp, #0x80]
               	str	x4, [sp, #0x88]
               	str	x5, [sp, #0x90]
               	str	x6, [sp, #0x98]
               	str	x8, [sp, #0xa0]
               	str	x9, [sp, #0xa8]
               	str	x10, [sp, #0xb0]
               	str	x11, [sp, #0xb8]
               	ldr	q0, [x7]
               	bl	<addr>
               	sub	x0, x29, #0x128
               	add	x0, x0, #0x10
               	sub	x1, x29, #0x2c0
               	add	x7, x1, #0x10
               	ldr	q0, [x7]
               	bl	<addr>
               	sub	x0, x29, #0x128
               	add	x0, x0, #0x20
               	sub	x1, x29, #0x2c0
               	add	x7, x1, #0x20
               	ldr	q0, [x7]
               	bl	<addr>
               	sub	x0, x29, #0x128
               	add	x0, x0, #0x30
               	sub	x1, x29, #0x2c0
               	add	x7, x1, #0x30
               	ldr	q0, [x7]
               	bl	<addr>
               	sub	x0, x29, #0x128
               	add	x0, x0, #0x40
               	sub	x1, x29, #0x2c0
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
