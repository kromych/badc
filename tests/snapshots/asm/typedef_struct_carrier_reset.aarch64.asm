
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
               	mov	x1, #0x0                // =0
               	stur	w1, [x29, #-0x10]
               	stur	w1, [x29, #-0x8]
               	b	<addr>
               	ldursw	x1, [x29, #-0x8]
               	cmp	x1, #0xa
               	b.ge	<addr>
               	b	<addr>
               	sub	x1, x29, #0x8
               	ldrsw	x2, [x1]
               	add	x2, x2, #0x1
               	str	w2, [x1]
               	b	<addr>
               	ldursw	x1, [x29, #-0x8]
               	lsl	x2, x1, #2
               	add	x2, x0, x2
               	str	w1, [x2]
               	add	x1, x0, #0x28
               	ldursw	x2, [x29, #-0x8]
               	lsl	x3, x2, #2
               	add	x1, x1, x3
               	add	x2, x2, #0x1
               	sxtw	x2, w2
               	str	w2, [x1]
               	sub	x1, x29, #0x10
               	ldrsw	x2, [x1]
               	ldursw	x3, [x29, #-0x8]
               	lsl	x3, x3, #2
               	add	x4, x0, x3
               	ldrsw	x4, [x4]
               	add	x5, x0, #0x28
               	add	x3, x5, x3
               	ldrsw	x3, [x3]
               	add	x3, x4, x3
               	sxtw	x3, w3
               	add	x2, x2, x3
               	str	w2, [x1]
               	b	<addr>
               	add	x1, x0, #0xa0
               	ldursw	x2, [x29, #-0x10]
               	str	w2, [x1]
               	add	x0, x0, #0xa0
               	ldrsw	x0, [x0]
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
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa8
               	add	x0, x0, #0x14
               	ldrsw	x0, [x0]
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa8
               	add	x0, x0, #0x3c
               	ldrsw	x0, [x0]
               	cmp	x0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa8
               	add	x0, x0, #0xa0
               	ldrsw	x0, [x0]
               	cmp	x0, #0x64
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
