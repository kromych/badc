
inline_asm_a64_fp_arith.aarch64:	file format elf64-littleaarch64

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

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x16, #0x4018000000000000 // =4618441417868443648
               	str	x16, [sp]
               	mov	x16, #0x4020000000000000 // =4620693217682128896
               	str	x16, [sp, #0x8]
               	ldr	d1, [sp]
               	ldr	d2, [sp, #0x8]
               	fmul	d0, d1, d2
               	fmov	d2, d0
               	mov	x16, #0x4018000000000000 // =4618441417868443648
               	str	x16, [sp]
               	ldr	d1, [sp]
               	fneg	d0, d1
               	fadd	d0, d2, d0
               	fcvtzs	x0, d0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
