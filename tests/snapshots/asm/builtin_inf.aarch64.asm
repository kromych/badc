
builtin_inf.aarch64:	file format elf64-littleaarch64

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
               	adrp	x16, <page>
               	ldr	d0, [x16]
               	fmov	d1, #10.00000000
               	fmul	d1, d0, d1
               	fcmp	d1, d0
               	b.gt	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	fcvt	s2, d1
               	adrp	x16, <page>
               	ldr	s3, [x16, #0x8]
               	fcmp	s2, s3
               	b.gt	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	fcmp	d1, d0
               	b.hi	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x0                // =0
               	ret
