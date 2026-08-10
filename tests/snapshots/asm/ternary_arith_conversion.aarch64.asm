
ternary_arith_conversion.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d16, x0
               	sub	x17, x29, #0x10
               	str	d16, [x17]
               	sub	x16, x29, #0x10
               	ldr	d0, [x16]
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x0
               	sub	x17, x29, #0x10
               	str	d16, [x17]
               	sub	x16, x29, #0x10
               	ldr	d0, [x16]
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d16, x0
               	sub	x17, x29, #0x10
               	str	d16, [x17]
               	sub	x16, x29, #0x10
               	ldr	d0, [x16]
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x0
               	sub	x17, x29, #0x10
               	str	d16, [x17]
               	sub	x16, x29, #0x10
               	ldr	d0, [x16]
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3f800000         // =1065353216
               	fmov	s16, w0
               	fcvt	d0, s16
               	sub	x17, x29, #0x10
               	str	d0, [x17]
               	sub	x16, x29, #0x10
               	ldr	d0, [x16]
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x0
               	sub	x17, x29, #0x10
               	str	d16, [x17]
               	sub	x16, x29, #0x10
               	ldr	d0, [x16]
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3f800000         // =1065353216
               	fmov	s16, w0
               	sub	x17, x29, #0x10
               	str	s16, [x17]
               	sub	x16, x29, #0x10
               	ldr	s0, [x16]
               	mov	x0, #0x3f800000         // =1065353216
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x40000000         // =1073741824
               	fmov	s16, w0
               	sub	x17, x29, #0x10
               	str	s16, [x17]
               	sub	x16, x29, #0x10
               	ldr	s0, [x16]
               	mov	x0, #0x40000000         // =1073741824
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x12               // =18
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa                // =10
               	mov	x0, #0x2                // =2
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
