
static_neg_infinity_init.aarch64:	file format elf64-littleaarch64

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
               	adrp	x16, <page>
               	ldr	d2, [x16]
               	fneg	d1, d2
               	fcmp	d0, d1
               	b.pl	<addr>
               	fadd	d3, d0, d0
               	fcmp	d3, d0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	d0, [x1, #0x8]
               	fcmp	d0, d1
               	b.pl	<addr>
               	fadd	d3, d0, d0
               	fcmp	d3, d0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	d0, [x1]
               	fcmp	d0, d1
               	b.pl	<addr>
               	fadd	d1, d0, d0
               	fcmp	d1, d0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldr	d0, [x0]
               	fneg	d0, d0
               	fcmp	d0, d2
               	b.hi	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x0                // =0
               	ret
