
unary_plus_preserves_float.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x4003c8 <.text+0x148>
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
               	bl	0x400848 <dlsym>
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
               	cbz	x14, 0x400414 <.text+0x194>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x14, [x29, #-0x8]
               	mov	x0, #0x0                // =0
               	scvtf	d7, x0
               	fmov	d0, x14
               	fcmp	d0, d7
               	cset	x0, mi
               	cbz	x0, 0x400448 <.text+0x1c8>
               	mov	x14, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d0, x14
               	fneg	d7, d0
               	fmov	x16, d7
               	stur	x16, [x29, #-0x38]
               	b	0x400454 <.text+0x1d4>
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	stur	x0, [x29, #-0x38]
               	b	0x400454 <.text+0x1d4>
               	ldur	x0, [x29, #-0x38]
               	mov	x14, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d0, x0
               	fmov	d1, x14
               	fcmp	d0, d1
               	cset	x13, ne
               	cbz	x13, 0x400484 <.text+0x204>
               	mov	x14, #0x2               // =2
               	mov	x0, x14
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x13, [x29, #-0x8]
               	fmov	d0, x13
               	fmov	d1, x0
               	fadd	d7, d0, d1
               	mov	x13, #0x4000000000000000 // =4611686018427387904
               	fmov	d1, x13
               	fcmp	d7, d1
               	cset	x0, ne
               	cbz	x0, 0x4004bc <.text+0x23c>
               	mov	x13, #0x3               // =3
               	mov	x0, x13
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x8]
               	mov	x13, #0x0               // =0
               	scvtf	d7, x13
               	fmov	d0, x0
               	fcmp	d0, d7
               	cset	x13, mi
               	cbz	x13, 0x4004f0 <.text+0x270>
               	mov	x14, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d0, x14
               	fneg	d7, d0
               	fmov	x16, d7
               	stur	x16, [x29, #-0x40]
               	b	0x4004fc <.text+0x27c>
               	mov	x13, #0x3fe0000000000000 // =4602678819172646912
               	stur	x13, [x29, #-0x40]
               	b	0x4004fc <.text+0x27c>
               	ldur	x13, [x29, #-0x40]
               	fmov	d0, x0
               	fmov	d1, x13
               	fadd	d7, d0, d1
               	mov	x13, #0x4000000000000000 // =4611686018427387904
               	fmov	d1, x13
               	fcmp	d7, d1
               	cset	x0, ne
               	cbz	x0, 0x400534 <.text+0x2b4>
               	mov	x13, #0x4               // =4
               	mov	x0, x13
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x8]
               	mov	x13, #0x0               // =0
               	scvtf	d7, x13
               	fmov	d0, x0
               	fcmp	d0, d7
               	cset	x13, mi
               	cbz	x13, 0x400568 <.text+0x2e8>
               	mov	x14, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d0, x14
               	fneg	d7, d0
               	fmov	x16, d7
               	stur	x16, [x29, #-0x48]
               	b	0x400574 <.text+0x2f4>
               	mov	x13, #0x3fe0000000000000 // =4602678819172646912
               	stur	x13, [x29, #-0x48]
               	b	0x400574 <.text+0x2f4>
               	ldur	x13, [x29, #-0x48]
               	fmov	d0, x0
               	fmov	d1, x13
               	fadd	d7, d0, d1
               	fcvtzs	x13, d7
               	cmp	x13, #0x2
               	b.eq	0x4005a4 <.text+0x324>
               	mov	x13, #0x5               // =5
               	mov	x0, x13
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x8]
               	mov	x13, #0x0               // =0
               	scvtf	d7, x13
               	fmov	d0, x0
               	fcmp	d0, d7
               	cset	x13, mi
               	cbz	x13, 0x4005d8 <.text+0x358>
               	mov	x14, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d0, x14
               	fneg	d7, d0
               	fmov	x16, d7
               	stur	x16, [x29, #-0x50]
               	b	0x4005e4 <.text+0x364>
               	mov	x13, #0x3fe0000000000000 // =4602678819172646912
               	stur	x13, [x29, #-0x50]
               	b	0x4005e4 <.text+0x364>
               	ldur	x13, [x29, #-0x50]
               	fmov	d0, x0
               	fmov	d1, x13
               	fadd	d7, d0, d1
               	fcvtzs	x13, d7
               	scvtf	d7, x13
               	fmov	x16, d7
               	stur	x16, [x29, #-0x20]
               	ldur	x13, [x29, #-0x20]
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d0, x13
               	fmov	d1, x0
               	fcmp	d0, d1
               	cset	x14, ne
               	cbz	x14, 0x400630 <.text+0x3b0>
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
               	cbz	x0, 0x400678 <.text+0x3f8>
               	mov	x13, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d0, x13
               	fneg	d7, d0
               	fmov	x16, d7
               	stur	x16, [x29, #-0x58]
               	b	0x400684 <.text+0x404>
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	stur	x0, [x29, #-0x58]
               	b	0x400684 <.text+0x404>
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
               	cset	x14, ne
               	cbz	x14, 0x4006d4 <.text+0x454>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x7               // =7
               	sxtw	x0, w14
               	cmp	x0, #0x7
               	b.eq	0x4006f4 <.text+0x474>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x0               // =0
               	mov	x0, x14
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
