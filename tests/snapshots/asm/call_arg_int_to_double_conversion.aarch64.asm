
call_arg_int_to_double_conversion.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400450 <.text+0x150>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0x108]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	sxtw	x20, w0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x118
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x12, x14, x13
               	ldr	x13, [x12]
               	cbz	x13, 0x40038c <.text+0x8c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x118
               	mov	x12, x19
               	lsl	x13, x20, #3
               	add	x14, x12, x13
               	ldr	x13, [x14]
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x18
               	mov	x21, #0x0               // =0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x130
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x12, x11, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x136
               	mov	x11, x19
               	str	x11, [x12]
               	sub	x14, x29, #0x18
               	add	x11, x14, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x13d
               	mov	x14, x19
               	str	x14, [x11]
               	sub	x12, x29, #0x18
               	lsl	x14, x20, #3
               	add	x11, x12, x14
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x4008f8 <dlsym>
               	mov	x11, x0
               	cbz	x11, 0x400418 <.text+0x118>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x118
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x12, x22, x21
               	ldr	x21, [x11]
               	str	x21, [x12]
               	b	0x400418 <.text+0x118>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x118
               	mov	x21, x19
               	lsl	x11, x20, #3
               	add	x20, x21, x11
               	ldr	x11, [x20]
               	mov	x0, x11
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	str	d8, [sp]
               	str	d9, [sp, #0x8]
               	str	x20, [sp, #0x10]
               	str	x21, [sp, #0x18]
               	str	x22, [sp, #0x20]
               	str	x23, [sp, #0x28]
               	str	x19, [sp, #0x30]
               	mov	x20, #0x4000000000000000 // =4611686018427387904
               	mov	x14, #0x1               // =1
               	scvtf	d8, x14
               	fmov	d0, x20
               	fmov	x16, d8
               	fmov	d1, x16
               	bl	0x400904 <pow>
               	fmov	x0, d0
               	mov	x14, x0
               	fmov	d0, x14
               	fmov	d1, x20
               	fcmp	d0, d1
               	cset	x13, ne
               	cbz	x13, 0x4004e0 <.text+0x1e0>
               	mov	x14, #0x1               // =1
               	mov	x0, x14
               	ldr	x20, [sp, #0x10]
               	ldr	x21, [sp, #0x18]
               	ldr	x22, [sp, #0x20]
               	ldr	x23, [sp, #0x28]
               	ldr	d8, [sp]
               	ldr	d9, [sp, #0x8]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x4000000000000000 // =4611686018427387904
               	mov	x14, #0x2               // =2
               	scvtf	d9, x14
               	fmov	d0, x21
               	fmov	x16, d9
               	fmov	d1, x16
               	bl	0x400904 <pow>
               	fmov	x0, d0
               	mov	x14, x0
               	mov	x21, #0x4010000000000000 // =4616189618054758400
               	fmov	d0, x14
               	fmov	d1, x21
               	fcmp	d0, d1
               	cset	x20, ne
               	cbz	x20, 0x40054c <.text+0x24c>
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	ldr	x20, [sp, #0x10]
               	ldr	x21, [sp, #0x18]
               	ldr	x22, [sp, #0x20]
               	ldr	x23, [sp, #0x28]
               	ldr	d8, [sp]
               	ldr	d9, [sp, #0x8]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x22, #0x4000000000000000 // =4611686018427387904
               	mov	x21, #0x3               // =3
               	scvtf	d8, x21
               	fmov	d0, x22
               	fmov	x16, d8
               	fmov	d1, x16
               	bl	0x400904 <pow>
               	fmov	x0, d0
               	mov	x21, x0
               	mov	x22, #0x4020000000000000 // =4620693217682128896
               	fmov	d0, x21
               	fmov	d1, x22
               	fcmp	d0, d1
               	cset	x14, ne
               	cbz	x14, 0x4005b8 <.text+0x2b8>
               	mov	x22, #0x3               // =3
               	mov	x0, x22
               	ldr	x20, [sp, #0x10]
               	ldr	x21, [sp, #0x18]
               	ldr	x22, [sp, #0x20]
               	ldr	x23, [sp, #0x28]
               	ldr	d8, [sp]
               	ldr	d9, [sp, #0x8]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x4000000000000000 // =4611686018427387904
               	mov	x22, #0x4               // =4
               	scvtf	d9, x22
               	fmov	d0, x20
               	fmov	x16, d9
               	fmov	d1, x16
               	bl	0x400904 <pow>
               	fmov	x0, d0
               	mov	x22, x0
               	mov	x20, #0x4030000000000000 // =4625196817309499392
               	fmov	d0, x22
               	fmov	d1, x20
               	fcmp	d0, d1
               	cset	x21, ne
               	cbz	x21, 0x400624 <.text+0x324>
               	mov	x20, #0x4               // =4
               	mov	x0, x20
               	ldr	x20, [sp, #0x10]
               	ldr	x21, [sp, #0x18]
               	ldr	x22, [sp, #0x20]
               	ldr	x23, [sp, #0x28]
               	ldr	d8, [sp]
               	ldr	d9, [sp, #0x8]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x2               // =2
               	mov	x23, #0x4000000000000000 // =4611686018427387904
               	sxtw	x22, w21
               	scvtf	d8, x22
               	fmov	d0, x23
               	fmov	x16, d8
               	fmov	d1, x16
               	bl	0x400904 <pow>
               	fmov	x0, d0
               	mov	x22, x0
               	mov	x23, #0x4010000000000000 // =4616189618054758400
               	fmov	d0, x22
               	fmov	d1, x23
               	fcmp	d0, d1
               	cset	x21, ne
               	cbz	x21, 0x400694 <.text+0x394>
               	mov	x23, #0x5               // =5
               	mov	x0, x23
               	ldr	x20, [sp, #0x10]
               	ldr	x21, [sp, #0x18]
               	ldr	x22, [sp, #0x20]
               	ldr	x23, [sp, #0x28]
               	ldr	d8, [sp]
               	ldr	d9, [sp, #0x8]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x3               // =3
               	mov	x20, #0x4000000000000000 // =4611686018427387904
               	sxtw	x22, w21
               	scvtf	d9, x22
               	fmov	d0, x20
               	fmov	x16, d9
               	fmov	d1, x16
               	bl	0x400904 <pow>
               	fmov	x0, d0
               	mov	x22, x0
               	mov	x20, #0x4020000000000000 // =4620693217682128896
               	fmov	d0, x22
               	fmov	d1, x20
               	fcmp	d0, d1
               	cset	x21, ne
               	cbz	x21, 0x400704 <.text+0x404>
               	mov	x20, #0x6               // =6
               	mov	x0, x20
               	ldr	x20, [sp, #0x10]
               	ldr	x21, [sp, #0x18]
               	ldr	x22, [sp, #0x20]
               	ldr	x23, [sp, #0x28]
               	ldr	d8, [sp]
               	ldr	d9, [sp, #0x8]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x23, #0x4000000000000000 // =4611686018427387904
               	mov	x20, #0x2               // =2
               	scvtf	d8, x20
               	fmov	d0, x23
               	fmov	x16, d8
               	fmov	d1, x16
               	bl	0x400904 <pow>
               	fmov	x0, d0
               	mov	x20, x0
               	mov	x23, #0x4010000000000000 // =4616189618054758400
               	fmov	d0, x20
               	fmov	d1, x23
               	fcmp	d0, d1
               	cset	x22, ne
               	cbz	x22, 0x400770 <.text+0x470>
               	mov	x23, #0x7               // =7
               	mov	x0, x23
               	ldr	x20, [sp, #0x10]
               	ldr	x21, [sp, #0x18]
               	ldr	x22, [sp, #0x20]
               	ldr	x23, [sp, #0x28]
               	ldr	d8, [sp]
               	ldr	d9, [sp, #0x8]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x168
               	mov	x21, x19
               	mov	x0, x21
               	bl	0x400910 <printf>
               	sxtw	x0, w0
               	mov	x23, x0
               	mov	x23, #0x0               // =0
               	mov	x0, x23
               	ldr	x20, [sp, #0x10]
               	ldr	x21, [sp, #0x18]
               	ldr	x22, [sp, #0x20]
               	ldr	x23, [sp, #0x28]
               	ldr	d8, [sp]
               	ldr	d9, [sp, #0x8]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
