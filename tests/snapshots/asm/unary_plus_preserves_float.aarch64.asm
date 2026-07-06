
unary_plus_preserves_float.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x230              // =560
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	mov	x0, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d16, x0
               	sub	x17, x29, #0x8
               	str	d16, [x17]
               	sub	x16, x29, #0x8
               	ldr	d0, [x16]
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d17, x0
               	fadd	d0, d0, d17
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x8
               	ldr	d0, [x16]
               	mov	x0, #0x0                // =0
               	scvtf	d1, x0
               	fcmp	d0, d1
               	cset	x0, mi
               	cbz	x0, <addr>
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d16, x0
               	fneg	d0, d16
               	sub	x17, x29, #0x38
               	str	d0, [x17]
               	sub	x16, x29, #0x38
               	ldr	d0, [x16]
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x8
               	ldr	d1, [x16]
               	fadd	d0, d1, d0
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x8
               	ldr	d0, [x16]
               	mov	x0, #0x0                // =0
               	scvtf	d1, x0
               	fcmp	d0, d1
               	cset	x0, mi
               	cbz	x0, <addr>
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d16, x0
               	fneg	d1, d16
               	sub	x17, x29, #0x40
               	str	d1, [x17]
               	sub	x16, x29, #0x40
               	ldr	d1, [x16]
               	fadd	d0, d0, d1
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x8
               	ldr	d0, [x16]
               	mov	x0, #0x0                // =0
               	scvtf	d1, x0
               	fcmp	d0, d1
               	cset	x0, mi
               	cbz	x0, <addr>
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d16, x0
               	fneg	d1, d16
               	sub	x17, x29, #0x48
               	str	d1, [x17]
               	sub	x16, x29, #0x48
               	ldr	d1, [x16]
               	fadd	d0, d0, d1
               	fcvtzs	x0, d0
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x8
               	ldr	d0, [x16]
               	mov	x0, #0x0                // =0
               	scvtf	d1, x0
               	fcmp	d0, d1
               	cset	x0, mi
               	cbz	x0, <addr>
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d16, x0
               	fneg	d1, d16
               	sub	x17, x29, #0x50
               	str	d1, [x17]
               	sub	x16, x29, #0x50
               	ldr	d1, [x16]
               	fadd	d0, d0, d1
               	fcvtzs	x0, d0
               	scvtf	d0, x0
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d16, x0
               	fneg	d0, d16
               	sub	x17, x29, #0x8
               	str	d0, [x17]
               	sub	x16, x29, #0x8
               	ldr	d0, [x16]
               	mov	x0, #0x0                // =0
               	scvtf	d1, x0
               	fcmp	d0, d1
               	cset	x0, mi
               	cbz	x0, <addr>
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d16, x0
               	fneg	d1, d16
               	sub	x17, x29, #0x58
               	str	d1, [x17]
               	sub	x16, x29, #0x58
               	ldr	d1, [x16]
               	fadd	d0, d0, d1
               	fcvtzs	x0, d0
               	scvtf	d0, x0
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x0
               	fneg	d1, d16
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d16, x0
               	sub	x17, x29, #0x58
               	str	d16, [x17]
               	b	<addr>
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d16, x0
               	sub	x17, x29, #0x50
               	str	d16, [x17]
               	b	<addr>
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d16, x0
               	sub	x17, x29, #0x48
               	str	d16, [x17]
               	b	<addr>
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d16, x0
               	sub	x17, x29, #0x40
               	str	d16, [x17]
               	b	<addr>
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d16, x0
               	sub	x17, x29, #0x38
               	str	d16, [x17]
               	b	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
