
aapcs64_variadic_host_abi.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	sub	sp, sp, #0xc0
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	str	x2, [sp, #0x10]
               	str	x3, [sp, #0x18]
               	str	x4, [sp, #0x20]
               	str	x5, [sp, #0x28]
               	str	x6, [sp, #0x30]
               	str	x7, [sp, #0x38]
               	str	d0, [sp, #0x40]
               	str	d1, [sp, #0x50]
               	str	d2, [sp, #0x60]
               	str	d3, [sp, #0x70]
               	str	d4, [sp, #0x80]
               	str	d5, [sp, #0x90]
               	str	d6, [sp, #0xa0]
               	str	d7, [sp, #0xb0]
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	str	x19, [sp]
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x28]
               	sub	x1, x29, #0x20
               	add	x2, x29, #0x10
               	mov	x16, x1
               	add	x17, x29, #0xd0
               	str	x17, [x16]
               	add	x17, x29, #0x50
               	str	x17, [x16, #0x8]
               	add	x17, x29, #0xd0
               	str	x17, [x16, #0x10]
               	mov	x17, #0xffc8            // =65480
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	str	w17, [x16, #0x18]
               	mov	x17, #0xff80            // =65408
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	str	w17, [x16, #0x1c]
               	stur	w0, [x29, #-0x30]
               	b	<addr>
               	ldursw	x0, [x29, #-0x30]
               	ldursw	x1, [x29, #0x10]
               	cmp	x0, x1
               	b.ge	<addr>
               	b	<addr>
               	sub	x0, x29, #0x30
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	b	<addr>
               	sub	x0, x29, #0x28
               	ldrsw	x1, [x0]
               	sub	x2, x29, #0x20
               	mov	x17, x2
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x8]
               	add	x9, x9, x16
               	add	x16, x16, #0x8
               	str	w16, [x17, #0x18]
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x2, x16
               	ldrsw	x2, [x2]
               	add	x1, x1, x2
               	str	w1, [x0]
               	b	<addr>
               	sub	x0, x29, #0x20
               	ldursw	x0, [x29, #-0x28]
               	ldr	x19, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xc0
               	ret
               	sub	sp, sp, #0xc0
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	str	x2, [sp, #0x10]
               	str	x3, [sp, #0x18]
               	str	x4, [sp, #0x20]
               	str	x5, [sp, #0x28]
               	str	x6, [sp, #0x30]
               	str	x7, [sp, #0x38]
               	str	d0, [sp, #0x40]
               	str	d1, [sp, #0x50]
               	str	d2, [sp, #0x60]
               	str	d3, [sp, #0x70]
               	str	d4, [sp, #0x80]
               	str	d5, [sp, #0x90]
               	str	d6, [sp, #0xa0]
               	str	d7, [sp, #0xb0]
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	str	x19, [sp]
               	mov	x0, #0x0                // =0
               	scvtf	d0, x0
               	sub	x17, x29, #0x28
               	str	d0, [x17]
               	sub	x1, x29, #0x20
               	add	x2, x29, #0x10
               	mov	x16, x1
               	add	x17, x29, #0xd0
               	str	x17, [x16]
               	add	x17, x29, #0x50
               	str	x17, [x16, #0x8]
               	add	x17, x29, #0xd0
               	str	x17, [x16, #0x10]
               	mov	x17, #0xffc8            // =65480
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	str	w17, [x16, #0x18]
               	mov	x17, #0xff80            // =65408
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	str	w17, [x16, #0x1c]
               	stur	w0, [x29, #-0x30]
               	b	<addr>
               	ldursw	x0, [x29, #-0x30]
               	ldursw	x1, [x29, #0x10]
               	cmp	x0, x1
               	b.ge	<addr>
               	b	<addr>
               	sub	x0, x29, #0x30
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	b	<addr>
               	sub	x0, x29, #0x28
               	ldr	d0, [x0]
               	sub	x1, x29, #0x20
               	mov	x17, x1
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x10]
               	add	x9, x9, x16
               	add	x16, x16, #0x10
               	str	w16, [x17, #0x1c]
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x1, x16
               	ldr	d1, [x1]
               	fadd	d0, d0, d1
               	str	d0, [x0]
               	b	<addr>
               	sub	x0, x29, #0x20
               	sub	x16, x29, #0x28
               	ldr	d0, [x16]
               	ldr	x19, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xc0
               	ret
               	sub	sp, sp, #0xc0
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	str	x2, [sp, #0x10]
               	str	x3, [sp, #0x18]
               	str	x4, [sp, #0x20]
               	str	x5, [sp, #0x28]
               	str	x6, [sp, #0x30]
               	str	x7, [sp, #0x38]
               	str	d0, [sp, #0x40]
               	str	d1, [sp, #0x50]
               	str	d2, [sp, #0x60]
               	str	d3, [sp, #0x70]
               	str	d4, [sp, #0x80]
               	str	d5, [sp, #0x90]
               	str	d6, [sp, #0xa0]
               	str	d7, [sp, #0xb0]
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	str	x19, [sp]
               	mov	x0, #0x0                // =0
               	scvtf	d0, x0
               	sub	x17, x29, #0x28
               	str	d0, [x17]
               	sub	x1, x29, #0x20
               	add	x2, x29, #0x10
               	mov	x16, x1
               	add	x17, x29, #0xd0
               	str	x17, [x16]
               	add	x17, x29, #0x50
               	str	x17, [x16, #0x8]
               	add	x17, x29, #0xd0
               	str	x17, [x16, #0x10]
               	mov	x17, #0xffc8            // =65480
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	str	w17, [x16, #0x18]
               	mov	x17, #0xff80            // =65408
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	str	w17, [x16, #0x1c]
               	stur	w0, [x29, #-0x30]
               	b	<addr>
               	ldursw	x0, [x29, #-0x30]
               	ldursw	x1, [x29, #0x10]
               	cmp	x0, x1
               	b.ge	<addr>
               	b	<addr>
               	sub	x0, x29, #0x30
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	b	<addr>
               	ldursw	x0, [x29, #-0x30]
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	cbz	x0, <addr>
               	b	<addr>
               	sub	x0, x29, #0x20
               	sub	x16, x29, #0x28
               	ldr	d0, [x16]
               	ldr	x19, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xc0
               	ret
               	sub	x0, x29, #0x28
               	ldr	d0, [x0]
               	sub	x1, x29, #0x20
               	mov	x17, x1
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x10]
               	add	x9, x9, x16
               	add	x16, x16, #0x10
               	str	w16, [x17, #0x1c]
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x1, x16
               	ldr	d1, [x1]
               	fadd	d0, d0, d1
               	str	d0, [x0]
               	b	<addr>
               	b	<addr>
               	sub	x0, x29, #0x28
               	ldr	d0, [x0]
               	sub	x1, x29, #0x20
               	mov	x17, x1
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x8]
               	add	x9, x9, x16
               	add	x16, x16, #0x8
               	str	w16, [x17, #0x18]
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x1, x16
               	ldrsw	x1, [x1]
               	scvtf	d1, x1
               	fadd	d0, d0, d1
               	str	d0, [x0]
               	b	<addr>
               	sub	sp, sp, #0xc0
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	str	x2, [sp, #0x10]
               	str	x3, [sp, #0x18]
               	str	x4, [sp, #0x20]
               	str	x5, [sp, #0x28]
               	str	x6, [sp, #0x30]
               	str	x7, [sp, #0x38]
               	str	d0, [sp, #0x40]
               	str	d1, [sp, #0x50]
               	str	d2, [sp, #0x60]
               	str	d3, [sp, #0x70]
               	str	d4, [sp, #0x80]
               	str	d5, [sp, #0x90]
               	str	d6, [sp, #0xa0]
               	str	d7, [sp, #0xb0]
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	str	x19, [sp]
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x48]
               	sub	x1, x29, #0x20
               	add	x2, x29, #0x10
               	mov	x16, x1
               	add	x17, x29, #0xd0
               	str	x17, [x16]
               	add	x17, x29, #0x50
               	str	x17, [x16, #0x8]
               	add	x17, x29, #0xd0
               	str	x17, [x16, #0x10]
               	mov	x17, #0xffc8            // =65480
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	str	w17, [x16, #0x18]
               	mov	x17, #0xff80            // =65408
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	str	w17, [x16, #0x1c]
               	sub	x1, x29, #0x40
               	sub	x2, x29, #0x20
               	str	x9, [sp, #-0x10]!
               	ldr	x9, [x2]
               	str	x9, [x1]
               	ldr	x9, [x2, #0x8]
               	str	x9, [x1, #0x8]
               	ldr	x9, [x2, #0x10]
               	str	x9, [x1, #0x10]
               	ldr	x9, [x2, #0x18]
               	str	x9, [x1, #0x18]
               	ldr	x9, [sp], #0x10
               	stur	w0, [x29, #-0x50]
               	b	<addr>
               	ldursw	x0, [x29, #-0x50]
               	ldursw	x1, [x29, #0x10]
               	cmp	x0, x1
               	b.ge	<addr>
               	b	<addr>
               	sub	x0, x29, #0x50
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	b	<addr>
               	sub	x0, x29, #0x48
               	ldrsw	x1, [x0]
               	sub	x2, x29, #0x20
               	mov	x17, x2
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x8]
               	add	x9, x9, x16
               	add	x16, x16, #0x8
               	str	w16, [x17, #0x18]
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x2, x16
               	ldrsw	x2, [x2]
               	add	x1, x1, x2
               	str	w1, [x0]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x50]
               	b	<addr>
               	ldursw	x0, [x29, #-0x50]
               	ldursw	x1, [x29, #0x10]
               	cmp	x0, x1
               	b.ge	<addr>
               	b	<addr>
               	sub	x0, x29, #0x50
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	b	<addr>
               	sub	x0, x29, #0x48
               	ldrsw	x1, [x0]
               	sub	x2, x29, #0x40
               	mov	x17, x2
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x8]
               	add	x9, x9, x16
               	add	x16, x16, #0x8
               	str	w16, [x17, #0x18]
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x2, x16
               	ldrsw	x2, [x2]
               	add	x1, x1, x2
               	str	w1, [x0]
               	b	<addr>
               	sub	x0, x29, #0x40
               	sub	x0, x29, #0x20
               	ldursw	x0, [x29, #-0x48]
               	ldr	x19, [sp]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xc0
               	ret
               	sub	sp, sp, #0xc0
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	str	x2, [sp, #0x10]
               	str	x3, [sp, #0x18]
               	str	x4, [sp, #0x20]
               	str	x5, [sp, #0x28]
               	str	x6, [sp, #0x30]
               	str	x7, [sp, #0x38]
               	str	d0, [sp, #0x40]
               	str	d1, [sp, #0x50]
               	str	d2, [sp, #0x60]
               	str	d3, [sp, #0x70]
               	str	d4, [sp, #0x80]
               	str	d5, [sp, #0x90]
               	str	d6, [sp, #0xa0]
               	str	d7, [sp, #0xb0]
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	str	x19, [sp]
               	ldursw	x0, [x29, #0x10]
               	ldursw	x1, [x29, #0x18]
               	add	x0, x0, x1
               	sxtw	x0, w0
               	ldursw	x1, [x29, #0x20]
               	add	x0, x0, x1
               	sxtw	x0, w0
               	ldursw	x1, [x29, #0x28]
               	add	x0, x0, x1
               	sxtw	x0, w0
               	ldursw	x1, [x29, #0x30]
               	add	x0, x0, x1
               	sxtw	x0, w0
               	ldursw	x1, [x29, #0x38]
               	add	x0, x0, x1
               	sxtw	x0, w0
               	ldursw	x1, [x29, #0x40]
               	add	x0, x0, x1
               	sxtw	x0, w0
               	ldursw	x1, [x29, #0x48]
               	add	x0, x0, x1
               	sxtw	x0, w0
               	ldursw	x1, [x29, #0xd0]
               	add	x0, x0, x1
               	sxtw	x0, w0
               	ldursw	x1, [x29, #0xd8]
               	add	x0, x0, x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x28]
               	sub	x0, x29, #0x20
               	add	x1, x29, #0xd8
               	mov	x16, x0
               	add	x17, x29, #0xe0
               	str	x17, [x16]
               	add	x17, x29, #0x50
               	str	x17, [x16, #0x8]
               	add	x17, x29, #0xd0
               	str	x17, [x16, #0x10]
               	mov	x17, #0x0               // =0
               	str	w17, [x16, #0x18]
               	mov	x17, #0xff80            // =65408
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	str	w17, [x16, #0x1c]
               	sub	x0, x29, #0x28
               	ldrsw	x1, [x0]
               	sub	x2, x29, #0x20
               	mov	x17, x2
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x8]
               	add	x9, x9, x16
               	add	x16, x16, #0x8
               	str	w16, [x17, #0x18]
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x2, x16
               	ldrsw	x2, [x2]
               	add	x1, x1, x2
               	str	w1, [x0]
               	sub	x0, x29, #0x28
               	ldrsw	x1, [x0]
               	sub	x2, x29, #0x20
               	mov	x17, x2
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x8]
               	add	x9, x9, x16
               	add	x16, x16, #0x8
               	str	w16, [x17, #0x18]
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x2, x16
               	ldrsw	x2, [x2]
               	add	x1, x1, x2
               	str	w1, [x0]
               	sub	x0, x29, #0x28
               	ldrsw	x1, [x0]
               	sub	x2, x29, #0x20
               	mov	x17, x2
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x8]
               	add	x9, x9, x16
               	add	x16, x16, #0x8
               	str	w16, [x17, #0x18]
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x2, x16
               	ldrsw	x2, [x2]
               	add	x1, x1, x2
               	str	w1, [x0]
               	sub	x0, x29, #0x20
               	ldursw	x0, [x29, #-0x28]
               	ldr	x19, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xc0
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x8]
               	mov	x0, #0x5                // =5
               	mov	x1, #0x1                // =1
               	mov	x2, #0x2                // =2
               	mov	x3, #0x3                // =3
               	mov	x4, #0x4                // =4
               	mov	x5, x0
               	bl	<addr>
               	cmp	x0, #0xf
               	b.eq	<addr>
               	sub	x0, x29, #0x8
               	ldrsw	x1, [x0]
               	mov	x17, #0x1               // =1
               	orr	x1, x1, x17
               	str	w1, [x0]
               	b	<addr>
               	mov	x0, #0xc                // =12
               	mov	x1, #0x1                // =1
               	mov	x2, #0x2                // =2
               	mov	x3, #0x3                // =3
               	mov	x4, #0x4                // =4
               	mov	x5, #0x5                // =5
               	mov	x6, #0x6                // =6
               	mov	x7, #0x7                // =7
               	mov	x8, #0x8                // =8
               	mov	x9, #0x9                // =9
               	mov	x10, #0xa               // =10
               	mov	x11, #0xb               // =11
               	sub	sp, sp, #0x30
               	str	x8, [sp]
               	str	x9, [sp, #0x8]
               	str	x10, [sp, #0x10]
               	str	x11, [sp, #0x18]
               	str	x0, [sp, #0x20]
               	bl	<addr>
               	add	sp, sp, #0x30
               	cmp	x0, #0x4e
               	b.eq	<addr>
               	sub	x0, x29, #0x8
               	ldrsw	x1, [x0]
               	mov	x17, #0x2               // =2
               	orr	x1, x1, x17
               	str	w1, [x0]
               	b	<addr>
               	mov	x0, #0x4                // =4
               	mov	x1, #0x3ff8000000000000 // =4609434218613702656
               	mov	x2, #0x4004000000000000 // =4612811918334230528
               	mov	x3, #0x4008000000000000 // =4613937818241073152
               	mov	x4, #0x4010000000000000 // =4616189618054758400
               	fmov	d0, x1
               	fmov	d1, x2
               	fmov	d2, x3
               	fmov	d3, x4
               	bl	<addr>
               	mov	x0, #0x4026000000000000 // =4622382067542392832
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	sub	x0, x29, #0x8
               	ldrsw	x1, [x0]
               	mov	x17, #0x4               // =4
               	orr	x1, x1, x17
               	str	w1, [x0]
               	b	<addr>
               	mov	x0, #0xa                // =10
               	mov	x1, #0x3ff0000000000000 // =4607182418800017408
               	mov	x2, #0x4000000000000000 // =4611686018427387904
               	mov	x3, #0x4008000000000000 // =4613937818241073152
               	mov	x4, #0x4010000000000000 // =4616189618054758400
               	mov	x5, #0x4014000000000000 // =4617315517961601024
               	mov	x6, #0x4018000000000000 // =4618441417868443648
               	mov	x7, #0x401c000000000000 // =4619567317775286272
               	mov	x8, #0x4020000000000000 // =4620693217682128896
               	mov	x9, #0x4022000000000000 // =4621256167635550208
               	mov	x10, #0x4024000000000000 // =4621819117588971520
               	sub	sp, sp, #0x10
               	str	x9, [sp]
               	str	x10, [sp, #0x8]
               	fmov	d0, x1
               	fmov	d1, x2
               	fmov	d2, x3
               	fmov	d3, x4
               	fmov	d4, x5
               	fmov	d5, x6
               	fmov	d6, x7
               	fmov	d7, x8
               	bl	<addr>
               	add	sp, sp, #0x10
               	mov	x0, #0x800000000000     // =140737488355328
               	movk	x0, #0x404b, lsl #48
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	sub	x0, x29, #0x8
               	ldrsw	x1, [x0]
               	mov	x17, #0x8               // =8
               	orr	x1, x1, x17
               	str	w1, [x0]
               	b	<addr>
               	mov	x0, #0x4                // =4
               	mov	x1, #0xa                // =10
               	mov	x2, #0x3ff8000000000000 // =4609434218613702656
               	mov	x3, #0x14               // =20
               	mov	x4, #0x4004000000000000 // =4612811918334230528
               	fmov	d0, x2
               	fmov	d1, x4
               	mov	x2, x3
               	bl	<addr>
               	mov	x0, #0x4041000000000000 // =4629981891913580544
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	sub	x0, x29, #0x8
               	ldrsw	x1, [x0]
               	mov	x17, #0x10              // =16
               	orr	x1, x1, x17
               	str	w1, [x0]
               	b	<addr>
               	mov	x0, #0x5                // =5
               	mov	x1, #0x2                // =2
               	mov	x2, #0x4                // =4
               	mov	x3, #0x6                // =6
               	mov	x4, #0x8                // =8
               	mov	x5, #0xa                // =10
               	bl	<addr>
               	cmp	x0, #0x3c
               	b.eq	<addr>
               	sub	x0, x29, #0x8
               	ldrsw	x1, [x0]
               	mov	x17, #0x20              // =32
               	orr	x1, x1, x17
               	str	w1, [x0]
               	b	<addr>
               	mov	x0, #0x1                // =1
               	mov	x1, #0x2                // =2
               	mov	x2, #0x3                // =3
               	mov	x3, #0x4                // =4
               	mov	x4, #0x5                // =5
               	mov	x5, #0x6                // =6
               	mov	x6, #0x7                // =7
               	mov	x7, #0x8                // =8
               	mov	x8, #0x9                // =9
               	mov	x9, #0xa                // =10
               	mov	x10, #0x64              // =100
               	mov	x11, #0xc8              // =200
               	mov	x12, #0x12c             // =300
               	sub	sp, sp, #0x30
               	str	x8, [sp]
               	str	x9, [sp, #0x8]
               	str	x10, [sp, #0x10]
               	str	x11, [sp, #0x18]
               	str	x12, [sp, #0x20]
               	bl	<addr>
               	add	sp, sp, #0x30
               	cmp	x0, #0x28f
               	b.eq	<addr>
               	sub	x0, x29, #0x8
               	ldrsw	x1, [x0]
               	mov	x17, #0x40              // =64
               	orr	x1, x1, x17
               	str	w1, [x0]
               	b	<addr>
               	ldursw	x0, [x29, #-0x8]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
