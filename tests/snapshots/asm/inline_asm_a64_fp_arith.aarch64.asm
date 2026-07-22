
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
               	sub	sp, sp, #0x40
               	mov	x0, #0x4018000000000000 // =4618441417868443648
               	mov	x1, #0x4020000000000000 // =4620693217682128896
               	sub	x2, x29, #0x30
               	sub	sp, sp, #0x30
               	str	d0, [sp, #0x18]
               	str	d1, [sp, #0x20]
               	str	d2, [sp, #0x28]
               	str	x2, [sp]
               	fmov	d16, x0
               	str	d16, [sp, #0x8]
               	fmov	d16, x1
               	str	d16, [sp, #0x10]
               	ldr	d1, [sp, #0x8]
               	ldr	d2, [sp, #0x10]
               	fmul	d0, d1, d2
               	ldr	x16, [sp]
               	str	d0, [x16]
               	ldr	d0, [sp, #0x18]
               	ldr	d1, [sp, #0x20]
               	ldr	d2, [sp, #0x28]
               	add	sp, sp, #0x30
               	sub	x16, x29, #0x30
               	ldr	d0, [x16]
               	sub	x1, x29, #0x38
               	sub	sp, sp, #0x20
               	str	d0, [sp, #0x10]
               	str	d1, [sp, #0x18]
               	str	x1, [sp]
               	fmov	d16, x0
               	str	d16, [sp, #0x8]
               	ldr	d1, [sp, #0x8]
               	fneg	d0, d1
               	ldr	x16, [sp]
               	str	d0, [x16]
               	ldr	d0, [sp, #0x10]
               	ldr	d1, [sp, #0x18]
               	add	sp, sp, #0x20
               	sub	x16, x29, #0x38
               	ldr	d1, [x16]
               	sub	x0, x29, #0x40
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
               	sub	x16, x29, #0x40
               	ldr	d0, [x16]
               	fcvtzs	x0, d0
               	sxtw	x0, w0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
