
libc_fp_return_value.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x40050c <.text+0x14c>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0x120]
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
               	add	x19, x19, #0x130
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x13, [x14]
               	cbz	x13, 0x40044c <.text+0x8c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x130
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
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
               	add	x19, x19, #0x148
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x14e
               	mov	x12, x19
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x155
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x4007d8 <dlsym>
               	cbz	x0, 0x4004d4 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x130
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x22, x22, x21
               	ldr	x21, [x0]
               	str	x21, [x22]
               	b	0x4004d4 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x130
               	mov	x21, x19
               	lsl	x20, x20, #3
               	add	x21, x21, x20
               	ldr	x20, [x21]
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	str	d8, [sp]
               	str	x20, [sp, #0x10]
               	str	x21, [sp, #0x18]
               	str	x19, [sp, #0x20]
               	mov	x15, #0x1               // =1
               	stur	w15, [x29, #-0x8]
               	mov	x20, #0x4010000000000000 // =4616189618054758400
               	fmov	d0, x20
               	bl	0x4007e4 <sqrt>
               	fmov	x0, d0
               	mov	x20, #0x4000000000000000 // =4611686018427387904
               	fmov	d0, x0
               	fmov	d1, x20
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, 0x400564 <.text+0x1a4>
               	mov	x20, #0x0               // =0
               	stur	w20, [x29, #-0x8]
               	b	0x400564 <.text+0x1a4>
               	mov	x21, #0x999a            // =39322
               	movk	x21, #0x9999, lsl #16
               	movk	x21, #0x9999, lsl #32
               	movk	x21, #0x4005, lsl #48
               	fmov	d0, x21
               	bl	0x4007f0 <floor>
               	fmov	x0, d0
               	mov	x21, #0x4000000000000000 // =4611686018427387904
               	fmov	d0, x0
               	fmov	d1, x21
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, 0x4005a4 <.text+0x1e4>
               	mov	x21, #0x0               // =0
               	stur	w21, [x29, #-0x8]
               	b	0x4005a4 <.text+0x1e4>
               	mov	x20, #0x6666            // =26214
               	movk	x20, #0x6666, lsl #16
               	movk	x20, #0x6666, lsl #32
               	movk	x20, #0x4002, lsl #48
               	fmov	d0, x20
               	bl	0x4007fc <ceil>
               	fmov	x0, d0
               	mov	x20, #0x4008000000000000 // =4613937818241073152
               	fmov	d0, x0
               	fmov	d1, x20
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, 0x4005e4 <.text+0x224>
               	mov	x20, #0x0               // =0
               	stur	w20, [x29, #-0x8]
               	b	0x4005e4 <.text+0x224>
               	mov	x21, #0x400c000000000000 // =4615063718147915776
               	fmov	d0, x21
               	fneg	d8, d0
               	fmov	x16, d8
               	fmov	d0, x16
               	bl	0x400808 <fabs>
               	fmov	x0, d0
               	fmov	d0, x0
               	fmov	d1, x21
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, 0x400620 <.text+0x260>
               	mov	x21, #0x0               // =0
               	stur	w21, [x29, #-0x8]
               	b	0x400620 <.text+0x260>
               	mov	x20, #0x401c000000000000 // =4619567317775286272
               	mov	x21, #0x4010000000000000 // =4616189618054758400
               	fmov	d0, x20
               	fmov	d1, x21
               	bl	0x400814 <fmod>
               	fmov	x0, d0
               	mov	x21, #0x4008000000000000 // =4613937818241073152
               	fmov	d0, x0
               	fmov	d1, x21
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, 0x40065c <.text+0x29c>
               	mov	x21, #0x0               // =0
               	stur	w21, [x29, #-0x8]
               	b	0x40065c <.text+0x29c>
               	ldursw	x21, [x29, #-0x8]
               	cbz	x21, 0x400670 <.text+0x2b0>
               	mov	x0, #0xb                // =11
               	stur	x0, [x29, #-0x48]
               	b	0x40067c <.text+0x2bc>
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x48]
               	b	0x40067c <.text+0x2bc>
               	ldur	x0, [x29, #-0x48]
               	ldr	x20, [sp, #0x10]
               	ldr	x21, [sp, #0x18]
               	ldr	d8, [sp]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
