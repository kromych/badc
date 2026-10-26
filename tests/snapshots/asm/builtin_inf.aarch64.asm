
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
               	mov	x16, #0x7ff0000000000000 // =9218868437227405312
               	fmov	d0, x16
               	adrp	x16, <page>
               	ldr	d1, [x16]
               	fcmp	d0, d1
               	b.gt	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x16, #0x7f800000        // =2139095040
               	fmov	s2, w16
               	adrp	x16, <page>
               	ldr	s3, [x16, #0x8]
               	fcmp	s2, s3
               	b.gt	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	fcmp	d0, d1
               	b.hi	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x0                // =0
               	ret
