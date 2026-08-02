
struct_arg_indirect_subscript.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<take_pair>:
               	sub	sp, sp, #0x20
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x16, x29, #0x10
               	str	x1, [x16]
               	str	x2, [x16, #0x8]
               	mov	x1, x0
               	mov	x2, x3
               	mov	x3, x4
               	sxtw	x3, w3
               	sub	x0, x29, #0x10
               	ldr	x0, [x0]
               	mov	x17, #0x3e8             // =1000
               	mul	x4, x0, x17
               	sub	x0, x29, #0x10
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0xa               // =10
               	mul	x0, x0, x17
               	add	x0, x4, x0
               	add	x3, x0, x3
               	cbz	x1, <addr>
               	mov	x0, #0x0                // =0
               	add	x1, x3, #0x0
               	cbz	x2, <addr>
               	mov	x0, #0x1                // =1
               	add	x0, x1, x0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x40
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>

<take_vec>:
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x16, x29, #0x10
               	str	d0, [x16]
               	str	d1, [x16, #0x8]
               	mov	x2, x0
               	sxtw	x2, w2
               	sub	x0, x29, #0x10
               	ldr	d0, [x0]
               	mov	x0, #0x4010000000000000 // =4616189618054758400
               	sub	x1, x29, #0x10
               	ldr	d1, [x1, #0x8]
               	mov	x1, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x1
               	fmul	d1, d1, d17
               	fmov	d17, x0
               	fmadd	d0, d0, d17, d1
               	scvtf	d1, x2
               	fadd	d0, d0, d1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret

<vec_via_ptr>:
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	str	x19, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	sub	x16, x29, #0x10
               	str	d0, [x16]
               	str	d1, [x16, #0x8]
               	mov	x1, #0x1                // =1
               	sub	x2, x29, #0x10
               	mov	x9, x0
               	ldr	d0, [x2]
               	ldr	d1, [x2, #0x8]
               	mov	x0, x1
               	blr	x9
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp], #0x30
               	add	sp, sp, #0x30
               	ret

<main>:
               	str	x19, [sp, #-0xe0]!
               	stp	x29, x30, [sp, #0xd0]
               	add	x29, sp, #0xd0
               	sub	x0, x29, #0x30
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x30
               	sub	x2, x29, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x2
               	mov	x1, #0x0                // =0
               	mov	x2, #0x1                // =1
               	mov	x3, #0x5                // =5
               	sub	x4, x29, #0x10
               	mov	x9, x0
               	mov	x0, x1
               	mov	x1, x4
               	mov	x4, x3
               	mov	x3, x2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	blr	x9
               	mov	x17, #0x1b7c            // =7036
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0xd0]
               	ldr	x19, [sp], #0xe0
               	ret
               	sub	x0, x29, #0xb8
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	sub	x0, x29, #0xb8
               	add	x0, x0, #0x8
               	add	x0, x0, #0x0
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	sub	x0, x29, #0xb8
               	add	x0, x0, #0x8
               	mov	x1, #0x0                // =0
               	add	x0, x0, #0x0
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0xb8
               	add	x0, x0, #0x8
               	mov	x1, #0x2                // =2
               	str	x1, [x0, #0x10]
               	sub	x0, x29, #0xb8
               	add	x0, x0, #0x8
               	mov	x1, #0x1                // =1
               	add	x0, x0, #0x10
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0xb8
               	add	x0, x0, #0x8
               	mov	x1, #0x3                // =3
               	str	x1, [x0, #0x20]
               	sub	x0, x29, #0xb8
               	add	x0, x0, #0x8
               	mov	x1, #0x2                // =2
               	add	x0, x0, #0x20
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0xb8
               	add	x0, x0, #0x8
               	mov	x1, #0x4                // =4
               	str	x1, [x0, #0x30]
               	sub	x0, x29, #0xb8
               	add	x0, x0, #0x8
               	mov	x1, #0x3                // =3
               	add	x0, x0, #0x30
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0xb8
               	add	x0, x0, #0x8
               	mov	x1, #0x5                // =5
               	str	x1, [x0, #0x40]
               	sub	x0, x29, #0xb8
               	add	x0, x0, #0x8
               	mov	x1, #0x4                // =4
               	add	x0, x0, #0x40
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0xb8
               	add	x0, x0, #0x8
               	mov	x1, #0x6                // =6
               	str	x1, [x0, #0x50]
               	sub	x0, x29, #0xb8
               	add	x0, x0, #0x8
               	mov	x1, #0x5                // =5
               	add	x0, x0, #0x50
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0xb8
               	add	x0, x0, #0x8
               	mov	x1, #0x7                // =7
               	str	x1, [x0, #0x60]
               	sub	x0, x29, #0xb8
               	add	x0, x0, #0x8
               	mov	x1, #0x6                // =6
               	add	x0, x0, #0x60
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0xb8
               	add	x0, x0, #0x8
               	mov	x1, #0x8                // =8
               	str	x1, [x0, #0x70]
               	sub	x0, x29, #0xb8
               	add	x0, x0, #0x8
               	mov	x1, #0x7                // =7
               	add	x0, x0, #0x70
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0xb8
               	add	x0, x1, #0x8
               	add	x0, x0, #0x30
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x3, [x0]
               	mov	x17, #0x3e8             // =1000
               	mul	x3, x3, x17
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0xa               // =10
               	mul	x0, x0, x17
               	add	x0, x3, x0
               	add	x3, x0, #0x3
               	cbz	x1, <addr>
               	mov	x0, #0x0                // =0
               	add	x1, x3, #0x0
               	cbz	x2, <addr>
               	mov	x0, #0x1                // =1
               	add	x0, x1, x0
               	cmp	x0, #0xfc2
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0xd0]
               	ldr	x19, [sp], #0xe0
               	ret
               	sub	x0, x29, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x20
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
               	ldp	x29, x30, [sp, #0xd0]
               	ldr	x19, [sp], #0xe0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x20
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
               	ldp	x29, x30, [sp, #0xd0]
               	ldr	x19, [sp], #0xe0
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0xd0]
               	ldr	x19, [sp], #0xe0
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
