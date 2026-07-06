
local_init_int_to_float.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xa0
               	str	x19, [sp]
               	sub	x0, x29, #0x8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
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
               	mov	x0, #0x999a             // =39322
               	movk	x0, #0x4227, lsl #16
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x1, mi
               	cbnz	x1, <addr>
               	mov	x0, #0x6666             // =26214
               	movk	x0, #0x4228, lsl #16
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x1, gt
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	fcvt	d0, s0
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3039             // =12345
               	scvtf	d0, x0
               	fcvt	s0, d0
               	mov	x0, #0xe200             // =57856
               	movk	x0, #0x4640, lsl #16
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x1, mi
               	cbnz	x1, <addr>
               	mov	x0, #0xe600             // =58880
               	movk	x0, #0x4640, lsl #16
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x1, gt
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	fcvt	d0, s0
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x2                // =2
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xfff9             // =65529
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	scvtf	d0, x0
               	mov	x0, #0x401e000000000000 // =4620130267728707584
               	fmov	d16, x0
               	fneg	d1, d16
               	fcmp	d0, d1
               	cset	x1, mi
               	cbnz	x1, <addr>
               	mov	x0, #0x401a000000000000 // =4619004367821864960
               	fmov	d16, x0
               	fneg	d1, d16
               	fcmp	d0, d1
               	cset	x1, gt
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x3                // =3
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	scvtf	d0, x0
               	fcvt	s0, d0
               	mov	x0, #0xb434             // =46132
               	movk	x0, #0x4f7f, lsl #16
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x1, mi
               	cbnz	x1, <addr>
               	mov	x0, #0x2666             // =9830
               	movk	x0, #0x4f80, lsl #16
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x1, gt
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	fcvt	d0, s0
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x4                // =4
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xcccd             // =52429
               	movk	x0, #0x406c, lsl #16
               	fmov	s16, w0
               	sub	x17, x29, #0x48
               	str	s16, [x17]
               	sub	x16, x29, #0x48
               	ldr	s0, [x16]
               	fcvt	d0, s0
               	fcvtzs	x0, d0
               	sxtw	x1, w0
               	cmp	x1, #0x3
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sxtw	x0, w0
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x5                // =5
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
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
               	add	x1, x1, <lo12>
               	sxtw	x0, w0
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x6                // =6
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
