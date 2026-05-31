
switch_nested_case_in_compound.aarch64:	file format elf64-littleaarch64

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
               	bl	0x400808 <dlsym>
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
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x19, [sp, #0x20]
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x8]
               	mov	x14, #0x2               // =2
               	sxtw	x15, w14
               	b	0x4004cc <.text+0x20c>
               	ldursw	x14, [x29, #-0x8]
               	cmp	x14, #0x7
               	b.eq	0x400568 <.text+0x2a8>
               	b	0x40051c <.text+0x25c>
               	mov	x13, #0x64              // =100
               	stur	w13, [x29, #-0x18]
               	sub	x14, x29, #0x8
               	ldrsw	x13, [x14]
               	ldursw	x15, [x29, #-0x18]
               	add	x12, x13, x15
               	str	w12, [x14]
               	ldursw	x15, [x29, #-0x18]
               	cmp	x15, #0x64
               	b.ne	0x400504 <.text+0x244>
               	b	0x4004e8 <.text+0x228>
               	sub	x15, x29, #0x8
               	ldrsw	x12, [x15]
               	add	x14, x12, #0x1
               	str	w14, [x15]
               	sub	x12, x29, #0x8
               	ldrsw	x14, [x12]
               	add	x15, x14, #0x2
               	str	w15, [x12]
               	sub	x14, x29, #0x8
               	ldrsw	x15, [x14]
               	add	x12, x15, #0x4
               	str	w12, [x14]
               	b	0x400444 <.text+0x184>
               	sub	x12, x29, #0x8
               	ldrsw	x15, [x12]
               	mov	x17, #0x4000            // =16384
               	orr	x14, x15, x17
               	str	w14, [x12]
               	b	0x400444 <.text+0x184>
               	cmp	x15, #0x1
               	b.eq	0x400454 <.text+0x194>
               	cmp	x15, #0x2
               	b.eq	0x400480 <.text+0x1c0>
               	cmp	x15, #0x3
               	b.eq	0x4004b4 <.text+0x1f4>
               	b	0x400444 <.text+0x184>
               	sub	x15, x29, #0x8
               	ldrsw	x12, [x15]
               	mov	x17, #0x1000            // =4096
               	orr	x14, x12, x17
               	str	w14, [x15]
               	b	0x400500 <.text+0x240>
               	b	0x400480 <.text+0x1c0>
               	sub	x14, x29, #0x8
               	ldrsw	x12, [x14]
               	mov	x17, #0x2000            // =8192
               	orr	x15, x12, x17
               	str	w15, [x14]
               	b	0x400444 <.text+0x184>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x150
               	mov	x20, x19
               	ldursw	x21, [x29, #-0x8]
               	mov	x0, x20
               	mov	x1, x21
               	bl	0x400814 <printf>
               	sxtw	x0, w0
               	mov	x12, x0
               	mov	x12, #0x1               // =1
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x0               // =0
               	stur	w21, [x29, #-0x8]
               	mov	x12, #0x1               // =1
               	sxtw	x21, w12
               	b	0x400608 <.text+0x348>
               	ldursw	x12, [x29, #-0x8]
               	mov	x17, #0x106b            // =4203
               	cmp	x12, x17
               	b.eq	0x4006a4 <.text+0x3e4>
               	b	0x400658 <.text+0x398>
               	mov	x20, #0x64              // =100
               	stur	w20, [x29, #-0x20]
               	sub	x12, x29, #0x8
               	ldrsw	x20, [x12]
               	ldursw	x21, [x29, #-0x20]
               	add	x13, x20, x21
               	str	w13, [x12]
               	ldursw	x21, [x29, #-0x20]
               	cmp	x21, #0x64
               	b.ne	0x400640 <.text+0x380>
               	b	0x400624 <.text+0x364>
               	sub	x21, x29, #0x8
               	ldrsw	x13, [x21]
               	add	x12, x13, #0x1
               	str	w12, [x21]
               	sub	x13, x29, #0x8
               	ldrsw	x12, [x13]
               	add	x21, x12, #0x2
               	str	w21, [x13]
               	sub	x12, x29, #0x8
               	ldrsw	x21, [x12]
               	add	x13, x21, #0x4
               	str	w13, [x12]
               	b	0x40057c <.text+0x2bc>
               	sub	x13, x29, #0x8
               	ldrsw	x21, [x13]
               	mov	x17, #0x4000            // =16384
               	orr	x12, x21, x17
               	str	w12, [x13]
               	b	0x40057c <.text+0x2bc>
               	cmp	x21, #0x1
               	b.eq	0x400590 <.text+0x2d0>
               	cmp	x21, #0x2
               	b.eq	0x4005bc <.text+0x2fc>
               	cmp	x21, #0x3
               	b.eq	0x4005f0 <.text+0x330>
               	b	0x40057c <.text+0x2bc>
               	sub	x21, x29, #0x8
               	ldrsw	x13, [x21]
               	mov	x17, #0x1000            // =4096
               	orr	x12, x13, x17
               	str	w12, [x21]
               	b	0x40063c <.text+0x37c>
               	b	0x4005bc <.text+0x2fc>
               	sub	x12, x29, #0x8
               	ldrsw	x13, [x12]
               	mov	x17, #0x2000            // =8192
               	orr	x21, x13, x17
               	str	w21, [x12]
               	b	0x40057c <.text+0x2bc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x165
               	mov	x22, x19
               	ldursw	x23, [x29, #-0x8]
               	mov	x0, x22
               	mov	x1, x23
               	bl	0x400814 <printf>
               	sxtw	x0, w0
               	mov	x13, x0
               	mov	x13, #0x2               // =2
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x23, #0x0               // =0
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
