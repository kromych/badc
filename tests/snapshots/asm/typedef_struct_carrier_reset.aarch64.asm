
typedef_struct_carrier_reset.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x15, x0
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x10]
               	stur	w14, [x29, #-0x8]
               	b	<addr>
               	ldursw	x14, [x29, #-0x8]
               	cmp	x14, #0xa
               	b.ge	<addr>
               	b	<addr>
               	sub	x13, x29, #0x8
               	ldrsw	x14, [x13]
               	add	x14, x14, #0x1
               	str	w14, [x13]
               	b	<addr>
               	ldursw	x14, [x29, #-0x8]
               	lsl	x12, x14, #2
               	add	x12, x15, x12
               	str	w14, [x12]
               	add	x13, x15, #0x28
               	ldursw	x12, [x29, #-0x8]
               	lsl	x14, x12, #2
               	add	x13, x13, x14
               	add	x12, x12, #0x1
               	sxtw	x12, w12
               	str	w12, [x13]
               	sub	x14, x29, #0x10
               	ldrsw	x12, [x14]
               	ldursw	x13, [x29, #-0x8]
               	lsl	x13, x13, #2
               	add	x11, x15, x13
               	ldrsw	x11, [x11]
               	add	x10, x15, #0x28
               	add	x10, x10, x13
               	ldrsw	x10, [x10]
               	add	x11, x11, x10
               	sxtw	x11, w11
               	add	x12, x12, x11
               	str	w12, [x14]
               	b	<addr>
               	add	x11, x15, #0xa0
               	ldursw	x14, [x29, #-0x10]
               	str	w14, [x11]
               	add	x15, x15, #0xa0
               	ldrsw	x0, [x15]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xc0
               	sub	x0, x29, #0xa8
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x64
               	b.eq	<addr>
               	mov	x14, #0x1               // =1
               	mov	x0, x14
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa8
               	add	x0, x0, #0x14
               	ldrsw	x0, [x0]
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x14, #0x2               // =2
               	mov	x0, x14
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa8
               	add	x0, x0, #0x3c
               	ldrsw	x0, [x0]
               	cmp	x0, #0x6
               	b.eq	<addr>
               	mov	x14, #0x3               // =3
               	mov	x0, x14
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa8
               	add	x0, x0, #0xa0
               	ldrsw	x0, [x0]
               	cmp	x0, #0x64
               	b.eq	<addr>
               	mov	x14, #0x4               // =4
               	mov	x0, x14
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
