
binop_imm_chain_fold.aarch64:	file format elf64-littleaarch64

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
               	bl	0x400688 <dlsym>
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
               	mov	x15, #0xa               // =10
               	sxtw	x14, w15
               	add	x15, x14, #0x3
               	sxtw	x15, w15
               	add	x13, x15, #0x7
               	sxtw	x13, w13
               	add	x15, x14, #0x8
               	sxtw	x15, w15
               	sub	x12, x15, #0x3
               	sxtw	x12, w12
               	sub	x15, x14, #0x4
               	sxtw	x15, w15
               	add	x11, x15, #0x9
               	sxtw	x11, w11
               	sub	x15, x14, #0x2
               	sxtw	x15, w15
               	sub	x10, x15, #0x5
               	sxtw	x10, w10
               	mov	x17, #0x3f              // =63
               	and	x15, x14, x17
               	mov	x17, #0x3               // =3
               	orr	x9, x14, x17
               	mov	x17, #0x3               // =3
               	eor	x8, x14, x17
               	sxtw	x14, w13
               	sxtw	x13, w12
               	add	x12, x14, x13
               	sxtw	x12, w12
               	sxtw	x13, w11
               	add	x11, x12, x13
               	sxtw	x11, w11
               	sxtw	x13, w10
               	add	x10, x11, x13
               	sxtw	x10, w10
               	sxtw	x13, w15
               	add	x15, x10, x13
               	sxtw	x15, w15
               	sxtw	x13, w9
               	add	x9, x15, x13
               	sxtw	x9, w9
               	sxtw	x13, w8
               	add	x8, x9, x13
               	sxtw	x20, w8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x150
               	mov	x21, x19
               	sxtw	x22, w20
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x400694 <printf>
               	sxtw	x0, w0
               	mov	x15, x0
               	sxtw	x15, w20
               	cmp	x15, #0x53
               	b.ne	0x400514 <.text+0x254>
               	mov	x15, #0x0               // =0
               	stur	x15, [x29, #-0x60]
               	b	0x400520 <.text+0x260>
               	mov	x15, #0x1               // =1
               	stur	x15, [x29, #-0x60]
               	b	0x400520 <.text+0x260>
               	ldur	x15, [x29, #-0x60]
               	mov	x0, x15
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
