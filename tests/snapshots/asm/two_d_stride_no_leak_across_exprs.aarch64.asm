
two_d_stride_no_leak_across_exprs.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	ldrh	w0, [x0]
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x520
               	sub	x0, x29, #0x400
               	mov	x1, #0x7                // =7
               	strh	w1, [x0]
               	sub	x0, x29, #0x400
               	mov	x1, #0xb                // =11
               	strh	w1, [x0, #0x2]
               	sub	x0, x29, #0x400
               	ldrh	w0, [x0]
               	sxtw	x0, w0
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x520
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x508
               	lsl	x3, x1, #2
               	add	x2, x2, x3
               	scvtf	s0, x1
               	mov	x3, #0x3e800000         // =1048576000
               	fmov	s17, w3
               	fmul	s0, s0, s17
               	str	s0, [x2]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x40
               	b.lt	<addr>
               	sub	x0, x29, #0x508
               	ldr	s0, [x0, #0x20]
               	mov	x0, #0x40000000         // =1073741824
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x520
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x508
               	mov	x0, #0x42c60000         // =1120272384
               	fmov	s16, w0
               	str	s16, [x1]
               	sub	x1, x29, #0x508
               	ldr	s0, [x1]
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x520
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x520
               	ldp	x29, x30, [sp], #0x10
               	ret
