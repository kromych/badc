
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
               	fmov	d0, #1.50000000
               	fmov	d1, #2.25000000
               	fadd	d2, d0, d1
               	fmov	d1, #3.75000000
               	fcmp	d2, d1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	fmov	d2, #5.00000000
               	fsub	d0, d2, d0
               	fmov	d2, #3.50000000
               	fcmp	d0, d2
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	fmov	d0, #2.50000000
               	fmov	d2, #4.00000000
               	fmul	d3, d0, d2
               	fmov	d4, #10.00000000
               	fcmp	d3, d4
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	fmov	d3, #15.00000000
               	fdiv	d2, d3, d2
               	fcmp	d2, d1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	fneg	d0, d0
               	fcmp	d0, d0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	fmov	d0, #7.00000000
               	fneg	d1, d0
               	fneg	d1, d1
               	fcmp	d1, d0
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	fmov	d0, #1.00000000
               	fcmp	d0, d0
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	fmov	d1, #2.00000000
               	fcmp	d0, d1
               	b.ne	<addr>
               	mov	x0, #0x8                // =8
               	ret
               	fcmp	d0, d1
               	b.ne	<addr>
               	mov	x0, #0x9                // =9
               	ret
               	fcmp	d0, d0
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ret
               	fcmp	d0, d1
               	b.mi	<addr>
               	mov	x0, #0xb                // =11
               	ret
               	fcmp	d1, d0
               	b.pl	<addr>
               	mov	x0, #0xc                // =12
               	ret
               	fcmp	d1, d0
               	b.gt	<addr>
               	mov	x0, #0xd                // =13
               	ret
               	fcmp	d0, d1
               	b.le	<addr>
               	mov	x0, #0xe                // =14
               	ret
               	fcmp	d0, d0
               	b.ls	<addr>
               	mov	x0, #0xf                // =15
               	ret
               	fcmp	d0, d1
               	b.ls	<addr>
               	mov	x0, #0x10               // =16
               	ret
               	fcmp	d1, d0
               	b.hi	<addr>
               	mov	x0, #0x11               // =17
               	ret
               	fcmp	d0, d0
               	b.ge	<addr>
               	mov	x0, #0x12               // =18
               	ret
               	fcmp	d1, d0
               	b.ge	<addr>
               	mov	x0, #0x13               // =19
               	ret
               	fmov	d1, #1.00000000
               	fmov	d0, #2.00000000
               	fcmp	d1, d0
               	b.lt	<addr>
               	mov	x0, #0x14               // =20
               	ret
               	mov	x0, #0x2a               // =42
               	scvtf	d1, x0
               	mov	x16, #0x4045000000000000 // =4631107791820423168
               	fmov	d2, x16
               	fcmp	d1, d2
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	ret
               	mov	x0, #-0x3               // =-3
               	scvtf	d1, x0
               	fmov	d2, #3.00000000
               	fneg	d2, d2
               	fcmp	d1, d2
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	ret
               	fmov	d1, #3.75000000
               	fcvtzs	x0, d1
               	cmp	w0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	ret
               	fneg	d1, d1
               	fcvtzs	x0, d1
               	mov	x17, #-0x3              // =-3
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x18               // =24
               	ret
               	adrp	x16, <page>
               	ldr	d1, [x16]
               	fcvt	s2, d1
               	fcvt	d2, s2
               	fcmp	d2, d1
               	b.ne	<addr>
               	mov	x0, #0x19               // =25
               	ret
               	fcvt	s1, d0
               	fcvt	d1, s1
               	fcmp	d1, d0
               	b.eq	<addr>
               	mov	x0, #0x1a               // =26
               	ret
               	mov	x0, #0x0                // =0
               	ret
