
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
               	mov	x0, #0x40a00000         // =1084227584
               	fmov	s16, w0
               	fneg	s1, s16
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x4240             // =16960
               	movk	x0, #0xf, lsl #16
               	scvtf	s0, x0
               	mov	x0, #0x2400             // =9216
               	movk	x0, #0x4974, lsl #16
               	fmov	s17, w0
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x999a             // =39322
               	movk	x0, #0x4079, lsl #16
               	fmov	s16, w0
               	fcvtzs	x0, s16
               	cmp	w0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x40200000         // =1075838976
               	fmov	s16, w0
               	fneg	s0, s16
               	fcvtzs	x0, s0
               	mov	x17, #-0x2              // =-2
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x7                // =7
               	scvtf	s0, x0
               	mov	x1, #0x40000000         // =1073741824
               	fmov	s17, w1
               	fmul	s0, s0, s17
               	fcvtzs	x1, s0
               	scvtf	s0, x1
               	mov	x1, #0x41600000         // =1096810496
               	fmov	s17, w1
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x1, #0x1                // =1
               	movk	x1, #0x100, lsl #16
               	scvtf	s0, x1
               	mov	x1, #0x4b800000         // =1266679808
               	fmov	s17, w1
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	mov	x1, #0x3                // =3
               	movk	x1, #0x100, lsl #16
               	scvtf	s0, x1
               	mov	x1, #0x2                // =2
               	movk	x1, #0x4b80, lsl #16
               	fmov	s17, w1
               	fcmp	s0, s17
               	b.eq	<addr>
               	ret
               	mov	x1, #0x7fffffffffffffff // =9223372036854775807
               	mov	x0, #0x0                // =0
               	scvtf	s0, x0
               	mov	x2, #0x0                // =0
               	fmov	s17, w2
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ret
               	scvtf	s0, x1
               	mov	x1, #0x5f000000         // =1593835520
               	fmov	s17, w1
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ret
               	mov	x1, #0x40300000         // =1076887552
               	fmov	s16, w1
               	fcvtzs	x2, s16
               	cmp	x2, #0x2
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ret
               	fmov	s16, w1
               	fneg	s0, s16
               	fcvtzs	x1, s0
               	mov	x17, #-0x2              // =-2
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ret
               	ret
