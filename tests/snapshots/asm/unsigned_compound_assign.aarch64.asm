
unsigned_compound_assign.aarch64:	file format elf64-littleaarch64

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
               	bl	0x400908 <dlsym>
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
               	sub	sp, sp, #0xa0
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x19, [sp, #0x30]
               	mov	x15, #0x64              // =100
               	stur	w15, [x29, #-0x8]
               	sub	x14, x29, #0x8
               	ldr	w15, [x14]
               	add	x13, x15, #0x5
               	str	w13, [x14]
               	ldur	w15, [x29, #-0x8]
               	mov	x17, #0x69              // =105
               	eor	x13, x15, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x13, x17
               	cmp	x15, #0x0
               	b.eq	0x4004bc <.text+0x1fc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x150
               	mov	x20, x19
               	ldur	w21, [x29, #-0x8]
               	mov	x0, x20
               	mov	x1, x21
               	bl	0x400914 <printf>
               	sxtw	x0, w0
               	mov	x14, x0
               	mov	x14, #0x1               // =1
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x21, x29, #0x8
               	ldr	w14, [x21]
               	sub	x20, x14, #0x3
               	str	w20, [x21]
               	ldur	w14, [x29, #-0x8]
               	mov	x17, #0x66              // =102
               	eor	x20, x14, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x20, x17
               	cmp	x14, #0x0
               	b.eq	0x40053c <.text+0x27c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x166
               	mov	x22, x19
               	ldur	w23, [x29, #-0x8]
               	mov	x0, x22
               	mov	x1, x23
               	bl	0x400914 <printf>
               	sxtw	x0, w0
               	mov	x21, x0
               	mov	x21, #0x1               // =1
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x23, #0x3e8             // =1000
               	stur	x23, [x29, #-0x10]
               	sub	x21, x29, #0x10
               	ldr	x23, [x21]
               	add	x22, x23, #0x19f
               	str	x22, [x21]
               	ldur	x23, [x29, #-0x10]
               	cmp	x23, #0x587
               	b.eq	0x4005b0 <.text+0x2f0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x17c
               	mov	x20, x19
               	ldur	x23, [x29, #-0x10]
               	mov	x0, x20
               	mov	x1, x23
               	bl	0x400914 <printf>
               	sxtw	x0, w0
               	mov	x21, x0
               	mov	x21, #0x1               // =1
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x23, #0x41c             // =1052
               	stur	w23, [x29, #-0x18]
               	mov	x21, #0x19f             // =415
               	sxtw	x21, w21
               	sub	x23, x29, #0x18
               	ldr	w20, [x23]
               	sxtw	x12, w21
               	add	x21, x20, x12
               	str	w21, [x23]
               	ldur	w12, [x29, #-0x18]
               	mov	x17, #0x5bb             // =1467
               	eor	x21, x12, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x12, x21, x17
               	cmp	x12, #0x0
               	b.eq	0x400644 <.text+0x384>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x195
               	mov	x22, x19
               	ldur	w24, [x29, #-0x18]
               	mov	x0, x22
               	mov	x1, x24
               	bl	0x400914 <printf>
               	sxtw	x0, w0
               	mov	x23, x0
               	mov	x23, #0x1               // =1
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x24, #0xc8              // =200
               	sturb	w24, [x29, #-0x28]
               	sub	x23, x29, #0x28
               	ldrb	w24, [x23]
               	add	x22, x24, #0x3c
               	strb	w22, [x23]
               	ldurb	w24, [x29, #-0x28]
               	mov	x17, #0x4               // =4
               	eor	x22, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x22, x17
               	cmp	x24, #0x0
               	b.eq	0x4006cc <.text+0x40c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b6
               	mov	x21, x19
               	ldurb	w24, [x29, #-0x28]
               	mov	x0, x21
               	mov	x1, x24
               	bl	0x400914 <printf>
               	sxtw	x0, w0
               	mov	x23, x0
               	mov	x23, #0x1               // =1
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x24, x29, #0x40
               	mov	x23, #0x0               // =0
               	str	w23, [x24]
               	sub	x21, x29, #0x40
               	add	x23, x21, #0x4
               	mov	x21, #0xa               // =10
               	str	w21, [x23]
               	sub	x24, x29, #0x40
               	add	x21, x24, #0x8
               	mov	x24, #0x14              // =20
               	str	w24, [x21]
               	sub	x23, x29, #0x40
               	add	x24, x23, #0xc
               	mov	x23, #0x1e              // =30
               	str	w23, [x24]
               	sub	x21, x29, #0x40
               	add	x23, x21, #0x10
               	mov	x21, #0x28              // =40
               	str	w21, [x23]
               	sub	x24, x29, #0x40
               	stur	x24, [x29, #-0x48]
               	sub	x21, x29, #0x48
               	ldr	x24, [x21]
               	add	x23, x24, #0xc
               	str	x23, [x21]
               	ldur	x24, [x29, #-0x48]
               	ldrsw	x23, [x24]
               	cmp	x23, #0x1e
               	b.eq	0x400794 <.text+0x4d4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d2
               	mov	x22, x19
               	ldur	x24, [x29, #-0x48]
               	ldrsw	x23, [x24]
               	mov	x0, x22
               	mov	x1, x23
               	bl	0x400914 <printf>
               	sxtw	x0, w0
               	mov	x24, x0
               	mov	x24, #0x1               // =1
               	mov	x0, x24
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x23, #0x0               // =0
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
