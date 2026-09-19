
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
               	fmov	s0, #2.50000000
               	fcmp	s0, s0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0xa                // =10
               	scvtf	s1, x0
               	fmov	s2, #0.50000000
               	fmul	s1, s1, s2
               	fmov	s2, #5.00000000
               	fcmp	s1, s2
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	fmov	d1, #2.00000000
               	fmov	d2, #1.00000000
               	fadd	d2, d1, d2
               	fcvt	s2, d2
               	fmov	s3, #3.00000000
               	fcmp	s2, s3
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	fcmp	s0, s0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x8                // =8
               	scvtf	d0, x0
               	fmov	d2, #0.25000000
               	fmul	d0, d0, d2
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x0                // =0
               	ret
