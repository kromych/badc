
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
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	d0, [x3]
               	mov	x2, #0xc8a0             // =51360
               	movk	x2, #0x85eb, lsl #16
               	movk	x2, #0xccf3, lsl #32
               	movk	x2, #0x7fe1, lsl #48
               	fmov	d16, x2
               	fneg	d1, d16
               	fcmp	d0, d1
               	mov	x0, #0x0                // =0
               	b.pl	<addr>
               	fadd	d2, d0, d0
               	fcmp	d2, d0
               	cset	x1, eq
               	sxtw	x1, w1
               	cbnz	x1, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	d0, [x1, #0x8]
               	fcmp	d0, d1
               	b.pl	<addr>
               	fadd	d2, d0, d0
               	fcmp	d2, d0
               	cset	x1, eq
               	sxtw	x1, w1
               	cbnz	x1, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	d0, [x1]
               	fcmp	d0, d1
               	b.pl	<addr>
               	fadd	d1, d0, d0
               	fcmp	d1, d0
               	cset	x0, eq
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldr	d0, [x3]
               	fneg	d0, d0
               	mov	x0, #0xc8a0             // =51360
               	movk	x0, #0x85eb, lsl #16
               	movk	x0, #0xccf3, lsl #32
               	movk	x0, #0x7fe1, lsl #48
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.hi	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
