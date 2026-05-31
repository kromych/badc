
function_macro.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400578 <.text+0x358>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	str	x1, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x15, x0
               	stur	x15, [x29, #0x10]
               	mov	x14, x1
               	stur	x14, [x29, #0x20]
               	b	0x400260 <.text+0x40>
               	ldur	x14, [x29, #0x10]
               	ldrb	w15, [x14]
               	stur	x15, [x29, #-0x8]
               	cbz	x15, 0x4002e0 <.text+0xc0>
               	b	0x4002c0 <.text+0xa0>
               	add	x13, x29, #0x10
               	ldr	x15, [x13]
               	add	x15, x15, #0x1
               	str	x15, [x13]
               	add	x14, x29, #0x20
               	ldr	x15, [x14]
               	add	x15, x15, #0x1
               	str	x15, [x14]
               	b	0x400260 <.text+0x40>
               	ldur	x15, [x29, #0x10]
               	ldrb	w13, [x15]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x13, x17
               	cmp	x13, #0x0
               	cset	x13, eq
               	stur	x13, [x29, #-0x10]
               	cbz	x13, 0x400310 <.text+0xf0>
               	b	0x4002ec <.text+0xcc>
               	ldur	x14, [x29, #0x10]
               	ldrb	w15, [x14]
               	ldur	x14, [x29, #0x20]
               	ldrb	w13, [x14]
               	cmp	x15, x13
               	cset	x15, eq
               	stur	x15, [x29, #-0x8]
               	b	0x4002e0 <.text+0xc0>
               	ldur	x15, [x29, #-0x8]
               	cbz	x15, 0x400298 <.text+0x78>
               	b	0x400274 <.text+0x54>
               	ldur	x15, [x29, #0x20]
               	ldrb	w13, [x15]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x13, x17
               	cmp	x13, #0x0
               	cset	x13, eq
               	stur	x13, [x29, #-0x10]
               	b	0x400310 <.text+0xf0>
               	ldur	x0, [x29, #-0x10]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x19, [sp, #0x30]
               	adrp	x19, 0x410000
               	add	x19, x19, #0xd0
               	mov	x20, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0xdb
               	mov	x21, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0xe6
               	mov	x22, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf1
               	mov	x23, x19
               	mov	x0, x20
               	mov	x1, x23
               	bl	0x400238 <.text+0x18>
               	cmp	x0, #0x0
               	b.ne	0x4003b8 <.text+0x198>
               	mov	x23, #0x15              // =21
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xfc
               	mov	x24, x19
               	mov	x0, x21
               	mov	x1, x24
               	bl	0x400238 <.text+0x18>
               	cmp	x0, #0x0
               	b.ne	0x400404 <.text+0x1e4>
               	mov	x24, #0x16              // =22
               	mov	x0, x24
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x107
               	mov	x23, x19
               	mov	x0, x22
               	mov	x1, x23
               	bl	0x400238 <.text+0x18>
               	cmp	x0, #0x0
               	b.ne	0x400450 <.text+0x230>
               	mov	x23, #0x17              // =23
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x20
               	mov	x1, x21
               	bl	0x400238 <.text+0x18>
               	cmp	x0, #0x0
               	b.ne	0x400490 <.text+0x270>
               	mov	x21, #0x18              // =24
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x20
               	mov	x1, x22
               	bl	0x400238 <.text+0x18>
               	cmp	x0, #0x0
               	b.ne	0x4004d0 <.text+0x2b0>
               	mov	x22, #0x19              // =25
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x112
               	mov	x20, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x11d
               	mov	x21, x19
               	mov	x0, x20
               	mov	x1, x21
               	bl	0x400238 <.text+0x18>
               	cmp	x0, #0x0
               	b.ne	0x40055c <.text+0x33c>
               	mov	x21, #0x1f              // =31
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	bl	0x400324 <.text+0x104>
               	sxtw	x14, w0
               	cmp	x14, #0x0
               	b.eq	0x4005c0 <.text+0x3a0>
               	sxtw	x20, w0
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	0x4004f8 <.text+0x2d8>
               	sxtw	x20, w0
               	cmp	x20, #0x0
               	b.eq	0x4005ec <.text+0x3cc>
               	sxtw	x0, w0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x128
               	mov	x21, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x12d
               	mov	x20, x19
               	mov	x0, x21
               	mov	x1, x20
               	bl	0x400238 <.text+0x18>
               	cmp	x0, #0x0
               	b.ne	0x400638 <.text+0x418>
               	mov	x20, #0x29              // =41
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
