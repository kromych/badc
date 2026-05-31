
extern_decl_then_define.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400264 <.text+0x44>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x19, [sp]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x110
               	mov	x0, x19
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	adrp	x19, 0x410000
               	add	x19, x19, #0xd0
               	mov	x15, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf0
               	mov	x14, x19
               	cmp	x15, x14
               	b.ne	0x4002bc <.text+0x9c>
               	mov	x14, #0x1               // =1
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xd0
               	mov	x15, x19
               	ldr	w14, [x15]
               	mov	x17, #0x9ed8            // =40664
               	movk	x17, #0xc105, lsl #16
               	cmp	x14, x17
               	b.eq	0x4002fc <.text+0xdc>
               	mov	x15, #0x2               // =2
               	mov	x0, x15
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf0
               	mov	x14, x19
               	ldr	w15, [x14]
               	mov	x17, #0xe667            // =58983
               	movk	x17, #0x6a09, lsl #16
               	cmp	x15, x17
               	b.eq	0x40033c <.text+0x11c>
               	mov	x14, #0x3               // =3
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xd0
               	mov	x15, x19
               	add	x15, x15, #0x1c
               	ldr	w14, [x15]
               	mov	x17, #0x4fa4            // =20388
               	movk	x17, #0xbefa, lsl #16
               	cmp	x14, x17
               	b.eq	0x400380 <.text+0x160>
               	mov	x15, #0x4               // =4
               	mov	x0, x15
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf0
               	mov	x14, x19
               	add	x14, x14, #0x1c
               	ldr	w15, [x14]
               	mov	x17, #0xcd19            // =52505
               	movk	x17, #0x5be0, lsl #16
               	cmp	x15, x17
               	b.eq	0x4003c4 <.text+0x1a4>
               	mov	x20, #0x5               // =5
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	0x400238 <.text+0x18>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x110
               	mov	x20, x19
               	cmp	x0, x20
               	b.eq	0x4003fc <.text+0x1dc>
               	mov	x21, #0x6               // =6
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	0x400238 <.text+0x18>
               	ldr	w21, [x0]
               	mov	x17, #0xa5a5            // =42405
               	movk	x17, #0xa5a5, lsl #16
               	cmp	x21, x17
               	b.eq	0x400434 <.text+0x214>
               	mov	x20, #0x7               // =7
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	0x400238 <.text+0x18>
               	add	x0, x0, #0x8
               	ldr	x20, [x0]
               	mov	x17, #0xbeef            // =48879
               	movk	x17, #0xdead, lsl #16
               	cmp	x20, x17
               	b.eq	0x40046c <.text+0x24c>
               	mov	x0, #0x8                // =8
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x0               // =0
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
