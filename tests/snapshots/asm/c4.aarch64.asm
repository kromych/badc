
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
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
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
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x18
               	mov	x0, #0x0                // =0
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
               	ldr	x1, [x11]
               	bl	<addr>
               	mov	x11, x0
               	cbz	x11, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x138
               	mov	x1, x19
               	lsl	x0, x20, #3
               	add	x1, x1, x0
               	ldr	x11, [x11]
               	str	x11, [x1]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x138
               	mov	x11, x19
               	lsl	x20, x20, #3
               	add	x11, x11, x20
               	ldr	x11, [x11]
               	mov	x0, x11
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x170
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
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
               	mov	x20, #0x0               // =0
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x170
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
               	mov	x1, x19
               	ldr	x1, [x1]
               	cmp	x1, #0x23
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1f8
               	mov	x0, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x14, x19
               	ldr	x1, [x14]
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x20, x19
               	ldr	x12, [x20]
               	adrp	x19, <page>
               	add	x19, x19, #0x190
               	mov	x21, x19
               	ldr	x10, [x21]
               	sub	x2, x12, x10
               	ldr	x3, [x21]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x12, x0
               	ldr	x20, [x20]
               	str	x20, [x21]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x1, [x0]
               	add	x1, x1, #0x1
               	str	x1, [x0]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a8
               	mov	x20, x19
               	ldr	x20, [x20]
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x12, x19
               	ldr	x12, [x12]
               	cmp	x20, x12
               	b.ge	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x201
               	mov	x0, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x207
               	mov	x20, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1a8
               	mov	x22, x19
               	ldr	x3, [x22]
               	add	x3, x3, #0x8
               	str	x3, [x22]
               	ldr	x3, [x3]
               	mov	x17, #0x5               // =5
               	mul	x3, x3, x17
               	add	x1, x20, x3
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x3, x0
               	ldr	x22, [x22]
               	ldr	x22, [x22]
               	cmp	x22, #0x7
               	b.gt	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x2cb
               	mov	x0, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1a8
               	mov	x22, x19
               	ldr	x1, [x22]
               	add	x1, x1, #0x8
               	str	x1, [x22]
               	ldr	x3, [x1]
               	mov	x1, x3
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x1, x0
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x2d0
               	mov	x0, x19
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x1, x0
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x1, x19
               	ldr	x1, [x1]
               	cmp	x1, #0x61
               	cset	x1, ge
               	stur	x1, [x29, #-0x48]
               	cbz	x1, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x3, x19
               	ldr	x3, [x3]
               	ldrb	w3, [x3]
               	cmp	x3, #0x0
               	cset	x3, ne
               	stur	x3, [x29, #-0x30]
               	cbz	x3, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x3, x19
               	ldr	x1, [x3]
               	add	x1, x1, #0x1
               	str	x1, [x3]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x1, x19
               	ldr	x1, [x1]
               	ldrb	w1, [x1]
               	mov	x17, #0xa               // =10
               	eor	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	cset	x1, ne
               	stur	x1, [x29, #-0x30]
               	b	<addr>
               	ldur	x1, [x29, #-0x30]
               	cbz	x1, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x7a
               	cset	x0, le
               	stur	x0, [x29, #-0x48]
               	b	<addr>
               	ldur	x0, [x29, #-0x48]
               	stur	x0, [x29, #-0x40]
               	cbnz	x0, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x1, x19
               	ldr	x1, [x1]
               	cmp	x1, #0x41
               	cset	x1, ge
               	stur	x1, [x29, #-0x50]
               	cbz	x1, <addr>
               	b	<addr>
               	ldur	x0, [x29, #-0x40]
               	stur	x0, [x29, #-0x38]
               	cbnz	x0, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x5a
               	cset	x0, le
               	stur	x0, [x29, #-0x50]
               	b	<addr>
               	ldur	x0, [x29, #-0x50]
               	stur	x0, [x29, #-0x40]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x1, x19
               	ldr	x1, [x1]
               	cmp	x1, #0x5f
               	cset	x1, eq
               	stur	x1, [x29, #-0x38]
               	b	<addr>
               	ldur	x1, [x29, #-0x38]
               	cbz	x1, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x0, x19
               	ldr	x0, [x0]
               	sub	x21, x0, #0x1
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x12, x19
               	ldr	x12, [x12]
               	cmp	x12, #0x30
               	cset	x12, ge
               	stur	x12, [x29, #-0x90]
               	cbz	x12, <addr>
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
               	mov	x3, x19
               	ldr	x0, [x3]
               	mov	x17, #0x93              // =147
               	mul	x0, x0, x17
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x22, x19
               	ldr	x20, [x22]
               	add	x2, x20, #0x1
               	str	x2, [x22]
               	ldrb	w20, [x20]
               	add	x0, x0, x20
               	str	x0, [x3]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x20, [x0]
               	lsl	x20, x20, #6
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x3, x19
               	ldr	x3, [x3]
               	sub	x3, x3, x21
               	add	x20, x20, x3
               	str	x20, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x3, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1b8
               	mov	x20, x19
               	ldr	x20, [x20]
               	str	x20, [x3]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x3, x19
               	ldr	x3, [x3]
               	ldrb	w3, [x3]
               	cmp	x3, #0x7a
               	cset	x3, le
               	stur	x3, [x29, #-0x70]
               	b	<addr>
               	ldur	x3, [x29, #-0x70]
               	stur	x3, [x29, #-0x68]
               	cbnz	x3, <addr>
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
               	ldur	x3, [x29, #-0x68]
               	stur	x3, [x29, #-0x60]
               	cbnz	x3, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x3, x19
               	ldr	x3, [x3]
               	ldrb	w3, [x3]
               	cmp	x3, #0x5a
               	cset	x3, le
               	stur	x3, [x29, #-0x78]
               	b	<addr>
               	ldur	x3, [x29, #-0x78]
               	stur	x3, [x29, #-0x68]
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
               	ldur	x3, [x29, #-0x60]
               	stur	x3, [x29, #-0x58]
               	cbnz	x3, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x3, x19
               	ldr	x3, [x3]
               	ldrb	w3, [x3]
               	cmp	x3, #0x39
               	cset	x3, le
               	stur	x3, [x29, #-0x80]
               	b	<addr>
               	ldur	x3, [x29, #-0x80]
               	stur	x3, [x29, #-0x60]
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
               	mov	x20, x19
               	ldr	x20, [x20]
               	ldr	x20, [x20]
               	cbz	x20, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x20, x19
               	ldr	x20, [x20]
               	add	x20, x20, #0x8
               	ldr	x20, [x20]
               	cmp	x0, x20
               	cset	x0, eq
               	stur	x0, [x29, #-0x88]
               	cbz	x0, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x0, x19
               	ldr	x20, [x0]
               	add	x20, x20, #0x10
               	str	x21, [x20]
               	ldr	x12, [x0]
               	add	x12, x12, #0x8
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	ldr	x21, [x20]
               	str	x21, [x12]
               	ldr	x0, [x0]
               	mov	x2, #0x0                // =0
               	mov	x21, #0x85              // =133
               	str	x21, [x0]
               	str	x21, [x20]
               	mov	x0, x2
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x20, x19
               	ldr	x20, [x20]
               	add	x20, x20, #0x10
               	ldr	x0, [x20]
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x20, x19
               	ldr	x20, [x20]
               	sub	x2, x20, x21
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, x0
               	cmp	x20, #0x0
               	cset	x20, eq
               	stur	x20, [x29, #-0x88]
               	b	<addr>
               	ldur	x20, [x29, #-0x88]
               	cbz	x20, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x2, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x20, x19
               	ldr	x20, [x20]
               	mov	x0, #0x0                // =0
               	ldr	x20, [x20]
               	str	x20, [x2]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x12, x19
               	ldr	x0, [x12]
               	add	x0, x0, #0x48
               	str	x0, [x12]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x2, x19
               	ldr	x2, [x2]
               	cmp	x2, #0x39
               	cset	x2, le
               	stur	x2, [x29, #-0x90]
               	b	<addr>
               	ldur	x2, [x29, #-0x90]
               	cbz	x2, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c8
               	mov	x12, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x2, x19
               	ldr	x2, [x2]
               	sub	x2, x2, #0x30
               	str	x2, [x12]
               	cbz	x2, <addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x2, x19
               	ldr	x2, [x2]
               	cmp	x2, #0x2f
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	mov	x2, #0x80               // =128
               	str	x2, [x20]
               	mov	x21, #0x0               // =0
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x2, x19
               	ldr	x2, [x2]
               	ldrb	w2, [x2]
               	mov	x17, #0x78              // =120
               	eor	x2, x2, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x2, x2, x17
               	cmp	x2, #0x0
               	cset	x2, eq
               	stur	x2, [x29, #-0xa0]
               	cbnz	x2, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x21, x19
               	ldr	x21, [x21]
               	ldrb	w21, [x21]
               	cmp	x21, #0x30
               	cset	x21, ge
               	stur	x21, [x29, #-0x98]
               	cbz	x21, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c8
               	mov	x21, x19
               	ldr	x2, [x21]
               	mov	x17, #0xa               // =10
               	mul	x2, x2, x17
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x12, x19
               	ldr	x20, [x12]
               	add	x0, x20, #0x1
               	str	x0, [x12]
               	ldrb	w20, [x20]
               	add	x2, x2, x20
               	sub	x2, x2, #0x30
               	str	x2, [x21]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x2, x19
               	ldr	x2, [x2]
               	ldrb	w2, [x2]
               	cmp	x2, #0x39
               	cset	x2, le
               	stur	x2, [x29, #-0x98]
               	b	<addr>
               	ldur	x2, [x29, #-0x98]
               	cbz	x2, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x20, x19
               	ldr	x20, [x20]
               	ldrb	w20, [x20]
               	mov	x17, #0x58              // =88
               	eor	x20, x20, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x20, x17
               	cmp	x20, #0x0
               	cset	x20, eq
               	stur	x20, [x29, #-0xa0]
               	b	<addr>
               	ldur	x20, [x29, #-0xa0]
               	cbz	x20, <addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x2, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x20, x19
               	ldr	x21, [x20]
               	add	x21, x21, #0x1
               	str	x21, [x20]
               	ldrb	w21, [x21]
               	str	x21, [x2]
               	stur	x21, [x29, #-0xa8]
               	cbz	x21, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c8
               	mov	x3, x19
               	ldr	x21, [x3]
               	lsl	x21, x21, #4
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x2, x19
               	ldr	x20, [x2]
               	mov	x17, #0xf               // =15
               	and	x20, x20, x17
               	add	x21, x21, x20
               	ldr	x2, [x2]
               	cmp	x2, #0x41
               	b.lt	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x3, x19
               	ldr	x3, [x3]
               	cmp	x3, #0x30
               	cset	x3, ge
               	stur	x3, [x29, #-0xc0]
               	cbz	x3, <addr>
               	b	<addr>
               	ldur	x21, [x29, #-0xa8]
               	cbz	x21, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x21, [x21]
               	cmp	x21, #0x39
               	cset	x21, le
               	stur	x21, [x29, #-0xc0]
               	b	<addr>
               	ldur	x21, [x29, #-0xc0]
               	stur	x21, [x29, #-0xb8]
               	cbnz	x21, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x3, x19
               	ldr	x3, [x3]
               	cmp	x3, #0x61
               	cset	x3, ge
               	stur	x3, [x29, #-0xc8]
               	cbz	x3, <addr>
               	b	<addr>
               	ldur	x21, [x29, #-0xb8]
               	stur	x21, [x29, #-0xb0]
               	cbnz	x21, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x21, [x21]
               	cmp	x21, #0x66
               	cset	x21, le
               	stur	x21, [x29, #-0xc8]
               	b	<addr>
               	ldur	x21, [x29, #-0xc8]
               	stur	x21, [x29, #-0xb8]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x3, x19
               	ldr	x3, [x3]
               	cmp	x3, #0x41
               	cset	x3, ge
               	stur	x3, [x29, #-0xd0]
               	cbz	x3, <addr>
               	b	<addr>
               	ldur	x21, [x29, #-0xb0]
               	stur	x21, [x29, #-0xa8]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x21, [x21]
               	cmp	x21, #0x46
               	cset	x21, le
               	stur	x21, [x29, #-0xd0]
               	b	<addr>
               	ldur	x21, [x29, #-0xd0]
               	stur	x21, [x29, #-0xb0]
               	b	<addr>
               	mov	x20, #0x9               // =9
               	stur	x20, [x29, #-0xd8]
               	b	<addr>
               	mov	x20, #0x0               // =0
               	stur	x20, [x29, #-0xd8]
               	b	<addr>
               	ldur	x20, [x29, #-0xd8]
               	add	x21, x21, x20
               	str	x21, [x3]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x21, x19
               	ldr	x21, [x21]
               	ldrb	w21, [x21]
               	cmp	x21, #0x30
               	cset	x21, ge
               	stur	x21, [x29, #-0xe0]
               	cbz	x21, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c8
               	mov	x21, x19
               	ldr	x20, [x21]
               	lsl	x20, x20, #3
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x3, x19
               	ldr	x2, [x3]
               	add	x0, x2, #0x1
               	str	x0, [x3]
               	ldrb	w2, [x2]
               	add	x20, x20, x2
               	sub	x20, x20, #0x30
               	str	x20, [x21]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x20, x19
               	ldr	x20, [x20]
               	ldrb	w20, [x20]
               	cmp	x20, #0x37
               	cset	x20, le
               	stur	x20, [x29, #-0xe0]
               	b	<addr>
               	ldur	x20, [x29, #-0xe0]
               	cbz	x20, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x21, x19
               	ldr	x21, [x21]
               	ldrb	w21, [x21]
               	mov	x17, #0x2f              // =47
               	eor	x21, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x21, x17
               	cmp	x21, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x2, x19
               	ldr	x2, [x2]
               	cmp	x2, #0x27
               	cset	x2, eq
               	stur	x2, [x29, #-0xf0]
               	cbnz	x2, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x2, x19
               	ldr	x21, [x2]
               	add	x21, x21, #0x1
               	str	x21, [x2]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	mov	x2, #0xa0               // =160
               	str	x2, [x20]
               	mov	x21, #0x0               // =0
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x21, x19
               	ldr	x21, [x21]
               	ldrb	w21, [x21]
               	cmp	x21, #0x0
               	cset	x21, ne
               	stur	x21, [x29, #-0xe8]
               	cbz	x21, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x21, x19
               	ldr	x20, [x21]
               	add	x20, x20, #0x1
               	str	x20, [x21]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x20, x19
               	ldr	x20, [x20]
               	ldrb	w20, [x20]
               	mov	x17, #0xa               // =10
               	eor	x20, x20, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x20, x17
               	cmp	x20, #0x0
               	cset	x20, ne
               	stur	x20, [x29, #-0xe8]
               	b	<addr>
               	ldur	x20, [x29, #-0xe8]
               	cbz	x20, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x21, [x21]
               	cmp	x21, #0x22
               	cset	x21, eq
               	stur	x21, [x29, #-0xf0]
               	b	<addr>
               	ldur	x21, [x29, #-0xf0]
               	cbz	x21, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x198
               	mov	x2, x19
               	ldr	x2, [x2]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x2, x19
               	ldr	x2, [x2]
               	cmp	x2, #0x3d
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x21, x19
               	ldr	x21, [x21]
               	ldrb	w21, [x21]
               	cmp	x21, #0x0
               	cset	x21, ne
               	stur	x21, [x29, #-0xf8]
               	cbz	x21, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c8
               	mov	x21, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x20, x19
               	ldr	x12, [x20]
               	add	x0, x12, #0x1
               	str	x0, [x20]
               	ldrb	w12, [x12]
               	str	x12, [x21]
               	cmp	x12, #0x5c
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x0, x19
               	ldr	x20, [x0]
               	add	x20, x20, #0x1
               	str	x20, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x21, [x21]
               	cmp	x21, #0x22
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x20, x19
               	ldr	x20, [x20]
               	ldrb	w20, [x20]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x21, [x21]
               	cmp	x20, x21
               	cset	x20, ne
               	stur	x20, [x29, #-0xf8]
               	b	<addr>
               	ldur	x20, [x29, #-0xf8]
               	cbz	x20, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c8
               	mov	x3, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x12, x19
               	ldr	x21, [x12]
               	add	x0, x21, #0x1
               	str	x0, [x12]
               	ldrb	w21, [x21]
               	str	x21, [x3]
               	cmp	x21, #0x6e
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x21, [x21]
               	cmp	x21, #0x22
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c8
               	mov	x20, x19
               	mov	x21, #0xa               // =10
               	str	x21, [x20]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x198
               	mov	x3, x19
               	ldr	x21, [x3]
               	add	x20, x21, #0x1
               	str	x20, [x3]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c8
               	mov	x0, x19
               	ldr	x0, [x0]
               	strb	w0, [x21]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c8
               	mov	x20, x19
               	str	x2, [x20]
               	b	<addr>
               	mov	x21, #0x0               // =0
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	mov	x21, #0x80              // =128
               	str	x21, [x20]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x21, x19
               	ldr	x21, [x21]
               	ldrb	w21, [x21]
               	mov	x17, #0x3d              // =61
               	eor	x21, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x21, x17
               	cmp	x21, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	ldr	x20, [x20]
               	cmp	x20, #0x2b
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x2, x19
               	ldr	x21, [x2]
               	add	x21, x21, #0x1
               	str	x21, [x2]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	mov	x21, #0x95              // =149
               	str	x21, [x20]
               	b	<addr>
               	mov	x2, #0x0                // =0
               	mov	x0, x2
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	mov	x2, #0x8e               // =142
               	str	x2, [x21]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x2, x19
               	ldr	x2, [x2]
               	ldrb	w2, [x2]
               	mov	x17, #0x2b              // =43
               	eor	x2, x2, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x2, x2, x17
               	cmp	x2, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x21, [x21]
               	cmp	x21, #0x2d
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x20, x19
               	ldr	x2, [x20]
               	add	x2, x2, #0x1
               	str	x2, [x20]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	mov	x2, #0xa2               // =162
               	str	x2, [x21]
               	b	<addr>
               	mov	x20, #0x0               // =0
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x2, x19
               	mov	x20, #0x9d              // =157
               	str	x20, [x2]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x20, x19
               	ldr	x20, [x20]
               	ldrb	w20, [x20]
               	mov	x17, #0x2d              // =45
               	eor	x20, x20, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x20, x17
               	cmp	x20, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x2, x19
               	ldr	x2, [x2]
               	cmp	x2, #0x21
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x21, x19
               	ldr	x20, [x21]
               	add	x20, x20, #0x1
               	str	x20, [x21]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x2, x19
               	mov	x20, #0xa3              // =163
               	str	x20, [x2]
               	b	<addr>
               	mov	x21, #0x0               // =0
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	mov	x21, #0x9e              // =158
               	str	x21, [x20]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x21, x19
               	ldr	x21, [x21]
               	ldrb	w21, [x21]
               	mov	x17, #0x3d              // =61
               	eor	x21, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x21, x17
               	cmp	x21, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x2, x19
               	ldr	x2, [x2]
               	cmp	x2, #0x3c
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x2, x19
               	ldr	x21, [x2]
               	add	x21, x21, #0x1
               	str	x21, [x2]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	mov	x21, #0x96              // =150
               	str	x21, [x20]
               	b	<addr>
               	mov	x21, #0x0               // =0
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x21, x19
               	ldr	x21, [x21]
               	ldrb	w21, [x21]
               	mov	x17, #0x3d              // =61
               	eor	x21, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x21, x17
               	cmp	x21, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	ldr	x20, [x20]
               	cmp	x20, #0x3e
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x2, x19
               	ldr	x21, [x2]
               	add	x21, x21, #0x1
               	str	x21, [x2]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	mov	x21, #0x99              // =153
               	str	x21, [x20]
               	b	<addr>
               	mov	x2, #0x0                // =0
               	mov	x0, x2
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x21, x19
               	ldr	x21, [x21]
               	ldrb	w21, [x21]
               	mov	x17, #0x3c              // =60
               	eor	x21, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x21, x17
               	cmp	x21, #0x0
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x2, x19
               	ldr	x21, [x2]
               	add	x21, x21, #0x1
               	str	x21, [x2]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	mov	x21, #0x9b              // =155
               	str	x21, [x20]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	mov	x2, #0x97               // =151
               	str	x2, [x21]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x2, x19
               	ldr	x2, [x2]
               	ldrb	w2, [x2]
               	mov	x17, #0x3d              // =61
               	eor	x2, x2, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x2, x2, x17
               	cmp	x2, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x21, [x21]
               	cmp	x21, #0x7c
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x20, x19
               	ldr	x2, [x20]
               	add	x2, x2, #0x1
               	str	x2, [x20]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	mov	x2, #0x9a               // =154
               	str	x2, [x21]
               	b	<addr>
               	mov	x20, #0x0               // =0
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x2, x19
               	ldr	x2, [x2]
               	ldrb	w2, [x2]
               	mov	x17, #0x3e              // =62
               	eor	x2, x2, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x2, x2, x17
               	cmp	x2, #0x0
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x20, x19
               	ldr	x2, [x20]
               	add	x2, x2, #0x1
               	str	x2, [x20]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	mov	x2, #0x9c               // =156
               	str	x2, [x21]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x2, x19
               	mov	x20, #0x98              // =152
               	str	x20, [x2]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x20, x19
               	ldr	x20, [x20]
               	ldrb	w20, [x20]
               	mov	x17, #0x7c              // =124
               	eor	x20, x20, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x20, x17
               	cmp	x20, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x2, x19
               	ldr	x2, [x2]
               	cmp	x2, #0x26
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x21, x19
               	ldr	x20, [x21]
               	add	x20, x20, #0x1
               	str	x20, [x21]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x2, x19
               	mov	x20, #0x90              // =144
               	str	x20, [x2]
               	b	<addr>
               	mov	x21, #0x0               // =0
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	mov	x21, #0x92              // =146
               	str	x21, [x20]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x21, x19
               	ldr	x21, [x21]
               	ldrb	w21, [x21]
               	mov	x17, #0x26              // =38
               	eor	x21, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x21, x17
               	cmp	x21, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	ldr	x20, [x20]
               	cmp	x20, #0x5e
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x2, x19
               	ldr	x21, [x2]
               	add	x21, x21, #0x1
               	str	x21, [x2]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	mov	x21, #0x91              // =145
               	str	x21, [x20]
               	b	<addr>
               	mov	x2, #0x0                // =0
               	mov	x0, x2
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	mov	x2, #0x94               // =148
               	str	x2, [x21]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x2, x19
               	mov	x20, #0x93              // =147
               	str	x20, [x2]
               	mov	x21, #0x0               // =0
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	ldr	x20, [x20]
               	cmp	x20, #0x25
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	mov	x20, #0xa1              // =161
               	str	x20, [x21]
               	mov	x2, #0x0                // =0
               	mov	x0, x2
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	ldr	x20, [x20]
               	cmp	x20, #0x2a
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x2, x19
               	mov	x20, #0x9f              // =159
               	str	x20, [x2]
               	mov	x21, #0x0               // =0
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	ldr	x20, [x20]
               	cmp	x20, #0x5b
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	mov	x20, #0xa4              // =164
               	str	x20, [x21]
               	mov	x2, #0x0                // =0
               	mov	x0, x2
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	ldr	x20, [x20]
               	cmp	x20, #0x3f
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x2, x19
               	mov	x20, #0x8f              // =143
               	str	x20, [x2]
               	mov	x21, #0x0               // =0
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	ldr	x20, [x20]
               	cmp	x20, #0x7e
               	cset	x20, eq
               	sub	x17, x29, #0x138
               	str	x20, [x17]
               	cbnz	x20, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x21, [x21]
               	cmp	x21, #0x3b
               	cset	x21, eq
               	sub	x17, x29, #0x138
               	str	x21, [x17]
               	b	<addr>
               	sub	x16, x29, #0x138
               	ldr	x21, [x16]
               	sub	x17, x29, #0x130
               	str	x21, [x17]
               	cbnz	x21, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	ldr	x20, [x20]
               	cmp	x20, #0x7b
               	cset	x20, eq
               	sub	x17, x29, #0x130
               	str	x20, [x17]
               	b	<addr>
               	sub	x16, x29, #0x130
               	ldr	x20, [x16]
               	sub	x17, x29, #0x128
               	str	x20, [x17]
               	cbnz	x20, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x21, [x21]
               	cmp	x21, #0x7d
               	cset	x21, eq
               	sub	x17, x29, #0x128
               	str	x21, [x17]
               	b	<addr>
               	sub	x16, x29, #0x128
               	ldr	x21, [x16]
               	sub	x17, x29, #0x120
               	str	x21, [x17]
               	cbnz	x21, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	ldr	x20, [x20]
               	cmp	x20, #0x28
               	cset	x20, eq
               	sub	x17, x29, #0x120
               	str	x20, [x17]
               	b	<addr>
               	sub	x16, x29, #0x120
               	ldr	x20, [x16]
               	sub	x17, x29, #0x118
               	str	x20, [x17]
               	cbnz	x20, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x21, [x21]
               	cmp	x21, #0x29
               	cset	x21, eq
               	sub	x17, x29, #0x118
               	str	x21, [x17]
               	b	<addr>
               	sub	x16, x29, #0x118
               	ldr	x21, [x16]
               	sub	x17, x29, #0x110
               	str	x21, [x17]
               	cbnz	x21, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	ldr	x20, [x20]
               	cmp	x20, #0x5d
               	cset	x20, eq
               	sub	x17, x29, #0x110
               	str	x20, [x17]
               	b	<addr>
               	sub	x16, x29, #0x110
               	ldr	x20, [x16]
               	sub	x17, x29, #0x108
               	str	x20, [x17]
               	cbnz	x20, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x21, [x21]
               	cmp	x21, #0x2c
               	cset	x21, eq
               	sub	x17, x29, #0x108
               	str	x21, [x17]
               	b	<addr>
               	sub	x16, x29, #0x108
               	ldr	x21, [x16]
               	stur	x21, [x29, #-0x100]
               	cbnz	x21, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	ldr	x20, [x20]
               	cmp	x20, #0x3a
               	cset	x20, eq
               	stur	x20, [x29, #-0x100]
               	b	<addr>
               	ldur	x20, [x29, #-0x100]
               	cbz	x20, <addr>
               	mov	x21, #0x0               // =0
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x110
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x19, [sp, #0x30]
               	mov	x20, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x14, x19
               	ldr	x14, [x14]
               	cmp	x14, #0x0
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x2d2
               	mov	x0, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x14, x19
               	ldr	x1, [x14]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x14, x0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x1, x0
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x80
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x1, x19
               	ldr	x0, [x1]
               	add	x0, x0, #0x8
               	str	x0, [x1]
               	mov	x21, #0x1               // =1
               	str	x21, [x0]
               	ldr	x11, [x1]
               	add	x11, x11, #0x8
               	str	x11, [x1]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c8
               	mov	x0, x19
               	ldr	x0, [x0]
               	str	x0, [x11]
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	str	x21, [x0]
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
               	mov	x1, x19
               	ldr	x0, [x1]
               	add	x0, x0, #0x8
               	str	x0, [x1]
               	mov	x21, #0x1               // =1
               	str	x21, [x0]
               	ldr	x11, [x1]
               	add	x11, x11, #0x8
               	str	x11, [x1]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c8
               	mov	x21, x19
               	ldr	x21, [x21]
               	str	x21, [x11]
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
               	mov	x21, x19
               	ldr	x21, [x21]
               	cmp	x21, #0x22
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
               	mov	x21, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x21, [x21]
               	cmp	x21, #0x28
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x85
               	b.ne	<addr>
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
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
               	ldr	x1, [x0]
               	mov	x0, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x1, x0
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
               	mov	x0, x19
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x21, #0x1               // =1
               	str	x21, [x1]
               	ldr	x11, [x0]
               	add	x11, x11, #0x8
               	str	x11, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x21, x19
               	ldr	x21, [x21]
               	cmp	x21, #0x0
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x317
               	mov	x21, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x1, [x0]
               	mov	x0, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x1, x0
               	b	<addr>
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0x30]
               	b	<addr>
               	mov	x0, #0x8                // =8
               	stur	x0, [x29, #-0x30]
               	b	<addr>
               	ldur	x0, [x29, #-0x30]
               	str	x0, [x11]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x21, x19
               	mov	x0, #0x1                // =1
               	str	x0, [x21]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x11, x19
               	ldr	x11, [x11]
               	stur	x11, [x29, #-0x10]
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
               	mov	x21, x19
               	ldr	x21, [x21]
               	cmp	x21, #0x28
               	b.ne	<addr>
               	b	<addr>
               	bl	<addr>
               	mov	x11, x0
               	mov	x11, #0x0               // =0
               	stur	x11, [x29, #-0x8]
               	b	<addr>
               	b	<addr>
               	ldur	x1, [x29, #-0x10]
               	add	x1, x1, #0x18
               	ldr	x1, [x1]
               	cmp	x1, #0x80
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x11, x19
               	ldr	x11, [x11]
               	cmp	x11, #0x29
               	b.eq	<addr>
               	mov	x0, #0x8e               // =142
               	bl	<addr>
               	mov	x11, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x11, x19
               	ldr	x0, [x11]
               	add	x0, x0, #0x8
               	str	x0, [x11]
               	mov	x21, #0xd               // =13
               	str	x21, [x0]
               	sub	x11, x29, #0x8
               	ldr	x21, [x11]
               	add	x21, x21, #0x1
               	str	x21, [x11]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x2c
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
               	ldur	x11, [x29, #-0x10]
               	add	x11, x11, #0x28
               	ldr	x11, [x11]
               	str	x11, [x0]
               	b	<addr>
               	ldur	x0, [x29, #-0x8]
               	cbz	x0, <addr>
               	b	<addr>
               	ldur	x11, [x29, #-0x10]
               	add	x11, x11, #0x18
               	ldr	x11, [x11]
               	cmp	x11, #0x81
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x21, x19
               	ldr	x11, [x21]
               	add	x11, x11, #0x8
               	str	x11, [x21]
               	mov	x0, #0x3                // =3
               	str	x0, [x11]
               	ldr	x1, [x21]
               	add	x1, x1, #0x8
               	str	x1, [x21]
               	ldur	x0, [x29, #-0x10]
               	add	x0, x0, #0x28
               	ldr	x0, [x0]
               	str	x0, [x1]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x33b
               	mov	x0, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x21, x19
               	ldr	x1, [x21]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x21, x0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x1, x0
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x1, x19
               	ldr	x0, [x1]
               	add	x0, x0, #0x8
               	str	x0, [x1]
               	mov	x21, #0x7               // =7
               	str	x21, [x0]
               	ldr	x11, [x1]
               	add	x11, x11, #0x8
               	str	x11, [x1]
               	ldur	x21, [x29, #-0x8]
               	str	x21, [x11]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x21, x19
               	ldur	x1, [x29, #-0x10]
               	add	x1, x1, #0x20
               	ldr	x1, [x1]
               	str	x1, [x21]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x11, x19
               	ldr	x1, [x11]
               	add	x1, x1, #0x8
               	str	x1, [x11]
               	mov	x21, #0x1               // =1
               	str	x21, [x1]
               	ldr	x0, [x11]
               	add	x0, x0, #0x8
               	str	x0, [x11]
               	ldur	x1, [x29, #-0x10]
               	add	x1, x1, #0x28
               	ldr	x1, [x1]
               	str	x1, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x11, x19
               	str	x21, [x11]
               	b	<addr>
               	b	<addr>
               	ldur	x11, [x29, #-0x10]
               	add	x11, x11, #0x18
               	ldr	x11, [x11]
               	cmp	x11, #0x84
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x1, x19
               	ldr	x11, [x1]
               	add	x11, x11, #0x8
               	str	x11, [x1]
               	mov	x21, #0x0               // =0
               	str	x21, [x11]
               	ldr	x0, [x1]
               	add	x0, x0, #0x8
               	str	x0, [x1]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d8
               	mov	x21, x19
               	ldr	x21, [x21]
               	ldur	x1, [x29, #-0x10]
               	add	x1, x1, #0x28
               	ldr	x1, [x1]
               	sub	x21, x21, x1
               	str	x21, [x0]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x11, [x0]
               	add	x11, x11, #0x8
               	str	x11, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x1, x19
               	ldur	x0, [x29, #-0x10]
               	add	x0, x0, #0x20
               	ldr	x0, [x0]
               	str	x0, [x1]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	ldur	x21, [x29, #-0x10]
               	add	x21, x21, #0x18
               	ldr	x21, [x21]
               	cmp	x21, #0x83
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x1, x19
               	ldr	x21, [x1]
               	add	x21, x21, #0x8
               	str	x21, [x1]
               	mov	x0, #0x1                // =1
               	str	x0, [x21]
               	ldr	x11, [x1]
               	add	x11, x11, #0x8
               	str	x11, [x1]
               	ldur	x0, [x29, #-0x10]
               	add	x0, x0, #0x28
               	ldr	x0, [x0]
               	str	x0, [x11]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x352
               	mov	x0, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x1, x19
               	ldr	x11, [x1]
               	mov	x1, x11
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x1, x0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x11, x0
               	b	<addr>
               	mov	x21, #0xa               // =10
               	stur	x21, [x29, #-0x38]
               	b	<addr>
               	mov	x21, #0x9               // =9
               	stur	x21, [x29, #-0x38]
               	b	<addr>
               	ldur	x21, [x29, #-0x38]
               	str	x21, [x11]
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
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x9f
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x21, [x21]
               	cmp	x21, #0x86
               	cset	x21, eq
               	stur	x21, [x29, #-0x40]
               	b	<addr>
               	ldur	x21, [x29, #-0x40]
               	cbz	x21, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x8a
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x8e               // =142
               	bl	<addr>
               	mov	x21, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x21, [x21]
               	cmp	x21, #0x29
               	b.ne	<addr>
               	b	<addr>
               	mov	x21, #0x1               // =1
               	stur	x21, [x29, #-0x48]
               	b	<addr>
               	mov	x21, #0x0               // =0
               	stur	x21, [x29, #-0x48]
               	b	<addr>
               	ldur	x21, [x29, #-0x48]
               	stur	x21, [x29, #-0x8]
               	bl	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x21, [x21]
               	cmp	x21, #0x9f
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
               	mov	x21, x0
               	b	<addr>
               	mov	x0, #0xa2               // =162
               	bl	<addr>
               	mov	x1, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x1, x19
               	ldur	x0, [x29, #-0x8]
               	str	x0, [x1]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x36a
               	mov	x0, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x21, x19
               	ldr	x1, [x21]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x21, x0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x1, x0
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
               	ldr	x1, [x0]
               	mov	x0, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x1, x0
               	b	<addr>
               	bl	<addr>
               	mov	x1, x0
               	mov	x0, #0xa2               // =162
               	bl	<addr>
               	mov	x1, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x1, x19
               	ldr	x1, [x1]
               	cmp	x1, #0x1
               	b.le	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x94
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	ldr	x1, [x0]
               	sub	x1, x1, #0x2
               	str	x1, [x0]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x21, x19
               	ldr	x21, [x21]
               	cmp	x21, #0x0
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x392
               	mov	x0, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x21, x19
               	ldr	x1, [x21]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x21, x0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x1, x0
               	b	<addr>
               	mov	x0, #0xa                // =10
               	stur	x0, [x29, #-0x50]
               	b	<addr>
               	mov	x0, #0x9                // =9
               	stur	x0, [x29, #-0x50]
               	b	<addr>
               	ldur	x0, [x29, #-0x50]
               	str	x0, [x1]
               	b	<addr>
               	bl	<addr>
               	mov	x21, x0
               	mov	x0, #0xa2               // =162
               	bl	<addr>
               	mov	x21, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x21, x19
               	ldr	x21, [x21]
               	ldr	x21, [x21]
               	cmp	x21, #0xa
               	cset	x21, eq
               	stur	x21, [x29, #-0x58]
               	cbnz	x21, <addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x21, [x21]
               	cmp	x21, #0x21
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x0, [x0]
               	ldr	x0, [x0]
               	cmp	x0, #0x9
               	cset	x0, eq
               	stur	x0, [x29, #-0x58]
               	b	<addr>
               	ldur	x0, [x29, #-0x58]
               	cbz	x0, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x21, x19
               	ldr	x0, [x21]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x0, x0, x17
               	str	x0, [x21]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	ldr	x21, [x0]
               	add	x21, x21, #0x2
               	str	x21, [x0]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x3a7
               	mov	x0, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x1, x19
               	ldr	x21, [x1]
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x1, x0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x21, x0
               	b	<addr>
               	bl	<addr>
               	mov	x0, #0xa2               // =162
               	bl	<addr>
               	mov	x21, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x21, x19
               	ldr	x0, [x21]
               	add	x0, x0, #0x8
               	str	x0, [x21]
               	mov	x1, #0xd                // =13
               	str	x1, [x0]
               	ldr	x11, [x21]
               	add	x11, x11, #0x8
               	str	x11, [x21]
               	mov	x1, #0x1                // =1
               	str	x1, [x11]
               	ldr	x0, [x21]
               	add	x0, x0, #0x8
               	str	x0, [x21]
               	mov	x11, #0x0               // =0
               	str	x11, [x0]
               	ldr	x10, [x21]
               	add	x10, x10, #0x8
               	str	x10, [x21]
               	mov	x11, #0x11              // =17
               	str	x11, [x10]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x21, x19
               	str	x1, [x21]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x21, [x21]
               	cmp	x21, #0x7e
               	b.ne	<addr>
               	bl	<addr>
               	mov	x0, #0xa2               // =162
               	bl	<addr>
               	mov	x21, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x21, x19
               	ldr	x0, [x21]
               	add	x0, x0, #0x8
               	str	x0, [x21]
               	mov	x1, #0xd                // =13
               	str	x1, [x0]
               	ldr	x10, [x21]
               	add	x10, x10, #0x8
               	str	x10, [x21]
               	mov	x1, #0x1                // =1
               	str	x1, [x10]
               	ldr	x0, [x21]
               	add	x0, x0, #0x8
               	str	x0, [x21]
               	mov	x10, #0xffff            // =65535
               	movk	x10, #0xffff, lsl #16
               	movk	x10, #0xffff, lsl #32
               	movk	x10, #0xffff, lsl #48
               	str	x10, [x0]
               	ldr	x11, [x21]
               	add	x11, x11, #0x8
               	str	x11, [x21]
               	mov	x10, #0xf               // =15
               	str	x10, [x11]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x21, x19
               	str	x1, [x21]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x21, [x21]
               	cmp	x21, #0x9d
               	b.ne	<addr>
               	bl	<addr>
               	mov	x0, #0xa2               // =162
               	bl	<addr>
               	mov	x21, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x21, x19
               	mov	x0, #0x1                // =1
               	str	x0, [x21]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x9e
               	b.ne	<addr>
               	bl	<addr>
               	mov	x1, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x1, x19
               	ldr	x0, [x1]
               	add	x0, x0, #0x8
               	str	x0, [x1]
               	mov	x21, #0x1               // =1
               	str	x21, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x1, x19
               	ldr	x1, [x1]
               	cmp	x1, #0x80
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
               	mov	x21, x19
               	ldr	x1, [x21]
               	add	x1, x1, #0x8
               	str	x1, [x21]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c8
               	mov	x0, x19
               	ldr	x0, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x0, x0, x17
               	str	x0, [x1]
               	bl	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	mov	x22, #0x1               // =1
               	str	x22, [x0]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x22, x19
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	str	x1, [x0]
               	ldr	x11, [x22]
               	add	x11, x11, #0x8
               	str	x11, [x22]
               	mov	x1, #0xd                // =13
               	str	x1, [x11]
               	mov	x0, #0xa2               // =162
               	bl	<addr>
               	mov	x1, x0
               	ldr	x1, [x22]
               	add	x1, x1, #0x8
               	str	x1, [x22]
               	mov	x0, #0x1b               // =27
               	str	x0, [x1]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x1, x19
               	ldr	x1, [x1]
               	cmp	x1, #0xa3
               	cset	x1, eq
               	stur	x1, [x29, #-0x60]
               	b	<addr>
               	ldur	x1, [x29, #-0x60]
               	cbz	x1, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x22, [x22]
               	stur	x22, [x29, #-0x8]
               	bl	<addr>
               	mov	x0, #0xa2               // =162
               	bl	<addr>
               	mov	x22, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x22, x19
               	ldr	x22, [x22]
               	ldr	x22, [x22]
               	cmp	x22, #0xa
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x3dc
               	mov	x1, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x11, [x0]
               	mov	x0, x1
               	mov	x1, x11
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x11, x0
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x22, [x0]
               	mov	x1, #0xd                // =13
               	str	x1, [x22]
               	ldr	x11, [x0]
               	add	x11, x11, #0x8
               	str	x11, [x0]
               	mov	x1, #0xa                // =10
               	str	x1, [x11]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x11, #0xd               // =13
               	str	x11, [x1]
               	ldr	x22, [x0]
               	add	x22, x22, #0x8
               	str	x22, [x0]
               	mov	x11, #0x1               // =1
               	str	x11, [x22]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x11, x19
               	ldr	x11, [x11]
               	cmp	x11, #0x2
               	b.le	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x1, x19
               	ldr	x1, [x1]
               	ldr	x1, [x1]
               	cmp	x1, #0x9
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x1, [x0]
               	mov	x11, #0xd               // =13
               	str	x11, [x1]
               	ldr	x22, [x0]
               	add	x22, x22, #0x8
               	str	x22, [x0]
               	mov	x11, #0x9               // =9
               	str	x11, [x22]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x3bb
               	mov	x11, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x1, [x0]
               	mov	x0, x11
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x1, x0
               	b	<addr>
               	mov	x0, #0x8                // =8
               	stur	x0, [x29, #-0x68]
               	b	<addr>
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0x68]
               	b	<addr>
               	ldur	x0, [x29, #-0x68]
               	str	x0, [x1]
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x11, x19
               	ldr	x0, [x11]
               	add	x0, x0, #0x8
               	str	x0, [x11]
               	ldur	x1, [x29, #-0x8]
               	cmp	x1, #0xa2
               	b.ne	<addr>
               	mov	x11, #0x19              // =25
               	stur	x11, [x29, #-0x70]
               	b	<addr>
               	mov	x11, #0x1a              // =26
               	stur	x11, [x29, #-0x70]
               	b	<addr>
               	ldur	x11, [x29, #-0x70]
               	str	x11, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x1, x19
               	ldr	x11, [x1]
               	add	x11, x11, #0x8
               	str	x11, [x1]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x1, #0xc                // =12
               	stur	x1, [x29, #-0x78]
               	b	<addr>
               	mov	x1, #0xb                // =11
               	stur	x1, [x29, #-0x78]
               	b	<addr>
               	ldur	x1, [x29, #-0x78]
               	str	x1, [x11]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, x20
               	b.lt	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x11, x19
               	ldr	x11, [x11]
               	stur	x11, [x29, #-0x8]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x8e
               	b.ne	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	mov	x11, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x11, x19
               	ldr	x11, [x11]
               	ldr	x11, [x11]
               	cmp	x11, #0xa
               	cset	x11, eq
               	stur	x11, [x29, #-0x80]
               	cbnz	x11, <addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x22, [x22]
               	cmp	x22, #0x8f
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x0, [x0]
               	ldr	x0, [x0]
               	cmp	x0, #0x9
               	cset	x0, eq
               	stur	x0, [x29, #-0x80]
               	b	<addr>
               	ldur	x0, [x29, #-0x80]
               	cbz	x0, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x11, x19
               	ldr	x11, [x11]
               	mov	x0, #0xd                // =13
               	str	x0, [x11]
               	b	<addr>
               	mov	x0, #0x8e               // =142
               	bl	<addr>
               	mov	x11, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x11, x19
               	ldr	x0, [x11]
               	add	x0, x0, #0x8
               	str	x0, [x11]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x1, x19
               	ldur	x11, [x29, #-0x8]
               	str	x11, [x1]
               	cmp	x11, #0x0
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x3f0
               	mov	x0, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x1, x19
               	ldr	x11, [x1]
               	mov	x1, x11
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x1, x0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x11, x0
               	b	<addr>
               	mov	x22, #0xc               // =12
               	stur	x22, [x29, #-0x88]
               	b	<addr>
               	mov	x22, #0xb               // =11
               	stur	x22, [x29, #-0x88]
               	b	<addr>
               	ldur	x22, [x29, #-0x88]
               	str	x22, [x0]
               	b	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x22, [x0]
               	add	x22, x22, #0x8
               	str	x22, [x0]
               	mov	x11, #0x4               // =4
               	str	x11, [x22]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	stur	x1, [x29, #-0x10]
               	mov	x0, #0x8e               // =142
               	bl	<addr>
               	mov	x1, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x1, x19
               	ldr	x1, [x1]
               	cmp	x1, #0x3a
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	ldr	x21, [x21]
               	cmp	x21, #0x90
               	b.ne	<addr>
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	ldur	x0, [x29, #-0x10]
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x21, x19
               	ldr	x1, [x21]
               	add	x1, x1, #0x18
               	str	x1, [x0]
               	ldr	x22, [x21]
               	add	x22, x22, #0x8
               	str	x22, [x21]
               	mov	x1, #0x2                // =2
               	str	x1, [x22]
               	ldr	x0, [x21]
               	add	x0, x0, #0x8
               	str	x0, [x21]
               	stur	x0, [x29, #-0x10]
               	mov	x0, #0x8f               // =143
               	bl	<addr>
               	mov	x1, x0
               	ldur	x1, [x29, #-0x10]
               	ldr	x21, [x21]
               	add	x21, x21, #0x8
               	str	x21, [x1]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x40e
               	mov	x1, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x11, [x0]
               	mov	x0, x1
               	mov	x1, x11
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x11, x0
               	b	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x21, [x23]
               	add	x21, x21, #0x8
               	str	x21, [x23]
               	mov	x1, #0x5                // =5
               	str	x1, [x21]
               	ldr	x22, [x23]
               	add	x22, x22, #0x8
               	str	x22, [x23]
               	stur	x22, [x29, #-0x10]
               	mov	x0, #0x91               // =145
               	bl	<addr>
               	mov	x22, x0
               	ldur	x22, [x29, #-0x10]
               	ldr	x23, [x23]
               	add	x23, x23, #0x8
               	str	x23, [x22]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	mov	x23, #0x1               // =1
               	str	x23, [x0]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x23, x19
               	ldr	x23, [x23]
               	cmp	x23, #0x91
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x24, x19
               	ldr	x23, [x24]
               	add	x23, x23, #0x8
               	str	x23, [x24]
               	mov	x22, #0x4               // =4
               	str	x22, [x23]
               	ldr	x21, [x24]
               	add	x21, x21, #0x8
               	str	x21, [x24]
               	stur	x21, [x29, #-0x10]
               	mov	x0, #0x92               // =146
               	bl	<addr>
               	mov	x21, x0
               	ldur	x21, [x29, #-0x10]
               	ldr	x24, [x24]
               	add	x24, x24, #0x8
               	str	x24, [x21]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	mov	x24, #0x1               // =1
               	str	x24, [x0]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x24, [x24]
               	cmp	x24, #0x92
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x22, x19
               	ldr	x24, [x22]
               	add	x24, x24, #0x8
               	str	x24, [x22]
               	mov	x21, #0xd               // =13
               	str	x21, [x24]
               	mov	x0, #0x93               // =147
               	bl	<addr>
               	mov	x21, x0
               	ldr	x21, [x22]
               	add	x21, x21, #0x8
               	str	x21, [x22]
               	mov	x0, #0xe                // =14
               	str	x0, [x21]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x22, x19
               	mov	x0, #0x1                // =1
               	str	x0, [x22]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x93
               	b.ne	<addr>
               	bl	<addr>
               	mov	x21, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x0, [x23]
               	add	x0, x0, #0x8
               	str	x0, [x23]
               	mov	x22, #0xd               // =13
               	str	x22, [x0]
               	mov	x0, #0x94               // =148
               	bl	<addr>
               	mov	x22, x0
               	ldr	x22, [x23]
               	add	x22, x22, #0x8
               	str	x22, [x23]
               	mov	x0, #0xf                // =15
               	str	x0, [x22]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x23, x19
               	mov	x0, #0x1                // =1
               	str	x0, [x23]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x94
               	b.ne	<addr>
               	bl	<addr>
               	mov	x22, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x21, x19
               	ldr	x0, [x21]
               	add	x0, x0, #0x8
               	str	x0, [x21]
               	mov	x23, #0xd               // =13
               	str	x23, [x0]
               	mov	x0, #0x95               // =149
               	bl	<addr>
               	mov	x23, x0
               	ldr	x23, [x21]
               	add	x23, x23, #0x8
               	str	x23, [x21]
               	mov	x0, #0x10               // =16
               	str	x0, [x23]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x21, x19
               	mov	x0, #0x1                // =1
               	str	x0, [x21]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x95
               	b.ne	<addr>
               	bl	<addr>
               	mov	x23, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x22, x19
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x21, #0xd               // =13
               	str	x21, [x0]
               	mov	x0, #0x97               // =151
               	bl	<addr>
               	mov	x21, x0
               	ldr	x21, [x22]
               	add	x21, x21, #0x8
               	str	x21, [x22]
               	mov	x0, #0x11               // =17
               	str	x0, [x21]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x22, x19
               	mov	x0, #0x1                // =1
               	str	x0, [x22]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x96
               	b.ne	<addr>
               	bl	<addr>
               	mov	x21, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x0, [x23]
               	add	x0, x0, #0x8
               	str	x0, [x23]
               	mov	x22, #0xd               // =13
               	str	x22, [x0]
               	mov	x0, #0x97               // =151
               	bl	<addr>
               	mov	x22, x0
               	ldr	x22, [x23]
               	add	x22, x22, #0x8
               	str	x22, [x23]
               	mov	x0, #0x12               // =18
               	str	x0, [x22]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x23, x19
               	mov	x0, #0x1                // =1
               	str	x0, [x23]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x97
               	b.ne	<addr>
               	bl	<addr>
               	mov	x22, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x21, x19
               	ldr	x0, [x21]
               	add	x0, x0, #0x8
               	str	x0, [x21]
               	mov	x23, #0xd               // =13
               	str	x23, [x0]
               	mov	x0, #0x9b               // =155
               	bl	<addr>
               	mov	x23, x0
               	ldr	x23, [x21]
               	add	x23, x23, #0x8
               	str	x23, [x21]
               	mov	x0, #0x13               // =19
               	str	x0, [x23]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x21, x19
               	mov	x0, #0x1                // =1
               	str	x0, [x21]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x98
               	b.ne	<addr>
               	bl	<addr>
               	mov	x23, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x22, x19
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x21, #0xd               // =13
               	str	x21, [x0]
               	mov	x0, #0x9b               // =155
               	bl	<addr>
               	mov	x21, x0
               	ldr	x21, [x22]
               	add	x21, x21, #0x8
               	str	x21, [x22]
               	mov	x0, #0x14               // =20
               	str	x0, [x21]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x22, x19
               	mov	x0, #0x1                // =1
               	str	x0, [x22]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x99
               	b.ne	<addr>
               	bl	<addr>
               	mov	x21, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x0, [x23]
               	add	x0, x0, #0x8
               	str	x0, [x23]
               	mov	x22, #0xd               // =13
               	str	x22, [x0]
               	mov	x0, #0x9b               // =155
               	bl	<addr>
               	mov	x22, x0
               	ldr	x22, [x23]
               	add	x22, x22, #0x8
               	str	x22, [x23]
               	mov	x0, #0x15               // =21
               	str	x0, [x22]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x23, x19
               	mov	x0, #0x1                // =1
               	str	x0, [x23]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x9a
               	b.ne	<addr>
               	bl	<addr>
               	mov	x22, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x21, x19
               	ldr	x0, [x21]
               	add	x0, x0, #0x8
               	str	x0, [x21]
               	mov	x23, #0xd               // =13
               	str	x23, [x0]
               	mov	x0, #0x9b               // =155
               	bl	<addr>
               	mov	x23, x0
               	ldr	x23, [x21]
               	add	x23, x23, #0x8
               	str	x23, [x21]
               	mov	x0, #0x16               // =22
               	str	x0, [x23]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x21, x19
               	mov	x0, #0x1                // =1
               	str	x0, [x21]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x9b
               	b.ne	<addr>
               	bl	<addr>
               	mov	x23, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x22, x19
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x21, #0xd               // =13
               	str	x21, [x0]
               	mov	x0, #0x9d               // =157
               	bl	<addr>
               	mov	x21, x0
               	ldr	x21, [x22]
               	add	x21, x21, #0x8
               	str	x21, [x22]
               	mov	x0, #0x17               // =23
               	str	x0, [x21]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x22, x19
               	mov	x0, #0x1                // =1
               	str	x0, [x22]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x9c
               	b.ne	<addr>
               	bl	<addr>
               	mov	x21, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x0, [x23]
               	add	x0, x0, #0x8
               	str	x0, [x23]
               	mov	x22, #0xd               // =13
               	str	x22, [x0]
               	mov	x0, #0x9d               // =157
               	bl	<addr>
               	mov	x22, x0
               	ldr	x22, [x23]
               	add	x22, x22, #0x8
               	str	x22, [x23]
               	mov	x0, #0x18               // =24
               	str	x0, [x22]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x23, x19
               	mov	x0, #0x1                // =1
               	str	x0, [x23]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x9d
               	b.ne	<addr>
               	bl	<addr>
               	mov	x22, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x22, x19
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x23, #0xd               // =13
               	str	x23, [x0]
               	mov	x0, #0x9f               // =159
               	bl	<addr>
               	mov	x23, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x23, x19
               	ldur	x0, [x29, #-0x8]
               	str	x0, [x23]
               	cmp	x0, #0x2
               	b.le	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x24, x19
               	ldr	x24, [x24]
               	cmp	x24, #0x9e
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x22, x19
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x23, #0xd               // =13
               	str	x23, [x0]
               	ldr	x24, [x22]
               	add	x24, x24, #0x8
               	str	x24, [x22]
               	mov	x23, #0x1               // =1
               	str	x23, [x24]
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x23, #0x8               // =8
               	str	x23, [x0]
               	ldr	x24, [x22]
               	add	x24, x24, #0x8
               	str	x24, [x22]
               	mov	x23, #0x1b              // =27
               	str	x23, [x24]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x23, x19
               	ldr	x22, [x23]
               	add	x22, x22, #0x8
               	str	x22, [x23]
               	mov	x24, #0x19              // =25
               	str	x24, [x22]
               	b	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x24, [x0]
               	add	x24, x24, #0x8
               	str	x24, [x0]
               	mov	x22, #0xd               // =13
               	str	x22, [x24]
               	mov	x0, #0x9f               // =159
               	bl	<addr>
               	mov	x22, x0
               	ldur	x22, [x29, #-0x8]
               	cmp	x22, #0x2
               	cset	x22, gt
               	stur	x22, [x29, #-0x90]
               	cbz	x22, <addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x9f
               	b.ne	<addr>
               	b	<addr>
               	ldur	x0, [x29, #-0x8]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x22, x19
               	ldr	x22, [x22]
               	cmp	x0, x22
               	cset	x0, eq
               	stur	x0, [x29, #-0x90]
               	b	<addr>
               	ldur	x0, [x29, #-0x90]
               	cbz	x0, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x22, x19
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x24, #0x1a              // =26
               	str	x24, [x0]
               	ldr	x23, [x22]
               	add	x23, x23, #0x8
               	str	x23, [x22]
               	mov	x24, #0xd               // =13
               	str	x24, [x23]
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x24, #0x1               // =1
               	str	x24, [x0]
               	ldr	x23, [x22]
               	add	x23, x23, #0x8
               	str	x23, [x22]
               	mov	x0, #0x8                // =8
               	str	x0, [x23]
               	ldr	x10, [x22]
               	add	x10, x10, #0x8
               	str	x10, [x22]
               	mov	x0, #0x1c               // =28
               	str	x0, [x10]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x22, x19
               	str	x24, [x22]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x22, x19
               	ldur	x0, [x29, #-0x8]
               	str	x0, [x22]
               	cmp	x0, #0x2
               	b.le	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x24, x19
               	ldr	x0, [x24]
               	add	x0, x0, #0x8
               	str	x0, [x24]
               	mov	x22, #0xd               // =13
               	str	x22, [x0]
               	ldr	x10, [x24]
               	add	x10, x10, #0x8
               	str	x10, [x24]
               	mov	x22, #0x1               // =1
               	str	x22, [x10]
               	ldr	x0, [x24]
               	add	x0, x0, #0x8
               	str	x0, [x24]
               	mov	x22, #0x8               // =8
               	str	x22, [x0]
               	ldr	x10, [x24]
               	add	x10, x10, #0x8
               	str	x10, [x24]
               	mov	x22, #0x1b              // =27
               	str	x22, [x10]
               	ldr	x0, [x24]
               	add	x0, x0, #0x8
               	str	x0, [x24]
               	mov	x22, #0x1a              // =26
               	str	x22, [x0]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x22, x19
               	ldr	x24, [x22]
               	add	x24, x24, #0x8
               	str	x24, [x22]
               	mov	x0, #0x1a               // =26
               	str	x0, [x24]
               	b	<addr>
               	bl	<addr>
               	mov	x22, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x21, x19
               	ldr	x0, [x21]
               	add	x0, x0, #0x8
               	str	x0, [x21]
               	mov	x24, #0xd               // =13
               	str	x24, [x0]
               	mov	x0, #0xa2               // =162
               	bl	<addr>
               	mov	x24, x0
               	ldr	x24, [x21]
               	add	x24, x24, #0x8
               	str	x24, [x21]
               	mov	x0, #0x1b               // =27
               	str	x0, [x24]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x21, x19
               	mov	x0, #0x1                // =1
               	str	x0, [x21]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0xa0
               	b.ne	<addr>
               	bl	<addr>
               	mov	x24, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x22, x19
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x21, #0xd               // =13
               	str	x21, [x0]
               	mov	x0, #0xa2               // =162
               	bl	<addr>
               	mov	x21, x0
               	ldr	x21, [x22]
               	add	x21, x21, #0x8
               	str	x21, [x22]
               	mov	x0, #0x1c               // =28
               	str	x0, [x21]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x22, x19
               	mov	x0, #0x1                // =1
               	str	x0, [x22]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0xa1
               	b.ne	<addr>
               	bl	<addr>
               	mov	x21, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x24, x19
               	ldr	x0, [x24]
               	add	x0, x0, #0x8
               	str	x0, [x24]
               	mov	x22, #0xd               // =13
               	str	x22, [x0]
               	mov	x0, #0xa2               // =162
               	bl	<addr>
               	mov	x22, x0
               	ldr	x22, [x24]
               	add	x22, x22, #0x8
               	str	x22, [x24]
               	mov	x0, #0x1d               // =29
               	str	x0, [x22]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x24, x19
               	mov	x0, #0x1                // =1
               	str	x0, [x24]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0xa2
               	cset	x0, eq
               	stur	x0, [x29, #-0x98]
               	cbnz	x0, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x22, [x22]
               	cmp	x22, #0xa3
               	cset	x22, eq
               	stur	x22, [x29, #-0x98]
               	b	<addr>
               	ldur	x22, [x29, #-0x98]
               	cbz	x22, <addr>
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
               	add	x19, x19, #0x1c0
               	mov	x22, x19
               	ldr	x22, [x22]
               	cmp	x22, #0xa4
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x22, x19
               	ldr	x0, [x22]
               	mov	x24, #0xd               // =13
               	str	x24, [x0]
               	ldr	x10, [x22]
               	add	x10, x10, #0x8
               	str	x10, [x22]
               	mov	x24, #0xa               // =10
               	str	x24, [x10]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x22, #0xd               // =13
               	str	x22, [x1]
               	ldr	x24, [x0]
               	add	x24, x24, #0x8
               	str	x24, [x0]
               	mov	x22, #0x1               // =1
               	str	x22, [x24]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
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
               	mov	x22, x19
               	ldr	x24, [x22]
               	mov	x10, #0xd               // =13
               	str	x10, [x24]
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x10, #0x9               // =9
               	str	x10, [x0]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x42d
               	mov	x0, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x22, x19
               	ldr	x1, [x22]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x22, x0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x1, x0
               	b	<addr>
               	mov	x0, #0x8                // =8
               	stur	x0, [x29, #-0xa0]
               	b	<addr>
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0xa0]
               	b	<addr>
               	ldur	x0, [x29, #-0xa0]
               	str	x0, [x1]
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x22, x19
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x1, x19
               	ldr	x1, [x1]
               	cmp	x1, #0xa2
               	b.ne	<addr>
               	mov	x22, #0x19              // =25
               	stur	x22, [x29, #-0xa8]
               	b	<addr>
               	mov	x22, #0x1a              // =26
               	stur	x22, [x29, #-0xa8]
               	b	<addr>
               	ldur	x22, [x29, #-0xa8]
               	str	x22, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x1, x19
               	ldr	x22, [x1]
               	add	x22, x22, #0x8
               	str	x22, [x1]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x1, #0xc                // =12
               	stur	x1, [x29, #-0xb0]
               	b	<addr>
               	mov	x1, #0xb                // =11
               	stur	x1, [x29, #-0xb0]
               	b	<addr>
               	ldur	x1, [x29, #-0xb0]
               	str	x1, [x22]
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x22, #0xd               // =13
               	str	x22, [x1]
               	ldr	x24, [x0]
               	add	x24, x24, #0x8
               	str	x24, [x0]
               	mov	x22, #0x1               // =1
               	str	x22, [x24]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x22, x19
               	ldr	x22, [x22]
               	cmp	x22, #0x2
               	b.le	<addr>
               	mov	x0, #0x8                // =8
               	stur	x0, [x29, #-0xb8]
               	b	<addr>
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0xb8]
               	b	<addr>
               	ldur	x0, [x29, #-0xb8]
               	str	x0, [x1]
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x22, x19
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x1, x19
               	ldr	x1, [x1]
               	cmp	x1, #0xa2
               	b.ne	<addr>
               	mov	x22, #0x1a              // =26
               	stur	x22, [x29, #-0xc0]
               	b	<addr>
               	mov	x22, #0x19              // =25
               	stur	x22, [x29, #-0xc0]
               	b	<addr>
               	ldur	x22, [x29, #-0xc0]
               	str	x22, [x0]
               	bl	<addr>
               	b	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x22, [x0]
               	add	x22, x22, #0x8
               	str	x22, [x0]
               	mov	x1, #0xd                // =13
               	str	x1, [x22]
               	mov	x0, #0x8e               // =142
               	bl	<addr>
               	mov	x1, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x1, x19
               	ldr	x1, [x1]
               	cmp	x1, #0x5d
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x486
               	mov	x24, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x1, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x2, [x0]
               	mov	x0, x24
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x2, x0
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, #0x2
               	b.le	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x44f
               	mov	x1, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x22, [x0]
               	mov	x0, x1
               	mov	x1, x22
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x22, x0
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x22, x19
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0xd                // =13
               	str	x1, [x0]
               	ldr	x24, [x22]
               	add	x24, x24, #0x8
               	str	x24, [x22]
               	mov	x1, #0x1                // =1
               	str	x1, [x24]
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0x8                // =8
               	str	x1, [x0]
               	ldr	x24, [x22]
               	add	x24, x24, #0x8
               	str	x24, [x22]
               	mov	x1, #0x1b               // =27
               	str	x1, [x24]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x24, [x0]
               	add	x24, x24, #0x8
               	str	x24, [x0]
               	mov	x1, #0x19               // =25
               	str	x1, [x24]
               	ldr	x22, [x0]
               	add	x22, x22, #0x8
               	str	x22, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d0
               	mov	x1, x19
               	ldur	x0, [x29, #-0x8]
               	sub	x0, x0, #0x2
               	str	x0, [x1]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	ldur	x1, [x29, #-0x8]
               	cmp	x1, #0x2
               	b.ge	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x46b
               	mov	x0, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x1, x19
               	ldr	x24, [x1]
               	mov	x1, x24
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x1, x0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x24, x0
               	b	<addr>
               	b	<addr>
               	mov	x24, #0xa               // =10
               	stur	x24, [x29, #-0xc8]
               	b	<addr>
               	mov	x24, #0x9               // =9
               	stur	x24, [x29, #-0xc8]
               	b	<addr>
               	ldur	x24, [x29, #-0xc8]
               	str	x24, [x22]
               	b	<addr>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
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
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x40
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
               	mov	x15, x0
               	b	<addr>
               	mov	x0, #0x8e               // =142
               	bl	<addr>
               	mov	x1, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x1, x19
               	ldr	x1, [x1]
               	cmp	x1, #0x29
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x4a0
               	mov	x0, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x15, x19
               	ldr	x1, [x15]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x15, x0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x1, x0
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x15, [x0]
               	add	x15, x15, #0x8
               	str	x15, [x0]
               	mov	x1, #0x4                // =4
               	str	x1, [x15]
               	ldr	x12, [x0]
               	add	x12, x12, #0x8
               	str	x12, [x0]
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
               	mov	x1, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x15, [x0]
               	mov	x0, x1
               	mov	x1, x15
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x15, x0
               	b	<addr>
               	ldur	x12, [x29, #-0x10]
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x0, x19
               	ldr	x1, [x0]
               	add	x1, x1, #0x18
               	str	x1, [x12]
               	ldr	x15, [x0]
               	add	x15, x15, #0x8
               	str	x15, [x0]
               	mov	x1, #0x2                // =2
               	str	x1, [x15]
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
               	mov	x1, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x1, x19
               	ldr	x1, [x1]
               	add	x1, x1, #0x8
               	stur	x1, [x29, #-0x8]
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
               	mov	x20, x19
               	ldr	x20, [x20]
               	cmp	x20, #0x8b
               	b.ne	<addr>
               	b	<addr>
               	bl	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x0, #0x8e               // =142
               	bl	<addr>
               	mov	x12, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x12, x19
               	ldr	x12, [x12]
               	cmp	x12, #0x29
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x4d3
               	mov	x0, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x1, x19
               	ldr	x12, [x1]
               	mov	x1, x12
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x1, x0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x12, x0
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x20, x19
               	ldr	x1, [x20]
               	add	x1, x1, #0x8
               	str	x1, [x20]
               	mov	x12, #0x4               // =4
               	str	x12, [x1]
               	ldr	x15, [x20]
               	add	x15, x15, #0x8
               	str	x15, [x20]
               	stur	x15, [x29, #-0x10]
               	bl	<addr>
               	ldr	x0, [x20]
               	add	x0, x0, #0x8
               	str	x0, [x20]
               	mov	x15, #0x2               // =2
               	str	x15, [x0]
               	ldr	x1, [x20]
               	add	x1, x1, #0x8
               	str	x1, [x20]
               	ldur	x15, [x29, #-0x8]
               	str	x15, [x1]
               	ldur	x0, [x29, #-0x10]
               	ldr	x20, [x20]
               	add	x20, x20, #0x8
               	str	x20, [x0]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x4ec
               	mov	x12, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x1, [x0]
               	mov	x0, x12
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x1, x0
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
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x7b
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
               	mov	x15, #0x8               // =8
               	str	x15, [x0]
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
               	mov	x20, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x1, [x0]
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x1, x0
               	b	<addr>
               	bl	<addr>
               	mov	x1, x0
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x1, x19
               	ldr	x1, [x1]
               	cmp	x1, #0x3b
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x7d
               	b.eq	<addr>
               	bl	<addr>
               	mov	x1, x0
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x1, #0x8e               // =142
               	mov	x0, x1
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x3b
               	b.ne	<addr>
               	bl	<addr>
               	mov	x1, x0
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x51e
               	mov	x0, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x1, x19
               	ldr	x20, [x1]
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x1, x0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, x0
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
               	mov	x0, x19
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x15, x0
               	mov	x15, #0xffff            // =65535
               	movk	x15, #0xffff, lsl #16
               	movk	x15, #0xffff, lsl #32
               	movk	x15, #0xffff, lsl #48
               	mov	x0, x15
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	ldur	x0, [x29, #0x20]
               	ldr	x15, [x0]
               	mov	x1, #0x0                // =0
               	mov	x0, x15
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, x0
               	cmp	x20, #0x0
               	b.ge	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x554
               	mov	x0, x19
               	ldur	x1, [x29, #0x20]
               	ldr	x12, [x1]
               	mov	x1, x12
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x1, x0
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	mov	x0, x1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	mov	x21, #0x40000           // =262144
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
               	mov	x11, x19
               	mov	x0, x11
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
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x1a8
               	mov	x23, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x24, x19
               	mov	x0, x21
               	bl	<addr>
               	str	x0, [x24]
               	str	x0, [x23]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x58a
               	mov	x10, x19
               	mov	x0, x10
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
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x198
               	mov	x22, x19
               	mov	x0, x21
               	bl	<addr>
               	str	x0, [x22]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x5aa
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
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x1b8
               	mov	x23, x19
               	ldr	x0, [x23]
               	mov	x25, #0x0               // =0
               	mov	x1, x25
               	mov	x2, x21
               	bl	<addr>
               	mov	x22, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x22, x19
               	ldr	x0, [x22]
               	mov	x1, x25
               	mov	x2, x21
               	bl	<addr>
               	mov	x22, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x198
               	mov	x22, x19
               	ldr	x0, [x22]
               	mov	x1, x25
               	mov	x2, x21
               	bl	<addr>
               	mov	x22, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x22, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x5eb
               	mov	x0, x19
               	str	x0, [x22]
               	mov	x25, #0x86              // =134
               	stur	x25, [x29, #-0x58]
               	b	<addr>
               	ldur	x25, [x29, #-0x58]
               	cmp	x25, #0x8d
               	b.gt	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x0, x19
               	ldr	x0, [x0]
               	sub	x25, x29, #0x58
               	ldr	x22, [x25]
               	add	x24, x22, #0x1
               	str	x24, [x25]
               	str	x22, [x0]
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
               	mov	x9, #0x82               // =130
               	str	x9, [x22]
               	ldr	x24, [x0]
               	add	x24, x24, #0x20
               	mov	x9, #0x1                // =1
               	str	x9, [x24]
               	ldr	x0, [x0]
               	add	x0, x0, #0x28
               	sub	x22, x29, #0x58
               	ldr	x9, [x22]
               	add	x24, x9, #0x1
               	str	x24, [x22]
               	str	x9, [x0]
               	b	<addr>
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x23, x19
               	ldr	x25, [x23]
               	mov	x9, #0x86               // =134
               	str	x9, [x25]
               	bl	<addr>
               	ldr	x23, [x23]
               	adrp	x19, <page>
               	add	x19, x19, #0x190
               	mov	x24, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x26, x19
               	mov	x0, x21
               	bl	<addr>
               	str	x0, [x26]
               	str	x0, [x24]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x655
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
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x22, x19
               	ldr	x1, [x22]
               	sub	x2, x21, #0x1
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	stur	x0, [x29, #-0x58]
               	cmp	x0, #0x0
               	b.gt	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x677
               	mov	x2, x19
               	ldur	x1, [x29, #-0x58]
               	mov	x0, x2
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
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x1, x19
               	ldr	x1, [x1]
               	ldur	x0, [x29, #-0x58]
               	add	x1, x1, x0
               	mov	x0, #0x0                // =0
               	strb	w0, [x1]
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
               	ldr	x20, [x20]
               	cbz	x20, <addr>
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0x10]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	ldr	x20, [x20]
               	cmp	x20, #0x8a
               	b.ne	<addr>
               	b	<addr>
               	add	x23, x23, #0x28
               	ldr	x23, [x23]
               	stur	x23, [x29, #-0x30]
               	cmp	x23, #0x0
               	b.ne	<addr>
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	ldr	x20, [x20]
               	cmp	x20, #0x86
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
               	mov	x20, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	ldr	x20, [x20]
               	cmp	x20, #0x7b
               	b.eq	<addr>
               	b	<addr>
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	ldr	x20, [x20]
               	cmp	x20, #0x7b
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
               	mov	x20, x19
               	ldr	x20, [x20]
               	cmp	x20, #0x85
               	b.eq	<addr>
               	b	<addr>
               	bl	<addr>
               	mov	x26, x0
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x68b
               	mov	x0, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x20, x19
               	ldr	x1, [x20]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	ldr	x2, [x20]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, x0
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
               	mov	x20, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	ldr	x20, [x20]
               	cmp	x20, #0x80
               	b.eq	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x1, x19
               	ldr	x0, [x1]
               	add	x0, x0, #0x18
               	mov	x20, #0x80              // =128
               	str	x20, [x0]
               	ldr	x2, [x1]
               	add	x2, x2, #0x20
               	mov	x20, #0x1               // =1
               	str	x20, [x2]
               	ldr	x1, [x1]
               	add	x1, x1, #0x28
               	sub	x0, x29, #0x58
               	ldr	x20, [x0]
               	add	x2, x20, #0x1
               	str	x2, [x0]
               	str	x20, [x1]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x26, [x26]
               	cmp	x26, #0x2c
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x6a7
               	mov	x0, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x20, x19
               	ldr	x1, [x20]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, x0
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
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x1c8
               	mov	x1, x19
               	ldr	x1, [x1]
               	stur	x1, [x29, #-0x58]
               	bl	<addr>
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x3b
               	cset	x0, ne
               	stur	x0, [x29, #-0xb8]
               	cbz	x0, <addr>
               	b	<addr>
               	ldur	x0, [x29, #-0x10]
               	stur	x0, [x29, #-0x18]
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x26, [x26]
               	cmp	x26, #0x7d
               	cset	x26, ne
               	stur	x26, [x29, #-0xb8]
               	b	<addr>
               	ldur	x26, [x29, #-0xb8]
               	cbz	x26, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x9f
               	b.ne	<addr>
               	bl	<addr>
               	mov	x26, x0
               	ldur	x26, [x29, #-0x18]
               	add	x26, x26, #0x2
               	stur	x26, [x29, #-0x18]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x26, [x26]
               	cmp	x26, #0x85
               	b.eq	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x6c1
               	mov	x0, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x26, x19
               	ldr	x1, [x26]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x26, x0
               	mov	x26, #0xffff            // =65535
               	movk	x26, #0xffff, lsl #16
               	movk	x26, #0xffff, lsl #32
               	movk	x26, #0xffff, lsl #48
               	mov	x0, x26
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x1, x19
               	ldr	x1, [x1]
               	add	x1, x1, #0x18
               	ldr	x1, [x1]
               	cbz	x1, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x6dd
               	mov	x0, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x1, x19
               	ldr	x26, [x1]
               	mov	x1, x26
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x1, x0
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	mov	x0, x1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
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
               	ldur	x1, [x29, #-0x18]
               	str	x1, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x26, x19
               	ldr	x26, [x26]
               	cmp	x26, #0x28
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x1, x19
               	ldr	x26, [x1]
               	add	x26, x26, #0x18
               	mov	x0, #0x81               // =129
               	str	x0, [x26]
               	ldr	x1, [x1]
               	add	x1, x1, #0x28
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x2, x19
               	ldr	x2, [x2]
               	add	x2, x2, #0x8
               	str	x2, [x1]
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
               	mov	x20, x19
               	ldr	x0, [x20]
               	add	x0, x0, #0x18
               	mov	x2, #0x83               // =131
               	str	x2, [x0]
               	ldr	x20, [x20]
               	add	x20, x20, #0x28
               	adrp	x19, <page>
               	add	x19, x19, #0x198
               	mov	x1, x19
               	ldr	x2, [x1]
               	str	x2, [x20]
               	ldr	x0, [x1]
               	add	x0, x0, #0x8
               	str	x0, [x1]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x29
               	b.eq	<addr>
               	mov	x2, #0x1                // =1
               	stur	x2, [x29, #-0x18]
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
               	mov	x2, x0
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x86
               	b.ne	<addr>
               	bl	<addr>
               	mov	x2, x0
               	mov	x2, #0x0                // =0
               	stur	x2, [x29, #-0x18]
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x2, x19
               	ldr	x2, [x2]
               	cmp	x2, #0x9f
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
               	mov	x2, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x1, [x0]
               	mov	x0, x2
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
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x1, x19
               	ldr	x1, [x1]
               	add	x1, x1, #0x18
               	ldr	x1, [x1]
               	cmp	x1, #0x84
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x71d
               	mov	x0, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x1, x19
               	ldr	x2, [x1]
               	mov	x1, x2
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x1, x0
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	mov	x0, x1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x2, x19
               	ldr	x1, [x2]
               	add	x1, x1, #0x30
               	ldr	x0, [x2]
               	add	x0, x0, #0x18
               	ldr	x0, [x0]
               	str	x0, [x1]
               	ldr	x26, [x2]
               	add	x26, x26, #0x18
               	mov	x0, #0x84               // =132
               	str	x0, [x26]
               	ldr	x1, [x2]
               	add	x1, x1, #0x38
               	ldr	x0, [x2]
               	add	x0, x0, #0x20
               	ldr	x0, [x0]
               	str	x0, [x1]
               	ldr	x26, [x2]
               	add	x26, x26, #0x20
               	ldur	x0, [x29, #-0x18]
               	str	x0, [x26]
               	ldr	x1, [x2]
               	add	x1, x1, #0x40
               	ldr	x0, [x2]
               	add	x0, x0, #0x28
               	ldr	x0, [x0]
               	str	x0, [x1]
               	ldr	x2, [x2]
               	add	x2, x2, #0x28
               	sub	x26, x29, #0x58
               	ldr	x0, [x26]
               	add	x1, x0, #0x1
               	str	x1, [x26]
               	str	x0, [x2]
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x2c
               	b.ne	<addr>
               	bl	<addr>
               	mov	x20, x0
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x741
               	mov	x20, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x0, x19
               	ldr	x1, [x0]
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
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x1d8
               	mov	x1, x19
               	sub	x0, x29, #0x58
               	ldr	x20, [x0]
               	add	x20, x20, #0x1
               	str	x20, [x0]
               	str	x20, [x1]
               	bl	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	ldr	x20, [x20]
               	cmp	x20, #0x8a
               	cset	x20, eq
               	stur	x20, [x29, #-0xc0]
               	cbnz	x20, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	ldr	x20, [x20]
               	cmp	x20, #0x8a
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x1, x19
               	ldr	x0, [x1]
               	add	x0, x0, #0x8
               	str	x0, [x1]
               	mov	x20, #0x6               // =6
               	str	x20, [x0]
               	ldr	x2, [x1]
               	add	x2, x2, #0x8
               	str	x2, [x1]
               	ldur	x20, [x29, #-0x58]
               	adrp	x19, <page>
               	add	x19, x19, #0x1d8
               	mov	x1, x19
               	ldr	x1, [x1]
               	sub	x20, x20, x1
               	str	x20, [x2]
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
               	mov	x20, x19
               	ldr	x20, [x20]
               	cmp	x20, #0x3b
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
               	mov	x20, x0
               	ldur	x20, [x29, #-0x18]
               	add	x20, x20, #0x2
               	stur	x20, [x29, #-0x18]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	ldr	x20, [x20]
               	cmp	x20, #0x85
               	b.eq	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x75e
               	mov	x0, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x20, x19
               	ldr	x1, [x20]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, x0
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
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x1, x19
               	ldr	x1, [x1]
               	add	x1, x1, #0x18
               	ldr	x1, [x1]
               	cmp	x1, #0x84
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x779
               	mov	x0, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1e0
               	mov	x1, x19
               	ldr	x20, [x1]
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x1, x0
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	mov	x0, x1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x20, x19
               	ldr	x1, [x20]
               	add	x1, x1, #0x30
               	ldr	x0, [x20]
               	add	x0, x0, #0x18
               	ldr	x0, [x0]
               	str	x0, [x1]
               	ldr	x2, [x20]
               	add	x2, x2, #0x18
               	mov	x0, #0x84               // =132
               	str	x0, [x2]
               	ldr	x1, [x20]
               	add	x1, x1, #0x38
               	ldr	x0, [x20]
               	add	x0, x0, #0x20
               	ldr	x0, [x0]
               	str	x0, [x1]
               	ldr	x2, [x20]
               	add	x2, x2, #0x20
               	ldur	x0, [x29, #-0x18]
               	str	x0, [x2]
               	ldr	x1, [x20]
               	add	x1, x1, #0x40
               	ldr	x0, [x20]
               	add	x0, x0, #0x28
               	ldr	x0, [x0]
               	str	x0, [x1]
               	ldr	x20, [x20]
               	add	x20, x20, #0x28
               	sub	x2, x29, #0x58
               	ldr	x0, [x2]
               	add	x0, x0, #0x1
               	str	x0, [x2]
               	str	x0, [x20]
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x0, x19
               	ldr	x0, [x0]
               	cmp	x0, #0x2c
               	b.ne	<addr>
               	bl	<addr>
               	mov	x1, x0
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	ldr	x20, [x20]
               	cmp	x20, #0x7d
               	b.eq	<addr>
               	bl	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a0
               	mov	x20, x19
               	ldr	x0, [x20]
               	add	x0, x0, #0x8
               	str	x0, [x20]
               	mov	x2, #0x8                // =8
               	str	x2, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x20, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x1b8
               	mov	x2, x19
               	ldr	x2, [x2]
               	str	x2, [x20]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x2, x19
               	ldr	x2, [x2]
               	ldr	x2, [x2]
               	cbz	x2, <addr>
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
               	mov	x2, x19
               	ldr	x0, [x2]
               	add	x0, x0, #0x18
               	ldr	x20, [x2]
               	add	x20, x20, #0x30
               	ldr	x20, [x20]
               	str	x20, [x0]
               	ldr	x1, [x2]
               	add	x1, x1, #0x20
               	ldr	x20, [x2]
               	add	x20, x20, #0x38
               	ldr	x20, [x20]
               	str	x20, [x1]
               	ldr	x0, [x2]
               	add	x0, x0, #0x28
               	ldr	x2, [x2]
               	add	x2, x2, #0x40
               	ldr	x2, [x2]
               	str	x2, [x0]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1b0
               	mov	x2, x19
               	ldr	x20, [x2]
               	add	x20, x20, #0x48
               	str	x20, [x2]
               	b	<addr>
               	bl	<addr>
               	mov	x2, x0
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x799
               	mov	x0, x19
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x23, x0
               	mov	x23, #0xffff            // =65535
               	movk	x23, #0xffff, lsl #16
               	movk	x23, #0xffff, lsl #32
               	movk	x23, #0xffff, lsl #48
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x1e8
               	mov	x0, x19
               	ldr	x0, [x0]
               	cbz	x0, <addr>
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
               	mov	x23, #0x26              // =38
               	str	x23, [x0]
               	sub	x21, x29, #0x38
               	ldr	x23, [x21]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x23, x23, x17
               	str	x23, [x21]
               	mov	x0, #0xd                // =13
               	str	x0, [x23]
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
               	ldur	x23, [x29, #0x10]
               	str	x23, [x21]
               	sub	x0, x29, #0x38
               	ldr	x23, [x0]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x23, x23, x17
               	str	x23, [x0]
               	ldur	x21, [x29, #0x20]
               	str	x21, [x23]
               	sub	x0, x29, #0x38
               	ldr	x21, [x0]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x21, x21, x17
               	str	x21, [x0]
               	ldur	x23, [x29, #-0x60]
               	str	x23, [x21]
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x50]
               	b	<addr>
               	mov	x0, #0x1                // =1
               	cbz	x0, <addr>
               	sub	x23, x29, #0x30
               	ldr	x0, [x23]
               	add	x21, x0, #0x8
               	str	x21, [x23]
               	ldr	x0, [x0]
               	stur	x0, [x29, #-0x58]
               	sub	x2, x29, #0x50
               	ldr	x0, [x2]
               	add	x0, x0, #0x1
               	str	x0, [x2]
               	adrp	x19, <page>
               	add	x19, x19, #0x1f0
               	mov	x21, x19
               	ldr	x21, [x21]
               	cbz	x21, <addr>
               	b	<addr>
               	mov	x2, #0x0                // =0
               	mov	x0, x2
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x7ad
               	mov	x0, x19
               	ldur	x1, [x29, #-0x50]
               	adrp	x19, <page>
               	add	x19, x19, #0x7b6
               	mov	x2, x19
               	ldur	x23, [x29, #-0x58]
               	mov	x17, #0x5               // =5
               	mul	x23, x23, x17
               	add	x21, x2, x23
               	mov	x2, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x23, x0
               	ldur	x23, [x29, #-0x58]
               	cmp	x23, #0x7
               	b.gt	<addr>
               	b	<addr>
               	ldur	x0, [x29, #-0x58]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x87a
               	mov	x0, x19
               	ldur	x23, [x29, #-0x30]
               	ldr	x1, [x23]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x23, x0
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x87f
               	mov	x0, x19
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x23, x0
               	b	<addr>
               	ldur	x23, [x29, #-0x40]
               	sub	x0, x29, #0x30
               	ldr	x1, [x0]
               	add	x21, x1, #0x8
               	str	x21, [x0]
               	ldr	x1, [x1]
               	lsl	x1, x1, #3
               	add	x23, x23, x1
               	stur	x23, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x23, [x29, #-0x58]
               	cmp	x23, #0x1
               	b.ne	<addr>
               	sub	x1, x29, #0x30
               	ldr	x23, [x1]
               	add	x2, x23, #0x8
               	str	x2, [x1]
               	ldr	x23, [x23]
               	stur	x23, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x23, [x29, #-0x58]
               	cmp	x23, #0x2
               	b.ne	<addr>
               	ldur	x21, [x29, #-0x30]
               	ldr	x21, [x21]
               	stur	x21, [x29, #-0x30]
               	b	<addr>
               	b	<addr>
               	ldur	x21, [x29, #-0x58]
               	cmp	x21, #0x3
               	b.ne	<addr>
               	sub	x23, x29, #0x38
               	ldr	x21, [x23]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x21, x21, x17
               	str	x21, [x23]
               	ldur	x2, [x29, #-0x30]
               	add	x2, x2, #0x8
               	str	x2, [x21]
               	ldur	x23, [x29, #-0x30]
               	ldr	x23, [x23]
               	stur	x23, [x29, #-0x30]
               	b	<addr>
               	b	<addr>
               	ldur	x23, [x29, #-0x58]
               	cmp	x23, #0x4
               	b.ne	<addr>
               	ldur	x2, [x29, #-0x48]
               	cbz	x2, <addr>
               	b	<addr>
               	b	<addr>
               	ldur	x23, [x29, #-0x58]
               	cmp	x23, #0x5
               	b.ne	<addr>
               	b	<addr>
               	ldur	x23, [x29, #-0x30]
               	add	x23, x23, #0x8
               	stur	x23, [x29, #-0xd0]
               	b	<addr>
               	ldur	x23, [x29, #-0x30]
               	ldr	x23, [x23]
               	stur	x23, [x29, #-0xd0]
               	b	<addr>
               	ldur	x23, [x29, #-0xd0]
               	stur	x23, [x29, #-0x30]
               	b	<addr>
               	ldur	x2, [x29, #-0x48]
               	cbz	x2, <addr>
               	b	<addr>
               	b	<addr>
               	ldur	x23, [x29, #-0x58]
               	cmp	x23, #0x6
               	b.ne	<addr>
               	b	<addr>
               	ldur	x23, [x29, #-0x30]
               	ldr	x23, [x23]
               	stur	x23, [x29, #-0xd8]
               	b	<addr>
               	ldur	x23, [x29, #-0x30]
               	add	x23, x23, #0x8
               	stur	x23, [x29, #-0xd8]
               	b	<addr>
               	ldur	x23, [x29, #-0xd8]
               	stur	x23, [x29, #-0x30]
               	b	<addr>
               	sub	x2, x29, #0x38
               	ldr	x23, [x2]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x23, x23, x17
               	str	x23, [x2]
               	ldur	x21, [x29, #-0x40]
               	str	x21, [x23]
               	ldur	x2, [x29, #-0x38]
               	stur	x2, [x29, #-0x40]
               	sub	x21, x29, #0x30
               	ldr	x23, [x21]
               	add	x1, x23, #0x8
               	str	x1, [x21]
               	ldr	x23, [x23]
               	lsl	x23, x23, #3
               	sub	x2, x2, x23
               	stur	x2, [x29, #-0x38]
               	b	<addr>
               	b	<addr>
               	ldur	x2, [x29, #-0x58]
               	cmp	x2, #0x7
               	b.ne	<addr>
               	ldur	x23, [x29, #-0x38]
               	sub	x2, x29, #0x30
               	ldr	x0, [x2]
               	add	x1, x0, #0x8
               	str	x1, [x2]
               	ldr	x0, [x0]
               	lsl	x0, x0, #3
               	add	x23, x23, x0
               	stur	x23, [x29, #-0x38]
               	b	<addr>
               	b	<addr>
               	ldur	x23, [x29, #-0x58]
               	cmp	x23, #0x8
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x40]
               	stur	x0, [x29, #-0x38]
               	sub	x23, x29, #0x38
               	ldr	x0, [x23]
               	add	x21, x0, #0x8
               	str	x21, [x23]
               	ldr	x0, [x0]
               	stur	x0, [x29, #-0x40]
               	sub	x1, x29, #0x38
               	ldr	x0, [x1]
               	add	x21, x0, #0x8
               	str	x21, [x1]
               	ldr	x0, [x0]
               	stur	x0, [x29, #-0x30]
               	b	<addr>
               	b	<addr>
               	ldur	x0, [x29, #-0x58]
               	cmp	x0, #0x9
               	b.ne	<addr>
               	ldur	x23, [x29, #-0x48]
               	ldr	x23, [x23]
               	stur	x23, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x23, [x29, #-0x58]
               	cmp	x23, #0xa
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x48]
               	ldrb	w0, [x0]
               	stur	x0, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x0, [x29, #-0x58]
               	cmp	x0, #0xb
               	b.ne	<addr>
               	sub	x23, x29, #0x38
               	ldr	x0, [x23]
               	add	x21, x0, #0x8
               	str	x21, [x23]
               	ldr	x0, [x0]
               	ldur	x1, [x29, #-0x48]
               	str	x1, [x0]
               	b	<addr>
               	b	<addr>
               	ldur	x1, [x29, #-0x58]
               	cmp	x1, #0xc
               	b.ne	<addr>
               	sub	x21, x29, #0x38
               	ldr	x1, [x21]
               	add	x0, x1, #0x8
               	str	x0, [x21]
               	ldr	x1, [x1]
               	ldur	x23, [x29, #-0x48]
               	strb	w23, [x1]
               	stur	x23, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x23, [x29, #-0x58]
               	cmp	x23, #0xd
               	b.ne	<addr>
               	sub	x0, x29, #0x38
               	ldr	x23, [x0]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x23, x23, x17
               	str	x23, [x0]
               	ldur	x1, [x29, #-0x48]
               	str	x1, [x23]
               	b	<addr>
               	b	<addr>
               	ldur	x1, [x29, #-0x58]
               	cmp	x1, #0xe
               	b.ne	<addr>
               	sub	x0, x29, #0x38
               	ldr	x1, [x0]
               	add	x23, x1, #0x8
               	str	x23, [x0]
               	ldr	x1, [x1]
               	ldur	x21, [x29, #-0x48]
               	orr	x1, x1, x21
               	stur	x1, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x1, [x29, #-0x58]
               	cmp	x1, #0xf
               	b.ne	<addr>
               	sub	x21, x29, #0x38
               	ldr	x1, [x21]
               	add	x23, x1, #0x8
               	str	x23, [x21]
               	ldr	x1, [x1]
               	ldur	x0, [x29, #-0x48]
               	eor	x1, x1, x0
               	stur	x1, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x1, [x29, #-0x58]
               	cmp	x1, #0x10
               	b.ne	<addr>
               	sub	x0, x29, #0x38
               	ldr	x1, [x0]
               	add	x23, x1, #0x8
               	str	x23, [x0]
               	ldr	x1, [x1]
               	ldur	x21, [x29, #-0x48]
               	and	x1, x1, x21
               	stur	x1, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x1, [x29, #-0x58]
               	cmp	x1, #0x11
               	b.ne	<addr>
               	sub	x21, x29, #0x38
               	ldr	x1, [x21]
               	add	x23, x1, #0x8
               	str	x23, [x21]
               	ldr	x1, [x1]
               	ldur	x0, [x29, #-0x48]
               	cmp	x1, x0
               	cset	x1, eq
               	stur	x1, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x1, [x29, #-0x58]
               	cmp	x1, #0x12
               	b.ne	<addr>
               	sub	x0, x29, #0x38
               	ldr	x1, [x0]
               	add	x23, x1, #0x8
               	str	x23, [x0]
               	ldr	x1, [x1]
               	ldur	x21, [x29, #-0x48]
               	cmp	x1, x21
               	cset	x1, ne
               	stur	x1, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x1, [x29, #-0x58]
               	cmp	x1, #0x13
               	b.ne	<addr>
               	sub	x21, x29, #0x38
               	ldr	x1, [x21]
               	add	x23, x1, #0x8
               	str	x23, [x21]
               	ldr	x1, [x1]
               	ldur	x0, [x29, #-0x48]
               	cmp	x1, x0
               	cset	x1, lt
               	stur	x1, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x1, [x29, #-0x58]
               	cmp	x1, #0x14
               	b.ne	<addr>
               	sub	x0, x29, #0x38
               	ldr	x1, [x0]
               	add	x23, x1, #0x8
               	str	x23, [x0]
               	ldr	x1, [x1]
               	ldur	x21, [x29, #-0x48]
               	cmp	x1, x21
               	cset	x1, gt
               	stur	x1, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x1, [x29, #-0x58]
               	cmp	x1, #0x15
               	b.ne	<addr>
               	sub	x21, x29, #0x38
               	ldr	x1, [x21]
               	add	x23, x1, #0x8
               	str	x23, [x21]
               	ldr	x1, [x1]
               	ldur	x0, [x29, #-0x48]
               	cmp	x1, x0
               	cset	x1, le
               	stur	x1, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x1, [x29, #-0x58]
               	cmp	x1, #0x16
               	b.ne	<addr>
               	sub	x0, x29, #0x38
               	ldr	x1, [x0]
               	add	x23, x1, #0x8
               	str	x23, [x0]
               	ldr	x1, [x1]
               	ldur	x21, [x29, #-0x48]
               	cmp	x1, x21
               	cset	x1, ge
               	stur	x1, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x1, [x29, #-0x58]
               	cmp	x1, #0x17
               	b.ne	<addr>
               	sub	x21, x29, #0x38
               	ldr	x1, [x21]
               	add	x23, x1, #0x8
               	str	x23, [x21]
               	ldr	x1, [x1]
               	ldur	x0, [x29, #-0x48]
               	lsl	x1, x1, x0
               	stur	x1, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x1, [x29, #-0x58]
               	cmp	x1, #0x18
               	b.ne	<addr>
               	sub	x0, x29, #0x38
               	ldr	x1, [x0]
               	add	x23, x1, #0x8
               	str	x23, [x0]
               	ldr	x1, [x1]
               	ldur	x21, [x29, #-0x48]
               	asr	x1, x1, x21
               	stur	x1, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x1, [x29, #-0x58]
               	cmp	x1, #0x19
               	b.ne	<addr>
               	sub	x21, x29, #0x38
               	ldr	x1, [x21]
               	add	x23, x1, #0x8
               	str	x23, [x21]
               	ldr	x1, [x1]
               	ldur	x0, [x29, #-0x48]
               	add	x1, x1, x0
               	stur	x1, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x1, [x29, #-0x58]
               	cmp	x1, #0x1a
               	b.ne	<addr>
               	sub	x0, x29, #0x38
               	ldr	x1, [x0]
               	add	x23, x1, #0x8
               	str	x23, [x0]
               	ldr	x1, [x1]
               	ldur	x21, [x29, #-0x48]
               	sub	x1, x1, x21
               	stur	x1, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x1, [x29, #-0x58]
               	cmp	x1, #0x1b
               	b.ne	<addr>
               	sub	x21, x29, #0x38
               	ldr	x1, [x21]
               	add	x23, x1, #0x8
               	str	x23, [x21]
               	ldr	x1, [x1]
               	ldur	x0, [x29, #-0x48]
               	mul	x1, x1, x0
               	stur	x1, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x1, [x29, #-0x58]
               	cmp	x1, #0x1c
               	b.ne	<addr>
               	sub	x0, x29, #0x38
               	ldr	x1, [x0]
               	add	x23, x1, #0x8
               	str	x23, [x0]
               	ldr	x1, [x1]
               	ldur	x21, [x29, #-0x48]
               	sdiv	x1, x1, x21
               	stur	x1, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x1, [x29, #-0x58]
               	cmp	x1, #0x1d
               	b.ne	<addr>
               	sub	x21, x29, #0x38
               	ldr	x1, [x21]
               	add	x23, x1, #0x8
               	str	x23, [x21]
               	ldr	x1, [x1]
               	ldur	x0, [x29, #-0x48]
               	sdiv	x17, x1, x0
               	msub	x1, x17, x0, x1
               	stur	x1, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x1, [x29, #-0x58]
               	cmp	x1, #0x1e
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x38]
               	add	x1, x0, #0x8
               	ldr	x23, [x1]
               	ldr	x1, [x0]
               	mov	x0, x23
               	bl	<addr>
               	sxtw	x0, w0
               	stur	x0, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x0, [x29, #-0x58]
               	cmp	x0, #0x1f
               	b.ne	<addr>
               	ldur	x1, [x29, #-0x38]
               	add	x0, x1, #0x10
               	ldr	x23, [x0]
               	add	x0, x1, #0x8
               	ldr	x21, [x0]
               	ldr	x2, [x1]
               	mov	x0, x23
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	stur	x0, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x0, [x29, #-0x58]
               	cmp	x0, #0x20
               	b.ne	<addr>
               	ldur	x2, [x29, #-0x38]
               	ldr	x0, [x2]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x2, x0
               	stur	x2, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x2, [x29, #-0x58]
               	cmp	x2, #0x21
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x38]
               	ldur	x2, [x29, #-0x30]
               	add	x2, x2, #0x8
               	ldr	x2, [x2]
               	lsl	x2, x2, #3
               	add	x0, x0, x2
               	stur	x0, [x29, #-0x60]
               	ldur	x2, [x29, #-0x60]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x0, x2, x17
               	ldr	x21, [x0]
               	mov	x17, #0xfff0            // =65520
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x0, x2, x17
               	ldr	x1, [x0]
               	mov	x17, #0xffe8            // =65512
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x0, x2, x17
               	ldr	x23, [x0]
               	mov	x17, #0xffe0            // =65504
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x0, x2, x17
               	ldr	x3, [x0]
               	mov	x17, #0xffd8            // =65496
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x0, x2, x17
               	ldr	x4, [x0]
               	mov	x17, #0xffd0            // =65488
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x2, x2, x17
               	ldr	x5, [x2]
               	mov	x0, x21
               	mov	x2, x23
               	bl	<addr>
               	sxtw	x0, w0
               	stur	x0, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x0, [x29, #-0x58]
               	cmp	x0, #0x22
               	b.ne	<addr>
               	ldur	x5, [x29, #-0x38]
               	ldr	x0, [x5]
               	bl	<addr>
               	mov	x5, x0
               	stur	x5, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x5, [x29, #-0x58]
               	cmp	x5, #0x23
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x38]
               	ldr	x5, [x0]
               	mov	x0, x5
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	ldur	x5, [x29, #-0x58]
               	cmp	x5, #0x24
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x38]
               	add	x5, x0, #0x10
               	ldr	x4, [x5]
               	add	x5, x0, #0x8
               	ldr	x1, [x5]
               	ldr	x2, [x0]
               	mov	x0, x4
               	bl	<addr>
               	stur	x0, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x0, [x29, #-0x58]
               	cmp	x0, #0x25
               	b.ne	<addr>
               	ldur	x2, [x29, #-0x38]
               	add	x0, x2, #0x10
               	ldr	x1, [x0]
               	add	x0, x2, #0x8
               	ldr	x4, [x0]
               	ldr	x0, [x2]
               	mov	x2, x0
               	mov	x0, x1
               	mov	x1, x4
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x2, x0
               	stur	x2, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	ldur	x2, [x29, #-0x58]
               	cmp	x2, #0x26
               	b.ne	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x881
               	mov	x0, x19
               	ldur	x2, [x29, #-0x38]
               	ldr	x1, [x2]
               	ldur	x2, [x29, #-0x50]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x4, x0
               	ldur	x4, [x29, #-0x38]
               	ldr	x4, [x4]
               	mov	x0, x4
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x896
               	mov	x0, x19
               	ldur	x1, [x29, #-0x58]
               	ldur	x2, [x29, #-0x50]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x4, x0
               	mov	x4, #0xffff             // =65535
               	movk	x4, #0xffff, lsl #16
               	movk	x4, #0xffff, lsl #32
               	movk	x4, #0xffff, lsl #48
               	mov	x0, x4
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
