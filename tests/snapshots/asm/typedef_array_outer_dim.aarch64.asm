
typedef_array_outer_dim.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x20
               	mov	x1, #0x0                // =0
               	stur	x1, [x29, #-0x18]
               	stur	w1, [x29, #-0x8]
               	b	<addr>
               	ldursw	x1, [x29, #-0x8]
               	cmp	x1, #0x4
               	b.ge	<addr>
               	b	<addr>
               	sub	x1, x29, #0x8
               	ldrsw	x2, [x1]
               	add	x2, x2, #0x1
               	str	w2, [x1]
               	b	<addr>
               	mov	x1, #0x0                // =0
               	stur	w1, [x29, #-0x10]
               	b	<addr>
               	ldur	x0, [x29, #-0x18]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x1, [x29, #-0x10]
               	cmp	x1, #0x10
               	b.ge	<addr>
               	b	<addr>
               	sub	x1, x29, #0x10
               	ldrsw	x2, [x1]
               	add	x2, x2, #0x1
               	str	w2, [x1]
               	b	<addr>
               	ldursw	x1, [x29, #-0x8]
               	lsl	x2, x1, #7
               	add	x2, x0, x2
               	ldursw	x3, [x29, #-0x10]
               	lsl	x4, x3, #3
               	add	x2, x2, x4
               	lsl	x1, x1, #4
               	sxtw	x1, w1
               	add	x1, x1, x3
               	sxtw	x1, w1
               	str	x1, [x2]
               	sub	x1, x29, #0x18
               	ldr	x2, [x1]
               	ldursw	x3, [x29, #-0x8]
               	lsl	x3, x3, #7
               	add	x3, x0, x3
               	ldursw	x4, [x29, #-0x10]
               	lsl	x4, x4, #3
               	add	x3, x3, x4
               	ldr	x3, [x3]
               	add	x2, x2, x3
               	str	x2, [x1]
               	b	<addr>
               	b	<addr>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x220
               	b	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	sub	x17, x29, #0x208
               	str	x0, [x17]
               	sub	x17, x29, #0x210
               	str	w0, [x17]
               	b	<addr>
               	sub	x16, x29, #0x210
               	ldrsw	x0, [x16]
               	cmp	x0, #0x40
               	b.ge	<addr>
               	b	<addr>
               	sub	x0, x29, #0x210
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	b	<addr>
               	sub	x0, x29, #0x208
               	ldr	x1, [x0]
               	sub	x16, x29, #0x210
               	ldrsw	x2, [x16]
               	add	x1, x1, x2
               	str	x1, [x0]
               	b	<addr>
               	sub	x0, x29, #0x200
               	bl	<addr>
               	sub	x16, x29, #0x208
               	ldr	x1, [x16]
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x200
               	ldr	x0, [x0]
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x200
               	add	x0, x0, #0x1f8
               	ldr	x0, [x0]
               	cmp	x0, #0x3f
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x200
               	add	x0, x0, #0xb8
               	ldr	x0, [x0]
               	cmp	x0, #0x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
