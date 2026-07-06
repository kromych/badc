
float_literal_f_suffix.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sub	sp, sp, #0xc0
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	str	x2, [sp, #0x10]
               	str	x3, [sp, #0x18]
               	str	x4, [sp, #0x20]
               	str	x5, [sp, #0x28]
               	str	x6, [sp, #0x30]
               	str	x7, [sp, #0x38]
               	str	d0, [sp, #0x40]
               	str	d1, [sp, #0x50]
               	str	d2, [sp, #0x60]
               	str	d3, [sp, #0x70]
               	str	d4, [sp, #0x80]
               	str	d5, [sp, #0x90]
               	str	d6, [sp, #0xa0]
               	str	d7, [sp, #0xb0]
               	str	x19, [sp, #-0x50]!
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	sub	x0, x29, #0x20
               	add	x1, x29, #0x10
               	mov	x16, x0
               	add	x17, x29, #0xd0
               	str	x17, [x16]
               	add	x17, x29, #0x50
               	str	x17, [x16, #0x8]
               	add	x17, x29, #0xd0
               	str	x17, [x16, #0x10]
               	mov	x17, #0xffc8            // =65480
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	str	w17, [x16, #0x18]
               	mov	x17, #0xff80            // =65408
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	str	w17, [x16, #0x1c]
               	mov	x1, #0x0                // =0
               	scvtf	d0, x1
               	b	<addr>
               	sub	x0, x29, #0x20
               	mov	x17, x0
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x10]
               	add	x9, x9, x16
               	add	x16, x16, #0x10
               	str	w16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x0, x16
               	ldr	d1, [x0]
               	fadd	d0, d0, d1
               	sxtw	x0, w1
               	add	x1, x0, #0x1
               	sxtw	x0, w1
               	ldursw	x2, [x29, #0x10]
               	cmp	x0, x2
               	b.lt	<addr>
               	sub	x0, x29, #0x20
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp], #0x50
               	add	sp, sp, #0xc0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x4b800000         // =1266679808
               	fmov	s16, w0
               	fmov	s17, w0
               	fcmp	s16, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x10000000         // =268435456
               	movk	x0, #0x4170, lsl #48
               	mov	x1, #0x4170000000000000 // =4715268809856909312
               	fmov	d16, x0
               	fmov	d17, x1
               	fcmp	d16, d17
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xcccd             // =52429
               	movk	x0, #0x3dcc, lsl #16
               	mov	x1, #0x999a             // =39322
               	movk	x1, #0x9999, lsl #16
               	movk	x1, #0x9999, lsl #32
               	movk	x1, #0x3fb9, lsl #48
               	fmov	s16, w0
               	fcvt	d0, s16
               	fmov	d17, x1
               	fcmp	d0, d17
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xcccd             // =52429
               	movk	x0, #0x3dcc, lsl #16
               	mov	x1, #0xa0000000         // =2684354560
               	movk	x1, #0x9999, lsl #32
               	movk	x1, #0x3fb9, lsl #48
               	fmov	s16, w0
               	fcvt	d0, s16
               	fmov	d17, x1
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xcccd             // =52429
               	movk	x0, #0x3dcc, lsl #16
               	fmov	s16, w0
               	fneg	s0, s16
               	mov	x0, #0xa0000000         // =2684354560
               	movk	x0, #0x9999, lsl #32
               	movk	x0, #0x3fb9, lsl #48
               	fmov	d16, x0
               	fneg	d1, d16
               	fcvt	d0, s0
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	mov	x1, #0x3fc00000         // =1069547520
               	fmov	s16, w1
               	fcvt	d0, s16
               	mov	x1, #0x3e800000         // =1048576000
               	fmov	s16, w1
               	fcvt	d1, s16
               	bl	<addr>
               	mov	x0, #0x3ffc000000000000 // =4610560118520545280
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	mov	x1, #0xcccd             // =52429
               	movk	x1, #0x3dcc, lsl #16
               	fmov	s16, w1
               	fcvt	d0, s16
               	bl	<addr>
               	mov	x0, #0xa0000000         // =2684354560
               	movk	x0, #0x9999, lsl #32
               	movk	x0, #0x3fb9, lsl #48
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x10               // =16
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	movk	x0, #0x4b80, lsl #16
               	fmov	s16, w0
               	fmov	s17, w0
               	fcmp	s16, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xf                // =15
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp], #0x10
               	ret
