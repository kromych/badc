
pointer_to_array_struct_field.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400490 <.text+0x150>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0x100]
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
               	add	x19, x19, #0x110
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x12, x14, x13
               	ldr	x13, [x12]
               	cbz	x13, 0x4003cc <.text+0x8c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x110
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
               	add	x19, x19, #0x128
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x12, x11, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x12e
               	mov	x11, x19
               	str	x11, [x12]
               	sub	x14, x29, #0x18
               	add	x11, x14, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x135
               	mov	x14, x19
               	str	x14, [x11]
               	sub	x12, x29, #0x18
               	lsl	x14, x20, #3
               	add	x11, x12, x14
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x400898 <dlsym>
               	mov	x11, x0
               	cbz	x11, 0x400458 <.text+0x118>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x110
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x12, x22, x21
               	ldr	x21, [x11]
               	str	x21, [x12]
               	b	0x400458 <.text+0x118>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x110
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
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	sub	x20, x29, #0x8
               	mov	x14, #0x40              // =64
               	sxtw	x21, w14
               	mov	x0, x21
               	bl	0x4008a4 <malloc>
               	mov	x13, x0
               	str	x13, [x20]
               	sub	x21, x29, #0x8
               	ldr	x13, [x21]
               	cmp	x13, #0x0
               	b.ne	0x4004fc <.text+0x1bc>
               	mov	x13, #0x1               // =1
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x0               // =0
               	stur	w21, [x29, #-0x10]
               	b	0x400508 <.text+0x1c8>
               	ldursw	x21, [x29, #-0x10]
               	cmp	x21, #0x4
               	b.ge	0x400538 <.text+0x1f8>
               	b	0x40052c <.text+0x1ec>
               	sub	x21, x29, #0x10
               	ldrsw	x13, [x21]
               	add	x20, x13, #0x1
               	str	w20, [x21]
               	b	0x400508 <.text+0x1c8>
               	mov	x20, #0x0               // =0
               	stur	w20, [x29, #-0x18]
               	b	0x400544 <.text+0x204>
               	mov	x21, #0x0               // =0
               	stur	w21, [x29, #-0x10]
               	b	0x4005ac <.text+0x26c>
               	ldursw	x20, [x29, #-0x18]
               	cmp	x20, #0x8
               	b.ge	0x4005a8 <.text+0x268>
               	b	0x400568 <.text+0x228>
               	sub	x20, x29, #0x18
               	ldrsw	x13, [x20]
               	add	x21, x13, #0x1
               	str	w21, [x20]
               	b	0x400544 <.text+0x204>
               	sub	x21, x29, #0x8
               	ldr	x13, [x21]
               	ldursw	x21, [x29, #-0x10]
               	lsl	x20, x21, #4
               	add	x12, x13, x20
               	ldursw	x20, [x29, #-0x18]
               	lsl	x13, x20, #1
               	add	x11, x12, x13
               	mov	x17, #0x64              // =100
               	mul	x13, x21, x17
               	sxtw	x13, w13
               	add	x21, x13, x20
               	sxtw	x21, w21
               	sxth	x21, w21
               	strh	w21, [x11]
               	b	0x400554 <.text+0x214>
               	b	0x400518 <.text+0x1d8>
               	ldursw	x21, [x29, #-0x10]
               	cmp	x21, #0x4
               	b.ge	0x4005dc <.text+0x29c>
               	b	0x4005d0 <.text+0x290>
               	sub	x21, x29, #0x10
               	ldrsw	x13, [x21]
               	add	x11, x13, #0x1
               	str	w11, [x21]
               	b	0x4005ac <.text+0x26c>
               	mov	x11, #0x0               // =0
               	stur	w11, [x29, #-0x18]
               	b	0x400620 <.text+0x2e0>
               	sub	x12, x29, #0x8
               	ldr	x13, [x12]
               	mov	x12, #0xffff            // =65535
               	movk	x12, #0xffff, lsl #16
               	movk	x12, #0xffff, lsl #32
               	movk	x12, #0xffff, lsl #48
               	strh	w12, [x13]
               	sub	x21, x29, #0x8
               	ldr	x12, [x21]
               	ldrsh	x21, [x12]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x21, x17
               	b.eq	0x4006f8 <.text+0x3b8>
               	b	0x4006d4 <.text+0x394>
               	ldursw	x11, [x29, #-0x18]
               	cmp	x11, #0x8
               	b.ge	0x40068c <.text+0x34c>
               	b	0x400644 <.text+0x304>
               	sub	x11, x29, #0x18
               	ldrsw	x13, [x11]
               	add	x21, x13, #0x1
               	str	w21, [x11]
               	b	0x400620 <.text+0x2e0>
               	sub	x21, x29, #0x8
               	ldr	x13, [x21]
               	ldursw	x21, [x29, #-0x10]
               	lsl	x11, x21, #4
               	add	x20, x13, x11
               	ldursw	x11, [x29, #-0x18]
               	lsl	x13, x11, #1
               	add	x12, x20, x13
               	ldrsh	x13, [x12]
               	mov	x17, #0x64              // =100
               	mul	x12, x21, x17
               	sxtw	x12, w12
               	add	x21, x12, x11
               	sxtw	x21, w21
               	sxth	x21, w21
               	cmp	x13, x21
               	b.eq	0x4006d0 <.text+0x390>
               	b	0x400690 <.text+0x350>
               	b	0x4005bc <.text+0x27c>
               	ldursw	x21, [x29, #-0x10]
               	lsl	x12, x21, #3
               	sxtw	x12, w12
               	add	x21, x12, #0xa
               	sxtw	x21, w21
               	ldursw	x12, [x29, #-0x18]
               	add	x13, x21, x12
               	sxtw	x13, w13
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x400630 <.text+0x2f0>
               	mov	x21, #0x63              // =99
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x12, x29, #0x8
               	ldr	x22, [x12]
               	mov	x0, x22
               	bl	0x4008b0 <free>
               	sxtw	x0, w0
               	mov	x12, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x21, x19
               	mov	x0, x21
               	bl	0x4008bc <printf>
               	sxtw	x0, w0
               	mov	x22, x0
               	mov	x22, #0x0               // =0
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	<unknown>
               	adr	x10, 0x4ec875
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x406da8 <exit+0x64e0>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8e38
               	tbz	w21, #0x6, 0x3fedfc
               	<unknown>
               	cbnz	w16, 0x46eda4
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x4003b0 <.text+0x70>
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
               	bl	0x4008c8 <exit>
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
               	adr	x10, 0x4ec941
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x406e74 <exit+0x65ac>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8f04
               	tbz	w21, #0x6, 0x3feec8
               	<unknown>
               	cbnz	w16, 0x46ee70
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x40047c <.text+0x13c>
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

<malloc>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xe8]
               	br	x16

<free>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xf0]
               	br	x16

<printf>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xf8]
               	br	x16

<exit>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0x100]
               	br	x16
