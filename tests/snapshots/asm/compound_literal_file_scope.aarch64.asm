
compound_literal_file_scope.aarch64:	file format elf64-littleaarch64

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
               	bl	0x400808 <dlsym>
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
               	str	x19, [sp]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x148
               	mov	x15, x19
               	ldr	x14, [x15]
               	ldrsw	x15, [x14]
               	cmp	x15, #0x1
               	cset	x14, ne
               	stur	x14, [x29, #-0x10]
               	cbnz	x14, 0x400424 <.text+0x1a4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x148
               	mov	x15, x19
               	ldr	x14, [x15]
               	add	x15, x14, #0x4
               	ldrsw	x14, [x15]
               	cmp	x14, #0x4
               	cset	x15, ne
               	stur	x15, [x29, #-0x10]
               	b	0x400424 <.text+0x1a4>
               	ldur	x15, [x29, #-0x10]
               	stur	x15, [x29, #-0x8]
               	cbnz	x15, 0x400458 <.text+0x1d8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x148
               	mov	x14, x19
               	ldr	x15, [x14]
               	add	x14, x15, #0x8
               	ldrsw	x15, [x14]
               	cmp	x15, #0x4
               	cset	x14, ne
               	stur	x14, [x29, #-0x8]
               	b	0x400458 <.text+0x1d8>
               	ldur	x14, [x29, #-0x8]
               	cbz	x14, 0x400474 <.text+0x1f4>
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x14, x19
               	ldr	x0, [x14]
               	ldrsw	x14, [x0]
               	cmp	x14, #0x2
               	cset	x0, ne
               	stur	x0, [x29, #-0x20]
               	cbnz	x0, 0x4004c0 <.text+0x240>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x14, x19
               	ldr	x0, [x14]
               	add	x14, x0, #0x4
               	ldrsw	x0, [x14]
               	cmp	x0, #0x8
               	cset	x14, ne
               	stur	x14, [x29, #-0x20]
               	b	0x4004c0 <.text+0x240>
               	ldur	x14, [x29, #-0x20]
               	stur	x14, [x29, #-0x18]
               	cbnz	x14, 0x4004f4 <.text+0x274>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x0, x19
               	ldr	x14, [x0]
               	add	x0, x14, #0x8
               	ldrsw	x14, [x0]
               	cmp	x14, #0x8
               	cset	x0, ne
               	stur	x0, [x29, #-0x18]
               	b	0x4004f4 <.text+0x274>
               	ldur	x0, [x29, #-0x18]
               	cbz	x0, 0x400514 <.text+0x294>
               	mov	x14, #0x2               // =2
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x178
               	mov	x0, x19
               	ldr	x14, [x0]
               	ldrsw	x0, [x14]
               	cmp	x0, #0x0
               	b.eq	0x400544 <.text+0x2c4>
               	mov	x0, #0x3                // =3
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x178
               	mov	x14, x19
               	ldr	x0, [x14]
               	add	x14, x0, #0x8
               	ldr	x0, [x14]
               	ldrb	w14, [x0]
               	mov	x17, #0x72              // =114
               	eor	x0, x14, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x0, x17
               	cmp	x14, #0x0
               	cset	x0, ne
               	stur	x0, [x29, #-0x28]
               	cbnz	x0, 0x4005c8 <.text+0x348>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x178
               	mov	x14, x19
               	ldr	x0, [x14]
               	add	x14, x0, #0x8
               	ldr	x0, [x14]
               	add	x14, x0, #0x1
               	ldrb	w0, [x14]
               	mov	x17, #0x6f              // =111
               	eor	x14, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x14, x17
               	cmp	x0, #0x0
               	cset	x14, ne
               	stur	x14, [x29, #-0x28]
               	b	0x4005c8 <.text+0x348>
               	ldur	x14, [x29, #-0x28]
               	cbz	x14, 0x4005e4 <.text+0x364>
               	mov	x0, #0x4                // =4
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x178
               	mov	x14, x19
               	ldr	x0, [x14]
               	add	x14, x0, #0x10
               	ldr	x0, [x14]
               	cmp	x0, #0x0
               	b.eq	0x400618 <.text+0x398>
               	mov	x0, #0x5                // =5
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x14, x19
               	ldr	x0, [x14]
               	ldrsw	x14, [x0]
               	cmp	x14, #0x0
               	cset	x0, ne
               	stur	x0, [x29, #-0x38]
               	cbnz	x0, 0x400664 <.text+0x3e4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x14, x19
               	ldr	x0, [x14]
               	add	x14, x0, #0x4
               	ldrsw	x0, [x14]
               	cmp	x0, #0x0
               	cset	x14, ne
               	stur	x14, [x29, #-0x38]
               	b	0x400664 <.text+0x3e4>
               	ldur	x14, [x29, #-0x38]
               	stur	x14, [x29, #-0x30]
               	cbnz	x14, 0x400698 <.text+0x418>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x14, [x0]
               	add	x0, x14, #0x8
               	ldrsw	x14, [x0]
               	cmp	x14, #0x0
               	cset	x0, ne
               	stur	x0, [x29, #-0x30]
               	b	0x400698 <.text+0x418>
               	ldur	x0, [x29, #-0x30]
               	cbz	x0, 0x4006b8 <.text+0x438>
               	mov	x14, #0x6               // =6
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
