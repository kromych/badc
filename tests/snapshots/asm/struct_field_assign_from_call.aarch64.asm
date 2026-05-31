
struct_field_assign_from_call.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x40072c <.text+0x46c>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xf0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	sxtw	x20, w0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x12, x14, x13
               	ldr	x13, [x12]
               	cbz	x13, 0x40034c <.text+0x8c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x12, x19
               	lsl	x13, x20, #3
               	add	x14, x12, x13
               	ldr	x13, [x14]
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x18
               	mov	x21, #0x0               // =0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x118
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x12, x11, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x11e
               	mov	x11, x19
               	str	x11, [x12]
               	sub	x14, x29, #0x18
               	add	x11, x14, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x125
               	mov	x14, x19
               	str	x14, [x11]
               	sub	x12, x29, #0x18
               	lsl	x14, x20, #3
               	add	x11, x12, x14
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x4009b8 <dlsym>
               	mov	x11, x0
               	cbz	x11, 0x4003d8 <.text+0x118>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x12, x22, x21
               	ldr	x21, [x11]
               	str	x21, [x12]
               	b	0x4003d8 <.text+0x118>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x21, x19
               	lsl	x11, x20, #3
               	add	x20, x21, x11
               	ldr	x11, [x20]
               	mov	x0, x11
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x2, w2
               	sxtw	x3, w3
               	sxtw	x4, w4
               	mov	x9, #0x4                // =4
               	str	w9, [x1]
               	mov	x0, #0xabcd             // =43981
               	movk	x0, #0x1234, lsl #16
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xa0
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x26, [sp, #0x30]
               	str	x27, [sp, #0x38]
               	str	x28, [sp, #0x40]
               	mov	x16, x0
               	str	x16, [sp, #0x58]
               	mov	x21, x1
               	ldr	x16, [sp, #0x58]
               	add	x22, x16, #0x8
               	ldr	x23, [x22]
               	ldr	x16, [sp, #0x58]
               	add	x11, x16, #0x18
               	ldr	x24, [x11]
               	ldr	x25, [x22]
               	ldr	x16, [sp, #0x58]
               	add	x26, x16, #0x14
               	ldr	x16, [sp, #0x58]
               	add	x8, x16, #0x10
               	ldrsw	x7, [x8]
               	add	x8, x7, #0x1
               	sxtw	x27, w8
               	mov	x28, #0x10              // =16
               	mov	x20, #0x7fff            // =32767
               	mov	x0, x25
               	mov	x5, x21
               	mov	x4, x20
               	mov	x3, x28
               	mov	x2, x27
               	mov	x1, x26
               	bl	0x400410 <.text+0x150>
               	mov	x6, x0
               	str	x6, [x22]
               	ldr	x16, [sp, #0x58]
               	add	x25, x16, #0x18
               	ldr	x27, [x25]
               	ldr	x16, [sp, #0x58]
               	add	x26, x16, #0x24
               	ldr	x16, [sp, #0x58]
               	add	x22, x16, #0x20
               	ldrsw	x6, [x22]
               	add	x22, x6, #0x1
               	sxtw	x22, w22
               	mov	x0, x27
               	mov	x5, x21
               	mov	x4, x20
               	mov	x3, x28
               	mov	x2, x22
               	mov	x1, x26
               	bl	0x400410 <.text+0x150>
               	mov	x6, x0
               	str	x6, [x25]
               	ldr	x16, [sp, #0x58]
               	add	x22, x16, #0x8
               	ldr	x6, [x22]
               	cmp	x23, x6
               	b.ne	0x400568 <.text+0x2a8>
               	mov	x6, #0x1                // =1
               	mov	x0, x6
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x28, [sp, #0x40]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x16, [sp, #0x58]
               	add	x22, x16, #0x18
               	ldr	x6, [x22]
               	cmp	x24, x6
               	b.ne	0x4005b4 <.text+0x2f4>
               	mov	x6, #0x2                // =2
               	mov	x0, x6
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x28, [sp, #0x40]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x16, [sp, #0x58]
               	add	x22, x16, #0x8
               	ldr	x6, [x22]
               	mov	x17, #0xabcd            // =43981
               	movk	x17, #0x1234, lsl #16
               	cmp	x6, x17
               	b.eq	0x400608 <.text+0x348>
               	mov	x6, #0x3                // =3
               	mov	x0, x6
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x28, [sp, #0x40]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x16, [sp, #0x58]
               	add	x22, x16, #0x18
               	ldr	x6, [x22]
               	mov	x17, #0xabcd            // =43981
               	movk	x17, #0x1234, lsl #16
               	cmp	x6, x17
               	b.eq	0x40065c <.text+0x39c>
               	mov	x6, #0x4                // =4
               	mov	x0, x6
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x28, [sp, #0x40]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x16, [sp, #0x58]
               	add	x22, x16, #0x14
               	ldrsw	x6, [x22]
               	cmp	x6, #0x4
               	b.eq	0x4006a8 <.text+0x3e8>
               	mov	x6, #0x5                // =5
               	mov	x0, x6
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x28, [sp, #0x40]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x16, [sp, #0x58]
               	add	x22, x16, #0x24
               	ldrsw	x6, [x22]
               	cmp	x6, #0x4
               	b.eq	0x4006f4 <.text+0x434>
               	mov	x6, #0x6                // =6
               	mov	x0, x6
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x28, [sp, #0x40]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x22, #0x0               // =0
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x28, [sp, #0x40]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x26, [sp, #0x30]
               	str	x19, [sp, #0x40]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x150
               	mov	x20, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x178
               	mov	x21, x19
               	mov	x0, x20
               	mov	x1, x21
               	bl	0x400430 <.text+0x170>
               	mov	x13, x0
               	sxtw	x21, w13
               	cmp	x21, #0x0
               	b.eq	0x400820 <.text+0x560>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x17d
               	mov	x22, x19
               	sxtw	x21, w13
               	adrp	x19, 0x410000
               	add	x19, x19, #0x150
               	mov	x13, x19
               	add	x12, x13, #0x8
               	ldr	x20, [x12]
               	add	x12, x13, #0x18
               	ldr	x23, [x12]
               	add	x12, x13, #0x14
               	ldrsw	x24, [x12]
               	add	x12, x13, #0x24
               	ldrsw	x25, [x12]
               	mov	x0, x22
               	mov	x5, x25
               	mov	x4, x24
               	mov	x3, x23
               	mov	x2, x20
               	mov	x1, x21
               	bl	0x4009c4 <printf>
               	sxtw	x0, w0
               	mov	x12, x0
               	mov	x12, #0x1               // =1
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b4
               	mov	x26, x19
               	mov	x0, x26
               	bl	0x4009c4 <printf>
               	sxtw	x0, w0
               	mov	x12, x0
               	mov	x12, #0x0               // =0
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
