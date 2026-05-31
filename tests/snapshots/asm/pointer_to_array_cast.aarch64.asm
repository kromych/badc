
pointer_to_array_cast.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x4003c8 <.text+0x148>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xe8]
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
               	add	x19, x19, #0xf8
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x12, x14, x13
               	ldr	x13, [x12]
               	cbz	x13, 0x40030c <.text+0x8c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
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
               	add	x19, x19, #0x110
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x12, x11, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x116
               	mov	x11, x19
               	str	x11, [x12]
               	sub	x14, x29, #0x18
               	add	x11, x14, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x11d
               	mov	x14, x19
               	str	x14, [x11]
               	sub	x12, x29, #0x18
               	lsl	x14, x20, #3
               	add	x11, x12, x14
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x400608 <dlsym>
               	cbz	x0, 0x400394 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x12, x22, x21
               	ldr	x21, [x0]
               	str	x21, [x12]
               	b	0x400394 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x21, x19
               	lsl	x0, x20, #3
               	add	x20, x21, x0
               	ldr	x0, [x20]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x38]
               	b	0x4003e0 <.text+0x160>
               	ldursw	x15, [x29, #-0x38]
               	cmp	x15, #0x18
               	b.ge	0x40042c <.text+0x1ac>
               	b	0x400404 <.text+0x184>
               	sub	x15, x29, #0x38
               	ldrsw	x14, [x15]
               	add	x13, x14, #0x1
               	str	w13, [x15]
               	b	0x4003e0 <.text+0x160>
               	sub	x13, x29, #0x30
               	ldursw	x14, [x29, #-0x38]
               	lsl	x15, x14, #1
               	add	x12, x13, x15
               	mov	x17, #0x3               // =3
               	mul	x15, x14, x17
               	sxtw	x15, w15
               	sxth	x15, w15
               	strh	w15, [x12]
               	b	0x4003f0 <.text+0x170>
               	sub	x15, x29, #0x30
               	sub	x14, x29, #0x30
               	cmp	x15, x14
               	b.eq	0x40044c <.text+0x1cc>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x12, x15, #0xc
               	ldrsh	x15, [x12]
               	mov	x12, #0x12              // =18
               	sxth	x12, w12
               	cmp	x15, x12
               	b.eq	0x400478 <.text+0x1f8>
               	mov	x12, #0x2               // =2
               	mov	x0, x12
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x30
               	sub	x12, x29, #0x30
               	cmp	x0, x12
               	b.eq	0x400498 <.text+0x218>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x30
               	sub	x0, x29, #0x30
               	cmp	x15, x0
               	b.eq	0x4004b8 <.text+0x238>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x12, #0x0               // =0
               	mov	x0, x12
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
