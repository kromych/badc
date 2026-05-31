
mem2reg_param_promoted.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x4002cc <.text+0xac>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	sxtw	x20, w0
               	cmp	x20, #0x2
               	b.ge	0x400280 <.text+0x60>
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x20, #0x1
               	sxtw	x21, w13
               	mov	x0, x21
               	bl	0x400238 <.text+0x18>
               	mov	x22, x0
               	sub	x21, x20, #0x2
               	sxtw	x23, w21
               	mov	x0, x23
               	bl	0x400238 <.text+0x18>
               	mov	x20, x0
               	add	x23, x22, x20
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	mov	x20, #0x0               // =0
               	mov	x0, x20
               	bl	0x400238 <.text+0x18>
               	mov	x14, x0
               	cmp	x14, #0x0
               	b.eq	0x400314 <.text+0xf4>
               	mov	x14, #0x1               // =1
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x1               // =1
               	mov	x0, x21
               	bl	0x400238 <.text+0x18>
               	mov	x14, x0
               	cmp	x14, #0x1
               	b.eq	0x400348 <.text+0x128>
               	mov	x14, #0x2               // =2
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x2               // =2
               	mov	x0, x20
               	bl	0x400238 <.text+0x18>
               	mov	x14, x0
               	cmp	x14, #0x1
               	b.eq	0x40037c <.text+0x15c>
               	mov	x14, #0x3               // =3
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0xa               // =10
               	mov	x0, x21
               	bl	0x400238 <.text+0x18>
               	mov	x14, x0
               	cmp	x14, #0x37
               	b.eq	0x4003b0 <.text+0x190>
               	mov	x14, #0x4               // =4
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x14              // =20
               	mov	x0, x20
               	bl	0x400238 <.text+0x18>
               	mov	x14, x0
               	mov	x17, #0x1a6d            // =6765
               	cmp	x14, x17
               	b.eq	0x4003e8 <.text+0x1c8>
               	mov	x14, #0x5               // =5
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x0               // =0
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
