
typedef_array_param_decay.aarch64:	file format elf64-littleaarch64

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
               	mov	x13, #0x0               // =0
               	stur	w13, [x29, #-0x8]
               	b	<addr>
               	ldursw	x13, [x29, #-0x8]
               	cmp	x13, #0x10
               	b.ge	<addr>
               	b	<addr>
               	sub	x12, x29, #0x8
               	ldrsw	x13, [x12]
               	add	x13, x13, #0x1
               	str	w13, [x12]
               	b	<addr>
               	ldursw	x13, [x29, #-0x8]
               	lsl	x13, x13, #3
               	add	x11, x0, x13
               	add	x13, x1, x13
               	ldr	x13, [x13]
               	str	x13, [x11]
               	b	<addr>
               	mov	x13, #0x0               // =0
               	mov	x0, x13
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x14, #0x0               // =0
               	stur	x14, [x29, #-0x10]
               	stur	w14, [x29, #-0x8]
               	b	<addr>
               	ldursw	x14, [x29, #-0x8]
               	cmp	x14, #0x10
               	b.ge	<addr>
               	b	<addr>
               	sub	x13, x29, #0x8
               	ldrsw	x14, [x13]
               	add	x14, x14, #0x1
               	str	w14, [x13]
               	b	<addr>
               	sub	x14, x29, #0x10
               	ldr	x12, [x14]
               	ldursw	x13, [x29, #-0x8]
               	lsl	x13, x13, #3
               	add	x13, x0, x13
               	ldr	x13, [x13]
               	add	x12, x12, x13
               	str	x12, [x14]
               	b	<addr>
               	ldur	x12, [x29, #-0x10]
               	mov	x0, x12
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x120
               	mov	x15, #0x0               // =0
               	sub	x17, x29, #0x108
               	str	w15, [x17]
               	b	<addr>
               	sub	x16, x29, #0x108
               	ldrsw	x15, [x16]
               	cmp	x15, #0x10
               	b.ge	<addr>
               	b	<addr>
               	sub	x14, x29, #0x108
               	ldrsw	x15, [x14]
               	add	x15, x15, #0x1
               	str	w15, [x14]
               	b	<addr>
               	sub	x15, x29, #0x80
               	sub	x16, x29, #0x108
               	ldrsw	x13, [x16]
               	lsl	x14, x13, #3
               	add	x15, x15, x14
               	add	x13, x13, #0x1
               	str	x13, [x15]
               	b	<addr>
               	sub	x0, x29, #0x100
               	sub	x1, x29, #0x80
               	bl	<addr>
               	mov	x15, x0
               	sub	x0, x29, #0x100
               	bl	<addr>
               	mov	x1, x0
               	mov	x0, #0x110              // =272
               	mov	x15, #0x2               // =2
               	sdiv	x0, x0, x15
               	cmp	x1, x0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x100
               	ldr	x1, [x1]
               	cmp	x1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x100
               	add	x1, x1, #0x78
               	ldr	x1, [x1]
               	cmp	x1, #0x10
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
