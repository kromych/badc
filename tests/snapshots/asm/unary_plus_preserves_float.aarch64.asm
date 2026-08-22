
unary_plus_preserves_float.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x20
               	mov	x3, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d16, x3
               	sub	x17, x29, #0x18
               	str	d16, [x17]
               	sub	x16, x29, #0x18
               	ldr	d0, [x16]
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d17, x0
               	fadd	d0, d0, d17
               	mov	x1, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x1
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x18
               	ldr	d0, [x16]
               	mov	x2, #0x0                // =0
               	fmov	d17, x2
               	fcmp	d0, d17
               	b.pl	<addr>
               	fmov	d16, x0
               	fneg	d0, d16
               	sub	x17, x29, #0x8
               	str	d0, [x17]
               	sub	x16, x29, #0x8
               	ldr	d0, [x16]
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x18
               	ldr	d1, [x16]
               	fadd	d0, d1, d0
               	fmov	d17, x1
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x18
               	ldr	d0, [x16]
               	fmov	d17, x2
               	fcmp	d0, d17
               	b.pl	<addr>
               	fmov	d16, x0
               	fneg	d1, d16
               	sub	x17, x29, #0x8
               	str	d1, [x17]
               	sub	x16, x29, #0x8
               	ldr	d1, [x16]
               	fadd	d0, d0, d1
               	fmov	d17, x1
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x18
               	ldr	d0, [x16]
               	fmov	d17, x2
               	fcmp	d0, d17
               	b.pl	<addr>
               	fmov	d16, x0
               	fneg	d1, d16
               	sub	x17, x29, #0x8
               	str	d1, [x17]
               	sub	x16, x29, #0x8
               	ldr	d1, [x16]
               	fadd	d0, d0, d1
               	fcvtzs	x4, d0
               	cmp	x4, #0x2
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x18
               	ldr	d0, [x16]
               	fmov	d17, x2
               	fcmp	d0, d17
               	b.pl	<addr>
               	fmov	d16, x0
               	fneg	d1, d16
               	sub	x17, x29, #0x8
               	str	d1, [x17]
               	sub	x16, x29, #0x8
               	ldr	d1, [x16]
               	fadd	d0, d0, d1
               	fcvtzs	x4, d0
               	scvtf	d0, x4
               	fmov	d17, x1
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d16, x3
               	fneg	d0, d16
               	sub	x17, x29, #0x18
               	str	d0, [x17]
               	sub	x16, x29, #0x18
               	ldr	d0, [x16]
               	fmov	d17, x2
               	fcmp	d0, d17
               	b.pl	<addr>
               	fmov	d16, x0
               	fneg	d1, d16
               	sub	x17, x29, #0x8
               	str	d1, [x17]
               	sub	x16, x29, #0x8
               	ldr	d1, [x16]
               	fadd	d0, d0, d1
               	fcvtzs	x0, d0
               	scvtf	d0, x0
               	fmov	d16, x1
               	fneg	d1, d16
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d16, x0
               	sub	x17, x29, #0x8
               	str	d16, [x17]
               	b	<addr>
               	fmov	d16, x0
               	sub	x17, x29, #0x8
               	str	d16, [x17]
               	b	<addr>
               	fmov	d16, x0
               	sub	x17, x29, #0x8
               	str	d16, [x17]
               	b	<addr>
               	fmov	d16, x0
               	sub	x17, x29, #0x8
               	str	d16, [x17]
               	b	<addr>
               	fmov	d16, x0
               	sub	x17, x29, #0x8
               	str	d16, [x17]
               	b	<addr>
