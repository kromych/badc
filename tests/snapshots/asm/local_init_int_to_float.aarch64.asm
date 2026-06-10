
local_init_int_to_float.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2b0              // =688
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	mov	x20, x0
               	sxtw	x20, w20
               	adrp	x21, <page>
               	add	x21, x21, #0xf0
               	ldr	x0, [x21, x20, lsl #3]
               	cbz	x0, <addr>
               	ldr	x0, [x21, x20, lsl #3]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	mov	x1, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, #0x108
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	adrp	x2, <page>
               	add	x2, x2, #0x10e
               	str	x2, [x0, #0x8]
               	sub	x0, x29, #0x18
               	adrp	x2, <page>
               	add	x2, x2, #0x115
               	str	x2, [x0, #0x10]
               	sub	x0, x29, #0x18
               	ldr	x0, [x0, x20, lsl #3]
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	cbz	x0, <addr>
               	ldr	x0, [x0]
               	str	x0, [x21, x20, lsl #3]
               	ldr	x0, [x21, x20, lsl #3]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xc0
               	str	d8, [sp]
               	str	x20, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	sub	x0, x29, #0x8
               	adrp	x1, <page>
               	add	x1, x1, #0x11c
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x1]
               	strb	w10, [x0]
               	ldrb	w10, [x1, #0x1]
               	strb	w10, [x0, #0x1]
               	ldrb	w10, [x1, #0x2]
               	strb	w10, [x0, #0x2]
               	ldrb	w10, [x1, #0x3]
               	strb	w10, [x0, #0x3]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x8
               	ldrb	w0, [x0]
               	scvtf	d0, x0
               	fcvt	s0, d0
               	sub	x0, x29, #0x10
               	str	s0, [x0]
               	sub	x16, x29, #0x10
               	ldr	s0, [x16]
               	mov	x0, #0x3333             // =13107
               	movk	x0, #0x3333, lsl #16
               	movk	x0, #0xf333, lsl #32
               	movk	x0, #0x4044, lsl #48
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x20, mi
               	cbnz	x20, <addr>
               	sub	x16, x29, #0x10
               	ldr	s0, [x16]
               	mov	x0, #0xcccd             // =52429
               	movk	x0, #0xcccc, lsl #16
               	movk	x0, #0xccc, lsl #32
               	movk	x0, #0x4045, lsl #48
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x20, gt
               	cbz	x20, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x120
               	sub	x16, x29, #0x10
               	ldr	s0, [x16]
               	fcvt	d0, s0
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp, #0x10]
               	ldr	d8, [sp]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3039             // =12345
               	scvtf	d0, x0
               	fcvt	s0, d0
               	sub	x0, x29, #0x20
               	str	s0, [x0]
               	sub	x16, x29, #0x20
               	ldr	s0, [x16]
               	mov	x0, #0x1c4000000000     // =31061203484672
               	movk	x0, #0x40c8, lsl #48
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x20, mi
               	cbnz	x20, <addr>
               	sub	x16, x29, #0x20
               	ldr	s0, [x16]
               	mov	x0, #0x1cc000000000     // =31610959298560
               	movk	x0, #0x40c8, lsl #48
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x20, gt
               	cbz	x20, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x136
               	sub	x16, x29, #0x20
               	ldr	s0, [x16]
               	fcvt	d0, s0
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp, #0x10]
               	ldr	d8, [sp]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xfff9             // =65529
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	scvtf	d8, x0
               	mov	x0, #0x401e000000000000 // =4620130267728707584
               	fmov	d16, x0
               	fneg	d0, d16
               	fcmp	d8, d0
               	cset	x20, mi
               	cbnz	x20, <addr>
               	mov	x0, #0x401a000000000000 // =4619004367821864960
               	fmov	d16, x0
               	fneg	d0, d16
               	fcmp	d8, d0
               	cset	x20, gt
               	cbz	x20, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x14e
               	fmov	d0, d8
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp, #0x10]
               	ldr	d8, [sp]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	scvtf	d0, x0
               	fcvt	s0, d0
               	sub	x0, x29, #0x40
               	str	s0, [x0]
               	sub	x16, x29, #0x40
               	ldr	s0, [x16]
               	mov	x0, #0x90000000         // =2415919104
               	movk	x0, #0xf686, lsl #32
               	movk	x0, #0x41ef, lsl #48
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x20, mi
               	cbnz	x20, <addr>
               	sub	x16, x29, #0x40
               	ldr	s0, [x16]
               	mov	x0, #0xb0000000         // =2952790016
               	movk	x0, #0x4cc, lsl #32
               	movk	x0, #0x41f0, lsl #48
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x20, gt
               	cbz	x20, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x167
               	sub	x16, x29, #0x40
               	ldr	s0, [x16]
               	fcvt	d0, s0
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp, #0x10]
               	ldr	d8, [sp]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x999a             // =39322
               	movk	x0, #0x9999, lsl #16
               	movk	x0, #0x9999, lsl #32
               	movk	x0, #0x400d, lsl #48
               	fmov	d16, x0
               	fcvt	s0, d16
               	sub	x0, x29, #0x48
               	str	s0, [x0]
               	sub	x16, x29, #0x48
               	ldr	s0, [x16]
               	fcvt	d0, s0
               	fcvtzs	x0, d0
               	sxtw	x1, w0
               	cmp	x1, #0x3
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x17f
               	sxtw	x0, w0
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp, #0x10]
               	ldr	d8, [sp]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3333             // =13107
               	movk	x0, #0x3333, lsl #16
               	movk	x0, #0x3333, lsl #32
               	movk	x0, #0x4007, lsl #48
               	fmov	d16, x0
               	fneg	d0, d16
               	fcvtzs	x0, d0
               	sxtw	x1, w0
               	mov	x17, #0xfffe            // =65534
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x1, x17
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x196
               	sxtw	x0, w0
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x6                // =6
               	ldr	x20, [sp, #0x10]
               	ldr	d8, [sp]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp, #0x10]
               	ldr	d8, [sp]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
