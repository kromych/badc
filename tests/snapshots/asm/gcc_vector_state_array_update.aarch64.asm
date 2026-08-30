
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
               	mov	x1, x0
               	sub	x0, x29, #0x10
               	add	x2, x0, #0x0
               	add	x3, x1, #0x0
               	ldrb	w3, [x3]
               	strb	w3, [x2]
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
               	ldr	x1, [x16, #0x8]
               	ldr	x0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<store16>:
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x16, x29, #0x10
               	str	x1, [x16]
               	str	x2, [x16, #0x8]
               	add	x2, x0, #0x0
               	sub	x1, x29, #0x10
               	add	x3, x1, #0x0
               	ldrb	w3, [x3]
               	strb	w3, [x2]
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
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret

<mix>:
               	sub	sp, sp, #0x10
               	stp	x20, x21, [sp, #-0x90]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x80]
               	add	x29, sp, #0x80
               	sub	x16, x29, #0x10
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x10
               	sub	x1, x29, #0x20
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
               	ldrb	w4, [x0]
               	lsr	x4, x4, #7
               	ldrb	w5, [x0, #0x1]
               	lsr	x5, x5, #7
               	ldrb	w6, [x0, #0x2]
               	lsr	x6, x6, #7
               	ldrb	w7, [x0, #0x3]
               	lsr	x7, x7, #7
               	ldrb	w8, [x0, #0x4]
               	lsr	x8, x8, #7
               	ldrb	w9, [x0, #0x5]
               	lsr	x9, x9, #7
               	ldrb	w10, [x0, #0x6]
               	lsr	x10, x10, #7
               	ldrb	w11, [x0, #0x7]
               	lsr	x11, x11, #7
               	ldrb	w12, [x0, #0x8]
               	lsr	x12, x12, #7
               	ldrb	w13, [x0, #0x9]
               	lsr	x13, x13, #7
               	ldrb	w14, [x0, #0xa]
               	lsr	x14, x14, #7
               	ldrb	w15, [x0, #0xb]
               	lsr	x15, x15, #7
               	ldrb	w20, [x0, #0xc]
               	lsr	x20, x20, #7
               	ldrb	w21, [x0, #0xd]
               	lsr	x21, x21, #7
               	ldrb	w22, [x0, #0xe]
               	lsr	x22, x22, #7
               	ldrb	w0, [x0, #0xf]
               	lsr	x23, x0, #7
               	mov	x2, #0x1b               // =27
               	sub	x0, x29, #0x40
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	mul	x4, x4, x2
               	strb	w4, [x0]
               	mov	x17, #0xff              // =255
               	and	x4, x5, x17
               	mul	x4, x4, x2
               	strb	w4, [x0, #0x1]
               	mov	x17, #0xff              // =255
               	and	x4, x6, x17
               	mul	x4, x4, x2
               	strb	w4, [x0, #0x2]
               	mov	x17, #0xff              // =255
               	and	x4, x7, x17
               	mul	x4, x4, x2
               	strb	w4, [x0, #0x3]
               	mov	x17, #0xff              // =255
               	and	x4, x8, x17
               	mul	x4, x4, x2
               	strb	w4, [x0, #0x4]
               	mov	x17, #0xff              // =255
               	and	x4, x9, x17
               	mul	x4, x4, x2
               	strb	w4, [x0, #0x5]
               	mov	x17, #0xff              // =255
               	and	x4, x10, x17
               	mul	x4, x4, x2
               	strb	w4, [x0, #0x6]
               	mov	x17, #0xff              // =255
               	and	x4, x11, x17
               	mul	x4, x4, x2
               	strb	w4, [x0, #0x7]
               	mov	x17, #0xff              // =255
               	and	x4, x12, x17
               	mul	x5, x4, x2
               	add	x4, x0, #0x8
               	strb	w5, [x4]
               	mov	x17, #0xff              // =255
               	and	x5, x13, x17
               	mul	x5, x5, x2
               	strb	w5, [x0, #0x9]
               	mov	x17, #0xff              // =255
               	and	x5, x14, x17
               	mul	x5, x5, x2
               	strb	w5, [x0, #0xa]
               	mov	x17, #0xff              // =255
               	and	x5, x15, x17
               	mul	x5, x5, x2
               	strb	w5, [x0, #0xb]
               	mov	x17, #0xff              // =255
               	and	x5, x20, x17
               	mul	x5, x5, x2
               	strb	w5, [x0, #0xc]
               	mov	x17, #0xff              // =255
               	and	x5, x21, x17
               	mul	x5, x5, x2
               	strb	w5, [x0, #0xd]
               	mov	x17, #0xff              // =255
               	and	x5, x22, x17
               	mul	x5, x5, x2
               	strb	w5, [x0, #0xe]
               	mov	x17, #0xff              // =255
               	and	x5, x23, x17
               	mul	x2, x5, x2
               	strb	w2, [x0, #0xf]
               	sub	x2, x29, #0x50
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
               	sub	x0, x29, #0x60
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
               	ldr	x1, [x16, #0x8]
               	ldr	x0, [x16]
               	ldp	x29, x30, [sp, #0x80]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	add	sp, sp, #0x10
               	ret

<update>:
               	sub	sp, sp, #0x10
               	str	x0, [sp, #-0x10]!
               	stp	x20, x21, [sp, #-0xc0]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0xb0]
               	add	x29, sp, #0xb0
               	sub	x16, x29, #0x10
               	str	x1, [x16]
               	str	x2, [x16, #0x8]
               	sub	x16, x29, #0x68
               	str	x8, [x16]
               	sub	x0, x29, #0x60
               	ldur	x1, [x29, #0x10]
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
               	mov	x1, x0
               	sub	x20, x29, #0x10
               	add	x0, x0, #0x40
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x88
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x1, x29, #0x88
               	sub	x0, x29, #0x78
               	ldr	x2, [x20]
               	ldr	x3, [x1]
               	eor	x21, x2, x3
               	str	x21, [x0]
               	ldr	x2, [x20, #0x8]
               	ldr	x1, [x1, #0x8]
               	eor	x22, x2, x1
               	str	x22, [x0, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x20]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x20, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x20
               	sub	x20, x29, #0x60
               	add	x23, x20, #0x40
               	add	x0, x20, #0x30
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x88
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x1, x29, #0x88
               	sub	x0, x29, #0x78
               	ldr	x2, [x20, #0x40]
               	ldr	x3, [x1]
               	eor	x2, x2, x3
               	str	x2, [x0]
               	ldr	x2, [x20, #0x48]
               	ldr	x1, [x1, #0x8]
               	eor	x1, x2, x1
               	str	x1, [x0, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x23]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x23, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x23
               	sub	x20, x29, #0x60
               	add	x23, x20, #0x30
               	add	x0, x20, #0x20
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x88
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x1, x29, #0x88
               	sub	x0, x29, #0x78
               	ldr	x2, [x20, #0x30]
               	ldr	x3, [x1]
               	eor	x2, x2, x3
               	str	x2, [x0]
               	ldr	x2, [x20, #0x38]
               	ldr	x1, [x1, #0x8]
               	eor	x1, x2, x1
               	str	x1, [x0, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x23]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x23, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x23
               	sub	x20, x29, #0x60
               	add	x23, x20, #0x20
               	add	x0, x20, #0x10
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x88
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x1, x29, #0x88
               	sub	x0, x29, #0x78
               	ldr	x2, [x20, #0x20]
               	ldr	x3, [x1]
               	eor	x2, x2, x3
               	str	x2, [x0]
               	ldr	x2, [x20, #0x28]
               	ldr	x1, [x1, #0x8]
               	eor	x1, x2, x1
               	str	x1, [x0, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x23]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x23, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x23
               	sub	x20, x29, #0x60
               	add	x23, x20, #0x10
               	mov	x0, x20
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x88
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x1, x29, #0x88
               	sub	x0, x29, #0x78
               	ldr	x2, [x20, #0x10]
               	ldr	x3, [x1]
               	eor	x2, x2, x3
               	str	x2, [x0]
               	ldr	x2, [x20, #0x18]
               	ldr	x1, [x1, #0x8]
               	eor	x1, x2, x1
               	str	x1, [x0, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x23]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x23, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x23
               	sub	x1, x29, #0x60
               	ldr	x3, [x1]
               	eor	x3, x3, x21
               	str	x3, [x0]
               	ldr	x3, [x1, #0x8]
               	eor	x2, x3, x22
               	str	x2, [x0, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x16, x1
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
               	ldp	x29, x30, [sp, #0xb0]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xc0
               	add	sp, sp, #0x20
               	ret

<update_scalar>:
               	stp	x20, x21, [sp, #-0x50]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	str	x26, [sp, #0x30]
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	add	x2, x1, #0x0
               	ldrb	w5, [x2]
               	add	x2, x0, #0x40
               	add	x3, x2, #0x0
               	ldrb	w3, [x3]
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	lsl	x4, x3, #1
               	lsr	x3, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x3, x3, x17
               	eor	x3, x4, x3
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	eor	x7, x5, x3
               	ldrb	w5, [x1, #0x1]
               	ldrb	w3, [x2, #0x1]
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	lsl	x4, x3, #1
               	lsr	x3, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x3, x3, x17
               	eor	x3, x4, x3
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	eor	x8, x5, x3
               	ldrb	w5, [x1, #0x2]
               	ldrb	w3, [x2, #0x2]
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	lsl	x4, x3, #1
               	lsr	x3, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x3, x3, x17
               	eor	x3, x4, x3
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	eor	x9, x5, x3
               	ldrb	w5, [x1, #0x3]
               	ldrb	w3, [x2, #0x3]
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	lsl	x4, x3, #1
               	lsr	x3, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x3, x3, x17
               	eor	x3, x4, x3
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	eor	x10, x5, x3
               	ldrb	w5, [x1, #0x4]
               	ldrb	w3, [x2, #0x4]
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	lsl	x4, x3, #1
               	lsr	x3, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x3, x3, x17
               	eor	x3, x4, x3
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	eor	x11, x5, x3
               	ldrb	w5, [x1, #0x5]
               	ldrb	w3, [x2, #0x5]
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	lsl	x4, x3, #1
               	lsr	x3, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x3, x3, x17
               	eor	x3, x4, x3
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	eor	x12, x5, x3
               	ldrb	w5, [x1, #0x6]
               	ldrb	w3, [x2, #0x6]
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	lsl	x4, x3, #1
               	lsr	x3, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x3, x3, x17
               	eor	x3, x4, x3
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	eor	x13, x5, x3
               	ldrb	w5, [x1, #0x7]
               	ldrb	w3, [x2, #0x7]
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	lsl	x4, x3, #1
               	lsr	x3, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x3, x3, x17
               	eor	x3, x4, x3
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	eor	x14, x5, x3
               	ldrb	w5, [x1, #0x8]
               	ldrb	w3, [x2, #0x8]
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	lsl	x4, x3, #1
               	lsr	x3, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x3, x3, x17
               	eor	x3, x4, x3
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	eor	x15, x5, x3
               	ldrb	w4, [x1, #0x9]
               	ldrb	w2, [x2, #0x9]
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	lsl	x3, x2, #1
               	lsr	x2, x2, #7
               	mov	x17, #0x1b              // =27
               	mul	x2, x2, x17
               	eor	x2, x3, x2
               	mov	x17, #0x63              // =99
               	eor	x2, x2, x17
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	eor	x20, x4, x2
               	ldrb	w5, [x1, #0xa]
               	add	x2, x0, #0x40
               	ldrb	w3, [x2, #0xa]
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	lsl	x4, x3, #1
               	lsr	x3, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x3, x3, x17
               	eor	x3, x4, x3
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	eor	x21, x5, x3
               	ldrb	w5, [x1, #0xb]
               	ldrb	w3, [x2, #0xb]
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	lsl	x4, x3, #1
               	lsr	x3, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x3, x3, x17
               	eor	x3, x4, x3
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	eor	x22, x5, x3
               	ldrb	w5, [x1, #0xc]
               	ldrb	w3, [x2, #0xc]
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	lsl	x4, x3, #1
               	lsr	x3, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x3, x3, x17
               	eor	x3, x4, x3
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	eor	x23, x5, x3
               	ldrb	w5, [x1, #0xd]
               	ldrb	w3, [x2, #0xd]
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	lsl	x4, x3, #1
               	lsr	x3, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x3, x3, x17
               	eor	x3, x4, x3
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	eor	x24, x5, x3
               	ldrb	w5, [x1, #0xe]
               	ldrb	w3, [x2, #0xe]
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	lsl	x4, x3, #1
               	lsr	x3, x3, #7
               	mov	x17, #0x1b              // =27
               	mul	x3, x3, x17
               	eor	x3, x4, x3
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	eor	x25, x5, x3
               	ldrb	w3, [x1, #0xf]
               	ldrb	w1, [x2, #0xf]
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	lsl	x2, x1, #1
               	lsr	x1, x1, #7
               	mov	x17, #0x1b              // =27
               	mul	x1, x1, x17
               	eor	x1, x2, x1
               	mov	x17, #0x63              // =99
               	eor	x1, x1, x17
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	eor	x26, x3, x1
               	mov	x2, #0x4                // =4
               	b	<addr>
               	sxtw	x1, w2
               	lsl	x3, x1, #4
               	add	x3, x0, x3
               	add	x3, x3, #0x0
               	ldrb	w6, [x3]
               	sub	x4, x1, #0x1
               	sxtw	x4, w4
               	lsl	x4, x4, #4
               	add	x4, x0, x4
               	add	x4, x4, #0x0
               	ldrb	w4, [x4]
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	lsl	x5, x4, #1
               	lsr	x4, x4, #7
               	mov	x17, #0x1b              // =27
               	mul	x4, x4, x17
               	eor	x4, x5, x4
               	mov	x17, #0x63              // =99
               	eor	x4, x4, x17
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	eor	x4, x6, x4
               	strb	w4, [x3]
               	lsl	x3, x1, #4
               	add	x3, x0, x3
               	ldrb	w6, [x3, #0x1]
               	sub	x4, x1, #0x1
               	sxtw	x4, w4
               	lsl	x4, x4, #4
               	add	x4, x0, x4
               	ldrb	w4, [x4, #0x1]
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	lsl	x5, x4, #1
               	lsr	x4, x4, #7
               	mov	x17, #0x1b              // =27
               	mul	x4, x4, x17
               	eor	x4, x5, x4
               	mov	x17, #0x63              // =99
               	eor	x4, x4, x17
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	eor	x4, x6, x4
               	strb	w4, [x3, #0x1]
               	lsl	x3, x1, #4
               	add	x3, x0, x3
               	ldrb	w6, [x3, #0x2]
               	sub	x4, x1, #0x1
               	sxtw	x4, w4
               	lsl	x4, x4, #4
               	add	x4, x0, x4
               	ldrb	w4, [x4, #0x2]
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	lsl	x5, x4, #1
               	lsr	x4, x4, #7
               	mov	x17, #0x1b              // =27
               	mul	x4, x4, x17
               	eor	x4, x5, x4
               	mov	x17, #0x63              // =99
               	eor	x4, x4, x17
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	eor	x4, x6, x4
               	strb	w4, [x3, #0x2]
               	lsl	x3, x1, #4
               	add	x3, x0, x3
               	ldrb	w6, [x3, #0x3]
               	sub	x4, x1, #0x1
               	sxtw	x4, w4
               	lsl	x4, x4, #4
               	add	x4, x0, x4
               	ldrb	w4, [x4, #0x3]
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	lsl	x5, x4, #1
               	lsr	x4, x4, #7
               	mov	x17, #0x1b              // =27
               	mul	x4, x4, x17
               	eor	x4, x5, x4
               	mov	x17, #0x63              // =99
               	eor	x4, x4, x17
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	eor	x4, x6, x4
               	strb	w4, [x3, #0x3]
               	lsl	x3, x1, #4
               	add	x3, x0, x3
               	ldrb	w6, [x3, #0x4]
               	sub	x4, x1, #0x1
               	sxtw	x4, w4
               	lsl	x4, x4, #4
               	add	x4, x0, x4
               	ldrb	w4, [x4, #0x4]
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	lsl	x5, x4, #1
               	lsr	x4, x4, #7
               	mov	x17, #0x1b              // =27
               	mul	x4, x4, x17
               	eor	x4, x5, x4
               	mov	x17, #0x63              // =99
               	eor	x4, x4, x17
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	eor	x4, x6, x4
               	strb	w4, [x3, #0x4]
               	lsl	x3, x1, #4
               	add	x3, x0, x3
               	ldrb	w6, [x3, #0x5]
               	sub	x4, x1, #0x1
               	sxtw	x4, w4
               	lsl	x4, x4, #4
               	add	x4, x0, x4
               	ldrb	w4, [x4, #0x5]
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	lsl	x5, x4, #1
               	lsr	x4, x4, #7
               	mov	x17, #0x1b              // =27
               	mul	x4, x4, x17
               	eor	x4, x5, x4
               	mov	x17, #0x63              // =99
               	eor	x4, x4, x17
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	eor	x4, x6, x4
               	strb	w4, [x3, #0x5]
               	lsl	x3, x1, #4
               	add	x3, x0, x3
               	ldrb	w6, [x3, #0x6]
               	sub	x4, x1, #0x1
               	sxtw	x4, w4
               	lsl	x4, x4, #4
               	add	x4, x0, x4
               	ldrb	w4, [x4, #0x6]
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	lsl	x5, x4, #1
               	lsr	x4, x4, #7
               	mov	x17, #0x1b              // =27
               	mul	x4, x4, x17
               	eor	x4, x5, x4
               	mov	x17, #0x63              // =99
               	eor	x4, x4, x17
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	eor	x4, x6, x4
               	strb	w4, [x3, #0x6]
               	lsl	x3, x1, #4
               	add	x3, x0, x3
               	ldrb	w6, [x3, #0x7]
               	sub	x4, x1, #0x1
               	sxtw	x4, w4
               	lsl	x4, x4, #4
               	add	x4, x0, x4
               	ldrb	w4, [x4, #0x7]
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	lsl	x5, x4, #1
               	lsr	x4, x4, #7
               	mov	x17, #0x1b              // =27
               	mul	x4, x4, x17
               	eor	x4, x5, x4
               	mov	x17, #0x63              // =99
               	eor	x4, x4, x17
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	eor	x4, x6, x4
               	strb	w4, [x3, #0x7]
               	lsl	x3, x1, #4
               	add	x3, x0, x3
               	ldrb	w6, [x3, #0x8]
               	sub	x4, x1, #0x1
               	sxtw	x4, w4
               	lsl	x4, x4, #4
               	add	x4, x0, x4
               	ldrb	w4, [x4, #0x8]
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	lsl	x5, x4, #1
               	lsr	x4, x4, #7
               	mov	x17, #0x1b              // =27
               	mul	x4, x4, x17
               	eor	x4, x5, x4
               	mov	x17, #0x63              // =99
               	eor	x4, x4, x17
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	eor	x4, x6, x4
               	strb	w4, [x3, #0x8]
               	lsl	x3, x1, #4
               	add	x3, x0, x3
               	ldrb	w6, [x3, #0x9]
               	sub	x4, x1, #0x1
               	sxtw	x4, w4
               	lsl	x4, x4, #4
               	add	x4, x0, x4
               	ldrb	w4, [x4, #0x9]
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	lsl	x5, x4, #1
               	lsr	x4, x4, #7
               	mov	x17, #0x1b              // =27
               	mul	x4, x4, x17
               	eor	x4, x5, x4
               	mov	x17, #0x63              // =99
               	eor	x4, x4, x17
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	eor	x4, x6, x4
               	strb	w4, [x3, #0x9]
               	lsl	x3, x1, #4
               	add	x3, x0, x3
               	ldrb	w6, [x3, #0xa]
               	sub	x4, x1, #0x1
               	sxtw	x4, w4
               	lsl	x4, x4, #4
               	add	x4, x0, x4
               	ldrb	w4, [x4, #0xa]
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	lsl	x5, x4, #1
               	lsr	x4, x4, #7
               	mov	x17, #0x1b              // =27
               	mul	x4, x4, x17
               	eor	x4, x5, x4
               	mov	x17, #0x63              // =99
               	eor	x4, x4, x17
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	eor	x4, x6, x4
               	strb	w4, [x3, #0xa]
               	lsl	x3, x1, #4
               	add	x3, x0, x3
               	ldrb	w6, [x3, #0xb]
               	sub	x4, x1, #0x1
               	sxtw	x4, w4
               	lsl	x4, x4, #4
               	add	x4, x0, x4
               	ldrb	w4, [x4, #0xb]
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	lsl	x5, x4, #1
               	lsr	x4, x4, #7
               	mov	x17, #0x1b              // =27
               	mul	x4, x4, x17
               	eor	x4, x5, x4
               	mov	x17, #0x63              // =99
               	eor	x4, x4, x17
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	eor	x4, x6, x4
               	strb	w4, [x3, #0xb]
               	lsl	x3, x1, #4
               	add	x3, x0, x3
               	ldrb	w6, [x3, #0xc]
               	sub	x4, x1, #0x1
               	sxtw	x4, w4
               	lsl	x4, x4, #4
               	add	x4, x0, x4
               	ldrb	w4, [x4, #0xc]
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	lsl	x5, x4, #1
               	lsr	x4, x4, #7
               	mov	x17, #0x1b              // =27
               	mul	x4, x4, x17
               	eor	x4, x5, x4
               	mov	x17, #0x63              // =99
               	eor	x4, x4, x17
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	eor	x4, x6, x4
               	strb	w4, [x3, #0xc]
               	lsl	x3, x1, #4
               	add	x3, x0, x3
               	ldrb	w6, [x3, #0xd]
               	sub	x4, x1, #0x1
               	sxtw	x4, w4
               	lsl	x4, x4, #4
               	add	x4, x0, x4
               	ldrb	w4, [x4, #0xd]
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	lsl	x5, x4, #1
               	lsr	x4, x4, #7
               	mov	x17, #0x1b              // =27
               	mul	x4, x4, x17
               	eor	x4, x5, x4
               	mov	x17, #0x63              // =99
               	eor	x4, x4, x17
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	eor	x4, x6, x4
               	strb	w4, [x3, #0xd]
               	lsl	x3, x1, #4
               	add	x3, x0, x3
               	ldrb	w6, [x3, #0xe]
               	sub	x4, x1, #0x1
               	sxtw	x4, w4
               	lsl	x4, x4, #4
               	add	x4, x0, x4
               	ldrb	w4, [x4, #0xe]
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	lsl	x5, x4, #1
               	lsr	x4, x4, #7
               	mov	x17, #0x1b              // =27
               	mul	x4, x4, x17
               	eor	x4, x5, x4
               	mov	x17, #0x63              // =99
               	eor	x4, x4, x17
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	eor	x4, x6, x4
               	strb	w4, [x3, #0xe]
               	lsl	x3, x1, #4
               	add	x3, x0, x3
               	ldrb	w6, [x3, #0xf]
               	sub	x4, x1, #0x1
               	sxtw	x4, w4
               	lsl	x4, x4, #4
               	add	x4, x0, x4
               	ldrb	w4, [x4, #0xf]
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	lsl	x5, x4, #1
               	lsr	x4, x4, #7
               	mov	x17, #0x1b              // =27
               	mul	x4, x4, x17
               	eor	x4, x5, x4
               	mov	x17, #0x63              // =99
               	eor	x4, x4, x17
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	eor	x4, x6, x4
               	strb	w4, [x3, #0xf]
               	sub	x2, x1, #0x1
               	cmp	w2, #0x0
               	b.gt	<addr>
               	add	x1, x0, #0x0
               	ldrb	w2, [x1]
               	mov	x17, #0xff              // =255
               	and	x3, x7, x17
               	eor	x2, x2, x3
               	strb	w2, [x1]
               	ldrb	w1, [x0, #0x1]
               	mov	x17, #0xff              // =255
               	and	x2, x8, x17
               	eor	x1, x1, x2
               	strb	w1, [x0, #0x1]
               	ldrb	w1, [x0, #0x2]
               	mov	x17, #0xff              // =255
               	and	x2, x9, x17
               	eor	x1, x1, x2
               	strb	w1, [x0, #0x2]
               	ldrb	w1, [x0, #0x3]
               	mov	x17, #0xff              // =255
               	and	x2, x10, x17
               	eor	x1, x1, x2
               	strb	w1, [x0, #0x3]
               	ldrb	w1, [x0, #0x4]
               	mov	x17, #0xff              // =255
               	and	x2, x11, x17
               	eor	x1, x1, x2
               	strb	w1, [x0, #0x4]
               	ldrb	w1, [x0, #0x5]
               	mov	x17, #0xff              // =255
               	and	x2, x12, x17
               	eor	x1, x1, x2
               	strb	w1, [x0, #0x5]
               	ldrb	w1, [x0, #0x6]
               	mov	x17, #0xff              // =255
               	and	x2, x13, x17
               	eor	x1, x1, x2
               	strb	w1, [x0, #0x6]
               	ldrb	w1, [x0, #0x7]
               	mov	x17, #0xff              // =255
               	and	x2, x14, x17
               	eor	x1, x1, x2
               	strb	w1, [x0, #0x7]
               	ldrb	w1, [x0, #0x8]
               	mov	x17, #0xff              // =255
               	and	x2, x15, x17
               	eor	x1, x1, x2
               	strb	w1, [x0, #0x8]
               	ldrb	w1, [x0, #0x9]
               	mov	x17, #0xff              // =255
               	and	x2, x20, x17
               	eor	x1, x1, x2
               	strb	w1, [x0, #0x9]
               	ldrb	w1, [x0, #0xa]
               	mov	x17, #0xff              // =255
               	and	x2, x21, x17
               	eor	x1, x1, x2
               	strb	w1, [x0, #0xa]
               	ldrb	w1, [x0, #0xb]
               	mov	x17, #0xff              // =255
               	and	x2, x22, x17
               	eor	x1, x1, x2
               	strb	w1, [x0, #0xb]
               	ldrb	w1, [x0, #0xc]
               	mov	x17, #0xff              // =255
               	and	x2, x23, x17
               	eor	x1, x1, x2
               	strb	w1, [x0, #0xc]
               	ldrb	w1, [x0, #0xd]
               	mov	x17, #0xff              // =255
               	and	x2, x24, x17
               	eor	x1, x1, x2
               	strb	w1, [x0, #0xd]
               	ldrb	w1, [x0, #0xe]
               	mov	x17, #0xff              // =255
               	and	x2, x25, x17
               	eor	x1, x1, x2
               	strb	w1, [x0, #0xe]
               	ldrb	w1, [x0, #0xf]
               	mov	x17, #0xff              // =255
               	and	x2, x26, x17
               	eor	x1, x1, x2
               	strb	w1, [x0, #0xf]
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x26, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x6e0
               	stp	x20, x21, [sp]
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x26, x27, [sp, #0x30]
               	str	x28, [sp, #0x40]
               	mov	x0, #0x0                // =0
               	mov	x3, #0x7                // =7
               	mov	x4, #0xff               // =255
               	b	<addr>
               	sub	x2, x29, #0x308
               	sxtw	x1, w0
               	add	x5, x2, x1
               	mul	x2, x1, x3
               	add	x2, x2, #0x1
               	and	x2, x2, x4
               	strb	w2, [x5]
               	add	x0, x1, #0x1
               	cmp	w0, #0x50
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	mov	x3, #0x1f               // =31
               	mov	x4, #0xff               // =255
               	b	<addr>
               	sub	x2, x29, #0x2b8
               	sxtw	x1, w0
               	add	x5, x2, x1
               	mul	x2, x1, x3
               	add	x2, x2, #0x9
               	and	x2, x2, x4
               	strb	w2, [x5]
               	add	x0, x1, #0x1
               	cmp	w0, #0x80
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x4, x29, #0x238
               	sxtw	x2, w0
               	lsl	x5, x2, #4
               	add	x3, x4, x5
               	add	x8, x3, #0x0
               	sub	x6, x29, #0x308
               	lsl	x1, x0, #4
               	add	x7, x1, #0x0
               	sxtw	x7, w7
               	add	x7, x6, x7
               	ldrb	w7, [x7]
               	strb	w7, [x8]
               	add	x7, x1, #0x1
               	sxtw	x7, w7
               	add	x7, x6, x7
               	ldrb	w7, [x7]
               	strb	w7, [x3, #0x1]
               	add	x7, x1, #0x2
               	sxtw	x7, w7
               	add	x7, x6, x7
               	ldrb	w7, [x7]
               	strb	w7, [x3, #0x2]
               	add	x1, x1, #0x3
               	sxtw	x1, w1
               	add	x1, x6, x1
               	ldrb	w1, [x1]
               	strb	w1, [x3, #0x3]
               	sub	x4, x29, #0x308
               	lsl	x1, x0, #4
               	add	x5, x1, #0x4
               	sxtw	x5, w5
               	add	x5, x4, x5
               	ldrb	w5, [x5]
               	strb	w5, [x3, #0x4]
               	sub	x6, x29, #0x238
               	lsl	x5, x2, #4
               	add	x3, x6, x5
               	add	x7, x1, #0x5
               	sxtw	x7, w7
               	add	x7, x4, x7
               	ldrb	w7, [x7]
               	strb	w7, [x3, #0x5]
               	add	x7, x1, #0x6
               	sxtw	x7, w7
               	add	x7, x4, x7
               	ldrb	w7, [x7]
               	strb	w7, [x3, #0x6]
               	add	x7, x1, #0x7
               	sxtw	x7, w7
               	add	x7, x4, x7
               	ldrb	w7, [x7]
               	strb	w7, [x3, #0x7]
               	add	x6, x1, #0x8
               	sxtw	x6, w6
               	add	x4, x4, x6
               	ldrb	w4, [x4]
               	strb	w4, [x3, #0x8]
               	sub	x4, x29, #0x238
               	add	x3, x4, x5
               	sub	x5, x29, #0x308
               	add	x1, x1, #0x9
               	sxtw	x1, w1
               	add	x1, x5, x1
               	ldrb	w1, [x1]
               	strb	w1, [x3, #0x9]
               	lsl	x6, x2, #4
               	add	x3, x4, x6
               	lsl	x1, x0, #4
               	add	x7, x1, #0xa
               	sxtw	x7, w7
               	add	x7, x5, x7
               	ldrb	w7, [x7]
               	strb	w7, [x3, #0xa]
               	add	x7, x1, #0xb
               	sxtw	x7, w7
               	add	x7, x5, x7
               	ldrb	w7, [x7]
               	strb	w7, [x3, #0xb]
               	add	x7, x1, #0xc
               	sxtw	x7, w7
               	add	x7, x5, x7
               	ldrb	w7, [x7]
               	strb	w7, [x3, #0xc]
               	add	x1, x1, #0xd
               	sxtw	x1, w1
               	add	x1, x5, x1
               	ldrb	w1, [x1]
               	strb	w1, [x3, #0xd]
               	sub	x4, x29, #0x308
               	lsl	x1, x0, #4
               	add	x5, x1, #0xe
               	sxtw	x5, w5
               	add	x5, x4, x5
               	ldrb	w5, [x5]
               	strb	w5, [x3, #0xe]
               	sub	x3, x29, #0x238
               	lsl	x5, x2, #4
               	add	x3, x3, x5
               	add	x1, x1, #0xf
               	sxtw	x1, w1
               	add	x1, x4, x1
               	ldrb	w1, [x1]
               	strb	w1, [x3, #0xf]
               	add	x0, x2, #0x1
               	cmp	w0, #0x5
               	b.lt	<addr>
               	sub	x0, x29, #0x238
               	sub	x1, x29, #0x2b8
               	add	x1, x1, #0x0
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
               	sub	x0, x29, #0x238
               	sub	x1, x29, #0x2b8
               	add	x1, x1, #0x70
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x1e8
               	sxtw	x1, w0
               	add	x2, x2, x1
               	sub	x3, x29, #0x308
               	add	x3, x3, x1
               	ldrb	w3, [x3]
               	strb	w3, [x2]
               	add	x0, x1, #0x1
               	cmp	w0, #0x50
               	b.lt	<addr>
               	sub	x22, x29, #0x1e8
               	sub	x23, x29, #0x2b8
               	sub	x0, x29, #0x358
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	x1, [x0, #0x10]
               	str	x1, [x0, #0x18]
               	str	x1, [x0, #0x20]
               	str	x1, [x0, #0x28]
               	str	x1, [x0, #0x30]
               	str	x1, [x0, #0x38]
               	str	x1, [x0, #0x40]
               	str	x1, [x0, #0x48]
               	mov	x0, x22
               	bl	<addr>
               	sub	x16, x29, #0x498
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x498
               	sub	x1, x29, #0x358
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	add	x0, x22, #0x10
               	bl	<addr>
               	sub	x16, x29, #0x488
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x488
               	sub	x1, x29, #0x358
               	add	x1, x1, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	add	x0, x22, #0x20
               	bl	<addr>
               	sub	x16, x29, #0x478
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x478
               	sub	x1, x29, #0x358
               	add	x1, x1, #0x20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	add	x0, x22, #0x30
               	bl	<addr>
               	sub	x16, x29, #0x468
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x468
               	sub	x1, x29, #0x358
               	add	x1, x1, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	add	x0, x22, #0x40
               	bl	<addr>
               	sub	x16, x29, #0x458
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x1, x29, #0x458
               	sub	x0, x29, #0x358
               	add	x2, x0, #0x40
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x2
               	sub	x1, x29, #0x448
               	ldrb	w2, [x0]
               	ldrb	w3, [x0, #0x1]
               	ldrb	w4, [x0, #0x2]
               	ldrb	w5, [x0, #0x3]
               	ldrb	w6, [x0, #0x4]
               	ldrb	w7, [x0, #0x5]
               	ldrb	w8, [x0, #0x6]
               	ldrb	w9, [x0, #0x7]
               	ldrb	w10, [x0, #0x8]
               	ldrb	w11, [x0, #0x9]
               	ldrb	w12, [x0, #0xa]
               	ldrb	w13, [x0, #0xb]
               	ldrb	w14, [x0, #0xc]
               	ldrb	w15, [x0, #0xd]
               	ldrb	w20, [x0, #0xe]
               	ldrb	w21, [x0, #0xf]
               	ldrb	w24, [x0, #0x10]
               	ldrb	w25, [x0, #0x11]
               	ldrb	w26, [x0, #0x12]
               	ldrb	w27, [x0, #0x13]
               	ldrb	w28, [x0, #0x14]
               	ldrb	w17, [x0, #0x15]
               	str	x17, [sp, #0x228]
               	ldrb	w17, [x0, #0x16]
               	str	x17, [sp, #0x220]
               	ldrb	w17, [x0, #0x17]
               	str	x17, [sp, #0x218]
               	ldrb	w17, [x0, #0x18]
               	str	x17, [sp, #0x210]
               	ldrb	w17, [x0, #0x19]
               	str	x17, [sp, #0x208]
               	ldrb	w17, [x0, #0x1a]
               	str	x17, [sp, #0x200]
               	ldrb	w17, [x0, #0x1b]
               	str	x17, [sp, #0x1f8]
               	ldrb	w17, [x0, #0x1c]
               	str	x17, [sp, #0x1f0]
               	ldrb	w17, [x0, #0x1d]
               	str	x17, [sp, #0x1e8]
               	ldrb	w17, [x0, #0x1e]
               	str	x17, [sp, #0x1e0]
               	ldrb	w17, [x0, #0x1f]
               	str	x17, [sp, #0x1d8]
               	ldrb	w17, [x0, #0x20]
               	str	x17, [sp, #0x1d0]
               	ldrb	w17, [x0, #0x21]
               	str	x17, [sp, #0x1c8]
               	ldrb	w17, [x0, #0x22]
               	str	x17, [sp, #0x1c0]
               	ldrb	w17, [x0, #0x23]
               	str	x17, [sp, #0x1b8]
               	ldrb	w17, [x0, #0x24]
               	str	x17, [sp, #0x1b0]
               	ldrb	w17, [x0, #0x25]
               	str	x17, [sp, #0x1a8]
               	ldrb	w17, [x0, #0x26]
               	str	x17, [sp, #0x1a0]
               	ldrb	w17, [x0, #0x27]
               	str	x17, [sp, #0x198]
               	ldrb	w17, [x0, #0x28]
               	str	x17, [sp, #0x190]
               	ldrb	w17, [x0, #0x29]
               	str	x17, [sp, #0x188]
               	ldrb	w17, [x0, #0x2a]
               	str	x17, [sp, #0x180]
               	ldrb	w17, [x0, #0x2b]
               	str	x17, [sp, #0x178]
               	ldrb	w17, [x0, #0x2c]
               	str	x17, [sp, #0x170]
               	ldrb	w17, [x0, #0x2d]
               	str	x17, [sp, #0x168]
               	ldrb	w17, [x0, #0x2e]
               	str	x17, [sp, #0x160]
               	ldrb	w17, [x0, #0x2f]
               	str	x17, [sp, #0x158]
               	ldrb	w17, [x0, #0x30]
               	str	x17, [sp, #0x150]
               	ldrb	w17, [x0, #0x31]
               	str	x17, [sp, #0x148]
               	ldrb	w17, [x0, #0x32]
               	str	x17, [sp, #0x140]
               	ldrb	w17, [x0, #0x33]
               	str	x17, [sp, #0x138]
               	ldrb	w17, [x0, #0x34]
               	str	x17, [sp, #0x130]
               	ldrb	w17, [x0, #0x35]
               	str	x17, [sp, #0x128]
               	ldrb	w17, [x0, #0x36]
               	str	x17, [sp, #0x120]
               	ldrb	w17, [x0, #0x37]
               	str	x17, [sp, #0x118]
               	ldrb	w17, [x0, #0x38]
               	str	x17, [sp, #0x110]
               	ldrb	w17, [x0, #0x39]
               	str	x17, [sp, #0x108]
               	ldrb	w17, [x0, #0x3a]
               	str	x17, [sp, #0x100]
               	ldrb	w17, [x0, #0x3b]
               	str	x17, [sp, #0xf8]
               	ldrb	w17, [x0, #0x3c]
               	str	x17, [sp, #0xf0]
               	ldrb	w17, [x0, #0x3d]
               	str	x17, [sp, #0xe8]
               	ldrb	w17, [x0, #0x3e]
               	str	x17, [sp, #0xe0]
               	ldrb	w17, [x0, #0x3f]
               	str	x17, [sp, #0xd8]
               	ldrb	w17, [x0, #0x40]
               	str	x17, [sp, #0xd0]
               	ldrb	w17, [x0, #0x41]
               	str	x17, [sp, #0xc8]
               	ldrb	w17, [x0, #0x42]
               	str	x17, [sp, #0xc0]
               	ldrb	w17, [x0, #0x43]
               	str	x17, [sp, #0xb8]
               	ldrb	w17, [x0, #0x44]
               	str	x17, [sp, #0xb0]
               	ldrb	w17, [x0, #0x45]
               	str	x17, [sp, #0xa8]
               	ldrb	w17, [x0, #0x46]
               	str	x17, [sp, #0xa0]
               	ldrb	w17, [x0, #0x47]
               	str	x17, [sp, #0x98]
               	ldrb	w17, [x0, #0x48]
               	str	x17, [sp, #0x90]
               	ldrb	w17, [x0, #0x49]
               	str	x17, [sp, #0x88]
               	ldrb	w17, [x0, #0x4a]
               	str	x17, [sp, #0x80]
               	ldrb	w17, [x0, #0x4b]
               	str	x17, [sp, #0x78]
               	ldrb	w17, [x0, #0x4c]
               	str	x17, [sp, #0x70]
               	ldrb	w17, [x0, #0x4d]
               	str	x17, [sp, #0x68]
               	ldrb	w17, [x0, #0x4e]
               	str	x17, [sp, #0x60]
               	ldrb	w0, [x0, #0x4f]
               	strb	w2, [x1]
               	strb	w3, [x1, #0x1]
               	strb	w4, [x1, #0x2]
               	strb	w5, [x1, #0x3]
               	strb	w6, [x1, #0x4]
               	strb	w7, [x1, #0x5]
               	strb	w8, [x1, #0x6]
               	strb	w9, [x1, #0x7]
               	strb	w10, [x1, #0x8]
               	strb	w11, [x1, #0x9]
               	strb	w12, [x1, #0xa]
               	strb	w13, [x1, #0xb]
               	strb	w14, [x1, #0xc]
               	strb	w15, [x1, #0xd]
               	strb	w20, [x1, #0xe]
               	strb	w21, [x1, #0xf]
               	strb	w24, [x1, #0x10]
               	strb	w25, [x1, #0x11]
               	strb	w26, [x1, #0x12]
               	strb	w27, [x1, #0x13]
               	strb	w28, [x1, #0x14]
               	ldr	x17, [sp, #0x228]
               	strb	w17, [x1, #0x15]
               	ldr	x17, [sp, #0x220]
               	strb	w17, [x1, #0x16]
               	ldr	x17, [sp, #0x218]
               	strb	w17, [x1, #0x17]
               	ldr	x17, [sp, #0x210]
               	strb	w17, [x1, #0x18]
               	ldr	x17, [sp, #0x208]
               	strb	w17, [x1, #0x19]
               	ldr	x17, [sp, #0x200]
               	strb	w17, [x1, #0x1a]
               	ldr	x17, [sp, #0x1f8]
               	strb	w17, [x1, #0x1b]
               	ldr	x17, [sp, #0x1f0]
               	strb	w17, [x1, #0x1c]
               	ldr	x17, [sp, #0x1e8]
               	strb	w17, [x1, #0x1d]
               	ldr	x17, [sp, #0x1e0]
               	strb	w17, [x1, #0x1e]
               	ldr	x17, [sp, #0x1d8]
               	strb	w17, [x1, #0x1f]
               	ldr	x17, [sp, #0x1d0]
               	strb	w17, [x1, #0x20]
               	ldr	x17, [sp, #0x1c8]
               	strb	w17, [x1, #0x21]
               	ldr	x17, [sp, #0x1c0]
               	strb	w17, [x1, #0x22]
               	ldr	x17, [sp, #0x1b8]
               	strb	w17, [x1, #0x23]
               	ldr	x17, [sp, #0x1b0]
               	strb	w17, [x1, #0x24]
               	ldr	x17, [sp, #0x1a8]
               	strb	w17, [x1, #0x25]
               	ldr	x17, [sp, #0x1a0]
               	strb	w17, [x1, #0x26]
               	ldr	x17, [sp, #0x198]
               	strb	w17, [x1, #0x27]
               	ldr	x17, [sp, #0x190]
               	strb	w17, [x1, #0x28]
               	ldr	x17, [sp, #0x188]
               	strb	w17, [x1, #0x29]
               	ldr	x17, [sp, #0x180]
               	strb	w17, [x1, #0x2a]
               	ldr	x17, [sp, #0x178]
               	strb	w17, [x1, #0x2b]
               	ldr	x17, [sp, #0x170]
               	strb	w17, [x1, #0x2c]
               	ldr	x17, [sp, #0x168]
               	strb	w17, [x1, #0x2d]
               	ldr	x17, [sp, #0x160]
               	strb	w17, [x1, #0x2e]
               	ldr	x17, [sp, #0x158]
               	strb	w17, [x1, #0x2f]
               	ldr	x17, [sp, #0x150]
               	strb	w17, [x1, #0x30]
               	ldr	x17, [sp, #0x148]
               	strb	w17, [x1, #0x31]
               	ldr	x17, [sp, #0x140]
               	strb	w17, [x1, #0x32]
               	ldr	x17, [sp, #0x138]
               	strb	w17, [x1, #0x33]
               	ldr	x17, [sp, #0x130]
               	strb	w17, [x1, #0x34]
               	ldr	x17, [sp, #0x128]
               	strb	w17, [x1, #0x35]
               	ldr	x17, [sp, #0x120]
               	strb	w17, [x1, #0x36]
               	ldr	x17, [sp, #0x118]
               	strb	w17, [x1, #0x37]
               	ldr	x17, [sp, #0x110]
               	strb	w17, [x1, #0x38]
               	ldr	x17, [sp, #0x108]
               	strb	w17, [x1, #0x39]
               	ldr	x17, [sp, #0x100]
               	strb	w17, [x1, #0x3a]
               	ldr	x17, [sp, #0xf8]
               	strb	w17, [x1, #0x3b]
               	ldr	x17, [sp, #0xf0]
               	strb	w17, [x1, #0x3c]
               	ldr	x17, [sp, #0xe8]
               	strb	w17, [x1, #0x3d]
               	ldr	x17, [sp, #0xe0]
               	strb	w17, [x1, #0x3e]
               	ldr	x17, [sp, #0xd8]
               	strb	w17, [x1, #0x3f]
               	ldr	x17, [sp, #0xd0]
               	strb	w17, [x1, #0x40]
               	ldr	x17, [sp, #0xc8]
               	strb	w17, [x1, #0x41]
               	ldr	x17, [sp, #0xc0]
               	strb	w17, [x1, #0x42]
               	ldr	x17, [sp, #0xb8]
               	strb	w17, [x1, #0x43]
               	ldr	x17, [sp, #0xb0]
               	strb	w17, [x1, #0x44]
               	ldr	x17, [sp, #0xa8]
               	strb	w17, [x1, #0x45]
               	ldr	x17, [sp, #0xa0]
               	strb	w17, [x1, #0x46]
               	ldr	x17, [sp, #0x98]
               	strb	w17, [x1, #0x47]
               	ldr	x17, [sp, #0x90]
               	strb	w17, [x1, #0x48]
               	ldr	x17, [sp, #0x88]
               	strb	w17, [x1, #0x49]
               	ldr	x17, [sp, #0x80]
               	strb	w17, [x1, #0x4a]
               	ldr	x17, [sp, #0x78]
               	strb	w17, [x1, #0x4b]
               	ldr	x17, [sp, #0x70]
               	strb	w17, [x1, #0x4c]
               	ldr	x17, [sp, #0x68]
               	strb	w17, [x1, #0x4d]
               	ldr	x17, [sp, #0x60]
               	strb	w17, [x1, #0x4e]
               	strb	w0, [x1, #0x4f]
               	sub	x0, x29, #0x448
               	sub	x1, x29, #0x50
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [x0, #0x10]
               	str	x10, [x1, #0x10]
               	ldr	x10, [x0, #0x18]
               	str	x10, [x1, #0x18]
               	ldr	x10, [x0, #0x20]
               	str	x10, [x1, #0x20]
               	ldr	x10, [x0, #0x28]
               	str	x10, [x1, #0x28]
               	ldr	x10, [x0, #0x30]
               	str	x10, [x1, #0x30]
               	ldr	x10, [x0, #0x38]
               	str	x10, [x1, #0x38]
               	ldr	x10, [x0, #0x40]
               	str	x10, [x1, #0x40]
               	ldr	x10, [x0, #0x48]
               	str	x10, [x1, #0x48]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x20, #0x0               // =0
               	b	<addr>
               	sub	x21, x29, #0x50
               	lsl	x0, x20, #4
               	sxtw	x0, w0
               	add	x0, x23, x0
               	bl	<addr>
               	sub	x16, x29, #0x4a8
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x1, x29, #0x4a8
               	mov	x0, x21
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	sub	x8, x29, #0x3f8
               	bl	<addr>
               	sub	x0, x29, #0x3f8
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
               	mov	x0, x21
               	sxtw	x0, w20
               	add	x20, x0, #0x1
               	cmp	w20, #0x8
               	b.lt	<addr>
               	sub	x1, x29, #0x50
               	sub	x0, x29, #0x3a8
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
               	mov	x1, x0
               	add	x1, x22, #0x0
               	add	x0, x0, #0x0
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	add	x0, x22, #0x10
               	sub	x1, x29, #0x3a8
               	add	x1, x1, #0x10
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	add	x0, x22, #0x20
               	sub	x1, x29, #0x3a8
               	add	x1, x1, #0x20
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	add	x0, x22, #0x30
               	sub	x1, x29, #0x3a8
               	add	x1, x1, #0x30
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	add	x0, x22, #0x40
               	sub	x1, x29, #0x3a8
               	add	x1, x1, #0x40
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x3, x29, #0x1e8
               	lsl	x2, x1, #4
               	add	x2, x2, x0
               	sxtw	x2, w2
               	add	x2, x3, x2
               	ldrb	w3, [x2]
               	sub	x2, x29, #0x238
               	sxtw	x4, w1
               	lsl	x4, x4, #4
               	add	x4, x2, x4
               	sxtw	x2, w0
               	add	x4, x4, x2
               	ldrb	w4, [x4]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x2, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sxtw	x0, w1
               	add	x1, x0, #0x1
               	cmp	w1, #0x5
               	b.lt	<addr>
               	mov	x22, #0x0               // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x198
               	sxtw	x1, w0
               	add	x2, x2, x1
               	sub	x3, x29, #0x308
               	add	x1, x3, x1
               	ldrb	w1, [x1]
               	strb	w1, [x2]
               	sxtw	x0, w0
               	add	x0, x0, #0x1
               	cmp	w0, #0x50
               	b.lt	<addr>
               	sub	x23, x29, #0x198
               	sub	x24, x29, #0x2b8
               	sub	x20, x29, #0x358
               	mov	x0, #0x0                // =0
               	str	x0, [x20]
               	str	x0, [x20, #0x8]
               	str	x0, [x20, #0x10]
               	str	x0, [x20, #0x18]
               	str	x0, [x20, #0x20]
               	str	x0, [x20, #0x28]
               	str	x0, [x20, #0x30]
               	str	x0, [x20, #0x38]
               	str	x0, [x20, #0x40]
               	str	x0, [x20, #0x48]
               	mov	x0, x23
               	bl	<addr>
               	sub	x16, x29, #0x498
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x498
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x20]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x20, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x20
               	add	x0, x23, #0x10
               	bl	<addr>
               	sub	x16, x29, #0x488
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x488
               	add	x1, x20, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	add	x0, x23, #0x20
               	bl	<addr>
               	sub	x16, x29, #0x478
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x478
               	sub	x20, x29, #0x358
               	add	x1, x20, #0x20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	add	x0, x23, #0x30
               	bl	<addr>
               	sub	x16, x29, #0x468
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x468
               	add	x1, x20, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	add	x0, x23, #0x40
               	bl	<addr>
               	sub	x16, x29, #0x458
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x458
               	add	x1, x20, #0x40
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x1, x29, #0x358
               	sub	x0, x29, #0x448
               	ldrb	w2, [x1]
               	ldrb	w3, [x1, #0x1]
               	ldrb	w4, [x1, #0x2]
               	ldrb	w5, [x1, #0x3]
               	ldrb	w6, [x1, #0x4]
               	ldrb	w7, [x1, #0x5]
               	ldrb	w8, [x1, #0x6]
               	ldrb	w9, [x1, #0x7]
               	ldrb	w10, [x1, #0x8]
               	ldrb	w11, [x1, #0x9]
               	ldrb	w12, [x1, #0xa]
               	ldrb	w13, [x1, #0xb]
               	ldrb	w14, [x1, #0xc]
               	ldrb	w15, [x1, #0xd]
               	ldrb	w20, [x1, #0xe]
               	ldrb	w21, [x1, #0xf]
               	ldrb	w25, [x1, #0x10]
               	ldrb	w26, [x1, #0x11]
               	ldrb	w27, [x1, #0x12]
               	ldrb	w28, [x1, #0x13]
               	ldrb	w17, [x1, #0x14]
               	str	x17, [sp, #0x228]
               	ldrb	w17, [x1, #0x15]
               	str	x17, [sp, #0x220]
               	ldrb	w17, [x1, #0x16]
               	str	x17, [sp, #0x218]
               	ldrb	w17, [x1, #0x17]
               	str	x17, [sp, #0x210]
               	ldrb	w17, [x1, #0x18]
               	str	x17, [sp, #0x208]
               	ldrb	w17, [x1, #0x19]
               	str	x17, [sp, #0x200]
               	ldrb	w17, [x1, #0x1a]
               	str	x17, [sp, #0x1f8]
               	ldrb	w17, [x1, #0x1b]
               	str	x17, [sp, #0x1f0]
               	ldrb	w17, [x1, #0x1c]
               	str	x17, [sp, #0x1e8]
               	ldrb	w17, [x1, #0x1d]
               	str	x17, [sp, #0x1e0]
               	ldrb	w17, [x1, #0x1e]
               	str	x17, [sp, #0x1d8]
               	ldrb	w17, [x1, #0x1f]
               	str	x17, [sp, #0x1d0]
               	ldrb	w17, [x1, #0x20]
               	str	x17, [sp, #0x1c8]
               	ldrb	w17, [x1, #0x21]
               	str	x17, [sp, #0x1c0]
               	ldrb	w17, [x1, #0x22]
               	str	x17, [sp, #0x1b8]
               	ldrb	w17, [x1, #0x23]
               	str	x17, [sp, #0x1b0]
               	ldrb	w17, [x1, #0x24]
               	str	x17, [sp, #0x1a8]
               	ldrb	w17, [x1, #0x25]
               	str	x17, [sp, #0x1a0]
               	ldrb	w17, [x1, #0x26]
               	str	x17, [sp, #0x198]
               	ldrb	w17, [x1, #0x27]
               	str	x17, [sp, #0x190]
               	ldrb	w17, [x1, #0x28]
               	str	x17, [sp, #0x188]
               	ldrb	w17, [x1, #0x29]
               	str	x17, [sp, #0x180]
               	ldrb	w17, [x1, #0x2a]
               	str	x17, [sp, #0x178]
               	ldrb	w17, [x1, #0x2b]
               	str	x17, [sp, #0x170]
               	ldrb	w17, [x1, #0x2c]
               	str	x17, [sp, #0x168]
               	ldrb	w17, [x1, #0x2d]
               	str	x17, [sp, #0x160]
               	ldrb	w17, [x1, #0x2e]
               	str	x17, [sp, #0x158]
               	ldrb	w17, [x1, #0x2f]
               	str	x17, [sp, #0x150]
               	ldrb	w17, [x1, #0x30]
               	str	x17, [sp, #0x148]
               	ldrb	w17, [x1, #0x31]
               	str	x17, [sp, #0x140]
               	ldrb	w17, [x1, #0x32]
               	str	x17, [sp, #0x138]
               	ldrb	w17, [x1, #0x33]
               	str	x17, [sp, #0x130]
               	ldrb	w17, [x1, #0x34]
               	str	x17, [sp, #0x128]
               	ldrb	w17, [x1, #0x35]
               	str	x17, [sp, #0x120]
               	ldrb	w17, [x1, #0x36]
               	str	x17, [sp, #0x118]
               	ldrb	w17, [x1, #0x37]
               	str	x17, [sp, #0x110]
               	ldrb	w17, [x1, #0x38]
               	str	x17, [sp, #0x108]
               	ldrb	w17, [x1, #0x39]
               	str	x17, [sp, #0x100]
               	ldrb	w17, [x1, #0x3a]
               	str	x17, [sp, #0xf8]
               	ldrb	w17, [x1, #0x3b]
               	str	x17, [sp, #0xf0]
               	ldrb	w17, [x1, #0x3c]
               	str	x17, [sp, #0xe8]
               	ldrb	w17, [x1, #0x3d]
               	str	x17, [sp, #0xe0]
               	ldrb	w17, [x1, #0x3e]
               	str	x17, [sp, #0xd8]
               	ldrb	w17, [x1, #0x3f]
               	str	x17, [sp, #0xd0]
               	ldrb	w17, [x1, #0x40]
               	str	x17, [sp, #0xc8]
               	ldrb	w17, [x1, #0x41]
               	str	x17, [sp, #0xc0]
               	ldrb	w17, [x1, #0x42]
               	str	x17, [sp, #0xb8]
               	ldrb	w17, [x1, #0x43]
               	str	x17, [sp, #0xb0]
               	ldrb	w17, [x1, #0x44]
               	str	x17, [sp, #0xa8]
               	ldrb	w17, [x1, #0x45]
               	str	x17, [sp, #0xa0]
               	ldrb	w17, [x1, #0x46]
               	str	x17, [sp, #0x98]
               	ldrb	w17, [x1, #0x47]
               	str	x17, [sp, #0x90]
               	ldrb	w17, [x1, #0x48]
               	str	x17, [sp, #0x88]
               	ldrb	w17, [x1, #0x49]
               	str	x17, [sp, #0x80]
               	ldrb	w17, [x1, #0x4a]
               	str	x17, [sp, #0x78]
               	ldrb	w17, [x1, #0x4b]
               	str	x17, [sp, #0x70]
               	ldrb	w17, [x1, #0x4c]
               	str	x17, [sp, #0x68]
               	ldrb	w17, [x1, #0x4d]
               	str	x17, [sp, #0x60]
               	ldrb	w17, [x1, #0x4e]
               	str	x17, [sp, #0x58]
               	ldrb	w1, [x1, #0x4f]
               	strb	w2, [x0]
               	strb	w3, [x0, #0x1]
               	strb	w4, [x0, #0x2]
               	strb	w5, [x0, #0x3]
               	strb	w6, [x0, #0x4]
               	strb	w7, [x0, #0x5]
               	strb	w8, [x0, #0x6]
               	strb	w9, [x0, #0x7]
               	strb	w10, [x0, #0x8]
               	strb	w11, [x0, #0x9]
               	strb	w12, [x0, #0xa]
               	strb	w13, [x0, #0xb]
               	strb	w14, [x0, #0xc]
               	strb	w15, [x0, #0xd]
               	strb	w20, [x0, #0xe]
               	strb	w21, [x0, #0xf]
               	strb	w25, [x0, #0x10]
               	strb	w26, [x0, #0x11]
               	strb	w27, [x0, #0x12]
               	strb	w28, [x0, #0x13]
               	ldr	x17, [sp, #0x228]
               	strb	w17, [x0, #0x14]
               	ldr	x17, [sp, #0x220]
               	strb	w17, [x0, #0x15]
               	ldr	x17, [sp, #0x218]
               	strb	w17, [x0, #0x16]
               	ldr	x17, [sp, #0x210]
               	strb	w17, [x0, #0x17]
               	ldr	x17, [sp, #0x208]
               	strb	w17, [x0, #0x18]
               	ldr	x17, [sp, #0x200]
               	strb	w17, [x0, #0x19]
               	ldr	x17, [sp, #0x1f8]
               	strb	w17, [x0, #0x1a]
               	ldr	x17, [sp, #0x1f0]
               	strb	w17, [x0, #0x1b]
               	ldr	x17, [sp, #0x1e8]
               	strb	w17, [x0, #0x1c]
               	ldr	x17, [sp, #0x1e0]
               	strb	w17, [x0, #0x1d]
               	ldr	x17, [sp, #0x1d8]
               	strb	w17, [x0, #0x1e]
               	ldr	x17, [sp, #0x1d0]
               	strb	w17, [x0, #0x1f]
               	ldr	x17, [sp, #0x1c8]
               	strb	w17, [x0, #0x20]
               	ldr	x17, [sp, #0x1c0]
               	strb	w17, [x0, #0x21]
               	ldr	x17, [sp, #0x1b8]
               	strb	w17, [x0, #0x22]
               	ldr	x17, [sp, #0x1b0]
               	strb	w17, [x0, #0x23]
               	ldr	x17, [sp, #0x1a8]
               	strb	w17, [x0, #0x24]
               	ldr	x17, [sp, #0x1a0]
               	strb	w17, [x0, #0x25]
               	ldr	x17, [sp, #0x198]
               	strb	w17, [x0, #0x26]
               	ldr	x17, [sp, #0x190]
               	strb	w17, [x0, #0x27]
               	ldr	x17, [sp, #0x188]
               	strb	w17, [x0, #0x28]
               	ldr	x17, [sp, #0x180]
               	strb	w17, [x0, #0x29]
               	ldr	x17, [sp, #0x178]
               	strb	w17, [x0, #0x2a]
               	ldr	x17, [sp, #0x170]
               	strb	w17, [x0, #0x2b]
               	ldr	x17, [sp, #0x168]
               	strb	w17, [x0, #0x2c]
               	ldr	x17, [sp, #0x160]
               	strb	w17, [x0, #0x2d]
               	ldr	x17, [sp, #0x158]
               	strb	w17, [x0, #0x2e]
               	ldr	x17, [sp, #0x150]
               	strb	w17, [x0, #0x2f]
               	ldr	x17, [sp, #0x148]
               	strb	w17, [x0, #0x30]
               	ldr	x17, [sp, #0x140]
               	strb	w17, [x0, #0x31]
               	ldr	x17, [sp, #0x138]
               	strb	w17, [x0, #0x32]
               	ldr	x17, [sp, #0x130]
               	strb	w17, [x0, #0x33]
               	ldr	x17, [sp, #0x128]
               	strb	w17, [x0, #0x34]
               	ldr	x17, [sp, #0x120]
               	strb	w17, [x0, #0x35]
               	ldr	x17, [sp, #0x118]
               	strb	w17, [x0, #0x36]
               	ldr	x17, [sp, #0x110]
               	strb	w17, [x0, #0x37]
               	ldr	x17, [sp, #0x108]
               	strb	w17, [x0, #0x38]
               	ldr	x17, [sp, #0x100]
               	strb	w17, [x0, #0x39]
               	ldr	x17, [sp, #0xf8]
               	strb	w17, [x0, #0x3a]
               	ldr	x17, [sp, #0xf0]
               	strb	w17, [x0, #0x3b]
               	ldr	x17, [sp, #0xe8]
               	strb	w17, [x0, #0x3c]
               	ldr	x17, [sp, #0xe0]
               	strb	w17, [x0, #0x3d]
               	ldr	x17, [sp, #0xd8]
               	strb	w17, [x0, #0x3e]
               	ldr	x17, [sp, #0xd0]
               	strb	w17, [x0, #0x3f]
               	ldr	x17, [sp, #0xc8]
               	strb	w17, [x0, #0x40]
               	ldr	x17, [sp, #0xc0]
               	strb	w17, [x0, #0x41]
               	ldr	x17, [sp, #0xb8]
               	strb	w17, [x0, #0x42]
               	ldr	x17, [sp, #0xb0]
               	strb	w17, [x0, #0x43]
               	ldr	x17, [sp, #0xa8]
               	strb	w17, [x0, #0x44]
               	ldr	x17, [sp, #0xa0]
               	strb	w17, [x0, #0x45]
               	ldr	x17, [sp, #0x98]
               	strb	w17, [x0, #0x46]
               	ldr	x17, [sp, #0x90]
               	strb	w17, [x0, #0x47]
               	ldr	x17, [sp, #0x88]
               	strb	w17, [x0, #0x48]
               	ldr	x17, [sp, #0x80]
               	strb	w17, [x0, #0x49]
               	ldr	x17, [sp, #0x78]
               	strb	w17, [x0, #0x4a]
               	ldr	x17, [sp, #0x70]
               	strb	w17, [x0, #0x4b]
               	ldr	x17, [sp, #0x68]
               	strb	w17, [x0, #0x4c]
               	ldr	x17, [sp, #0x60]
               	strb	w17, [x0, #0x4d]
               	ldr	x17, [sp, #0x58]
               	strb	w17, [x0, #0x4e]
               	strb	w1, [x0, #0x4f]
               	sub	x0, x29, #0x448
               	sub	x1, x29, #0x50
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [x0, #0x10]
               	str	x10, [x1, #0x10]
               	ldr	x10, [x0, #0x18]
               	str	x10, [x1, #0x18]
               	ldr	x10, [x0, #0x20]
               	str	x10, [x1, #0x20]
               	ldr	x10, [x0, #0x28]
               	str	x10, [x1, #0x28]
               	ldr	x10, [x0, #0x30]
               	str	x10, [x1, #0x30]
               	ldr	x10, [x0, #0x38]
               	str	x10, [x1, #0x38]
               	ldr	x10, [x0, #0x40]
               	str	x10, [x1, #0x40]
               	ldr	x10, [x0, #0x48]
               	str	x10, [x1, #0x48]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x20, #0x0               // =0
               	b	<addr>
               	sub	x21, x29, #0x50
               	lsl	x0, x20, #4
               	sxtw	x0, w0
               	add	x0, x24, x0
               	bl	<addr>
               	sub	x16, x29, #0x4a8
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x1, x29, #0x4a8
               	mov	x0, x21
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	sub	x8, x29, #0x3f8
               	bl	<addr>
               	sub	x0, x29, #0x3f8
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
               	mov	x0, x21
               	sxtw	x0, w20
               	add	x20, x0, #0x1
               	cmp	w20, w22
               	b.lt	<addr>
               	sub	x0, x29, #0x50
               	sub	x20, x29, #0x3a8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x20]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x20, #0x8]
               	ldr	x10, [x0, #0x10]
               	str	x10, [x20, #0x10]
               	ldr	x10, [x0, #0x18]
               	str	x10, [x20, #0x18]
               	ldr	x10, [x0, #0x20]
               	str	x10, [x20, #0x20]
               	ldr	x10, [x0, #0x28]
               	str	x10, [x20, #0x28]
               	ldr	x10, [x0, #0x30]
               	str	x10, [x20, #0x30]
               	ldr	x10, [x0, #0x38]
               	str	x10, [x20, #0x38]
               	ldr	x10, [x0, #0x40]
               	str	x10, [x20, #0x40]
               	ldr	x10, [x0, #0x48]
               	str	x10, [x20, #0x48]
               	ldr	x10, [sp], #0x10
               	mov	x0, x20
               	add	x0, x23, #0x0
               	add	x1, x20, #0x0
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	add	x0, x23, #0x10
               	add	x1, x20, #0x10
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	add	x0, x23, #0x20
               	add	x1, x20, #0x20
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	add	x0, x23, #0x30
               	add	x1, x20, #0x30
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	add	x0, x23, #0x40
               	sub	x1, x29, #0x3a8
               	add	x1, x1, #0x40
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	sub	x24, x29, #0x198
               	sub	x1, x29, #0x2b8
               	lsl	x0, x22, #4
               	sxtw	x0, w0
               	add	x25, x1, x0
               	mov	x0, #0x8                // =8
               	sub	x23, x0, x22
               	sub	x20, x29, #0x358
               	mov	x0, #0x0                // =0
               	str	x0, [x20]
               	str	x0, [x20, #0x8]
               	str	x0, [x20, #0x10]
               	str	x0, [x20, #0x18]
               	str	x0, [x20, #0x20]
               	str	x0, [x20, #0x28]
               	str	x0, [x20, #0x30]
               	str	x0, [x20, #0x38]
               	str	x0, [x20, #0x40]
               	str	x0, [x20, #0x48]
               	mov	x0, x24
               	bl	<addr>
               	sub	x16, x29, #0x498
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x498
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x20]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x20, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x20
               	add	x0, x24, #0x10
               	bl	<addr>
               	sub	x16, x29, #0x488
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x488
               	sub	x20, x29, #0x358
               	add	x1, x20, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	add	x0, x24, #0x20
               	bl	<addr>
               	sub	x16, x29, #0x478
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x478
               	add	x1, x20, #0x20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	add	x0, x24, #0x30
               	bl	<addr>
               	sub	x16, x29, #0x468
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x468
               	sub	x20, x29, #0x358
               	add	x1, x20, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	add	x0, x24, #0x40
               	bl	<addr>
               	sub	x16, x29, #0x458
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x458
               	add	x1, x20, #0x40
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x1, x29, #0x358
               	sub	x0, x29, #0x448
               	ldrb	w2, [x1]
               	ldrb	w3, [x1, #0x1]
               	ldrb	w4, [x1, #0x2]
               	ldrb	w5, [x1, #0x3]
               	ldrb	w6, [x1, #0x4]
               	ldrb	w7, [x1, #0x5]
               	ldrb	w8, [x1, #0x6]
               	ldrb	w9, [x1, #0x7]
               	ldrb	w10, [x1, #0x8]
               	ldrb	w11, [x1, #0x9]
               	ldrb	w12, [x1, #0xa]
               	ldrb	w13, [x1, #0xb]
               	ldrb	w14, [x1, #0xc]
               	ldrb	w15, [x1, #0xd]
               	ldrb	w20, [x1, #0xe]
               	ldrb	w21, [x1, #0xf]
               	ldrb	w26, [x1, #0x10]
               	ldrb	w27, [x1, #0x11]
               	ldrb	w28, [x1, #0x12]
               	ldrb	w17, [x1, #0x13]
               	str	x17, [sp, #0x228]
               	ldrb	w17, [x1, #0x14]
               	str	x17, [sp, #0x220]
               	ldrb	w17, [x1, #0x15]
               	str	x17, [sp, #0x218]
               	ldrb	w17, [x1, #0x16]
               	str	x17, [sp, #0x210]
               	ldrb	w17, [x1, #0x17]
               	str	x17, [sp, #0x208]
               	ldrb	w17, [x1, #0x18]
               	str	x17, [sp, #0x200]
               	ldrb	w17, [x1, #0x19]
               	str	x17, [sp, #0x1f8]
               	ldrb	w17, [x1, #0x1a]
               	str	x17, [sp, #0x1f0]
               	ldrb	w17, [x1, #0x1b]
               	str	x17, [sp, #0x1e8]
               	ldrb	w17, [x1, #0x1c]
               	str	x17, [sp, #0x1e0]
               	ldrb	w17, [x1, #0x1d]
               	str	x17, [sp, #0x1d8]
               	ldrb	w17, [x1, #0x1e]
               	str	x17, [sp, #0x1d0]
               	ldrb	w17, [x1, #0x1f]
               	str	x17, [sp, #0x1c8]
               	ldrb	w17, [x1, #0x20]
               	str	x17, [sp, #0x1c0]
               	ldrb	w17, [x1, #0x21]
               	str	x17, [sp, #0x1b8]
               	ldrb	w17, [x1, #0x22]
               	str	x17, [sp, #0x1b0]
               	ldrb	w17, [x1, #0x23]
               	str	x17, [sp, #0x1a8]
               	ldrb	w17, [x1, #0x24]
               	str	x17, [sp, #0x1a0]
               	ldrb	w17, [x1, #0x25]
               	str	x17, [sp, #0x198]
               	ldrb	w17, [x1, #0x26]
               	str	x17, [sp, #0x190]
               	ldrb	w17, [x1, #0x27]
               	str	x17, [sp, #0x188]
               	ldrb	w17, [x1, #0x28]
               	str	x17, [sp, #0x180]
               	ldrb	w17, [x1, #0x29]
               	str	x17, [sp, #0x178]
               	ldrb	w17, [x1, #0x2a]
               	str	x17, [sp, #0x170]
               	ldrb	w17, [x1, #0x2b]
               	str	x17, [sp, #0x168]
               	ldrb	w17, [x1, #0x2c]
               	str	x17, [sp, #0x160]
               	ldrb	w17, [x1, #0x2d]
               	str	x17, [sp, #0x158]
               	ldrb	w17, [x1, #0x2e]
               	str	x17, [sp, #0x150]
               	ldrb	w17, [x1, #0x2f]
               	str	x17, [sp, #0x148]
               	ldrb	w17, [x1, #0x30]
               	str	x17, [sp, #0x140]
               	ldrb	w17, [x1, #0x31]
               	str	x17, [sp, #0x138]
               	ldrb	w17, [x1, #0x32]
               	str	x17, [sp, #0x130]
               	ldrb	w17, [x1, #0x33]
               	str	x17, [sp, #0x128]
               	ldrb	w17, [x1, #0x34]
               	str	x17, [sp, #0x120]
               	ldrb	w17, [x1, #0x35]
               	str	x17, [sp, #0x118]
               	ldrb	w17, [x1, #0x36]
               	str	x17, [sp, #0x110]
               	ldrb	w17, [x1, #0x37]
               	str	x17, [sp, #0x108]
               	ldrb	w17, [x1, #0x38]
               	str	x17, [sp, #0x100]
               	ldrb	w17, [x1, #0x39]
               	str	x17, [sp, #0xf8]
               	ldrb	w17, [x1, #0x3a]
               	str	x17, [sp, #0xf0]
               	ldrb	w17, [x1, #0x3b]
               	str	x17, [sp, #0xe8]
               	ldrb	w17, [x1, #0x3c]
               	str	x17, [sp, #0xe0]
               	ldrb	w17, [x1, #0x3d]
               	str	x17, [sp, #0xd8]
               	ldrb	w17, [x1, #0x3e]
               	str	x17, [sp, #0xd0]
               	ldrb	w17, [x1, #0x3f]
               	str	x17, [sp, #0xc8]
               	ldrb	w17, [x1, #0x40]
               	str	x17, [sp, #0xc0]
               	ldrb	w17, [x1, #0x41]
               	str	x17, [sp, #0xb8]
               	ldrb	w17, [x1, #0x42]
               	str	x17, [sp, #0xb0]
               	ldrb	w17, [x1, #0x43]
               	str	x17, [sp, #0xa8]
               	ldrb	w17, [x1, #0x44]
               	str	x17, [sp, #0xa0]
               	ldrb	w17, [x1, #0x45]
               	str	x17, [sp, #0x98]
               	ldrb	w17, [x1, #0x46]
               	str	x17, [sp, #0x90]
               	ldrb	w17, [x1, #0x47]
               	str	x17, [sp, #0x88]
               	ldrb	w17, [x1, #0x48]
               	str	x17, [sp, #0x80]
               	ldrb	w17, [x1, #0x49]
               	str	x17, [sp, #0x78]
               	ldrb	w17, [x1, #0x4a]
               	str	x17, [sp, #0x70]
               	ldrb	w17, [x1, #0x4b]
               	str	x17, [sp, #0x68]
               	ldrb	w17, [x1, #0x4c]
               	str	x17, [sp, #0x60]
               	ldrb	w17, [x1, #0x4d]
               	str	x17, [sp, #0x58]
               	ldrb	w17, [x1, #0x4e]
               	str	x17, [sp, #0x50]
               	ldrb	w1, [x1, #0x4f]
               	strb	w2, [x0]
               	strb	w3, [x0, #0x1]
               	strb	w4, [x0, #0x2]
               	strb	w5, [x0, #0x3]
               	strb	w6, [x0, #0x4]
               	strb	w7, [x0, #0x5]
               	strb	w8, [x0, #0x6]
               	strb	w9, [x0, #0x7]
               	strb	w10, [x0, #0x8]
               	strb	w11, [x0, #0x9]
               	strb	w12, [x0, #0xa]
               	strb	w13, [x0, #0xb]
               	strb	w14, [x0, #0xc]
               	strb	w15, [x0, #0xd]
               	strb	w20, [x0, #0xe]
               	strb	w21, [x0, #0xf]
               	strb	w26, [x0, #0x10]
               	strb	w27, [x0, #0x11]
               	strb	w28, [x0, #0x12]
               	ldr	x17, [sp, #0x228]
               	strb	w17, [x0, #0x13]
               	ldr	x17, [sp, #0x220]
               	strb	w17, [x0, #0x14]
               	ldr	x17, [sp, #0x218]
               	strb	w17, [x0, #0x15]
               	ldr	x17, [sp, #0x210]
               	strb	w17, [x0, #0x16]
               	ldr	x17, [sp, #0x208]
               	strb	w17, [x0, #0x17]
               	ldr	x17, [sp, #0x200]
               	strb	w17, [x0, #0x18]
               	ldr	x17, [sp, #0x1f8]
               	strb	w17, [x0, #0x19]
               	ldr	x17, [sp, #0x1f0]
               	strb	w17, [x0, #0x1a]
               	ldr	x17, [sp, #0x1e8]
               	strb	w17, [x0, #0x1b]
               	ldr	x17, [sp, #0x1e0]
               	strb	w17, [x0, #0x1c]
               	ldr	x17, [sp, #0x1d8]
               	strb	w17, [x0, #0x1d]
               	ldr	x17, [sp, #0x1d0]
               	strb	w17, [x0, #0x1e]
               	ldr	x17, [sp, #0x1c8]
               	strb	w17, [x0, #0x1f]
               	ldr	x17, [sp, #0x1c0]
               	strb	w17, [x0, #0x20]
               	ldr	x17, [sp, #0x1b8]
               	strb	w17, [x0, #0x21]
               	ldr	x17, [sp, #0x1b0]
               	strb	w17, [x0, #0x22]
               	ldr	x17, [sp, #0x1a8]
               	strb	w17, [x0, #0x23]
               	ldr	x17, [sp, #0x1a0]
               	strb	w17, [x0, #0x24]
               	ldr	x17, [sp, #0x198]
               	strb	w17, [x0, #0x25]
               	ldr	x17, [sp, #0x190]
               	strb	w17, [x0, #0x26]
               	ldr	x17, [sp, #0x188]
               	strb	w17, [x0, #0x27]
               	ldr	x17, [sp, #0x180]
               	strb	w17, [x0, #0x28]
               	ldr	x17, [sp, #0x178]
               	strb	w17, [x0, #0x29]
               	ldr	x17, [sp, #0x170]
               	strb	w17, [x0, #0x2a]
               	ldr	x17, [sp, #0x168]
               	strb	w17, [x0, #0x2b]
               	ldr	x17, [sp, #0x160]
               	strb	w17, [x0, #0x2c]
               	ldr	x17, [sp, #0x158]
               	strb	w17, [x0, #0x2d]
               	ldr	x17, [sp, #0x150]
               	strb	w17, [x0, #0x2e]
               	ldr	x17, [sp, #0x148]
               	strb	w17, [x0, #0x2f]
               	ldr	x17, [sp, #0x140]
               	strb	w17, [x0, #0x30]
               	ldr	x17, [sp, #0x138]
               	strb	w17, [x0, #0x31]
               	ldr	x17, [sp, #0x130]
               	strb	w17, [x0, #0x32]
               	ldr	x17, [sp, #0x128]
               	strb	w17, [x0, #0x33]
               	ldr	x17, [sp, #0x120]
               	strb	w17, [x0, #0x34]
               	ldr	x17, [sp, #0x118]
               	strb	w17, [x0, #0x35]
               	ldr	x17, [sp, #0x110]
               	strb	w17, [x0, #0x36]
               	ldr	x17, [sp, #0x108]
               	strb	w17, [x0, #0x37]
               	ldr	x17, [sp, #0x100]
               	strb	w17, [x0, #0x38]
               	ldr	x17, [sp, #0xf8]
               	strb	w17, [x0, #0x39]
               	ldr	x17, [sp, #0xf0]
               	strb	w17, [x0, #0x3a]
               	ldr	x17, [sp, #0xe8]
               	strb	w17, [x0, #0x3b]
               	ldr	x17, [sp, #0xe0]
               	strb	w17, [x0, #0x3c]
               	ldr	x17, [sp, #0xd8]
               	strb	w17, [x0, #0x3d]
               	ldr	x17, [sp, #0xd0]
               	strb	w17, [x0, #0x3e]
               	ldr	x17, [sp, #0xc8]
               	strb	w17, [x0, #0x3f]
               	ldr	x17, [sp, #0xc0]
               	strb	w17, [x0, #0x40]
               	ldr	x17, [sp, #0xb8]
               	strb	w17, [x0, #0x41]
               	ldr	x17, [sp, #0xb0]
               	strb	w17, [x0, #0x42]
               	ldr	x17, [sp, #0xa8]
               	strb	w17, [x0, #0x43]
               	ldr	x17, [sp, #0xa0]
               	strb	w17, [x0, #0x44]
               	ldr	x17, [sp, #0x98]
               	strb	w17, [x0, #0x45]
               	ldr	x17, [sp, #0x90]
               	strb	w17, [x0, #0x46]
               	ldr	x17, [sp, #0x88]
               	strb	w17, [x0, #0x47]
               	ldr	x17, [sp, #0x80]
               	strb	w17, [x0, #0x48]
               	ldr	x17, [sp, #0x78]
               	strb	w17, [x0, #0x49]
               	ldr	x17, [sp, #0x70]
               	strb	w17, [x0, #0x4a]
               	ldr	x17, [sp, #0x68]
               	strb	w17, [x0, #0x4b]
               	ldr	x17, [sp, #0x60]
               	strb	w17, [x0, #0x4c]
               	ldr	x17, [sp, #0x58]
               	strb	w17, [x0, #0x4d]
               	ldr	x17, [sp, #0x50]
               	strb	w17, [x0, #0x4e]
               	strb	w1, [x0, #0x4f]
               	sub	x0, x29, #0x448
               	sub	x1, x29, #0x50
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [x0, #0x10]
               	str	x10, [x1, #0x10]
               	ldr	x10, [x0, #0x18]
               	str	x10, [x1, #0x18]
               	ldr	x10, [x0, #0x20]
               	str	x10, [x1, #0x20]
               	ldr	x10, [x0, #0x28]
               	str	x10, [x1, #0x28]
               	ldr	x10, [x0, #0x30]
               	str	x10, [x1, #0x30]
               	ldr	x10, [x0, #0x38]
               	str	x10, [x1, #0x38]
               	ldr	x10, [x0, #0x40]
               	str	x10, [x1, #0x40]
               	ldr	x10, [x0, #0x48]
               	str	x10, [x1, #0x48]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x20, #0x0               // =0
               	b	<addr>
               	sub	x21, x29, #0x50
               	lsl	x0, x20, #4
               	sxtw	x0, w0
               	add	x0, x25, x0
               	bl	<addr>
               	sub	x16, x29, #0x4a8
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x1, x29, #0x4a8
               	mov	x0, x21
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	sub	x8, x29, #0x3f8
               	bl	<addr>
               	sub	x0, x29, #0x3f8
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
               	mov	x0, x21
               	sxtw	x0, w20
               	add	x20, x0, #0x1
               	cmp	w20, w23
               	b.lt	<addr>
               	sub	x0, x29, #0x50
               	sub	x20, x29, #0x3a8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x20]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x20, #0x8]
               	ldr	x10, [x0, #0x10]
               	str	x10, [x20, #0x10]
               	ldr	x10, [x0, #0x18]
               	str	x10, [x20, #0x18]
               	ldr	x10, [x0, #0x20]
               	str	x10, [x20, #0x20]
               	ldr	x10, [x0, #0x28]
               	str	x10, [x20, #0x28]
               	ldr	x10, [x0, #0x30]
               	str	x10, [x20, #0x30]
               	ldr	x10, [x0, #0x38]
               	str	x10, [x20, #0x38]
               	ldr	x10, [x0, #0x40]
               	str	x10, [x20, #0x40]
               	ldr	x10, [x0, #0x48]
               	str	x10, [x20, #0x48]
               	ldr	x10, [sp], #0x10
               	mov	x0, x20
               	add	x0, x24, #0x0
               	add	x1, x20, #0x0
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	add	x0, x24, #0x10
               	add	x1, x20, #0x10
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	add	x0, x24, #0x20
               	add	x1, x20, #0x20
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	add	x0, x24, #0x30
               	add	x1, x20, #0x30
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	add	x0, x24, #0x40
               	sub	x1, x29, #0x3a8
               	add	x1, x1, #0x40
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x198
               	sxtw	x1, w0
               	add	x2, x2, x1
               	ldrb	w2, [x2]
               	sub	x3, x29, #0x1e8
               	add	x1, x3, x1
               	ldrb	w1, [x1]
               	cmp	w2, w1
               	b.ne	<addr>
               	sxtw	x0, w0
               	add	x0, x0, #0x1
               	cmp	w0, #0x50
               	b.lt	<addr>
               	sxtw	x0, w22
               	add	x22, x0, #0x1
               	cmp	w22, #0x8
               	b.le	<addr>
               	sub	x0, x29, #0x308
               	bl	<addr>
               	sub	x16, x29, #0x318
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x318
               	sub	x1, x29, #0x478
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x308
               	add	x0, x0, #0x10
               	bl	<addr>
               	sub	x16, x29, #0x318
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x318
               	sub	x1, x29, #0x468
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x308
               	add	x0, x0, #0x20
               	bl	<addr>
               	sub	x16, x29, #0x318
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x318
               	sub	x1, x29, #0x458
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x308
               	add	x0, x0, #0x30
               	bl	<addr>
               	sub	x16, x29, #0x318
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x318
               	sub	x1, x29, #0x408
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x22, x29, #0x308
               	add	x0, x22, #0x40
               	bl	<addr>
               	sub	x16, x29, #0x318
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x1, x29, #0x318
               	sub	x0, x29, #0x3b8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	sub	x21, x29, #0x148
               	mov	x20, #0x0               // =0
               	str	x20, [x21]
               	str	x20, [x21, #0x8]
               	str	x20, [x21, #0x10]
               	str	x20, [x21, #0x18]
               	str	x20, [x21, #0x20]
               	str	x20, [x21, #0x28]
               	str	x20, [x21, #0x30]
               	str	x20, [x21, #0x38]
               	str	x20, [x21, #0x40]
               	str	x20, [x21, #0x48]
               	sub	x1, x29, #0x478
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x21]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x21, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x21
               	sub	x1, x29, #0x468
               	add	x2, x21, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x2
               	sub	x1, x29, #0x458
               	add	x2, x21, #0x20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x2
               	sub	x1, x29, #0x408
               	add	x2, x21, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x2
               	add	x1, x21, #0x40
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x2b8
               	bl	<addr>
               	sub	x16, x29, #0x3b8
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x1, x29, #0x3b8
               	mov	x0, x21
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	sub	x8, x29, #0x358
               	bl	<addr>
               	sub	x1, x29, #0x358
               	sub	x21, x29, #0xf8
               	sub	x0, x29, #0x3a8
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
               	mov	x1, x0
               	add	x1, x21, #0x0
               	add	x0, x0, #0x0
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	add	x0, x21, #0x10
               	sub	x1, x29, #0x3a8
               	add	x1, x1, #0x10
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	add	x0, x21, #0x20
               	sub	x1, x29, #0x3a8
               	add	x1, x1, #0x20
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	add	x0, x21, #0x30
               	sub	x1, x29, #0x3a8
               	add	x1, x1, #0x30
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	add	x0, x21, #0x40
               	sub	x1, x29, #0x3a8
               	add	x1, x1, #0x40
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	b	<addr>
               	sub	x4, x29, #0xa0
               	sxtw	x0, w20
               	lsl	x5, x0, #4
               	add	x2, x4, x5
               	add	x6, x2, #0x0
               	lsl	x1, x20, #4
               	add	x3, x1, #0x0
               	sxtw	x3, w3
               	add	x3, x22, x3
               	ldrb	w3, [x3]
               	strb	w3, [x6]
               	add	x3, x1, #0x1
               	sxtw	x3, w3
               	add	x3, x22, x3
               	ldrb	w3, [x3]
               	strb	w3, [x2, #0x1]
               	sub	x3, x29, #0x308
               	add	x6, x1, #0x2
               	sxtw	x6, w6
               	add	x6, x3, x6
               	ldrb	w6, [x6]
               	strb	w6, [x2, #0x2]
               	add	x6, x1, #0x3
               	sxtw	x6, w6
               	add	x6, x3, x6
               	ldrb	w6, [x6]
               	strb	w6, [x2, #0x3]
               	add	x1, x1, #0x4
               	sxtw	x1, w1
               	add	x1, x3, x1
               	ldrb	w1, [x1]
               	strb	w1, [x2, #0x4]
               	sub	x5, x29, #0xa0
               	lsl	x4, x0, #4
               	add	x2, x5, x4
               	lsl	x1, x20, #4
               	add	x6, x1, #0x5
               	sxtw	x6, w6
               	add	x6, x3, x6
               	ldrb	w6, [x6]
               	strb	w6, [x2, #0x5]
               	add	x6, x1, #0x6
               	sxtw	x6, w6
               	add	x6, x3, x6
               	ldrb	w6, [x6]
               	strb	w6, [x2, #0x6]
               	add	x6, x1, #0x7
               	sxtw	x6, w6
               	add	x3, x3, x6
               	ldrb	w3, [x3]
               	strb	w3, [x2, #0x7]
               	sub	x3, x29, #0x308
               	add	x5, x1, #0x8
               	sxtw	x5, w5
               	add	x5, x3, x5
               	ldrb	w5, [x5]
               	strb	w5, [x2, #0x8]
               	sub	x5, x29, #0xa0
               	add	x2, x5, x4
               	add	x1, x1, #0x9
               	sxtw	x1, w1
               	add	x1, x3, x1
               	ldrb	w1, [x1]
               	strb	w1, [x2, #0x9]
               	lsl	x4, x0, #4
               	add	x2, x5, x4
               	lsl	x1, x20, #4
               	add	x6, x1, #0xa
               	sxtw	x6, w6
               	add	x6, x3, x6
               	ldrb	w6, [x6]
               	strb	w6, [x2, #0xa]
               	add	x6, x1, #0xb
               	sxtw	x6, w6
               	add	x6, x3, x6
               	ldrb	w6, [x6]
               	strb	w6, [x2, #0xb]
               	add	x6, x1, #0xc
               	sxtw	x6, w6
               	add	x6, x3, x6
               	ldrb	w6, [x6]
               	strb	w6, [x2, #0xc]
               	add	x1, x1, #0xd
               	sxtw	x1, w1
               	add	x1, x3, x1
               	ldrb	w1, [x1]
               	strb	w1, [x2, #0xd]
               	sub	x2, x29, #0xa0
               	add	x3, x2, x4
               	sub	x4, x29, #0x308
               	lsl	x1, x20, #4
               	add	x5, x1, #0xe
               	sxtw	x5, w5
               	add	x5, x4, x5
               	ldrb	w5, [x5]
               	strb	w5, [x3, #0xe]
               	lsl	x3, x0, #4
               	add	x2, x2, x3
               	add	x1, x1, #0xf
               	sxtw	x1, w1
               	add	x1, x4, x1
               	ldrb	w1, [x1]
               	strb	w1, [x2, #0xf]
               	add	x20, x0, #0x1
               	cmp	w20, #0x5
               	b.lt	<addr>
               	sub	x20, x29, #0xa0
               	sub	x1, x29, #0x2b8
               	mov	x0, x20
               	bl	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x3, x29, #0xf8
               	lsl	x2, x1, #4
               	add	x2, x2, x0
               	sxtw	x2, w2
               	add	x2, x3, x2
               	ldrb	w3, [x2]
               	sxtw	x2, w1
               	lsl	x2, x2, #4
               	add	x4, x20, x2
               	sxtw	x2, w0
               	add	x4, x4, x2
               	ldrb	w4, [x4]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x2, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sxtw	x0, w1
               	add	x1, x0, #0x1
               	cmp	w1, #0x5
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x6e0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x14               // =20
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x6e0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x22, #0x2
               	sxtw	x0, w0
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x6e0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x6e0
               	ldp	x29, x30, [sp], #0x10
               	ret
