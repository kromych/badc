
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
               	sub	x15, x29, #0x8
               	add	x14, x29, #0x10
               	add	x17, x14, #0x10
               	str	x17, [x15]
               	mov	x13, #0x0               // =0
               	stur	x13, [x29, #-0x10]
               	stur	w13, [x29, #-0x18]
               	b	<addr>
               	ldursw	x13, [x29, #-0x18]
               	ldursw	x14, [x29, #0x10]
               	cmp	x13, x14
               	b.ge	<addr>
               	b	<addr>
               	sub	x14, x29, #0x18
               	ldrsw	x13, [x14]
               	add	x13, x13, #0x1
               	str	w13, [x14]
               	b	<addr>
               	sub	x13, x29, #0x10
               	ldr	x15, [x13]
               	sub	x14, x29, #0x8
               	ldr	x12, [x14]
               	add	x17, x12, #0x10
               	str	x17, [x14]
               	ldr	x14, [x12]
               	add	x15, x15, x14
               	str	x15, [x13]
               	b	<addr>
               	sub	x15, x29, #0x8
               	ldur	x0, [x29, #-0x10]
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x19, [sp]
               	sub	x15, x29, #0x8
               	add	x14, x29, #0x10
               	add	x17, x14, #0x10
               	str	x17, [x15]
               	sub	x13, x29, #0x8
               	ldr	x14, [x13]
               	add	x17, x14, #0x10
               	str	x17, [x13]
               	ldr	x0, [x14]
               	sub	x14, x29, #0x8
               	ldr	x19, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x26, [sp, #0x30]
               	mov	x20, #0x3               // =3
               	mov	x21, #0xa               // =10
               	mov	x22, #0x14              // =20
               	mov	x23, #0x1e              // =30
               	str	x23, [sp, #-0x10]!
               	str	x22, [sp, #-0x10]!
               	str	x21, [sp, #-0x10]!
               	str	x20, [sp, #-0x10]!
               	bl	<addr>
               	add	sp, sp, #0x40
               	cmp	x0, #0x3c
               	b.eq	<addr>
               	mov	x23, #0x1               // =1
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x24, #0x5               // =5
               	mov	x25, #0x1               // =1
               	mov	x23, #0x2               // =2
               	mov	x22, #0x3               // =3
               	mov	x21, #0x4               // =4
               	str	x24, [sp, #-0x10]!
               	str	x21, [sp, #-0x10]!
               	str	x22, [sp, #-0x10]!
               	str	x23, [sp, #-0x10]!
               	str	x25, [sp, #-0x10]!
               	str	x24, [sp, #-0x10]!
               	bl	<addr>
               	add	sp, sp, #0x60
               	cmp	x0, #0xf
               	b.eq	<addr>
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x1               // =1
               	mov	x26, #0x2a              // =42
               	str	x26, [sp, #-0x10]!
               	str	x20, [sp, #-0x10]!
               	bl	<addr>
               	add	sp, sp, #0x20
               	cmp	x0, #0x2a
               	b.eq	<addr>
               	mov	x26, #0x3               // =3
               	mov	x0, x26
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
