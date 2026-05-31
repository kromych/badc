
function_type_typedef.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400330 <.text+0x110>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	sxtw	x15, w0
               	sxtw	x14, w1
               	add	x13, x15, x14
               	sxtw	x0, w13
               	ret
               	sxtw	x15, w0
               	sxtw	x14, w1
               	sub	x13, x15, x14
               	sxtw	x0, w13
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	mov	x20, x0
               	sxtw	x21, w1
               	sxtw	x22, w2
               	mov	x9, x20
               	str	x22, [sp, #-0x10]!
               	str	x21, [sp, #-0x10]!
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x10]
               	blr	x9
               	add	sp, sp, #0x20
               	mov	x12, x0
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	mov	x20, x0
               	sxtw	x21, w1
               	sxtw	x22, w2
               	mov	x9, x20
               	str	x22, [sp, #-0x10]!
               	str	x21, [sp, #-0x10]!
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x10]
               	blr	x9
               	add	sp, sp, #0x20
               	mov	x12, x0
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
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
               	str	x19, [sp, #0x30]
               	adrp	x19, 0x400000
               	add	x19, x19, #0x238
               	mov	x20, x19
               	mov	x21, #0x3               // =3
               	mov	x22, #0x4               // =4
               	mov	x0, x20
               	mov	x2, x22
               	mov	x1, x21
               	bl	0x400260 <.text+0x40>
               	mov	x12, x0
               	cmp	x12, #0x7
               	b.eq	0x4003b0 <.text+0x190>
               	mov	x12, #0x1               // =1
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x400000
               	add	x19, x19, #0x24c
               	mov	x23, x19
               	mov	x22, #0xa               // =10
               	mov	x24, #0x4               // =4
               	mov	x0, x23
               	mov	x2, x24
               	mov	x1, x22
               	bl	0x400260 <.text+0x40>
               	mov	x20, x0
               	cmp	x20, #0x6
               	b.eq	0x40040c <.text+0x1ec>
               	mov	x20, #0x2               // =2
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x400000
               	add	x19, x19, #0x238
               	mov	x21, x19
               	mov	x24, #0x5               // =5
               	mov	x20, #0x6               // =6
               	mov	x0, x21
               	mov	x2, x20
               	mov	x1, x24
               	bl	0x4002c8 <.text+0xa8>
               	mov	x23, x0
               	cmp	x23, #0xb
               	b.eq	0x400468 <.text+0x248>
               	mov	x23, #0x3               // =3
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x400000
               	add	x19, x19, #0x24c
               	mov	x22, x19
               	mov	x20, #0x14              // =20
               	mov	x23, #0x8               // =8
               	mov	x0, x22
               	mov	x2, x23
               	mov	x1, x20
               	bl	0x4002c8 <.text+0xa8>
               	mov	x21, x0
               	cmp	x21, #0xc
               	b.eq	0x4004c4 <.text+0x2a4>
               	mov	x21, #0x4               // =4
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x23, #0x0               // =0
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
