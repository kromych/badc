
unary_plus_init_and_param_shadow.aarch64:	file format elf64-littleaarch64

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

<f>:
               	sxtw	x0, w0
               	ret

<main>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0]
               	adrp	x16, <page>
               	ldr	d1, [x16]
               	fsub	d2, d0, d1
               	adrp	x16, <page>
               	ldr	d0, [x16, #0x8]
               	fcmp	d2, d0
               	b.pl	<addr>
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x10]
               	fcmp	d2, d1
               	b.gt	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldr	d2, [x0, #0x8]
               	adrp	x16, <page>
               	ldr	d3, [x16, #0x18]
               	fsub	d2, d2, d3
               	fcmp	d2, d0
               	b.pl	<addr>
               	fcmp	d2, d1
               	b.gt	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldr	d2, [x0, #0x10]
               	fmov	d3, #1.00000000
               	fsub	d2, d2, d3
               	fcmp	d2, d0
               	b.pl	<addr>
               	fcmp	d2, d1
               	b.gt	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldr	d2, [x0, #0x18]
               	fmov	d3, #-2.00000000
               	fsub	d2, d2, d3
               	fcmp	d2, d0
               	b.pl	<addr>
               	fcmp	d2, d1
               	b.gt	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	cmp	w1, #0x5
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0x4]
               	mov	x17, #-0x3              // =-3
               	cmp	w1, w17
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0x8]
               	cbnz	w1, <addr>
               	ldrsw	x0, [x0, #0xc]
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x0                // =0
               	ret
