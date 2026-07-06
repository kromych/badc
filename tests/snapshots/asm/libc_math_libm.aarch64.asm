
libc_math_libm.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x420              // =1056
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	fsub	d1, d0, d1
               	mov	x0, #0x0                // =0
               	scvtf	d0, x0
               	fcmp	d1, d0
               	cset	x0, mi
               	cbz	x0, <addr>
               	fneg	d1, d1
               	mov	x0, #0xd695             // =54933
               	movk	x0, #0xe826, lsl #16
               	movk	x0, #0x2e0b, lsl #32
               	movk	x0, #0x3e11, lsl #48
               	fmov	d17, x0
               	fcmp	d1, d17
               	cset	x0, mi
               	ret
               	b	<addr>

<main>:
               	str	x20, [sp, #-0x30]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x0, #0x403b000000000000 // =4628293042053316608
               	fmov	d0, x0
               	bl	<addr>
               	mov	x0, #0x4008000000000000 // =4613937818241073152
               	fmov	d1, x0
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x4020000000000000 // =4620693217682128896
               	fmov	d0, x0
               	bl	<addr>
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d1, x0
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x20, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d0, x20
               	bl	<addr>
               	bl	<addr>
               	fmov	d1, x20
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x4014000000000000 // =4617315517961601024
               	mov	x1, #0x4008000000000000 // =4613937818241073152
               	fmov	d0, x0
               	fmov	d1, x1
               	bl	<addr>
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d16, x0
               	fneg	d1, d16
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x4004000000000000 // =4612811918334230528
               	fmov	d0, x0
               	bl	<addr>
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x400c000000000000 // =4615063718147915776
               	fmov	d0, x0
               	bl	<addr>
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x4004000000000000 // =4612811918334230528
               	fmov	d16, x0
               	fneg	d0, d16
               	bl	<addr>
               	mov	x17, #0xfffe            // =65534
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x41d80000         // =1104674816
               	fmov	d0, x0
               	bl	<addr>
               	fcvt	d0, s0
               	mov	x0, #0x40400000         // =1077936128
               	fmov	s16, w0
               	fcvt	d1, s16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x40a00000         // =1084227584
               	mov	x1, #0x40400000         // =1077936128
               	fmov	d0, x0
               	fmov	d1, x1
               	bl	<addr>
               	fcvt	d0, s0
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d16, x0
               	fneg	d1, d16
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
