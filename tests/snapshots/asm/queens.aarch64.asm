
queens.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400444 <.text+0x224>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x15, x0
               	sxtw	x14, w1
               	sxtw	x13, w2
               	mov	x12, #0x0               // =0
               	stur	w12, [x29, #-0x8]
               	b	0x40025c <.text+0x3c>
               	ldursw	x12, [x29, #-0x8]
               	cmp	x12, x14
               	b.ge	0x4002b8 <.text+0x98>
               	b	0x400280 <.text+0x60>
               	ldursw	x12, [x29, #-0x8]
               	add	x11, x12, #0x1
               	sxtw	x11, w11
               	stur	w11, [x29, #-0x8]
               	b	0x40025c <.text+0x3c>
               	ldursw	x11, [x29, #-0x8]
               	sub	x12, x14, x11
               	sxtw	x12, w12
               	stur	w12, [x29, #-0x10]
               	lsl	x10, x11, #2
               	add	x11, x15, x10
               	ldrsw	x10, [x11]
               	sub	x11, x13, x10
               	sxtw	x11, w11
               	stur	w11, [x29, #-0x18]
               	ldursw	x10, [x29, #-0x18]
               	cmp	x10, #0x0
               	b.ge	0x4002ec <.text+0xcc>
               	b	0x4002cc <.text+0xac>
               	mov	x12, #0x0               // =0
               	mov	x0, x12
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x10, [x29, #-0x18]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x11, x10, x17
               	stur	w11, [x29, #-0x18]
               	b	0x4002ec <.text+0xcc>
               	ldursw	x11, [x29, #-0x8]
               	lsl	x10, x11, #2
               	add	x11, x15, x10
               	ldrsw	x10, [x11]
               	cmp	x10, x13
               	b.ne	0x400314 <.text+0xf4>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x11, [x29, #-0x10]
               	ldursw	x0, [x29, #-0x18]
               	cmp	x11, x0
               	b.ne	0x400334 <.text+0x114>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x40026c <.text+0x4c>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	mov	x20, x0
               	sxtw	x21, w1
               	cmp	x21, #0x8
               	b.ne	0x400390 <.text+0x170>
               	mov	x12, #0x1               // =1
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x13, #0x0               // =0
               	stur	w13, [x29, #-0x8]
               	stur	w13, [x29, #-0x10]
               	b	0x4003a0 <.text+0x180>
               	ldursw	x13, [x29, #-0x10]
               	cmp	x13, #0x8
               	b.ge	0x4003e0 <.text+0x1c0>
               	b	0x4003c4 <.text+0x1a4>
               	ldursw	x13, [x29, #-0x10]
               	add	x12, x13, #0x1
               	sxtw	x12, w12
               	stur	w12, [x29, #-0x10]
               	b	0x4003a0 <.text+0x180>
               	ldursw	x22, [x29, #-0x10]
               	mov	x0, x20
               	mov	x2, x22
               	mov	x1, x21
               	bl	0x400238 <.text+0x18>
               	cbz	x0, 0x40040c <.text+0x1ec>
               	b	0x400408 <.text+0x1e8>
               	ldursw	x24, [x29, #-0x8]
               	mov	x0, x24
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x4003b0 <.text+0x190>
               	lsl	x22, x21, #2
               	add	x0, x20, x22
               	ldursw	x22, [x29, #-0x10]
               	str	w22, [x0]
               	ldursw	x23, [x29, #-0x8]
               	add	x22, x21, #0x1
               	sxtw	x24, w22
               	mov	x0, x20
               	mov	x1, x24
               	bl	0x400338 <.text+0x118>
               	add	x24, x23, x0
               	sxtw	x24, w24
               	stur	w24, [x29, #-0x8]
               	b	0x4003b0 <.text+0x190>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	sub	x20, x29, #0x20
               	mov	x21, #0x0               // =0
               	mov	x0, x20
               	mov	x1, x21
               	bl	0x400338 <.text+0x118>
               	sxtw	x21, w0
               	cmp	x21, #0x5c
               	b.eq	0x400494 <.text+0x274>
               	mov	x21, #0x1               // =1
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
