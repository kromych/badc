
libc_math_special.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x360              // =864
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	fsub	d1, d0, d1
               	mov	x0, #0x0                // =0
               	scvtf	d0, x0
               	fcmp	d1, d0
               	cset	x0, mi
               	cbz	x0, <addr>
               	fneg	d1, d1
               	mov	x0, #0xed8d             // =60813
               	movk	x0, #0xa0b5, lsl #16
               	movk	x0, #0xc6f7, lsl #32
               	movk	x0, #0x3eb0, lsl #48
               	fmov	d17, x0
               	fcmp	d1, d17
               	cset	x0, mi
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	d8, [sp]
               	str	x20, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	mov	x0, #0x4014000000000000 // =4617315517961601024
               	fmov	d0, x0
               	bl	<addr>
               	mov	x0, #0x4038000000000000 // =4627448617123184640
               	fmov	d1, x0
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp, #0x10]
               	ldr	d8, [sp]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d0, x20
               	bl	<addr>
               	fmov	d1, x20
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp, #0x10]
               	ldr	d8, [sp]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x0               // =0
               	fmov	d0, x20
               	bl	<addr>
               	fmov	d1, x20
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp, #0x10]
               	ldr	d8, [sp]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	fmov	d0, x0
               	bl	<addr>
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d1, x0
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp, #0x10]
               	ldr	d8, [sp]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d0, x20
               	bl	<addr>
               	fmov	d8, d0
               	fmov	d0, x20
               	bl	<addr>
               	fadd	d0, d8, d0
               	fmov	d1, x20
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp, #0x10]
               	ldr	d8, [sp]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4014000000000000 // =4617315517961601024
               	fmov	d16, x0
               	fcvt	s0, d16
               	bl	<addr>
               	fcvt	d0, s0
               	mov	x0, #0x4038000000000000 // =4627448617123184640
               	fmov	d1, x0
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x6                // =6
               	ldr	x20, [sp, #0x10]
               	ldr	d8, [sp]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x0               // =0
               	fmov	d16, x20
               	fcvt	s0, d16
               	bl	<addr>
               	fcvt	d0, s0
               	fmov	d1, x20
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x7                // =7
               	ldr	x20, [sp, #0x10]
               	ldr	d8, [sp]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp, #0x10]
               	ldr	d8, [sp]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
