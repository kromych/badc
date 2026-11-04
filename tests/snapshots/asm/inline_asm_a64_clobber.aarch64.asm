
inline_asm_a64_clobber.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x20
               	mov	x16, #0x13              // =19
               	str	x16, [sp]
               	mov	x16, #0xe               // =14
               	str	x16, [sp, #0x8]
               	mov	x16, #0x9               // =9
               	str	x16, [sp, #0x10]
               	ldr	x1, [sp]
               	ldr	x3, [sp, #0x8]
               	ldr	x4, [sp, #0x10]
               	mov	x2, #0x0                // =0
               	add	w0, w1, w3
               	add	w0, w0, w4
               	cmp	w0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x4034000000000000 // =4626322717216342016
               	str	x16, [sp]
               	mov	x16, #0x402c000000000000 // =4624070917402656768
               	str	x16, [sp, #0x8]
               	mov	x16, #0x4020000000000000 // =4620693217682128896
               	str	x16, [sp, #0x10]
               	ldr	d2, [sp]
               	ldr	d3, [sp, #0x8]
               	ldr	d4, [sp, #0x10]
               	fmov	d1, xzr
               	fadd	d0, d2, d3
               	fadd	d0, d0, d4
               	fcvtzs	x0, d0
               	cmp	w0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
