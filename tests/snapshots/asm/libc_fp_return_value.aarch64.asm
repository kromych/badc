
libc_fp_return_value.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400510 <.text+0x150>
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
               	add	x12, x14, x13
               	ldr	x13, [x12]
               	cbz	x13, 0x40044c <.text+0x8c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x130
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
               	add	x19, x19, #0x148
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x12, x11, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x14e
               	mov	x11, x19
               	str	x11, [x12]
               	sub	x14, x29, #0x18
               	add	x11, x14, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x155
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
               	cbz	x11, 0x4004d8 <.text+0x118>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x130
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x12, x22, x21
               	ldr	x21, [x11]
               	str	x21, [x12]
               	b	0x4004d8 <.text+0x118>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x130
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
               	sub	sp, sp, #0x90
               	str	d8, [sp]
               	str	x20, [sp, #0x10]
               	str	x21, [sp, #0x18]
               	str	x22, [sp, #0x20]
               	str	x19, [sp, #0x30]
               	mov	x15, #0x1               // =1
               	stur	w15, [x29, #-0x8]
               	mov	x20, #0x4010000000000000 // =4616189618054758400
               	fmov	d0, x20
               	bl	0x400814 <sqrt>
               	fmov	x0, d0
               	mov	x15, x0
               	mov	x20, #0x4000000000000000 // =4611686018427387904
               	fmov	d0, x15
               	fmov	d1, x20
               	fcmp	d0, d1
               	cset	x13, ne
               	cbz	x13, 0x400570 <.text+0x1b0>
               	mov	x20, #0x0               // =0
               	stur	w20, [x29, #-0x8]
               	b	0x400570 <.text+0x1b0>
               	mov	x21, #0x999a            // =39322
               	movk	x21, #0x9999, lsl #16
               	movk	x21, #0x9999, lsl #32
               	movk	x21, #0x4005, lsl #48
               	fmov	d0, x21
               	bl	0x400820 <floor>
               	fmov	x0, d0
               	mov	x13, x0
               	mov	x21, #0x4000000000000000 // =4611686018427387904
               	fmov	d0, x13
               	fmov	d1, x21
               	fcmp	d0, d1
               	cset	x15, ne
               	cbz	x15, 0x4005b4 <.text+0x1f4>
               	mov	x21, #0x0               // =0
               	stur	w21, [x29, #-0x8]
               	b	0x4005b4 <.text+0x1f4>
               	mov	x20, #0x6666            // =26214
               	movk	x20, #0x6666, lsl #16
               	movk	x20, #0x6666, lsl #32
               	movk	x20, #0x4002, lsl #48
               	fmov	d0, x20
               	bl	0x40082c <ceil>
               	fmov	x0, d0
               	mov	x15, x0
               	mov	x20, #0x4008000000000000 // =4613937818241073152
               	fmov	d0, x15
               	fmov	d1, x20
               	fcmp	d0, d1
               	cset	x13, ne
               	cbz	x13, 0x4005f8 <.text+0x238>
               	mov	x20, #0x0               // =0
               	stur	w20, [x29, #-0x8]
               	b	0x4005f8 <.text+0x238>
               	mov	x21, #0x400c000000000000 // =4615063718147915776
               	fmov	d0, x21
               	fneg	d8, d0
               	fmov	x16, d8
               	fmov	d0, x16
               	bl	0x400838 <fabs>
               	fmov	x0, d0
               	mov	x13, x0
               	fmov	d0, x13
               	fmov	d1, x21
               	fcmp	d0, d1
               	cset	x15, ne
               	cbz	x15, 0x400638 <.text+0x278>
               	mov	x13, #0x0               // =0
               	stur	w13, [x29, #-0x8]
               	b	0x400638 <.text+0x278>
               	mov	x20, #0x401c000000000000 // =4619567317775286272
               	mov	x22, #0x4010000000000000 // =4616189618054758400
               	fmov	d0, x20
               	fmov	d1, x22
               	bl	0x400844 <fmod>
               	fmov	x0, d0
               	mov	x21, x0
               	mov	x22, #0x4008000000000000 // =4613937818241073152
               	fmov	d0, x21
               	fmov	d1, x22
               	fcmp	d0, d1
               	cset	x20, ne
               	cbz	x20, 0x400678 <.text+0x2b8>
               	mov	x22, #0x0               // =0
               	stur	w22, [x29, #-0x8]
               	b	0x400678 <.text+0x2b8>
               	ldursw	x22, [x29, #-0x8]
               	cbz	x22, 0x40068c <.text+0x2cc>
               	mov	x20, #0xb               // =11
               	stur	x20, [x29, #-0x48]
               	b	0x400698 <.text+0x2d8>
               	mov	x20, #0x0               // =0
               	stur	x20, [x29, #-0x48]
               	b	0x400698 <.text+0x2d8>
               	ldur	x20, [x29, #-0x48]
               	mov	x0, x20
               	ldr	x20, [sp, #0x10]
               	ldr	x21, [sp, #0x18]
               	ldr	x22, [sp, #0x20]
               	ldr	d8, [sp]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
