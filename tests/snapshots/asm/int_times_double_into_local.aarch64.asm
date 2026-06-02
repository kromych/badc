
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
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	adrp	x21, <page>
               	add	x21, x21, #0xf8
               	lsl	x13, x20, #3
               	add	x13, x21, x13
               	ldr	x13, [x13]
               	cbz	x13, <addr>
               	lsl	x12, x20, #3
               	add	x12, x21, x12
               	ldr	x12, [x12]
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x18
               	mov	x0, #0x0                // =0
               	adrp	x11, <page>
               	add	x11, x11, #0x110
               	str	x11, [x13]
               	sub	x10, x29, #0x18
               	add	x10, x10, #0x8
               	adrp	x11, <page>
               	add	x11, x11, #0x116
               	str	x11, [x10]
               	sub	x13, x29, #0x18
               	add	x13, x13, #0x10
               	adrp	x11, <page>
               	add	x11, x11, #0x11d
               	str	x11, [x13]
               	sub	x10, x29, #0x18
               	lsl	x11, x20, #3
               	add	x10, x10, x11
               	ldr	x1, [x10]
               	bl	<addr>
               	mov	x10, x0
               	cbz	x10, <addr>
               	lsl	x1, x20, #3
               	add	x1, x21, x1
               	ldr	x10, [x10]
               	str	x10, [x1]
               	b	<addr>
               	lsl	x20, x20, #3
               	add	x21, x21, x20
               	ldr	x21, [x21]
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
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
               	sub	sp, sp, #0x10
               	str	x20, [sp]
               	mov	x0, #0x8                // =8
               	mov	x20, #0x0               // =0
               	mov	x1, x20
               	bl	<addr>
               	mov	x13, x0
               	fmov	d0, x13
               	fmov	d1, x20
               	fcmp	d0, d1
               	cset	x13, ne
               	cbz	x13, <addr>
               	mov	x20, #0x1               // =1
               	mov	x0, x20
               	ldr	x20, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x8                // =8
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	mov	x13, x0
               	mov	x1, #0x4000000000000000 // =4611686018427387904
               	fmov	d0, x1
               	fneg	d7, d0
               	mov	x1, #0x2d18             // =11544
               	movk	x1, #0x5444, lsl #16
               	movk	x1, #0x21fb, lsl #32
               	movk	x1, #0x4009, lsl #48
               	fmov	d1, x1
               	fmul	d7, d7, d1
               	fmov	d0, x13
               	fcmp	d0, d7
               	cset	x13, ne
               	cbz	x13, <addr>
               	mov	x1, #0x2                // =2
               	mov	x0, x1
               	ldr	x20, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x8                // =8
               	mov	x1, #0x2                // =2
               	bl	<addr>
               	mov	x13, x0
               	mov	x1, #0x4010000000000000 // =4616189618054758400
               	fmov	d0, x1
               	fneg	d7, d0
               	mov	x1, #0x2d18             // =11544
               	movk	x1, #0x5444, lsl #16
               	movk	x1, #0x21fb, lsl #32
               	movk	x1, #0x4009, lsl #48
               	fmov	d1, x1
               	fmul	d7, d7, d1
               	fmov	d0, x13
               	fcmp	d0, d7
               	cset	x13, ne
               	cbz	x13, <addr>
               	mov	x1, #0x3                // =3
               	mov	x0, x1
               	ldr	x20, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x13, #0x0               // =0
               	mov	x0, x13
               	ldr	x20, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
