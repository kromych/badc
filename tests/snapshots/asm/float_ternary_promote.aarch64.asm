
float_ternary_promote.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sxtw	x0, w0
               	fmov	d2, d0
               	cbz	x0, <addr>
               	b	<addr>
               	fmov	d2, d1
               	fmov	d0, d2
               	ret

<main>:
               	str	d8, [sp, #-0x70]!
               	str	x20, [sp, #0x10]
               	stp	x29, x30, [sp, #0x60]
               	add	x29, sp, #0x60
               	mov	x0, #0x1                // =1
               	mov	x20, #0x3fc00000        // =1069547520
               	mov	x1, #0x40200000         // =1075838976
               	fmov	s16, w1
               	fneg	s0, s16
               	fmov	d1, d0
               	fmov	d0, x20
               	bl	<addr>
               	fmov	s17, w20
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x20, [sp, #0x10]
               	ldr	d8, [sp], #0x70
               	ret
               	mov	x0, #0x0                // =0
               	mov	x1, #0x3fc00000         // =1069547520
               	mov	x2, #0x40200000         // =1075838976
               	fmov	s16, w2
               	fneg	s8, s16
               	fmov	d1, d8
               	fmov	d0, x1
               	bl	<addr>
               	fcmp	s0, s8
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x20, [sp, #0x10]
               	ldr	d8, [sp], #0x70
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
               	b	<addr>
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	fneg	s0, s0
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
               	b	<addr>
               	sub	x16, x29, #0x8
               	ldr	s1, [x16]
               	fadd	s0, s0, s1
               	mov	x0, #0x40d00000         // =1087373312
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x20, [sp, #0x10]
               	ldr	d8, [sp], #0x70
               	ret
               	mov	x0, #0x2                // =2
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	fmov	s16, w0
               	sub	x17, x29, #0x38
               	str	s16, [x17]
               	b	<addr>
               	cmp	x0, #0x1
               	b.ne	<addr>
               	b	<addr>
               	sub	x16, x29, #0x38
               	ldr	s0, [x16]
               	mov	x0, #0x41a00000         // =1101004800
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	b	<addr>
               	mov	x0, #0x41200000         // =1092616192
               	fmov	s16, w0
               	sub	x17, x29, #0x40
               	str	s16, [x17]
               	b	<addr>
               	mov	x0, #0x41a00000         // =1101004800
               	fmov	s16, w0
               	sub	x17, x29, #0x40
               	str	s16, [x17]
               	sub	x16, x29, #0x40
               	ldr	s0, [x16]
               	sub	x17, x29, #0x38
               	str	s0, [x17]
               	b	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x20, [sp, #0x10]
               	ldr	d8, [sp], #0x70
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x20, [sp, #0x10]
               	ldr	d8, [sp], #0x70
               	ret
