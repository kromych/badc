
fn_ptr_float_arg_narrow.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x0, #0x40000000         // =1073741824
               	fmov	s17, w0
               	fmul	s0, s0, s17
               	ret

<negf>:
               	fneg	s0, s0
               	ret

<addf>:
               	fadd	s0, s0, s1
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x110
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x10
               	ldr	x0, [x0]
               	mov	x1, #0x40400000         // =1077936128
               	mov	x9, x0
               	fmov	d0, x1
               	blr	x9
               	mov	x0, #0x40c00000         // =1086324736
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	x0, [x0, #0x8]
               	mov	x20, #0x40400000        // =1077936128
               	mov	x9, x0
               	fmov	d0, x20
               	blr	x9
               	fmov	s16, w20
               	fneg	s1, s16
               	fcmp	s0, s1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x10
               	ldr	x0, [x1, x0, lsl #3]
               	mov	x1, #0x40800000         // =1082130432
               	mov	x9, x0
               	fmov	d0, x1
               	blr	x9
               	mov	x0, #0x41000000         // =1090519040
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x50
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x50
               	ldr	x0, [x0]
               	mov	x1, #0x3fc00000         // =1069547520
               	mov	x2, #0x40000000         // =1073741824
               	mov	x9, x0
               	fmov	d0, x1
               	fmov	d1, x2
               	blr	x9
               	mov	x0, #0x40600000         // =1080033280
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x40a00000         // =1084227584
               	mov	x9, x0
               	fmov	d0, x1
               	blr	x9
               	mov	x0, #0x41200000         // =1092616192
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x40e00000         // =1088421888
               	fmov	s16, w0
               	sub	x17, x29, #0x88
               	str	s16, [x17]
               	sub	x0, x29, #0x10
               	ldr	x0, [x0]
               	sub	x16, x29, #0x88
               	ldr	s0, [x16]
               	mov	x9, x0
               	blr	x9
               	mov	x0, #0x41600000         // =1096810496
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x20, x29, #0xa8
               	sub	x0, x29, #0xa8
               	ldr	x0, [x0]
               	mov	x1, #0x40400000         // =1077936128
               	mov	x9, x0
               	fmov	d0, x1
               	blr	x9
               	mov	x0, #0x40c00000         // =1086324736
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [x20]
               	mov	x1, #0x40400000         // =1077936128
               	mov	x9, x0
               	fmov	d0, x1
               	blr	x9
               	mov	x0, #0x40c00000         // =1086324736
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [x20, #0x8]
               	mov	x1, #0x3fc00000         // =1069547520
               	mov	x2, #0x40000000         // =1073741824
               	mov	x9, x0
               	fmov	d0, x1
               	fmov	d1, x2
               	blr	x9
               	mov	x0, #0x40600000         // =1080033280
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
