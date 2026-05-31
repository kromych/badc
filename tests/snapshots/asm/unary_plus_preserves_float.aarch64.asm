
unary_plus_preserves_float.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x4003cc <.text+0x14c>
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
               	add	x14, x14, x13
               	ldr	x13, [x14]
               	cbz	x13, 0x40030c <.text+0x8c>
               	adrp	x19, 0x410000
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
               	adrp	x19, 0x410000
               	add	x19, x19, #0x110
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x116
               	mov	x12, x19
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x11d
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x400848 <dlsym>
               	cbz	x0, 0x400394 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x22, x22, x21
               	ldr	x21, [x0]
               	str	x21, [x22]
               	b	0x400394 <.text+0x114>
               	adrp	x19, 0x410000
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
               	cbz	x14, 0x400418 <.text+0x198>
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
               	cbz	x14, 0x40044c <.text+0x1cc>
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d0, x0
               	fneg	d7, d0
               	fmov	x16, d7
               	stur	x16, [x29, #-0x38]
               	b	0x400458 <.text+0x1d8>
               	mov	x14, #0x3fe0000000000000 // =4602678819172646912
               	stur	x14, [x29, #-0x38]
               	b	0x400458 <.text+0x1d8>
               	ldur	x14, [x29, #-0x38]
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d0, x14
               	fmov	d1, x0
               	fcmp	d0, d1
               	cset	x13, ne
               	cbz	x13, 0x400484 <.text+0x204>
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
               	cbz	x14, 0x4004b8 <.text+0x238>
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
               	cbz	x0, 0x4004ec <.text+0x26c>
               	mov	x13, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d0, x13
               	fneg	d7, d0
               	fmov	x16, d7
               	stur	x16, [x29, #-0x40]
               	b	0x4004f8 <.text+0x278>
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	stur	x0, [x29, #-0x40]
               	b	0x4004f8 <.text+0x278>
               	ldur	x0, [x29, #-0x40]
               	fmov	d0, x14
               	fmov	d1, x0
               	fadd	d7, d0, d1
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d1, x0
               	fcmp	d7, d1
               	cset	x14, ne
               	cbz	x14, 0x40052c <.text+0x2ac>
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
               	cbz	x0, 0x400560 <.text+0x2e0>
               	mov	x13, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d0, x13
               	fneg	d7, d0
               	fmov	x16, d7
               	stur	x16, [x29, #-0x48]
               	b	0x40056c <.text+0x2ec>
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	stur	x0, [x29, #-0x48]
               	b	0x40056c <.text+0x2ec>
               	ldur	x0, [x29, #-0x48]
               	fmov	d0, x14
               	fmov	d1, x0
               	fadd	d7, d0, d1
               	fcvtzs	x0, d7
               	cmp	x0, #0x2
               	b.eq	0x40059c <.text+0x31c>
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
               	cbz	x14, 0x4005d0 <.text+0x350>
               	mov	x13, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d0, x13
               	fneg	d7, d0
               	fmov	x16, d7
               	stur	x16, [x29, #-0x50]
               	b	0x4005dc <.text+0x35c>
               	mov	x14, #0x3fe0000000000000 // =4602678819172646912
               	stur	x14, [x29, #-0x50]
               	b	0x4005dc <.text+0x35c>
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
               	cbz	x14, 0x400628 <.text+0x3a8>
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
               	cbz	x0, 0x400670 <.text+0x3f0>
               	mov	x13, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d0, x13
               	fneg	d7, d0
               	fmov	x16, d7
               	stur	x16, [x29, #-0x58]
               	b	0x40067c <.text+0x3fc>
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	stur	x0, [x29, #-0x58]
               	b	0x40067c <.text+0x3fc>
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
               	cbz	x0, 0x4006d0 <.text+0x450>
               	mov	x14, #0x7               // =7
               	mov	x0, x14
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	sxtw	x0, w0
               	cmp	x0, #0x7
               	b.eq	0x4006f4 <.text+0x474>
               	mov	x14, #0x8               // =8
               	mov	x0, x14
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
