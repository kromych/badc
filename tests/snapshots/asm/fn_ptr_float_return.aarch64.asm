
fn_ptr_float_return.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0x40200000         // =1075838976
               	fmov	s16, w0
               	fmov	s17, w0
               	fcmp	s16, s17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x1, #0xa                // =10
               	scvtf	s0, x1
               	mov	x1, #0x3f000000         // =1056964608
               	fmov	s17, w1
               	fmul	s0, s0, s17
               	mov	x1, #0x40a00000         // =1084227584
               	fmov	s17, w1
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x1, #0x4000000000000000 // =4611686018427387904
               	mov	x2, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d16, x1
               	fmov	d17, x2
               	fadd	d0, d16, d17
               	fcvt	s0, d0
               	mov	x2, #0x40400000         // =1077936128
               	fmov	s17, w2
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	fmov	s16, w0
               	fmov	s17, w0
               	fcmp	s16, s17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x8                // =8
               	scvtf	d0, x0
               	mov	x0, #0x3fd0000000000000 // =4598175219545276416
               	fmov	d17, x0
               	fmul	d0, d0, d17
               	fmov	d17, x1
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x0                // =0
               	ret
