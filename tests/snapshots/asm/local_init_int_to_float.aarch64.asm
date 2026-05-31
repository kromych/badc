
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
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
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
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x18
               	mov	x21, #0x0               // =0
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
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	<addr>
               	cbz	x0, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x22, x22, x21
               	ldr	x0, [x0]
               	str	x0, [x22]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x0, x19
               	lsl	x20, x20, #3
               	add	x0, x0, x20
               	ldr	x0, [x0]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xe0
               	str	d8, [sp]
               	str	d9, [sp, #0x8]
               	str	d10, [sp, #0x10]
               	str	x20, [sp, #0x20]
               	str	x21, [sp, #0x28]
               	str	x22, [sp, #0x30]
               	str	x19, [sp, #0x40]
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
               	mov	x20, x19
               	sub	x16, x29, #0x10
               	ldr	s8, [x16]
               	fcvt	d8, s8
               	fmov	x16, d8
               	fmov	d0, x16
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp, #0x20]
               	ldr	x21, [sp, #0x28]
               	ldr	x22, [sp, #0x30]
               	ldr	d8, [sp]
               	ldr	d9, [sp, #0x8]
               	ldr	d10, [sp, #0x10]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x3039            // =12345
               	sxtw	x20, w20
               	scvtf	d8, x20
               	sub	x20, x29, #0x20
               	fcvt	s0, d8
               	str	s0, [x20]
               	sub	x16, x29, #0x20
               	ldr	s7, [x16]
               	fcvt	d7, s7
               	mov	x20, #0x1c4000000000    // =31061203484672
               	movk	x20, #0x40c8, lsl #48
               	fmov	d1, x20
               	fcmp	d7, d1
               	cset	x0, mi
               	stur	x0, [x29, #-0x80]
               	cbnz	x0, <addr>
               	sub	x16, x29, #0x20
               	ldr	s7, [x16]
               	fcvt	d7, s7
               	mov	x0, #0x1cc000000000     // =31610959298560
               	movk	x0, #0x40c8, lsl #48
               	fmov	d1, x0
               	fcmp	d7, d1
               	cset	x20, gt
               	stur	x20, [x29, #-0x80]
               	b	<addr>
               	ldur	x20, [x29, #-0x80]
               	cbz	x20, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x16a
               	mov	x21, x19
               	sub	x16, x29, #0x20
               	ldr	s9, [x16]
               	fcvt	d9, s9
               	fmov	x16, d9
               	fmov	d0, x16
               	mov	x0, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp, #0x20]
               	ldr	x21, [sp, #0x28]
               	ldr	x22, [sp, #0x30]
               	ldr	d8, [sp]
               	ldr	d9, [sp, #0x8]
               	ldr	d10, [sp, #0x10]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0xfff9            // =65529
               	movk	x21, #0xffff, lsl #16
               	movk	x21, #0xffff, lsl #32
               	movk	x21, #0xffff, lsl #48
               	sxtw	x21, w21
               	scvtf	d9, x21
               	fmov	x16, d9
               	stur	x16, [x29, #-0x30]
               	ldur	x21, [x29, #-0x30]
               	mov	x0, #0x401e000000000000 // =4620130267728707584
               	fmov	d0, x0
               	fneg	d9, d0
               	fmov	d0, x21
               	fcmp	d0, d9
               	cset	x21, mi
               	stur	x21, [x29, #-0x88]
               	cbnz	x21, <addr>
               	ldur	x0, [x29, #-0x30]
               	mov	x21, #0x401a000000000000 // =4619004367821864960
               	fmov	d0, x21
               	fneg	d9, d0
               	fmov	d0, x0
               	fcmp	d0, d9
               	cset	x0, gt
               	stur	x0, [x29, #-0x88]
               	b	<addr>
               	ldur	x0, [x29, #-0x88]
               	cbz	x0, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x182
               	mov	x20, x19
               	ldur	x21, [x29, #-0x30]
               	fmov	d0, x21
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp, #0x20]
               	ldr	x21, [sp, #0x28]
               	ldr	x22, [sp, #0x30]
               	ldr	d8, [sp]
               	ldr	d9, [sp, #0x8]
               	ldr	d10, [sp, #0x10]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0xffff            // =65535
               	movk	x21, #0xffff, lsl #16
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x21, x17
               	scvtf	d9, x21
               	sub	x21, x29, #0x40
               	fcvt	s0, d9
               	str	s0, [x21]
               	sub	x16, x29, #0x40
               	ldr	s8, [x16]
               	fcvt	d8, s8
               	mov	x21, #0x90000000        // =2415919104
               	movk	x21, #0xf686, lsl #32
               	movk	x21, #0x41ef, lsl #48
               	fmov	d1, x21
               	fcmp	d8, d1
               	cset	x0, mi
               	stur	x0, [x29, #-0x90]
               	cbnz	x0, <addr>
               	sub	x16, x29, #0x40
               	ldr	s8, [x16]
               	fcvt	d8, s8
               	mov	x0, #0xb0000000         // =2952790016
               	movk	x0, #0x4cc, lsl #32
               	movk	x0, #0x41f0, lsl #48
               	fmov	d1, x0
               	fcmp	d8, d1
               	cset	x21, gt
               	stur	x21, [x29, #-0x90]
               	b	<addr>
               	ldur	x21, [x29, #-0x90]
               	cbz	x21, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x19b
               	mov	x22, x19
               	sub	x16, x29, #0x40
               	ldr	s10, [x16]
               	fcvt	d10, s10
               	fmov	x16, d10
               	fmov	d0, x16
               	mov	x0, x22
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp, #0x20]
               	ldr	x21, [sp, #0x28]
               	ldr	x22, [sp, #0x30]
               	ldr	d8, [sp]
               	ldr	d9, [sp, #0x8]
               	ldr	d10, [sp, #0x10]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x22, #0x999a            // =39322
               	movk	x22, #0x9999, lsl #16
               	movk	x22, #0x9999, lsl #32
               	movk	x22, #0x400d, lsl #48
               	sub	x0, x29, #0x48
               	fmov	d0, x22
               	fcvt	s0, d0
               	str	s0, [x0]
               	sub	x16, x29, #0x48
               	ldr	s10, [x16]
               	fcvt	d10, s10
               	fcvtzs	x0, d10
               	sxtw	x22, w0
               	cmp	x22, #0x3
               	b.eq	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1b3
               	mov	x21, x19
               	sxtw	x20, w0
               	mov	x0, x21
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp, #0x20]
               	ldr	x21, [sp, #0x28]
               	ldr	x22, [sp, #0x30]
               	ldr	d8, [sp]
               	ldr	d9, [sp, #0x8]
               	ldr	d10, [sp, #0x10]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x3333            // =13107
               	movk	x20, #0x3333, lsl #16
               	movk	x20, #0x3333, lsl #32
               	movk	x20, #0x4007, lsl #48
               	fmov	d0, x20
               	fneg	d10, d0
               	fmov	x16, d10
               	stur	x16, [x29, #-0x58]
               	ldur	x20, [x29, #-0x58]
               	fmov	d0, x20
               	fcvtzs	x0, d0
               	sxtw	x20, w0
               	mov	x17, #0xfffe            // =65534
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x20, x17
               	b.eq	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1ca
               	mov	x22, x19
               	sxtw	x21, w0
               	mov	x0, x22
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x6                // =6
               	ldr	x20, [sp, #0x20]
               	ldr	x21, [sp, #0x28]
               	ldr	x22, [sp, #0x30]
               	ldr	d8, [sp]
               	ldr	d9, [sp, #0x8]
               	ldr	d10, [sp, #0x10]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x0               // =0
               	mov	x0, x21
               	ldr	x20, [sp, #0x20]
               	ldr	x21, [sp, #0x28]
               	ldr	x22, [sp, #0x30]
               	ldr	d8, [sp]
               	ldr	d9, [sp, #0x8]
               	ldr	d10, [sp, #0x10]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
