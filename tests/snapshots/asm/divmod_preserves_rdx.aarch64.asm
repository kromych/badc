
divmod_preserves_rdx.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400410 <.text+0x150>
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
               	bl	0x400658 <dlsym>
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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x90
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	mov	x15, #0x64              // =100
               	mov	x14, #0x32              // =50
               	mov	x13, #0x19              // =25
               	mov	x12, #0xc               // =12
               	sxtw	x11, w15
               	mov	x15, #0x8               // =8
               	sdiv	x10, x11, x15
               	sxtw	x9, w14
               	sdiv	x14, x9, x15
               	sxtw	x8, w13
               	sdiv	x13, x8, x15
               	sxtw	x7, w12
               	sdiv	x12, x7, x15
               	sxtw	x15, w10
               	sxtw	x10, w14
               	add	x14, x15, x10
               	sxtw	x14, w14
               	sxtw	x10, w13
               	add	x13, x14, x10
               	sxtw	x13, w13
               	sxtw	x10, w12
               	add	x12, x13, x10
               	sxtw	x12, w12
               	add	x10, x12, x11
               	sxtw	x10, w10
               	add	x12, x10, x9
               	sxtw	x12, w12
               	add	x10, x12, x8
               	sxtw	x10, w10
               	add	x12, x10, x7
               	sxtw	x20, w12
               	adrp	x19, 0x410000
               	add	x19, x19, #0x150
               	mov	x21, x19
               	sxtw	x22, w20
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x400664 <printf>
               	sxtw	x0, w0
               	mov	x8, x0
               	sxtw	x8, w20
               	cmp	x8, #0xd1
               	b.ne	0x4004e4 <.text+0x224>
               	mov	x8, #0x0                // =0
               	stur	x8, [x29, #-0x60]
               	b	0x4004f0 <.text+0x230>
               	mov	x8, #0x1                // =1
               	stur	x8, [x29, #-0x60]
               	b	0x4004f0 <.text+0x230>
               	ldur	x8, [x29, #-0x60]
               	mov	x0, x8
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
