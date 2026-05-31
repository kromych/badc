
int_times_double_into_local.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400428 <.text+0x1a8>
               	adrp	x16, 0x410000
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
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x12, x14, x13
               	ldr	x13, [x12]
               	cbz	x13, 0x40030c <.text+0x8c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
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
               	add	x19, x19, #0x110
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x12, x11, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x116
               	mov	x11, x19
               	str	x11, [x12]
               	sub	x14, x29, #0x18
               	add	x11, x14, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x11d
               	mov	x14, x19
               	str	x14, [x11]
               	sub	x12, x29, #0x18
               	lsl	x14, x20, #3
               	add	x11, x12, x14
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x4006a8 <dlsym>
               	cbz	x0, 0x400394 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x12, x22, x21
               	ldr	x21, [x0]
               	str	x21, [x12]
               	b	0x400394 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
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
               	fmul	d6, d7, d1
               	scvtf	d7, x15
               	fmul	d5, d6, d7
               	fmov	x16, d5
               	stur	x16, [x29, #-0x10]
               	ldur	x0, [x29, #-0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	mov	x20, #0x8               // =8
               	mov	x21, #0x0               // =0
               	mov	x0, x20
               	mov	x1, x21
               	bl	0x4003c8 <.text+0x148>
               	fmov	d0, x0
               	fmov	d1, x21
               	fcmp	d0, d1
               	cset	x20, ne
               	cbz	x20, 0x400484 <.text+0x204>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x22, #0x8               // =8
               	mov	x20, #0x1               // =1
               	mov	x0, x22
               	mov	x1, x20
               	bl	0x4003c8 <.text+0x148>
               	mov	x20, #0x4000000000000000 // =4611686018427387904
               	fmov	d0, x20
               	fneg	d7, d0
               	mov	x20, #0x2d18            // =11544
               	movk	x20, #0x5444, lsl #16
               	movk	x20, #0x21fb, lsl #32
               	movk	x20, #0x4009, lsl #48
               	fmov	d1, x20
               	fmul	d6, d7, d1
               	fmov	d0, x0
               	fcmp	d0, d6
               	cset	x20, ne
               	cbz	x20, 0x4004e8 <.text+0x268>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x8               // =8
               	mov	x20, #0x2               // =2
               	mov	x0, x21
               	mov	x1, x20
               	bl	0x4003c8 <.text+0x148>
               	mov	x20, #0x4010000000000000 // =4616189618054758400
               	fmov	d0, x20
               	fneg	d6, d0
               	mov	x20, #0x2d18            // =11544
               	movk	x20, #0x5444, lsl #16
               	movk	x20, #0x21fb, lsl #32
               	movk	x20, #0x4009, lsl #48
               	fmov	d1, x20
               	fmul	d7, d6, d1
               	fmov	d0, x0
               	fcmp	d0, d7
               	cset	x20, ne
               	cbz	x20, 0x40054c <.text+0x2cc>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x0               // =0
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
