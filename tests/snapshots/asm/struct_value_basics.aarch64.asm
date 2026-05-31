
struct_value_basics.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400238 <.text+0x18>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x15, x29, #0x8
               	mov	x14, #0x3               // =3
               	str	w14, [x15]
               	sub	x13, x29, #0x8
               	add	x13, x13, #0x4
               	mov	x14, #0x4               // =4
               	str	w14, [x13]
               	sub	x15, x29, #0x8
               	ldrsw	x14, [x15]
               	cmp	x14, #0x3
               	b.eq	0x400280 <.text+0x60>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x8
               	add	x14, x14, #0x4
               	ldrsw	x0, [x14]
               	cmp	x0, #0x4
               	b.eq	0x4002a8 <.text+0x88>
               	mov	x14, #0x2               // =2
               	mov	x0, x14
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	ldrsw	x14, [x0]
               	cmp	x14, #0x3
               	b.eq	0x4002cc <.text+0xac>
               	mov	x13, #0x3               // =3
               	mov	x0, x13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x14, x0, #0x4
               	ldrsw	x13, [x14]
               	cmp	x13, #0x4
               	b.eq	0x4002f0 <.text+0xd0>
               	mov	x14, #0x4               // =4
               	mov	x0, x14
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x13, #0x1e              // =30
               	str	w13, [x0]
               	add	x0, x0, #0x4
               	mov	x14, #0x28              // =40
               	str	w14, [x0]
               	sub	x13, x29, #0x8
               	ldrsw	x14, [x13]
               	cmp	x14, #0x1e
               	b.eq	0x400324 <.text+0x104>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x8
               	add	x14, x14, #0x4
               	ldrsw	x0, [x14]
               	cmp	x0, #0x28
               	b.eq	0x40034c <.text+0x12c>
               	mov	x14, #0x6               // =6
               	mov	x0, x14
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	mov	x14, #0x64              // =100
               	str	w14, [x0]
               	sub	x13, x29, #0x10
               	add	x13, x13, #0x4
               	mov	x14, #0xc8              // =200
               	str	w14, [x13]
               	sub	x0, x29, #0x8
               	ldrsw	x14, [x0]
               	cmp	x14, #0x1e
               	b.eq	0x400388 <.text+0x168>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x10
               	ldrsw	x0, [x14]
               	cmp	x0, #0x64
               	b.eq	0x4003ac <.text+0x18c>
               	mov	x14, #0x8               // =8
               	mov	x0, x14
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	ldrsw	x14, [x0]
               	sub	x0, x29, #0x8
               	add	x0, x0, #0x4
               	ldrsw	x13, [x0]
               	add	x14, x14, x13
               	sxtw	x14, w14
               	sub	x13, x29, #0x10
               	ldrsw	x0, [x13]
               	add	x14, x14, x0
               	sxtw	x14, w14
               	sub	x0, x29, #0x10
               	add	x0, x0, #0x4
               	ldrsw	x13, [x0]
               	add	x14, x14, x13
               	sxtw	x14, w14
               	sxtw	x14, w14
               	cmp	x14, #0x172
               	b.eq	0x400408 <.text+0x1e8>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x0               // =0
               	mov	x0, x14
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
