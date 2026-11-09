
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
               	ldr	d1, [x0, #0x18]
               	adrp	x16, <page>
               	ldr	d0, [x16]
               	fcmpe	d1, d0
               	b.gt	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x0, <page>
               	ldr	d1, [x0, #0x20]
               	adrp	x16, <page>
               	ldr	d2, [x16, #0x8]
               	fcmpe	d1, d2
               	b.mi	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x0, <page>
               	ldr	d1, [x0, #0x28]
               	fcmp	d1, d1
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x16, #0x7ff0000000000000 // =9218868437227405312
               	fmov	d1, x16
               	fcmpe	d1, d0
               	b.gt	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x0                // =0
               	ret
