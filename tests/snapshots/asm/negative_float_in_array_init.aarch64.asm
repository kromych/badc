
negative_float_in_array_init.aarch64:	file format elf64-littleaarch64

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
               	ldr	d0, [x0]
               	fmov	d1, #1.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldr	d0, [x0, #0x8]
               	fmov	d2, #-2.50000000
               	fcmp	d0, d2
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldr	d2, [x0, #0x10]
               	adrp	x16, <page>
               	ldr	d0, [x16, #0x18]
               	fcmp	d2, d0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldr	d2, [x0]
               	ldr	d3, [x0, #0x8]
               	fadd	d2, d2, d3
               	ldr	d3, [x0, #0x10]
               	fadd	d2, d2, d3
               	fmov	d3, #0.50000000
               	fadd	d3, d0, d3
               	fcmp	d2, d3
               	b.gt	<addr>
               	fsub	d0, d0, d1
               	fcmp	d2, d0
               	b.pl	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x0                // =0
               	ret
