
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
               	ldr	x13, [x14]
               	cbz	x13, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x138
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
               	ldr	x21, [x0]
               	str	x21, [x22]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x138
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
               	ldr	x13, [x14]
               	ldrb	w14, [x13]
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
               	ldr	x14, [x15]
               	cmp	x14, #0xa
               	b.ne	<addr>
               	b	<addr>
               	mov	x25, #0x0               // =0
               	mov	x0, x25
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
               	mov	x15, x19
               	ldr	x14, [x15]
               	cbz	x14, <addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x24, [x0]
               	cmp	x24, #0x23
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
               	ldr	x0, [x22]
               	str	x0, [x23]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x22, x19
               	ldr	x0, [x22]
               	add	x0, x0, #0x1
               	str	x0, [x22]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a8
               	mov	x0, x19
               	ldr	x22, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x23, [x0]
               	cmp	x22, x23
               	b.ge	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x201
               	mov	x26, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x207
               	mov	x22, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1a8
               	mov	x23, x19
               	ldr	x25, [x23]
               	add	x25, x25, #0x8
               	str	x25, [x23]
               	ldr	x24, [x25]
               	mov	x17, #0x5               // =5
               	mul	x24, x24, x17
               	add	x22, x22, x24
               	mov	x0, x26
               	mov	x1, x22
               	bl	<addr>
               	sxtw	x0, w0
               	ldr	x0, [x23]
               	ldr	x23, [x0]
               	cmp	x23, #0x7
               	b.gt	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x2cb
               	mov	x24, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1a8
               	mov	x23, x19
               	ldr	x22, [x23]
               	add	x22, x22, #0x8
               	str	x22, [x23]
               	ldr	x27, [x22]
               	mov	x0, x24
               	mov	x1, x27
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x2d0
               	mov	x22, x19
               	mov	x0, x22
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x22, [x24]
               	cmp	x22, #0x61
               	cset	x22, ge
               	stur	x22, [x29, #-0x48]
               	cbz	x22, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x0, x19
               	ldr	x24, [x0]
               	ldrb	w0, [x24]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	stur	x0, [x29, #-0x30]
               	cbz	x0, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x0, x19
               	ldr	x24, [x0]
               	add	x24, x24, #0x1
               	str	x24, [x0]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x24, x19
               	ldr	x0, [x24]
               	ldrb	w24, [x0]
               	mov	x17, #0xa               // =10
               	eor	x24, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x24, x17
               	cmp	x24, #0x0
               	cset	x24, ne
               	stur	x24, [x29, #-0x30]
               	b	<addr>
               	ldur	x24, [x29, #-0x30]
               	cbz	x24, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x22, [x24]
               	cmp	x22, #0x7a
               	cset	x22, le
               	stur	x22, [x29, #-0x48]
               	b	<addr>
               	ldur	x22, [x29, #-0x48]
               	stur	x22, [x29, #-0x40]
               	cbnz	x22, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x22, [x24]
               	cmp	x22, #0x41
               	cset	x22, ge
               	stur	x22, [x29, #-0x50]
               	cbz	x22, <addr>
               	b	<addr>
               	ldur	x22, [x29, #-0x40]
               	stur	x22, [x29, #-0x38]
               	cbnz	x22, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x22, [x24]
               	cmp	x22, #0x5a
               	cset	x22, le
               	stur	x22, [x29, #-0x50]
               	b	<addr>
               	ldur	x22, [x29, #-0x50]
               	stur	x22, [x29, #-0x40]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x22, [x24]
               	cmp	x22, #0x5f
               	cset	x22, eq
               	stur	x22, [x29, #-0x38]
               	b	<addr>
               	ldur	x22, [x29, #-0x38]
               	cbz	x22, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x24, x19
               	ldr	x22, [x24]
               	sub	x22, x22, #0x1
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	ldr	x0, [x27]
               	cmp	x0, #0x30
               	cset	x0, ge
               	stur	x0, [x29, #-0x90]
               	cbz	x0, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x24, x19
               	ldr	x0, [x24]
               	ldrb	w24, [x0]
               	cmp	x24, #0x61
               	cset	x24, ge
               	stur	x24, [x29, #-0x70]
               	cbz	x24, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x24, [x0]
               	mov	x17, #0x93              // =147
               	mul	x24, x24, x17
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x23, x19
               	ldr	x25, [x23]
               	add	x21, x25, #0x1
               	str	x21, [x23]
               	ldrb	w20, [x25]
               	add	x24, x24, x20
               	str	x24, [x0]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x20, [x24]
               	lsl	x20, x20, #6
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x0, x19
               	ldr	x25, [x0]
               	sub	x25, x25, x22
               	add	x20, x20, x25
               	str	x20, [x24]
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x25, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1b8
               	mov	x20, x19
               	ldr	x24, [x20]
               	str	x24, [x25]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x0, x19
               	ldr	x24, [x0]
               	ldrb	w0, [x24]
               	cmp	x0, #0x7a
               	cset	x0, le
               	stur	x0, [x29, #-0x70]
               	b	<addr>
               	ldur	x0, [x29, #-0x70]
               	stur	x0, [x29, #-0x68]
               	cbnz	x0, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x24, x19
               	ldr	x0, [x24]
               	ldrb	w24, [x0]
               	cmp	x24, #0x41
               	cset	x24, ge
               	stur	x24, [x29, #-0x78]
               	cbz	x24, <addr>
               	b	<addr>
               	ldur	x0, [x29, #-0x68]
               	stur	x0, [x29, #-0x60]
               	cbnz	x0, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x0, x19
               	ldr	x24, [x0]
               	ldrb	w0, [x24]
               	cmp	x0, #0x5a
               	cset	x0, le
               	stur	x0, [x29, #-0x78]
               	b	<addr>
               	ldur	x0, [x29, #-0x78]
               	stur	x0, [x29, #-0x68]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x24, x19
               	ldr	x0, [x24]
               	ldrb	w24, [x0]
               	cmp	x24, #0x30
               	cset	x24, ge
               	stur	x24, [x29, #-0x80]
               	cbz	x24, <addr>
               	b	<addr>
               	ldur	x0, [x29, #-0x60]
               	stur	x0, [x29, #-0x58]
               	cbnz	x0, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x0, x19
               	ldr	x24, [x0]
               	ldrb	w0, [x24]
               	cmp	x0, #0x39
               	cset	x0, le
               	stur	x0, [x29, #-0x80]
               	b	<addr>
               	ldur	x0, [x29, #-0x80]
               	stur	x0, [x29, #-0x60]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x24, x19
               	ldr	x0, [x24]
               	ldrb	w24, [x0]
               	mov	x17, #0x5f              // =95
               	eor	x24, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x24, x17
               	cmp	x24, #0x0
               	cset	x24, eq
               	stur	x24, [x29, #-0x58]
               	b	<addr>
               	ldur	x24, [x29, #-0x58]
               	cbz	x24, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x24, x19
               	ldr	x20, [x24]
               	ldr	x24, [x20]
               	cbz	x24, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	ldr	x24, [x20]
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x20, x19
               	ldr	x25, [x20]
               	add	x25, x25, #0x8
               	ldr	x20, [x25]
               	cmp	x24, x20
               	cset	x24, eq
               	stur	x24, [x29, #-0x88]
               	cbz	x24, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x0, x19
               	ldr	x24, [x0]
               	add	x24, x24, #0x10
               	str	x22, [x24]
               	ldr	x27, [x0]
               	add	x27, x27, #0x8
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x22, [x24]
               	str	x22, [x27]
               	ldr	x25, [x0]
               	mov	x0, #0x0                // =0
               	mov	x22, #0x85              // =133
               	str	x22, [x25]
               	str	x22, [x24]
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
               	add	x24, x24, #0x10
               	ldr	x27, [x24]
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x24, x19
               	ldr	x25, [x24]
               	sub	x25, x25, x22
               	mov	x0, x27
               	mov	x2, x25
               	mov	x1, x22
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
               	mov	x25, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x0, x19
               	ldr	x27, [x0]
               	mov	x0, #0x0                // =0
               	ldr	x24, [x27]
               	str	x24, [x25]
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
               	mov	x27, x19
               	ldr	x0, [x27]
               	add	x0, x0, #0x48
               	str	x0, [x27]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	ldr	x0, [x27]
               	cmp	x0, #0x39
               	cset	x0, le
               	stur	x0, [x29, #-0x90]
               	b	<addr>
               	ldur	x0, [x29, #-0x90]
               	cbz	x0, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c8
               	mov	x27, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x22, [x0]
               	sub	x22, x22, #0x30
               	str	x22, [x27]
               	cbz	x22, <addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	ldr	x24, [x27]
               	cmp	x24, #0x2f
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	mov	x27, #0x80              // =128
               	str	x27, [x22]
               	mov	x24, #0x0               // =0
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
               	add	x19, x19, #0x188
               	mov	x22, x19
               	ldr	x21, [x22]
               	ldrb	w22, [x21]
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
               	mov	x0, x19
               	ldr	x22, [x0]
               	ldrb	w0, [x22]
               	cmp	x0, #0x30
               	cset	x0, ge
               	stur	x0, [x29, #-0x98]
               	cbz	x0, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c8
               	mov	x0, x19
               	ldr	x22, [x0]
               	mov	x17, #0xa               // =10
               	mul	x22, x22, x17
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x27, x19
               	ldr	x24, [x27]
               	add	x25, x24, #0x1
               	str	x25, [x27]
               	ldrb	w21, [x24]
               	add	x22, x22, x21
               	sub	x22, x22, #0x30
               	str	x22, [x0]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x22, x19
               	ldr	x0, [x22]
               	ldrb	w22, [x0]
               	cmp	x22, #0x39
               	cset	x22, le
               	stur	x22, [x29, #-0x98]
               	b	<addr>
               	ldur	x22, [x29, #-0x98]
               	cbz	x22, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x21, x19
               	ldr	x22, [x21]
               	ldrb	w21, [x22]
               	mov	x17, #0x58              // =88
               	eor	x21, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x21, x17
               	cmp	x21, #0x0
               	cset	x21, eq
               	stur	x21, [x29, #-0xa0]
               	b	<addr>
               	ldur	x21, [x29, #-0xa0]
               	cbz	x21, <addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x21, x19
               	ldr	x0, [x21]
               	add	x0, x0, #0x1
               	str	x0, [x21]
               	ldrb	w24, [x0]
               	str	x24, [x22]
               	stur	x24, [x29, #-0xa8]
               	cbz	x24, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c8
               	mov	x0, x19
               	ldr	x24, [x0]
               	lsl	x24, x24, #4
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x21, [x22]
               	mov	x17, #0xf               // =15
               	and	x21, x21, x17
               	add	x24, x24, x21
               	ldr	x21, [x22]
               	cmp	x21, #0x41
               	b.lt	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x24, [x0]
               	cmp	x24, #0x30
               	cset	x24, ge
               	stur	x24, [x29, #-0xc0]
               	cbz	x24, <addr>
               	b	<addr>
               	ldur	x24, [x29, #-0xa8]
               	cbz	x24, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x24, [x0]
               	cmp	x24, #0x39
               	cset	x24, le
               	stur	x24, [x29, #-0xc0]
               	b	<addr>
               	ldur	x24, [x29, #-0xc0]
               	stur	x24, [x29, #-0xb8]
               	cbnz	x24, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x24, [x0]
               	cmp	x24, #0x61
               	cset	x24, ge
               	stur	x24, [x29, #-0xc8]
               	cbz	x24, <addr>
               	b	<addr>
               	ldur	x24, [x29, #-0xb8]
               	stur	x24, [x29, #-0xb0]
               	cbnz	x24, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x24, [x0]
               	cmp	x24, #0x66
               	cset	x24, le
               	stur	x24, [x29, #-0xc8]
               	b	<addr>
               	ldur	x24, [x29, #-0xc8]
               	stur	x24, [x29, #-0xb8]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x24, [x0]
               	cmp	x24, #0x41
               	cset	x24, ge
               	stur	x24, [x29, #-0xd0]
               	cbz	x24, <addr>
               	b	<addr>
               	ldur	x24, [x29, #-0xb0]
               	stur	x24, [x29, #-0xa8]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x24, [x0]
               	cmp	x24, #0x46
               	cset	x24, le
               	stur	x24, [x29, #-0xd0]
               	b	<addr>
               	ldur	x24, [x29, #-0xd0]
               	stur	x24, [x29, #-0xb0]
               	b	<addr>
               	mov	x22, #0x9               // =9
               	stur	x22, [x29, #-0xd8]
               	b	<addr>
               	mov	x22, #0x0               // =0
               	stur	x22, [x29, #-0xd8]
               	b	<addr>
               	ldur	x22, [x29, #-0xd8]
               	add	x24, x24, x22
               	str	x24, [x0]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x24, x19
               	ldr	x22, [x24]
               	ldrb	w24, [x22]
               	cmp	x24, #0x30
               	cset	x24, ge
               	stur	x24, [x29, #-0xe0]
               	cbz	x24, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c8
               	mov	x24, x19
               	ldr	x22, [x24]
               	lsl	x22, x22, #3
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x0, x19
               	ldr	x21, [x0]
               	add	x25, x21, #0x1
               	str	x25, [x0]
               	ldrb	w27, [x21]
               	add	x22, x22, x27
               	sub	x22, x22, #0x30
               	str	x22, [x24]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x22, x19
               	ldr	x24, [x22]
               	ldrb	w22, [x24]
               	cmp	x22, #0x37
               	cset	x22, le
               	stur	x22, [x29, #-0xe0]
               	b	<addr>
               	ldur	x22, [x29, #-0xe0]
               	cbz	x22, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x27, x19
               	ldr	x24, [x27]
               	ldrb	w27, [x24]
               	mov	x17, #0x2f              // =47
               	eor	x27, x27, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x27, x27, x17
               	cmp	x27, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x27, [x24]
               	cmp	x27, #0x27
               	cset	x27, eq
               	stur	x27, [x29, #-0xf0]
               	cbnz	x27, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x24, x19
               	ldr	x27, [x24]
               	add	x27, x27, #0x1
               	str	x27, [x24]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	mov	x24, #0xa0              // =160
               	str	x24, [x22]
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
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x27, x19
               	ldr	x22, [x27]
               	ldrb	w27, [x22]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x27, x27, x17
               	cmp	x27, #0x0
               	cset	x27, ne
               	stur	x27, [x29, #-0xe8]
               	cbz	x27, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x27, x19
               	ldr	x22, [x27]
               	add	x22, x22, #0x1
               	str	x22, [x27]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x22, x19
               	ldr	x27, [x22]
               	ldrb	w22, [x27]
               	mov	x17, #0xa               // =10
               	eor	x22, x22, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x22, x17
               	cmp	x22, #0x0
               	cset	x22, ne
               	stur	x22, [x29, #-0xe8]
               	b	<addr>
               	ldur	x22, [x29, #-0xe8]
               	cbz	x22, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x27, [x24]
               	cmp	x27, #0x22
               	cset	x27, eq
               	stur	x27, [x29, #-0xf0]
               	b	<addr>
               	ldur	x27, [x29, #-0xf0]
               	cbz	x27, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x198
               	mov	x24, x19
               	ldr	x27, [x24]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	ldr	x25, [x27]
               	cmp	x25, #0x3d
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x24, x19
               	ldr	x22, [x24]
               	ldrb	w24, [x22]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x24, x17
               	cmp	x24, #0x0
               	cset	x24, ne
               	stur	x24, [x29, #-0xf8]
               	cbz	x24, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c8
               	mov	x21, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x22, x19
               	ldr	x24, [x22]
               	add	x25, x24, #0x1
               	str	x25, [x22]
               	ldrb	w0, [x24]
               	str	x0, [x21]
               	cmp	x0, #0x5c
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x21, x19
               	ldr	x25, [x21]
               	add	x25, x25, #0x1
               	str	x25, [x21]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x25, [x24]
               	cmp	x25, #0x22
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x22, x19
               	ldr	x24, [x22]
               	ldrb	w22, [x24]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x21, [x24]
               	cmp	x22, x21
               	cset	x22, ne
               	stur	x22, [x29, #-0xf8]
               	b	<addr>
               	ldur	x22, [x29, #-0xf8]
               	cbz	x22, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c8
               	mov	x24, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x0, x19
               	ldr	x21, [x0]
               	add	x25, x21, #0x1
               	str	x25, [x0]
               	ldrb	w22, [x21]
               	str	x22, [x24]
               	cmp	x22, #0x6e
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x24, [x22]
               	cmp	x24, #0x22
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c8
               	mov	x21, x19
               	mov	x22, #0xa               // =10
               	str	x22, [x21]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x198
               	mov	x22, x19
               	ldr	x24, [x22]
               	add	x21, x24, #0x1
               	str	x21, [x22]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c8
               	mov	x25, x19
               	ldr	x21, [x25]
               	strb	w21, [x24]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c8
               	mov	x24, x19
               	str	x27, [x24]
               	b	<addr>
               	mov	x25, #0x0               // =0
               	mov	x0, x25
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
               	mov	x24, x19
               	mov	x25, #0x80              // =128
               	str	x25, [x24]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x27, x19
               	ldr	x25, [x27]
               	ldrb	w27, [x25]
               	mov	x17, #0x3d              // =61
               	eor	x27, x27, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x27, x27, x17
               	cmp	x27, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x25, [x24]
               	cmp	x25, #0x2b
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x25, x19
               	ldr	x27, [x25]
               	add	x27, x27, #0x1
               	str	x27, [x25]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	mov	x27, #0x95              // =149
               	str	x27, [x24]
               	b	<addr>
               	mov	x25, #0x0               // =0
               	mov	x0, x25
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
               	mov	x27, x19
               	mov	x25, #0x8e              // =142
               	str	x25, [x27]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x24, x19
               	ldr	x25, [x24]
               	ldrb	w24, [x25]
               	mov	x17, #0x2b              // =43
               	eor	x24, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x24, x17
               	cmp	x24, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	ldr	x25, [x27]
               	cmp	x25, #0x2d
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x25, x19
               	ldr	x24, [x25]
               	add	x24, x24, #0x1
               	str	x24, [x25]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	mov	x24, #0xa2              // =162
               	str	x24, [x27]
               	b	<addr>
               	mov	x25, #0x0               // =0
               	mov	x0, x25
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
               	mov	x24, x19
               	mov	x25, #0x9d              // =157
               	str	x25, [x24]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x27, x19
               	ldr	x25, [x27]
               	ldrb	w27, [x25]
               	mov	x17, #0x2d              // =45
               	eor	x27, x27, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x27, x27, x17
               	cmp	x27, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x25, [x24]
               	cmp	x25, #0x21
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x25, x19
               	ldr	x27, [x25]
               	add	x27, x27, #0x1
               	str	x27, [x25]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	mov	x27, #0xa3              // =163
               	str	x27, [x24]
               	b	<addr>
               	mov	x25, #0x0               // =0
               	mov	x0, x25
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
               	mov	x27, x19
               	mov	x25, #0x9e              // =158
               	str	x25, [x27]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x24, x19
               	ldr	x25, [x24]
               	ldrb	w24, [x25]
               	mov	x17, #0x3d              // =61
               	eor	x24, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x24, x17
               	cmp	x24, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x24, [x25]
               	cmp	x24, #0x3c
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x25, x19
               	ldr	x24, [x25]
               	add	x24, x24, #0x1
               	str	x24, [x25]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	mov	x24, #0x96              // =150
               	str	x24, [x27]
               	b	<addr>
               	mov	x24, #0x0               // =0
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
               	add	x19, x19, #0x188
               	mov	x25, x19
               	ldr	x24, [x25]
               	ldrb	w25, [x24]
               	mov	x17, #0x3d              // =61
               	eor	x25, x25, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x25, x25, x17
               	cmp	x25, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	ldr	x24, [x27]
               	cmp	x24, #0x3e
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x24, x19
               	ldr	x25, [x24]
               	add	x25, x25, #0x1
               	str	x25, [x24]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	mov	x25, #0x99              // =153
               	str	x25, [x27]
               	b	<addr>
               	mov	x24, #0x0               // =0
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
               	add	x19, x19, #0x188
               	mov	x25, x19
               	ldr	x24, [x25]
               	ldrb	w25, [x24]
               	mov	x17, #0x3c              // =60
               	eor	x25, x25, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x25, x25, x17
               	cmp	x25, #0x0
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x24, x19
               	ldr	x25, [x24]
               	add	x25, x25, #0x1
               	str	x25, [x24]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	mov	x25, #0x9b              // =155
               	str	x25, [x27]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	mov	x24, #0x97              // =151
               	str	x24, [x25]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x27, x19
               	ldr	x24, [x27]
               	ldrb	w27, [x24]
               	mov	x17, #0x3d              // =61
               	eor	x27, x27, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x27, x27, x17
               	cmp	x27, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x24, [x25]
               	cmp	x24, #0x7c
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x24, x19
               	ldr	x27, [x24]
               	add	x27, x27, #0x1
               	str	x27, [x24]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	mov	x27, #0x9a              // =154
               	str	x27, [x25]
               	b	<addr>
               	mov	x24, #0x0               // =0
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
               	add	x19, x19, #0x188
               	mov	x27, x19
               	ldr	x24, [x27]
               	ldrb	w27, [x24]
               	mov	x17, #0x3e              // =62
               	eor	x27, x27, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x27, x27, x17
               	cmp	x27, #0x0
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x24, x19
               	ldr	x27, [x24]
               	add	x27, x27, #0x1
               	str	x27, [x24]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	mov	x27, #0x9c              // =156
               	str	x27, [x25]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	mov	x24, #0x98              // =152
               	str	x24, [x27]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x25, x19
               	ldr	x24, [x25]
               	ldrb	w25, [x24]
               	mov	x17, #0x7c              // =124
               	eor	x25, x25, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x25, x25, x17
               	cmp	x25, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	ldr	x24, [x27]
               	cmp	x24, #0x26
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x24, x19
               	ldr	x25, [x24]
               	add	x25, x25, #0x1
               	str	x25, [x24]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	mov	x25, #0x90              // =144
               	str	x25, [x27]
               	b	<addr>
               	mov	x24, #0x0               // =0
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
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	mov	x24, #0x92              // =146
               	str	x24, [x25]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x27, x19
               	ldr	x24, [x27]
               	ldrb	w27, [x24]
               	mov	x17, #0x26              // =38
               	eor	x27, x27, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x27, x27, x17
               	cmp	x27, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x24, [x25]
               	cmp	x24, #0x5e
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x24, x19
               	ldr	x27, [x24]
               	add	x27, x27, #0x1
               	str	x27, [x24]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	mov	x27, #0x91              // =145
               	str	x27, [x25]
               	b	<addr>
               	mov	x24, #0x0               // =0
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
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	mov	x24, #0x94              // =148
               	str	x24, [x27]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	mov	x24, #0x93              // =147
               	str	x24, [x25]
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
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x27, [x24]
               	cmp	x27, #0x25
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	mov	x27, #0xa1              // =161
               	str	x27, [x24]
               	mov	x25, #0x0               // =0
               	mov	x0, x25
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
               	mov	x27, x19
               	ldr	x25, [x27]
               	cmp	x25, #0x2a
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	mov	x25, #0x9f              // =159
               	str	x25, [x27]
               	mov	x24, #0x0               // =0
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
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x24, [x25]
               	cmp	x24, #0x5b
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	mov	x24, #0xa4              // =164
               	str	x24, [x25]
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
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x27, [x24]
               	cmp	x27, #0x3f
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	mov	x27, #0x8f              // =143
               	str	x27, [x24]
               	mov	x25, #0x0               // =0
               	mov	x0, x25
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
               	mov	x27, x19
               	ldr	x25, [x27]
               	cmp	x25, #0x7e
               	cset	x25, eq
               	sub	x17, x29, #0x138
               	str	x25, [x17]
               	cbnz	x25, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	ldr	x25, [x27]
               	cmp	x25, #0x3b
               	cset	x25, eq
               	sub	x17, x29, #0x138
               	str	x25, [x17]
               	b	<addr>
               	sub	x16, x29, #0x138
               	ldr	x25, [x16]
               	sub	x17, x29, #0x130
               	str	x25, [x17]
               	cbnz	x25, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	ldr	x25, [x27]
               	cmp	x25, #0x7b
               	cset	x25, eq
               	sub	x17, x29, #0x130
               	str	x25, [x17]
               	b	<addr>
               	sub	x16, x29, #0x130
               	ldr	x25, [x16]
               	sub	x17, x29, #0x128
               	str	x25, [x17]
               	cbnz	x25, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	ldr	x25, [x27]
               	cmp	x25, #0x7d
               	cset	x25, eq
               	sub	x17, x29, #0x128
               	str	x25, [x17]
               	b	<addr>
               	sub	x16, x29, #0x128
               	ldr	x25, [x16]
               	sub	x17, x29, #0x120
               	str	x25, [x17]
               	cbnz	x25, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	ldr	x25, [x27]
               	cmp	x25, #0x28
               	cset	x25, eq
               	sub	x17, x29, #0x120
               	str	x25, [x17]
               	b	<addr>
               	sub	x16, x29, #0x120
               	ldr	x25, [x16]
               	sub	x17, x29, #0x118
               	str	x25, [x17]
               	cbnz	x25, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	ldr	x25, [x27]
               	cmp	x25, #0x29
               	cset	x25, eq
               	sub	x17, x29, #0x118
               	str	x25, [x17]
               	b	<addr>
               	sub	x16, x29, #0x118
               	ldr	x25, [x16]
               	sub	x17, x29, #0x110
               	str	x25, [x17]
               	cbnz	x25, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	ldr	x25, [x27]
               	cmp	x25, #0x5d
               	cset	x25, eq
               	sub	x17, x29, #0x110
               	str	x25, [x17]
               	b	<addr>
               	sub	x16, x29, #0x110
               	ldr	x25, [x16]
               	sub	x17, x29, #0x108
               	str	x25, [x17]
               	cbnz	x25, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	ldr	x25, [x27]
               	cmp	x25, #0x2c
               	cset	x25, eq
               	sub	x17, x29, #0x108
               	str	x25, [x17]
               	b	<addr>
               	sub	x16, x29, #0x108
               	ldr	x25, [x16]
               	stur	x25, [x29, #-0x100]
               	cbnz	x25, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x27, x19
               	ldr	x25, [x27]
               	cmp	x25, #0x3a
               	cset	x25, eq
               	stur	x25, [x29, #-0x100]
               	b	<addr>
               	ldur	x25, [x29, #-0x100]
               	cbz	x25, <addr>
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
               	ldr	x13, [x14]
               	cmp	x13, #0x0
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x2d2
               	mov	x21, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x13, x19
               	ldr	x22, [x13]
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
               	ldr	x0, [x23]
               	cmp	x0, #0x80
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
               	mov	x0, x19
               	ldr	x23, [x0]
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
               	ldr	x23, [x0]
               	cmp	x23, #0x22
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
               	mov	x22, x19
               	ldr	x0, [x22]
               	str	x0, [x11]
               	bl	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x21, [x0]
               	cmp	x21, #0x8c
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x0, [x22]
               	cmp	x0, #0x22
               	b.ne	<addr>
               	bl	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x198
               	mov	x21, x19
               	ldr	x0, [x21]
               	add	x0, x0, #0x8
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	str	x0, [x21]
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
               	ldr	x21, [x0]
               	cmp	x21, #0x28
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x23, [x21]
               	cmp	x23, #0x85
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
               	mov	x22, x19
               	ldr	x0, [x22]
               	cmp	x0, #0x8a
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x2f4
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
               	bl	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x0, [x21]
               	cmp	x0, #0x86
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	mov	x22, #0x0               // =0
               	str	x22, [x0]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x24, [x22]
               	cmp	x24, #0x9f
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	ldr	x24, [x0]
               	add	x24, x24, #0x2
               	str	x24, [x0]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x22, [x24]
               	cmp	x22, #0x29
               	b.ne	<addr>
               	bl	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x24, x19
               	ldr	x0, [x24]
               	add	x0, x0, #0x8
               	str	x0, [x24]
               	mov	x21, #0x1               // =1
               	str	x21, [x0]
               	ldr	x23, [x24]
               	add	x23, x23, #0x8
               	str	x23, [x24]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x21, x19
               	ldr	x24, [x21]
               	cmp	x24, #0x0
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x317
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
               	mov	x21, #0x1               // =1
               	stur	x21, [x29, #-0x30]
               	b	<addr>
               	mov	x21, #0x8               // =8
               	stur	x21, [x29, #-0x30]
               	b	<addr>
               	ldur	x21, [x29, #-0x30]
               	str	x21, [x23]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x24, x19
               	mov	x21, #0x1               // =1
               	str	x21, [x24]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x21, x19
               	ldr	x23, [x21]
               	stur	x23, [x29, #-0x10]
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x23, [x0]
               	cmp	x23, #0x28
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x24, [x23]
               	cmp	x24, #0x28
               	b.ne	<addr>
               	b	<addr>
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x8]
               	b	<addr>
               	b	<addr>
               	ldur	x24, [x29, #-0x10]
               	add	x24, x24, #0x18
               	ldr	x0, [x24]
               	cmp	x0, #0x80
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x23, [x0]
               	cmp	x23, #0x29
               	b.eq	<addr>
               	mov	x22, #0x8e              // =142
               	mov	x0, x22
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x22, [x0]
               	add	x22, x22, #0x8
               	str	x22, [x0]
               	mov	x24, #0xd               // =13
               	str	x24, [x22]
               	sub	x0, x29, #0x8
               	ldr	x24, [x0]
               	add	x24, x24, #0x1
               	str	x24, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x24, [x22]
               	cmp	x24, #0x2c
               	b.ne	<addr>
               	b	<addr>
               	bl	<addr>
               	ldur	x0, [x29, #-0x10]
               	add	x0, x0, #0x18
               	ldr	x23, [x0]
               	cmp	x23, #0x82
               	b.ne	<addr>
               	b	<addr>
               	bl	<addr>
               	mov	x23, x0
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x23, [x0]
               	add	x23, x23, #0x8
               	str	x23, [x0]
               	ldur	x24, [x29, #-0x10]
               	add	x24, x24, #0x28
               	ldr	x0, [x24]
               	str	x0, [x23]
               	b	<addr>
               	ldur	x23, [x29, #-0x8]
               	cbz	x23, <addr>
               	b	<addr>
               	ldur	x0, [x29, #-0x10]
               	add	x0, x0, #0x18
               	ldr	x24, [x0]
               	cmp	x24, #0x81
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x24, [x0]
               	add	x24, x24, #0x8
               	str	x24, [x0]
               	mov	x23, #0x3               // =3
               	str	x23, [x24]
               	ldr	x21, [x0]
               	add	x21, x21, #0x8
               	str	x21, [x0]
               	ldur	x23, [x29, #-0x10]
               	add	x23, x23, #0x28
               	ldr	x0, [x23]
               	str	x0, [x21]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x33b
               	mov	x22, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x23, x19
               	ldr	x25, [x23]
               	mov	x0, x22
               	mov	x1, x25
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
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x23, [x0]
               	add	x23, x23, #0x8
               	str	x23, [x0]
               	mov	x22, #0x7               // =7
               	str	x22, [x23]
               	ldr	x24, [x0]
               	add	x24, x24, #0x8
               	str	x24, [x0]
               	ldur	x22, [x29, #-0x8]
               	str	x22, [x24]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x22, x19
               	ldur	x0, [x29, #-0x10]
               	add	x0, x0, #0x20
               	ldr	x24, [x0]
               	str	x24, [x22]
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
               	ldur	x0, [x29, #-0x10]
               	add	x0, x0, #0x28
               	ldr	x24, [x0]
               	str	x24, [x23]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	str	x22, [x0]
               	b	<addr>
               	b	<addr>
               	ldur	x0, [x29, #-0x10]
               	add	x0, x0, #0x18
               	ldr	x24, [x0]
               	cmp	x24, #0x84
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x24, [x0]
               	add	x24, x24, #0x8
               	str	x24, [x0]
               	mov	x22, #0x0               // =0
               	str	x22, [x24]
               	ldr	x23, [x0]
               	add	x23, x23, #0x8
               	str	x23, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d8
               	mov	x22, x19
               	ldr	x0, [x22]
               	ldur	x22, [x29, #-0x10]
               	add	x22, x22, #0x28
               	ldr	x24, [x22]
               	sub	x0, x0, x24
               	str	x0, [x23]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x0, [x23]
               	add	x0, x0, #0x8
               	str	x0, [x23]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x25, x19
               	ldur	x23, [x29, #-0x10]
               	add	x23, x23, #0x20
               	ldr	x24, [x23]
               	str	x24, [x25]
               	cmp	x24, #0x0
               	b.ne	<addr>
               	b	<addr>
               	ldur	x0, [x29, #-0x10]
               	add	x0, x0, #0x18
               	ldr	x24, [x0]
               	cmp	x24, #0x83
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x24, [x0]
               	add	x24, x24, #0x8
               	str	x24, [x0]
               	mov	x23, #0x1               // =1
               	str	x23, [x24]
               	ldr	x22, [x0]
               	add	x22, x22, #0x8
               	str	x22, [x0]
               	ldur	x23, [x29, #-0x10]
               	add	x23, x23, #0x28
               	ldr	x0, [x23]
               	str	x0, [x22]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x352
               	mov	x25, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x23, x19
               	ldr	x21, [x23]
               	mov	x0, x25
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
               	mov	x23, #0xa               // =10
               	stur	x23, [x29, #-0x38]
               	b	<addr>
               	mov	x23, #0x9               // =9
               	stur	x23, [x29, #-0x38]
               	b	<addr>
               	ldur	x23, [x29, #-0x38]
               	str	x23, [x0]
               	b	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x24, [x0]
               	cmp	x24, #0x8a
               	cset	x24, eq
               	stur	x24, [x29, #-0x40]
               	cbnz	x24, <addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x0, [x24]
               	cmp	x0, #0x9f
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x24, [x0]
               	cmp	x24, #0x86
               	cset	x24, eq
               	stur	x24, [x29, #-0x40]
               	b	<addr>
               	ldur	x24, [x29, #-0x40]
               	cbz	x24, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x24, [x0]
               	cmp	x24, #0x8a
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x23, #0x8e              // =142
               	mov	x0, x23
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x23, [x0]
               	cmp	x23, #0x29
               	b.ne	<addr>
               	b	<addr>
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0x48]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x48]
               	b	<addr>
               	ldur	x0, [x29, #-0x48]
               	stur	x0, [x29, #-0x8]
               	bl	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x0, [x24]
               	cmp	x0, #0x9f
               	b.ne	<addr>
               	bl	<addr>
               	ldur	x0, [x29, #-0x8]
               	add	x0, x0, #0x2
               	stur	x0, [x29, #-0x8]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x21, [x0]
               	cmp	x21, #0x29
               	b.ne	<addr>
               	bl	<addr>
               	b	<addr>
               	mov	x21, #0xa2              // =162
               	mov	x0, x21
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	ldur	x21, [x29, #-0x8]
               	str	x21, [x0]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x36a
               	mov	x24, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x21, [x0]
               	mov	x0, x24
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
               	bl	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x378
               	mov	x21, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x23, [x0]
               	mov	x0, x21
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
               	mov	x24, #0xa2              // =162
               	mov	x0, x24
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	ldr	x24, [x0]
               	cmp	x24, #0x1
               	b.le	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x21, [x23]
               	cmp	x21, #0x94
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	ldr	x24, [x0]
               	sub	x24, x24, #0x2
               	str	x24, [x0]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x21, x19
               	ldr	x0, [x21]
               	add	x0, x0, #0x8
               	str	x0, [x21]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x23, x19
               	ldr	x21, [x23]
               	cmp	x21, #0x0
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x392
               	mov	x23, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x21, x19
               	ldr	x24, [x21]
               	mov	x0, x23
               	mov	x1, x24
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
               	mov	x23, #0xa               // =10
               	stur	x23, [x29, #-0x50]
               	b	<addr>
               	mov	x23, #0x9               // =9
               	stur	x23, [x29, #-0x50]
               	b	<addr>
               	ldur	x23, [x29, #-0x50]
               	str	x23, [x0]
               	b	<addr>
               	bl	<addr>
               	mov	x24, #0xa2              // =162
               	mov	x0, x24
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x24, [x0]
               	ldr	x0, [x24]
               	cmp	x0, #0xa
               	cset	x0, eq
               	stur	x0, [x29, #-0x58]
               	cbnz	x0, <addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x21, [x0]
               	cmp	x21, #0x21
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x24, x19
               	ldr	x0, [x24]
               	ldr	x24, [x0]
               	cmp	x24, #0x9
               	cset	x24, eq
               	stur	x24, [x29, #-0x58]
               	b	<addr>
               	ldur	x24, [x29, #-0x58]
               	cbz	x24, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x24, [x0]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x24, x24, x17
               	str	x24, [x0]
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
               	mov	x21, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x23, x19
               	ldr	x24, [x23]
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
               	ldr	x25, [x0]
               	add	x25, x25, #0x8
               	str	x25, [x0]
               	mov	x23, #0x1               // =1
               	str	x23, [x25]
               	ldr	x24, [x0]
               	add	x24, x24, #0x8
               	str	x24, [x0]
               	mov	x25, #0x0               // =0
               	str	x25, [x24]
               	ldr	x10, [x0]
               	add	x10, x10, #0x8
               	str	x10, [x0]
               	mov	x25, #0x11              // =17
               	str	x25, [x10]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	str	x23, [x0]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x25, [x0]
               	cmp	x25, #0x7e
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
               	ldr	x10, [x0]
               	cmp	x10, #0x9d
               	b.ne	<addr>
               	bl	<addr>
               	mov	x22, #0xa2              // =162
               	mov	x0, x22
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	mov	x22, #0x1               // =1
               	str	x22, [x0]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x23, [x22]
               	cmp	x23, #0x9e
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x23, [x0]
               	add	x23, x23, #0x8
               	str	x23, [x0]
               	mov	x22, #0x1               // =1
               	str	x22, [x23]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x22, [x0]
               	cmp	x22, #0x80
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x0, [x25]
               	cmp	x0, #0xa2
               	cset	x0, eq
               	stur	x0, [x29, #-0x60]
               	cbnz	x0, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x22, [x0]
               	add	x22, x22, #0x8
               	str	x22, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c8
               	mov	x23, x19
               	ldr	x0, [x23]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x0, x0, x17
               	str	x0, [x22]
               	bl	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x23, x19
               	mov	x25, #0x1               // =1
               	str	x25, [x23]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x0, [x25]
               	add	x0, x0, #0x8
               	str	x0, [x25]
               	mov	x22, #0xffff            // =65535
               	movk	x22, #0xffff, lsl #16
               	movk	x22, #0xffff, lsl #32
               	movk	x22, #0xffff, lsl #48
               	str	x22, [x0]
               	ldr	x24, [x25]
               	add	x24, x24, #0x8
               	str	x24, [x25]
               	mov	x22, #0xd               // =13
               	str	x22, [x24]
               	mov	x23, #0xa2              // =162
               	mov	x0, x23
               	bl	<addr>
               	ldr	x0, [x25]
               	add	x0, x0, #0x8
               	str	x0, [x25]
               	mov	x23, #0x1b              // =27
               	str	x23, [x0]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x0, [x25]
               	cmp	x0, #0xa3
               	cset	x0, eq
               	stur	x0, [x29, #-0x60]
               	b	<addr>
               	ldur	x0, [x29, #-0x60]
               	cbz	x0, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x0, [x25]
               	stur	x0, [x29, #-0x8]
               	bl	<addr>
               	mov	x22, #0xa2              // =162
               	mov	x0, x22
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x22, [x0]
               	ldr	x0, [x22]
               	cmp	x0, #0xa
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x3dc
               	mov	x24, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x25, [x0]
               	mov	x0, x24
               	mov	x1, x25
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
               	mov	x22, x19
               	ldr	x0, [x22]
               	mov	x23, #0xd               // =13
               	str	x23, [x0]
               	ldr	x24, [x22]
               	add	x24, x24, #0x8
               	str	x24, [x22]
               	mov	x23, #0xa               // =10
               	str	x23, [x24]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x22, x19
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x25, #0xd               // =13
               	str	x25, [x0]
               	ldr	x23, [x22]
               	add	x23, x23, #0x8
               	str	x23, [x22]
               	mov	x25, #0x1               // =1
               	str	x25, [x23]
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x25, x19
               	ldr	x22, [x25]
               	cmp	x22, #0x2
               	b.le	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x22, [x23]
               	ldr	x23, [x22]
               	cmp	x23, #0x9
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x22, x19
               	ldr	x23, [x22]
               	mov	x24, #0xd               // =13
               	str	x24, [x23]
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x24, #0x9               // =9
               	str	x24, [x0]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x3bb
               	mov	x25, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x22, x19
               	ldr	x24, [x22]
               	mov	x0, x25
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
               	mov	x25, #0x8               // =8
               	stur	x25, [x29, #-0x68]
               	b	<addr>
               	mov	x25, #0x1               // =1
               	stur	x25, [x29, #-0x68]
               	b	<addr>
               	ldur	x25, [x29, #-0x68]
               	str	x25, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x22, x19
               	ldr	x25, [x22]
               	add	x25, x25, #0x8
               	str	x25, [x22]
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
               	str	x22, [x25]
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x22, [x0]
               	add	x22, x22, #0x8
               	str	x22, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x25, x19
               	ldr	x0, [x25]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x25, #0xc               // =12
               	stur	x25, [x29, #-0x78]
               	b	<addr>
               	mov	x25, #0xb               // =11
               	stur	x25, [x29, #-0x78]
               	b	<addr>
               	ldur	x25, [x29, #-0x78]
               	str	x25, [x22]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x0, [x22]
               	cmp	x0, x20
               	b.lt	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x22, x19
               	ldr	x0, [x22]
               	stur	x0, [x29, #-0x8]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x0, [x22]
               	cmp	x0, #0x8e
               	b.ne	<addr>
               	b	<addr>
               	mov	x25, #0x0               // =0
               	mov	x0, x25
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
               	ldr	x25, [x0]
               	ldr	x0, [x25]
               	cmp	x0, #0xa
               	cset	x0, eq
               	stur	x0, [x29, #-0x80]
               	cbnz	x0, <addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x0, [x23]
               	cmp	x0, #0x8f
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x0, [x25]
               	ldr	x25, [x0]
               	cmp	x25, #0x9
               	cset	x25, eq
               	stur	x25, [x29, #-0x80]
               	b	<addr>
               	ldur	x25, [x29, #-0x80]
               	cbz	x25, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x25, [x0]
               	mov	x0, #0xd                // =13
               	str	x0, [x25]
               	b	<addr>
               	mov	x26, #0x8e              // =142
               	mov	x0, x26
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x26, [x0]
               	add	x26, x26, #0x8
               	str	x26, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x22, x19
               	ldur	x0, [x29, #-0x8]
               	str	x0, [x22]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x3f0
               	mov	x22, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x24, x19
               	ldr	x26, [x24]
               	mov	x0, x22
               	mov	x1, x26
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
               	mov	x23, #0xc               // =12
               	stur	x23, [x29, #-0x88]
               	b	<addr>
               	mov	x23, #0xb               // =11
               	stur	x23, [x29, #-0x88]
               	b	<addr>
               	ldur	x23, [x29, #-0x88]
               	str	x23, [x26]
               	b	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x24, [x0]
               	add	x24, x24, #0x8
               	str	x24, [x0]
               	mov	x26, #0x4               // =4
               	str	x26, [x24]
               	ldr	x22, [x0]
               	add	x22, x22, #0x8
               	str	x22, [x0]
               	stur	x22, [x29, #-0x10]
               	mov	x23, #0x8e              // =142
               	mov	x0, x23
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x23, [x0]
               	cmp	x23, #0x3a
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x23, [x25]
               	cmp	x23, #0x90
               	b.ne	<addr>
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	ldur	x22, [x29, #-0x10]
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x26, [x23]
               	add	x26, x26, #0x18
               	str	x26, [x22]
               	ldr	x24, [x23]
               	add	x24, x24, #0x8
               	str	x24, [x23]
               	mov	x26, #0x2               // =2
               	str	x26, [x24]
               	ldr	x22, [x23]
               	add	x22, x22, #0x8
               	str	x22, [x23]
               	stur	x22, [x29, #-0x10]
               	mov	x25, #0x8f              // =143
               	mov	x0, x25
               	bl	<addr>
               	ldur	x0, [x29, #-0x10]
               	ldr	x25, [x23]
               	add	x25, x25, #0x8
               	str	x25, [x0]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x40e
               	mov	x26, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x23, [x0]
               	mov	x0, x26
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
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x22, x19
               	ldr	x23, [x22]
               	add	x23, x23, #0x8
               	str	x23, [x22]
               	mov	x25, #0x5               // =5
               	str	x25, [x23]
               	ldr	x24, [x22]
               	add	x24, x24, #0x8
               	str	x24, [x22]
               	stur	x24, [x29, #-0x10]
               	mov	x26, #0x91              // =145
               	mov	x0, x26
               	bl	<addr>
               	ldur	x0, [x29, #-0x10]
               	ldr	x26, [x22]
               	add	x26, x26, #0x8
               	str	x26, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x22, x19
               	mov	x26, #0x1               // =1
               	str	x26, [x22]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x0, [x26]
               	cmp	x0, #0x91
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x26, x19
               	ldr	x24, [x26]
               	add	x24, x24, #0x8
               	str	x24, [x26]
               	mov	x22, #0x4               // =4
               	str	x22, [x24]
               	ldr	x23, [x26]
               	add	x23, x23, #0x8
               	str	x23, [x26]
               	stur	x23, [x29, #-0x10]
               	mov	x25, #0x92              // =146
               	mov	x0, x25
               	bl	<addr>
               	ldur	x0, [x29, #-0x10]
               	ldr	x25, [x26]
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
               	ldr	x0, [x25]
               	cmp	x0, #0x92
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x23, [x25]
               	add	x23, x23, #0x8
               	str	x23, [x25]
               	mov	x26, #0xd               // =13
               	str	x26, [x23]
               	mov	x22, #0x93              // =147
               	mov	x0, x22
               	bl	<addr>
               	ldr	x0, [x25]
               	add	x0, x0, #0x8
               	str	x0, [x25]
               	mov	x22, #0xe               // =14
               	str	x22, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x25, x19
               	mov	x22, #0x1               // =1
               	str	x22, [x25]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x0, [x22]
               	cmp	x0, #0x93
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x22, x19
               	ldr	x26, [x22]
               	add	x26, x26, #0x8
               	str	x26, [x22]
               	mov	x25, #0xd               // =13
               	str	x25, [x26]
               	mov	x24, #0x94              // =148
               	mov	x0, x24
               	bl	<addr>
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x24, #0xf               // =15
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
               	ldr	x0, [x24]
               	cmp	x0, #0x94
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x24, x19
               	ldr	x25, [x24]
               	add	x25, x25, #0x8
               	str	x25, [x24]
               	mov	x22, #0xd               // =13
               	str	x22, [x25]
               	mov	x23, #0x95              // =149
               	mov	x0, x23
               	bl	<addr>
               	ldr	x0, [x24]
               	add	x0, x0, #0x8
               	str	x0, [x24]
               	mov	x23, #0x10              // =16
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
               	ldr	x0, [x23]
               	cmp	x0, #0x95
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x22, [x23]
               	add	x22, x22, #0x8
               	str	x22, [x23]
               	mov	x24, #0xd               // =13
               	str	x24, [x22]
               	mov	x26, #0x97              // =151
               	mov	x0, x26
               	bl	<addr>
               	ldr	x0, [x23]
               	add	x0, x0, #0x8
               	str	x0, [x23]
               	mov	x26, #0x11              // =17
               	str	x26, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x23, x19
               	mov	x26, #0x1               // =1
               	str	x26, [x23]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x0, [x26]
               	cmp	x0, #0x96
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
               	mov	x25, #0x97              // =151
               	mov	x0, x25
               	bl	<addr>
               	ldr	x0, [x26]
               	add	x0, x0, #0x8
               	str	x0, [x26]
               	mov	x25, #0x12              // =18
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
               	ldr	x0, [x25]
               	cmp	x0, #0x97
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x23, [x25]
               	add	x23, x23, #0x8
               	str	x23, [x25]
               	mov	x26, #0xd               // =13
               	str	x26, [x23]
               	mov	x22, #0x9b              // =155
               	mov	x0, x22
               	bl	<addr>
               	ldr	x0, [x25]
               	add	x0, x0, #0x8
               	str	x0, [x25]
               	mov	x22, #0x13              // =19
               	str	x22, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x25, x19
               	mov	x22, #0x1               // =1
               	str	x22, [x25]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x0, [x22]
               	cmp	x0, #0x98
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x22, x19
               	ldr	x26, [x22]
               	add	x26, x26, #0x8
               	str	x26, [x22]
               	mov	x25, #0xd               // =13
               	str	x25, [x26]
               	mov	x24, #0x9b              // =155
               	mov	x0, x24
               	bl	<addr>
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x24, #0x14              // =20
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
               	ldr	x0, [x24]
               	cmp	x0, #0x99
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x24, x19
               	ldr	x25, [x24]
               	add	x25, x25, #0x8
               	str	x25, [x24]
               	mov	x22, #0xd               // =13
               	str	x22, [x25]
               	mov	x23, #0x9b              // =155
               	mov	x0, x23
               	bl	<addr>
               	ldr	x0, [x24]
               	add	x0, x0, #0x8
               	str	x0, [x24]
               	mov	x23, #0x15              // =21
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
               	ldr	x0, [x23]
               	cmp	x0, #0x9a
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x22, [x23]
               	add	x22, x22, #0x8
               	str	x22, [x23]
               	mov	x24, #0xd               // =13
               	str	x24, [x22]
               	mov	x26, #0x9b              // =155
               	mov	x0, x26
               	bl	<addr>
               	ldr	x0, [x23]
               	add	x0, x0, #0x8
               	str	x0, [x23]
               	mov	x26, #0x16              // =22
               	str	x26, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x23, x19
               	mov	x26, #0x1               // =1
               	str	x26, [x23]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x0, [x26]
               	cmp	x0, #0x9b
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
               	mov	x25, #0x9d              // =157
               	mov	x0, x25
               	bl	<addr>
               	ldr	x0, [x26]
               	add	x0, x0, #0x8
               	str	x0, [x26]
               	mov	x25, #0x17              // =23
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
               	ldr	x0, [x25]
               	cmp	x0, #0x9c
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x23, [x25]
               	add	x23, x23, #0x8
               	str	x23, [x25]
               	mov	x26, #0xd               // =13
               	str	x26, [x23]
               	mov	x22, #0x9d              // =157
               	mov	x0, x22
               	bl	<addr>
               	ldr	x0, [x25]
               	add	x0, x0, #0x8
               	str	x0, [x25]
               	mov	x22, #0x18              // =24
               	str	x22, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x25, x19
               	mov	x22, #0x1               // =1
               	str	x22, [x25]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x0, [x22]
               	cmp	x0, #0x9d
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x26, [x0]
               	add	x26, x26, #0x8
               	str	x26, [x0]
               	mov	x25, #0xd               // =13
               	str	x25, [x26]
               	mov	x22, #0x9f              // =159
               	mov	x0, x22
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	ldur	x22, [x29, #-0x8]
               	str	x22, [x0]
               	cmp	x22, #0x2
               	b.le	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x0, [x23]
               	cmp	x0, #0x9e
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x26, x19
               	ldr	x22, [x26]
               	add	x22, x22, #0x8
               	str	x22, [x26]
               	mov	x0, #0xd                // =13
               	str	x0, [x22]
               	ldr	x23, [x26]
               	add	x23, x23, #0x8
               	str	x23, [x26]
               	mov	x0, #0x1                // =1
               	str	x0, [x23]
               	ldr	x22, [x26]
               	add	x22, x22, #0x8
               	str	x22, [x26]
               	mov	x0, #0x8                // =8
               	str	x0, [x22]
               	ldr	x23, [x26]
               	add	x23, x23, #0x8
               	str	x23, [x26]
               	mov	x0, #0x1b               // =27
               	str	x0, [x23]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x26, [x0]
               	add	x26, x26, #0x8
               	str	x26, [x0]
               	mov	x23, #0x19              // =25
               	str	x23, [x26]
               	b	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x25, [x0]
               	add	x25, x25, #0x8
               	str	x25, [x0]
               	mov	x26, #0xd               // =13
               	str	x26, [x25]
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
               	ldr	x25, [x23]
               	cmp	x25, #0x9f
               	b.ne	<addr>
               	b	<addr>
               	ldur	x23, [x29, #-0x8]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	ldr	x25, [x0]
               	cmp	x23, x25
               	cset	x23, eq
               	stur	x23, [x29, #-0x90]
               	b	<addr>
               	ldur	x23, [x29, #-0x90]
               	cbz	x23, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x23, [x25]
               	add	x23, x23, #0x8
               	str	x23, [x25]
               	mov	x0, #0x1a               // =26
               	str	x0, [x23]
               	ldr	x22, [x25]
               	add	x22, x22, #0x8
               	str	x22, [x25]
               	mov	x0, #0xd                // =13
               	str	x0, [x22]
               	ldr	x23, [x25]
               	add	x23, x23, #0x8
               	str	x23, [x25]
               	mov	x0, #0x1                // =1
               	str	x0, [x23]
               	ldr	x22, [x25]
               	add	x22, x22, #0x8
               	str	x22, [x25]
               	mov	x23, #0x8               // =8
               	str	x23, [x22]
               	ldr	x21, [x25]
               	add	x21, x21, #0x8
               	str	x21, [x25]
               	mov	x23, #0x1c              // =28
               	str	x23, [x21]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x25, x19
               	str	x0, [x25]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x25, x19
               	ldur	x23, [x29, #-0x8]
               	str	x23, [x25]
               	cmp	x23, #0x2
               	b.le	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x23, [x0]
               	add	x23, x23, #0x8
               	str	x23, [x0]
               	mov	x25, #0xd               // =13
               	str	x25, [x23]
               	ldr	x21, [x0]
               	add	x21, x21, #0x8
               	str	x21, [x0]
               	mov	x25, #0x1               // =1
               	str	x25, [x21]
               	ldr	x23, [x0]
               	add	x23, x23, #0x8
               	str	x23, [x0]
               	mov	x25, #0x8               // =8
               	str	x25, [x23]
               	ldr	x21, [x0]
               	add	x21, x21, #0x8
               	str	x21, [x0]
               	mov	x25, #0x1b              // =27
               	str	x25, [x21]
               	ldr	x23, [x0]
               	add	x23, x23, #0x8
               	str	x23, [x0]
               	mov	x25, #0x1a              // =26
               	str	x25, [x23]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x0, [x25]
               	add	x0, x0, #0x8
               	str	x0, [x25]
               	mov	x23, #0x1a              // =26
               	str	x23, [x0]
               	b	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x26, x19
               	ldr	x25, [x26]
               	add	x25, x25, #0x8
               	str	x25, [x26]
               	mov	x23, #0xd               // =13
               	str	x23, [x25]
               	mov	x24, #0xa2              // =162
               	mov	x0, x24
               	bl	<addr>
               	ldr	x0, [x26]
               	add	x0, x0, #0x8
               	str	x0, [x26]
               	mov	x24, #0x1b              // =27
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
               	ldr	x0, [x24]
               	cmp	x0, #0xa0
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x24, x19
               	ldr	x23, [x24]
               	add	x23, x23, #0x8
               	str	x23, [x24]
               	mov	x26, #0xd               // =13
               	str	x26, [x23]
               	mov	x21, #0xa2              // =162
               	mov	x0, x21
               	bl	<addr>
               	ldr	x0, [x24]
               	add	x0, x0, #0x8
               	str	x0, [x24]
               	mov	x21, #0x1c              // =28
               	str	x21, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x24, x19
               	mov	x21, #0x1               // =1
               	str	x21, [x24]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x0, [x21]
               	cmp	x0, #0xa1
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x21, x19
               	ldr	x26, [x21]
               	add	x26, x26, #0x8
               	str	x26, [x21]
               	mov	x24, #0xd               // =13
               	str	x24, [x26]
               	mov	x25, #0xa2              // =162
               	mov	x0, x25
               	bl	<addr>
               	ldr	x0, [x21]
               	add	x0, x0, #0x8
               	str	x0, [x21]
               	mov	x25, #0x1d              // =29
               	str	x25, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x21, x19
               	mov	x25, #0x1               // =1
               	str	x25, [x21]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x0, [x25]
               	cmp	x0, #0xa2
               	cset	x0, eq
               	stur	x0, [x29, #-0x98]
               	cbnz	x0, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x0, [x25]
               	cmp	x0, #0xa3
               	cset	x0, eq
               	stur	x0, [x29, #-0x98]
               	b	<addr>
               	ldur	x0, [x29, #-0x98]
               	cbz	x0, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x0, [x25]
               	ldr	x25, [x0]
               	cmp	x25, #0xa
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x0, [x24]
               	cmp	x0, #0xa4
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x25, [x0]
               	mov	x21, #0xd               // =13
               	str	x21, [x25]
               	ldr	x26, [x0]
               	add	x26, x26, #0x8
               	str	x26, [x0]
               	mov	x21, #0xa               // =10
               	str	x21, [x26]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x0, [x25]
               	add	x0, x0, #0x8
               	str	x0, [x25]
               	mov	x24, #0xd               // =13
               	str	x24, [x0]
               	ldr	x21, [x25]
               	add	x21, x21, #0x8
               	str	x21, [x25]
               	mov	x24, #0x1               // =1
               	str	x24, [x21]
               	ldr	x0, [x25]
               	add	x0, x0, #0x8
               	str	x0, [x25]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x24, x19
               	ldr	x25, [x24]
               	cmp	x25, #0x2
               	b.le	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x21, x19
               	ldr	x0, [x21]
               	ldr	x21, [x0]
               	cmp	x21, #0x9
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x21, [x0]
               	mov	x26, #0xd               // =13
               	str	x26, [x21]
               	ldr	x25, [x0]
               	add	x25, x25, #0x8
               	str	x25, [x0]
               	mov	x26, #0x9               // =9
               	str	x26, [x25]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x42d
               	mov	x24, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x26, [x0]
               	mov	x0, x24
               	mov	x1, x26
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x25, #0xffff            // =65535
               	movk	x25, #0xffff, lsl #16
               	movk	x25, #0xffff, lsl #32
               	movk	x25, #0xffff, lsl #48
               	mov	x0, x25
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	mov	x24, #0x8               // =8
               	stur	x24, [x29, #-0xa0]
               	b	<addr>
               	mov	x24, #0x1               // =1
               	stur	x24, [x29, #-0xa0]
               	b	<addr>
               	ldur	x24, [x29, #-0xa0]
               	str	x24, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x24, [x25]
               	add	x24, x24, #0x8
               	str	x24, [x25]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x25, [x0]
               	cmp	x25, #0xa2
               	b.ne	<addr>
               	mov	x0, #0x19               // =25
               	stur	x0, [x29, #-0xa8]
               	b	<addr>
               	mov	x0, #0x1a               // =26
               	stur	x0, [x29, #-0xa8]
               	b	<addr>
               	ldur	x0, [x29, #-0xa8]
               	str	x0, [x24]
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x0, [x25]
               	add	x0, x0, #0x8
               	str	x0, [x25]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x24, x19
               	ldr	x25, [x24]
               	cmp	x25, #0x0
               	b.ne	<addr>
               	mov	x24, #0xc               // =12
               	stur	x24, [x29, #-0xb0]
               	b	<addr>
               	mov	x24, #0xb               // =11
               	stur	x24, [x29, #-0xb0]
               	b	<addr>
               	ldur	x24, [x29, #-0xb0]
               	str	x24, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x24, [x25]
               	add	x24, x24, #0x8
               	str	x24, [x25]
               	mov	x0, #0xd                // =13
               	str	x0, [x24]
               	ldr	x21, [x25]
               	add	x21, x21, #0x8
               	str	x21, [x25]
               	mov	x0, #0x1                // =1
               	str	x0, [x21]
               	ldr	x24, [x25]
               	add	x24, x24, #0x8
               	str	x24, [x25]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	ldr	x25, [x0]
               	cmp	x25, #0x2
               	b.le	<addr>
               	mov	x0, #0x8                // =8
               	stur	x0, [x29, #-0xb8]
               	b	<addr>
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0xb8]
               	b	<addr>
               	ldur	x0, [x29, #-0xb8]
               	str	x0, [x24]
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x0, [x25]
               	add	x0, x0, #0x8
               	str	x0, [x25]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x25, [x24]
               	cmp	x25, #0xa2
               	b.ne	<addr>
               	mov	x24, #0x1a              // =26
               	stur	x24, [x29, #-0xc0]
               	b	<addr>
               	mov	x24, #0x19              // =25
               	stur	x24, [x29, #-0xc0]
               	b	<addr>
               	ldur	x24, [x29, #-0xc0]
               	str	x24, [x0]
               	bl	<addr>
               	b	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x26, [x0]
               	add	x26, x26, #0x8
               	str	x26, [x0]
               	mov	x25, #0xd               // =13
               	str	x25, [x26]
               	mov	x24, #0x8e              // =142
               	mov	x0, x24
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x24, [x0]
               	cmp	x24, #0x5d
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x486
               	mov	x23, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x25, x19
               	ldr	x21, [x25]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x26, [x25]
               	mov	x0, x23
               	mov	x2, x26
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x25, #0xffff            // =65535
               	movk	x25, #0xffff, lsl #16
               	movk	x25, #0xffff, lsl #32
               	movk	x25, #0xffff, lsl #48
               	mov	x0, x25
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	ldur	x26, [x29, #-0x8]
               	cmp	x26, #0x2
               	b.le	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x44f
               	mov	x25, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x24, [x0]
               	mov	x0, x25
               	mov	x1, x24
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x26, #0xffff            // =65535
               	movk	x26, #0xffff, lsl #16
               	movk	x26, #0xffff, lsl #32
               	movk	x26, #0xffff, lsl #48
               	mov	x0, x26
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x26, [x0]
               	add	x26, x26, #0x8
               	str	x26, [x0]
               	mov	x25, #0xd               // =13
               	str	x25, [x26]
               	ldr	x21, [x0]
               	add	x21, x21, #0x8
               	str	x21, [x0]
               	mov	x25, #0x1               // =1
               	str	x25, [x21]
               	ldr	x26, [x0]
               	add	x26, x26, #0x8
               	str	x26, [x0]
               	mov	x25, #0x8               // =8
               	str	x25, [x26]
               	ldr	x21, [x0]
               	add	x21, x21, #0x8
               	str	x21, [x0]
               	mov	x25, #0x1b              // =27
               	str	x25, [x21]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x0, [x25]
               	add	x0, x0, #0x8
               	str	x0, [x25]
               	mov	x24, #0x19              // =25
               	str	x24, [x0]
               	ldr	x26, [x25]
               	add	x26, x26, #0x8
               	str	x26, [x25]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x24, x19
               	ldur	x25, [x29, #-0x8]
               	sub	x25, x25, #0x2
               	str	x25, [x24]
               	cmp	x25, #0x0
               	b.ne	<addr>
               	b	<addr>
               	ldur	x25, [x29, #-0x8]
               	cmp	x25, #0x2
               	b.ge	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x46b
               	mov	x24, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x25, x19
               	ldr	x23, [x25]
               	mov	x0, x24
               	mov	x1, x23
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x25, #0xffff            // =65535
               	movk	x25, #0xffff, lsl #16
               	movk	x25, #0xffff, lsl #32
               	movk	x25, #0xffff, lsl #48
               	mov	x0, x25
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
               	str	x0, [x26]
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
               	ldr	x14, [x15]
               	cmp	x14, #0x89
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x20, [x0]
               	cmp	x20, #0x28
               	b.ne	<addr>
               	b	<addr>
               	mov	x20, #0x0               // =0
               	mov	x0, x20
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
               	mov	x12, x19
               	ldr	x0, [x12]
               	cmp	x0, #0x8d
               	b.ne	<addr>
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	mov	x20, #0x8e              // =142
               	mov	x0, x20
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x20, [x0]
               	cmp	x20, #0x29
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x4a0
               	mov	x21, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x20, [x0]
               	mov	x0, x21
               	mov	x1, x20
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
               	mov	x21, x19
               	ldr	x0, [x21]
               	add	x0, x0, #0x8
               	str	x0, [x21]
               	mov	x22, #0x4               // =4
               	str	x22, [x0]
               	ldr	x12, [x21]
               	add	x12, x12, #0x8
               	str	x12, [x21]
               	stur	x12, [x29, #-0x10]
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x12, [x0]
               	cmp	x12, #0x87
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x4b9
               	mov	x22, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x20, [x0]
               	mov	x0, x22
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
               	ldur	x0, [x29, #-0x10]
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x12, x19
               	ldr	x21, [x12]
               	add	x21, x21, #0x18
               	str	x21, [x0]
               	ldr	x22, [x12]
               	add	x22, x22, #0x8
               	str	x22, [x12]
               	mov	x21, #0x2               // =2
               	str	x21, [x22]
               	ldr	x0, [x12]
               	add	x0, x0, #0x8
               	str	x0, [x12]
               	stur	x0, [x29, #-0x10]
               	bl	<addr>
               	bl	<addr>
               	b	<addr>
               	ldur	x21, [x29, #-0x10]
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x12, [x0]
               	add	x12, x12, #0x8
               	str	x12, [x21]
               	b	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x20, [x0]
               	add	x20, x20, #0x8
               	stur	x20, [x29, #-0x8]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x20, [x0]
               	cmp	x20, #0x28
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x20, [x22]
               	cmp	x20, #0x8b
               	b.ne	<addr>
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	mov	x20, #0x8e              // =142
               	mov	x0, x20
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x20, [x0]
               	cmp	x20, #0x29
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x4d3
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
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x20, x19
               	ldr	x0, [x20]
               	add	x0, x0, #0x8
               	str	x0, [x20]
               	mov	x21, #0x4               // =4
               	str	x21, [x0]
               	ldr	x22, [x20]
               	add	x22, x22, #0x8
               	str	x22, [x20]
               	stur	x22, [x29, #-0x10]
               	bl	<addr>
               	ldr	x0, [x20]
               	add	x0, x0, #0x8
               	str	x0, [x20]
               	mov	x22, #0x2               // =2
               	str	x22, [x0]
               	ldr	x21, [x20]
               	add	x21, x21, #0x8
               	str	x21, [x20]
               	ldur	x22, [x29, #-0x8]
               	str	x22, [x21]
               	ldur	x0, [x29, #-0x10]
               	ldr	x22, [x20]
               	add	x22, x22, #0x8
               	str	x22, [x0]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x4ec
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
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x20, [x0]
               	cmp	x20, #0x3b
               	b.eq	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x0, [x23]
               	cmp	x0, #0x7b
               	b.ne	<addr>
               	b	<addr>
               	mov	x23, #0x8e              // =142
               	mov	x0, x23
               	bl	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x0, [x23]
               	add	x0, x0, #0x8
               	str	x0, [x23]
               	mov	x22, #0x8               // =8
               	str	x22, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x22, [x23]
               	cmp	x22, #0x3b
               	b.ne	<addr>
               	bl	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x506
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
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x0, [x22]
               	cmp	x0, #0x3b
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x0, [x22]
               	cmp	x0, #0x7d
               	b.eq	<addr>
               	bl	<addr>
               	mov	x22, x0
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x22, #0x8e              // =142
               	mov	x0, x22
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x22, [x0]
               	cmp	x22, #0x3b
               	b.ne	<addr>
               	bl	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x51e
               	mov	x23, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x22, [x0]
               	mov	x0, x23
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
               	ldr	x15, [x14]
               	ldrb	w14, [x15]
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
               	ldr	x14, [x15]
               	add	x14, x14, #0x1
               	ldrb	w15, [x14]
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
               	ldr	x15, [x13]
               	ldrb	w13, [x15]
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
               	ldr	x13, [x15]
               	add	x13, x13, #0x1
               	ldrb	w15, [x13]
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
               	ldr	x21, [x20]
               	mov	x22, #0x0               // =0
               	mov	x0, x21
               	mov	x1, x22
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, x0
               	cmp	x20, #0x0
               	b.ge	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x554
               	mov	x23, x19
               	ldur	x22, [x29, #0x20]
               	ldr	x21, [x22]
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
               	mov	x22, x19
               	mov	x0, x21
               	bl	<addr>
               	str	x0, [x22]
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
               	mov	x22, x19
               	mov	x0, x22
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
               	mov	x22, x19
               	mov	x0, x22
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
               	ldr	x22, [x24]
               	mov	x26, #0x0               // =0
               	mov	x0, x22
               	mov	x2, x21
               	mov	x1, x26
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x25, [x0]
               	mov	x0, x25
               	mov	x2, x21
               	mov	x1, x26
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x198
               	mov	x0, x19
               	ldr	x22, [x0]
               	mov	x0, x22
               	mov	x2, x21
               	mov	x1, x26
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x0, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x5eb
               	mov	x22, x19
               	str	x22, [x0]
               	mov	x26, #0x86              // =134
               	stur	x26, [x29, #-0x58]
               	b	<addr>
               	ldur	x26, [x29, #-0x58]
               	cmp	x26, #0x8d
               	b.gt	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x0, x19
               	ldr	x26, [x0]
               	sub	x0, x29, #0x58
               	ldr	x22, [x0]
               	add	x23, x22, #0x1
               	str	x23, [x0]
               	str	x22, [x26]
               	b	<addr>
               	mov	x22, #0x1e              // =30
               	stur	x22, [x29, #-0x58]
               	b	<addr>
               	ldur	x22, [x29, #-0x58]
               	cmp	x22, #0x26
               	b.gt	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x0, x19
               	ldr	x22, [x0]
               	add	x22, x22, #0x18
               	mov	x26, #0x82              // =130
               	str	x26, [x22]
               	ldr	x23, [x0]
               	add	x23, x23, #0x20
               	mov	x26, #0x1               // =1
               	str	x26, [x23]
               	ldr	x22, [x0]
               	add	x22, x22, #0x28
               	sub	x0, x29, #0x58
               	ldr	x26, [x0]
               	add	x23, x26, #0x1
               	str	x23, [x0]
               	str	x26, [x22]
               	b	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x24, x19
               	ldr	x25, [x24]
               	mov	x22, #0x86              // =134
               	str	x22, [x25]
               	bl	<addr>
               	ldr	x23, [x24]
               	adrp	x19, <page>
               	add	x19, x19, #0x190
               	mov	x27, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x24, x19
               	mov	x0, x21
               	bl	<addr>
               	str	x0, [x24]
               	str	x0, [x27]
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
               	ldr	x26, [x25]
               	sub	x22, x21, #0x1
               	mov	x0, x20
               	mov	x2, x22
               	mov	x1, x26
               	bl	<addr>
               	sxtw	x0, w0
               	stur	x0, [x29, #-0x58]
               	cmp	x0, #0x0
               	b.gt	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x677
               	mov	x27, x19
               	ldur	x22, [x29, #-0x58]
               	mov	x0, x27
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
               	add	x19, x19, #0x188
               	mov	x22, x19
               	ldr	x0, [x22]
               	ldur	x22, [x29, #-0x58]
               	add	x0, x0, x22
               	mov	x22, #0x0               // =0
               	strb	w22, [x0]
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	mov	x20, #0x1               // =1
               	str	x20, [x0]
               	bl	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	ldr	x0, [x20]
               	cbz	x0, <addr>
               	mov	x20, #0x1               // =1
               	stur	x20, [x29, #-0x10]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x20, [x0]
               	cmp	x20, #0x8a
               	b.ne	<addr>
               	b	<addr>
               	add	x23, x23, #0x28
               	ldr	x25, [x23]
               	stur	x25, [x29, #-0x30]
               	cmp	x25, #0x0
               	b.ne	<addr>
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	ldr	x0, [x20]
               	cmp	x0, #0x86
               	b.ne	<addr>
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x10]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x26, [x0]
               	cmp	x26, #0x88
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x26, [x0]
               	cmp	x26, #0x7b
               	b.eq	<addr>
               	b	<addr>
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x0, [x26]
               	cmp	x0, #0x7b
               	b.ne	<addr>
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x58]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x20, [x0]
               	cmp	x20, #0x7d
               	b.eq	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x20, [x0]
               	cmp	x20, #0x85
               	b.eq	<addr>
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x68b
               	mov	x26, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x20, x19
               	ldr	x25, [x20]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	ldr	x22, [x20]
               	mov	x0, x26
               	mov	x2, x22
               	mov	x1, x25
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0xffff            // =65535
               	movk	x20, #0xffff, lsl #16
               	movk	x20, #0xffff, lsl #32
               	movk	x20, #0xffff, lsl #48
               	mov	x0, x20
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
               	ldr	x20, [x0]
               	cmp	x20, #0x8e
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x20, [x0]
               	cmp	x20, #0x80
               	b.eq	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x27, x19
               	ldr	x0, [x27]
               	add	x0, x0, #0x18
               	mov	x22, #0x80              // =128
               	str	x22, [x0]
               	ldr	x26, [x27]
               	add	x26, x26, #0x20
               	mov	x22, #0x1               // =1
               	str	x22, [x26]
               	ldr	x0, [x27]
               	add	x0, x0, #0x28
               	sub	x27, x29, #0x58
               	ldr	x22, [x27]
               	add	x26, x22, #0x1
               	str	x26, [x27]
               	str	x22, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x22, [x24]
               	cmp	x22, #0x2c
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x6a7
               	mov	x22, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x20, x19
               	ldr	x27, [x20]
               	mov	x0, x22
               	mov	x1, x27
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
               	mov	x27, x19
               	ldr	x0, [x27]
               	stur	x0, [x29, #-0x58]
               	bl	<addr>
               	b	<addr>
               	bl	<addr>
               	mov	x20, x0
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	ldr	x0, [x20]
               	cmp	x0, #0x3b
               	cset	x0, ne
               	stur	x0, [x29, #-0xb8]
               	cbz	x0, <addr>
               	b	<addr>
               	ldur	x20, [x29, #-0x10]
               	stur	x20, [x29, #-0x18]
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	ldr	x0, [x20]
               	cmp	x0, #0x7d
               	cset	x0, ne
               	stur	x0, [x29, #-0xb8]
               	b	<addr>
               	ldur	x0, [x29, #-0xb8]
               	cbz	x0, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	ldr	x0, [x20]
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
               	ldr	x24, [x0]
               	cmp	x24, #0x85
               	b.eq	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x6c1
               	mov	x20, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x24, x19
               	ldr	x25, [x24]
               	mov	x0, x20
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
               	add	x0, x0, #0x18
               	ldr	x25, [x0]
               	cbz	x25, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x6dd
               	mov	x24, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x25, x19
               	ldr	x22, [x25]
               	mov	x0, x24
               	mov	x1, x22
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x25, #0xffff            // =65535
               	movk	x25, #0xffff, lsl #16
               	movk	x25, #0xffff, lsl #32
               	movk	x25, #0xffff, lsl #48
               	mov	x0, x25
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
               	ldr	x25, [x0]
               	add	x25, x25, #0x20
               	ldur	x0, [x29, #-0x18]
               	str	x0, [x25]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x0, [x24]
               	cmp	x0, #0x28
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x24, x19
               	ldr	x0, [x24]
               	add	x0, x0, #0x18
               	mov	x25, #0x81              // =129
               	str	x25, [x0]
               	ldr	x26, [x24]
               	add	x26, x26, #0x28
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x24, x19
               	ldr	x25, [x24]
               	add	x25, x25, #0x8
               	str	x25, [x26]
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x58]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x0, [x25]
               	cmp	x0, #0x2c
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x22, x19
               	ldr	x25, [x22]
               	add	x25, x25, #0x18
               	mov	x0, #0x83               // =131
               	str	x0, [x25]
               	ldr	x27, [x22]
               	add	x27, x27, #0x28
               	adrp	x19, <page>
               	add	x19, x19, #0x198
               	mov	x22, x19
               	ldr	x0, [x22]
               	str	x0, [x27]
               	ldr	x25, [x22]
               	add	x25, x25, #0x8
               	str	x25, [x22]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x25, [x0]
               	cmp	x25, #0x29
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0x18]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x25, x19
               	ldr	x0, [x25]
               	cmp	x0, #0x8a
               	b.ne	<addr>
               	b	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x20, [x0]
               	cmp	x20, #0x7b
               	b.eq	<addr>
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x0, [x22]
               	cmp	x0, #0x86
               	b.ne	<addr>
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x18]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x25, [x0]
               	cmp	x25, #0x9f
               	b.ne	<addr>
               	bl	<addr>
               	ldur	x0, [x29, #-0x18]
               	add	x0, x0, #0x2
               	stur	x0, [x29, #-0x18]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x25, [x0]
               	cmp	x25, #0x85
               	b.eq	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x6fe
               	mov	x22, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x25, x19
               	ldr	x20, [x25]
               	mov	x0, x22
               	mov	x1, x20
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
               	mov	x20, x19
               	ldr	x0, [x20]
               	add	x0, x0, #0x18
               	ldr	x20, [x0]
               	cmp	x20, #0x84
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x71d
               	mov	x25, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x20, x19
               	ldr	x26, [x20]
               	mov	x0, x25
               	mov	x1, x26
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
               	mov	x26, x19
               	ldr	x0, [x26]
               	add	x0, x0, #0x30
               	ldr	x25, [x26]
               	add	x25, x25, #0x18
               	ldr	x24, [x25]
               	str	x24, [x0]
               	ldr	x25, [x26]
               	add	x25, x25, #0x18
               	mov	x24, #0x84              // =132
               	str	x24, [x25]
               	ldr	x0, [x26]
               	add	x0, x0, #0x38
               	ldr	x24, [x26]
               	add	x24, x24, #0x20
               	ldr	x25, [x24]
               	str	x25, [x0]
               	ldr	x24, [x26]
               	add	x24, x24, #0x20
               	ldur	x25, [x29, #-0x18]
               	str	x25, [x24]
               	ldr	x0, [x26]
               	add	x0, x0, #0x40
               	ldr	x25, [x26]
               	add	x25, x25, #0x28
               	ldr	x24, [x25]
               	str	x24, [x0]
               	ldr	x25, [x26]
               	add	x25, x25, #0x28
               	sub	x26, x29, #0x58
               	ldr	x24, [x26]
               	add	x0, x24, #0x1
               	str	x0, [x26]
               	str	x24, [x25]
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x24, [x0]
               	cmp	x24, #0x2c
               	b.ne	<addr>
               	bl	<addr>
               	mov	x20, x0
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x741
               	mov	x24, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x20, x19
               	ldr	x22, [x20]
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
               	add	x19, x19, #0x1d8
               	mov	x22, x19
               	sub	x0, x29, #0x58
               	ldr	x24, [x0]
               	add	x24, x24, #0x1
               	str	x24, [x0]
               	str	x24, [x22]
               	bl	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x0, [x24]
               	cmp	x0, #0x8a
               	cset	x0, eq
               	stur	x0, [x29, #-0xc0]
               	cbnz	x0, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x0, [x24]
               	cmp	x0, #0x8a
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x25, x19
               	ldr	x0, [x25]
               	add	x0, x0, #0x8
               	str	x0, [x25]
               	mov	x20, #0x6               // =6
               	str	x20, [x0]
               	ldr	x22, [x25]
               	add	x22, x22, #0x8
               	str	x22, [x25]
               	ldur	x20, [x29, #-0x58]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d8
               	mov	x25, x19
               	ldr	x0, [x25]
               	sub	x20, x20, x0
               	str	x20, [x22]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x0, [x24]
               	cmp	x0, #0x86
               	cset	x0, eq
               	stur	x0, [x29, #-0xc0]
               	b	<addr>
               	ldur	x0, [x29, #-0xc0]
               	cbz	x0, <addr>
               	b	<addr>
               	mov	x24, #0x1               // =1
               	stur	x24, [x29, #-0xc8]
               	b	<addr>
               	mov	x24, #0x0               // =0
               	stur	x24, [x29, #-0xc8]
               	b	<addr>
               	ldur	x24, [x29, #-0xc8]
               	stur	x24, [x29, #-0x10]
               	bl	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x0, [x24]
               	cmp	x0, #0x3b
               	b.eq	<addr>
               	ldur	x24, [x29, #-0x10]
               	stur	x24, [x29, #-0x18]
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x0, [x24]
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
               	ldr	x20, [x0]
               	cmp	x20, #0x85
               	b.eq	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x75e
               	mov	x24, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x20, x19
               	ldr	x25, [x20]
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
               	add	x0, x0, #0x18
               	ldr	x25, [x0]
               	cmp	x25, #0x84
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x779
               	mov	x20, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x25, x19
               	ldr	x22, [x25]
               	mov	x0, x20
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
               	ldr	x0, [x22]
               	add	x0, x0, #0x30
               	ldr	x20, [x22]
               	add	x20, x20, #0x18
               	ldr	x27, [x20]
               	str	x27, [x0]
               	ldr	x20, [x22]
               	add	x20, x20, #0x18
               	mov	x27, #0x84              // =132
               	str	x27, [x20]
               	ldr	x0, [x22]
               	add	x0, x0, #0x38
               	ldr	x27, [x22]
               	add	x27, x27, #0x20
               	ldr	x20, [x27]
               	str	x20, [x0]
               	ldr	x27, [x22]
               	add	x27, x27, #0x20
               	ldur	x20, [x29, #-0x18]
               	str	x20, [x27]
               	ldr	x0, [x22]
               	add	x0, x0, #0x40
               	ldr	x20, [x22]
               	add	x20, x20, #0x28
               	ldr	x27, [x20]
               	str	x27, [x0]
               	ldr	x20, [x22]
               	add	x20, x20, #0x28
               	sub	x22, x29, #0x58
               	ldr	x27, [x22]
               	add	x27, x27, #0x1
               	str	x27, [x22]
               	str	x27, [x20]
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x27, [x0]
               	cmp	x27, #0x2c
               	b.ne	<addr>
               	bl	<addr>
               	mov	x25, x0
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	ldr	x0, [x20]
               	cmp	x0, #0x7d
               	b.eq	<addr>
               	bl	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x27, x19
               	ldr	x0, [x27]
               	add	x0, x0, #0x8
               	str	x0, [x27]
               	mov	x22, #0x8               // =8
               	str	x22, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x27, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1b8
               	mov	x22, x19
               	ldr	x0, [x22]
               	str	x0, [x27]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x0, x19
               	ldr	x22, [x0]
               	ldr	x0, [x22]
               	cbz	x0, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x22, x19
               	ldr	x0, [x22]
               	add	x0, x0, #0x18
               	ldr	x22, [x0]
               	cmp	x22, #0x84
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x0, x19
               	ldr	x22, [x0]
               	add	x22, x22, #0x18
               	ldr	x27, [x0]
               	add	x27, x27, #0x30
               	ldr	x25, [x27]
               	str	x25, [x22]
               	ldr	x27, [x0]
               	add	x27, x27, #0x20
               	ldr	x25, [x0]
               	add	x25, x25, #0x38
               	ldr	x22, [x25]
               	str	x22, [x27]
               	ldr	x25, [x0]
               	add	x25, x25, #0x28
               	ldr	x22, [x0]
               	add	x22, x22, #0x40
               	ldr	x0, [x22]
               	str	x0, [x25]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x0, x19
               	ldr	x22, [x0]
               	add	x22, x22, #0x48
               	str	x22, [x0]
               	b	<addr>
               	bl	<addr>
               	mov	x25, x0
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x799
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
               	adrp	x19, <page>
               	add	x19, x19, #0x1e8
               	mov	x20, x19
               	ldr	x0, [x20]
               	cbz	x0, <addr>
               	mov	x20, #0x0               // =0
               	mov	x0, x20
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
               	ldur	x0, [x29, #-0x38]
               	add	x0, x0, x21
               	stur	x0, [x29, #-0x38]
               	stur	x0, [x29, #-0x40]
               	sub	x21, x29, #0x38
               	ldr	x0, [x21]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x0, x0, x17
               	str	x0, [x21]
               	mov	x20, #0x26              // =38
               	str	x20, [x0]
               	sub	x21, x29, #0x38
               	ldr	x20, [x21]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x20, x20, x17
               	str	x20, [x21]
               	mov	x0, #0xd                // =13
               	str	x0, [x20]
               	ldur	x21, [x29, #-0x38]
               	stur	x21, [x29, #-0x60]
               	sub	x0, x29, #0x38
               	ldr	x21, [x0]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x21, x21, x17
               	str	x21, [x0]
               	ldur	x20, [x29, #0x10]
               	str	x20, [x21]
               	sub	x0, x29, #0x38
               	ldr	x20, [x0]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x20, x20, x17
               	str	x20, [x0]
               	ldur	x21, [x29, #0x20]
               	str	x21, [x20]
               	sub	x0, x29, #0x38
               	ldr	x21, [x0]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x21, x21, x17
               	str	x21, [x0]
               	ldur	x20, [x29, #-0x60]
               	str	x20, [x21]
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x50]
               	b	<addr>
               	mov	x0, #0x1                // =1
               	cbz	x0, <addr>
               	sub	x20, x29, #0x30
               	ldr	x0, [x20]
               	add	x21, x0, #0x8
               	str	x21, [x20]
               	ldr	x25, [x0]
               	stur	x25, [x29, #-0x58]
               	sub	x0, x29, #0x50
               	ldr	x25, [x0]
               	add	x25, x25, #0x1
               	str	x25, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1f0
               	mov	x21, x19
               	ldr	x25, [x21]
               	cbz	x25, <addr>
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
               	mov	x23, x19
               	ldur	x21, [x29, #-0x50]
               	adrp	x19, <page>
               	add	x19, x19, #0x7b6
               	mov	x0, x19
               	ldur	x20, [x29, #-0x58]
               	mov	x17, #0x5               // =5
               	mul	x20, x20, x17
               	add	x25, x0, x20
               	mov	x0, x23
               	mov	x2, x25
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	ldur	x0, [x29, #-0x58]
               	cmp	x0, #0x7
               	b.gt	<addr>
               	b	<addr>
               	ldur	x21, [x29, #-0x58]
               	cmp	x21, #0x0
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x87a
               	mov	x22, x19
               	ldur	x0, [x29, #-0x30]
               	ldr	x25, [x0]
               	mov	x0, x22
               	mov	x1, x25
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x87f
               	mov	x21, x19
               	mov	x0, x21
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	ldur	x0, [x29, #-0x40]
               	sub	x21, x29, #0x30
               	ldr	x22, [x21]
               	add	x23, x22, #0x8
               	str	x23, [x21]
               	ldr	x20, [x22]
               	lsl	x20, x20, #3
               	add	x0, x0, x20
               	stur	x0, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x0, [x29, #-0x58]
               	cmp	x0, #0x1
               	b.ne	<addr>
               	sub	x20, x29, #0x30
               	ldr	x0, [x20]
               	add	x22, x0, #0x8
               	str	x22, [x20]
               	ldr	x23, [x0]
               	stur	x23, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x23, [x29, #-0x58]
               	cmp	x23, #0x2
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x30]
               	ldr	x23, [x0]
               	stur	x23, [x29, #-0x30]
               	b	<addr>
               	b	<addr>
               	ldur	x23, [x29, #-0x58]
               	cmp	x23, #0x3
               	b.ne	<addr>
               	sub	x0, x29, #0x38
               	ldr	x23, [x0]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x23, x23, x17
               	str	x23, [x0]
               	ldur	x22, [x29, #-0x30]
               	add	x22, x22, #0x8
               	str	x22, [x23]
               	ldur	x0, [x29, #-0x30]
               	ldr	x22, [x0]
               	stur	x22, [x29, #-0x30]
               	b	<addr>
               	b	<addr>
               	ldur	x22, [x29, #-0x58]
               	cmp	x22, #0x4
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x48]
               	cbz	x0, <addr>
               	b	<addr>
               	b	<addr>
               	ldur	x0, [x29, #-0x58]
               	cmp	x0, #0x5
               	b.ne	<addr>
               	b	<addr>
               	ldur	x22, [x29, #-0x30]
               	add	x22, x22, #0x8
               	stur	x22, [x29, #-0xd0]
               	b	<addr>
               	ldur	x22, [x29, #-0x30]
               	ldr	x0, [x22]
               	stur	x0, [x29, #-0xd0]
               	b	<addr>
               	ldur	x0, [x29, #-0xd0]
               	stur	x0, [x29, #-0x30]
               	b	<addr>
               	ldur	x22, [x29, #-0x48]
               	cbz	x22, <addr>
               	b	<addr>
               	b	<addr>
               	ldur	x22, [x29, #-0x58]
               	cmp	x22, #0x6
               	b.ne	<addr>
               	b	<addr>
               	ldur	x0, [x29, #-0x30]
               	ldr	x22, [x0]
               	stur	x22, [x29, #-0xd8]
               	b	<addr>
               	ldur	x22, [x29, #-0x30]
               	add	x22, x22, #0x8
               	stur	x22, [x29, #-0xd8]
               	b	<addr>
               	ldur	x22, [x29, #-0xd8]
               	stur	x22, [x29, #-0x30]
               	b	<addr>
               	sub	x0, x29, #0x38
               	ldr	x22, [x0]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x22, x22, x17
               	str	x22, [x0]
               	ldur	x23, [x29, #-0x40]
               	str	x23, [x22]
               	ldur	x0, [x29, #-0x38]
               	stur	x0, [x29, #-0x40]
               	sub	x23, x29, #0x30
               	ldr	x22, [x23]
               	add	x20, x22, #0x8
               	str	x20, [x23]
               	ldr	x21, [x22]
               	lsl	x21, x21, #3
               	sub	x0, x0, x21
               	stur	x0, [x29, #-0x38]
               	b	<addr>
               	b	<addr>
               	ldur	x0, [x29, #-0x58]
               	cmp	x0, #0x7
               	b.ne	<addr>
               	ldur	x21, [x29, #-0x38]
               	sub	x0, x29, #0x30
               	ldr	x22, [x0]
               	add	x20, x22, #0x8
               	str	x20, [x0]
               	ldr	x23, [x22]
               	lsl	x23, x23, #3
               	add	x21, x21, x23
               	stur	x21, [x29, #-0x38]
               	b	<addr>
               	b	<addr>
               	ldur	x21, [x29, #-0x58]
               	cmp	x21, #0x8
               	b.ne	<addr>
               	ldur	x23, [x29, #-0x40]
               	stur	x23, [x29, #-0x38]
               	sub	x21, x29, #0x38
               	ldr	x23, [x21]
               	add	x22, x23, #0x8
               	str	x22, [x21]
               	ldr	x20, [x23]
               	stur	x20, [x29, #-0x40]
               	sub	x23, x29, #0x38
               	ldr	x20, [x23]
               	add	x22, x20, #0x8
               	str	x22, [x23]
               	ldr	x21, [x20]
               	stur	x21, [x29, #-0x30]
               	b	<addr>
               	b	<addr>
               	ldur	x21, [x29, #-0x58]
               	cmp	x21, #0x9
               	b.ne	<addr>
               	ldur	x20, [x29, #-0x48]
               	ldr	x21, [x20]
               	stur	x21, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x21, [x29, #-0x58]
               	cmp	x21, #0xa
               	b.ne	<addr>
               	ldur	x20, [x29, #-0x48]
               	ldrb	w21, [x20]
               	stur	x21, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x21, [x29, #-0x58]
               	cmp	x21, #0xb
               	b.ne	<addr>
               	sub	x20, x29, #0x38
               	ldr	x21, [x20]
               	add	x22, x21, #0x8
               	str	x22, [x20]
               	ldr	x23, [x21]
               	ldur	x21, [x29, #-0x48]
               	str	x21, [x23]
               	b	<addr>
               	b	<addr>
               	ldur	x21, [x29, #-0x58]
               	cmp	x21, #0xc
               	b.ne	<addr>
               	sub	x22, x29, #0x38
               	ldr	x21, [x22]
               	add	x23, x21, #0x8
               	str	x23, [x22]
               	ldr	x20, [x21]
               	ldur	x21, [x29, #-0x48]
               	strb	w21, [x20]
               	stur	x21, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x21, [x29, #-0x58]
               	cmp	x21, #0xd
               	b.ne	<addr>
               	sub	x23, x29, #0x38
               	ldr	x21, [x23]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x21, x21, x17
               	str	x21, [x23]
               	ldur	x20, [x29, #-0x48]
               	str	x20, [x21]
               	b	<addr>
               	b	<addr>
               	ldur	x20, [x29, #-0x58]
               	cmp	x20, #0xe
               	b.ne	<addr>
               	sub	x23, x29, #0x38
               	ldr	x20, [x23]
               	add	x21, x20, #0x8
               	str	x21, [x23]
               	ldr	x22, [x20]
               	ldur	x20, [x29, #-0x48]
               	orr	x22, x22, x20
               	stur	x22, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x22, [x29, #-0x58]
               	cmp	x22, #0xf
               	b.ne	<addr>
               	sub	x20, x29, #0x38
               	ldr	x22, [x20]
               	add	x21, x22, #0x8
               	str	x21, [x20]
               	ldr	x23, [x22]
               	ldur	x22, [x29, #-0x48]
               	eor	x23, x23, x22
               	stur	x23, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x23, [x29, #-0x58]
               	cmp	x23, #0x10
               	b.ne	<addr>
               	sub	x22, x29, #0x38
               	ldr	x23, [x22]
               	add	x21, x23, #0x8
               	str	x21, [x22]
               	ldr	x20, [x23]
               	ldur	x23, [x29, #-0x48]
               	and	x20, x20, x23
               	stur	x20, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x20, [x29, #-0x58]
               	cmp	x20, #0x11
               	b.ne	<addr>
               	sub	x23, x29, #0x38
               	ldr	x20, [x23]
               	add	x21, x20, #0x8
               	str	x21, [x23]
               	ldr	x22, [x20]
               	ldur	x20, [x29, #-0x48]
               	cmp	x22, x20
               	cset	x22, eq
               	stur	x22, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x22, [x29, #-0x58]
               	cmp	x22, #0x12
               	b.ne	<addr>
               	sub	x20, x29, #0x38
               	ldr	x22, [x20]
               	add	x21, x22, #0x8
               	str	x21, [x20]
               	ldr	x23, [x22]
               	ldur	x22, [x29, #-0x48]
               	cmp	x23, x22
               	cset	x23, ne
               	stur	x23, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x23, [x29, #-0x58]
               	cmp	x23, #0x13
               	b.ne	<addr>
               	sub	x22, x29, #0x38
               	ldr	x23, [x22]
               	add	x21, x23, #0x8
               	str	x21, [x22]
               	ldr	x20, [x23]
               	ldur	x23, [x29, #-0x48]
               	cmp	x20, x23
               	cset	x20, lt
               	stur	x20, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x20, [x29, #-0x58]
               	cmp	x20, #0x14
               	b.ne	<addr>
               	sub	x23, x29, #0x38
               	ldr	x20, [x23]
               	add	x21, x20, #0x8
               	str	x21, [x23]
               	ldr	x22, [x20]
               	ldur	x20, [x29, #-0x48]
               	cmp	x22, x20
               	cset	x22, gt
               	stur	x22, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x22, [x29, #-0x58]
               	cmp	x22, #0x15
               	b.ne	<addr>
               	sub	x20, x29, #0x38
               	ldr	x22, [x20]
               	add	x21, x22, #0x8
               	str	x21, [x20]
               	ldr	x23, [x22]
               	ldur	x22, [x29, #-0x48]
               	cmp	x23, x22
               	cset	x23, le
               	stur	x23, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x23, [x29, #-0x58]
               	cmp	x23, #0x16
               	b.ne	<addr>
               	sub	x22, x29, #0x38
               	ldr	x23, [x22]
               	add	x21, x23, #0x8
               	str	x21, [x22]
               	ldr	x20, [x23]
               	ldur	x23, [x29, #-0x48]
               	cmp	x20, x23
               	cset	x20, ge
               	stur	x20, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x20, [x29, #-0x58]
               	cmp	x20, #0x17
               	b.ne	<addr>
               	sub	x23, x29, #0x38
               	ldr	x20, [x23]
               	add	x21, x20, #0x8
               	str	x21, [x23]
               	ldr	x22, [x20]
               	ldur	x20, [x29, #-0x48]
               	lsl	x22, x22, x20
               	stur	x22, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x22, [x29, #-0x58]
               	cmp	x22, #0x18
               	b.ne	<addr>
               	sub	x20, x29, #0x38
               	ldr	x22, [x20]
               	add	x21, x22, #0x8
               	str	x21, [x20]
               	ldr	x23, [x22]
               	ldur	x22, [x29, #-0x48]
               	asr	x23, x23, x22
               	stur	x23, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x23, [x29, #-0x58]
               	cmp	x23, #0x19
               	b.ne	<addr>
               	sub	x22, x29, #0x38
               	ldr	x23, [x22]
               	add	x21, x23, #0x8
               	str	x21, [x22]
               	ldr	x20, [x23]
               	ldur	x23, [x29, #-0x48]
               	add	x20, x20, x23
               	stur	x20, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x20, [x29, #-0x58]
               	cmp	x20, #0x1a
               	b.ne	<addr>
               	sub	x23, x29, #0x38
               	ldr	x20, [x23]
               	add	x21, x20, #0x8
               	str	x21, [x23]
               	ldr	x22, [x20]
               	ldur	x20, [x29, #-0x48]
               	sub	x22, x22, x20
               	stur	x22, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x22, [x29, #-0x58]
               	cmp	x22, #0x1b
               	b.ne	<addr>
               	sub	x20, x29, #0x38
               	ldr	x22, [x20]
               	add	x21, x22, #0x8
               	str	x21, [x20]
               	ldr	x23, [x22]
               	ldur	x22, [x29, #-0x48]
               	mul	x23, x23, x22
               	stur	x23, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x23, [x29, #-0x58]
               	cmp	x23, #0x1c
               	b.ne	<addr>
               	sub	x22, x29, #0x38
               	ldr	x23, [x22]
               	add	x21, x23, #0x8
               	str	x21, [x22]
               	ldr	x20, [x23]
               	ldur	x23, [x29, #-0x48]
               	sdiv	x20, x20, x23
               	stur	x20, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x20, [x29, #-0x58]
               	cmp	x20, #0x1d
               	b.ne	<addr>
               	sub	x23, x29, #0x38
               	ldr	x20, [x23]
               	add	x21, x20, #0x8
               	str	x21, [x23]
               	ldr	x22, [x20]
               	ldur	x20, [x29, #-0x48]
               	sdiv	x17, x22, x20
               	msub	x22, x17, x20, x22
               	stur	x22, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x22, [x29, #-0x58]
               	cmp	x22, #0x1e
               	b.ne	<addr>
               	ldur	x20, [x29, #-0x38]
               	add	x22, x20, #0x8
               	ldr	x25, [x22]
               	ldr	x21, [x20]
               	mov	x0, x25
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	stur	x0, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x0, [x29, #-0x58]
               	cmp	x0, #0x1f
               	b.ne	<addr>
               	ldur	x21, [x29, #-0x38]
               	add	x0, x21, #0x10
               	ldr	x22, [x0]
               	add	x0, x21, #0x8
               	ldr	x25, [x0]
               	ldr	x23, [x21]
               	mov	x0, x22
               	mov	x2, x23
               	mov	x1, x25
               	bl	<addr>
               	sxtw	x0, w0
               	stur	x0, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x0, [x29, #-0x58]
               	cmp	x0, #0x20
               	b.ne	<addr>
               	ldur	x23, [x29, #-0x38]
               	ldr	x21, [x23]
               	mov	x0, x21
               	bl	<addr>
               	sxtw	x0, w0
               	stur	x0, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x0, [x29, #-0x58]
               	cmp	x0, #0x21
               	b.ne	<addr>
               	ldur	x21, [x29, #-0x38]
               	ldur	x0, [x29, #-0x30]
               	add	x0, x0, #0x8
               	ldr	x25, [x0]
               	lsl	x25, x25, #3
               	add	x21, x21, x25
               	stur	x21, [x29, #-0x60]
               	ldur	x25, [x29, #-0x60]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x21, x25, x17
               	ldr	x23, [x21]
               	mov	x17, #0xfff0            // =65520
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x21, x25, x17
               	ldr	x24, [x21]
               	mov	x17, #0xffe8            // =65512
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x21, x25, x17
               	ldr	x22, [x21]
               	mov	x17, #0xffe0            // =65504
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x21, x25, x17
               	ldr	x20, [x21]
               	mov	x17, #0xffd8            // =65496
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x21, x25, x17
               	ldr	x27, [x21]
               	mov	x17, #0xffd0            // =65488
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x25, x25, x17
               	ldr	x26, [x25]
               	mov	x0, x23
               	mov	x5, x26
               	mov	x4, x27
               	mov	x3, x20
               	mov	x2, x22
               	mov	x1, x24
               	bl	<addr>
               	sxtw	x0, w0
               	stur	x0, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x0, [x29, #-0x58]
               	cmp	x0, #0x22
               	b.ne	<addr>
               	ldur	x26, [x29, #-0x38]
               	ldr	x25, [x26]
               	mov	x0, x25
               	bl	<addr>
               	stur	x0, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x0, [x29, #-0x58]
               	cmp	x0, #0x23
               	b.ne	<addr>
               	ldur	x25, [x29, #-0x38]
               	ldr	x26, [x25]
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
               	ldr	x25, [x26]
               	add	x26, x0, #0x8
               	ldr	x27, [x26]
               	ldr	x20, [x0]
               	mov	x0, x25
               	mov	x2, x20
               	mov	x1, x27
               	bl	<addr>
               	stur	x0, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x0, [x29, #-0x58]
               	cmp	x0, #0x25
               	b.ne	<addr>
               	ldur	x20, [x29, #-0x38]
               	add	x0, x20, #0x10
               	ldr	x26, [x0]
               	add	x0, x20, #0x8
               	ldr	x27, [x0]
               	ldr	x25, [x20]
               	mov	x0, x26
               	mov	x2, x25
               	mov	x1, x27
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
               	mov	x20, x19
               	ldur	x0, [x29, #-0x38]
               	ldr	x25, [x0]
               	ldur	x27, [x29, #-0x50]
               	mov	x0, x20
               	mov	x2, x27
               	mov	x1, x25
               	bl	<addr>
               	sxtw	x0, w0
               	ldur	x0, [x29, #-0x38]
               	ldr	x27, [x0]
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
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x896
               	mov	x26, x19
               	ldur	x21, [x29, #-0x58]
               	ldur	x27, [x29, #-0x50]
               	mov	x0, x26
               	mov	x2, x27
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
