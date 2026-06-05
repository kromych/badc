
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
               	sub	sp, sp, #0x50
               	mov	x4, #0x0                // =0
               	stur	w4, [x29, #-0x48]
               	b	<addr>
               	ldursw	x4, [x29, #-0x48]
               	cmp	x4, #0x4
               	b.ge	<addr>
               	b	<addr>
               	sub	x4, x29, #0x48
               	ldrsw	x5, [x4]
               	add	x5, x5, #0x1
               	str	w5, [x4]
               	b	<addr>
               	sub	x4, x29, #0x40
               	ldursw	x5, [x29, #-0x48]
               	mov	x17, #0x5               // =5
               	mul	x6, x5, x17
               	sxtw	x6, w6
               	lsl	x6, x6, #2
               	add	x4, x4, x6
               	lsl	x5, x5, #2
               	sxtw	x5, w5
               	add	x5, x3, x5
               	add	x6, x5, #0x3
               	ldrb	w6, [x6]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x6, x6, x17
               	lsl	x6, x6, #8
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x6, x6, x17
               	add	x7, x5, #0x2
               	ldrb	w7, [x7]
               	orr	x6, x6, x7
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x6, x6, x17
               	lsl	x6, x6, #8
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x6, x6, x17
               	add	x7, x5, #0x1
               	ldrb	w7, [x7]
               	orr	x6, x6, x7
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x6, x6, x17
               	lsl	x6, x6, #8
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x6, x6, x17
               	ldrb	w5, [x5]
               	orr	x5, x6, x5
               	str	w5, [x4]
               	sub	x4, x29, #0x40
               	ldursw	x5, [x29, #-0x48]
               	add	x6, x5, #0x1
               	sxtw	x6, w6
               	lsl	x6, x6, #2
               	add	x4, x4, x6
               	lsl	x5, x5, #2
               	sxtw	x5, w5
               	add	x5, x2, x5
               	add	x6, x5, #0x3
               	ldrb	w6, [x6]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x6, x6, x17
               	lsl	x6, x6, #8
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x6, x6, x17
               	add	x7, x5, #0x2
               	ldrb	w7, [x7]
               	orr	x6, x6, x7
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x6, x6, x17
               	lsl	x6, x6, #8
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x6, x6, x17
               	add	x7, x5, #0x1
               	ldrb	w7, [x7]
               	orr	x6, x6, x7
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x6, x6, x17
               	lsl	x6, x6, #8
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x6, x6, x17
               	ldrb	w5, [x5]
               	orr	x5, x6, x5
               	str	w5, [x4]
               	sub	x4, x29, #0x40
               	ldursw	x5, [x29, #-0x48]
               	add	x6, x5, #0x6
               	sxtw	x6, w6
               	lsl	x6, x6, #2
               	add	x4, x4, x6
               	lsl	x5, x5, #2
               	sxtw	x5, w5
               	add	x5, x1, x5
               	add	x6, x5, #0x3
               	ldrb	w6, [x6]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x6, x6, x17
               	lsl	x6, x6, #8
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x6, x6, x17
               	add	x7, x5, #0x2
               	ldrb	w7, [x7]
               	orr	x6, x6, x7
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x6, x6, x17
               	lsl	x6, x6, #8
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x6, x6, x17
               	add	x7, x5, #0x1
               	ldrb	w7, [x7]
               	orr	x6, x6, x7
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x6, x6, x17
               	lsl	x6, x6, #8
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x6, x6, x17
               	ldrb	w5, [x5]
               	orr	x5, x6, x5
               	str	w5, [x4]
               	sub	x4, x29, #0x40
               	ldursw	x5, [x29, #-0x48]
               	add	x6, x5, #0xb
               	sxtw	x6, w6
               	lsl	x6, x6, #2
               	add	x4, x4, x6
               	add	x6, x2, #0x10
               	lsl	x5, x5, #2
               	sxtw	x5, w5
               	add	x5, x6, x5
               	add	x6, x5, #0x3
               	ldrb	w6, [x6]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x6, x6, x17
               	lsl	x6, x6, #8
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x6, x6, x17
               	add	x7, x5, #0x2
               	ldrb	w7, [x7]
               	orr	x6, x6, x7
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x6, x6, x17
               	lsl	x6, x6, #8
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x6, x6, x17
               	add	x7, x5, #0x1
               	ldrb	w7, [x7]
               	orr	x6, x6, x7
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x6, x6, x17
               	lsl	x6, x6, #8
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x6, x6, x17
               	ldrb	w5, [x5]
               	orr	x5, x6, x5
               	str	w5, [x4]
               	b	<addr>
               	mov	x1, #0x0                // =0
               	sub	x2, x29, #0x40
               	ldr	w2, [x2]
               	sub	x3, x29, #0x40
               	add	x3, x3, #0x14
               	ldr	w3, [x3]
               	eor	x2, x2, x3
               	sub	x3, x29, #0x40
               	add	x3, x3, #0x28
               	ldr	w3, [x3]
               	eor	x2, x2, x3
               	sub	x3, x29, #0x40
               	add	x3, x3, #0x3c
               	ldr	w3, [x3]
               	eor	x2, x2, x3
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	strb	w2, [x0]
               	mov	x0, x1
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x40]
               	b	<addr>
               	ldursw	x0, [x29, #-0x40]
               	cmp	x0, #0x10
               	b.ge	<addr>
               	b	<addr>
               	sub	x0, x29, #0x40
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	b	<addr>
               	sub	x0, x29, #0x18
               	ldursw	x1, [x29, #-0x40]
               	add	x0, x0, x1
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	strb	w1, [x0]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x40]
               	b	<addr>
               	ldursw	x0, [x29, #-0x40]
               	cmp	x0, #0x20
               	b.ge	<addr>
               	b	<addr>
               	sub	x0, x29, #0x40
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	b	<addr>
               	sub	x0, x29, #0x38
               	ldursw	x1, [x29, #-0x40]
               	add	x0, x0, x1
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	strb	w1, [x0]
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
