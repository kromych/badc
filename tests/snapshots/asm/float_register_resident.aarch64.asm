
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
               	sub	sp, sp, #0x30
               	mov	x1, #0x0                // =0
               	fmov	d16, x1
               	fcvt	s0, d16
               	sxtw	x0, w1
               	cmp	x0, #0xa
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w1
               	add	x1, x0, #0x1
               	b	<addr>
               	sxtw	x0, w1
               	scvtf	d1, x0
               	fcvt	s1, d1
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	fcvt	d1, s1
               	fmov	d17, x0
               	fmul	d1, d1, d17
               	fcvt	s1, d1
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x0
               	fcvt	s2, d16
               	fmadd	s0, s1, s2, s0
               	b	<addr>
               	fcvt	d0, s0
               	fcvtzs	x0, d0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
