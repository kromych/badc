
array_2d_struct_init.aarch64:	file format elf64-littleaarch64

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
               	fmov	d0, #1.00000000
               	fcmp	d1, d0
               	b.ne	<addr>
               	ldr	d1, [x0, #0x18]
               	fmov	d2, #4.00000000
               	fcmp	d1, d2
               	b.ne	<addr>
               	ldr	d1, [x0, #0x20]
               	fmov	d2, #5.00000000
               	fcmp	d1, d2
               	b.ne	<addr>
               	ldr	d2, [x0, #0x38]
               	fmov	d1, #8.00000000
               	fcmp	d2, d1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d2, [x0]
               	fcmp	d2, d0
               	b.ne	<addr>
               	ldr	d0, [x0, #0x78]
               	fcmp	d0, d1
               	b.ne	<addr>
               	ldr	d0, [x0, #0x50]
               	fmov	d1, #6.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0]
               	fmov	d1, #9.00000000
               	fcmp	d0, d1
               	b.ne	<addr>
               	ldr	d0, [x0, #0x38]
               	fmov	d1, #16.00000000
               	fcmp	d0, d1
               	b.ne	<addr>
               	ldr	d0, [x0, #0x10]
               	fmov	d1, #11.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x0                // =0
               	ret
