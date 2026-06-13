
float_register_resident.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	fmadd	s0, s0, s1, s2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	d8, [sp]
               	str	x20, [sp, #0x10]
               	mov	x20, #0x0               // =0
               	fmov	d16, x20
               	fcvt	s8, d16
               	sxtw	x0, w20
               	cmp	x0, #0xa
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w20
               	add	x20, x0, #0x1
               	b	<addr>
               	sxtw	x0, w20
               	scvtf	d0, x0
               	fcvt	s0, d0
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	fcvt	d0, s0
               	fmov	d17, x0
               	fmul	d0, d0, d17
               	fcvt	s0, d0
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x0
               	fcvt	s1, d16
               	fmov	d2, d8
               	bl	<addr>
               	fmov	d8, d0
               	b	<addr>
               	fcvt	d0, s8
               	fcvtzs	x0, d0
               	ldr	x20, [sp, #0x10]
               	ldr	d8, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
