
float_literal_arith_single_precision.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x0, #0x3f800000         // =1065353216
               	fmov	s17, w0
               	fsub	s0, s0, s17
               	ret

<blend>:
               	mov	x0, #0x3f000000         // =1056964608
               	mov	x1, #0x3e800000         // =1048576000
               	fmov	s17, w1
               	fmul	s1, s1, s17
               	fmov	s17, w0
               	fmadd	s0, s0, s17, s1
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0x40200000         // =1075838976
               	mov	x1, #0x3f800000         // =1065353216
               	fmov	s16, w0
               	fmov	s17, w1
               	fsub	s0, s16, s17
               	mov	x0, #0x3fc00000         // =1069547520
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x40400000         // =1077936128
               	mov	x2, #0x41000000         // =1090519040
               	mov	x1, #0x3f000000         // =1056964608
               	mov	x3, #0x3e800000         // =1048576000
               	fmov	s16, w2
               	fmov	s17, w3
               	fmul	s0, s16, s17
               	fmov	s16, w0
               	fmov	s17, w1
               	fmadd	s0, s16, s17, s0
               	mov	x0, #0x40600000         // =1080033280
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	fmov	s16, w0
               	sub	x17, x29, #0x8
               	str	s16, [x17]
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	mov	x0, #0xcccd             // =52429
               	movk	x0, #0x3dcc, lsl #16
               	fmov	s17, w0
               	fadd	s0, s0, s17
               	sub	x17, x29, #0x8
               	str	s0, [x17]
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	mov	x0, #0xcccd             // =52429
               	movk	x0, #0x3dcc, lsl #16
               	fmov	s17, w0
               	fadd	s0, s0, s17
               	sub	x17, x29, #0x8
               	str	s0, [x17]
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	mov	x0, #0xcccd             // =52429
               	movk	x0, #0x3dcc, lsl #16
               	fmov	s17, w0
               	fadd	s0, s0, s17
               	sub	x17, x29, #0x8
               	str	s0, [x17]
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	mov	x0, #0xcccd             // =52429
               	movk	x0, #0x3dcc, lsl #16
               	fmov	s17, w0
               	fadd	s0, s0, s17
               	sub	x17, x29, #0x8
               	str	s0, [x17]
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	mov	x0, #0xcccd             // =52429
               	movk	x0, #0x3dcc, lsl #16
               	fmov	s17, w0
               	fadd	s0, s0, s17
               	sub	x17, x29, #0x8
               	str	s0, [x17]
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	mov	x0, #0xcccd             // =52429
               	movk	x0, #0x3dcc, lsl #16
               	fmov	s17, w0
               	fadd	s0, s0, s17
               	sub	x17, x29, #0x8
               	str	s0, [x17]
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	mov	x0, #0xcccd             // =52429
               	movk	x0, #0x3dcc, lsl #16
               	fmov	s17, w0
               	fadd	s0, s0, s17
               	sub	x17, x29, #0x8
               	str	s0, [x17]
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	mov	x0, #0xcccd             // =52429
               	movk	x0, #0x3dcc, lsl #16
               	fmov	s17, w0
               	fadd	s0, s0, s17
               	sub	x17, x29, #0x8
               	str	s0, [x17]
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	mov	x0, #0xcccd             // =52429
               	movk	x0, #0x3dcc, lsl #16
               	fmov	s17, w0
               	fadd	s0, s0, s17
               	sub	x17, x29, #0x8
               	str	s0, [x17]
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	mov	x0, #0xcccd             // =52429
               	movk	x0, #0x3dcc, lsl #16
               	fmov	s17, w0
               	fadd	s0, s0, s17
               	sub	x17, x29, #0x8
               	str	s0, [x17]
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	mov	x0, #0x3f800000         // =1065353216
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	mov	x0, #0x1                // =1
               	movk	x0, #0x3f80, lsl #16
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
