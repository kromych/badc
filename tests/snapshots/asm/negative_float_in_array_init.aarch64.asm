
negative_float_in_array_init.aarch64:	file format elf64-littleaarch64

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
               	ldr	d0, [x0]
               	mov	x1, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d17, x1
               	fcmp	d0, d17
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldr	d0, [x0, #0x8]
               	mov	x1, #0x4004000000000000 // =4612811918334230528
               	fmov	d16, x1
               	fneg	d1, d16
               	fcmp	d0, d1
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldr	d0, [x0, #0x10]
               	mov	x1, #0x94000000         // =2483027968
               	movk	x1, #0x449a, lsl #32
               	movk	x1, #0x421e, lsl #48
               	fmov	d16, x1
               	fneg	d1, d16
               	fcmp	d0, d1
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldr	d0, [x0]
               	ldr	d1, [x0, #0x8]
               	fadd	d0, d0, d1
               	ldr	d1, [x0, #0x10]
               	fadd	d0, d0, d1
               	mov	x0, #0x94000000         // =2483027968
               	movk	x0, #0x449a, lsl #32
               	movk	x0, #0x421e, lsl #48
               	fmov	d16, x0
               	fneg	d1, d16
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d17, x0
               	fadd	d1, d1, d17
               	fcmp	d0, d1
               	cset	x1, gt
               	cbnz	x1, <addr>
               	mov	x0, #0x94000000         // =2483027968
               	movk	x0, #0x449a, lsl #32
               	movk	x0, #0x421e, lsl #48
               	fmov	d16, x0
               	fneg	d1, d16
               	mov	x0, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d17, x0
               	fsub	d1, d1, d17
               	fcmp	d0, d1
               	cset	x1, mi
               	cbz	x1, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	b	<addr>
