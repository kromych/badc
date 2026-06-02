
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
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	adrp	x21, <page>
               	add	x21, x21, #0x118
               	lsl	x13, x20, #3
               	add	x13, x21, x13
               	ldr	x13, [x13]
               	cbz	x13, <addr>
               	lsl	x12, x20, #3
               	add	x12, x21, x12
               	ldr	x12, [x12]
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x18
               	mov	x0, #0x0                // =0
               	adrp	x11, <page>
               	add	x11, x11, #0x130
               	str	x11, [x13]
               	sub	x10, x29, #0x18
               	add	x10, x10, #0x8
               	adrp	x11, <page>
               	add	x11, x11, #0x136
               	str	x11, [x10]
               	sub	x13, x29, #0x18
               	add	x13, x13, #0x10
               	adrp	x11, <page>
               	add	x11, x11, #0x13d
               	str	x11, [x13]
               	sub	x10, x29, #0x18
               	lsl	x11, x20, #3
               	add	x10, x10, x11
               	ldr	x1, [x10]
               	bl	<addr>
               	mov	x10, x0
               	cbz	x10, <addr>
               	lsl	x1, x20, #3
               	add	x1, x21, x1
               	ldr	x10, [x10]
               	str	x10, [x1]
               	b	<addr>
               	lsl	x20, x20, #3
               	add	x21, x21, x20
               	ldr	x21, [x21]
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	mov	x20, #0x4000000000000000 // =4611686018427387904
               	mov	x14, #0x1               // =1
               	scvtf	d7, x14
               	fmov	d0, x20
               	fmov	x16, d7
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
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	mov	x20, #0x2               // =2
               	scvtf	d7, x20
               	fmov	d0, x0
               	fmov	x16, d7
               	fmov	d1, x16
               	bl	<addr>
               	fmov	x0, d0
               	mov	x20, x0
               	mov	x0, #0x4010000000000000 // =4616189618054758400
               	fmov	d0, x20
               	fmov	d1, x0
               	fcmp	d0, d1
               	cset	x20, ne
               	cbz	x20, <addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x4000000000000000 // =4611686018427387904
               	mov	x0, #0x3                // =3
               	scvtf	d7, x0
               	fmov	d0, x20
               	fmov	x16, d7
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
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	mov	x20, #0x4               // =4
               	scvtf	d7, x20
               	fmov	d0, x0
               	fmov	x16, d7
               	fmov	d1, x16
               	bl	<addr>
               	fmov	x0, d0
               	mov	x20, x0
               	mov	x0, #0x4030000000000000 // =4625196817309499392
               	fmov	d0, x20
               	fmov	d1, x0
               	fcmp	d0, d1
               	cset	x20, ne
               	cbz	x20, <addr>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x2               // =2
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	scvtf	d7, x20
               	fmov	d0, x0
               	fmov	x16, d7
               	fmov	d1, x16
               	bl	<addr>
               	fmov	x0, d0
               	mov	x20, x0
               	mov	x0, #0x4010000000000000 // =4616189618054758400
               	fmov	d0, x20
               	fmov	d1, x0
               	fcmp	d0, d1
               	cset	x20, ne
               	cbz	x20, <addr>
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x3               // =3
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	scvtf	d7, x20
               	fmov	d0, x0
               	fmov	x16, d7
               	fmov	d1, x16
               	bl	<addr>
               	fmov	x0, d0
               	mov	x20, x0
               	mov	x0, #0x4020000000000000 // =4620693217682128896
               	fmov	d0, x20
               	fmov	d1, x0
               	fcmp	d0, d1
               	cset	x20, ne
               	cbz	x20, <addr>
               	mov	x0, #0x6                // =6
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x4000000000000000 // =4611686018427387904
               	mov	x0, #0x2                // =2
               	scvtf	d7, x0
               	fmov	d0, x20
               	fmov	x16, d7
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
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x168
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, x0
               	mov	x20, #0x0               // =0
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
