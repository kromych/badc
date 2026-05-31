
compound_literal_file_scope.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x4003cc <.text+0x14c>
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
               	add	x14, x14, x13
               	ldr	x13, [x14]
               	cbz	x13, 0x40030c <.text+0x8c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
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
               	add	x11, x11, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x116
               	mov	x12, x19
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x11d
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x400818 <dlsym>
               	cbz	x0, 0x400394 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x22, x22, x21
               	ldr	x21, [x0]
               	str	x21, [x22]
               	b	0x400394 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x21, x19
               	lsl	x20, x20, #3
               	add	x21, x21, x20
               	ldr	x20, [x21]
               	mov	x0, x20
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
               	cset	x15, ne
               	stur	x15, [x29, #-0x10]
               	cbnz	x15, 0x400428 <.text+0x1a8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x148
               	mov	x14, x19
               	ldr	x15, [x14]
               	add	x15, x15, #0x4
               	ldrsw	x14, [x15]
               	cmp	x14, #0x4
               	cset	x14, ne
               	stur	x14, [x29, #-0x10]
               	b	0x400428 <.text+0x1a8>
               	ldur	x14, [x29, #-0x10]
               	stur	x14, [x29, #-0x8]
               	cbnz	x14, 0x40045c <.text+0x1dc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x148
               	mov	x15, x19
               	ldr	x14, [x15]
               	add	x14, x14, #0x8
               	ldrsw	x15, [x14]
               	cmp	x15, #0x4
               	cset	x15, ne
               	stur	x15, [x29, #-0x8]
               	b	0x40045c <.text+0x1dc>
               	ldur	x15, [x29, #-0x8]
               	cbz	x15, 0x400478 <.text+0x1f8>
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x15, x19
               	ldr	x0, [x15]
               	ldrsw	x15, [x0]
               	cmp	x15, #0x2
               	cset	x15, ne
               	stur	x15, [x29, #-0x20]
               	cbnz	x15, 0x4004c4 <.text+0x244>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x0, x19
               	ldr	x15, [x0]
               	add	x15, x15, #0x4
               	ldrsw	x0, [x15]
               	cmp	x0, #0x8
               	cset	x0, ne
               	stur	x0, [x29, #-0x20]
               	b	0x4004c4 <.text+0x244>
               	ldur	x0, [x29, #-0x20]
               	stur	x0, [x29, #-0x18]
               	cbnz	x0, 0x4004f8 <.text+0x278>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x15, x19
               	ldr	x0, [x15]
               	add	x0, x0, #0x8
               	ldrsw	x15, [x0]
               	cmp	x15, #0x8
               	cset	x15, ne
               	stur	x15, [x29, #-0x18]
               	b	0x4004f8 <.text+0x278>
               	ldur	x15, [x29, #-0x18]
               	cbz	x15, 0x400514 <.text+0x294>
               	mov	x0, #0x2                // =2
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x178
               	mov	x15, x19
               	ldr	x0, [x15]
               	ldrsw	x15, [x0]
               	cmp	x15, #0x0
               	b.eq	0x400544 <.text+0x2c4>
               	mov	x0, #0x3                // =3
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x178
               	mov	x15, x19
               	ldr	x0, [x15]
               	add	x0, x0, #0x8
               	ldr	x15, [x0]
               	ldrb	w0, [x15]
               	mov	x17, #0x72              // =114
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	stur	x0, [x29, #-0x28]
               	cbnz	x0, 0x4005c8 <.text+0x348>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x178
               	mov	x15, x19
               	ldr	x0, [x15]
               	add	x0, x0, #0x8
               	ldr	x15, [x0]
               	add	x15, x15, #0x1
               	ldrb	w0, [x15]
               	mov	x17, #0x6f              // =111
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	stur	x0, [x29, #-0x28]
               	b	0x4005c8 <.text+0x348>
               	ldur	x0, [x29, #-0x28]
               	cbz	x0, 0x4005e8 <.text+0x368>
               	mov	x15, #0x4               // =4
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x178
               	mov	x0, x19
               	ldr	x15, [x0]
               	add	x15, x15, #0x10
               	ldr	x0, [x15]
               	cmp	x0, #0x0
               	b.eq	0x400620 <.text+0x3a0>
               	mov	x15, #0x5               // =5
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x15, [x0]
               	ldrsw	x0, [x15]
               	cmp	x0, #0x0
               	cset	x0, ne
               	stur	x0, [x29, #-0x38]
               	cbnz	x0, 0x40066c <.text+0x3ec>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x15, x19
               	ldr	x0, [x15]
               	add	x0, x0, #0x4
               	ldrsw	x15, [x0]
               	cmp	x15, #0x0
               	cset	x15, ne
               	stur	x15, [x29, #-0x38]
               	b	0x40066c <.text+0x3ec>
               	ldur	x15, [x29, #-0x38]
               	stur	x15, [x29, #-0x30]
               	cbnz	x15, 0x4006a0 <.text+0x420>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x15, [x0]
               	add	x15, x15, #0x8
               	ldrsw	x0, [x15]
               	cmp	x0, #0x0
               	cset	x0, ne
               	stur	x0, [x29, #-0x30]
               	b	0x4006a0 <.text+0x420>
               	ldur	x0, [x29, #-0x30]
               	cbz	x0, 0x4006c0 <.text+0x440>
               	mov	x15, #0x6               // =6
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
