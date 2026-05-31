
switch_goto_label_into_case.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x4002f8 <.text+0xd8>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sxtw	x15, w0
               	b	0x4002a4 <.text+0x84>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x13, #0x14              // =20
               	mov	x0, x13
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1e               // =30
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	x15, #0x5
               	cset	x13, ge
               	stur	x13, [x29, #-0x8]
               	cbz	x13, 0x4002d8 <.text+0xb8>
               	b	0x4002c8 <.text+0xa8>
               	cmp	x15, #0x1
               	b.eq	0x40025c <.text+0x3c>
               	cmp	x15, #0x2
               	b.eq	0x40026c <.text+0x4c>
               	cmp	x15, #0x3
               	b.eq	0x400280 <.text+0x60>
               	cmp	x15, #0x4
               	b.eq	0x400280 <.text+0x60>
               	b	0x400290 <.text+0x70>
               	cmp	x15, #0x8
               	cset	x0, le
               	stur	x0, [x29, #-0x8]
               	b	0x4002d8 <.text+0xb8>
               	ldur	x0, [x29, #-0x8]
               	cbz	x0, 0x4002e4 <.text+0xc4>
               	b	0x400280 <.text+0x60>
               	mov	x15, #0x0               // =0
               	mov	x0, x15
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	mov	x20, #0x1               // =1
               	mov	x0, x20
               	bl	0x400238 <.text+0x18>
               	cmp	x0, #0xa
               	b.eq	0x400338 <.text+0x118>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	0x400238 <.text+0x18>
               	cmp	x0, #0x14
               	b.eq	0x400364 <.text+0x144>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x3               // =3
               	mov	x0, x20
               	bl	0x400238 <.text+0x18>
               	cmp	x0, #0x1e
               	b.eq	0x400390 <.text+0x170>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x4               // =4
               	mov	x0, x21
               	bl	0x400238 <.text+0x18>
               	cmp	x0, #0x1e
               	b.eq	0x4003bc <.text+0x19c>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x5               // =5
               	mov	x0, x20
               	bl	0x400238 <.text+0x18>
               	cmp	x0, #0x1e
               	b.eq	0x4003e8 <.text+0x1c8>
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x7               // =7
               	mov	x0, x21
               	bl	0x400238 <.text+0x18>
               	cmp	x0, #0x1e
               	b.eq	0x400414 <.text+0x1f4>
               	mov	x0, #0x6                // =6
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x8               // =8
               	mov	x0, x20
               	bl	0x400238 <.text+0x18>
               	cmp	x0, #0x1e
               	b.eq	0x400440 <.text+0x220>
               	mov	x0, #0x7                // =7
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x0               // =0
               	mov	x0, x21
               	bl	0x400238 <.text+0x18>
               	cmp	x0, #0x0
               	b.eq	0x40046c <.text+0x24c>
               	mov	x0, #0x8                // =8
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x9               // =9
               	mov	x0, x20
               	bl	0x400238 <.text+0x18>
               	cmp	x0, #0x0
               	b.eq	0x400498 <.text+0x278>
               	mov	x0, #0x9                // =9
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
