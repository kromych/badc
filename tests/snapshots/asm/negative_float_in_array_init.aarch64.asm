
negative_float_in_array_init.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xd8]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	mov	x20, x0
               	sxtw	x20, w20
               	adrp	x21, <page>
               	add	x21, x21, #0xe8
               	ldr	x0, [x21, x20, lsl #3]
               	cbz	x0, <addr>
               	ldr	x0, [x21, x20, lsl #3]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	mov	x1, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, #0x100
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x8
               	adrp	x2, <page>
               	add	x2, x2, #0x106
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x10
               	adrp	x2, <page>
               	add	x2, x2, #0x10d
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	ldr	x0, [x0, x20, lsl #3]
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	cbz	x0, <addr>
               	ldr	x0, [x0]
               	str	x0, [x21, x20, lsl #3]
               	b	<addr>
               	ldr	x0, [x21, x20, lsl #3]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	adrp	x0, <page>
               	add	x0, x0, #0x118
               	ldr	d0, [x0]
               	mov	x1, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d17, x1
               	fcmp	d0, d17
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x1, x0, #0x8
               	ldr	d0, [x1]
               	mov	x1, #0x4004000000000000 // =4612811918334230528
               	fmov	d16, x1
               	fneg	d1, d16
               	fcmp	d0, d1
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x1, x0, #0x10
               	ldr	d0, [x1]
               	mov	x1, #0x94000000         // =2483027968
               	movk	x1, #0x449a, lsl #32
               	movk	x1, #0x421e, lsl #48
               	fmov	d16, x1
               	fneg	d1, d16
               	fcmp	d0, d1
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	d0, [x0]
               	add	x1, x0, #0x8
               	ldr	d1, [x1]
               	fadd	d0, d0, d1
               	add	x0, x0, #0x10
               	ldr	d1, [x0]
               	fadd	d0, d0, d1
               	mov	x0, #0x94000000         // =2483027968
               	movk	x0, #0x449a, lsl #32
               	movk	x0, #0x421e, lsl #48
               	fmov	d16, x0
               	fneg	d1, d16
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d17, x0
               	fadd	d1, d1, d17
               	fcmp	d0, d1
               	cset	x1, gt
               	cbnz	x1, <addr>
               	mov	x0, #0x94000000         // =2483027968
               	movk	x0, #0x449a, lsl #32
               	movk	x0, #0x421e, lsl #48
               	fmov	d16, x0
               	fneg	d1, d16
               	mov	x0, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d17, x0
               	fsub	d1, d1, d17
               	fcmp	d0, d1
               	cset	x1, mi
               	b	<addr>
               	cbz	x1, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
