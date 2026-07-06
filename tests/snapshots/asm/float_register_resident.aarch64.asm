
float_register_resident.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	fmadd	s0, s0, s1, s2
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	mov	x0, #0x0                // =0
               	fmov	s16, w0
               	sub	x17, x29, #0x8
               	str	s16, [x17]
               	mov	x1, #0x0                // =0
               	b	<addr>
               	sxtw	x0, w1
               	scvtf	d0, x0
               	fcvt	s0, d0
               	mov	x0, #0x3f000000         // =1056964608
               	fmov	s17, w0
               	fmul	s0, s0, s17
               	mov	x0, #0x40000000         // =1073741824
               	sub	x16, x29, #0x8
               	ldr	s1, [x16]
               	fmov	s17, w0
               	fmadd	s0, s0, s17, s1
               	sub	x17, x29, #0x8
               	str	s0, [x17]
               	sxtw	x0, w1
               	add	x1, x0, #0x1
               	sxtw	x0, w1
               	cmp	x0, #0xa
               	b.lt	<addr>
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	fcvt	d0, s0
               	fcvtzs	x0, d0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
