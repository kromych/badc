
call_arg_int_to_double_conversion.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
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
               	adrp	x19, <page>
               	add	x19, x19, #0x118
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x14, [x14]
               	cbz	x14, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x118
               	mov	x13, x19
               	lsl	x14, x20, #3
               	add	x13, x13, x14
               	ldr	x13, [x13]
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
               	adrp	x19, <page>
               	add	x19, x19, #0x130
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x19, <page>
               	add	x19, x19, #0x136
               	mov	x12, x19
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x19, <page>
               	add	x19, x19, #0x13d
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	<addr>
               	cbz	x0, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x118
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x22, x22, x21
               	ldr	x0, [x0]
               	str	x0, [x22]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x118
               	mov	x0, x19
               	lsl	x20, x20, #3
               	add	x0, x0, x20
               	ldr	x0, [x0]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	d8, [sp]
               	str	d9, [sp, #0x8]
               	str	x20, [sp, #0x10]
               	str	x21, [sp, #0x18]
               	str	x19, [sp, #0x20]
               	mov	x20, #0x4000000000000000 // =4611686018427387904
               	mov	x14, #0x1               // =1
               	scvtf	d8, x14
               	fmov	d0, x20
               	fmov	x16, d8
               	fmov	d1, x16
               	bl	<addr>
               	fmov	x0, d0
               	fmov	d0, x0
               	fmov	d1, x20
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x20, #0x1               // =1
               	mov	x0, x20
               	ldr	x20, [sp, #0x10]
               	ldr	x21, [sp, #0x18]
               	ldr	d8, [sp]
               	ldr	d9, [sp, #0x8]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x4000000000000000 // =4611686018427387904
               	mov	x20, #0x2               // =2
               	scvtf	d9, x20
               	fmov	d0, x21
               	fmov	x16, d9
               	fmov	d1, x16
               	bl	<addr>
               	fmov	x0, d0
               	mov	x21, #0x4010000000000000 // =4616189618054758400
               	fmov	d0, x0
               	fmov	d1, x21
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	ldr	x20, [sp, #0x10]
               	ldr	x21, [sp, #0x18]
               	ldr	d8, [sp]
               	ldr	d9, [sp, #0x8]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x4000000000000000 // =4611686018427387904
               	mov	x21, #0x3               // =3
               	scvtf	d8, x21
               	fmov	d0, x20
               	fmov	x16, d8
               	fmov	d1, x16
               	bl	<addr>
               	fmov	x0, d0
               	mov	x20, #0x4020000000000000 // =4620693217682128896
               	fmov	d0, x0
               	fmov	d1, x20
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x20, #0x3               // =3
               	mov	x0, x20
               	ldr	x20, [sp, #0x10]
               	ldr	x21, [sp, #0x18]
               	ldr	d8, [sp]
               	ldr	d9, [sp, #0x8]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x4000000000000000 // =4611686018427387904
               	mov	x20, #0x4               // =4
               	scvtf	d9, x20
               	fmov	d0, x21
               	fmov	x16, d9
               	fmov	d1, x16
               	bl	<addr>
               	fmov	x0, d0
               	mov	x21, #0x4030000000000000 // =4625196817309499392
               	fmov	d0, x0
               	fmov	d1, x21
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x21, #0x4               // =4
               	mov	x0, x21
               	ldr	x20, [sp, #0x10]
               	ldr	x21, [sp, #0x18]
               	ldr	d8, [sp]
               	ldr	d9, [sp, #0x8]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	mov	x20, #0x4000000000000000 // =4611686018427387904
               	sxtw	x0, w0
               	scvtf	d8, x0
               	fmov	d0, x20
               	fmov	x16, d8
               	fmov	d1, x16
               	bl	<addr>
               	fmov	x0, d0
               	mov	x20, #0x4010000000000000 // =4616189618054758400
               	fmov	d0, x0
               	fmov	d1, x20
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x20, #0x5               // =5
               	mov	x0, x20
               	ldr	x20, [sp, #0x10]
               	ldr	x21, [sp, #0x18]
               	ldr	d8, [sp]
               	ldr	d9, [sp, #0x8]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	mov	x21, #0x4000000000000000 // =4611686018427387904
               	sxtw	x0, w0
               	scvtf	d9, x0
               	fmov	d0, x21
               	fmov	x16, d9
               	fmov	d1, x16
               	bl	<addr>
               	fmov	x0, d0
               	mov	x21, #0x4020000000000000 // =4620693217682128896
               	fmov	d0, x0
               	fmov	d1, x21
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x21, #0x6               // =6
               	mov	x0, x21
               	ldr	x20, [sp, #0x10]
               	ldr	x21, [sp, #0x18]
               	ldr	d8, [sp]
               	ldr	d9, [sp, #0x8]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x4000000000000000 // =4611686018427387904
               	mov	x21, #0x2               // =2
               	scvtf	d8, x21
               	fmov	d0, x20
               	fmov	x16, d8
               	fmov	d1, x16
               	bl	<addr>
               	fmov	x0, d0
               	mov	x20, #0x4010000000000000 // =4616189618054758400
               	fmov	d0, x0
               	fmov	d1, x20
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x20, #0x7               // =7
               	mov	x0, x20
               	ldr	x20, [sp, #0x10]
               	ldr	x21, [sp, #0x18]
               	ldr	d8, [sp]
               	ldr	d9, [sp, #0x8]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x168
               	mov	x21, x19
               	mov	x0, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp, #0x10]
               	ldr	x21, [sp, #0x18]
               	ldr	d8, [sp]
               	ldr	d9, [sp, #0x8]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
