
comparison_imm_lhs_swap.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400410 <.text+0x150>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xf0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	sxtw	x20, w0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x12, x14, x13
               	ldr	x13, [x12]
               	cbz	x13, 0x40034c <.text+0x8c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x12, x19
               	lsl	x13, x20, #3
               	add	x14, x12, x13
               	ldr	x13, [x14]
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x18
               	mov	x21, #0x0               // =0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x118
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x12, x11, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x11e
               	mov	x11, x19
               	str	x11, [x12]
               	sub	x14, x29, #0x18
               	add	x11, x14, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x125
               	mov	x14, x19
               	str	x14, [x11]
               	sub	x12, x29, #0x18
               	lsl	x14, x20, #3
               	add	x11, x12, x14
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x400758 <dlsym>
               	mov	x11, x0
               	cbz	x11, 0x4003d8 <.text+0x118>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x12, x22, x21
               	ldr	x21, [x11]
               	str	x21, [x12]
               	b	0x4003d8 <.text+0x118>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x21, x19
               	lsl	x11, x20, #3
               	add	x20, x21, x11
               	ldr	x11, [x20]
               	mov	x0, x11
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	mov	x15, #0x5               // =5
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x18]
               	sxtw	x13, w15
               	cmp	x13, #0x0
               	b.le	0x400454 <.text+0x194>
               	ldursw	x13, [x29, #-0x18]
               	add	x14, x13, #0x1
               	sxtw	x14, w14
               	stur	w14, [x29, #-0x18]
               	b	0x400454 <.text+0x194>
               	sxtw	x14, w15
               	cmp	x14, #0x0
               	b.lt	0x400474 <.text+0x1b4>
               	ldursw	x14, [x29, #-0x18]
               	add	x13, x14, #0x1
               	sxtw	x13, w13
               	stur	w13, [x29, #-0x18]
               	b	0x400474 <.text+0x1b4>
               	sxtw	x13, w15
               	cmp	x13, #0xa
               	b.ge	0x400494 <.text+0x1d4>
               	ldursw	x13, [x29, #-0x18]
               	add	x14, x13, #0x1
               	sxtw	x14, w14
               	stur	w14, [x29, #-0x18]
               	b	0x400494 <.text+0x1d4>
               	sxtw	x14, w15
               	cmp	x14, #0xa
               	b.gt	0x4004b4 <.text+0x1f4>
               	ldursw	x14, [x29, #-0x18]
               	add	x13, x14, #0x1
               	sxtw	x13, w13
               	stur	w13, [x29, #-0x18]
               	b	0x4004b4 <.text+0x1f4>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x15, x17
               	cmp	x13, #0x0
               	b.ls	0x4004dc <.text+0x21c>
               	ldursw	x13, [x29, #-0x18]
               	add	x14, x13, #0x1
               	sxtw	x14, w14
               	stur	w14, [x29, #-0x18]
               	b	0x4004dc <.text+0x21c>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x15, x17
               	cmp	x14, #0x0
               	b.lo	0x400504 <.text+0x244>
               	ldursw	x14, [x29, #-0x18]
               	add	x13, x14, #0x1
               	sxtw	x13, w13
               	stur	w13, [x29, #-0x18]
               	b	0x400504 <.text+0x244>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x15, x17
               	cmp	x13, #0xa
               	b.hs	0x40052c <.text+0x26c>
               	ldursw	x13, [x29, #-0x18]
               	add	x14, x13, #0x1
               	sxtw	x14, w14
               	stur	w14, [x29, #-0x18]
               	b	0x40052c <.text+0x26c>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x15, x17
               	cmp	x14, #0xa
               	b.hi	0x400554 <.text+0x294>
               	ldursw	x14, [x29, #-0x18]
               	add	x13, x14, #0x1
               	sxtw	x13, w13
               	stur	w13, [x29, #-0x18]
               	b	0x400554 <.text+0x294>
               	sxtw	x13, w15
               	cmp	x13, #0xa
               	b.le	0x400580 <.text+0x2c0>
               	mov	x13, #0x1               // =1
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x14, w15
               	cmp	x14, #0x0
               	b.ge	0x4005ac <.text+0x2ec>
               	mov	x14, #0x2               // =2
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x150
               	mov	x20, x19
               	ldursw	x21, [x29, #-0x18]
               	mov	x0, x20
               	mov	x1, x21
               	bl	0x400764 <printf>
               	sxtw	x0, w0
               	mov	x13, x0
               	ldursw	x13, [x29, #-0x18]
               	cmp	x13, #0x8
               	b.ne	0x4005e8 <.text+0x328>
               	mov	x13, #0x0               // =0
               	stur	x13, [x29, #-0x30]
               	b	0x4005f4 <.text+0x334>
               	mov	x13, #0x3               // =3
               	stur	x13, [x29, #-0x30]
               	b	0x4005f4 <.text+0x334>
               	ldur	x13, [x29, #-0x30]
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	<unknown>
               	adr	x10, 0x4ec739
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x406c6c <exit+0x64fc>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8cfc
               	tbz	w21, #0x6, 0x3fecc0
               	<unknown>
               	cbnz	w16, 0x46ec68
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x400274
               	<unknown>
               	ldpsw	x15, x11, [x25, #-0xc8]
               	<unknown>
               	ldp	d14, d24, [x25, #-0x110]
               	umlsl2	v15.4s, v25.8h, v2.h[7]
               	<unknown>
               	<unknown>
               	ldpsw	x3, x11, [x19, #-0xc8]
               	udf	#0x74
		...
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	mov	x0, x20
               	bl	0x400770 <exit>
               	uxtb	w0, w0
               	mov	x14, x0
               	mov	x14, #0x0               // =0
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	<unknown>
               	adr	x10, 0x4ec801
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x406d34 <exit+0x65c4>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8dc4
               	tbz	w21, #0x6, 0x3fed88
               	<unknown>
               	cbnz	w16, 0x46ed30
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x40033c <.text+0x7c>
               	<unknown>
               	ldpsw	x15, x11, [x25, #-0xc8]
               	<unknown>
               	ldp	d14, d24, [x25, #-0x110]
               	umlsl2	v15.4s, v25.8h, v2.h[7]
               	<unknown>
               	<unknown>
               	ldpsw	x3, x11, [x19, #-0xc8]
               	udf	#0x74

<dlsym>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xe0]
               	br	x16

<printf>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xe8]
               	br	x16

<exit>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xf0]
               	br	x16
