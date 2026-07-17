
float_ternary_promote.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	mov	x0, #0x3fc00000         // =1069547520
               	mov	x17, #0x3fc00000        // =1069547520
               	fmov	s0, w17
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x40200000         // =1075838976
               	fmov	s16, w0
               	fneg	s0, s16
               	fmov	d1, d0
               	fcmp	s1, s0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x40500000         // =1078984704
               	fmov	s16, w0
               	sub	x17, x29, #0x8
               	str	s16, [x17]
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	mov	x0, #0x0                // =0
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, gt
               	cbz	x0, <addr>
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	sub	x16, x29, #0x8
               	ldr	s1, [x16]
               	mov	x0, #0x0                // =0
               	fmov	s17, w0
               	fcmp	s1, s17
               	cset	x0, mi
               	cbz	x0, <addr>
               	sub	x16, x29, #0x8
               	ldr	s1, [x16]
               	fneg	s1, s1
               	fadd	s0, s0, s1
               	mov	x0, #0x40d00000         // =1087373312
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x41a00000         // =1101004800
               	fmov	s16, w0
               	sub	x17, x29, #0x40
               	str	s16, [x17]
               	sub	x16, x29, #0x40
               	ldr	s0, [x16]
               	sub	x17, x29, #0x38
               	str	s0, [x17]
               	sub	x16, x29, #0x38
               	ldr	s0, [x16]
               	mov	x0, #0x41a00000         // =1101004800
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x8
               	ldr	s1, [x16]
               	b	<addr>
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	fneg	s0, s0
               	b	<addr>
