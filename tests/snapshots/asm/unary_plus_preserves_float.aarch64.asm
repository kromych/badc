
unary_plus_preserves_float.aarch64:	file format elf64-littleaarch64

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
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	adrp	x14, <page>
               	add	x14, x14, #0xf8
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x14, [x14]
               	cbz	x14, <addr>
               	adrp	x13, <page>
               	add	x13, x13, #0xf8
               	lsl	x14, x20, #3
               	add	x13, x13, x14
               	ldr	x13, [x13]
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x18
               	mov	x0, #0x0                // =0
               	adrp	x12, <page>
               	add	x12, x12, #0x110
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x12, <page>
               	add	x12, x12, #0x116
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x12, <page>
               	add	x12, x12, #0x11d
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x1, [x11]
               	bl	<addr>
               	cbz	x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, #0xf8
               	lsl	x11, x20, #3
               	add	x1, x1, x11
               	ldr	x0, [x0]
               	str	x0, [x1]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0xf8
               	lsl	x20, x20, #3
               	add	x0, x0, x20
               	ldr	x0, [x0]
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	mov	x15, #0x3ff8000000000000 // =4609434218613702656
               	stur	x15, [x29, #-0x8]
               	ldur	x14, [x29, #-0x8]
               	mov	x15, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d0, x14
               	fmov	d1, x15
               	fadd	d7, d0, d1
               	mov	x15, #0x4000000000000000 // =4611686018427387904
               	fmov	d1, x15
               	fcmp	d7, d1
               	cset	x14, ne
               	cbz	x14, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x14, [x29, #-0x8]
               	mov	x0, #0x0                // =0
               	scvtf	d7, x0
               	fmov	d0, x14
               	fcmp	d0, d7
               	cset	x14, mi
               	cbz	x14, <addr>
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d0, x0
               	fneg	d7, d0
               	fmov	x16, d7
               	stur	x16, [x29, #-0x38]
               	b	<addr>
               	mov	x14, #0x3fe0000000000000 // =4602678819172646912
               	stur	x14, [x29, #-0x38]
               	b	<addr>
               	ldur	x14, [x29, #-0x38]
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d0, x14
               	fmov	d1, x0
               	fcmp	d0, d1
               	cset	x13, ne
               	cbz	x13, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x13, [x29, #-0x8]
               	fmov	d0, x13
               	fmov	d1, x14
               	fadd	d7, d0, d1
               	mov	x13, #0x4000000000000000 // =4611686018427387904
               	fmov	d1, x13
               	fcmp	d7, d1
               	cset	x14, ne
               	cbz	x14, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x14, [x29, #-0x8]
               	mov	x0, #0x0                // =0
               	scvtf	d7, x0
               	fmov	d0, x14
               	fcmp	d0, d7
               	cset	x0, mi
               	cbz	x0, <addr>
               	mov	x13, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d0, x13
               	fneg	d7, d0
               	fmov	x16, d7
               	stur	x16, [x29, #-0x40]
               	b	<addr>
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	stur	x0, [x29, #-0x40]
               	b	<addr>
               	ldur	x0, [x29, #-0x40]
               	fmov	d0, x14
               	fmov	d1, x0
               	fadd	d7, d0, d1
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d1, x0
               	fcmp	d7, d1
               	cset	x14, ne
               	cbz	x14, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x14, [x29, #-0x8]
               	mov	x0, #0x0                // =0
               	scvtf	d7, x0
               	fmov	d0, x14
               	fcmp	d0, d7
               	cset	x0, mi
               	cbz	x0, <addr>
               	mov	x13, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d0, x13
               	fneg	d7, d0
               	fmov	x16, d7
               	stur	x16, [x29, #-0x48]
               	b	<addr>
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	stur	x0, [x29, #-0x48]
               	b	<addr>
               	ldur	x0, [x29, #-0x48]
               	fmov	d0, x14
               	fmov	d1, x0
               	fadd	d7, d0, d1
               	fcvtzs	x0, d7
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x14, #0x5               // =5
               	mov	x0, x14
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x8]
               	mov	x14, #0x0               // =0
               	scvtf	d7, x14
               	fmov	d0, x0
               	fcmp	d0, d7
               	cset	x14, mi
               	cbz	x14, <addr>
               	mov	x13, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d0, x13
               	fneg	d7, d0
               	fmov	x16, d7
               	stur	x16, [x29, #-0x50]
               	b	<addr>
               	mov	x14, #0x3fe0000000000000 // =4602678819172646912
               	stur	x14, [x29, #-0x50]
               	b	<addr>
               	ldur	x14, [x29, #-0x50]
               	fmov	d0, x0
               	fmov	d1, x14
               	fadd	d7, d0, d1
               	fcvtzs	x14, d7
               	scvtf	d7, x14
               	fmov	x16, d7
               	stur	x16, [x29, #-0x20]
               	ldur	x14, [x29, #-0x20]
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d0, x14
               	fmov	d1, x0
               	fcmp	d0, d1
               	cset	x14, ne
               	cbz	x14, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d0, x14
               	fneg	d7, d0
               	fmov	x16, d7
               	stur	x16, [x29, #-0x8]
               	ldur	x14, [x29, #-0x8]
               	mov	x0, #0x0                // =0
               	scvtf	d7, x0
               	fmov	d0, x14
               	fcmp	d0, d7
               	cset	x0, mi
               	cbz	x0, <addr>
               	mov	x13, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d0, x13
               	fneg	d7, d0
               	fmov	x16, d7
               	stur	x16, [x29, #-0x58]
               	b	<addr>
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	stur	x0, [x29, #-0x58]
               	b	<addr>
               	ldur	x0, [x29, #-0x58]
               	fmov	d0, x14
               	fmov	d1, x0
               	fadd	d7, d0, d1
               	fcvtzs	x0, d7
               	scvtf	d7, x0
               	fmov	x16, d7
               	stur	x16, [x29, #-0x28]
               	ldur	x0, [x29, #-0x28]
               	mov	x14, #0x4000000000000000 // =4611686018427387904
               	fmov	d0, x14
               	fneg	d7, d0
               	fmov	d0, x0
               	fcmp	d0, d7
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x14, #0x7               // =7
               	mov	x0, x14
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x14, #0x8               // =8
               	mov	x0, x14
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
