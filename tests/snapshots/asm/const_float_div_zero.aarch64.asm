
const_float_div_zero.aarch64:	file format elf64-littleaarch64

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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d1, [x0]
               	adrp	x16, <page>
               	ldr	d0, [x16]
               	fcmp	d1, d0
               	b.gt	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d1, [x0]
               	adrp	x16, <page>
               	ldr	d2, [x16, #0x8]
               	fcmp	d1, d2
               	b.mi	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d1, [x0]
               	fcmp	d1, d1
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	fmov	d1, #2.00000000
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fdiv	d1, d1, d17
               	fcmp	d1, d0
               	b.gt	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	ret
