
struct_arg_indirect_subscript.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sub	sp, sp, #0x20
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x16, x29, #0x10
               	str	x1, [x16]
               	str	x2, [x16, #0x8]
               	mov	x2, x3
               	mov	x3, x4
               	sxtw	x3, w3
               	sub	x1, x29, #0x10
               	ldr	x1, [x1]
               	mov	x17, #0x3e8             // =1000
               	mul	x1, x1, x17
               	sub	x4, x29, #0x10
               	ldr	x4, [x4, #0x8]
               	mov	x17, #0xa               // =10
               	mul	x4, x4, x17
               	add	x1, x1, x4
               	add	x1, x1, x3
               	cbz	x0, <addr>
               	mov	x3, #0x0                // =0
               	b	<addr>
               	mov	x3, #0x0                // =0
               	add	x0, x1, x3
               	cbz	x2, <addr>
               	mov	x2, #0x1                // =1
               	b	<addr>
               	mov	x2, #0x0                // =0
               	add	x0, x0, x2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x40
               	ret

<take_vec>:
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x16, x29, #0x10
               	str	d0, [x16]
               	str	d1, [x16, #0x8]
               	mov	x1, x0
               	sxtw	x1, w1
               	sub	x0, x29, #0x10
               	ldr	d0, [x0]
               	mov	x0, #0x4010000000000000 // =4616189618054758400
               	sub	x2, x29, #0x10
               	add	x2, x2, #0x8
               	ldr	d1, [x2]
               	mov	x2, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x2
               	fmul	d1, d1, d17
               	fmov	d17, x0
               	fmadd	d0, d0, d17, d1
               	scvtf	d1, x1
               	fadd	d0, d0, d1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret

<pair_via_ptr>:
               	sub	sp, sp, #0x20
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x20
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	str	x19, [sp]
               	sub	x16, x29, #0x10
               	str	x2, [x16]
               	str	x3, [x16, #0x8]
               	mov	x3, x4
               	mov	x4, x5
               	sxtw	x4, w4
               	sub	x2, x29, #0x10
               	mov	x9, x0
               	mov	x0, x1
               	mov	x1, x2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	blr	x9
               	ldr	x19, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x50
               	ret

<vec_via_ptr>:
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	x19, [sp]
               	sub	x16, x29, #0x10
               	str	d0, [x16]
               	str	d1, [x16, #0x8]
               	mov	x2, x1
               	sxtw	x2, w2
               	sub	x1, x29, #0x10
               	mov	x9, x0
               	ldr	d0, [x1]
               	ldr	d1, [x1, #0x8]
               	mov	x0, x2
               	blr	x9
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x30
               	ret

<pair_from_subscript>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sxtw	x1, w1
               	add	x2, x0, #0x8
               	lsl	x3, x1, #4
               	add	x2, x2, x3
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x4, x1
               	mov	x1, x2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xd0
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x10
               	mov	x3, #0x5                // =5
               	mov	x4, x3
               	mov	x3, x0
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	mov	x17, #0x1b7b            // =7035
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	sub	x2, x29, #0x10
               	mov	x3, #0x1                // =1
               	mov	x4, #0x5                // =5
               	mov	x5, x4
               	mov	x4, x3
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	mov	x17, #0x1b7c            // =7036
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x98
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	sxtw	x0, w1
               	cmp	x0, #0x8
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w1
               	add	x1, x0, #0x1
               	b	<addr>
               	sub	x0, x29, #0x98
               	add	x0, x0, #0x8
               	sxtw	x2, w1
               	lsl	x3, x2, #4
               	add	x0, x0, x3
               	add	x2, x2, #0x1
               	sxtw	x2, w2
               	str	x2, [x0]
               	sub	x0, x29, #0x98
               	add	x0, x0, #0x8
               	sxtw	x2, w1
               	lsl	x3, x2, #4
               	add	x0, x0, x3
               	str	x2, [x0, #0x8]
               	b	<addr>
               	sub	x0, x29, #0x98
               	mov	x1, #0x3                // =3
               	bl	<addr>
               	cmp	x0, #0xfc2
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xb0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0xb0
               	mov	x1, #0x1                // =1
               	ldr	d0, [x0]
               	ldr	d1, [x0, #0x8]
               	mov	x0, x1
               	bl	<addr>
               	mov	x0, #0x3ff8000000000000 // =4609434218613702656
               	mov	x1, #0x4010000000000000 // =4616189618054758400
               	mov	x2, #0x4002000000000000 // =4612248968380809216
               	mov	x3, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x2
               	fmov	d17, x3
               	fmul	d1, d16, d17
               	fmov	d16, x0
               	fmov	d17, x1
               	fmadd	d1, d16, d17, d1
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d17, x0
               	fadd	d1, d1, d17
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0xb0
               	mov	x2, #0x1                // =1
               	ldr	d0, [x1]
               	ldr	d1, [x1, #0x8]
               	mov	x1, x2
               	bl	<addr>
               	mov	x0, #0x3ff8000000000000 // =4609434218613702656
               	mov	x1, #0x4010000000000000 // =4616189618054758400
               	mov	x2, #0x4002000000000000 // =4612248968380809216
               	mov	x3, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x2
               	fmov	d17, x3
               	fmul	d1, d16, d17
               	fmov	d16, x0
               	fmov	d17, x1
               	fmadd	d1, d16, d17, d1
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d17, x0
               	fadd	d1, d1, d17
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
