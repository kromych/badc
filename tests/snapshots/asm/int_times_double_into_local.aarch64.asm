
int_times_double_into_local.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xe8]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	sxtw	x20, w0
               	adrp	x19, <page>
               	add	x19, x19, #0xf8
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x13, [x14]
               	cbz	x13, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0xf8
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
               	adrp	x19, <page>
               	add	x19, x19, #0x110
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x19, <page>
               	add	x19, x19, #0x116
               	mov	x12, x19
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x19, <page>
               	add	x19, x19, #0x11d
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	<addr>
               	cbz	x0, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0xf8
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x22, x22, x21
               	ldr	x21, [x0]
               	str	x21, [x22]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0xf8
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
               	sub	sp, sp, #0x20
               	sxtw	x15, w0
               	sxtw	x15, w1
               	mov	x14, #0x2d18            // =11544
               	movk	x14, #0x5444, lsl #16
               	movk	x14, #0x21fb, lsl #32
               	movk	x14, #0x4009, lsl #48
               	mov	x13, #0xfffe            // =65534
               	movk	x13, #0xffff, lsl #16
               	movk	x13, #0xffff, lsl #32
               	movk	x13, #0xffff, lsl #48
               	scvtf	d7, x13
               	fmov	d1, x14
               	fmul	d7, d7, d1
               	scvtf	d6, x15
               	fmul	d7, d7, d6
               	fmov	x16, d7
               	stur	x16, [x29, #-0x10]
               	ldur	x0, [x29, #-0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	mov	x15, #0x0               // =0
               	mov	x14, #0x2d18            // =11544
               	movk	x14, #0x5444, lsl #16
               	movk	x14, #0x21fb, lsl #32
               	movk	x14, #0x4009, lsl #48
               	mov	x13, #0xfffe            // =65534
               	movk	x13, #0xffff, lsl #16
               	movk	x13, #0xffff, lsl #32
               	movk	x13, #0xffff, lsl #48
               	scvtf	d7, x13
               	fmov	d1, x14
               	fmul	d7, d7, d1
               	scvtf	d6, x15
               	fmul	d7, d7, d6
               	fmov	x16, d7
               	stur	x16, [x29, #-0x18]
               	ldur	x14, [x29, #-0x18]
               	fmov	d0, x14
               	fmov	d1, x15
               	fcmp	d0, d1
               	cset	x14, ne
               	cbz	x14, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x1               // =1
               	mov	x0, #0x2d18             // =11544
               	movk	x0, #0x5444, lsl #16
               	movk	x0, #0x21fb, lsl #32
               	movk	x0, #0x4009, lsl #48
               	mov	x13, #0xfffe            // =65534
               	movk	x13, #0xffff, lsl #16
               	movk	x13, #0xffff, lsl #32
               	movk	x13, #0xffff, lsl #48
               	scvtf	d7, x13
               	fmov	d1, x0
               	fmul	d7, d7, d1
               	scvtf	d6, x14
               	fmul	d7, d7, d6
               	fmov	x16, d7
               	stur	x16, [x29, #-0x28]
               	ldur	x14, [x29, #-0x28]
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d0, x0
               	fneg	d7, d0
               	mov	x0, #0x2d18             // =11544
               	movk	x0, #0x5444, lsl #16
               	movk	x0, #0x21fb, lsl #32
               	movk	x0, #0x4009, lsl #48
               	fmov	d1, x0
               	fmul	d7, d7, d1
               	fmov	d0, x14
               	fcmp	d0, d7
               	cset	x14, ne
               	cbz	x14, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x2               // =2
               	mov	x0, #0x2d18             // =11544
               	movk	x0, #0x5444, lsl #16
               	movk	x0, #0x21fb, lsl #32
               	movk	x0, #0x4009, lsl #48
               	mov	x13, #0xfffe            // =65534
               	movk	x13, #0xffff, lsl #16
               	movk	x13, #0xffff, lsl #32
               	movk	x13, #0xffff, lsl #48
               	scvtf	d7, x13
               	fmov	d1, x0
               	fmul	d7, d7, d1
               	scvtf	d6, x14
               	fmul	d7, d7, d6
               	fmov	x16, d7
               	stur	x16, [x29, #-0x38]
               	ldur	x14, [x29, #-0x38]
               	mov	x0, #0x4010000000000000 // =4616189618054758400
               	fmov	d0, x0
               	fneg	d7, d0
               	mov	x0, #0x2d18             // =11544
               	movk	x0, #0x5444, lsl #16
               	movk	x0, #0x21fb, lsl #32
               	movk	x0, #0x4009, lsl #48
               	fmov	d1, x0
               	fmul	d7, d7, d1
               	fmov	d0, x14
               	fcmp	d0, d7
               	cset	x14, ne
               	cbz	x14, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x0               // =0
               	mov	x0, x14
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
