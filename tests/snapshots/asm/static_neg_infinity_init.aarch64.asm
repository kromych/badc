
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
               	mov	x1, #0xc8a0             // =51360
               	movk	x1, #0x85eb, lsl #16
               	movk	x1, #0xccf3, lsl #32
               	movk	x1, #0x7fe1, lsl #48
               	fmov	d16, x1
               	fneg	d1, d16
               	fcmp	d0, d1
               	b.pl	<addr>
               	fadd	d2, d0, d0
               	fcmp	d2, d0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	d0, [x2, #0x8]
               	fcmp	d0, d1
               	b.pl	<addr>
               	fadd	d2, d0, d0
               	fcmp	d2, d0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	d0, [x2]
               	fcmp	d0, d1
               	b.pl	<addr>
               	fadd	d1, d0, d0
               	fcmp	d1, d0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldr	d0, [x0]
               	fneg	d0, d0
               	fmov	d17, x1
               	fcmp	d0, d17
               	b.hi	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x0                // =0
               	ret
