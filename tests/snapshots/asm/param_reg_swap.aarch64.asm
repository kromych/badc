
param_reg_swap.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	add	x1, x0, #0x3
               	ldrb	w1, [x1]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	lsl	x1, x1, #8
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	add	x2, x0, #0x2
               	ldrb	w2, [x2]
               	orr	x1, x1, x2
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	lsl	x1, x1, #8
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	add	x2, x0, #0x1
               	ldrb	w2, [x2]
               	orr	x1, x1, x2
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	lsl	x1, x1, #8
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	ldrb	w0, [x0]
               	orr	x0, x1, x0
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	mov	x20, x0
               	mov	x23, x3
               	mov	x22, x2
               	mov	x21, x1
               	mov	x24, #0x0               // =0
               	b	<addr>
               	sxtw	x0, w24
               	cmp	x0, #0x4
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w24
               	add	x24, x0, #0x1
               	b	<addr>
               	sub	x0, x29, #0x40
               	sxtw	x1, w24
               	mov	x17, #0x5               // =5
               	mul	x2, x1, x17
               	sxtw	x2, w2
               	lsl	x2, x2, #2
               	add	x25, x0, x2
               	lsl	x0, x1, #2
               	sxtw	x0, w0
               	add	x0, x23, x0
               	bl	<addr>
               	str	w0, [x25]
               	sub	x0, x29, #0x40
               	sxtw	x1, w24
               	add	x2, x1, #0x1
               	sxtw	x2, w2
               	lsl	x2, x2, #2
               	add	x25, x0, x2
               	lsl	x0, x1, #2
               	sxtw	x0, w0
               	add	x0, x22, x0
               	bl	<addr>
               	str	w0, [x25]
               	sub	x0, x29, #0x40
               	sxtw	x1, w24
               	add	x2, x1, #0x6
               	sxtw	x2, w2
               	lsl	x2, x2, #2
               	add	x25, x0, x2
               	lsl	x0, x1, #2
               	sxtw	x0, w0
               	add	x0, x21, x0
               	bl	<addr>
               	str	w0, [x25]
               	sub	x0, x29, #0x40
               	sxtw	x1, w24
               	add	x2, x1, #0xb
               	sxtw	x2, w2
               	lsl	x2, x2, #2
               	add	x25, x0, x2
               	add	x0, x22, #0x10
               	lsl	x1, x1, #2
               	sxtw	x1, w1
               	add	x0, x0, x1
               	bl	<addr>
               	str	w0, [x25]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x40
               	ldr	w1, [x1]
               	sub	x2, x29, #0x40
               	add	x2, x2, #0x14
               	ldr	w2, [x2]
               	eor	x1, x1, x2
               	sub	x2, x29, #0x40
               	add	x2, x2, #0x28
               	ldr	w2, [x2]
               	eor	x1, x1, x2
               	sub	x2, x29, #0x40
               	add	x2, x2, #0x3c
               	ldr	w2, [x2]
               	eor	x1, x1, x2
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	strb	w1, [x20]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	mov	x1, #0x0                // =0
               	b	<addr>
               	sxtw	x0, w1
               	cmp	x0, #0x10
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w1
               	add	x1, x0, #0x1
               	b	<addr>
               	sub	x0, x29, #0x18
               	sxtw	x2, w1
               	add	x0, x0, x2
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	strb	w2, [x0]
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	sxtw	x0, w1
               	cmp	x0, #0x20
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w1
               	add	x1, x0, #0x1
               	b	<addr>
               	sub	x0, x29, #0x38
               	sxtw	x2, w1
               	add	x0, x0, x2
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	strb	w2, [x0]
               	b	<addr>
               	sub	x0, x29, #0x8
               	sub	x1, x29, #0x18
               	sub	x2, x29, #0x38
               	adrp	x3, <page>
               	add	x3, x3, #0xd0
               	bl	<addr>
               	sub	x0, x29, #0x8
               	ldrb	w0, [x0]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
