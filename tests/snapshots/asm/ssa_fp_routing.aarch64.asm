
ssa_fp_routing.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0x3ff8000000000000 // =4609434218613702656
               	mov	x1, #0x4002000000000000 // =4612248968380809216
               	fmov	d16, x0
               	fmov	d17, x1
               	fadd	d0, d16, d17
               	mov	x1, #0x400e000000000000 // =4615626668101337088
               	fmov	d17, x1
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x2, #0x4014000000000000 // =4617315517961601024
               	fmov	d16, x2
               	fmov	d17, x0
               	fsub	d0, d16, d17
               	mov	x0, #0x400c000000000000 // =4615063718147915776
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x4004000000000000 // =4612811918334230528
               	mov	x2, #0x4010000000000000 // =4616189618054758400
               	fmov	d16, x0
               	fmov	d17, x2
               	fmul	d0, d16, d17
               	mov	x3, #0x4024000000000000 // =4621819117588971520
               	fmov	d17, x3
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x3, #0x402e000000000000 // =4624633867356078080
               	fmov	d16, x3
               	fmov	d17, x2
               	fdiv	d0, d16, d17
               	fmov	d17, x1
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	fmov	d16, x0
               	fneg	d0, d16
               	fcmp	d0, d0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x401c000000000000 // =4619567317775286272
               	fmov	d16, x0
               	fneg	d0, d16
               	fneg	d0, d0
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d16, x0
               	fmov	d17, x0
               	fcmp	d16, d17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	mov	x1, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x0
               	fmov	d17, x1
               	fcmp	d16, d17
               	cset	x2, eq
               	sxtw	x2, w2
               	cbz	x2, <addr>
               	mov	x0, #0x8                // =8
               	ret
               	fmov	d16, x0
               	fmov	d17, x1
               	fcmp	d16, d17
               	b.ne	<addr>
               	mov	x0, #0x9                // =9
               	ret
               	fmov	d16, x0
               	fmov	d17, x0
               	fcmp	d16, d17
               	cset	x2, ne
               	sxtw	x2, w2
               	cbz	x2, <addr>
               	mov	x0, #0xa                // =10
               	ret
               	fmov	d16, x0
               	fmov	d17, x1
               	fcmp	d16, d17
               	b.mi	<addr>
               	mov	x0, #0xb                // =11
               	ret
               	fmov	d16, x1
               	fmov	d17, x0
               	fcmp	d16, d17
               	cset	x2, mi
               	sxtw	x2, w2
               	cbz	x2, <addr>
               	mov	x0, #0xc                // =12
               	ret
               	fmov	d16, x1
               	fmov	d17, x0
               	fcmp	d16, d17
               	b.gt	<addr>
               	mov	x0, #0xd                // =13
               	ret
               	fmov	d16, x0
               	fmov	d17, x1
               	fcmp	d16, d17
               	cset	x2, gt
               	sxtw	x2, w2
               	cbz	x2, <addr>
               	mov	x0, #0xe                // =14
               	ret
               	fmov	d16, x0
               	fmov	d17, x0
               	fcmp	d16, d17
               	b.ls	<addr>
               	mov	x0, #0xf                // =15
               	ret
               	fmov	d16, x0
               	fmov	d17, x1
               	fcmp	d16, d17
               	b.ls	<addr>
               	mov	x0, #0x10               // =16
               	ret
               	fmov	d16, x1
               	fmov	d17, x0
               	fcmp	d16, d17
               	cset	x2, ls
               	sxtw	x2, w2
               	cbz	x2, <addr>
               	mov	x0, #0x11               // =17
               	ret
               	fmov	d16, x0
               	fmov	d17, x0
               	fcmp	d16, d17
               	b.ge	<addr>
               	mov	x0, #0x12               // =18
               	ret
               	fmov	d16, x1
               	fmov	d17, x0
               	fcmp	d16, d17
               	b.ge	<addr>
               	mov	x0, #0x13               // =19
               	ret
               	mov	x1, #0x3ff0000000000000 // =4607182418800017408
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x1
               	fmov	d17, x0
               	fcmp	d16, d17
               	cset	x1, ge
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	mov	x0, #0x14               // =20
               	ret
               	mov	x1, #0x2a               // =42
               	scvtf	d0, x1
               	mov	x1, #0x4045000000000000 // =4631107791820423168
               	fmov	d17, x1
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	ret
               	mov	x1, #0xfffd             // =65533
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	scvtf	d0, x1
               	mov	x1, #0x4008000000000000 // =4613937818241073152
               	fmov	d16, x1
               	fneg	d1, d16
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	ret
               	mov	x2, #0x400e000000000000 // =4615626668101337088
               	fmov	d16, x2
               	fcvtzs	x1, d16
               	cmp	w1, #0x3
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	ret
               	fmov	d16, x2
               	fneg	d0, d16
               	fcvtzs	x1, d0
               	mov	x17, #0xfffd            // =65533
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0x18               // =24
               	ret
               	mov	x1, #0x999a             // =39322
               	movk	x1, #0x9999, lsl #16
               	movk	x1, #0x9999, lsl #32
               	movk	x1, #0x3fb9, lsl #48
               	fmov	d16, x1
               	fcvt	s0, d16
               	fcvt	d0, s0
               	fmov	d17, x1
               	fcmp	d0, d17
               	b.ne	<addr>
               	mov	x0, #0x19               // =25
               	ret
               	fmov	d16, x0
               	fcvt	s0, d16
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x1a               // =26
               	ret
               	mov	x0, #0x0                // =0
               	ret
