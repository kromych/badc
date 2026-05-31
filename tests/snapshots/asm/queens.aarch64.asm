
queens.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400438 <.text+0x218>
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
               	ldursw	x11, [x29, #-0x8]
               	add	x11, x11, #0x1
               	sxtw	x11, w11
               	stur	w11, [x29, #-0x8]
               	b	0x40025c <.text+0x3c>
               	ldursw	x11, [x29, #-0x8]
               	sub	x12, x14, x11
               	sxtw	x12, w12
               	stur	w12, [x29, #-0x10]
               	lsl	x11, x11, #2
               	add	x10, x15, x11
               	ldrsw	x11, [x10]
               	sub	x10, x13, x11
               	sxtw	x10, w10
               	stur	w10, [x29, #-0x18]
               	ldursw	x11, [x29, #-0x18]
               	cmp	x11, #0x0
               	b.ge	0x4002ec <.text+0xcc>
               	b	0x4002cc <.text+0xac>
               	mov	x10, #0x0               // =0
               	mov	x0, x10
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x10, [x29, #-0x18]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x10, x10, x17
               	stur	w10, [x29, #-0x18]
               	b	0x4002ec <.text+0xcc>
               	ldursw	x10, [x29, #-0x8]
               	lsl	x10, x10, #2
               	add	x11, x15, x10
               	ldrsw	x10, [x11]
               	cmp	x10, x13
               	b.ne	0x400314 <.text+0xf4>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x10, [x29, #-0x10]
               	ldursw	x0, [x29, #-0x18]
               	cmp	x10, x0
               	b.ne	0x400334 <.text+0x114>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x40026c <.text+0x4c>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	mov	x20, x0
               	sxtw	x21, w1
               	cmp	x21, #0x8
               	b.ne	0x400388 <.text+0x168>
               	mov	x12, #0x1               // =1
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x13, #0x0               // =0
               	stur	w13, [x29, #-0x8]
               	stur	w13, [x29, #-0x10]
               	b	0x400398 <.text+0x178>
               	ldursw	x13, [x29, #-0x10]
               	cmp	x13, #0x8
               	b.ge	0x4003d8 <.text+0x1b8>
               	b	0x4003bc <.text+0x19c>
               	ldursw	x12, [x29, #-0x10]
               	add	x12, x12, #0x1
               	sxtw	x12, w12
               	stur	w12, [x29, #-0x10]
               	b	0x400398 <.text+0x178>
               	ldursw	x22, [x29, #-0x10]
               	mov	x0, x20
               	mov	x2, x22
               	mov	x1, x21
               	bl	0x400238 <.text+0x18>
               	cbz	x0, 0x400400 <.text+0x1e0>
               	b	0x4003fc <.text+0x1dc>
               	ldursw	x23, [x29, #-0x8]
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x4003a8 <.text+0x188>
               	lsl	x22, x21, #2
               	add	x0, x20, x22
               	ldursw	x22, [x29, #-0x10]
               	str	w22, [x0]
               	ldursw	x23, [x29, #-0x8]
               	add	x22, x21, #0x1
               	sxtw	x22, w22
               	mov	x0, x20
               	mov	x1, x22
               	bl	0x400338 <.text+0x118>
               	add	x23, x23, x0
               	sxtw	x23, w23
               	stur	w23, [x29, #-0x8]
               	b	0x4003a8 <.text+0x188>
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
               	sxtw	x0, w0
               	cmp	x0, #0x5c
               	b.eq	0x400488 <.text+0x268>
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
