
float_arith_in_static_init.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x230              // =560
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	s0, [x0]
               	mov	x1, #0x40000000         // =1073741824
               	fmov	s17, w1
               	fcmp	s0, s17
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldr	s0, [x0, #0x4]
               	mov	x1, #0x40200000         // =1075838976
               	fmov	s16, w1
               	fneg	s1, s16
               	fcmp	s0, s1
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldr	s0, [x0, #0x8]
               	mov	x0, #0x41400000         // =1094713344
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0]
               	mov	x0, #0x8f5c             // =36700
               	movk	x0, #0xf5c2, lsl #16
               	movk	x0, #0x5c28, lsl #32
               	movk	x0, #0x400f, lsl #48
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, mi
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0]
               	mov	x0, #0x3d71             // =15729
               	movk	x0, #0xd70a, lsl #16
               	movk	x0, #0x70a3, lsl #32
               	movk	x0, #0x400f, lsl #48
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, gt
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0, #0x8]
               	mov	x0, #0x3fe8000000000000 // =4604930618986332160
               	fmov	d16, x0
               	fneg	d1, d16
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	b	<addr>
