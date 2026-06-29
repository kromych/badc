
init_scalar_conversion.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	x16, x29, #0x20
               	str	d0, [x16]
               	str	d1, [x16, #0x8]
               	str	d2, [x16, #0x10]
               	str	d3, [x16, #0x18]
               	sub	x0, x29, #0x20
               	ldr	d0, [x0]
               	mov	x2, #0x0                // =0
               	fmov	d17, x2
               	fcmp	d0, d17
               	cset	x0, eq
               	cbz	x0, <addr>
               	sub	x0, x29, #0x20
               	add	x0, x0, #0x8
               	ldr	d0, [x0]
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x2, ne
               	mov	x1, #0x0                // =0
               	cbz	x2, <addr>
               	sub	x0, x29, #0x20
               	add	x0, x0, #0x10
               	ldr	d0, [x0]
               	mov	x0, #0x400000000000     // =70368744177664
               	movk	x0, #0x408a, lsl #48
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x2, #0x0                // =0
               	cbz	x1, <addr>
               	sub	x0, x29, #0x20
               	add	x0, x0, #0x18
               	ldr	d0, [x0]
               	mov	x0, #0xe00000000000     // =246290604621824
               	movk	x0, #0x4080, lsl #48
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x2, ne
               	mov	x0, x2
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xe0
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	mov	x20, #0x348             // =840
               	mov	x21, #0x21c             // =540
               	sub	x0, x29, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	scvtf	d0, x20
               	sub	x0, x29, #0x20
               	str	d0, [x0]
               	scvtf	d0, x21
               	sub	x0, x29, #0x20
               	add	x0, x0, #0x8
               	str	d0, [x0]
               	sub	x0, x29, #0x20
               	ldr	d0, [x0]
               	mov	x0, #0x400000000000     // =70368744177664
               	movk	x0, #0x408a, lsl #48
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x22, ne
               	cbnz	x22, <addr>
               	sub	x0, x29, #0x20
               	add	x0, x0, #0x8
               	ldr	d0, [x0]
               	mov	x0, #0xe00000000000     // =246290604621824
               	movk	x0, #0x4080, lsl #48
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x22, ne
               	cbz	x22, <addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x1, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [sp], #0x10
               	mov	x0, #0x0                // =0
               	scvtf	d0, x0
               	sub	x0, x29, #0x40
               	str	d0, [x0]
               	sub	x0, x29, #0x40
               	add	x0, x0, #0x8
               	str	d0, [x0]
               	scvtf	d0, x20
               	sub	x0, x29, #0x40
               	add	x0, x0, #0x10
               	str	d0, [x0]
               	scvtf	d0, x21
               	sub	x0, x29, #0x40
               	add	x0, x0, #0x18
               	str	d0, [x0]
               	sub	x0, x29, #0x40
               	add	x0, x0, #0x10
               	ldr	d0, [x0]
               	mov	x0, #0x400000000000     // =70368744177664
               	movk	x0, #0x408a, lsl #48
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x22, ne
               	cbnz	x22, <addr>
               	sub	x0, x29, #0x40
               	add	x0, x0, #0x18
               	ldr	d0, [x0]
               	mov	x0, #0xe00000000000     // =246290604621824
               	movk	x0, #0x4080, lsl #48
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x22, ne
               	cbz	x22, <addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x50
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	scvtf	d0, x20
               	sub	x0, x29, #0x50
               	str	d0, [x0]
               	scvtf	d0, x21
               	sub	x0, x29, #0x50
               	add	x0, x0, #0x8
               	str	d0, [x0]
               	sub	x0, x29, #0x50
               	ldr	d0, [x0]
               	mov	x0, #0x400000000000     // =70368744177664
               	movk	x0, #0x408a, lsl #48
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x22, ne
               	cbnz	x22, <addr>
               	sub	x0, x29, #0x50
               	add	x0, x0, #0x8
               	ldr	d0, [x0]
               	mov	x0, #0xe00000000000     // =246290604621824
               	movk	x0, #0x4080, lsl #48
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x22, ne
               	cbz	x22, <addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3333             // =13107
               	movk	x0, #0x3333, lsl #16
               	movk	x0, #0x3333, lsl #32
               	movk	x0, #0x400f, lsl #48
               	fmov	d16, x0
               	sub	x17, x29, #0x58
               	str	d16, [x17]
               	sub	x0, x29, #0x60
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	sub	x16, x29, #0x58
               	ldr	d0, [x16]
               	fcvtzs	x0, d0
               	sub	x1, x29, #0x60
               	str	w0, [x1]
               	mov	x0, #0x7                // =7
               	sub	x1, x29, #0x60
               	str	w0, [x1, #0x4]
               	sub	x0, x29, #0x60
               	ldrsw	x0, [x0]
               	cmp	x0, #0x3
               	cset	x22, ne
               	cbnz	x22, <addr>
               	sub	x0, x29, #0x60
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x7
               	cset	x22, ne
               	cbz	x22, <addr>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x70
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x2]
               	strb	w10, [x1]
               	ldrb	w10, [x2, #0x1]
               	strb	w10, [x1, #0x1]
               	ldrb	w10, [x2, #0x2]
               	strb	w10, [x1, #0x2]
               	ldrb	w10, [x2, #0x3]
               	strb	w10, [x1, #0x3]
               	ldr	x10, [sp], #0x10
               	sub	x16, x29, #0x58
               	ldr	d0, [x16]
               	fmov	d17, x0
               	fadd	d0, d0, d17
               	fcvt	s0, d0
               	sub	x0, x29, #0x70
               	str	s0, [x0]
               	sub	x0, x29, #0x70
               	ldr	s0, [x0]
               	mov	x0, #0x851f             // =34079
               	movk	x0, #0x51eb, lsl #16
               	movk	x0, #0x1eb8, lsl #32
               	movk	x0, #0x400f, lsl #48
               	fcvt	d1, s0
               	fmov	d17, x0
               	fcmp	d1, d17
               	cset	x22, mi
               	cbnz	x22, <addr>
               	mov	x0, #0xe148             // =57672
               	movk	x0, #0x147a, lsl #16
               	movk	x0, #0x47ae, lsl #32
               	movk	x0, #0x400f, lsl #48
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x22, gt
               	cbz	x22, <addr>
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x40
               	ldr	d0, [x0]
               	ldr	d1, [x0, #0x8]
               	ldr	d2, [x0, #0x10]
               	ldr	d3, [x0, #0x18]
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x6                // =6
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x98
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x1, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [sp], #0x10
               	mov	x0, #0x0                // =0
               	scvtf	d0, x0
               	sub	x0, x29, #0x98
               	str	d0, [x0]
               	sub	x0, x29, #0x98
               	add	x0, x0, #0x8
               	str	d0, [x0]
               	scvtf	d0, x20
               	sub	x0, x29, #0x98
               	add	x0, x0, #0x10
               	str	d0, [x0]
               	scvtf	d0, x21
               	sub	x0, x29, #0x98
               	add	x0, x0, #0x18
               	str	d0, [x0]
               	sub	x0, x29, #0x98
               	ldr	d0, [x0]
               	ldr	d1, [x0, #0x8]
               	ldr	d2, [x0, #0x10]
               	ldr	d3, [x0, #0x18]
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x7                // =7
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
