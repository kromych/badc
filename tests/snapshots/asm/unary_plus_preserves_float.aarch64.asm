
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
