
inline_asm_a64_fp_arith.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x0, x29, #0x8
               	sub	sp, sp, #0x30
               	str	d0, [sp, #0x18]
               	str	d1, [sp, #0x20]
               	str	d2, [sp, #0x28]
               	str	x0, [sp]
               	str	d0, [sp, #0x8]
               	str	d1, [sp, #0x10]
               	ldr	d1, [sp, #0x8]
               	ldr	d2, [sp, #0x10]
               	fmul	d0, d1, d2
               	ldr	x16, [sp]
               	str	d0, [x16]
               	ldr	d0, [sp, #0x18]
               	ldr	d1, [sp, #0x20]
               	ldr	d2, [sp, #0x28]
               	add	sp, sp, #0x30
               	sub	x16, x29, #0x8
               	ldr	d0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<add>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x0, x29, #0x8
               	sub	sp, sp, #0x30
               	str	d0, [sp, #0x18]
               	str	d1, [sp, #0x20]
               	str	d2, [sp, #0x28]
               	str	x0, [sp]
               	str	d0, [sp, #0x8]
               	str	d1, [sp, #0x10]
               	ldr	d1, [sp, #0x8]
               	ldr	d2, [sp, #0x10]
               	fadd	d0, d1, d2
               	ldr	x16, [sp]
               	str	d0, [x16]
               	ldr	d0, [sp, #0x18]
               	ldr	d1, [sp, #0x20]
               	ldr	d2, [sp, #0x28]
               	add	sp, sp, #0x30
               	sub	x16, x29, #0x8
               	ldr	d0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<neg>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x0, x29, #0x8
               	sub	sp, sp, #0x20
               	str	d0, [sp, #0x10]
               	str	d1, [sp, #0x18]
               	str	x0, [sp]
               	str	d0, [sp, #0x8]
               	ldr	d1, [sp, #0x8]
               	fneg	d0, d1
               	ldr	x16, [sp]
               	str	d0, [x16]
               	ldr	d0, [sp, #0x10]
               	ldr	d1, [sp, #0x18]
               	add	sp, sp, #0x20
               	sub	x16, x29, #0x8
               	ldr	d0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	str	d8, [sp, #-0x30]!
               	str	x20, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, #0x4018000000000000 // =4618441417868443648
               	mov	x1, #0x4020000000000000 // =4620693217682128896
               	fmov	d0, x20
               	fmov	d1, x1
               	bl	<addr>
               	fmov	d8, d0
               	fmov	d0, x20
               	bl	<addr>
               	fmov	d1, d0
               	fmov	d0, d8
               	bl	<addr>
               	fcvtzs	x0, d0
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp, #0x10]
               	ldr	d8, [sp], #0x30
               	ret
