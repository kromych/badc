
fp_direct_width_cast.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #-0x5               // =-5
               	scvtf	s0, x0
               	fmov	s1, #-5.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x4240             // =16960
               	movk	x0, #0xf, lsl #16
               	scvtf	s0, x0
               	adrp	x16, <page>
               	ldr	s1, [x16]
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x16, <page>
               	ldr	s0, [x16, #0x4]
               	fcvtzs	x0, s0
               	cmp	w0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	fmov	s0, #-2.50000000
               	fcvtzs	x0, s0
               	mov	x17, #-0x2              // =-2
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x7                // =7
               	scvtf	s0, x0
               	fmov	s1, #2.00000000
               	fmul	s0, s0, s1
               	fcvtzs	x1, s0
               	scvtf	s0, x1
               	fmov	s1, #14.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x1, #0x1                // =1
               	movk	x1, #0x100, lsl #16
               	scvtf	s0, x1
               	mov	x16, #0x4b800000        // =1266679808
               	fmov	s1, w16
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	mov	x1, #0x3                // =3
               	movk	x1, #0x100, lsl #16
               	scvtf	s0, x1
               	adrp	x16, <page>
               	ldr	s1, [x16, #0x8]
               	fcmp	s0, s1
               	b.eq	<addr>
               	ret
               	mov	x1, #0x7fffffffffffffff // =9223372036854775807
               	mov	x0, #0x0                // =0
               	scvtf	s0, x0
               	movi	d1, #0000000000000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ret
               	scvtf	s0, x1
               	mov	x16, #0x5f000000        // =1593835520
               	fmov	s1, w16
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ret
               	fmov	s0, #2.75000000
               	fcvtzs	x1, s0
               	cmp	x1, #0x2
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ret
               	fmov	s0, #-2.75000000
               	fcvtzs	x1, s0
               	mov	x17, #-0x2              // =-2
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ret
               	ret
