
float_long_double_suffix.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400238 <.text+0x18>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	mov	x15, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d0, x15
               	fmov	d1, x15
               	fcmp	d0, d1
               	cset	x14, ne
               	cbz	x14, 0x40026c <.text+0x4c>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d0, x15
               	fmov	d1, x15
               	fcmp	d0, d1
               	cset	x14, ne
               	cbz	x14, 0x400290 <.text+0x70>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d0, x15
               	fmov	d1, x15
               	fcmp	d0, d1
               	cset	x14, ne
               	cbz	x14, 0x4002b4 <.text+0x94>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d0, x15
               	fmov	d1, x14
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, 0x4002e0 <.text+0xc0>
               	mov	x14, #0xe               // =14
               	mov	x0, x14
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xb0000000         // =2952790016
               	movk	x0, #0xf08e, lsl #32
               	movk	x0, #0x420b, lsl #48
               	fmov	d0, x0
               	fmov	d1, x0
               	fcmp	d0, d1
               	cset	x14, ne
               	cbz	x14, 0x400310 <.text+0xf0>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x7               // =7
               	cmp	x14, #0x7
               	b.eq	0x400330 <.text+0x110>
               	mov	x14, #0x10              // =16
               	mov	x0, x14
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
