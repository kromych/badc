
typedef_fn_ptr_struct_field.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x40024c <.text+0x2c>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	sxtw	x15, w0
               	sxtw	x14, w1
               	mul	x13, x15, x14
               	sxtw	x0, w13
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xc0
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x19, [sp, #0x30]
               	sub	x15, x29, #0x10
               	adrp	x19, 0x400000
               	add	x19, x19, #0x238
               	mov	x14, x19
               	str	x14, [x15]
               	sub	x13, x29, #0x10
               	add	x14, x13, #0x8
               	mov	x13, #0x0               // =0
               	str	w13, [x14]
               	sub	x20, x29, #0x10
               	ldr	x21, [x20]
               	mov	x22, #0x3               // =3
               	mov	x23, #0x7               // =7
               	mov	x9, x21
               	str	x23, [sp, #-0x10]!
               	str	x22, [sp, #-0x10]!
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x10]
               	blr	x9
               	add	sp, sp, #0x20
               	cmp	x0, #0x15
               	b.eq	0x4002f8 <.text+0xd8>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x24, [x20]
               	mov	x23, #0x4               // =4
               	mov	x20, #0x5               // =5
               	mov	x9, x24
               	str	x20, [sp, #-0x10]!
               	str	x23, [sp, #-0x10]!
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x10]
               	blr	x9
               	add	sp, sp, #0x20
               	cmp	x0, #0x14
               	b.eq	0x400354 <.text+0x134>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x20, x29, #0x10
               	ldr	x22, [x20]
               	mov	x25, #0x2               // =2
               	mov	x20, #0x9               // =9
               	mov	x9, x22
               	str	x20, [sp, #-0x10]!
               	str	x25, [sp, #-0x10]!
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x10]
               	blr	x9
               	add	sp, sp, #0x20
               	cmp	x0, #0x12
               	b.eq	0x4003b4 <.text+0x194>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x20, x29, #0x10
               	ldr	x24, [x20]
               	mov	x23, #0x6               // =6
               	mov	x20, #0x4               // =4
               	mov	x9, x24
               	str	x20, [sp, #-0x10]!
               	str	x23, [sp, #-0x10]!
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x10]
               	blr	x9
               	add	sp, sp, #0x20
               	cmp	x0, #0x18
               	b.eq	0x400414 <.text+0x1f4>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x0               // =0
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
