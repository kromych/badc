
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
               	sub	sp, sp, #0x20
               	mov	x1, x0
               	sub	x0, x29, #0x20
               	ldrb	w2, [x1]
               	strb	w2, [x0]
               	ldrb	w2, [x1, #0x1]
               	strb	w2, [x0, #0x1]
               	ldrb	w2, [x1, #0x2]
               	strb	w2, [x0, #0x2]
               	ldrb	w2, [x1, #0x3]
               	strb	w2, [x0, #0x3]
               	ldrb	w2, [x1, #0x4]
               	strb	w2, [x0, #0x4]
               	ldrb	w2, [x1, #0x5]
               	strb	w2, [x0, #0x5]
               	ldrb	w2, [x1, #0x6]
               	strb	w2, [x0, #0x6]
               	ldrb	w2, [x1, #0x7]
               	strb	w2, [x0, #0x7]
               	ldrb	w2, [x1, #0x8]
               	strb	w2, [x0, #0x8]
               	ldrb	w2, [x1, #0x9]
               	strb	w2, [x0, #0x9]
               	ldrb	w2, [x1, #0xa]
               	strb	w2, [x0, #0xa]
               	ldrb	w2, [x1, #0xb]
               	strb	w2, [x0, #0xb]
               	ldrb	w2, [x1, #0xc]
               	strb	w2, [x0, #0xc]
               	ldrb	w2, [x1, #0xd]
               	strb	w2, [x0, #0xd]
               	ldrb	w2, [x1, #0xe]
               	strb	w2, [x0, #0xe]
               	ldrb	w1, [x1, #0xf]
               	strb	w1, [x0, #0xf]
               	mov	x16, x0
               	ldr	q0, [x16]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<store16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	stur	q0, [x29, #-0x20]
               	sub	x1, x29, #0x20
               	ldrb	w2, [x1]
               	strb	w2, [x0]
               	ldrb	w2, [x1, #0x1]
               	strb	w2, [x0, #0x1]
               	ldrb	w2, [x1, #0x2]
               	strb	w2, [x0, #0x2]
               	ldrb	w2, [x1, #0x3]
               	strb	w2, [x0, #0x3]
               	ldrb	w2, [x1, #0x4]
               	strb	w2, [x0, #0x4]
               	ldrb	w2, [x1, #0x5]
               	strb	w2, [x0, #0x5]
               	ldrb	w2, [x1, #0x6]
               	strb	w2, [x0, #0x6]
               	ldrb	w2, [x1, #0x7]
               	strb	w2, [x0, #0x7]
               	ldrb	w2, [x1, #0x8]
               	strb	w2, [x0, #0x8]
               	ldrb	w2, [x1, #0x9]
               	strb	w2, [x0, #0x9]
               	ldrb	w2, [x1, #0xa]
               	strb	w2, [x0, #0xa]
               	ldrb	w2, [x1, #0xb]
               	strb	w2, [x0, #0xb]
               	ldrb	w2, [x1, #0xc]
               	strb	w2, [x0, #0xc]
               	ldrb	w2, [x1, #0xd]
               	strb	w2, [x0, #0xd]
               	ldrb	w2, [x1, #0xe]
               	strb	w2, [x0, #0xe]
               	ldrb	w1, [x1, #0xf]
               	strb	w1, [x0, #0xf]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<mix>:
               	stp	x20, x21, [sp, #-0x90]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x80]
               	add	x29, sp, #0x80
               	stur	q0, [x29, #-0x60]
               	sub	x0, x29, #0x60
               	sub	x1, x29, #0x50
               	ldrb	w2, [x0]
               	lsl	x2, x2, #1
               	strb	w2, [x1]
               	ldrb	w2, [x0, #0x1]
               	lsl	x2, x2, #1
               	strb	w2, [x1, #0x1]
               	ldrb	w2, [x0, #0x2]
               	lsl	x2, x2, #1
               	strb	w2, [x1, #0x2]
               	ldrb	w2, [x0, #0x3]
               	lsl	x2, x2, #1
               	strb	w2, [x1, #0x3]
               	ldrb	w2, [x0, #0x4]
               	lsl	x2, x2, #1
               	strb	w2, [x1, #0x4]
               	ldrb	w2, [x0, #0x5]
               	lsl	x2, x2, #1
               	strb	w2, [x1, #0x5]
               	ldrb	w2, [x0, #0x6]
               	lsl	x2, x2, #1
               	strb	w2, [x1, #0x6]
               	ldrb	w2, [x0, #0x7]
               	lsl	x2, x2, #1
               	strb	w2, [x1, #0x7]
               	ldrb	w2, [x0, #0x8]
               	lsl	x2, x2, #1
               	add	x3, x1, #0x8
               	strb	w2, [x3]
               	ldrb	w2, [x0, #0x9]
               	lsl	x2, x2, #1
               	strb	w2, [x1, #0x9]
               	ldrb	w2, [x0, #0xa]
               	lsl	x2, x2, #1
               	strb	w2, [x1, #0xa]
               	ldrb	w2, [x0, #0xb]
               	lsl	x2, x2, #1
               	strb	w2, [x1, #0xb]
               	ldrb	w2, [x0, #0xc]
               	lsl	x2, x2, #1
               	strb	w2, [x1, #0xc]
               	ldrb	w2, [x0, #0xd]
               	lsl	x2, x2, #1
               	strb	w2, [x1, #0xd]
               	ldrb	w2, [x0, #0xe]
               	lsl	x2, x2, #1
               	strb	w2, [x1, #0xe]
               	ldrb	w2, [x0, #0xf]
               	lsl	x2, x2, #1
               	strb	w2, [x1, #0xf]
               	ldrb	w2, [x0]
               	lsr	x4, x2, #7
               	ldrb	w2, [x0, #0x1]
               	lsr	x5, x2, #7
               	ldrb	w2, [x0, #0x2]
               	lsr	x6, x2, #7
               	ldrb	w2, [x0, #0x3]
               	lsr	x7, x2, #7
               	ldrb	w2, [x0, #0x4]
               	lsr	x8, x2, #7
               	ldrb	w2, [x0, #0x5]
               	lsr	x9, x2, #7
               	ldrb	w2, [x0, #0x6]
               	lsr	x10, x2, #7
               	ldrb	w2, [x0, #0x7]
               	lsr	x11, x2, #7
               	ldrb	w2, [x0, #0x8]
               	lsr	x12, x2, #7
               	ldrb	w2, [x0, #0x9]
               	lsr	x13, x2, #7
               	ldrb	w2, [x0, #0xa]
               	lsr	x14, x2, #7
               	ldrb	w2, [x0, #0xb]
               	lsr	x15, x2, #7
               	ldrb	w2, [x0, #0xc]
               	lsr	x20, x2, #7
               	ldrb	w2, [x0, #0xd]
               	lsr	x21, x2, #7
               	ldrb	w2, [x0, #0xe]
               	lsr	x22, x2, #7
               	ldrb	w0, [x0, #0xf]
               	lsr	x23, x0, #7
               	mov	x2, #0x1b               // =27
               	sub	x0, x29, #0x40
               	mul	x4, x4, x2
               	strb	w4, [x0]
               	mul	x4, x5, x2
               	strb	w4, [x0, #0x1]
               	mul	x4, x6, x2
               	strb	w4, [x0, #0x2]
               	mul	x4, x7, x2
               	strb	w4, [x0, #0x3]
               	mul	x4, x8, x2
               	strb	w4, [x0, #0x4]
               	mul	x4, x9, x2
               	strb	w4, [x0, #0x5]
               	mul	x4, x10, x2
               	strb	w4, [x0, #0x6]
               	mul	x4, x11, x2
               	strb	w4, [x0, #0x7]
               	mul	x5, x12, x2
               	add	x4, x0, #0x8
               	strb	w5, [x4]
               	mul	x5, x13, x2
               	strb	w5, [x0, #0x9]
               	mul	x5, x14, x2
               	strb	w5, [x0, #0xa]
               	mul	x5, x15, x2
               	strb	w5, [x0, #0xb]
               	mul	x5, x20, x2
               	strb	w5, [x0, #0xc]
               	mul	x5, x21, x2
               	strb	w5, [x0, #0xd]
               	mul	x5, x22, x2
               	strb	w5, [x0, #0xe]
               	mul	x2, x23, x2
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0x30
               	ldr	x1, [x1]
               	ldr	x0, [x0]
               	eor	x0, x1, x0
               	str	x0, [x2]
               	add	x5, x2, #0x8
               	ldr	x0, [x3]
               	ldr	x1, [x4]
               	eor	x0, x0, x1
               	str	x0, [x5]
               	mov	x1, #0x63               // =99
               	sub	x0, x29, #0x10
               	ldrb	w3, [x2]
               	eor	x3, x3, x1
               	strb	w3, [x0]
               	ldrb	w3, [x2, #0x1]
               	eor	x3, x3, x1
               	strb	w3, [x0, #0x1]
               	ldrb	w3, [x2, #0x2]
               	eor	x3, x3, x1
               	strb	w3, [x0, #0x2]
               	ldrb	w3, [x2, #0x3]
               	eor	x3, x3, x1
               	strb	w3, [x0, #0x3]
               	ldrb	w3, [x2, #0x4]
               	eor	x3, x3, x1
               	strb	w3, [x0, #0x4]
               	ldrb	w3, [x2, #0x5]
               	eor	x3, x3, x1
               	strb	w3, [x0, #0x5]
               	ldrb	w3, [x2, #0x6]
               	eor	x3, x3, x1
               	strb	w3, [x0, #0x6]
               	ldrb	w3, [x2, #0x7]
               	eor	x3, x3, x1
               	strb	w3, [x0, #0x7]
               	ldrb	w3, [x5]
               	eor	x3, x3, x1
               	strb	w3, [x0, #0x8]
               	ldrb	w3, [x2, #0x9]
               	eor	x3, x3, x1
               	strb	w3, [x0, #0x9]
               	ldrb	w3, [x2, #0xa]
               	eor	x3, x3, x1
               	strb	w3, [x0, #0xa]
               	ldrb	w3, [x2, #0xb]
               	eor	x3, x3, x1
               	strb	w3, [x0, #0xb]
               	ldrb	w3, [x2, #0xc]
               	eor	x3, x3, x1
               	strb	w3, [x0, #0xc]
               	ldrb	w3, [x2, #0xd]
               	eor	x3, x3, x1
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x2, #0xe]
               	eor	x3, x3, x1
               	strb	w3, [x0, #0xe]
               	ldrb	w2, [x2, #0xf]
               	eor	x1, x2, x1
               	strb	w1, [x0, #0xf]
               	mov	x16, x0
               	ldr	q0, [x16]
               	ldp	x29, x30, [sp, #0x80]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret

<update>:
               	stp	x20, x21, [sp, #-0x130]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x120]
               	add	x29, sp, #0x120
               	sub	x16, x29, #0x68
               	str	x8, [x16]
               	stur	x0, [x29, #-0xa0]
               	stur	q0, [x29, #-0xb0]
               	sub	x0, x29, #0x100
               	ldur	x1, [x29, #-0xa0]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x1, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [x1, #0x20]
               	str	x10, [x0, #0x20]
               	ldr	x10, [x1, #0x28]
               	str	x10, [x0, #0x28]
               	ldr	x10, [x1, #0x30]
               	str	x10, [x0, #0x30]
               	ldr	x10, [x1, #0x38]
               	str	x10, [x0, #0x38]
               	ldr	x10, [x1, #0x40]
               	str	x10, [x0, #0x40]
               	ldr	x10, [x1, #0x48]
               	str	x10, [x0, #0x48]
               	ldr	x10, [sp], #0x10
               	sub	x20, x29, #0xb0
               	add	x7, x0, #0x40
               	ldr	q0, [x7]
               	bl	<addr>
               	stur	q0, [x29, #-0x78]
               	sub	x0, x29, #0x78
               	ldr	x1, [x20]
               	ldr	x2, [x0]
               	eor	x21, x1, x2
               	ldr	x1, [x20, #0x8]
               	ldr	x0, [x0, #0x8]
               	eor	x22, x1, x0
               	str	x21, [x20]
               	str	x22, [x20, #0x8]
               	sub	x20, x29, #0x100
               	add	x23, x20, #0x40
               	add	x7, x20, #0x30
               	ldr	q0, [x7]
               	bl	<addr>
               	stur	q0, [x29, #-0x78]
               	sub	x0, x29, #0x78
               	ldr	x1, [x20, #0x40]
               	ldr	x2, [x0]
               	eor	x1, x1, x2
               	ldr	x2, [x20, #0x48]
               	ldr	x0, [x0, #0x8]
               	eor	x0, x2, x0
               	str	x1, [x23]
               	str	x0, [x23, #0x8]
               	sub	x20, x29, #0x100
               	add	x23, x20, #0x30
               	add	x7, x20, #0x20
               	ldr	q0, [x7]
               	bl	<addr>
               	stur	q0, [x29, #-0x78]
               	sub	x0, x29, #0x78
               	ldr	x1, [x20, #0x30]
               	ldr	x2, [x0]
               	eor	x1, x1, x2
               	ldr	x2, [x20, #0x38]
               	ldr	x0, [x0, #0x8]
               	eor	x0, x2, x0
               	str	x1, [x23]
               	str	x0, [x23, #0x8]
               	sub	x20, x29, #0x100
               	add	x23, x20, #0x20
               	add	x7, x20, #0x10
               	ldr	q0, [x7]
               	bl	<addr>
               	stur	q0, [x29, #-0x78]
               	sub	x0, x29, #0x78
               	ldr	x1, [x20, #0x20]
               	ldr	x2, [x0]
               	eor	x1, x1, x2
               	ldr	x2, [x20, #0x28]
               	ldr	x0, [x0, #0x8]
               	eor	x0, x2, x0
               	str	x1, [x23]
               	str	x0, [x23, #0x8]
               	sub	x20, x29, #0x100
               	add	x23, x20, #0x10
               	ldr	q0, [x20]
               	bl	<addr>
               	stur	q0, [x29, #-0x78]
               	sub	x0, x29, #0x78
               	ldr	x1, [x20, #0x10]
               	ldr	x2, [x0]
               	eor	x1, x1, x2
               	ldr	x2, [x20, #0x18]
               	ldr	x0, [x0, #0x8]
               	eor	x0, x2, x0
               	str	x1, [x23]
               	str	x0, [x23, #0x8]
               	sub	x0, x29, #0x100
               	ldr	x1, [x0]
               	eor	x1, x1, x21
               	ldr	x2, [x0, #0x8]
               	eor	x2, x2, x22
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	mov	x16, x0
               	sub	x17, x29, #0x68
               	ldr	x17, [x17]
               	ldr	x0, [x16]
               	str	x0, [x17]
               	ldr	x0, [x16, #0x8]
               	str	x0, [x17, #0x8]
               	ldr	x0, [x16, #0x10]
               	str	x0, [x17, #0x10]
               	ldr	x0, [x16, #0x18]
               	str	x0, [x17, #0x18]
               	ldr	x0, [x16, #0x20]
               	str	x0, [x17, #0x20]
               	ldr	x0, [x16, #0x28]
               	str	x0, [x17, #0x28]
               	ldr	x0, [x16, #0x30]
               	str	x0, [x17, #0x30]
               	ldr	x0, [x16, #0x38]
               	str	x0, [x17, #0x38]
               	ldr	x0, [x16, #0x40]
               	str	x0, [x17, #0x40]
               	ldr	x0, [x16, #0x48]
               	str	x0, [x17, #0x48]
               	mov	x0, x17
               	ldp	x29, x30, [sp, #0x120]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x130
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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x270
               	stp	x20, x21, [sp]
               	stp	x22, x23, [sp, #0x10]
               	str	x24, [sp, #0x20]
               	mov	x22, x0
               	mov	x24, x2
               	mov	x23, x1
               	sub	x0, x29, #0x1f0
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	stp	xzr, xzr, [x0, #0x30]
               	stp	xzr, xzr, [x0, #0x40]
               	mov	x0, x22
               	bl	<addr>
               	stur	q0, [x29, #-0x100]
               	sub	x0, x29, #0x100
               	sub	x1, x29, #0x1f0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	add	x0, x22, #0x10
               	bl	<addr>
               	stur	q0, [x29, #-0x100]
               	sub	x0, x29, #0x100
               	sub	x1, x29, #0x1f0
               	add	x1, x1, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	add	x0, x22, #0x20
               	bl	<addr>
               	stur	q0, [x29, #-0x100]
               	sub	x0, x29, #0x100
               	sub	x1, x29, #0x1f0
               	add	x1, x1, #0x20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	add	x0, x22, #0x30
               	bl	<addr>
               	stur	q0, [x29, #-0x100]
               	sub	x0, x29, #0x100
               	sub	x1, x29, #0x1f0
               	add	x1, x1, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	add	x0, x22, #0x40
               	bl	<addr>
               	stur	q0, [x29, #-0x100]
               	sub	x1, x29, #0x100
               	sub	x0, x29, #0x1f0
               	add	x2, x0, #0x40
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0x140
               	ldr	q0, [x0]
               	ldr	q1, [x0, #0x10]
               	ldr	q2, [x0, #0x20]
               	ldr	q3, [x0, #0x30]
               	ldr	q4, [x0, #0x40]
               	str	q0, [x1]
               	str	q1, [x1, #0x10]
               	str	q2, [x1, #0x20]
               	str	q3, [x1, #0x30]
               	str	q4, [x1, #0x40]
               	sub	x0, x29, #0x240
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x1, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [x1, #0x20]
               	str	x10, [x0, #0x20]
               	ldr	x10, [x1, #0x28]
               	str	x10, [x0, #0x28]
               	ldr	x10, [x1, #0x30]
               	str	x10, [x0, #0x30]
               	ldr	x10, [x1, #0x38]
               	str	x10, [x0, #0x38]
               	ldr	x10, [x1, #0x40]
               	str	x10, [x0, #0x40]
               	ldr	x10, [x1, #0x48]
               	str	x10, [x0, #0x48]
               	ldr	x10, [sp], #0x10
               	mov	x20, #0x0               // =0
               	cmp	w20, w24
               	b.ge	<addr>
               	sub	x21, x29, #0x240
               	lsl	x0, x20, #4
               	sxtw	x0, w0
               	add	x0, x23, x0
               	bl	<addr>
               	sub	x16, x29, #0x150
               	str	q0, [x16]
               	sub	x7, x29, #0x150
               	ldr	q0, [x7]
               	mov	x0, x21
               	sub	x8, x29, #0x140
               	bl	<addr>
               	sub	x0, x29, #0x140
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x21]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x21, #0x8]
               	ldr	x10, [x0, #0x10]
               	str	x10, [x21, #0x10]
               	ldr	x10, [x0, #0x18]
               	str	x10, [x21, #0x18]
               	ldr	x10, [x0, #0x20]
               	str	x10, [x21, #0x20]
               	ldr	x10, [x0, #0x28]
               	str	x10, [x21, #0x28]
               	ldr	x10, [x0, #0x30]
               	str	x10, [x21, #0x30]
               	ldr	x10, [x0, #0x38]
               	str	x10, [x21, #0x38]
               	ldr	x10, [x0, #0x40]
               	str	x10, [x21, #0x40]
               	ldr	x10, [x0, #0x48]
               	str	x10, [x21, #0x48]
               	ldr	x10, [sp], #0x10
               	add	x20, x20, #0x1
               	cmp	w20, w24
               	b.lt	<addr>
               	sub	x0, x29, #0x240
               	sub	x7, x29, #0x1a0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x7]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x7, #0x8]
               	ldr	x10, [x0, #0x10]
               	str	x10, [x7, #0x10]
               	ldr	x10, [x0, #0x18]
               	str	x10, [x7, #0x18]
               	ldr	x10, [x0, #0x20]
               	str	x10, [x7, #0x20]
               	ldr	x10, [x0, #0x28]
               	str	x10, [x7, #0x28]
               	ldr	x10, [x0, #0x30]
               	str	x10, [x7, #0x30]
               	ldr	x10, [x0, #0x38]
               	str	x10, [x7, #0x38]
               	ldr	x10, [x0, #0x40]
               	str	x10, [x7, #0x40]
               	ldr	x10, [x0, #0x48]
               	str	x10, [x7, #0x48]
               	ldr	x10, [sp], #0x10
               	ldr	q0, [x7]
               	mov	x0, x22
               	bl	<addr>
               	add	x0, x22, #0x10
               	sub	x1, x29, #0x1a0
               	add	x7, x1, #0x10
               	ldr	q0, [x7]
               	bl	<addr>
               	add	x0, x22, #0x20
               	sub	x1, x29, #0x1a0
               	add	x7, x1, #0x20
               	ldr	q0, [x7]
               	bl	<addr>
               	add	x0, x22, #0x30
               	sub	x1, x29, #0x1a0
               	add	x7, x1, #0x30
               	ldr	q0, [x7]
               	bl	<addr>
               	add	x0, x22, #0x40
               	sub	x1, x29, #0x1a0
               	add	x7, x1, #0x40
               	ldr	q0, [x7]
               	bl	<addr>
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x270
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x4d0
               	stp	x20, x21, [sp]
               	stp	x22, x23, [sp, #0x10]
               	mov	x0, #0x0                // =0
               	mov	x1, #0x7                // =7
               	sub	x2, x29, #0x308
               	mul	x3, x0, x1
               	add	x3, x3, #0x1
               	and	x3, x3, #0xff
               	strb	w3, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x50
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	mov	x1, #0x1f               // =31
               	sub	x2, x29, #0x2b8
               	mul	x3, x0, x1
               	add	x3, x3, #0x9
               	and	x3, x3, #0xff
               	strb	w3, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x80
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x238
               	lsl	x1, x0, #4
               	add	x2, x2, x1
               	sub	x3, x29, #0x308
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
               	sub	x3, x29, #0x308
               	lsl	x1, x0, #4
               	add	x4, x1, #0x4
               	ldrb	w4, [x3, x4]
               	strb	w4, [x2, #0x4]
               	sub	x2, x29, #0x238
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
               	sub	x3, x29, #0x308
               	lsl	x1, x0, #4
               	add	x4, x1, #0x9
               	ldrb	w4, [x3, x4]
               	strb	w4, [x2, #0x9]
               	sub	x2, x29, #0x238
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
               	sub	x3, x29, #0x308
               	lsl	x1, x0, #4
               	add	x4, x1, #0xe
               	ldrb	w4, [x3, x4]
               	strb	w4, [x2, #0xe]
               	sub	x2, x29, #0x238
               	add	x2, x2, x1
               	add	x1, x1, #0xf
               	ldrb	w1, [x3, x1]
               	strb	w1, [x2, #0xf]
               	add	x0, x0, #0x1
               	cmp	w0, #0x5
               	b.lt	<addr>
               	sub	x0, x29, #0x238
               	sub	x1, x29, #0x2b8
               	bl	<addr>
               	sub	x0, x29, #0x238
               	sub	x1, x29, #0x2b8
               	add	x1, x1, #0x10
               	bl	<addr>
               	sub	x0, x29, #0x238
               	sub	x1, x29, #0x2b8
               	add	x1, x1, #0x20
               	bl	<addr>
               	sub	x0, x29, #0x238
               	sub	x1, x29, #0x2b8
               	add	x1, x1, #0x30
               	bl	<addr>
               	sub	x0, x29, #0x238
               	sub	x1, x29, #0x2b8
               	add	x1, x1, #0x40
               	bl	<addr>
               	sub	x0, x29, #0x238
               	sub	x1, x29, #0x2b8
               	add	x1, x1, #0x50
               	bl	<addr>
               	sub	x0, x29, #0x238
               	sub	x1, x29, #0x2b8
               	add	x1, x1, #0x60
               	bl	<addr>
               	sub	x21, x29, #0x238
               	sub	x0, x29, #0x2b8
               	add	x1, x0, #0x70
               	mov	x0, x21
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x1e8
               	sub	x2, x29, #0x308
               	ldrb	w2, [x2, x0]
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x50
               	b.lt	<addr>
               	sub	x20, x29, #0x1e8
               	sub	x1, x29, #0x2b8
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
               	sub	x1, x29, #0x3a8
               	sub	x2, x29, #0x308
               	ldrb	w2, [x2, x0]
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x50
               	b.lt	<addr>
               	sub	x21, x29, #0x3a8
               	sub	x23, x29, #0x2b8
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
               	sub	x0, x29, #0x308
               	bl	<addr>
               	sub	x16, x29, #0x318
               	str	q0, [x16]
               	sub	x0, x29, #0x318
               	sub	x1, x29, #0x4b0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x308
               	add	x0, x0, #0x10
               	bl	<addr>
               	sub	x16, x29, #0x318
               	str	q0, [x16]
               	sub	x0, x29, #0x318
               	sub	x1, x29, #0x4a0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x308
               	add	x0, x0, #0x20
               	bl	<addr>
               	sub	x16, x29, #0x318
               	str	q0, [x16]
               	sub	x0, x29, #0x318
               	sub	x1, x29, #0x490
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x308
               	add	x0, x0, #0x30
               	bl	<addr>
               	sub	x16, x29, #0x318
               	str	q0, [x16]
               	sub	x0, x29, #0x318
               	sub	x1, x29, #0x480
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x20, x29, #0x308
               	add	x0, x20, #0x40
               	bl	<addr>
               	sub	x16, x29, #0x318
               	str	q0, [x16]
               	sub	x1, x29, #0x318
               	sub	x0, x29, #0x470
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x21, x29, #0x460
               	stp	xzr, xzr, [x21]
               	stp	xzr, xzr, [x21, #0x10]
               	stp	xzr, xzr, [x21, #0x20]
               	stp	xzr, xzr, [x21, #0x30]
               	stp	xzr, xzr, [x21, #0x40]
               	sub	x1, x29, #0x4b0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x21]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x21, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0x4a0
               	add	x2, x21, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0x490
               	add	x2, x21, #0x20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0x480
               	add	x2, x21, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	add	x1, x21, #0x40
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x2b8
               	bl	<addr>
               	sub	x16, x29, #0x3b8
               	str	q0, [x16]
               	sub	x7, x29, #0x3b8
               	ldr	q0, [x7]
               	mov	x0, x21
               	sub	x8, x29, #0x358
               	bl	<addr>
               	sub	x0, x29, #0x358
               	sub	x21, x29, #0xf8
               	sub	x7, x29, #0x410
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x7]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x7, #0x8]
               	ldr	x10, [x0, #0x10]
               	str	x10, [x7, #0x10]
               	ldr	x10, [x0, #0x18]
               	str	x10, [x7, #0x18]
               	ldr	x10, [x0, #0x20]
               	str	x10, [x7, #0x20]
               	ldr	x10, [x0, #0x28]
               	str	x10, [x7, #0x28]
               	ldr	x10, [x0, #0x30]
               	str	x10, [x7, #0x30]
               	ldr	x10, [x0, #0x38]
               	str	x10, [x7, #0x38]
               	ldr	x10, [x0, #0x40]
               	str	x10, [x7, #0x40]
               	ldr	x10, [x0, #0x48]
               	str	x10, [x7, #0x48]
               	ldr	x10, [sp], #0x10
               	ldr	q0, [x7]
               	mov	x0, x21
               	bl	<addr>
               	add	x0, x21, #0x10
               	sub	x1, x29, #0x410
               	add	x7, x1, #0x10
               	ldr	q0, [x7]
               	bl	<addr>
               	add	x0, x21, #0x20
               	sub	x1, x29, #0x410
               	add	x7, x1, #0x20
               	ldr	q0, [x7]
               	bl	<addr>
               	add	x0, x21, #0x30
               	sub	x1, x29, #0x410
               	add	x7, x1, #0x30
               	ldr	q0, [x7]
               	bl	<addr>
               	add	x0, x21, #0x40
               	sub	x1, x29, #0x410
               	add	x7, x1, #0x40
               	ldr	q0, [x7]
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0xa0
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
               	sub	x3, x29, #0xa0
               	add	x4, x3, x1
               	sub	x2, x29, #0x308
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
               	sub	x2, x29, #0x308
               	add	x1, x1, #0x8
               	ldrb	w1, [x2, x1]
               	strb	w1, [x3, #0x8]
               	sub	x3, x29, #0xa0
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
               	sub	x2, x29, #0x308
               	add	x1, x1, #0xc
               	ldrb	w1, [x2, x1]
               	strb	w1, [x3, #0xc]
               	sub	x3, x29, #0xa0
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
               	sub	x20, x29, #0xa0
               	sub	x1, x29, #0x2b8
               	mov	x0, x20
               	bl	<addr>
               	mov	x2, #0x0                // =0
               	mov	x0, #0x0                // =0
               	sub	x3, x29, #0xf8
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
               	add	sp, sp, #0x4d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x14               // =20
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x4d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x22, #0x2
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x4d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x4d0
               	ldp	x29, x30, [sp], #0x10
               	ret
