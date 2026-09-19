
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
               	stur	d0, [x29, #-0x8]
               	ldur	d0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	d8, d9, [sp, #-0x40]!
               	stp	d10, d11, [sp, #0x10]
               	str	d12, [sp, #0x20]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	fmov	d0, #1.00000000
               	bl	<addr>
               	fmov	d8, d0
               	fmov	d0, #2.00000000
               	bl	<addr>
               	fmov	d9, d0
               	fmov	d0, #3.00000000
               	bl	<addr>
               	fmov	d10, d0
               	fmov	d0, #4.00000000
               	bl	<addr>
               	fmov	d11, d0
               	fmov	d0, #5.00000000
               	bl	<addr>
               	fmov	d12, d0
               	fmov	d0, #6.00000000
               	bl	<addr>
               	fmul	d1, d10, d11
               	fmadd	d1, d8, d9, d1
               	fmadd	d0, d12, d0, d1
               	fcvtzs	x0, d0
               	fmov	d1, #2.00000000
               	fmadd	d0, d0, d1, d8
               	fcvtzs	x1, d0
               	cmp	w0, #0x2c
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x30]
               	ldr	d12, [sp, #0x20]
               	ldp	d10, d11, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x40
               	ret
               	cmp	w1, #0x59
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x30]
               	ldr	d12, [sp, #0x20]
               	ldp	d10, d11, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x40
               	ret
               	fmov	d0, #10.00000000
               	bl	<addr>
               	fmov	d8, d0
               	fmov	d0, #1.00000000
               	bl	<addr>
               	fmov	d9, d0
               	movi	d0, #0000000000000000
               	bl	<addr>
               	fmov	d10, d0
               	movi	d0, #0000000000000000
               	bl	<addr>
               	fmov	d11, d0
               	movi	d0, #0000000000000000
               	bl	<addr>
               	fmov	d12, d0
               	movi	d0, #0000000000000000
               	bl	<addr>
               	fmul	d1, d10, d11
               	fmadd	d1, d8, d9, d1
               	fmadd	d0, d12, d0, d1
               	fcvtzs	x0, d0
               	fmov	d1, #2.00000000
               	fmadd	d0, d0, d1, d8
               	fcvtzs	x1, d0
               	cmp	w0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x30]
               	ldr	d12, [sp, #0x20]
               	ldp	d10, d11, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x40
               	ret
               	cmp	w1, #0x1e
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x30]
               	ldr	d12, [sp, #0x20]
               	ldp	d10, d11, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x40
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x30]
               	ldr	d12, [sp, #0x20]
               	ldp	d10, d11, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x40
               	ret
