
switch_multilabel.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x4002c4 <.text+0xa4>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	sxtw	x15, w0
               	b	0x400270 <.text+0x50>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x1                // =1
               	ret
               	mov	x13, #0x2               // =2
               	mov	x0, x13
               	ret
               	mov	x0, #0x3                // =3
               	ret
               	mov	x13, #0x0               // =0
               	mov	x0, x13
               	ret
               	cmp	x15, #0x61
               	b.eq	0x400248 <.text+0x28>
               	cmp	x15, #0x62
               	b.eq	0x400248 <.text+0x28>
               	cmp	x15, #0x63
               	b.eq	0x400248 <.text+0x28>
               	cmp	x15, #0x64
               	b.eq	0x400248 <.text+0x28>
               	cmp	x15, #0x41
               	b.eq	0x400250 <.text+0x30>
               	cmp	x15, #0x42
               	b.eq	0x400250 <.text+0x30>
               	cmp	x15, #0x30
               	b.eq	0x40025c <.text+0x3c>
               	cmp	x15, #0x31
               	b.eq	0x40025c <.text+0x3c>
               	cmp	x15, #0x32
               	b.eq	0x40025c <.text+0x3c>
               	cmp	x15, #0x33
               	b.eq	0x40025c <.text+0x3c>
               	b	0x400264 <.text+0x44>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	mov	x20, #0x61              // =97
               	mov	x0, x20
               	bl	0x400238 <.text+0x18>
               	mov	x14, x0
               	cmp	x14, #0x1
               	b.eq	0x40030c <.text+0xec>
               	mov	x14, #0x1               // =1
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x62              // =98
               	mov	x0, x21
               	bl	0x400238 <.text+0x18>
               	mov	x14, x0
               	cmp	x14, #0x1
               	b.eq	0x400340 <.text+0x120>
               	mov	x14, #0x2               // =2
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x63              // =99
               	mov	x0, x20
               	bl	0x400238 <.text+0x18>
               	mov	x14, x0
               	cmp	x14, #0x1
               	b.eq	0x400374 <.text+0x154>
               	mov	x14, #0x3               // =3
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x64              // =100
               	mov	x0, x21
               	bl	0x400238 <.text+0x18>
               	mov	x14, x0
               	cmp	x14, #0x1
               	b.eq	0x4003a8 <.text+0x188>
               	mov	x14, #0x4               // =4
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x41              // =65
               	mov	x0, x20
               	bl	0x400238 <.text+0x18>
               	mov	x14, x0
               	cmp	x14, #0x2
               	b.eq	0x4003dc <.text+0x1bc>
               	mov	x14, #0x5               // =5
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x42              // =66
               	mov	x0, x21
               	bl	0x400238 <.text+0x18>
               	mov	x14, x0
               	cmp	x14, #0x2
               	b.eq	0x400410 <.text+0x1f0>
               	mov	x14, #0x6               // =6
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x30              // =48
               	mov	x0, x20
               	bl	0x400238 <.text+0x18>
               	mov	x14, x0
               	cmp	x14, #0x3
               	b.eq	0x400444 <.text+0x224>
               	mov	x14, #0x7               // =7
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x33              // =51
               	mov	x0, x21
               	bl	0x400238 <.text+0x18>
               	mov	x14, x0
               	cmp	x14, #0x3
               	b.eq	0x400478 <.text+0x258>
               	mov	x14, #0x8               // =8
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x3f              // =63
               	mov	x0, x20
               	bl	0x400238 <.text+0x18>
               	mov	x14, x0
               	cmp	x14, #0x0
               	b.eq	0x4004ac <.text+0x28c>
               	mov	x14, #0x9               // =9
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
