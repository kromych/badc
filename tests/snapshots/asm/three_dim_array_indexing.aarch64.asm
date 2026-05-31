
three_dim_array_indexing.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x40044c <.text+0x18c>
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
               	bl	0x400868 <dlsym>
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
               	mov	x15, x0
               	ldrb	w14, [x15]
               	add	x13, x15, #0x1
               	ldrb	w12, [x13]
               	add	x13, x14, x12
               	sxtw	x13, w13
               	add	x12, x15, #0x2
               	ldrb	w14, [x12]
               	add	x12, x13, x14
               	sxtw	x12, w12
               	add	x14, x15, #0x3
               	ldrb	w15, [x14]
               	add	x14, x12, x15
               	sxtw	x0, w14
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x150
               	mov	x20, x19
               	mov	x0, x20
               	bl	0x400410 <.text+0x150>
               	mov	x14, x0
               	mov	x20, #0x3               // =3
               	sxtw	x20, w20
               	add	x13, x20, #0x3
               	sxtw	x13, w13
               	add	x20, x13, #0x4
               	sxtw	x20, w20
               	cmp	x14, x20
               	b.eq	0x4004bc <.text+0x1fc>
               	mov	x20, #0x1               // =1
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x150
               	mov	x13, x19
               	add	x21, x13, #0x8
               	mov	x0, x21
               	bl	0x400410 <.text+0x150>
               	mov	x13, x0
               	mov	x21, #0x13              // =19
               	sxtw	x21, w21
               	add	x14, x21, #0xb
               	sxtw	x14, w14
               	add	x21, x14, #0xc
               	sxtw	x21, w21
               	cmp	x13, x21
               	b.eq	0x400518 <.text+0x258>
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x150
               	mov	x14, x19
               	add	x20, x14, #0x10
               	mov	x0, x20
               	bl	0x400410 <.text+0x150>
               	mov	x14, x0
               	mov	x20, #0x23              // =35
               	sxtw	x20, w20
               	add	x13, x20, #0x13
               	sxtw	x13, w13
               	add	x20, x13, #0x14
               	sxtw	x20, w20
               	cmp	x14, x20
               	b.eq	0x400574 <.text+0x2b4>
               	mov	x20, #0x3               // =3
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x150
               	mov	x13, x19
               	ldrb	w20, [x13]
               	mov	x17, #0x1               // =1
               	eor	x13, x20, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x13, x17
               	cmp	x20, #0x0
               	b.eq	0x4005c0 <.text+0x300>
               	mov	x20, #0x4               // =4
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x150
               	mov	x13, x19
               	add	x20, x13, #0xb
               	ldrb	w13, [x20]
               	mov	x17, #0xc               // =12
               	eor	x20, x13, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x20, x17
               	cmp	x13, #0x0
               	b.eq	0x400610 <.text+0x350>
               	mov	x13, #0x5               // =5
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x150
               	mov	x20, x19
               	add	x13, x20, #0x17
               	ldrb	w20, [x13]
               	mov	x17, #0x18              // =24
               	eor	x13, x20, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x13, x17
               	cmp	x20, #0x0
               	b.eq	0x400660 <.text+0x3a0>
               	mov	x20, #0x6               // =6
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x150
               	mov	x13, x19
               	add	x20, x13, #0xc
               	ldrb	w14, [x20]
               	ldrb	w20, [x13]
               	sub	x13, x14, x20
               	sxtw	x13, w13
               	cmp	x13, #0xc
               	b.eq	0x4006a8 <.text+0x3e8>
               	mov	x13, #0x7               // =7
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x150
               	mov	x20, x19
               	add	x13, x20, #0x4
               	ldrb	w14, [x13]
               	ldrb	w13, [x20]
               	sub	x20, x14, x13
               	sxtw	x20, w20
               	cmp	x20, #0x4
               	b.eq	0x4006f0 <.text+0x430>
               	mov	x20, #0x8               // =8
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x168
               	mov	x21, x19
               	mov	x0, x21
               	bl	0x400874 <printf>
               	sxtw	x0, w0
               	mov	x20, x0
               	mov	x20, #0x0               // =0
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
