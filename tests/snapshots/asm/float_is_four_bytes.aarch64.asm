
float_is_four_bytes.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<main>:
               	str	x20, [sp, #-0x60]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	mov	x20, #0x0               // =0
               	mov	x0, #0x3fc00000         // =1069547520
               	fmov	s16, w0
               	sub	x17, x29, #0x18
               	str	s16, [x17]
               	sub	x16, x29, #0x18
               	ldr	s0, [x16]
               	fmov	s17, w0
               	fcmp	s0, s17
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0x5               // =5
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x1, x0, #0x4
               	sub	x1, x1, x0
               	cmp	x1, #0x4
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	add	x2, x2, #0x4
               	sub	x0, x2, x0
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0x6               // =6
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	s0, [x0]
               	mov	x0, #0x3fc00000         // =1069547520
               	fmov	s17, w0
               	fcmp	s0, s17
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	s0, [x1]
               	fcvt	d0, s0
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0x7               // =7
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	s0, [x0, #0x4]
               	mov	x0, #0x40200000         // =1075838976
               	fmov	s17, w0
               	fcmp	s0, s17
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	s0, [x0, #0x4]
               	fcvt	d0, s0
               	mov	x0, x1
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0x8               // =8
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	s0, [x0, #0x8]
               	mov	x0, #0x40600000         // =1080033280
               	fmov	s17, w0
               	fcmp	s0, s17
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	s0, [x0, #0x8]
               	fcvt	d0, s0
               	mov	x0, x1
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0x9               // =9
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	s0, [x0, #0xc]
               	mov	x0, #0x40900000         // =1083179008
               	fmov	s17, w0
               	fcmp	s0, s17
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	s0, [x0, #0xc]
               	fcvt	d0, s0
               	mov	x0, x1
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0xa               // =10
               	mov	x0, #0x3fc00000         // =1069547520
               	fmov	s16, w0
               	fmov	s17, w0
               	fcmp	s16, s17
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0xb               // =11
               	mov	x0, #0x40200000         // =1075838976
               	fmov	s16, w0
               	fmov	s17, w0
               	fcmp	s16, s17
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0xc               // =12
               	mov	x0, #0x3fc00000         // =1069547520
               	mov	x1, #0x40200000         // =1075838976
               	fmov	s16, w0
               	fmov	s17, w1
               	fcmp	s16, s17
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0xd               // =13
               	mov	x0, #0x3f800000         // =1065353216
               	mov	x1, #0x40000000         // =1073741824
               	mov	x2, #0x40600000         // =1080033280
               	fmov	s16, w0
               	fmov	s17, w1
               	fadd	s0, s16, s17
               	fmov	s17, w2
               	fadd	s1, s0, s17
               	mov	x3, #0x40d00000         // =1087373312
               	fmov	s17, w3
               	fcmp	s1, s17
               	b.eq	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	fcvt	d0, s1
               	mov	x0, x3
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0xe               // =14
               	mov	x0, #0x3fc00000         // =1069547520
               	fmov	s16, w0
               	sub	x17, x29, #0x28
               	str	s16, [x17]
               	mov	x0, #0x40000000         // =1073741824
               	fmov	s16, w0
               	sub	x17, x29, #0x18
               	str	s16, [x17]
               	sub	x16, x29, #0x28
               	ldr	s0, [x16]
               	sub	x16, x29, #0x18
               	ldr	s1, [x16]
               	mov	x0, #0x3e800000         // =1048576000
               	fmov	s18, w0
               	fmadd	s0, s0, s1, s18
               	mov	x0, #0x40500000         // =1078984704
               	fmov	s17, w0
               	fcmp	s0, s17
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	fcvt	d0, s0
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0xf               // =15
               	mov	x0, #0x3f800000         // =1065353216
               	fmov	s16, w0
               	sub	x17, x29, #0x10
               	str	s16, [x17]
               	sub	x0, x29, #0x8
               	sub	x1, x29, #0x10
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	ldur	w0, [x29, #-0x8]
               	mov	x17, #0x3f800000        // =1065353216
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldur	w1, [x29, #-0x8]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0x10              // =16
               	sxtw	x0, w20
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x60
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
