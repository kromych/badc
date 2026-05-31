
local_struct_array_brace_init.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x4002b8 <.text+0x98>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x15, x0
               	sxtw	x14, w1
               	mov	x13, #0x0               // =0
               	stur	x13, [x29, #-0x8]
               	stur	w13, [x29, #-0x10]
               	b	0x40025c <.text+0x3c>
               	ldursw	x13, [x29, #-0x10]
               	cmp	x13, x14
               	b.ge	0x4002a8 <.text+0x88>
               	b	0x400280 <.text+0x60>
               	sub	x13, x29, #0x10
               	ldrsw	x12, [x13]
               	add	x11, x12, #0x1
               	str	w11, [x13]
               	b	0x40025c <.text+0x3c>
               	sub	x11, x29, #0x8
               	ldr	x12, [x11]
               	ldursw	x13, [x29, #-0x10]
               	lsl	x10, x13, #4
               	add	x13, x15, x10
               	add	x10, x13, #0x8
               	ldr	x13, [x10]
               	add	x10, x12, x13
               	str	x10, [x11]
               	b	0x40026c <.text+0x4c>
               	ldur	x0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xe0
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	sub	x15, x29, #0x30
               	adrp	x19, 0x410000
               	add	x19, x19, #0xdc
               	mov	x14, x19
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x14]
               	str	x10, [x15]
               	ldr	x10, [x14, #0x8]
               	str	x10, [x15, #0x8]
               	ldr	x10, [x14, #0x10]
               	str	x10, [x15, #0x10]
               	ldr	x10, [x14, #0x18]
               	str	x10, [x15, #0x18]
               	ldr	x10, [x14, #0x20]
               	str	x10, [x15, #0x20]
               	ldr	x10, [x14, #0x28]
               	str	x10, [x15, #0x28]
               	ldr	x10, [sp], #0x10
               	mov	x13, x15
               	sub	x20, x29, #0x30
               	mov	x21, #0x3               // =3
               	mov	x0, x20
               	mov	x1, x21
               	bl	0x400238 <.text+0x18>
               	mov	x15, x0
               	cmp	x15, #0xc
               	b.eq	0x400364 <.text+0x144>
               	mov	x15, #0x1               // =1
               	mov	x0, x15
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x21, x29, #0x30
               	add	x15, x21, #0x8
               	ldr	x21, [x15]
               	cmp	x21, #0x3
               	b.eq	0x40039c <.text+0x17c>
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x30
               	add	x21, x15, #0x28
               	ldr	x15, [x21]
               	cmp	x15, #0x5
               	b.eq	0x4003d4 <.text+0x1b4>
               	mov	x15, #0x3               // =3
               	mov	x0, x15
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x21, x29, #0x98
               	adrp	x19, 0x410000
               	add	x19, x19, #0x11b
               	mov	x15, x19
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x15]
               	str	x10, [x21]
               	ldr	x10, [x15, #0x8]
               	str	x10, [x21, #0x8]
               	ldr	x10, [x15, #0x10]
               	str	x10, [x21, #0x10]
               	ldr	x10, [x15, #0x18]
               	str	x10, [x21, #0x18]
               	ldr	x10, [x15, #0x20]
               	str	x10, [x21, #0x20]
               	ldr	x10, [x15, #0x28]
               	str	x10, [x21, #0x28]
               	ldr	x10, [sp], #0x10
               	mov	x20, x21
               	sub	x20, x29, #0x40
               	sub	x15, x29, #0x98
               	str	x20, [x15]
               	mov	x21, #0x10              // =16
               	sub	x15, x29, #0x98
               	add	x20, x15, #0x8
               	str	x21, [x20]
               	sub	x15, x29, #0x60
               	sub	x20, x29, #0x98
               	add	x21, x20, #0x10
               	str	x15, [x21]
               	mov	x20, #0x20              // =32
               	sub	x21, x29, #0x98
               	add	x15, x21, #0x18
               	str	x20, [x15]
               	sub	x21, x29, #0x68
               	sub	x15, x29, #0x98
               	add	x20, x15, #0x20
               	str	x21, [x20]
               	mov	x15, #0x8               // =8
               	sub	x20, x29, #0x98
               	add	x21, x20, #0x28
               	str	x15, [x21]
               	sub	x22, x29, #0x98
               	mov	x20, #0x3               // =3
               	mov	x0, x22
               	mov	x1, x20
               	bl	0x400238 <.text+0x18>
               	mov	x15, x0
               	mov	x20, #0x30              // =48
               	sxtw	x20, w20
               	add	x22, x20, #0x8
               	sxtw	x22, w22
               	cmp	x15, x22
               	b.eq	0x4004d0 <.text+0x2b0>
               	mov	x22, #0x4               // =4
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x20, x29, #0x98
               	ldr	x22, [x20]
               	sub	x20, x29, #0x40
               	cmp	x22, x20
               	b.eq	0x400508 <.text+0x2e8>
               	mov	x20, #0x5               // =5
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x98
               	add	x20, x15, #0x10
               	ldr	x15, [x20]
               	sub	x20, x29, #0x60
               	cmp	x15, x20
               	b.eq	0x400544 <.text+0x324>
               	mov	x20, #0x6               // =6
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x22, x29, #0x98
               	add	x20, x22, #0x20
               	ldr	x22, [x20]
               	sub	x20, x29, #0x68
               	cmp	x22, x20
               	b.eq	0x400580 <.text+0x360>
               	mov	x20, #0x7               // =7
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x98
               	add	x20, x15, #0x28
               	ldr	x15, [x20]
               	cmp	x15, #0x8
               	b.eq	0x4005b8 <.text+0x398>
               	mov	x15, #0x8               // =8
               	mov	x0, x15
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x0               // =0
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
