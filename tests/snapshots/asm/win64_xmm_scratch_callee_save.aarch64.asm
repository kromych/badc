
win64_xmm_scratch_callee_save.aarch64:	file format elf64-littleaarch64

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

<rt>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x17, x29, #0x8
               	str	d0, [x17]
               	sub	x16, x29, #0x8
               	ldr	d0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	d8, d9, [sp, #-0x50]!
               	stp	d10, d11, [sp, #0x10]
               	str	d12, [sp, #0x20]
               	str	x20, [sp, #0x30]
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d0, x0
               	bl	<addr>
               	fmov	d8, d0
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d0, x0
               	bl	<addr>
               	fmov	d9, d0
               	mov	x0, #0x4008000000000000 // =4613937818241073152
               	fmov	d0, x0
               	bl	<addr>
               	fmov	d11, d0
               	mov	x0, #0x4010000000000000 // =4616189618054758400
               	fmov	d0, x0
               	bl	<addr>
               	fmov	d12, d0
               	mov	x0, #0x4014000000000000 // =4617315517961601024
               	fmov	d0, x0
               	bl	<addr>
               	fmov	d10, d0
               	mov	x0, #0x4018000000000000 // =4618441417868443648
               	fmov	d0, x0
               	bl	<addr>
               	fmul	d1, d11, d12
               	fmadd	d1, d8, d9, d1
               	fmadd	d0, d10, d0, d1
               	fcvtzs	x0, d0
               	mov	x1, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x1
               	fmadd	d0, d0, d17, d8
               	fcvtzs	x1, d0
               	cmp	w0, #0x2c
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x20, [sp, #0x30]
               	ldr	d12, [sp, #0x20]
               	ldp	d10, d11, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x50
               	ret
               	cmp	w1, #0x59
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x20, [sp, #0x30]
               	ldr	d12, [sp, #0x20]
               	ldp	d10, d11, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x50
               	ret
               	mov	x0, #0x4024000000000000 // =4621819117588971520
               	fmov	d0, x0
               	bl	<addr>
               	fmov	d8, d0
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d0, x0
               	bl	<addr>
               	fmov	d9, d0
               	mov	x20, #0x0               // =0
               	fmov	d0, x20
               	bl	<addr>
               	fmov	d11, d0
               	fmov	d0, x20
               	bl	<addr>
               	fmov	d12, d0
               	fmov	d0, x20
               	bl	<addr>
               	fmov	d10, d0
               	fmov	d0, x20
               	bl	<addr>
               	fmul	d1, d11, d12
               	fmadd	d1, d8, d9, d1
               	fmadd	d0, d10, d0, d1
               	fcvtzs	x0, d0
               	mov	x1, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x1
               	fmadd	d0, d0, d17, d8
               	fcvtzs	x1, d0
               	cmp	w0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x20, [sp, #0x30]
               	ldr	d12, [sp, #0x20]
               	ldp	d10, d11, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x50
               	ret
               	cmp	w1, #0x1e
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x20, [sp, #0x30]
               	ldr	d12, [sp, #0x20]
               	ldp	d10, d11, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x50
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x20, [sp, #0x30]
               	ldr	d12, [sp, #0x20]
               	ldp	d10, d11, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x50
               	ret
