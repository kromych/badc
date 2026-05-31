
enum_tag_types.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400248 <.text+0x28>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	sxtw	x15, w0
               	add	x14, x15, #0x64
               	sxtw	x0, w14
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	mov	x15, #0x1               // =1
               	sxtw	x14, w15
               	cmp	x14, #0x1
               	b.eq	0x400288 <.text+0x68>
               	mov	x14, #0x1               // =1
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x4002ac <.text+0x8c>
               	mov	x14, #0x2               // =2
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x4002d0 <.text+0xb0>
               	mov	x14, #0x3               // =3
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x4002f4 <.text+0xd4>
               	mov	x14, #0x4               // =4
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x400318 <.text+0xf8>
               	mov	x14, #0x5               // =5
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x1               // =1
               	sxtw	x14, w15
               	cmp	x14, #0x1
               	b.eq	0x400344 <.text+0x124>
               	mov	x14, #0x6               // =6
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x400368 <.text+0x148>
               	mov	x14, #0x7               // =7
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x40038c <.text+0x16c>
               	mov	x14, #0x8               // =8
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
               	cmp	x14, #0x66
               	b.eq	0x4003c0 <.text+0x1a0>
               	mov	x14, #0x9               // =9
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x0               // =0
               	cbz	x20, 0x4003e4 <.text+0x1c4>
               	mov	x14, #0xa               // =10
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x2a              // =42
               	mov	x0, x21
               	bl	0x400238 <.text+0x18>
               	mov	x14, x0
               	cmp	x14, #0x8e
               	b.eq	0x400418 <.text+0x1f8>
               	mov	x14, #0xb               // =11
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x0               // =0
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
