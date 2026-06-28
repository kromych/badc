
const_float_init_int_lead.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0]
               	mov	x0, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0]
               	mov	x0, #0x400c000000000000 // =4615063718147915776
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	s0, [x0]
               	mov	x0, #0x3ff8000000000000 // =4609434218613702656
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x0                // =0
               	ret
