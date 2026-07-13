
ssa_fp_routing.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	fadd	d0, d0, d1
               	ret

<fsub>:
               	fsub	d0, d0, d1
               	ret

<fmul>:
               	fmul	d0, d0, d1
               	ret

<fdiv>:
               	fdiv	d0, d0, d1
               	ret

<fneg>:
               	fneg	d0, d0
               	ret

<feq>:
               	fcmp	d0, d1
               	cset	x0, eq
               	sxtw	x0, w0
               	ret

<fne>:
               	fcmp	d0, d1
               	cset	x0, ne
               	sxtw	x0, w0
               	ret

<flt>:
               	fcmp	d0, d1
               	cset	x0, mi
               	sxtw	x0, w0
               	ret

<fgt>:
               	fcmp	d0, d1
               	cset	x0, gt
               	sxtw	x0, w0
               	ret

<fle>:
               	fcmp	d0, d1
               	cset	x0, ls
               	sxtw	x0, w0
               	ret

<fge>:
               	fcmp	d0, d1
               	cset	x0, ge
               	sxtw	x0, w0
               	ret

<itof>:
               	sxtw	x0, w0
               	scvtf	d0, x0
               	ret

<ftoi>:
               	fcvtzs	x0, d0
               	sxtw	x0, w0
               	ret

<round_through_f32>:
               	fcvt	s0, d0
               	fcvt	d0, s0
               	ret

<main>:
               	mov	x0, #0x3ff8000000000000 // =4609434218613702656
               	mov	x1, #0x4002000000000000 // =4612248968380809216
               	fmov	d16, x0
               	fmov	d17, x1
               	fadd	d0, d16, d17
               	mov	x0, #0x400e000000000000 // =4615626668101337088
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x4014000000000000 // =4617315517961601024
               	mov	x1, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d16, x0
               	fmov	d17, x1
               	fsub	d0, d16, d17
               	mov	x0, #0x400c000000000000 // =4615063718147915776
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x4004000000000000 // =4612811918334230528
               	mov	x1, #0x4010000000000000 // =4616189618054758400
               	fmov	d16, x0
               	fmov	d17, x1
               	fmul	d0, d16, d17
               	mov	x0, #0x4024000000000000 // =4621819117588971520
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x402e000000000000 // =4624633867356078080
               	mov	x1, #0x4010000000000000 // =4616189618054758400
               	fmov	d16, x0
               	fmov	d17, x1
               	fdiv	d0, d16, d17
               	mov	x0, #0x400e000000000000 // =4615626668101337088
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x4004000000000000 // =4612811918334230528
               	fmov	d16, x0
               	fneg	d0, d16
               	fmov	d16, x0
               	fneg	d1, d16
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x401c000000000000 // =4619567317775286272
               	fmov	d16, x0
               	fneg	d0, d16
               	fneg	d0, d0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ret
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d16, x0
               	fmov	d17, x0
               	fcmp	d16, d17
               	cset	x0, eq
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	mov	x1, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x0
               	fmov	d17, x1
               	fcmp	d16, d17
               	cset	x0, eq
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	ret
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	mov	x1, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x0
               	fmov	d17, x1
               	fcmp	d16, d17
               	cset	x0, ne
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x9                // =9
               	ret
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d16, x0
               	fmov	d17, x0
               	fcmp	d16, d17
               	cset	x0, ne
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	ret
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	mov	x1, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x0
               	fmov	d17, x1
               	fcmp	d16, d17
               	cset	x0, mi
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0xb                // =11
               	ret
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	mov	x1, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d16, x0
               	fmov	d17, x1
               	fcmp	d16, d17
               	cset	x0, mi
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xc                // =12
               	ret
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	mov	x1, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d16, x0
               	fmov	d17, x1
               	fcmp	d16, d17
               	cset	x0, gt
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0xd                // =13
               	ret
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	mov	x1, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x0
               	fmov	d17, x1
               	fcmp	d16, d17
               	cset	x0, gt
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xe                // =14
               	ret
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d16, x0
               	fmov	d17, x0
               	fcmp	d16, d17
               	cset	x0, ls
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0xf                // =15
               	ret
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	mov	x1, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x0
               	fmov	d17, x1
               	fcmp	d16, d17
               	cset	x0, ls
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x10               // =16
               	ret
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	mov	x1, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d16, x0
               	fmov	d17, x1
               	fcmp	d16, d17
               	cset	x0, ls
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x11               // =17
               	ret
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d16, x0
               	fmov	d17, x0
               	fcmp	d16, d17
               	cset	x0, ge
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x12               // =18
               	ret
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	mov	x1, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d16, x0
               	fmov	d17, x1
               	fcmp	d16, d17
               	cset	x0, ge
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x13               // =19
               	ret
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	mov	x1, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x0
               	fmov	d17, x1
               	fcmp	d16, d17
               	cset	x0, ge
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x14               // =20
               	ret
               	mov	x0, #0x2a               // =42
               	scvtf	d0, x0
               	mov	x0, #0x4045000000000000 // =4631107791820423168
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x15               // =21
               	ret
               	mov	x0, #0xfffd             // =65533
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	scvtf	d0, x0
               	mov	x0, #0x4008000000000000 // =4613937818241073152
               	fmov	d16, x0
               	fneg	d1, d16
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x16               // =22
               	ret
               	mov	x0, #0x400e000000000000 // =4615626668101337088
               	fmov	d16, x0
               	fcvtzs	x0, d16
               	sxtw	x0, w0
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	ret
               	mov	x0, #0x400e000000000000 // =4615626668101337088
               	fmov	d16, x0
               	fneg	d0, d16
               	fcvtzs	x0, d0
               	sxtw	x0, w0
               	mov	x17, #0xfffd            // =65533
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x18               // =24
               	ret
               	mov	x0, #0x999a             // =39322
               	movk	x0, #0x9999, lsl #16
               	movk	x0, #0x9999, lsl #32
               	movk	x0, #0x3fb9, lsl #48
               	fmov	d16, x0
               	fcvt	s0, d16
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, #0x19               // =25
               	ret
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x0
               	fcvt	s0, d16
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1a               // =26
               	ret
               	mov	x0, #0x0                // =0
               	ret
