
local_init_int_to_float.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xf0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x14, [x14]
               	cbz	x14, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x13, x19
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
               	adrp	x19, <page>
               	add	x19, x19, #0x118
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x19, <page>
               	add	x19, x19, #0x11e
               	mov	x12, x19
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x19, <page>
               	add	x19, x19, #0x125
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x1, [x11]
               	bl	<addr>
               	mov	x11, x0
               	cbz	x11, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x1, x19
               	lsl	x0, x20, #3
               	add	x1, x1, x0
               	ldr	x11, [x11]
               	str	x11, [x1]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x11, x19
               	lsl	x20, x20, #3
               	add	x11, x11, x20
               	ldr	x11, [x11]
               	mov	x0, x11
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xa0
               	str	x19, [sp]
               	sub	x15, x29, #0x8
               	adrp	x19, <page>
               	add	x19, x19, #0x150
               	mov	x14, x19
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x14]
               	strb	w10, [x15]
               	ldrb	w10, [x14, #0x1]
               	strb	w10, [x15, #0x1]
               	ldrb	w10, [x14, #0x2]
               	strb	w10, [x15, #0x2]
               	ldrb	w10, [x14, #0x3]
               	strb	w10, [x15, #0x3]
               	ldr	x10, [sp], #0x10
               	sub	x15, x29, #0x8
               	ldrb	w15, [x15]
               	scvtf	d7, x15
               	sub	x15, x29, #0x10
               	fcvt	s0, d7
               	str	s0, [x15]
               	sub	x16, x29, #0x10
               	ldr	s6, [x16]
               	fcvt	d6, s6
               	mov	x15, #0x3333            // =13107
               	movk	x15, #0x3333, lsl #16
               	movk	x15, #0xf333, lsl #32
               	movk	x15, #0x4044, lsl #48
               	fmov	d1, x15
               	fcmp	d6, d1
               	cset	x14, mi
               	stur	x14, [x29, #-0x78]
               	cbnz	x14, <addr>
               	sub	x16, x29, #0x10
               	ldr	s6, [x16]
               	fcvt	d6, s6
               	mov	x14, #0xcccd            // =52429
               	movk	x14, #0xcccc, lsl #16
               	movk	x14, #0xccc, lsl #32
               	movk	x14, #0x4045, lsl #48
               	fmov	d1, x14
               	fcmp	d6, d1
               	cset	x15, gt
               	stur	x15, [x29, #-0x78]
               	b	<addr>
               	ldur	x15, [x29, #-0x78]
               	cbz	x15, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x154
               	mov	x0, x19
               	sub	x16, x29, #0x10
               	ldr	s6, [x16]
               	fcvt	d6, s6
               	fmov	x16, d6
               	fmov	d0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x15, x0
               	mov	x15, #0x1               // =1
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3039             // =12345
               	scvtf	d6, x0
               	sub	x0, x29, #0x20
               	fcvt	s0, d6
               	str	s0, [x0]
               	sub	x16, x29, #0x20
               	ldr	s7, [x16]
               	fcvt	d7, s7
               	mov	x0, #0x1c4000000000     // =31061203484672
               	movk	x0, #0x40c8, lsl #48
               	fmov	d1, x0
               	fcmp	d7, d1
               	cset	x15, mi
               	stur	x15, [x29, #-0x80]
               	cbnz	x15, <addr>
               	sub	x16, x29, #0x20
               	ldr	s7, [x16]
               	fcvt	d7, s7
               	mov	x15, #0x1cc000000000    // =31610959298560
               	movk	x15, #0x40c8, lsl #48
               	fmov	d1, x15
               	fcmp	d7, d1
               	cset	x0, gt
               	stur	x0, [x29, #-0x80]
               	b	<addr>
               	ldur	x0, [x29, #-0x80]
               	cbz	x0, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x16a
               	mov	x15, x19
               	sub	x16, x29, #0x20
               	ldr	s7, [x16]
               	fcvt	d7, s7
               	fmov	x16, d7
               	fmov	d0, x16
               	mov	x0, x15
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x2                // =2
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0xfff9            // =65529
               	movk	x15, #0xffff, lsl #16
               	movk	x15, #0xffff, lsl #32
               	movk	x15, #0xffff, lsl #48
               	scvtf	d7, x15
               	fmov	x16, d7
               	stur	x16, [x29, #-0x30]
               	ldur	x15, [x29, #-0x30]
               	mov	x0, #0x401e000000000000 // =4620130267728707584
               	fmov	d0, x0
               	fneg	d7, d0
               	fmov	d0, x15
               	fcmp	d0, d7
               	cset	x15, mi
               	stur	x15, [x29, #-0x88]
               	cbnz	x15, <addr>
               	ldur	x0, [x29, #-0x30]
               	mov	x15, #0x401a000000000000 // =4619004367821864960
               	fmov	d0, x15
               	fneg	d7, d0
               	fmov	d0, x0
               	fcmp	d0, d7
               	cset	x0, gt
               	stur	x0, [x29, #-0x88]
               	b	<addr>
               	ldur	x0, [x29, #-0x88]
               	cbz	x0, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x182
               	mov	x15, x19
               	ldur	x1, [x29, #-0x30]
               	fmov	d0, x1
               	mov	x0, x15
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x3                // =3
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	scvtf	d7, x1
               	sub	x1, x29, #0x40
               	fcvt	s0, d7
               	str	s0, [x1]
               	sub	x16, x29, #0x40
               	ldr	s6, [x16]
               	fcvt	d6, s6
               	mov	x1, #0x90000000         // =2415919104
               	movk	x1, #0xf686, lsl #32
               	movk	x1, #0x41ef, lsl #48
               	fmov	d1, x1
               	fcmp	d6, d1
               	cset	x0, mi
               	stur	x0, [x29, #-0x90]
               	cbnz	x0, <addr>
               	sub	x16, x29, #0x40
               	ldr	s6, [x16]
               	fcvt	d6, s6
               	mov	x0, #0xb0000000         // =2952790016
               	movk	x0, #0x4cc, lsl #32
               	movk	x0, #0x41f0, lsl #48
               	fmov	d1, x0
               	fcmp	d6, d1
               	cset	x1, gt
               	stur	x1, [x29, #-0x90]
               	b	<addr>
               	ldur	x1, [x29, #-0x90]
               	cbz	x1, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x19b
               	mov	x0, x19
               	sub	x16, x29, #0x40
               	ldr	s6, [x16]
               	fcvt	d6, s6
               	fmov	x16, d6
               	fmov	d0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x1, x0
               	mov	x1, #0x4                // =4
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x999a             // =39322
               	movk	x0, #0x9999, lsl #16
               	movk	x0, #0x9999, lsl #32
               	movk	x0, #0x400d, lsl #48
               	sub	x1, x29, #0x48
               	fmov	d0, x0
               	fcvt	s0, d0
               	str	s0, [x1]
               	sub	x16, x29, #0x48
               	ldr	s6, [x16]
               	fcvt	d6, s6
               	fcvtzs	x1, d6
               	sxtw	x0, w1
               	cmp	x0, #0x3
               	b.eq	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1b3
               	mov	x15, x19
               	sxtw	x0, w1
               	mov	x1, x0
               	mov	x0, x15
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x1, x0
               	mov	x1, #0x5                // =5
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3333             // =13107
               	movk	x0, #0x3333, lsl #16
               	movk	x0, #0x3333, lsl #32
               	movk	x0, #0x4007, lsl #48
               	fmov	d0, x0
               	fneg	d6, d0
               	fmov	x16, d6
               	stur	x16, [x29, #-0x58]
               	ldur	x0, [x29, #-0x58]
               	fmov	d0, x0
               	fcvtzs	x1, d0
               	sxtw	x0, w1
               	mov	x17, #0xfffe            // =65534
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1ca
               	mov	x15, x19
               	sxtw	x0, w1
               	mov	x1, x0
               	mov	x0, x15
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x1, x0
               	mov	x1, #0x6                // =6
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
