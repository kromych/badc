
queens.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sxtw	x1, w1
               	sxtw	x2, w2
               	mov	x12, #0x0               // =0
               	stur	w12, [x29, #-0x8]
               	b	<addr>
               	ldursw	x12, [x29, #-0x8]
               	cmp	x12, x1
               	b.ge	<addr>
               	b	<addr>
               	ldursw	x11, [x29, #-0x8]
               	add	x11, x11, #0x1
               	sxtw	x11, w11
               	stur	w11, [x29, #-0x8]
               	b	<addr>
               	ldursw	x11, [x29, #-0x8]
               	sub	x12, x1, x11
               	sxtw	x12, w12
               	stur	w12, [x29, #-0x10]
               	lsl	x11, x11, #2
               	add	x11, x0, x11
               	ldrsw	x11, [x11]
               	sub	x10, x2, x11
               	sxtw	x10, w10
               	stur	w10, [x29, #-0x18]
               	ldursw	x11, [x29, #-0x18]
               	cmp	x11, #0x0
               	b.ge	<addr>
               	b	<addr>
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
               	b	<addr>
               	ldursw	x10, [x29, #-0x8]
               	lsl	x10, x10, #2
               	add	x10, x0, x10
               	ldrsw	x10, [x10]
               	cmp	x10, x2
               	b.ne	<addr>
               	mov	x11, #0x1               // =1
               	mov	x0, x11
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x10, [x29, #-0x10]
               	ldursw	x11, [x29, #-0x18]
               	cmp	x10, x11
               	b.ne	<addr>
               	mov	x11, #0x1               // =1
               	mov	x0, x11
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	mov	x20, x0
               	sxtw	x21, w1
               	cmp	x21, #0x8
               	b.ne	<addr>
               	mov	x12, #0x1               // =1
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x13, #0x0               // =0
               	stur	w13, [x29, #-0x8]
               	stur	w13, [x29, #-0x10]
               	b	<addr>
               	ldursw	x13, [x29, #-0x10]
               	cmp	x13, #0x8
               	b.ge	<addr>
               	b	<addr>
               	ldursw	x12, [x29, #-0x10]
               	add	x12, x12, #0x1
               	sxtw	x12, w12
               	stur	w12, [x29, #-0x10]
               	b	<addr>
               	ldursw	x2, [x29, #-0x10]
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	cbz	x0, <addr>
               	b	<addr>
               	ldursw	x22, [x29, #-0x8]
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	lsl	x2, x21, #2
               	add	x2, x20, x2
               	ldursw	x0, [x29, #-0x10]
               	str	w0, [x2]
               	ldursw	x22, [x29, #-0x8]
               	add	x0, x21, #0x1
               	sxtw	x1, w0
               	mov	x0, x20
               	bl	<addr>
               	add	x22, x22, x0
               	sxtw	x22, w22
               	stur	w22, [x29, #-0x8]
               	b	<addr>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	x0, x29, #0x20
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	mov	x13, x0
               	sxtw	x13, w13
               	cmp	x13, #0x5c
               	b.eq	<addr>
               	mov	x1, #0x1                // =1
               	mov	x0, x1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x13, #0x0               // =0
               	mov	x0, x13
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
