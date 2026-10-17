
call_conv_declarator_positions.aarch64:	file format elf64-littleaarch64

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

<msf>:
               	mov	x17, #0x5               // =5
               	mul	x0, x0, x17
               	add	x0, x0, x1
               	ret

<svf>:
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	sub	x0, x0, x1
               	ret

<plainf>:
               	add	x0, x1, x0, lsl #1
               	ret

<msf6>:
               	add	x0, x0, x1, lsl #1
               	mov	x17, #0x3               // =3
               	mul	x1, x2, x17
               	add	x0, x0, x1
               	add	x0, x0, x3, lsl #2
               	mov	x17, #0x5               // =5
               	mul	x1, x4, x17
               	add	x0, x0, x1
               	mov	x17, #0x6               // =6
               	mul	x1, x5, x17
               	add	x0, x0, x1
               	ret

<svf6>:
               	sub	x0, x0, x1, lsl #1
               	mov	x17, #0x3               // =3
               	mul	x1, x2, x17
               	add	x0, x0, x1
               	sub	x0, x0, x3, lsl #2
               	mov	x17, #0x5               // =5
               	mul	x1, x4, x17
               	add	x0, x0, x1
               	mov	x17, #0x6               // =6
               	mul	x1, x5, x17
               	sub	x0, x0, x1
               	ret

<msd>:
               	sxtw	x0, w0
               	scvtf	d2, x0
               	fmov	d3, #10.00000000
               	fmadd	d0, d0, d3, d2
               	mov	x17, #0x64              // =100
               	mul	x0, x1, x17
               	sxtw	x0, w0
               	scvtf	d2, x0
               	fadd	d0, d0, d2
               	adrp	x16, <page>
               	ldr	d2, [x16]
               	fmadd	d0, d1, d2, d0
               	ret

<svd>:
               	sxtw	x0, w0
               	scvtf	d2, x0
               	fmov	d3, #10.00000000
               	fmsub	d0, d0, d3, d2
               	mov	x17, #0x64              // =100
               	mul	x0, x1, x17
               	sxtw	x0, w0
               	scvtf	d2, x0
               	fadd	d0, d0, d2
               	adrp	x16, <page>
               	ldr	d2, [x16]
               	fmsub	d0, d1, d2, d0
               	ret

<positions>:
               	stp	x20, x21, [sp, #-0x40]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x20, x0
               	mov	x21, x1
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	cmp	x0, #0x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	cmp	x0, #0x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	cmp	x0, #0x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x8]
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	cmp	x0, #0x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	cmp	x0, #0x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	cmp	x0, #0x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	cmp	x0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0]
               	mov	x0, x20
               	mov	x1, x21
               	blr	x2
               	cmp	x0, #0x17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	cmp	x0, #0x17
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	mov	x22, x0
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	mov	x17, #0x64              // =100
               	mul	x0, x0, x17
               	add	x0, x22, x0
               	cmp	x0, #0x38d
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	mov	x17, #0x64              // =100
               	mul	x22, x0, x17
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	add	x0, x22, x0
               	cmp	x0, #0x38f
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	mov	x17, #0x64              // =100
               	mul	x22, x0, x17
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	add	x0, x22, x0
               	cmp	x0, #0x38f
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	mov	x17, #0x64              // =100
               	mul	x22, x0, x17
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	add	x0, x22, x0
               	cmp	x0, #0x455
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	cmp	x0, #0x17
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	mov	x17, #0x64              // =100
               	mul	x22, x0, x17
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	add	x0, x22, x0
               	cmp	x0, #0x905
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	ldur	x2, [x29, #-0x8]
               	mov	x0, x20
               	mov	x1, x21
               	blr	x2
               	cmp	x0, #0x17
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	cmp	x0, #0x17
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x1                // =1
               	mov	x1, #0x2                // =2
               	mov	x2, #0x3                // =3
               	mov	x3, #0x4                // =4
               	mov	x4, #0x5                // =5
               	mov	x5, #0x6                // =6
               	bl	<addr>
               	cmp	x0, #0x5b
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x1                // =1
               	mov	x1, #0x2                // =2
               	mov	x2, #0x3                // =3
               	mov	x3, #0x4                // =4
               	mov	x4, #0x5                // =5
               	mov	x5, #0x6                // =6
               	bl	<addr>
               	mov	x17, #-0x15             // =-21
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x1                // =1
               	fmov	d0, #2.50000000
               	mov	x1, #0x3                // =3
               	fmov	d1, #4.50000000
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x8]
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x1                // =1
               	fmov	d0, #2.50000000
               	mov	x1, #0x3                // =3
               	fmov	d1, #4.50000000
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x10]
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	cmp	x0, #0x17
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	cmp	x0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	cmp	x0, #0x17
               	b.eq	<addr>
               	mov	x0, #0x18               // =24
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret

<casts>:
               	stp	x20, x21, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x20, x0
               	mov	x21, x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x1, [x0]
               	ldr	x2, [x0]
               	mov	x0, x20
               	mov	x1, x21
               	blr	x2
               	cmp	x0, #0x17
               	b.eq	<addr>
               	mov	x0, #0x1f               // =31
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0]
               	mov	x0, x20
               	mov	x1, x21
               	blr	x2
               	cmp	x0, #0x17
               	b.eq	<addr>
               	mov	x0, #0x20               // =32
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0]
               	mov	x0, x20
               	mov	x1, x21
               	blr	x2
               	cmp	x0, #0x17
               	b.eq	<addr>
               	mov	x0, #0x21               // =33
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x1, [x0]
               	ldr	x2, [x0]
               	mov	x0, x20
               	mov	x1, x21
               	blr	x2
               	cmp	x0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x22               // =34
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0]
               	mov	x0, x20
               	mov	x1, x21
               	blr	x2
               	cmp	x0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x23               // =35
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x4                // =4
               	mov	x1, #0x3                // =3
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	mov	x1, #0x3                // =3
               	bl	<addr>
               	b	<addr>
