
ssa_va_arg_loop.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x30
               	str	x19, [sp]
               	sub	x0, x29, #0x8
               	add	x1, x29, #0x10
               	add	x17, x1, #0x10
               	str	x17, [x0]
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x10]
               	stur	w0, [x29, #-0x18]
               	b	<addr>
               	ldursw	x0, [x29, #-0x18]
               	ldursw	x1, [x29, #0x10]
               	cmp	x0, x1
               	b.ge	<addr>
               	b	<addr>
               	sub	x0, x29, #0x18
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	b	<addr>
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	sub	x2, x29, #0x8
               	ldr	x17, [x2]
               	add	x16, x17, #0x10
               	str	x16, [x2]
               	mov	x2, x17
               	ldr	x2, [x2]
               	add	x1, x1, x2
               	str	x1, [x0]
               	b	<addr>
               	sub	x0, x29, #0x8
               	ldur	x0, [x29, #-0x10]
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x19, [sp]
               	sub	x0, x29, #0x8
               	add	x1, x29, #0x10
               	add	x17, x1, #0x10
               	str	x17, [x0]
               	sub	x0, x29, #0x8
               	ldr	x17, [x0]
               	add	x16, x17, #0x10
               	str	x16, [x0]
               	mov	x0, x17
               	ldr	x0, [x0]
               	sub	x1, x29, #0x8
               	ldr	x19, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x3                // =3
               	mov	x1, #0xa                // =10
               	mov	x2, #0x14               // =20
               	mov	x3, #0x1e               // =30
               	str	x3, [sp, #-0x10]!
               	str	x2, [sp, #-0x10]!
               	str	x1, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	bl	<addr>
               	add	sp, sp, #0x40
               	cmp	x0, #0x3c
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	mov	x1, #0x1                // =1
               	mov	x2, #0x2                // =2
               	mov	x3, #0x3                // =3
               	mov	x4, #0x4                // =4
               	str	x0, [sp, #-0x10]!
               	str	x4, [sp, #-0x10]!
               	str	x3, [sp, #-0x10]!
               	str	x2, [sp, #-0x10]!
               	str	x1, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	bl	<addr>
               	add	sp, sp, #0x60
               	cmp	x0, #0xf
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	mov	x1, #0x2a               // =42
               	str	x1, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	bl	<addr>
               	add	sp, sp, #0x20
               	cmp	x0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
