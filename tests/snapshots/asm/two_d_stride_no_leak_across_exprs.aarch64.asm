
two_d_stride_no_leak_across_exprs.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x500
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x500
               	sxtw	x1, w0
               	lsl	x3, x1, #2
               	add	x2, x2, x3
               	scvtf	s0, x1
               	mov	x3, #0x3e800000         // =1048576000
               	fmov	s17, w3
               	fmul	s0, s0, s17
               	str	s0, [x2]
               	add	x0, x1, #0x1
               	cmp	w0, #0x40
               	b.lt	<addr>
               	sub	x0, x29, #0x500
               	ldr	s0, [x0, #0x20]
               	mov	x1, #0x40000000         // =1073741824
               	fmov	s17, w1
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x500
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x42c60000         // =1120272384
               	fmov	s16, w1
               	str	s16, [x0]
               	ldr	s0, [x0]
               	fmov	s17, w1
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x500
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x500
               	ldp	x29, x30, [sp], #0x10
               	ret
