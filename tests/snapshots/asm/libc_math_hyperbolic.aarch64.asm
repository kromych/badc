
libc_math_hyperbolic.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x420              // =1056
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	fsub	d0, d0, d1
               	mov	x0, #0x0                // =0
               	scvtf	d1, x0
               	fcmp	d0, d1
               	cset	x0, mi
               	cbz	x0, <addr>
               	fneg	d0, d0
               	mov	x0, #0xd695             // =54933
               	movk	x0, #0xe826, lsl #16
               	movk	x0, #0x2e0b, lsl #32
               	movk	x0, #0x3e11, lsl #48
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, mi
               	ret
               	b	<addr>

<main>:
               	str	x20, [sp, #-0x30]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, #0x0               // =0
               	fmov	d0, x20
               	bl	<addr>
               	fmov	d1, x20
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d0, x0
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	fmov	d1, x0
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x20, #0x0               // =0
               	fmov	d0, x20
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
               	mov	x20, #0x4000000000000000 // =4611686018427387904
               	fmov	d0, x20
               	bl	<addr>
               	bl	<addr>
               	fmov	d1, x20
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x20, #0x4008000000000000 // =4613937818241073152
               	fmov	d0, x20
               	bl	<addr>
               	bl	<addr>
               	fmov	d1, x20
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x20, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d0, x20
               	bl	<addr>
               	bl	<addr>
               	fmov	d1, x20
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	fmov	d0, x0
               	bl	<addr>
               	fcvt	d0, s0
               	mov	x0, #0x0                // =0
               	fmov	d1, x0
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	fmov	d0, x0
               	bl	<addr>
               	fcvt	d0, s0
               	mov	x0, #0x0                // =0
               	fmov	d1, x0
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
