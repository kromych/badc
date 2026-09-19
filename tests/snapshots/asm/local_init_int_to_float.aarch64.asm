
local_init_int_to_float.aarch64:	file format elf64-littleaarch64

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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x2a               // =42
               	scvtf	s0, x0
               	mov	x0, #0x999a             // =39322
               	movk	x0, #0x4227, lsl #16
               	fmov	s17, w0
               	fcmp	s0, s17
               	b.mi	<addr>
               	mov	x0, #0x6666             // =26214
               	movk	x0, #0x4228, lsl #16
               	fmov	s17, w0
               	fcmp	s0, s17
               	b.le	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	fcvt	d0, s0
               	bl	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3039             // =12345
               	scvtf	s0, x0
               	mov	x0, #0xe200             // =57856
               	movk	x0, #0x4640, lsl #16
               	fmov	s17, w0
               	fcmp	s0, s17
               	b.mi	<addr>
               	mov	x0, #0xe600             // =58880
               	movk	x0, #0x4640, lsl #16
               	fmov	s17, w0
               	fcmp	s0, s17
               	b.le	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	fcvt	d0, s0
               	bl	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #-0x7               // =-7
               	scvtf	d0, x0
               	mov	x0, #0x401e000000000000 // =4620130267728707584
               	fmov	d16, x0
               	fneg	d1, d16
               	fcmp	d0, d1
               	b.mi	<addr>
               	mov	x0, #0x401a000000000000 // =4619004367821864960
               	fmov	d16, x0
               	fneg	d1, d16
               	fcmp	d0, d1
               	b.le	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xffffffff         // =4294967295
               	scvtf	s0, x0
               	mov	x0, #0xb434             // =46132
               	movk	x0, #0x4f7f, lsl #16
               	fmov	s17, w0
               	fcmp	s0, s17
               	b.mi	<addr>
               	mov	x0, #0x2666             // =9830
               	movk	x0, #0x4f80, lsl #16
               	fmov	s17, w0
               	fcmp	s0, s17
               	b.le	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	fcvt	d0, s0
               	bl	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xcccd             // =52429
               	movk	x0, #0x406c, lsl #16
               	fmov	s16, w0
               	fcvtzs	x0, s16
               	cmp	w0, #0x3
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sxtw	x0, w0
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3333             // =13107
               	movk	x0, #0x3333, lsl #16
               	movk	x0, #0x3333, lsl #32
               	movk	x0, #0x4007, lsl #48
               	fmov	d16, x0
               	fneg	d0, d16
               	fcvtzs	x0, d0
               	mov	x17, #-0x2              // =-2
               	cmp	w0, w17
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sxtw	x0, w0
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
