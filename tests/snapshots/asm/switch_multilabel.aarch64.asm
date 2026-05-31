
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
               	mov	x15, #0x2               // =2
               	mov	x0, x15
               	ret
               	mov	x0, #0x3                // =3
               	ret
               	mov	x15, #0x0               // =0
               	mov	x0, x15
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
               	cmp	x0, #0x1
               	b.eq	0x400308 <.text+0xe8>
               	mov	x20, #0x1               // =1
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x62              // =98
               	mov	x0, x21
               	bl	0x400238 <.text+0x18>
               	cmp	x0, #0x1
               	b.eq	0x400338 <.text+0x118>
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x63              // =99
               	mov	x0, x20
               	bl	0x400238 <.text+0x18>
               	cmp	x0, #0x1
               	b.eq	0x400368 <.text+0x148>
               	mov	x20, #0x3               // =3
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x64              // =100
               	mov	x0, x21
               	bl	0x400238 <.text+0x18>
               	cmp	x0, #0x1
               	b.eq	0x400398 <.text+0x178>
               	mov	x21, #0x4               // =4
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x41              // =65
               	mov	x0, x20
               	bl	0x400238 <.text+0x18>
               	cmp	x0, #0x2
               	b.eq	0x4003c8 <.text+0x1a8>
               	mov	x20, #0x5               // =5
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x42              // =66
               	mov	x0, x21
               	bl	0x400238 <.text+0x18>
               	cmp	x0, #0x2
               	b.eq	0x4003f8 <.text+0x1d8>
               	mov	x21, #0x6               // =6
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x30              // =48
               	mov	x0, x20
               	bl	0x400238 <.text+0x18>
               	cmp	x0, #0x3
               	b.eq	0x400428 <.text+0x208>
               	mov	x20, #0x7               // =7
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x33              // =51
               	mov	x0, x21
               	bl	0x400238 <.text+0x18>
               	cmp	x0, #0x3
               	b.eq	0x400458 <.text+0x238>
               	mov	x21, #0x8               // =8
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x3f              // =63
               	mov	x0, x20
               	bl	0x400238 <.text+0x18>
               	cmp	x0, #0x0
               	b.eq	0x400488 <.text+0x268>
               	mov	x20, #0x9               // =9
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
