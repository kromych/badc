
c4.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xf8]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	sxtw	x20, w0
               	adrp	x19, <page>
               	add	x19, x19, #0x138
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x14, [x14]
               	cbz	x14, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x138
               	mov	x13, x19
               	lsl	x14, x20, #3
               	add	x13, x13, x14
               	ldr	x13, [x13]
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
               	adrp	x19, <page>
               	add	x19, x19, #0x150
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x19, <page>
               	add	x19, x19, #0x156
               	mov	x12, x19
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x19, <page>
               	add	x19, x19, #0x15d
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	<addr>
               	cbz	x0, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x138
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x22, x22, x21
               	ldr	x0, [x0]
               	str	x0, [x22]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x138
               	mov	x0, x19
               	lsl	x20, x20, #3
               	add	x0, x0, x20
               	ldr	x0, [x0]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x190
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x26, [sp, #0x30]
               	str	x27, [sp, #0x38]
               	str	x19, [sp, #0x40]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x15, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x14, x19
               	ldr	x14, [x14]
               	ldrb	w14, [x14]
               	str	x14, [x15]
               	cbz	x14, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x13, x19
               	ldr	x14, [x13]
               	add	x14, x14, #0x1
               	str	x14, [x13]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x15, x19
               	ldr	x15, [x15]
               	cmp	x15, #0xa
               	b.ne	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x1e8
               	mov	x14, x19
               	ldr	x14, [x14]
               	cbz	x14, <addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x23
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1f8
               	mov	x20, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x14, x19
               	ldr	x21, [x14]
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x22, x19
               	ldr	x12, [x22]
               	adrp	x19, <page>
               	add	x19, x19, #0x190
               	mov	x23, x19
               	ldr	x10, [x23]
               	sub	x24, x12, x10
               	ldr	x25, [x23]
               	mov	x0, x20
               	mov	x3, x25
               	mov	x2, x24
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	ldr	x22, [x22]
               	str	x22, [x23]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x26, x19
               	ldr	x0, [x26]
               	add	x0, x0, #0x1
               	str	x0, [x26]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a8
               	mov	x22, x19
               	ldr	x22, [x22]
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x22, x0
               	b.ge	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x201
               	mov	x26, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x207
               	mov	x22, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1a8
               	mov	x27, x19
               	ldr	x25, [x27]
               	add	x25, x25, #0x8
               	str	x25, [x27]
               	ldr	x25, [x25]
               	mov	x17, #0x5               // =5
               	mul	x25, x25, x17
               	add	x22, x22, x25
               	mov	x0, x26
               	mov	x1, x22
               	bl	<addr>
               	sxtw	x0, w0
               	ldr	x27, [x27]
               	ldr	x27, [x27]
               	cmp	x27, #0x7
               	b.gt	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x2cb
               	mov	x25, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1a8
               	mov	x27, x19
               	ldr	x22, [x27]
               	add	x22, x22, #0x8
               	str	x22, [x27]
               	ldr	x22, [x22]
               	mov	x0, x25
               	mov	x1, x22
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x2d0
               	mov	x26, x19
               	mov	x0, x26
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x61
               	cset	x0, ge
               	stur	x0, [x29, #-0x48]
               	cbz	x0, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x25, x19
               	ldr	x25, [x25]
               	ldrb	w25, [x25]
               	cmp	x25, #0x0
               	cset	x25, ne
               	stur	x25, [x29, #-0x30]
               	cbz	x25, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x25, x19
               	ldr	x0, [x25]
               	add	x0, x0, #0x1
               	str	x0, [x25]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x0, x19
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	mov	x17, #0xa               // =10
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	stur	x0, [x29, #-0x30]
               	b	<addr>
               	ldur	x0, [x29, #-0x30]
               	cbz	x0, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x26, [x26]
               	cmp	x26, #0x7a
               	cset	x26, le
               	stur	x26, [x29, #-0x48]
               	b	<addr>
               	ldur	x26, [x29, #-0x48]
               	stur	x26, [x29, #-0x40]
               	cbnz	x26, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x41
               	cset	x0, ge
               	stur	x0, [x29, #-0x50]
               	cbz	x0, <addr>
               	b	<addr>
               	ldur	x26, [x29, #-0x40]
               	stur	x26, [x29, #-0x38]
               	cbnz	x26, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x26, [x26]
               	cmp	x26, #0x5a
               	cset	x26, le
               	stur	x26, [x29, #-0x50]
               	b	<addr>
               	ldur	x26, [x29, #-0x50]
               	stur	x26, [x29, #-0x40]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x5f
               	cset	x0, eq
               	stur	x0, [x29, #-0x38]
               	b	<addr>
               	ldur	x0, [x29, #-0x38]
               	cbz	x0, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x26, x19
               	ldr	x26, [x26]
               	sub	x26, x26, #0x1
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	ldr	x20, [x20]
               	cmp	x20, #0x30
               	cset	x20, ge
               	stur	x20, [x29, #-0x90]
               	cbz	x20, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x0, x19
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	cmp	x0, #0x61
               	cset	x0, ge
               	stur	x0, [x29, #-0x70]
               	cbz	x0, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x0, [x25]
               	mov	x17, #0x93              // =147
               	mul	x0, x0, x17
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x27, x19
               	ldr	x24, [x27]
               	add	x21, x24, #0x1
               	str	x21, [x27]
               	ldrb	w24, [x24]
               	add	x0, x0, x24
               	str	x0, [x25]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x24, [x0]
               	lsl	x24, x24, #6
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x25, x19
               	ldr	x25, [x25]
               	sub	x25, x25, x26
               	add	x24, x24, x25
               	str	x24, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x25, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1b8
               	mov	x24, x19
               	ldr	x24, [x24]
               	str	x24, [x25]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x25, x19
               	ldr	x25, [x25]
               	ldrb	w25, [x25]
               	cmp	x25, #0x7a
               	cset	x25, le
               	stur	x25, [x29, #-0x70]
               	b	<addr>
               	ldur	x25, [x29, #-0x70]
               	stur	x25, [x29, #-0x68]
               	cbnz	x25, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x0, x19
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	cmp	x0, #0x41
               	cset	x0, ge
               	stur	x0, [x29, #-0x78]
               	cbz	x0, <addr>
               	b	<addr>
               	ldur	x25, [x29, #-0x68]
               	stur	x25, [x29, #-0x60]
               	cbnz	x25, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x25, x19
               	ldr	x25, [x25]
               	ldrb	w25, [x25]
               	cmp	x25, #0x5a
               	cset	x25, le
               	stur	x25, [x29, #-0x78]
               	b	<addr>
               	ldur	x25, [x29, #-0x78]
               	stur	x25, [x29, #-0x68]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x0, x19
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	cmp	x0, #0x30
               	cset	x0, ge
               	stur	x0, [x29, #-0x80]
               	cbz	x0, <addr>
               	b	<addr>
               	ldur	x25, [x29, #-0x60]
               	stur	x25, [x29, #-0x58]
               	cbnz	x25, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x25, x19
               	ldr	x25, [x25]
               	ldrb	w25, [x25]
               	cmp	x25, #0x39
               	cset	x25, le
               	stur	x25, [x29, #-0x80]
               	b	<addr>
               	ldur	x25, [x29, #-0x80]
               	stur	x25, [x29, #-0x60]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x0, x19
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	mov	x17, #0x5f              // =95
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	stur	x0, [x29, #-0x58]
               	b	<addr>
               	ldur	x0, [x29, #-0x58]
               	cbz	x0, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x24, x19
               	ldr	x24, [x24]
               	ldr	x24, [x24]
               	cbz	x24, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x24, x19
               	ldr	x24, [x24]
               	add	x24, x24, #0x8
               	ldr	x24, [x24]
               	cmp	x0, x24
               	cset	x0, eq
               	stur	x0, [x29, #-0x88]
               	cbz	x0, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x24, x19
               	ldr	x0, [x24]
               	add	x0, x0, #0x10
               	str	x26, [x0]
               	ldr	x20, [x24]
               	add	x20, x20, #0x8
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x26, [x0]
               	str	x26, [x20]
               	ldr	x24, [x24]
               	mov	x22, #0x0               // =0
               	mov	x26, #0x85              // =133
               	str	x26, [x24]
               	str	x26, [x0]
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x24, x19
               	ldr	x24, [x24]
               	add	x24, x24, #0x10
               	ldr	x24, [x24]
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x0, x19
               	ldr	x0, [x0]
               	sub	x22, x0, x26
               	mov	x0, x24
               	mov	x2, x22
               	mov	x1, x26
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	stur	x0, [x29, #-0x88]
               	b	<addr>
               	ldur	x0, [x29, #-0x88]
               	cbz	x0, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x0, x19
               	ldr	x0, [x0]
               	mov	x24, #0x0               // =0
               	ldr	x0, [x0]
               	str	x0, [x22]
               	mov	x0, x24
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x20, x19
               	ldr	x24, [x20]
               	add	x24, x24, #0x48
               	str	x24, [x20]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x22, [x22]
               	cmp	x22, #0x39
               	cset	x22, le
               	stur	x22, [x29, #-0x90]
               	b	<addr>
               	ldur	x22, [x29, #-0x90]
               	cbz	x22, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c8
               	mov	x20, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x22, [x22]
               	sub	x22, x22, #0x30
               	str	x22, [x20]
               	cbz	x22, <addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x22, [x22]
               	cmp	x22, #0x2f
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	mov	x22, #0x80              // =128
               	str	x22, [x0]
               	mov	x26, #0x0               // =0
               	mov	x0, x26
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x22, x19
               	ldr	x22, [x22]
               	ldrb	w22, [x22]
               	mov	x17, #0x78              // =120
               	eor	x22, x22, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x22, x17
               	cmp	x22, #0x0
               	cset	x22, eq
               	stur	x22, [x29, #-0xa0]
               	cbnz	x22, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x26, x19
               	ldr	x26, [x26]
               	ldrb	w26, [x26]
               	cmp	x26, #0x30
               	cset	x26, ge
               	stur	x26, [x29, #-0x98]
               	cbz	x26, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c8
               	mov	x26, x19
               	ldr	x22, [x26]
               	mov	x17, #0xa               // =10
               	mul	x22, x22, x17
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x20, x19
               	ldr	x0, [x20]
               	add	x24, x0, #0x1
               	str	x24, [x20]
               	ldrb	w0, [x0]
               	add	x22, x22, x0
               	sub	x22, x22, #0x30
               	str	x22, [x26]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x22, x19
               	ldr	x22, [x22]
               	ldrb	w22, [x22]
               	cmp	x22, #0x39
               	cset	x22, le
               	stur	x22, [x29, #-0x98]
               	b	<addr>
               	ldur	x22, [x29, #-0x98]
               	cbz	x22, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x0, x19
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	mov	x17, #0x58              // =88
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	stur	x0, [x29, #-0xa0]
               	b	<addr>
               	ldur	x0, [x29, #-0xa0]
               	cbz	x0, <addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x0, x19
               	ldr	x26, [x0]
               	add	x26, x26, #0x1
               	str	x26, [x0]
               	ldrb	w26, [x26]
               	str	x26, [x22]
               	stur	x26, [x29, #-0xa8]
               	cbz	x26, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c8
               	mov	x21, x19
               	ldr	x26, [x21]
               	lsl	x26, x26, #4
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x0, [x22]
               	mov	x17, #0xf               // =15
               	and	x0, x0, x17
               	add	x26, x26, x0
               	ldr	x22, [x22]
               	cmp	x22, #0x41
               	b.lt	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x21, [x21]
               	cmp	x21, #0x30
               	cset	x21, ge
               	stur	x21, [x29, #-0xc0]
               	cbz	x21, <addr>
               	b	<addr>
               	ldur	x26, [x29, #-0xa8]
               	cbz	x26, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x26, [x26]
               	cmp	x26, #0x39
               	cset	x26, le
               	stur	x26, [x29, #-0xc0]
               	b	<addr>
               	ldur	x26, [x29, #-0xc0]
               	stur	x26, [x29, #-0xb8]
               	cbnz	x26, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x21, [x21]
               	cmp	x21, #0x61
               	cset	x21, ge
               	stur	x21, [x29, #-0xc8]
               	cbz	x21, <addr>
               	b	<addr>
               	ldur	x26, [x29, #-0xb8]
               	stur	x26, [x29, #-0xb0]
               	cbnz	x26, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x26, [x26]
               	cmp	x26, #0x66
               	cset	x26, le
               	stur	x26, [x29, #-0xc8]
               	b	<addr>
               	ldur	x26, [x29, #-0xc8]
               	stur	x26, [x29, #-0xb8]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x21, [x21]
               	cmp	x21, #0x41
               	cset	x21, ge
               	stur	x21, [x29, #-0xd0]
               	cbz	x21, <addr>
               	b	<addr>
               	ldur	x26, [x29, #-0xb0]
               	stur	x26, [x29, #-0xa8]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x26, [x26]
               	cmp	x26, #0x46
               	cset	x26, le
               	stur	x26, [x29, #-0xd0]
               	b	<addr>
               	ldur	x26, [x29, #-0xd0]
               	stur	x26, [x29, #-0xb0]
               	b	<addr>
               	mov	x0, #0x9                // =9
               	stur	x0, [x29, #-0xd8]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0xd8]
               	b	<addr>
               	ldur	x0, [x29, #-0xd8]
               	add	x26, x26, x0
               	str	x26, [x21]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x26, x19
               	ldr	x26, [x26]
               	ldrb	w26, [x26]
               	cmp	x26, #0x30
               	cset	x26, ge
               	stur	x26, [x29, #-0xe0]
               	cbz	x26, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c8
               	mov	x26, x19
               	ldr	x0, [x26]
               	lsl	x0, x0, #3
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x21, x19
               	ldr	x22, [x21]
               	add	x24, x22, #0x1
               	str	x24, [x21]
               	ldrb	w22, [x22]
               	add	x0, x0, x22
               	sub	x0, x0, #0x30
               	str	x0, [x26]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x0, x19
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	cmp	x0, #0x37
               	cset	x0, le
               	stur	x0, [x29, #-0xe0]
               	b	<addr>
               	ldur	x0, [x29, #-0xe0]
               	cbz	x0, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x26, x19
               	ldr	x26, [x26]
               	ldrb	w26, [x26]
               	mov	x17, #0x2f              // =47
               	eor	x26, x26, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x26, x26, x17
               	cmp	x26, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x22, [x22]
               	cmp	x22, #0x27
               	cset	x22, eq
               	stur	x22, [x29, #-0xf0]
               	cbnz	x22, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x22, x19
               	ldr	x26, [x22]
               	add	x26, x26, #0x1
               	str	x26, [x22]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	mov	x22, #0xa0              // =160
               	str	x22, [x0]
               	mov	x26, #0x0               // =0
               	mov	x0, x26
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x26, x19
               	ldr	x26, [x26]
               	ldrb	w26, [x26]
               	cmp	x26, #0x0
               	cset	x26, ne
               	stur	x26, [x29, #-0xe8]
               	cbz	x26, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x26, x19
               	ldr	x0, [x26]
               	add	x0, x0, #0x1
               	str	x0, [x26]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x0, x19
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	mov	x17, #0xa               // =10
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	stur	x0, [x29, #-0xe8]
               	b	<addr>
               	ldur	x0, [x29, #-0xe8]
               	cbz	x0, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x26, [x26]
               	cmp	x26, #0x22
               	cset	x26, eq
               	stur	x26, [x29, #-0xf0]
               	b	<addr>
               	ldur	x26, [x29, #-0xf0]
               	cbz	x26, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x198
               	mov	x22, x19
               	ldr	x22, [x22]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x22, [x22]
               	cmp	x22, #0x3d
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x26, x19
               	ldr	x26, [x26]
               	ldrb	w26, [x26]
               	cmp	x26, #0x0
               	cset	x26, ne
               	stur	x26, [x29, #-0xf8]
               	cbz	x26, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c8
               	mov	x26, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x0, x19
               	ldr	x20, [x0]
               	add	x24, x20, #0x1
               	str	x24, [x0]
               	ldrb	w20, [x20]
               	str	x20, [x26]
               	cmp	x20, #0x5c
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x24, x19
               	ldr	x0, [x24]
               	add	x0, x0, #0x1
               	str	x0, [x24]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x26, [x26]
               	cmp	x26, #0x22
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x0, x19
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x26, [x26]
               	cmp	x0, x26
               	cset	x0, ne
               	stur	x0, [x29, #-0xf8]
               	b	<addr>
               	ldur	x0, [x29, #-0xf8]
               	cbz	x0, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c8
               	mov	x21, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x20, x19
               	ldr	x26, [x20]
               	add	x24, x26, #0x1
               	str	x24, [x20]
               	ldrb	w26, [x26]
               	str	x26, [x21]
               	cmp	x26, #0x6e
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x26, [x26]
               	cmp	x26, #0x22
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c8
               	mov	x0, x19
               	mov	x26, #0xa               // =10
               	str	x26, [x0]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x198
               	mov	x21, x19
               	ldr	x26, [x21]
               	add	x0, x26, #0x1
               	str	x0, [x21]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c8
               	mov	x24, x19
               	ldr	x24, [x24]
               	strb	w24, [x26]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c8
               	mov	x0, x19
               	str	x22, [x0]
               	b	<addr>
               	mov	x26, #0x0               // =0
               	mov	x0, x26
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	mov	x26, #0x80              // =128
               	str	x26, [x0]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x26, x19
               	ldr	x26, [x26]
               	ldrb	w26, [x26]
               	mov	x17, #0x3d              // =61
               	eor	x26, x26, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x26, x26, x17
               	cmp	x26, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x2b
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x22, x19
               	ldr	x26, [x22]
               	add	x26, x26, #0x1
               	str	x26, [x22]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	mov	x26, #0x95              // =149
               	str	x26, [x0]
               	b	<addr>
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
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	mov	x22, #0x8e              // =142
               	str	x22, [x26]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x22, x19
               	ldr	x22, [x22]
               	ldrb	w22, [x22]
               	mov	x17, #0x2b              // =43
               	eor	x22, x22, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x22, x17
               	cmp	x22, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x26, [x26]
               	cmp	x26, #0x2d
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x0, x19
               	ldr	x22, [x0]
               	add	x22, x22, #0x1
               	str	x22, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	mov	x22, #0xa2              // =162
               	str	x22, [x26]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	mov	x0, #0x9d               // =157
               	str	x0, [x22]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x0, x19
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	mov	x17, #0x2d              // =45
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x22, [x22]
               	cmp	x22, #0x21
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x26, x19
               	ldr	x0, [x26]
               	add	x0, x0, #0x1
               	str	x0, [x26]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	mov	x0, #0xa3               // =163
               	str	x0, [x22]
               	b	<addr>
               	mov	x26, #0x0               // =0
               	mov	x0, x26
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	mov	x26, #0x9e              // =158
               	str	x26, [x0]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x26, x19
               	ldr	x26, [x26]
               	ldrb	w26, [x26]
               	mov	x17, #0x3d              // =61
               	eor	x26, x26, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x26, x26, x17
               	cmp	x26, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x22, [x22]
               	cmp	x22, #0x3c
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x22, x19
               	ldr	x26, [x22]
               	add	x26, x26, #0x1
               	str	x26, [x22]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	mov	x26, #0x96              // =150
               	str	x26, [x0]
               	b	<addr>
               	mov	x26, #0x0               // =0
               	mov	x0, x26
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x26, x19
               	ldr	x26, [x26]
               	ldrb	w26, [x26]
               	mov	x17, #0x3d              // =61
               	eor	x26, x26, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x26, x26, x17
               	cmp	x26, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x3e
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x22, x19
               	ldr	x26, [x22]
               	add	x26, x26, #0x1
               	str	x26, [x22]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	mov	x26, #0x99              // =153
               	str	x26, [x0]
               	b	<addr>
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
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x26, x19
               	ldr	x26, [x26]
               	ldrb	w26, [x26]
               	mov	x17, #0x3c              // =60
               	eor	x26, x26, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x26, x26, x17
               	cmp	x26, #0x0
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x22, x19
               	ldr	x26, [x22]
               	add	x26, x26, #0x1
               	str	x26, [x22]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	mov	x26, #0x9b              // =155
               	str	x26, [x0]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	mov	x22, #0x97              // =151
               	str	x22, [x26]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x22, x19
               	ldr	x22, [x22]
               	ldrb	w22, [x22]
               	mov	x17, #0x3d              // =61
               	eor	x22, x22, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x22, x17
               	cmp	x22, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x26, [x26]
               	cmp	x26, #0x7c
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x0, x19
               	ldr	x22, [x0]
               	add	x22, x22, #0x1
               	str	x22, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	mov	x22, #0x9a              // =154
               	str	x22, [x26]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x22, x19
               	ldr	x22, [x22]
               	ldrb	w22, [x22]
               	mov	x17, #0x3e              // =62
               	eor	x22, x22, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x22, x17
               	cmp	x22, #0x0
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x0, x19
               	ldr	x22, [x0]
               	add	x22, x22, #0x1
               	str	x22, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	mov	x22, #0x9c              // =156
               	str	x22, [x26]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	mov	x0, #0x98               // =152
               	str	x0, [x22]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x0, x19
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	mov	x17, #0x7c              // =124
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x22, [x22]
               	cmp	x22, #0x26
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x26, x19
               	ldr	x0, [x26]
               	add	x0, x0, #0x1
               	str	x0, [x26]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	mov	x0, #0x90               // =144
               	str	x0, [x22]
               	b	<addr>
               	mov	x26, #0x0               // =0
               	mov	x0, x26
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	mov	x26, #0x92              // =146
               	str	x26, [x0]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x26, x19
               	ldr	x26, [x26]
               	ldrb	w26, [x26]
               	mov	x17, #0x26              // =38
               	eor	x26, x26, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x26, x26, x17
               	cmp	x26, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x5e
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x22, x19
               	ldr	x26, [x22]
               	add	x26, x26, #0x1
               	str	x26, [x22]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	mov	x26, #0x91              // =145
               	str	x26, [x0]
               	b	<addr>
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
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	mov	x22, #0x94              // =148
               	str	x22, [x26]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	mov	x0, #0x93               // =147
               	str	x0, [x22]
               	mov	x26, #0x0               // =0
               	mov	x0, x26
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x25
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	mov	x0, #0xa1               // =161
               	str	x0, [x26]
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
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x2a
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	mov	x0, #0x9f               // =159
               	str	x0, [x22]
               	mov	x26, #0x0               // =0
               	mov	x0, x26
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x5b
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	mov	x0, #0xa4               // =164
               	str	x0, [x26]
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
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x3f
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	mov	x0, #0x8f               // =143
               	str	x0, [x22]
               	mov	x26, #0x0               // =0
               	mov	x0, x26
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x7e
               	cset	x0, eq
               	sub	x17, x29, #0x138
               	str	x0, [x17]
               	cbnz	x0, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x26, [x26]
               	cmp	x26, #0x3b
               	cset	x26, eq
               	sub	x17, x29, #0x138
               	str	x26, [x17]
               	b	<addr>
               	sub	x16, x29, #0x138
               	ldr	x26, [x16]
               	sub	x17, x29, #0x130
               	str	x26, [x17]
               	cbnz	x26, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x7b
               	cset	x0, eq
               	sub	x17, x29, #0x130
               	str	x0, [x17]
               	b	<addr>
               	sub	x16, x29, #0x130
               	ldr	x0, [x16]
               	sub	x17, x29, #0x128
               	str	x0, [x17]
               	cbnz	x0, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x26, [x26]
               	cmp	x26, #0x7d
               	cset	x26, eq
               	sub	x17, x29, #0x128
               	str	x26, [x17]
               	b	<addr>
               	sub	x16, x29, #0x128
               	ldr	x26, [x16]
               	sub	x17, x29, #0x120
               	str	x26, [x17]
               	cbnz	x26, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x28
               	cset	x0, eq
               	sub	x17, x29, #0x120
               	str	x0, [x17]
               	b	<addr>
               	sub	x16, x29, #0x120
               	ldr	x0, [x16]
               	sub	x17, x29, #0x118
               	str	x0, [x17]
               	cbnz	x0, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x26, [x26]
               	cmp	x26, #0x29
               	cset	x26, eq
               	sub	x17, x29, #0x118
               	str	x26, [x17]
               	b	<addr>
               	sub	x16, x29, #0x118
               	ldr	x26, [x16]
               	sub	x17, x29, #0x110
               	str	x26, [x17]
               	cbnz	x26, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x5d
               	cset	x0, eq
               	sub	x17, x29, #0x110
               	str	x0, [x17]
               	b	<addr>
               	sub	x16, x29, #0x110
               	ldr	x0, [x16]
               	sub	x17, x29, #0x108
               	str	x0, [x17]
               	cbnz	x0, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x26, [x26]
               	cmp	x26, #0x2c
               	cset	x26, eq
               	sub	x17, x29, #0x108
               	str	x26, [x17]
               	b	<addr>
               	sub	x16, x29, #0x108
               	ldr	x26, [x16]
               	stur	x26, [x29, #-0x100]
               	cbnz	x26, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x3a
               	cset	x0, eq
               	stur	x0, [x29, #-0x100]
               	b	<addr>
               	ldur	x0, [x29, #-0x100]
               	cbz	x0, <addr>
               	mov	x26, #0x0               // =0
               	mov	x0, x26
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x120
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x26, [sp, #0x30]
               	str	x19, [sp, #0x40]
               	mov	x20, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x14, x19
               	ldr	x14, [x14]
               	cmp	x14, #0x0
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x2d2
               	mov	x21, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x14, x19
               	ldr	x22, [x14]
               	mov	x0, x21
               	mov	x1, x22
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x23, #0xffff            // =65535
               	movk	x23, #0xffff, lsl #16
               	movk	x23, #0xffff, lsl #32
               	movk	x23, #0xffff, lsl #48
               	mov	x0, x23
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x23, [x23]
               	cmp	x23, #0x80
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x23, [x0]
               	add	x23, x23, #0x8
               	str	x23, [x0]
               	mov	x22, #0x1               // =1
               	str	x22, [x23]
               	ldr	x11, [x0]
               	add	x11, x11, #0x8
               	str	x11, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c8
               	mov	x23, x19
               	ldr	x23, [x23]
               	str	x23, [x11]
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	str	x22, [x0]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x22
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x0, [x23]
               	add	x0, x0, #0x8
               	str	x0, [x23]
               	mov	x22, #0x1               // =1
               	str	x22, [x0]
               	ldr	x11, [x23]
               	add	x11, x11, #0x8
               	str	x11, [x23]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c8
               	mov	x22, x19
               	ldr	x22, [x22]
               	str	x22, [x11]
               	bl	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x8c
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x22, [x22]
               	cmp	x22, #0x22
               	b.ne	<addr>
               	bl	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x198
               	mov	x22, x19
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	str	x0, [x22]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x11, x19
               	mov	x0, #0x2                // =2
               	str	x0, [x11]
               	b	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x28
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x24, [x24]
               	cmp	x24, #0x85
               	b.ne	<addr>
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x24, x19
               	mov	x0, #0x1                // =1
               	str	x0, [x24]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x21, [x21]
               	cmp	x21, #0x8a
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x2f4
               	mov	x21, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x22, [x0]
               	mov	x0, x21
               	mov	x1, x22
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x24, #0xffff            // =65535
               	movk	x24, #0xffff, lsl #16
               	movk	x24, #0xffff, lsl #32
               	movk	x24, #0xffff, lsl #48
               	mov	x0, x24
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x21, [x21]
               	cmp	x21, #0x86
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	mov	x21, #0x0               // =0
               	str	x21, [x0]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x21, [x21]
               	cmp	x21, #0x9f
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	ldr	x21, [x0]
               	add	x21, x21, #0x2
               	str	x21, [x0]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x21, [x21]
               	cmp	x21, #0x29
               	b.ne	<addr>
               	bl	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x24, x19
               	ldr	x0, [x24]
               	add	x0, x0, #0x8
               	str	x0, [x24]
               	mov	x22, #0x1               // =1
               	str	x22, [x0]
               	ldr	x23, [x24]
               	add	x23, x23, #0x8
               	str	x23, [x24]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x22, x19
               	ldr	x22, [x22]
               	cmp	x22, #0x0
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x317
               	mov	x22, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x21, [x0]
               	mov	x0, x22
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x24, #0xffff            // =65535
               	movk	x24, #0xffff, lsl #16
               	movk	x24, #0xffff, lsl #32
               	movk	x24, #0xffff, lsl #48
               	mov	x0, x24
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	mov	x24, #0x1               // =1
               	stur	x24, [x29, #-0x30]
               	b	<addr>
               	mov	x24, #0x8               // =8
               	stur	x24, [x29, #-0x30]
               	b	<addr>
               	ldur	x24, [x29, #-0x30]
               	str	x24, [x23]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x22, x19
               	mov	x24, #0x1               // =1
               	str	x24, [x22]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x23, x19
               	ldr	x23, [x23]
               	stur	x23, [x29, #-0x10]
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x28
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x22, [x22]
               	cmp	x22, #0x28
               	b.ne	<addr>
               	b	<addr>
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x8]
               	b	<addr>
               	b	<addr>
               	ldur	x0, [x29, #-0x10]
               	add	x0, x0, #0x18
               	ldr	x0, [x0]
               	cmp	x0, #0x80
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x29
               	b.eq	<addr>
               	mov	x23, #0x8e              // =142
               	mov	x0, x23
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x23, [x0]
               	add	x23, x23, #0x8
               	str	x23, [x0]
               	mov	x22, #0xd               // =13
               	str	x22, [x23]
               	sub	x0, x29, #0x8
               	ldr	x22, [x0]
               	add	x22, x22, #0x1
               	str	x22, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x23, [x23]
               	cmp	x23, #0x2c
               	b.ne	<addr>
               	b	<addr>
               	bl	<addr>
               	ldur	x0, [x29, #-0x10]
               	add	x0, x0, #0x18
               	ldr	x0, [x0]
               	cmp	x0, #0x82
               	b.ne	<addr>
               	b	<addr>
               	bl	<addr>
               	mov	x21, x0
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x21, x19
               	ldr	x0, [x21]
               	add	x0, x0, #0x8
               	str	x0, [x21]
               	ldur	x23, [x29, #-0x10]
               	add	x23, x23, #0x28
               	ldr	x23, [x23]
               	str	x23, [x0]
               	b	<addr>
               	ldur	x24, [x29, #-0x8]
               	cbz	x24, <addr>
               	b	<addr>
               	ldur	x23, [x29, #-0x10]
               	add	x23, x23, #0x18
               	ldr	x23, [x23]
               	cmp	x23, #0x81
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x21, x19
               	ldr	x23, [x21]
               	add	x23, x23, #0x8
               	str	x23, [x21]
               	mov	x0, #0x3                // =3
               	str	x0, [x23]
               	ldr	x24, [x21]
               	add	x24, x24, #0x8
               	str	x24, [x21]
               	ldur	x0, [x29, #-0x10]
               	add	x0, x0, #0x28
               	ldr	x0, [x0]
               	str	x0, [x24]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x33b
               	mov	x22, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x21, x19
               	ldr	x21, [x21]
               	mov	x0, x22
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x24, #0xffff            // =65535
               	movk	x24, #0xffff, lsl #16
               	movk	x24, #0xffff, lsl #32
               	movk	x24, #0xffff, lsl #48
               	mov	x0, x24
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x24, [x0]
               	add	x24, x24, #0x8
               	str	x24, [x0]
               	mov	x22, #0x7               // =7
               	str	x22, [x24]
               	ldr	x23, [x0]
               	add	x23, x23, #0x8
               	str	x23, [x0]
               	ldur	x22, [x29, #-0x8]
               	str	x22, [x23]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x22, x19
               	ldur	x0, [x29, #-0x10]
               	add	x0, x0, #0x20
               	ldr	x0, [x0]
               	str	x0, [x22]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x0, [x23]
               	add	x0, x0, #0x8
               	str	x0, [x23]
               	mov	x22, #0x1               // =1
               	str	x22, [x0]
               	ldr	x24, [x23]
               	add	x24, x24, #0x8
               	str	x24, [x23]
               	ldur	x0, [x29, #-0x10]
               	add	x0, x0, #0x28
               	ldr	x0, [x0]
               	str	x0, [x24]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x23, x19
               	str	x22, [x23]
               	b	<addr>
               	b	<addr>
               	ldur	x23, [x29, #-0x10]
               	add	x23, x23, #0x18
               	ldr	x23, [x23]
               	cmp	x23, #0x84
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x23, [x0]
               	add	x23, x23, #0x8
               	str	x23, [x0]
               	mov	x22, #0x0               // =0
               	str	x22, [x23]
               	ldr	x24, [x0]
               	add	x24, x24, #0x8
               	str	x24, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d8
               	mov	x22, x19
               	ldr	x22, [x22]
               	ldur	x0, [x29, #-0x10]
               	add	x0, x0, #0x28
               	ldr	x0, [x0]
               	sub	x22, x22, x0
               	str	x22, [x24]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x0, [x23]
               	add	x0, x0, #0x8
               	str	x0, [x23]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x21, x19
               	ldur	x23, [x29, #-0x10]
               	add	x23, x23, #0x20
               	ldr	x23, [x23]
               	str	x23, [x21]
               	cmp	x23, #0x0
               	b.ne	<addr>
               	b	<addr>
               	ldur	x22, [x29, #-0x10]
               	add	x22, x22, #0x18
               	ldr	x22, [x22]
               	cmp	x22, #0x83
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x22, [x0]
               	add	x22, x22, #0x8
               	str	x22, [x0]
               	mov	x24, #0x1               // =1
               	str	x24, [x22]
               	ldr	x23, [x0]
               	add	x23, x23, #0x8
               	str	x23, [x0]
               	ldur	x24, [x29, #-0x10]
               	add	x24, x24, #0x28
               	ldr	x24, [x24]
               	str	x24, [x23]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x352
               	mov	x21, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x24, [x0]
               	mov	x0, x21
               	mov	x1, x24
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x23, #0xffff            // =65535
               	movk	x23, #0xffff, lsl #16
               	movk	x23, #0xffff, lsl #32
               	movk	x23, #0xffff, lsl #48
               	mov	x0, x23
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	mov	x22, #0xa               // =10
               	stur	x22, [x29, #-0x38]
               	b	<addr>
               	mov	x22, #0x9               // =9
               	stur	x22, [x29, #-0x38]
               	b	<addr>
               	ldur	x22, [x29, #-0x38]
               	str	x22, [x0]
               	b	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x8a
               	cset	x0, eq
               	stur	x0, [x29, #-0x40]
               	cbnz	x0, <addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x22, [x22]
               	cmp	x22, #0x9f
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x22, [x22]
               	cmp	x22, #0x86
               	cset	x22, eq
               	stur	x22, [x29, #-0x40]
               	b	<addr>
               	ldur	x22, [x29, #-0x40]
               	cbz	x22, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x8a
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x23, #0x8e              // =142
               	mov	x0, x23
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x29
               	b.ne	<addr>
               	b	<addr>
               	mov	x22, #0x1               // =1
               	stur	x22, [x29, #-0x48]
               	b	<addr>
               	mov	x22, #0x0               // =0
               	stur	x22, [x29, #-0x48]
               	b	<addr>
               	ldur	x22, [x29, #-0x48]
               	stur	x22, [x29, #-0x8]
               	bl	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x22, [x22]
               	cmp	x22, #0x9f
               	b.ne	<addr>
               	bl	<addr>
               	ldur	x0, [x29, #-0x8]
               	add	x0, x0, #0x2
               	stur	x0, [x29, #-0x8]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x29
               	b.ne	<addr>
               	bl	<addr>
               	b	<addr>
               	mov	x24, #0xa2              // =162
               	mov	x0, x24
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	ldur	x24, [x29, #-0x8]
               	str	x24, [x0]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x36a
               	mov	x22, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x24, [x0]
               	mov	x0, x22
               	mov	x1, x24
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x23, #0xffff            // =65535
               	movk	x23, #0xffff, lsl #16
               	movk	x23, #0xffff, lsl #32
               	movk	x23, #0xffff, lsl #48
               	mov	x0, x23
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x378
               	mov	x23, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x24, [x0]
               	mov	x0, x23
               	mov	x1, x24
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x22, #0xffff            // =65535
               	movk	x22, #0xffff, lsl #16
               	movk	x22, #0xffff, lsl #32
               	movk	x22, #0xffff, lsl #48
               	mov	x0, x22
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	bl	<addr>
               	mov	x24, #0xa2              // =162
               	mov	x0, x24
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x1
               	b.le	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x24, [x24]
               	cmp	x24, #0x94
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x24, x19
               	ldr	x0, [x24]
               	sub	x0, x0, #0x2
               	str	x0, [x24]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x24, x19
               	ldr	x0, [x24]
               	add	x0, x0, #0x8
               	str	x0, [x24]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x22, x19
               	ldr	x22, [x22]
               	cmp	x22, #0x0
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x392
               	mov	x22, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x23, x19
               	ldr	x23, [x23]
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x24, #0xffff            // =65535
               	movk	x24, #0xffff, lsl #16
               	movk	x24, #0xffff, lsl #32
               	movk	x24, #0xffff, lsl #48
               	mov	x0, x24
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	mov	x24, #0xa               // =10
               	stur	x24, [x29, #-0x50]
               	b	<addr>
               	mov	x24, #0x9               // =9
               	stur	x24, [x29, #-0x50]
               	b	<addr>
               	ldur	x24, [x29, #-0x50]
               	str	x24, [x0]
               	b	<addr>
               	bl	<addr>
               	mov	x23, #0xa2              // =162
               	mov	x0, x23
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x0, [x0]
               	ldr	x0, [x0]
               	cmp	x0, #0xa
               	cset	x0, eq
               	stur	x0, [x29, #-0x58]
               	cbnz	x0, <addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x21
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x23, [x23]
               	ldr	x23, [x23]
               	cmp	x23, #0x9
               	cset	x23, eq
               	stur	x23, [x29, #-0x58]
               	b	<addr>
               	ldur	x23, [x29, #-0x58]
               	cbz	x23, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x23, [x0]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x23, x23, x17
               	str	x23, [x0]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x23, x19
               	ldr	x0, [x23]
               	add	x0, x0, #0x2
               	str	x0, [x23]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x3a7
               	mov	x24, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x22, x19
               	ldr	x22, [x22]
               	mov	x0, x24
               	mov	x1, x22
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x23, #0xffff            // =65535
               	movk	x23, #0xffff, lsl #16
               	movk	x23, #0xffff, lsl #32
               	movk	x23, #0xffff, lsl #48
               	mov	x0, x23
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	bl	<addr>
               	mov	x24, #0xa2              // =162
               	mov	x0, x24
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x24, [x0]
               	add	x24, x24, #0x8
               	str	x24, [x0]
               	mov	x23, #0xd               // =13
               	str	x23, [x24]
               	ldr	x21, [x0]
               	add	x21, x21, #0x8
               	str	x21, [x0]
               	mov	x23, #0x1               // =1
               	str	x23, [x21]
               	ldr	x24, [x0]
               	add	x24, x24, #0x8
               	str	x24, [x0]
               	mov	x21, #0x0               // =0
               	str	x21, [x24]
               	ldr	x10, [x0]
               	add	x10, x10, #0x8
               	str	x10, [x0]
               	mov	x21, #0x11              // =17
               	str	x21, [x10]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	str	x23, [x0]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x7e
               	b.ne	<addr>
               	bl	<addr>
               	mov	x21, #0xa2              // =162
               	mov	x0, x21
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x21, [x0]
               	add	x21, x21, #0x8
               	str	x21, [x0]
               	mov	x23, #0xd               // =13
               	str	x23, [x21]
               	ldr	x10, [x0]
               	add	x10, x10, #0x8
               	str	x10, [x0]
               	mov	x23, #0x1               // =1
               	str	x23, [x10]
               	ldr	x21, [x0]
               	add	x21, x21, #0x8
               	str	x21, [x0]
               	mov	x10, #0xffff            // =65535
               	movk	x10, #0xffff, lsl #16
               	movk	x10, #0xffff, lsl #32
               	movk	x10, #0xffff, lsl #48
               	str	x10, [x21]
               	ldr	x24, [x0]
               	add	x24, x24, #0x8
               	str	x24, [x0]
               	mov	x10, #0xf               // =15
               	str	x10, [x24]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	str	x23, [x0]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x9d
               	b.ne	<addr>
               	bl	<addr>
               	mov	x25, #0xa2              // =162
               	mov	x0, x25
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	mov	x25, #0x1               // =1
               	str	x25, [x0]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x25, [x25]
               	cmp	x25, #0x9e
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x25, [x0]
               	add	x25, x25, #0x8
               	str	x25, [x0]
               	mov	x23, #0x1               // =1
               	str	x23, [x25]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x80
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x22, [x22]
               	cmp	x22, #0xa2
               	cset	x22, eq
               	stur	x22, [x29, #-0x60]
               	cbnz	x22, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x0, [x23]
               	add	x0, x0, #0x8
               	str	x0, [x23]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c8
               	mov	x25, x19
               	ldr	x25, [x25]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x25, x25, x17
               	str	x25, [x0]
               	bl	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x25, x19
               	mov	x22, #0x1               // =1
               	str	x22, [x25]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x22, x19
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x23, #0xffff            // =65535
               	movk	x23, #0xffff, lsl #16
               	movk	x23, #0xffff, lsl #32
               	movk	x23, #0xffff, lsl #48
               	str	x23, [x0]
               	ldr	x24, [x22]
               	add	x24, x24, #0x8
               	str	x24, [x22]
               	mov	x23, #0xd               // =13
               	str	x23, [x24]
               	mov	x25, #0xa2              // =162
               	mov	x0, x25
               	bl	<addr>
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x25, #0x1b              // =27
               	str	x25, [x0]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0xa3
               	cset	x0, eq
               	stur	x0, [x29, #-0x60]
               	b	<addr>
               	ldur	x0, [x29, #-0x60]
               	cbz	x0, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x22, [x22]
               	stur	x22, [x29, #-0x8]
               	bl	<addr>
               	mov	x23, #0xa2              // =162
               	mov	x0, x23
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x0, [x0]
               	ldr	x0, [x0]
               	cmp	x0, #0xa
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x3dc
               	mov	x23, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x24, x19
               	ldr	x24, [x24]
               	mov	x0, x23
               	mov	x1, x24
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x22, #0xffff            // =65535
               	movk	x22, #0xffff, lsl #16
               	movk	x22, #0xffff, lsl #32
               	movk	x22, #0xffff, lsl #48
               	mov	x0, x22
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x0, [x23]
               	mov	x25, #0xd               // =13
               	str	x25, [x0]
               	ldr	x24, [x23]
               	add	x24, x24, #0x8
               	str	x24, [x23]
               	mov	x25, #0xa               // =10
               	str	x25, [x24]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x24, x19
               	ldr	x0, [x24]
               	add	x0, x0, #0x8
               	str	x0, [x24]
               	mov	x22, #0xd               // =13
               	str	x22, [x0]
               	ldr	x25, [x24]
               	add	x25, x25, #0x8
               	str	x25, [x24]
               	mov	x22, #0x1               // =1
               	str	x22, [x25]
               	ldr	x0, [x24]
               	add	x0, x0, #0x8
               	str	x0, [x24]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x22, x19
               	ldr	x22, [x22]
               	cmp	x22, #0x2
               	b.le	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x25, [x25]
               	ldr	x25, [x25]
               	cmp	x25, #0x9
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x25, [x23]
               	mov	x24, #0xd               // =13
               	str	x24, [x25]
               	ldr	x0, [x23]
               	add	x0, x0, #0x8
               	str	x0, [x23]
               	mov	x24, #0x9               // =9
               	str	x24, [x0]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x3bb
               	mov	x22, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x23, x19
               	ldr	x23, [x23]
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x24, #0xffff            // =65535
               	movk	x24, #0xffff, lsl #16
               	movk	x24, #0xffff, lsl #32
               	movk	x24, #0xffff, lsl #48
               	mov	x0, x24
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	mov	x24, #0x8               // =8
               	stur	x24, [x29, #-0x68]
               	b	<addr>
               	mov	x24, #0x1               // =1
               	stur	x24, [x29, #-0x68]
               	b	<addr>
               	ldur	x24, [x29, #-0x68]
               	str	x24, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x22, x19
               	ldr	x24, [x22]
               	add	x24, x24, #0x8
               	str	x24, [x22]
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, #0xa2
               	b.ne	<addr>
               	mov	x22, #0x19              // =25
               	stur	x22, [x29, #-0x70]
               	b	<addr>
               	mov	x22, #0x1a              // =26
               	stur	x22, [x29, #-0x70]
               	b	<addr>
               	ldur	x22, [x29, #-0x70]
               	str	x22, [x24]
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x22, [x0]
               	add	x22, x22, #0x8
               	str	x22, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x24, x19
               	ldr	x24, [x24]
               	cmp	x24, #0x0
               	b.ne	<addr>
               	mov	x0, #0xc                // =12
               	stur	x0, [x29, #-0x78]
               	b	<addr>
               	mov	x0, #0xb                // =11
               	stur	x0, [x29, #-0x78]
               	b	<addr>
               	ldur	x0, [x29, #-0x78]
               	str	x0, [x22]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x22, [x22]
               	cmp	x22, x20
               	b.lt	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	ldr	x0, [x0]
               	stur	x0, [x29, #-0x8]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x22, [x22]
               	cmp	x22, #0x8e
               	b.ne	<addr>
               	b	<addr>
               	mov	x23, #0x0               // =0
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x0, [x0]
               	ldr	x0, [x0]
               	cmp	x0, #0xa
               	cset	x0, eq
               	stur	x0, [x29, #-0x80]
               	cbnz	x0, <addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x25, [x25]
               	cmp	x25, #0x8f
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x22, x19
               	ldr	x22, [x22]
               	ldr	x22, [x22]
               	cmp	x22, #0x9
               	cset	x22, eq
               	stur	x22, [x29, #-0x80]
               	b	<addr>
               	ldur	x22, [x29, #-0x80]
               	cbz	x22, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x0, [x0]
               	mov	x22, #0xd               // =13
               	str	x22, [x0]
               	b	<addr>
               	mov	x23, #0x8e              // =142
               	mov	x0, x23
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x23, [x0]
               	add	x23, x23, #0x8
               	str	x23, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x24, x19
               	ldur	x0, [x29, #-0x8]
               	str	x0, [x24]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x3f0
               	mov	x24, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x23, x19
               	ldr	x23, [x23]
               	mov	x0, x24
               	mov	x1, x23
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x22, #0xffff            // =65535
               	movk	x22, #0xffff, lsl #16
               	movk	x22, #0xffff, lsl #32
               	movk	x22, #0xffff, lsl #48
               	mov	x0, x22
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	mov	x25, #0xc               // =12
               	stur	x25, [x29, #-0x88]
               	b	<addr>
               	mov	x25, #0xb               // =11
               	stur	x25, [x29, #-0x88]
               	b	<addr>
               	ldur	x25, [x29, #-0x88]
               	str	x25, [x23]
               	b	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x25, [x0]
               	add	x25, x25, #0x8
               	str	x25, [x0]
               	mov	x23, #0x4               // =4
               	str	x23, [x25]
               	ldr	x24, [x0]
               	add	x24, x24, #0x8
               	str	x24, [x0]
               	stur	x24, [x29, #-0x10]
               	mov	x22, #0x8e              // =142
               	mov	x0, x22
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x3a
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x23, [x23]
               	cmp	x23, #0x90
               	b.ne	<addr>
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	ldur	x24, [x29, #-0x10]
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x22, [x23]
               	add	x22, x22, #0x18
               	str	x22, [x24]
               	ldr	x25, [x23]
               	add	x25, x25, #0x8
               	str	x25, [x23]
               	mov	x22, #0x2               // =2
               	str	x22, [x25]
               	ldr	x24, [x23]
               	add	x24, x24, #0x8
               	str	x24, [x23]
               	stur	x24, [x29, #-0x10]
               	mov	x26, #0x8f              // =143
               	mov	x0, x26
               	bl	<addr>
               	ldur	x0, [x29, #-0x10]
               	ldr	x23, [x23]
               	add	x23, x23, #0x8
               	str	x23, [x0]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x40e
               	mov	x22, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x23, [x0]
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x24, #0xffff            // =65535
               	movk	x24, #0xffff, lsl #16
               	movk	x24, #0xffff, lsl #32
               	movk	x24, #0xffff, lsl #48
               	mov	x0, x24
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x24, x19
               	ldr	x23, [x24]
               	add	x23, x23, #0x8
               	str	x23, [x24]
               	mov	x26, #0x5               // =5
               	str	x26, [x23]
               	ldr	x25, [x24]
               	add	x25, x25, #0x8
               	str	x25, [x24]
               	stur	x25, [x29, #-0x10]
               	mov	x22, #0x91              // =145
               	mov	x0, x22
               	bl	<addr>
               	ldur	x0, [x29, #-0x10]
               	ldr	x24, [x24]
               	add	x24, x24, #0x8
               	str	x24, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x22, x19
               	mov	x24, #0x1               // =1
               	str	x24, [x22]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x24, [x24]
               	cmp	x24, #0x91
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x24, [x25]
               	add	x24, x24, #0x8
               	str	x24, [x25]
               	mov	x22, #0x4               // =4
               	str	x22, [x24]
               	ldr	x23, [x25]
               	add	x23, x23, #0x8
               	str	x23, [x25]
               	stur	x23, [x29, #-0x10]
               	mov	x26, #0x92              // =146
               	mov	x0, x26
               	bl	<addr>
               	ldur	x0, [x29, #-0x10]
               	ldr	x25, [x25]
               	add	x25, x25, #0x8
               	str	x25, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x26, x19
               	mov	x25, #0x1               // =1
               	str	x25, [x26]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x25, [x25]
               	cmp	x25, #0x92
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x25, [x23]
               	add	x25, x25, #0x8
               	str	x25, [x23]
               	mov	x26, #0xd               // =13
               	str	x26, [x25]
               	mov	x22, #0x93              // =147
               	mov	x0, x22
               	bl	<addr>
               	ldr	x0, [x23]
               	add	x0, x0, #0x8
               	str	x0, [x23]
               	mov	x22, #0xe               // =14
               	str	x22, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x23, x19
               	mov	x22, #0x1               // =1
               	str	x22, [x23]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x22, [x22]
               	cmp	x22, #0x93
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x26, x19
               	ldr	x22, [x26]
               	add	x22, x22, #0x8
               	str	x22, [x26]
               	mov	x23, #0xd               // =13
               	str	x23, [x22]
               	mov	x24, #0x94              // =148
               	mov	x0, x24
               	bl	<addr>
               	ldr	x0, [x26]
               	add	x0, x0, #0x8
               	str	x0, [x26]
               	mov	x24, #0xf               // =15
               	str	x24, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x26, x19
               	mov	x24, #0x1               // =1
               	str	x24, [x26]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x24, [x24]
               	cmp	x24, #0x94
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x24, [x23]
               	add	x24, x24, #0x8
               	str	x24, [x23]
               	mov	x26, #0xd               // =13
               	str	x26, [x24]
               	mov	x25, #0x95              // =149
               	mov	x0, x25
               	bl	<addr>
               	ldr	x0, [x23]
               	add	x0, x0, #0x8
               	str	x0, [x23]
               	mov	x25, #0x10              // =16
               	str	x25, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x23, x19
               	mov	x25, #0x1               // =1
               	str	x25, [x23]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x25, [x25]
               	cmp	x25, #0x95
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x26, x19
               	ldr	x25, [x26]
               	add	x25, x25, #0x8
               	str	x25, [x26]
               	mov	x23, #0xd               // =13
               	str	x23, [x25]
               	mov	x22, #0x97              // =151
               	mov	x0, x22
               	bl	<addr>
               	ldr	x0, [x26]
               	add	x0, x0, #0x8
               	str	x0, [x26]
               	mov	x22, #0x11              // =17
               	str	x22, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x26, x19
               	mov	x22, #0x1               // =1
               	str	x22, [x26]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x22, [x22]
               	cmp	x22, #0x96
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x22, [x23]
               	add	x22, x22, #0x8
               	str	x22, [x23]
               	mov	x26, #0xd               // =13
               	str	x26, [x22]
               	mov	x24, #0x97              // =151
               	mov	x0, x24
               	bl	<addr>
               	ldr	x0, [x23]
               	add	x0, x0, #0x8
               	str	x0, [x23]
               	mov	x24, #0x12              // =18
               	str	x24, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x23, x19
               	mov	x24, #0x1               // =1
               	str	x24, [x23]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x24, [x24]
               	cmp	x24, #0x97
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x26, x19
               	ldr	x24, [x26]
               	add	x24, x24, #0x8
               	str	x24, [x26]
               	mov	x23, #0xd               // =13
               	str	x23, [x24]
               	mov	x25, #0x9b              // =155
               	mov	x0, x25
               	bl	<addr>
               	ldr	x0, [x26]
               	add	x0, x0, #0x8
               	str	x0, [x26]
               	mov	x25, #0x13              // =19
               	str	x25, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x26, x19
               	mov	x25, #0x1               // =1
               	str	x25, [x26]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x25, [x25]
               	cmp	x25, #0x98
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x25, [x23]
               	add	x25, x25, #0x8
               	str	x25, [x23]
               	mov	x26, #0xd               // =13
               	str	x26, [x25]
               	mov	x22, #0x9b              // =155
               	mov	x0, x22
               	bl	<addr>
               	ldr	x0, [x23]
               	add	x0, x0, #0x8
               	str	x0, [x23]
               	mov	x22, #0x14              // =20
               	str	x22, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x23, x19
               	mov	x22, #0x1               // =1
               	str	x22, [x23]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x22, [x22]
               	cmp	x22, #0x99
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x26, x19
               	ldr	x22, [x26]
               	add	x22, x22, #0x8
               	str	x22, [x26]
               	mov	x23, #0xd               // =13
               	str	x23, [x22]
               	mov	x24, #0x9b              // =155
               	mov	x0, x24
               	bl	<addr>
               	ldr	x0, [x26]
               	add	x0, x0, #0x8
               	str	x0, [x26]
               	mov	x24, #0x15              // =21
               	str	x24, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x26, x19
               	mov	x24, #0x1               // =1
               	str	x24, [x26]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x24, [x24]
               	cmp	x24, #0x9a
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x24, [x23]
               	add	x24, x24, #0x8
               	str	x24, [x23]
               	mov	x26, #0xd               // =13
               	str	x26, [x24]
               	mov	x25, #0x9b              // =155
               	mov	x0, x25
               	bl	<addr>
               	ldr	x0, [x23]
               	add	x0, x0, #0x8
               	str	x0, [x23]
               	mov	x25, #0x16              // =22
               	str	x25, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x23, x19
               	mov	x25, #0x1               // =1
               	str	x25, [x23]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x25, [x25]
               	cmp	x25, #0x9b
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x26, x19
               	ldr	x25, [x26]
               	add	x25, x25, #0x8
               	str	x25, [x26]
               	mov	x23, #0xd               // =13
               	str	x23, [x25]
               	mov	x22, #0x9d              // =157
               	mov	x0, x22
               	bl	<addr>
               	ldr	x0, [x26]
               	add	x0, x0, #0x8
               	str	x0, [x26]
               	mov	x22, #0x17              // =23
               	str	x22, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x26, x19
               	mov	x22, #0x1               // =1
               	str	x22, [x26]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x22, [x22]
               	cmp	x22, #0x9c
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x22, [x23]
               	add	x22, x22, #0x8
               	str	x22, [x23]
               	mov	x26, #0xd               // =13
               	str	x26, [x22]
               	mov	x24, #0x9d              // =157
               	mov	x0, x24
               	bl	<addr>
               	ldr	x0, [x23]
               	add	x0, x0, #0x8
               	str	x0, [x23]
               	mov	x24, #0x18              // =24
               	str	x24, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x23, x19
               	mov	x24, #0x1               // =1
               	str	x24, [x23]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x24, [x24]
               	cmp	x24, #0x9d
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x24, [x0]
               	add	x24, x24, #0x8
               	str	x24, [x0]
               	mov	x23, #0xd               // =13
               	str	x23, [x24]
               	mov	x26, #0x9f              // =159
               	mov	x0, x26
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	ldur	x26, [x29, #-0x8]
               	str	x26, [x0]
               	cmp	x26, #0x2
               	b.le	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x22, [x22]
               	cmp	x22, #0x9e
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x24, x19
               	ldr	x26, [x24]
               	add	x26, x26, #0x8
               	str	x26, [x24]
               	mov	x0, #0xd                // =13
               	str	x0, [x26]
               	ldr	x22, [x24]
               	add	x22, x22, #0x8
               	str	x22, [x24]
               	mov	x0, #0x1                // =1
               	str	x0, [x22]
               	ldr	x26, [x24]
               	add	x26, x26, #0x8
               	str	x26, [x24]
               	mov	x0, #0x8                // =8
               	str	x0, [x26]
               	ldr	x22, [x24]
               	add	x22, x22, #0x8
               	str	x22, [x24]
               	mov	x0, #0x1b               // =27
               	str	x0, [x22]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x24, [x0]
               	add	x24, x24, #0x8
               	str	x24, [x0]
               	mov	x22, #0x19              // =25
               	str	x22, [x24]
               	b	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x22, [x0]
               	add	x22, x22, #0x8
               	str	x22, [x0]
               	mov	x24, #0xd               // =13
               	str	x24, [x22]
               	mov	x23, #0x9f              // =159
               	mov	x0, x23
               	bl	<addr>
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, #0x2
               	cset	x0, gt
               	stur	x0, [x29, #-0x90]
               	cbz	x0, <addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x23, [x23]
               	cmp	x23, #0x9f
               	b.ne	<addr>
               	b	<addr>
               	ldur	x23, [x29, #-0x8]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x23, x0
               	cset	x23, eq
               	stur	x23, [x29, #-0x90]
               	b	<addr>
               	ldur	x23, [x29, #-0x90]
               	cbz	x23, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x23, [x0]
               	add	x23, x23, #0x8
               	str	x23, [x0]
               	mov	x22, #0x1a              // =26
               	str	x22, [x23]
               	ldr	x26, [x0]
               	add	x26, x26, #0x8
               	str	x26, [x0]
               	mov	x22, #0xd               // =13
               	str	x22, [x26]
               	ldr	x23, [x0]
               	add	x23, x23, #0x8
               	str	x23, [x0]
               	mov	x22, #0x1               // =1
               	str	x22, [x23]
               	ldr	x26, [x0]
               	add	x26, x26, #0x8
               	str	x26, [x0]
               	mov	x23, #0x8               // =8
               	str	x23, [x26]
               	ldr	x21, [x0]
               	add	x21, x21, #0x8
               	str	x21, [x0]
               	mov	x23, #0x1c              // =28
               	str	x23, [x21]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	str	x22, [x0]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	ldur	x23, [x29, #-0x8]
               	str	x23, [x0]
               	cmp	x23, #0x2
               	b.le	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x22, x19
               	ldr	x23, [x22]
               	add	x23, x23, #0x8
               	str	x23, [x22]
               	mov	x0, #0xd                // =13
               	str	x0, [x23]
               	ldr	x21, [x22]
               	add	x21, x21, #0x8
               	str	x21, [x22]
               	mov	x0, #0x1                // =1
               	str	x0, [x21]
               	ldr	x23, [x22]
               	add	x23, x23, #0x8
               	str	x23, [x22]
               	mov	x0, #0x8                // =8
               	str	x0, [x23]
               	ldr	x21, [x22]
               	add	x21, x21, #0x8
               	str	x21, [x22]
               	mov	x0, #0x1b               // =27
               	str	x0, [x21]
               	ldr	x23, [x22]
               	add	x23, x23, #0x8
               	str	x23, [x22]
               	mov	x0, #0x1a               // =26
               	str	x0, [x23]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x22, [x0]
               	add	x22, x22, #0x8
               	str	x22, [x0]
               	mov	x23, #0x1a              // =26
               	str	x23, [x22]
               	b	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x24, x19
               	ldr	x23, [x24]
               	add	x23, x23, #0x8
               	str	x23, [x24]
               	mov	x22, #0xd               // =13
               	str	x22, [x23]
               	mov	x25, #0xa2              // =162
               	mov	x0, x25
               	bl	<addr>
               	ldr	x0, [x24]
               	add	x0, x0, #0x8
               	str	x0, [x24]
               	mov	x25, #0x1b              // =27
               	str	x25, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x24, x19
               	mov	x25, #0x1               // =1
               	str	x25, [x24]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x25, [x25]
               	cmp	x25, #0xa0
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x22, x19
               	ldr	x25, [x22]
               	add	x25, x25, #0x8
               	str	x25, [x22]
               	mov	x24, #0xd               // =13
               	str	x24, [x25]
               	mov	x21, #0xa2              // =162
               	mov	x0, x21
               	bl	<addr>
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x21, #0x1c              // =28
               	str	x21, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x22, x19
               	mov	x21, #0x1               // =1
               	str	x21, [x22]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x21, [x21]
               	cmp	x21, #0xa1
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x24, x19
               	ldr	x21, [x24]
               	add	x21, x21, #0x8
               	str	x21, [x24]
               	mov	x22, #0xd               // =13
               	str	x22, [x21]
               	mov	x23, #0xa2              // =162
               	mov	x0, x23
               	bl	<addr>
               	ldr	x0, [x24]
               	add	x0, x0, #0x8
               	str	x0, [x24]
               	mov	x23, #0x1d              // =29
               	str	x23, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x24, x19
               	mov	x23, #0x1               // =1
               	str	x23, [x24]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x23, [x23]
               	cmp	x23, #0xa2
               	cset	x23, eq
               	stur	x23, [x29, #-0x98]
               	cbnz	x23, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0xa3
               	cset	x0, eq
               	stur	x0, [x29, #-0x98]
               	b	<addr>
               	ldur	x0, [x29, #-0x98]
               	cbz	x0, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x23, [x23]
               	ldr	x23, [x23]
               	cmp	x23, #0xa
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x22, [x22]
               	cmp	x22, #0xa4
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x23, [x0]
               	mov	x24, #0xd               // =13
               	str	x24, [x23]
               	ldr	x21, [x0]
               	add	x21, x21, #0x8
               	str	x21, [x0]
               	mov	x24, #0xa               // =10
               	str	x24, [x21]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x0, [x23]
               	add	x0, x0, #0x8
               	str	x0, [x23]
               	mov	x22, #0xd               // =13
               	str	x22, [x0]
               	ldr	x24, [x23]
               	add	x24, x24, #0x8
               	str	x24, [x23]
               	mov	x22, #0x1               // =1
               	str	x22, [x24]
               	ldr	x0, [x23]
               	add	x0, x0, #0x8
               	str	x0, [x23]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x22, x19
               	ldr	x22, [x22]
               	cmp	x22, #0x2
               	b.le	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x24, x19
               	ldr	x24, [x24]
               	ldr	x24, [x24]
               	cmp	x24, #0x9
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x24, [x0]
               	mov	x21, #0xd               // =13
               	str	x21, [x24]
               	ldr	x23, [x0]
               	add	x23, x23, #0x8
               	str	x23, [x0]
               	mov	x21, #0x9               // =9
               	str	x21, [x23]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x42d
               	mov	x22, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x21, [x0]
               	mov	x0, x22
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x23, #0xffff            // =65535
               	movk	x23, #0xffff, lsl #16
               	movk	x23, #0xffff, lsl #32
               	movk	x23, #0xffff, lsl #48
               	mov	x0, x23
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	mov	x23, #0x8               // =8
               	stur	x23, [x29, #-0xa0]
               	b	<addr>
               	mov	x23, #0x1               // =1
               	stur	x23, [x29, #-0xa0]
               	b	<addr>
               	ldur	x23, [x29, #-0xa0]
               	str	x23, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x22, x19
               	ldr	x23, [x22]
               	add	x23, x23, #0x8
               	str	x23, [x22]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0xa2
               	b.ne	<addr>
               	mov	x22, #0x19              // =25
               	stur	x22, [x29, #-0xa8]
               	b	<addr>
               	mov	x22, #0x1a              // =26
               	stur	x22, [x29, #-0xa8]
               	b	<addr>
               	ldur	x22, [x29, #-0xa8]
               	str	x22, [x23]
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x22, [x0]
               	add	x22, x22, #0x8
               	str	x22, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x23, x19
               	ldr	x23, [x23]
               	cmp	x23, #0x0
               	b.ne	<addr>
               	mov	x0, #0xc                // =12
               	stur	x0, [x29, #-0xb0]
               	b	<addr>
               	mov	x0, #0xb                // =11
               	stur	x0, [x29, #-0xb0]
               	b	<addr>
               	ldur	x0, [x29, #-0xb0]
               	str	x0, [x22]
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x0, [x23]
               	add	x0, x0, #0x8
               	str	x0, [x23]
               	mov	x22, #0xd               // =13
               	str	x22, [x0]
               	ldr	x24, [x23]
               	add	x24, x24, #0x8
               	str	x24, [x23]
               	mov	x22, #0x1               // =1
               	str	x22, [x24]
               	ldr	x0, [x23]
               	add	x0, x0, #0x8
               	str	x0, [x23]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x22, x19
               	ldr	x22, [x22]
               	cmp	x22, #0x2
               	b.le	<addr>
               	mov	x23, #0x8               // =8
               	stur	x23, [x29, #-0xb8]
               	b	<addr>
               	mov	x23, #0x1               // =1
               	stur	x23, [x29, #-0xb8]
               	b	<addr>
               	ldur	x23, [x29, #-0xb8]
               	str	x23, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x22, x19
               	ldr	x23, [x22]
               	add	x23, x23, #0x8
               	str	x23, [x22]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0xa2
               	b.ne	<addr>
               	mov	x22, #0x1a              // =26
               	stur	x22, [x29, #-0xc0]
               	b	<addr>
               	mov	x22, #0x19              // =25
               	stur	x22, [x29, #-0xc0]
               	b	<addr>
               	ldur	x22, [x29, #-0xc0]
               	str	x22, [x23]
               	bl	<addr>
               	b	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x22, [x0]
               	add	x22, x22, #0x8
               	str	x22, [x0]
               	mov	x23, #0xd               // =13
               	str	x23, [x22]
               	mov	x21, #0x8e              // =142
               	mov	x0, x21
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x5d
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x486
               	mov	x21, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x24, x19
               	ldr	x24, [x24]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x22, [x22]
               	mov	x0, x21
               	mov	x2, x22
               	mov	x1, x24
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x23, #0xffff            // =65535
               	movk	x23, #0xffff, lsl #16
               	movk	x23, #0xffff, lsl #32
               	movk	x23, #0xffff, lsl #48
               	mov	x0, x23
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	ldur	x22, [x29, #-0x8]
               	cmp	x22, #0x2
               	b.le	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x44f
               	mov	x21, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x23, [x0]
               	mov	x0, x21
               	mov	x1, x23
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x22, #0xffff            // =65535
               	movk	x22, #0xffff, lsl #16
               	movk	x22, #0xffff, lsl #32
               	movk	x22, #0xffff, lsl #48
               	mov	x0, x22
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x22, [x0]
               	add	x22, x22, #0x8
               	str	x22, [x0]
               	mov	x21, #0xd               // =13
               	str	x21, [x22]
               	ldr	x24, [x0]
               	add	x24, x24, #0x8
               	str	x24, [x0]
               	mov	x21, #0x1               // =1
               	str	x21, [x24]
               	ldr	x22, [x0]
               	add	x22, x22, #0x8
               	str	x22, [x0]
               	mov	x21, #0x8               // =8
               	str	x21, [x22]
               	ldr	x24, [x0]
               	add	x24, x24, #0x8
               	str	x24, [x0]
               	mov	x21, #0x1b              // =27
               	str	x21, [x24]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x24, x19
               	ldr	x0, [x24]
               	add	x0, x0, #0x8
               	str	x0, [x24]
               	mov	x23, #0x19              // =25
               	str	x23, [x0]
               	ldr	x22, [x24]
               	add	x22, x22, #0x8
               	str	x22, [x24]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x23, x19
               	ldur	x24, [x29, #-0x8]
               	sub	x24, x24, #0x2
               	str	x24, [x23]
               	cmp	x24, #0x0
               	b.ne	<addr>
               	b	<addr>
               	ldur	x21, [x29, #-0x8]
               	cmp	x21, #0x2
               	b.ge	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x46b
               	mov	x23, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x21, x19
               	ldr	x21, [x21]
               	mov	x0, x23
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x24, #0xffff            // =65535
               	movk	x24, #0xffff, lsl #16
               	movk	x24, #0xffff, lsl #32
               	movk	x24, #0xffff, lsl #48
               	mov	x0, x24
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x0, #0xa                // =10
               	stur	x0, [x29, #-0xc8]
               	b	<addr>
               	mov	x0, #0x9                // =9
               	stur	x0, [x29, #-0xc8]
               	b	<addr>
               	ldur	x0, [x29, #-0xc8]
               	str	x0, [x22]
               	b	<addr>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x19, [sp, #0x20]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x15, x19
               	ldr	x15, [x15]
               	cmp	x15, #0x89
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x28
               	b.ne	<addr>
               	b	<addr>
               	mov	x23, #0x0               // =0
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x8d
               	b.ne	<addr>
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	mov	x21, #0x8e              // =142
               	mov	x0, x21
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x29
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x4a0
               	mov	x20, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x21, [x0]
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x22, #0xffff            // =65535
               	movk	x22, #0xffff, lsl #16
               	movk	x22, #0xffff, lsl #32
               	movk	x22, #0xffff, lsl #48
               	mov	x0, x22
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x20, x19
               	ldr	x0, [x20]
               	add	x0, x0, #0x8
               	str	x0, [x20]
               	mov	x21, #0x4               // =4
               	str	x21, [x0]
               	ldr	x12, [x20]
               	add	x12, x12, #0x8
               	str	x12, [x20]
               	stur	x12, [x29, #-0x10]
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x87
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x4b9
               	mov	x21, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x22, [x0]
               	mov	x0, x21
               	mov	x1, x22
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0xffff            // =65535
               	movk	x20, #0xffff, lsl #16
               	movk	x20, #0xffff, lsl #32
               	movk	x20, #0xffff, lsl #48
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	ldur	x12, [x29, #-0x10]
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x20, [x0]
               	add	x20, x20, #0x18
               	str	x20, [x12]
               	ldr	x21, [x0]
               	add	x21, x21, #0x8
               	str	x21, [x0]
               	mov	x20, #0x2               // =2
               	str	x20, [x21]
               	ldr	x12, [x0]
               	add	x12, x12, #0x8
               	str	x12, [x0]
               	stur	x12, [x29, #-0x10]
               	bl	<addr>
               	bl	<addr>
               	b	<addr>
               	ldur	x12, [x29, #-0x10]
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x0, [x0]
               	add	x0, x0, #0x8
               	str	x0, [x12]
               	b	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x0, [x0]
               	add	x0, x0, #0x8
               	stur	x0, [x29, #-0x8]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x22, [x22]
               	cmp	x22, #0x28
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x23, [x23]
               	cmp	x23, #0x8b
               	b.ne	<addr>
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	mov	x22, #0x8e              // =142
               	mov	x0, x22
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x29
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x4d3
               	mov	x20, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x22, [x0]
               	mov	x0, x20
               	mov	x1, x22
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x23, #0xffff            // =65535
               	movk	x23, #0xffff, lsl #16
               	movk	x23, #0xffff, lsl #32
               	movk	x23, #0xffff, lsl #48
               	mov	x0, x23
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x0, [x23]
               	add	x0, x0, #0x8
               	str	x0, [x23]
               	mov	x22, #0x4               // =4
               	str	x22, [x0]
               	ldr	x21, [x23]
               	add	x21, x21, #0x8
               	str	x21, [x23]
               	stur	x21, [x29, #-0x10]
               	bl	<addr>
               	ldr	x0, [x23]
               	add	x0, x0, #0x8
               	str	x0, [x23]
               	mov	x21, #0x2               // =2
               	str	x21, [x0]
               	ldr	x22, [x23]
               	add	x22, x22, #0x8
               	str	x22, [x23]
               	ldur	x21, [x29, #-0x8]
               	str	x21, [x22]
               	ldur	x0, [x29, #-0x10]
               	ldr	x23, [x23]
               	add	x23, x23, #0x8
               	str	x23, [x0]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x4ec
               	mov	x22, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x23, [x0]
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0xffff            // =65535
               	movk	x20, #0xffff, lsl #16
               	movk	x20, #0xffff, lsl #32
               	movk	x20, #0xffff, lsl #48
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x3b
               	b.eq	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x21, [x21]
               	cmp	x21, #0x7b
               	b.ne	<addr>
               	b	<addr>
               	mov	x20, #0x8e              // =142
               	mov	x0, x20
               	bl	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x20, x19
               	ldr	x0, [x20]
               	add	x0, x0, #0x8
               	str	x0, [x20]
               	mov	x21, #0x8               // =8
               	str	x21, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	ldr	x20, [x20]
               	cmp	x20, #0x3b
               	b.ne	<addr>
               	bl	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x506
               	mov	x23, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x20, [x0]
               	mov	x0, x23
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x21, #0xffff            // =65535
               	movk	x21, #0xffff, lsl #16
               	movk	x21, #0xffff, lsl #32
               	movk	x21, #0xffff, lsl #48
               	mov	x0, x21
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	ldr	x20, [x20]
               	cmp	x20, #0x3b
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x21, [x21]
               	cmp	x21, #0x7d
               	b.eq	<addr>
               	bl	<addr>
               	mov	x20, x0
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x21, #0x8e              // =142
               	mov	x0, x21
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x3b
               	b.ne	<addr>
               	bl	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x51e
               	mov	x21, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x20, [x0]
               	mov	x0, x21
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x23, #0xffff            // =65535
               	movk	x23, #0xffff, lsl #16
               	movk	x23, #0xffff, lsl #32
               	movk	x23, #0xffff, lsl #48
               	mov	x0, x23
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	str	x1, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x130
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x26, [sp, #0x30]
               	str	x27, [sp, #0x38]
               	str	x19, [sp, #0x40]
               	mov	x15, x0
               	stur	x15, [x29, #0x10]
               	mov	x14, x1
               	stur	x14, [x29, #0x20]
               	add	x15, x29, #0x10
               	ldr	x14, [x15]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x14, x14, x17
               	str	x14, [x15]
               	add	x13, x29, #0x20
               	ldr	x14, [x13]
               	add	x14, x14, #0x8
               	str	x14, [x13]
               	ldur	x15, [x29, #0x10]
               	cmp	x15, #0x0
               	cset	x15, gt
               	stur	x15, [x29, #-0xa0]
               	cbz	x15, <addr>
               	ldur	x14, [x29, #0x20]
               	ldr	x14, [x14]
               	ldrb	w14, [x14]
               	mov	x17, #0x2d              // =45
               	eor	x14, x14, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x14, x17
               	cmp	x14, #0x0
               	cset	x14, eq
               	stur	x14, [x29, #-0xa0]
               	b	<addr>
               	ldur	x14, [x29, #-0xa0]
               	stur	x14, [x29, #-0x98]
               	cbz	x14, <addr>
               	ldur	x15, [x29, #0x20]
               	ldr	x15, [x15]
               	add	x15, x15, #0x1
               	ldrb	w15, [x15]
               	mov	x17, #0x73              // =115
               	eor	x15, x15, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x15, x17
               	cmp	x15, #0x0
               	cset	x15, eq
               	stur	x15, [x29, #-0x98]
               	b	<addr>
               	ldur	x15, [x29, #-0x98]
               	cbz	x15, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1e8
               	mov	x14, x19
               	mov	x15, #0x1               // =1
               	str	x15, [x14]
               	add	x13, x29, #0x10
               	ldr	x15, [x13]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x15, x15, x17
               	str	x15, [x13]
               	add	x14, x29, #0x20
               	ldr	x15, [x14]
               	add	x15, x15, #0x8
               	str	x15, [x14]
               	b	<addr>
               	ldur	x15, [x29, #0x10]
               	cmp	x15, #0x0
               	cset	x15, gt
               	stur	x15, [x29, #-0xb0]
               	cbz	x15, <addr>
               	ldur	x13, [x29, #0x20]
               	ldr	x13, [x13]
               	ldrb	w13, [x13]
               	mov	x17, #0x2d              // =45
               	eor	x13, x13, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x13, x17
               	cmp	x13, #0x0
               	cset	x13, eq
               	stur	x13, [x29, #-0xb0]
               	b	<addr>
               	ldur	x13, [x29, #-0xb0]
               	stur	x13, [x29, #-0xa8]
               	cbz	x13, <addr>
               	ldur	x15, [x29, #0x20]
               	ldr	x15, [x15]
               	add	x15, x15, #0x1
               	ldrb	w15, [x15]
               	mov	x17, #0x64              // =100
               	eor	x15, x15, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x15, x17
               	cmp	x15, #0x0
               	cset	x15, eq
               	stur	x15, [x29, #-0xa8]
               	b	<addr>
               	ldur	x15, [x29, #-0xa8]
               	cbz	x15, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1f0
               	mov	x13, x19
               	mov	x15, #0x1               // =1
               	str	x15, [x13]
               	add	x14, x29, #0x10
               	ldr	x15, [x14]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x15, x15, x17
               	str	x15, [x14]
               	add	x13, x29, #0x20
               	ldr	x15, [x13]
               	add	x15, x15, #0x8
               	str	x15, [x13]
               	b	<addr>
               	ldur	x15, [x29, #0x10]
               	cmp	x15, #0x1
               	b.ge	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x536
               	mov	x20, x19
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	ldur	x20, [x29, #0x20]
               	ldr	x20, [x20]
               	mov	x21, #0x0               // =0
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x22, x0
               	cmp	x22, #0x0
               	b.ge	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x554
               	mov	x23, x19
               	ldur	x21, [x29, #0x20]
               	ldr	x21, [x21]
               	mov	x0, x23
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	mov	x21, #0x40000           // =262144
               	sxtw	x21, w21
               	adrp	x19, <page>
               	add	x19, x19, #0x1b8
               	mov	x20, x19
               	mov	x0, x21
               	bl	<addr>
               	str	x0, [x20]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x568
               	mov	x23, x19
               	mov	x0, x23
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x1a8
               	mov	x24, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	mov	x0, x21
               	bl	<addr>
               	str	x0, [x23]
               	str	x0, [x24]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x58a
               	mov	x20, x19
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x198
               	mov	x25, x19
               	mov	x0, x21
               	bl	<addr>
               	str	x0, [x25]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x5aa
               	mov	x20, x19
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	mov	x0, x21
               	bl	<addr>
               	stur	x0, [x29, #-0x38]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x5ca
               	mov	x24, x19
               	mov	x0, x24
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x1b8
               	mov	x24, x19
               	ldr	x24, [x24]
               	mov	x20, #0x0               // =0
               	mov	x0, x24
               	mov	x2, x21
               	mov	x1, x20
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x25, [x0]
               	mov	x0, x25
               	mov	x2, x21
               	mov	x1, x20
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x198
               	mov	x0, x19
               	ldr	x24, [x0]
               	mov	x0, x24
               	mov	x2, x21
               	mov	x1, x20
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x0, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x5eb
               	mov	x24, x19
               	str	x24, [x0]
               	mov	x20, #0x86              // =134
               	stur	x20, [x29, #-0x58]
               	b	<addr>
               	ldur	x20, [x29, #-0x58]
               	cmp	x20, #0x8d
               	b.gt	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x0, x19
               	ldr	x0, [x0]
               	sub	x20, x29, #0x58
               	ldr	x24, [x20]
               	add	x23, x24, #0x1
               	str	x23, [x20]
               	str	x24, [x0]
               	b	<addr>
               	mov	x24, #0x1e              // =30
               	stur	x24, [x29, #-0x58]
               	b	<addr>
               	ldur	x24, [x29, #-0x58]
               	cmp	x24, #0x26
               	b.gt	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x0, x19
               	ldr	x24, [x0]
               	add	x24, x24, #0x18
               	mov	x9, #0x82               // =130
               	str	x9, [x24]
               	ldr	x23, [x0]
               	add	x23, x23, #0x20
               	mov	x9, #0x1                // =1
               	str	x9, [x23]
               	ldr	x0, [x0]
               	add	x0, x0, #0x28
               	sub	x24, x29, #0x58
               	ldr	x9, [x24]
               	add	x23, x9, #0x1
               	str	x23, [x24]
               	str	x9, [x0]
               	b	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x20, x19
               	ldr	x25, [x20]
               	mov	x9, #0x86               // =134
               	str	x9, [x25]
               	bl	<addr>
               	ldr	x20, [x20]
               	adrp	x19, <page>
               	add	x19, x19, #0x190
               	mov	x23, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x26, x19
               	mov	x0, x21
               	bl	<addr>
               	str	x0, [x26]
               	str	x0, [x23]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x655
               	mov	x25, x19
               	mov	x0, x25
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x25, x19
               	ldr	x25, [x25]
               	sub	x24, x21, #0x1
               	mov	x0, x22
               	mov	x2, x24
               	mov	x1, x25
               	bl	<addr>
               	sxtw	x0, w0
               	stur	x0, [x29, #-0x58]
               	cmp	x0, #0x0
               	b.gt	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x677
               	mov	x23, x19
               	ldur	x24, [x29, #-0x58]
               	mov	x0, x23
               	mov	x1, x24
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x24, x19
               	ldr	x24, [x24]
               	ldur	x0, [x29, #-0x58]
               	add	x24, x24, x0
               	mov	x0, #0x0                // =0
               	strb	w0, [x24]
               	mov	x0, x22
               	bl	<addr>
               	sxtw	x0, w0
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	mov	x22, #0x1               // =1
               	str	x22, [x0]
               	bl	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x22, [x22]
               	cbz	x22, <addr>
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0x10]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x22, [x22]
               	cmp	x22, #0x8a
               	b.ne	<addr>
               	b	<addr>
               	add	x20, x20, #0x28
               	ldr	x20, [x20]
               	stur	x20, [x29, #-0x30]
               	cmp	x20, #0x0
               	b.ne	<addr>
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x22, [x22]
               	cmp	x22, #0x86
               	b.ne	<addr>
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x10]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x88
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x7b
               	b.eq	<addr>
               	b	<addr>
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x22, [x22]
               	cmp	x22, #0x7b
               	b.ne	<addr>
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x58]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x7d
               	b.eq	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x22, [x22]
               	cmp	x22, #0x85
               	b.eq	<addr>
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x68b
               	mov	x25, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x22, x19
               	ldr	x22, [x22]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x23, [x23]
               	mov	x0, x25
               	mov	x2, x23
               	mov	x1, x22
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x24, #0xffff            // =65535
               	movk	x24, #0xffff, lsl #16
               	movk	x24, #0xffff, lsl #32
               	movk	x24, #0xffff, lsl #48
               	mov	x0, x24
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x8e
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x80
               	b.eq	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x23, x19
               	ldr	x0, [x23]
               	add	x0, x0, #0x18
               	mov	x24, #0x80              // =128
               	str	x24, [x0]
               	ldr	x25, [x23]
               	add	x25, x25, #0x20
               	mov	x24, #0x1               // =1
               	str	x24, [x25]
               	ldr	x23, [x23]
               	add	x23, x23, #0x28
               	sub	x0, x29, #0x58
               	ldr	x24, [x0]
               	add	x25, x24, #0x1
               	str	x25, [x0]
               	str	x24, [x23]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x26, [x26]
               	cmp	x26, #0x2c
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x6a7
               	mov	x24, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x23, [x0]
               	mov	x0, x24
               	mov	x1, x23
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x1c8
               	mov	x23, x19
               	ldr	x23, [x23]
               	stur	x23, [x29, #-0x58]
               	bl	<addr>
               	b	<addr>
               	bl	<addr>
               	mov	x22, x0
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x22, [x22]
               	cmp	x22, #0x3b
               	cset	x22, ne
               	stur	x22, [x29, #-0xb8]
               	cbz	x22, <addr>
               	b	<addr>
               	ldur	x22, [x29, #-0x10]
               	stur	x22, [x29, #-0x18]
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x7d
               	cset	x0, ne
               	stur	x0, [x29, #-0xb8]
               	b	<addr>
               	ldur	x0, [x29, #-0xb8]
               	cbz	x0, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x22, [x22]
               	cmp	x22, #0x9f
               	b.ne	<addr>
               	bl	<addr>
               	ldur	x0, [x29, #-0x18]
               	add	x0, x0, #0x2
               	stur	x0, [x29, #-0x18]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x85
               	b.eq	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x6c1
               	mov	x24, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x22, [x0]
               	mov	x0, x24
               	mov	x1, x22
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x22, x19
               	ldr	x22, [x22]
               	add	x22, x22, #0x18
               	ldr	x22, [x22]
               	cbz	x22, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x6dd
               	mov	x23, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x22, x19
               	ldr	x22, [x22]
               	mov	x0, x23
               	mov	x1, x22
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x24, #0xffff            // =65535
               	movk	x24, #0xffff, lsl #16
               	movk	x24, #0xffff, lsl #32
               	movk	x24, #0xffff, lsl #48
               	mov	x0, x24
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x0, x19
               	ldr	x0, [x0]
               	add	x0, x0, #0x20
               	ldur	x24, [x29, #-0x18]
               	str	x24, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x23, [x23]
               	cmp	x23, #0x28
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x24, x19
               	ldr	x23, [x24]
               	add	x23, x23, #0x18
               	mov	x0, #0x81               // =129
               	str	x0, [x23]
               	ldr	x24, [x24]
               	add	x24, x24, #0x28
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x25, [x25]
               	add	x25, x25, #0x8
               	str	x25, [x24]
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x58]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x2c
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x25, x19
               	ldr	x0, [x25]
               	add	x0, x0, #0x18
               	mov	x26, #0x83              // =131
               	str	x26, [x0]
               	ldr	x25, [x25]
               	add	x25, x25, #0x28
               	adrp	x19, <page>
               	add	x19, x19, #0x198
               	mov	x24, x19
               	ldr	x26, [x24]
               	str	x26, [x25]
               	ldr	x0, [x24]
               	add	x0, x0, #0x8
               	str	x0, [x24]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x29
               	b.eq	<addr>
               	mov	x25, #0x1               // =1
               	stur	x25, [x29, #-0x18]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x8a
               	b.ne	<addr>
               	b	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x7b
               	b.eq	<addr>
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x22, [x22]
               	cmp	x22, #0x86
               	b.ne	<addr>
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x18]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x9f
               	b.ne	<addr>
               	bl	<addr>
               	ldur	x0, [x29, #-0x18]
               	add	x0, x0, #0x2
               	stur	x0, [x29, #-0x18]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x85
               	b.eq	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x6fe
               	mov	x22, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x25, [x0]
               	mov	x0, x22
               	mov	x1, x25
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x25, x19
               	ldr	x25, [x25]
               	add	x25, x25, #0x18
               	ldr	x25, [x25]
               	cmp	x25, #0x84
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x71d
               	mov	x24, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x25, x19
               	ldr	x25, [x25]
               	mov	x0, x24
               	mov	x1, x25
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x25, x19
               	ldr	x0, [x25]
               	add	x0, x0, #0x30
               	ldr	x24, [x25]
               	add	x24, x24, #0x18
               	ldr	x24, [x24]
               	str	x24, [x0]
               	ldr	x23, [x25]
               	add	x23, x23, #0x18
               	mov	x24, #0x84              // =132
               	str	x24, [x23]
               	ldr	x0, [x25]
               	add	x0, x0, #0x38
               	ldr	x24, [x25]
               	add	x24, x24, #0x20
               	ldr	x24, [x24]
               	str	x24, [x0]
               	ldr	x23, [x25]
               	add	x23, x23, #0x20
               	ldur	x24, [x29, #-0x18]
               	str	x24, [x23]
               	ldr	x0, [x25]
               	add	x0, x0, #0x40
               	ldr	x24, [x25]
               	add	x24, x24, #0x28
               	ldr	x24, [x24]
               	str	x24, [x0]
               	ldr	x25, [x25]
               	add	x25, x25, #0x28
               	sub	x23, x29, #0x58
               	ldr	x24, [x23]
               	add	x0, x24, #0x1
               	str	x0, [x23]
               	str	x24, [x25]
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x2c
               	b.ne	<addr>
               	bl	<addr>
               	mov	x24, x0
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x741
               	mov	x22, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x24, [x0]
               	mov	x0, x22
               	mov	x1, x24
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x1d8
               	mov	x24, x19
               	sub	x0, x29, #0x58
               	ldr	x22, [x0]
               	add	x22, x22, #0x1
               	str	x22, [x0]
               	str	x22, [x24]
               	bl	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x22, [x22]
               	cmp	x22, #0x8a
               	cset	x22, eq
               	stur	x22, [x29, #-0xc0]
               	cbnz	x22, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x22, [x22]
               	cmp	x22, #0x8a
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x24, x19
               	ldr	x0, [x24]
               	add	x0, x0, #0x8
               	str	x0, [x24]
               	mov	x25, #0x6               // =6
               	str	x25, [x0]
               	ldr	x26, [x24]
               	add	x26, x26, #0x8
               	str	x26, [x24]
               	ldur	x25, [x29, #-0x58]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d8
               	mov	x24, x19
               	ldr	x24, [x24]
               	sub	x25, x25, x24
               	str	x25, [x26]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x86
               	cset	x0, eq
               	stur	x0, [x29, #-0xc0]
               	b	<addr>
               	ldur	x0, [x29, #-0xc0]
               	cbz	x0, <addr>
               	b	<addr>
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0xc8]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0xc8]
               	b	<addr>
               	ldur	x0, [x29, #-0xc8]
               	stur	x0, [x29, #-0x10]
               	bl	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x22, [x22]
               	cmp	x22, #0x3b
               	b.eq	<addr>
               	ldur	x0, [x29, #-0x10]
               	stur	x0, [x29, #-0x18]
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x9f
               	b.ne	<addr>
               	bl	<addr>
               	ldur	x0, [x29, #-0x18]
               	add	x0, x0, #0x2
               	stur	x0, [x29, #-0x18]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x85
               	b.eq	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x75e
               	mov	x22, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x25, [x0]
               	mov	x0, x22
               	mov	x1, x25
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x25, x19
               	ldr	x25, [x25]
               	add	x25, x25, #0x18
               	ldr	x25, [x25]
               	cmp	x25, #0x84
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x779
               	mov	x24, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x25, x19
               	ldr	x25, [x25]
               	mov	x0, x24
               	mov	x1, x25
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x25, x19
               	ldr	x0, [x25]
               	add	x0, x0, #0x30
               	ldr	x24, [x25]
               	add	x24, x24, #0x18
               	ldr	x24, [x24]
               	str	x24, [x0]
               	ldr	x26, [x25]
               	add	x26, x26, #0x18
               	mov	x24, #0x84              // =132
               	str	x24, [x26]
               	ldr	x0, [x25]
               	add	x0, x0, #0x38
               	ldr	x24, [x25]
               	add	x24, x24, #0x20
               	ldr	x24, [x24]
               	str	x24, [x0]
               	ldr	x26, [x25]
               	add	x26, x26, #0x20
               	ldur	x24, [x29, #-0x18]
               	str	x24, [x26]
               	ldr	x0, [x25]
               	add	x0, x0, #0x40
               	ldr	x24, [x25]
               	add	x24, x24, #0x28
               	ldr	x24, [x24]
               	str	x24, [x0]
               	ldr	x25, [x25]
               	add	x25, x25, #0x28
               	sub	x26, x29, #0x58
               	ldr	x24, [x26]
               	add	x24, x24, #0x1
               	str	x24, [x26]
               	str	x24, [x25]
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x2c
               	b.ne	<addr>
               	bl	<addr>
               	mov	x24, x0
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x25, [x25]
               	cmp	x25, #0x7d
               	b.eq	<addr>
               	bl	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x0, [x25]
               	add	x0, x0, #0x8
               	str	x0, [x25]
               	mov	x26, #0x8               // =8
               	str	x26, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x25, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1b8
               	mov	x26, x19
               	ldr	x26, [x26]
               	str	x26, [x25]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x26, x19
               	ldr	x26, [x26]
               	ldr	x26, [x26]
               	cbz	x26, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x0, x19
               	ldr	x0, [x0]
               	add	x0, x0, #0x18
               	ldr	x0, [x0]
               	cmp	x0, #0x84
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x26, x19
               	ldr	x0, [x26]
               	add	x0, x0, #0x18
               	ldr	x25, [x26]
               	add	x25, x25, #0x30
               	ldr	x25, [x25]
               	str	x25, [x0]
               	ldr	x24, [x26]
               	add	x24, x24, #0x20
               	ldr	x25, [x26]
               	add	x25, x25, #0x38
               	ldr	x25, [x25]
               	str	x25, [x24]
               	ldr	x0, [x26]
               	add	x0, x0, #0x28
               	ldr	x26, [x26]
               	add	x26, x26, #0x40
               	ldr	x26, [x26]
               	str	x26, [x0]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x26, x19
               	ldr	x25, [x26]
               	add	x25, x25, #0x48
               	str	x25, [x26]
               	b	<addr>
               	bl	<addr>
               	mov	x26, x0
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x799
               	mov	x22, x19
               	mov	x0, x22
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x1e8
               	mov	x22, x19
               	ldr	x22, [x22]
               	cbz	x22, <addr>
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	ldur	x22, [x29, #-0x38]
               	add	x22, x22, x21
               	stur	x22, [x29, #-0x38]
               	stur	x22, [x29, #-0x40]
               	sub	x21, x29, #0x38
               	ldr	x22, [x21]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x22, x22, x17
               	str	x22, [x21]
               	mov	x0, #0x26               // =38
               	str	x0, [x22]
               	sub	x21, x29, #0x38
               	ldr	x0, [x21]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x0, x0, x17
               	str	x0, [x21]
               	mov	x22, #0xd               // =13
               	str	x22, [x0]
               	ldur	x21, [x29, #-0x38]
               	stur	x21, [x29, #-0x60]
               	sub	x22, x29, #0x38
               	ldr	x21, [x22]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x21, x21, x17
               	str	x21, [x22]
               	ldur	x0, [x29, #0x10]
               	str	x0, [x21]
               	sub	x22, x29, #0x38
               	ldr	x0, [x22]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x0, x0, x17
               	str	x0, [x22]
               	ldur	x21, [x29, #0x20]
               	str	x21, [x0]
               	sub	x22, x29, #0x38
               	ldr	x21, [x22]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x21, x21, x17
               	str	x21, [x22]
               	ldur	x0, [x29, #-0x60]
               	str	x0, [x21]
               	mov	x22, #0x0               // =0
               	stur	x22, [x29, #-0x50]
               	b	<addr>
               	mov	x22, #0x1               // =1
               	cbz	x22, <addr>
               	sub	x0, x29, #0x30
               	ldr	x22, [x0]
               	add	x21, x22, #0x8
               	str	x21, [x0]
               	ldr	x22, [x22]
               	stur	x22, [x29, #-0x58]
               	sub	x20, x29, #0x50
               	ldr	x22, [x20]
               	add	x22, x22, #0x1
               	str	x22, [x20]
               	adrp	x19, <page>
               	add	x19, x19, #0x1f0
               	mov	x21, x19
               	ldr	x21, [x21]
               	cbz	x21, <addr>
               	b	<addr>
               	mov	x27, #0x0               // =0
               	mov	x0, x27
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x7ad
               	mov	x26, x19
               	ldur	x22, [x29, #-0x50]
               	adrp	x19, <page>
               	add	x19, x19, #0x7b6
               	mov	x20, x19
               	ldur	x0, [x29, #-0x58]
               	mov	x17, #0x5               // =5
               	mul	x0, x0, x17
               	add	x20, x20, x0
               	mov	x0, x26
               	mov	x2, x20
               	mov	x1, x22
               	bl	<addr>
               	sxtw	x0, w0
               	ldur	x0, [x29, #-0x58]
               	cmp	x0, #0x7
               	b.gt	<addr>
               	b	<addr>
               	ldur	x22, [x29, #-0x58]
               	cmp	x22, #0x0
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x87a
               	mov	x21, x19
               	ldur	x0, [x29, #-0x30]
               	ldr	x20, [x0]
               	mov	x0, x21
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x87f
               	mov	x22, x19
               	mov	x0, x22
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	ldur	x0, [x29, #-0x40]
               	sub	x22, x29, #0x30
               	ldr	x21, [x22]
               	add	x26, x21, #0x8
               	str	x26, [x22]
               	ldr	x21, [x21]
               	lsl	x21, x21, #3
               	add	x0, x0, x21
               	stur	x0, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x0, [x29, #-0x58]
               	cmp	x0, #0x1
               	b.ne	<addr>
               	sub	x21, x29, #0x30
               	ldr	x0, [x21]
               	add	x24, x0, #0x8
               	str	x24, [x21]
               	ldr	x0, [x0]
               	stur	x0, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x0, [x29, #-0x58]
               	cmp	x0, #0x2
               	b.ne	<addr>
               	ldur	x26, [x29, #-0x30]
               	ldr	x26, [x26]
               	stur	x26, [x29, #-0x30]
               	b	<addr>
               	b	<addr>
               	ldur	x26, [x29, #-0x58]
               	cmp	x26, #0x3
               	b.ne	<addr>
               	sub	x0, x29, #0x38
               	ldr	x26, [x0]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x26, x26, x17
               	str	x26, [x0]
               	ldur	x24, [x29, #-0x30]
               	add	x24, x24, #0x8
               	str	x24, [x26]
               	ldur	x0, [x29, #-0x30]
               	ldr	x0, [x0]
               	stur	x0, [x29, #-0x30]
               	b	<addr>
               	b	<addr>
               	ldur	x0, [x29, #-0x58]
               	cmp	x0, #0x4
               	b.ne	<addr>
               	ldur	x24, [x29, #-0x48]
               	cbz	x24, <addr>
               	b	<addr>
               	b	<addr>
               	ldur	x0, [x29, #-0x58]
               	cmp	x0, #0x5
               	b.ne	<addr>
               	b	<addr>
               	ldur	x0, [x29, #-0x30]
               	add	x0, x0, #0x8
               	stur	x0, [x29, #-0xd0]
               	b	<addr>
               	ldur	x0, [x29, #-0x30]
               	ldr	x0, [x0]
               	stur	x0, [x29, #-0xd0]
               	b	<addr>
               	ldur	x0, [x29, #-0xd0]
               	stur	x0, [x29, #-0x30]
               	b	<addr>
               	ldur	x24, [x29, #-0x48]
               	cbz	x24, <addr>
               	b	<addr>
               	b	<addr>
               	ldur	x0, [x29, #-0x58]
               	cmp	x0, #0x6
               	b.ne	<addr>
               	b	<addr>
               	ldur	x0, [x29, #-0x30]
               	ldr	x0, [x0]
               	stur	x0, [x29, #-0xd8]
               	b	<addr>
               	ldur	x0, [x29, #-0x30]
               	add	x0, x0, #0x8
               	stur	x0, [x29, #-0xd8]
               	b	<addr>
               	ldur	x0, [x29, #-0xd8]
               	stur	x0, [x29, #-0x30]
               	b	<addr>
               	sub	x24, x29, #0x38
               	ldr	x0, [x24]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x0, x0, x17
               	str	x0, [x24]
               	ldur	x26, [x29, #-0x40]
               	str	x26, [x0]
               	ldur	x24, [x29, #-0x38]
               	stur	x24, [x29, #-0x40]
               	sub	x26, x29, #0x30
               	ldr	x0, [x26]
               	add	x21, x0, #0x8
               	str	x21, [x26]
               	ldr	x0, [x0]
               	lsl	x0, x0, #3
               	sub	x24, x24, x0
               	stur	x24, [x29, #-0x38]
               	b	<addr>
               	b	<addr>
               	ldur	x24, [x29, #-0x58]
               	cmp	x24, #0x7
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x38]
               	sub	x24, x29, #0x30
               	ldr	x22, [x24]
               	add	x21, x22, #0x8
               	str	x21, [x24]
               	ldr	x22, [x22]
               	lsl	x22, x22, #3
               	add	x0, x0, x22
               	stur	x0, [x29, #-0x38]
               	b	<addr>
               	b	<addr>
               	ldur	x0, [x29, #-0x58]
               	cmp	x0, #0x8
               	b.ne	<addr>
               	ldur	x22, [x29, #-0x40]
               	stur	x22, [x29, #-0x38]
               	sub	x0, x29, #0x38
               	ldr	x22, [x0]
               	add	x26, x22, #0x8
               	str	x26, [x0]
               	ldr	x22, [x22]
               	stur	x22, [x29, #-0x40]
               	sub	x21, x29, #0x38
               	ldr	x22, [x21]
               	add	x26, x22, #0x8
               	str	x26, [x21]
               	ldr	x22, [x22]
               	stur	x22, [x29, #-0x30]
               	b	<addr>
               	b	<addr>
               	ldur	x22, [x29, #-0x58]
               	cmp	x22, #0x9
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x48]
               	ldr	x0, [x0]
               	stur	x0, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x0, [x29, #-0x58]
               	cmp	x0, #0xa
               	b.ne	<addr>
               	ldur	x22, [x29, #-0x48]
               	ldrb	w22, [x22]
               	stur	x22, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x22, [x29, #-0x58]
               	cmp	x22, #0xb
               	b.ne	<addr>
               	sub	x0, x29, #0x38
               	ldr	x22, [x0]
               	add	x26, x22, #0x8
               	str	x26, [x0]
               	ldr	x22, [x22]
               	ldur	x21, [x29, #-0x48]
               	str	x21, [x22]
               	b	<addr>
               	b	<addr>
               	ldur	x21, [x29, #-0x58]
               	cmp	x21, #0xc
               	b.ne	<addr>
               	sub	x26, x29, #0x38
               	ldr	x21, [x26]
               	add	x22, x21, #0x8
               	str	x22, [x26]
               	ldr	x21, [x21]
               	ldur	x0, [x29, #-0x48]
               	strb	w0, [x21]
               	stur	x0, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x0, [x29, #-0x58]
               	cmp	x0, #0xd
               	b.ne	<addr>
               	sub	x22, x29, #0x38
               	ldr	x0, [x22]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x0, x0, x17
               	str	x0, [x22]
               	ldur	x21, [x29, #-0x48]
               	str	x21, [x0]
               	b	<addr>
               	b	<addr>
               	ldur	x21, [x29, #-0x58]
               	cmp	x21, #0xe
               	b.ne	<addr>
               	sub	x22, x29, #0x38
               	ldr	x21, [x22]
               	add	x0, x21, #0x8
               	str	x0, [x22]
               	ldr	x21, [x21]
               	ldur	x26, [x29, #-0x48]
               	orr	x21, x21, x26
               	stur	x21, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x21, [x29, #-0x58]
               	cmp	x21, #0xf
               	b.ne	<addr>
               	sub	x26, x29, #0x38
               	ldr	x21, [x26]
               	add	x0, x21, #0x8
               	str	x0, [x26]
               	ldr	x21, [x21]
               	ldur	x22, [x29, #-0x48]
               	eor	x21, x21, x22
               	stur	x21, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x21, [x29, #-0x58]
               	cmp	x21, #0x10
               	b.ne	<addr>
               	sub	x22, x29, #0x38
               	ldr	x21, [x22]
               	add	x0, x21, #0x8
               	str	x0, [x22]
               	ldr	x21, [x21]
               	ldur	x26, [x29, #-0x48]
               	and	x21, x21, x26
               	stur	x21, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x21, [x29, #-0x58]
               	cmp	x21, #0x11
               	b.ne	<addr>
               	sub	x26, x29, #0x38
               	ldr	x21, [x26]
               	add	x0, x21, #0x8
               	str	x0, [x26]
               	ldr	x21, [x21]
               	ldur	x22, [x29, #-0x48]
               	cmp	x21, x22
               	cset	x21, eq
               	stur	x21, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x21, [x29, #-0x58]
               	cmp	x21, #0x12
               	b.ne	<addr>
               	sub	x22, x29, #0x38
               	ldr	x21, [x22]
               	add	x0, x21, #0x8
               	str	x0, [x22]
               	ldr	x21, [x21]
               	ldur	x26, [x29, #-0x48]
               	cmp	x21, x26
               	cset	x21, ne
               	stur	x21, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x21, [x29, #-0x58]
               	cmp	x21, #0x13
               	b.ne	<addr>
               	sub	x26, x29, #0x38
               	ldr	x21, [x26]
               	add	x0, x21, #0x8
               	str	x0, [x26]
               	ldr	x21, [x21]
               	ldur	x22, [x29, #-0x48]
               	cmp	x21, x22
               	cset	x21, lt
               	stur	x21, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x21, [x29, #-0x58]
               	cmp	x21, #0x14
               	b.ne	<addr>
               	sub	x22, x29, #0x38
               	ldr	x21, [x22]
               	add	x0, x21, #0x8
               	str	x0, [x22]
               	ldr	x21, [x21]
               	ldur	x26, [x29, #-0x48]
               	cmp	x21, x26
               	cset	x21, gt
               	stur	x21, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x21, [x29, #-0x58]
               	cmp	x21, #0x15
               	b.ne	<addr>
               	sub	x26, x29, #0x38
               	ldr	x21, [x26]
               	add	x0, x21, #0x8
               	str	x0, [x26]
               	ldr	x21, [x21]
               	ldur	x22, [x29, #-0x48]
               	cmp	x21, x22
               	cset	x21, le
               	stur	x21, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x21, [x29, #-0x58]
               	cmp	x21, #0x16
               	b.ne	<addr>
               	sub	x22, x29, #0x38
               	ldr	x21, [x22]
               	add	x0, x21, #0x8
               	str	x0, [x22]
               	ldr	x21, [x21]
               	ldur	x26, [x29, #-0x48]
               	cmp	x21, x26
               	cset	x21, ge
               	stur	x21, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x21, [x29, #-0x58]
               	cmp	x21, #0x17
               	b.ne	<addr>
               	sub	x26, x29, #0x38
               	ldr	x21, [x26]
               	add	x0, x21, #0x8
               	str	x0, [x26]
               	ldr	x21, [x21]
               	ldur	x22, [x29, #-0x48]
               	lsl	x21, x21, x22
               	stur	x21, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x21, [x29, #-0x58]
               	cmp	x21, #0x18
               	b.ne	<addr>
               	sub	x22, x29, #0x38
               	ldr	x21, [x22]
               	add	x0, x21, #0x8
               	str	x0, [x22]
               	ldr	x21, [x21]
               	ldur	x26, [x29, #-0x48]
               	asr	x21, x21, x26
               	stur	x21, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x21, [x29, #-0x58]
               	cmp	x21, #0x19
               	b.ne	<addr>
               	sub	x26, x29, #0x38
               	ldr	x21, [x26]
               	add	x0, x21, #0x8
               	str	x0, [x26]
               	ldr	x21, [x21]
               	ldur	x22, [x29, #-0x48]
               	add	x21, x21, x22
               	stur	x21, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x21, [x29, #-0x58]
               	cmp	x21, #0x1a
               	b.ne	<addr>
               	sub	x22, x29, #0x38
               	ldr	x21, [x22]
               	add	x0, x21, #0x8
               	str	x0, [x22]
               	ldr	x21, [x21]
               	ldur	x26, [x29, #-0x48]
               	sub	x21, x21, x26
               	stur	x21, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x21, [x29, #-0x58]
               	cmp	x21, #0x1b
               	b.ne	<addr>
               	sub	x26, x29, #0x38
               	ldr	x21, [x26]
               	add	x0, x21, #0x8
               	str	x0, [x26]
               	ldr	x21, [x21]
               	ldur	x22, [x29, #-0x48]
               	mul	x21, x21, x22
               	stur	x21, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x21, [x29, #-0x58]
               	cmp	x21, #0x1c
               	b.ne	<addr>
               	sub	x22, x29, #0x38
               	ldr	x21, [x22]
               	add	x0, x21, #0x8
               	str	x0, [x22]
               	ldr	x21, [x21]
               	ldur	x26, [x29, #-0x48]
               	sdiv	x21, x21, x26
               	stur	x21, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x21, [x29, #-0x58]
               	cmp	x21, #0x1d
               	b.ne	<addr>
               	sub	x26, x29, #0x38
               	ldr	x21, [x26]
               	add	x0, x21, #0x8
               	str	x0, [x26]
               	ldr	x21, [x21]
               	ldur	x22, [x29, #-0x48]
               	sdiv	x17, x21, x22
               	msub	x21, x17, x22, x21
               	stur	x21, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x21, [x29, #-0x58]
               	cmp	x21, #0x1e
               	b.ne	<addr>
               	ldur	x22, [x29, #-0x38]
               	add	x21, x22, #0x8
               	ldr	x21, [x21]
               	ldr	x22, [x22]
               	mov	x0, x21
               	mov	x1, x22
               	bl	<addr>
               	sxtw	x0, w0
               	stur	x0, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x0, [x29, #-0x58]
               	cmp	x0, #0x1f
               	b.ne	<addr>
               	ldur	x22, [x29, #-0x38]
               	add	x0, x22, #0x10
               	ldr	x20, [x0]
               	add	x0, x22, #0x8
               	ldr	x21, [x0]
               	ldr	x22, [x22]
               	mov	x0, x20
               	mov	x2, x22
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	stur	x0, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x0, [x29, #-0x58]
               	cmp	x0, #0x20
               	b.ne	<addr>
               	ldur	x22, [x29, #-0x38]
               	ldr	x22, [x22]
               	mov	x0, x22
               	bl	<addr>
               	sxtw	x0, w0
               	stur	x0, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x0, [x29, #-0x58]
               	cmp	x0, #0x21
               	b.ne	<addr>
               	ldur	x22, [x29, #-0x38]
               	ldur	x0, [x29, #-0x30]
               	add	x0, x0, #0x8
               	ldr	x0, [x0]
               	lsl	x0, x0, #3
               	add	x22, x22, x0
               	stur	x22, [x29, #-0x60]
               	ldur	x0, [x29, #-0x60]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x22, x0, x17
               	ldr	x22, [x22]
               	mov	x17, #0xfff0            // =65520
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x21, x0, x17
               	ldr	x21, [x21]
               	mov	x17, #0xffe8            // =65512
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x20, x0, x17
               	ldr	x20, [x20]
               	mov	x17, #0xffe0            // =65504
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x24, x0, x17
               	ldr	x24, [x24]
               	mov	x17, #0xffd8            // =65496
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x25, x0, x17
               	ldr	x25, [x25]
               	mov	x17, #0xffd0            // =65488
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x0, x0, x17
               	ldr	x26, [x0]
               	mov	x0, x22
               	mov	x5, x26
               	mov	x4, x25
               	mov	x3, x24
               	mov	x2, x20
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	stur	x0, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x0, [x29, #-0x58]
               	cmp	x0, #0x22
               	b.ne	<addr>
               	ldur	x26, [x29, #-0x38]
               	ldr	x26, [x26]
               	mov	x0, x26
               	bl	<addr>
               	stur	x0, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x0, [x29, #-0x58]
               	cmp	x0, #0x23
               	b.ne	<addr>
               	ldur	x26, [x29, #-0x38]
               	ldr	x26, [x26]
               	mov	x0, x26
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	ldur	x26, [x29, #-0x58]
               	cmp	x26, #0x24
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x38]
               	add	x26, x0, #0x10
               	ldr	x26, [x26]
               	add	x25, x0, #0x8
               	ldr	x25, [x25]
               	ldr	x23, [x0]
               	mov	x0, x26
               	mov	x2, x23
               	mov	x1, x25
               	bl	<addr>
               	stur	x0, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x0, [x29, #-0x58]
               	cmp	x0, #0x25
               	b.ne	<addr>
               	ldur	x23, [x29, #-0x38]
               	add	x0, x23, #0x10
               	ldr	x24, [x0]
               	add	x0, x23, #0x8
               	ldr	x25, [x0]
               	ldr	x23, [x23]
               	mov	x0, x24
               	mov	x2, x23
               	mov	x1, x25
               	bl	<addr>
               	sxtw	x0, w0
               	stur	x0, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x0, [x29, #-0x58]
               	cmp	x0, #0x26
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x881
               	mov	x26, x19
               	ldur	x0, [x29, #-0x38]
               	ldr	x23, [x0]
               	ldur	x25, [x29, #-0x50]
               	mov	x0, x26
               	mov	x2, x25
               	mov	x1, x23
               	bl	<addr>
               	sxtw	x0, w0
               	ldur	x0, [x29, #-0x38]
               	ldr	x0, [x0]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x896
               	mov	x24, x19
               	ldur	x25, [x29, #-0x58]
               	ldur	x27, [x29, #-0x50]
               	mov	x0, x24
               	mov	x2, x27
               	mov	x1, x25
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
