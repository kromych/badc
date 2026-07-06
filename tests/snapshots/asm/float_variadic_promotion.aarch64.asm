
float_variadic_promotion.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	fsub	d1, d0, d1
               	mov	x0, #0x0                // =0
               	scvtf	d0, x0
               	fcmp	d1, d0
               	cset	x0, mi
               	cbz	x0, <addr>
               	fneg	d1, d1
               	mov	x0, #0xa9fc             // =43516
               	movk	x0, #0xd2f1, lsl #16
               	movk	x0, #0x624d, lsl #32
               	movk	x0, #0x3f50, lsl #48
               	fmov	d17, x0
               	fcmp	d1, d17
               	cset	x0, mi
               	ret
               	b	<addr>

<vsum>:
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
               	str	x19, [sp, #-0x50]!
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	sub	x0, x29, #0x20
               	add	x1, x29, #0x10
               	mov	x16, x0
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
               	mov	x1, #0x0                // =0
               	scvtf	d0, x1
               	b	<addr>
               	sub	x0, x29, #0x20
               	mov	x17, x0
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x10]
               	add	x9, x9, x16
               	add	x16, x16, #0x10
               	str	w16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x0, x16
               	ldr	d1, [x0]
               	fadd	d0, d0, d1
               	sxtw	x0, w1
               	add	x1, x0, #0x1
               	sxtw	x0, w1
               	ldursw	x2, [x29, #0x10]
               	cmp	x0, x2
               	b.lt	<addr>
               	sub	x0, x29, #0x20
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp], #0x50
               	add	sp, sp, #0xc0
               	ret

<main>:
               	str	x20, [sp, #-0x60]!
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	mov	x0, #0x3d71             // =15729
               	movk	x0, #0x428a, lsl #16
               	fmov	s16, w0
               	sub	x17, x29, #0x8
               	str	s16, [x17]
               	mov	x0, #0x3fc00000         // =1069547520
               	fmov	s16, w0
               	sub	x17, x29, #0x10
               	str	s16, [x17]
               	mov	x0, #0x1                // =1
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	fcvt	d0, s0
               	bl	<addr>
               	mov	x0, #0xe148             // =57672
               	movk	x0, #0x147a, lsl #16
               	movk	x0, #0x47ae, lsl #32
               	movk	x0, #0x4051, lsl #48
               	fmov	d1, x0
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x0, #0x1                // =1
               	mov	x20, #0x4004000000000000 // =4612811918334230528
               	fmov	d16, x20
               	fcvt	s0, d16
               	fcvt	d0, s0
               	bl	<addr>
               	fmov	d1, x20
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x0, #0x2                // =2
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	fcvt	d0, s0
               	sub	x16, x29, #0x10
               	ldr	s1, [x16]
               	fcvt	d1, s1
               	bl	<addr>
               	mov	x0, #0xe148             // =57672
               	movk	x0, #0x147a, lsl #16
               	movk	x0, #0xa7ae, lsl #32
               	movk	x0, #0x4051, lsl #48
               	fmov	d1, x0
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x0, #0x3                // =3
               	mov	x1, #0xa                // =10
               	scvtf	d0, x1
               	sub	x16, x29, #0x8
               	ldr	s1, [x16]
               	fcvt	d1, s1
               	sub	x16, x29, #0x10
               	ldr	s2, [x16]
               	fcvt	d2, s2
               	bl	<addr>
               	mov	x0, #0xe148             // =57672
               	movk	x0, #0x147a, lsl #16
               	movk	x0, #0x27ae, lsl #32
               	movk	x0, #0x4054, lsl #48
               	fmov	d1, x0
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
