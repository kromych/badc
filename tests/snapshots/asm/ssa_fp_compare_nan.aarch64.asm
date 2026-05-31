
ssa_fp_compare_nan.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400434 <.text+0x174>
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
               	bl	0x400798 <dlsym>
               	cbz	x0, 0x4003d4 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x12, x22, x21
               	ldr	x21, [x0]
               	str	x21, [x12]
               	b	0x4003d4 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x21, x19
               	lsl	x0, x20, #3
               	add	x20, x21, x0
               	ldr	x0, [x20]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x15, #0x0               // =0
               	fmov	d0, x15
               	fmov	d1, x15
               	fdiv	d0, d0, d1
               	fmov	x0, d0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	bl	0x400408 <.text+0x148>
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x10]
               	fmov	d0, x0
               	fmov	d1, x14
               	fcmp	d0, d1
               	cset	x13, mi
               	cbz	x13, 0x400488 <.text+0x1c8>
               	sub	x14, x29, #0x10
               	ldrsw	x13, [x14]
               	mov	x17, #0x1               // =1
               	orr	x12, x13, x17
               	str	w12, [x14]
               	b	0x400488 <.text+0x1c8>
               	mov	x12, #0x0               // =0
               	fmov	d0, x0
               	fmov	d1, x12
               	fcmp	d0, d1
               	cset	x13, gt
               	cbz	x13, 0x4004b8 <.text+0x1f8>
               	sub	x12, x29, #0x10
               	ldrsw	x13, [x12]
               	mov	x17, #0x2               // =2
               	orr	x14, x13, x17
               	str	w14, [x12]
               	b	0x4004b8 <.text+0x1f8>
               	mov	x14, #0x0               // =0
               	fmov	d0, x0
               	fmov	d1, x14
               	fcmp	d0, d1
               	cset	x13, ls
               	cbz	x13, 0x4004e8 <.text+0x228>
               	sub	x14, x29, #0x10
               	ldrsw	x13, [x14]
               	mov	x17, #0x4               // =4
               	orr	x12, x13, x17
               	str	w12, [x14]
               	b	0x4004e8 <.text+0x228>
               	mov	x12, #0x0               // =0
               	fmov	d0, x0
               	fmov	d1, x12
               	fcmp	d0, d1
               	cset	x13, ge
               	cbz	x13, 0x400518 <.text+0x258>
               	sub	x12, x29, #0x10
               	ldrsw	x13, [x12]
               	mov	x17, #0x8               // =8
               	orr	x14, x13, x17
               	str	w14, [x12]
               	b	0x400518 <.text+0x258>
               	mov	x14, #0x0               // =0
               	fmov	d0, x0
               	fmov	d1, x14
               	fcmp	d0, d1
               	cset	x13, eq
               	cbz	x13, 0x400548 <.text+0x288>
               	sub	x14, x29, #0x10
               	ldrsw	x13, [x14]
               	mov	x17, #0x10              // =16
               	orr	x12, x13, x17
               	str	w12, [x14]
               	b	0x400548 <.text+0x288>
               	mov	x12, #0x0               // =0
               	fmov	d0, x0
               	fmov	d1, x12
               	fcmp	d0, d1
               	cset	x13, ne
               	cmp	x13, #0x0
               	b.ne	0x40057c <.text+0x2bc>
               	sub	x13, x29, #0x10
               	ldrsw	x12, [x13]
               	mov	x17, #0x20              // =32
               	orr	x14, x12, x17
               	str	w14, [x13]
               	b	0x40057c <.text+0x2bc>
               	fmov	d0, x0
               	fmov	d1, x0
               	fcmp	d0, d1
               	cset	x14, mi
               	cbz	x14, 0x4005a8 <.text+0x2e8>
               	sub	x12, x29, #0x10
               	ldrsw	x14, [x12]
               	mov	x17, #0x40              // =64
               	orr	x13, x14, x17
               	str	w13, [x12]
               	b	0x4005a8 <.text+0x2e8>
               	fmov	d0, x0
               	fmov	d1, x0
               	fcmp	d0, d1
               	cset	x13, eq
               	cbz	x13, 0x4005d4 <.text+0x314>
               	sub	x0, x29, #0x10
               	ldrsw	x13, [x0]
               	mov	x17, #0x80              // =128
               	orr	x14, x13, x17
               	str	w14, [x0]
               	b	0x4005d4 <.text+0x314>
               	ldursw	x14, [x29, #-0x10]
               	cbz	x14, 0x40061c <.text+0x35c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x150
               	mov	x20, x19
               	ldursw	x21, [x29, #-0x10]
               	mov	x0, x20
               	mov	x1, x21
               	bl	0x4007a4 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x22, x19
               	mov	x0, x22
               	bl	0x4007a4 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
