
libc_fp_return_value.aarch64:	file format elf64-littleaarch64

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
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x20, #0x1               // =1
               	fmov	d0, #4.00000000
               	fsqrt	d0, d0
               	fmov	d1, #2.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x20, #0x0               // =0
               	adrp	x16, <page>
               	ldr	d0, [x16]
               	frintm	d0, d0
               	fmov	d1, #2.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x20, #0x0               // =0
               	adrp	x16, <page>
               	ldr	d0, [x16, #0x8]
               	frintp	d0, d0
               	fmov	d1, #3.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x20, #0x0               // =0
               	fmov	d0, #3.50000000
               	fneg	d1, d0
               	fabs	d1, d1
               	fcmp	d1, d0
               	b.eq	<addr>
               	mov	x20, #0x0               // =0
               	fmov	d0, #7.00000000
               	fmov	d1, #4.00000000
               	bl	<addr>
               	fmov	d1, #3.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x20, #0x0               // =0
               	fmov	s0, #4.00000000
               	fsqrt	s0, s0
               	fmov	s1, #2.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x20, #0x0               // =0
               	fmov	s0, #3.50000000
               	fneg	s1, s0
               	fabs	s1, s1
               	fcmp	s1, s0
               	b.eq	<addr>
               	mov	x20, #0x0               // =0
               	fmov	s0, #16.00000000
               	fsqrt	s0, s0
               	fcvt	d0, s0
               	fmov	d1, #4.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x20, #0x0               // =0
               	adrp	x16, <page>
               	ldr	s0, [x16, #0x10]
               	frintm	s0, s0
               	fmov	s1, #2.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x20, #0x0               // =0
               	adrp	x16, <page>
               	ldr	s0, [x16, #0x14]
               	frintp	s0, s0
               	fmov	s1, #3.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x20, #0x0               // =0
               	fmov	s0, #7.00000000
               	fmov	s1, #4.00000000
               	bl	<addr>
               	fmov	s1, #3.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	cbz	x20, <addr>
               	mov	x0, #0xb                // =11
               	b	<addr>
