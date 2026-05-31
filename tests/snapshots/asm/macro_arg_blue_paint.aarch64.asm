
macro_arg_blue_paint.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400284 <.text+0x64>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	mov	x15, x0
               	mov	x14, x1
               	str	x14, [x15]
               	mov	x0, #0x0                // =0
               	ret
               	mov	x15, x0
               	ldr	x14, [x15]
               	ldrsw	x0, [x14]
               	ret
               	mov	x15, x0
               	ldr	x14, [x15]
               	ldrsw	x0, [x14]
               	ret
               	mov	x15, x0
               	ldr	x14, [x15]
               	ldrsw	x15, [x14]
               	add	x15, x15, #0x7
               	sxtw	x0, w15
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	sub	x15, x29, #0x8
               	mov	x14, #0x64              // =100
               	str	w14, [x15]
               	sub	x20, x29, #0x10
               	sub	x21, x29, #0x8
               	mov	x0, x20
               	mov	x1, x21
               	bl	0x400238 <.text+0x18>
               	sub	x22, x29, #0x10
               	mov	x0, x22
               	bl	0x40024c <.text+0x2c>
               	cmp	x0, #0x64
               	b.eq	0x4002f0 <.text+0xd0>
               	mov	x22, #0xb               // =11
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x21, x29, #0x10
               	mov	x0, x21
               	bl	0x40025c <.text+0x3c>
               	cmp	x0, #0x64
               	b.eq	0x400324 <.text+0x104>
               	mov	x21, #0xc               // =12
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x22, x29, #0x10
               	mov	x0, x22
               	bl	0x40026c <.text+0x4c>
               	cmp	x0, #0x6b
               	b.eq	0x400358 <.text+0x138>
               	mov	x22, #0xd               // =13
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
