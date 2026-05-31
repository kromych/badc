
double_pointers.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400288 <.text+0x18>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xd8]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	mov	x15, #0xa               // =10
               	stur	w15, [x29, #-0x8]
               	sub	x14, x29, #0x8
               	stur	x14, [x29, #-0x10]
               	sub	x15, x29, #0x10
               	ldr	x14, [x15]
               	mov	x15, #0x2a              // =42
               	str	w15, [x14]
               	ldursw	x13, [x29, #-0x8]
               	cmp	x13, #0x2a
               	b.eq	0x4002f4 <.text+0x84>
               	mov	x15, #0x1               // =1
               	mov	x0, x15
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x13, [x29, #-0x10]
               	ldrsw	x15, [x13]
               	cmp	x15, #0x2a
               	b.eq	0x400328 <.text+0xb8>
               	mov	x13, #0x2               // =2
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x8               // =8
               	mov	x0, x20
               	bl	0x400518 <malloc>
               	mov	x21, x0
               	mov	x22, #0x4               // =4
               	mov	x0, x22
               	bl	0x400518 <malloc>
               	str	x0, [x21]
               	ldr	x22, [x21]
               	mov	x0, #0x7b               // =123
               	str	w0, [x22]
               	ldr	x12, [x21]
               	ldrsw	x0, [x12]
               	cmp	x0, #0x7b
               	b.eq	0x400388 <.text+0x118>
               	mov	x12, #0x3               // =3
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [x21]
               	ldrsw	x21, [x0]
               	cmp	x21, #0x7b
               	b.eq	0x4003b8 <.text+0x148>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x0               // =0
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
