
branch_fuse_fp_nan.aarch64:	file format elf64-littleaarch64

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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0]
               	ldr	d1, [x0]
               	fdiv	d0, d0, d1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	s2, [x0]
               	ldr	s3, [x0]
               	fdiv	s2, s2, s3
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	s3, [x0]
               	fcmp	d0, d1
               	b.pl	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	fcmp	d0, d1
               	b.le	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	fcmp	d0, d1
               	b.hi	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	fcmp	d0, d1
               	b.lt	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	fcmp	d0, d1
               	b.ne	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	fcmp	d0, d0
               	b.ne	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	fcmp	d0, d1
               	b.eq	<addr>
               	fcmp	d0, d0
               	b.eq	<addr>
               	fcmp	d1, d0
               	b.pl	<addr>
               	mov	x0, #0x9                // =9
               	ret
               	fcmp	d1, d0
               	b.le	<addr>
               	mov	x0, #0xa                // =10
               	ret
               	fcmp	d1, d0
               	b.hi	<addr>
               	mov	x0, #0xb                // =11
               	ret
               	fcmp	d1, d0
               	b.lt	<addr>
               	mov	x0, #0xc                // =12
               	ret
               	fcmp	d0, d1
               	b.mi	<addr>
               	fcmp	d0, d1
               	b.ge	<addr>
               	fcmp	d0, d1
               	b.eq	<addr>
               	fcmp	d0, d1
               	b.ne	<addr>
               	mov	x0, #0x10               // =16
               	ret
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x0
               	fcmp	d1, d17
               	b.pl	<addr>
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x0
               	fcmp	d1, d17
               	b.le	<addr>
               	mov	x0, #0x12               // =18
               	ret
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d17, x0
               	fcmp	d1, d17
               	b.ne	<addr>
               	fcmp	s2, s3
               	b.pl	<addr>
               	mov	x0, #0x14               // =20
               	ret
               	fcmp	s2, s3
               	b.le	<addr>
               	mov	x0, #0x15               // =21
               	ret
               	fcmp	s2, s3
               	b.hi	<addr>
               	mov	x0, #0x16               // =22
               	ret
               	fcmp	s2, s3
               	b.lt	<addr>
               	mov	x0, #0x17               // =23
               	ret
               	fcmp	s2, s2
               	b.ne	<addr>
               	mov	x0, #0x18               // =24
               	ret
               	fcmp	s2, s2
               	b.eq	<addr>
               	mov	x0, #0x40000000         // =1073741824
               	fmov	s17, w0
               	fcmp	s3, s17
               	b.pl	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x1a               // =26
               	ret
               	mov	x0, #0x19               // =25
               	ret
               	mov	x0, #0x13               // =19
               	ret
               	mov	x0, #0x11               // =17
               	ret
               	mov	x0, #0xf                // =15
               	ret
               	mov	x0, #0xe                // =14
               	ret
               	mov	x0, #0xd                // =13
               	ret
               	mov	x0, #0x8                // =8
               	ret
               	mov	x0, #0x7                // =7
               	ret
