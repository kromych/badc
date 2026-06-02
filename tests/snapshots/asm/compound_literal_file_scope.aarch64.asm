
compound_literal_file_scope.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xe8]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	adrp	x14, <page>
               	add	x14, x14, #0xf8
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x14, [x14]
               	cbz	x14, <addr>
               	adrp	x13, <page>
               	add	x13, x13, #0xf8
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
               	adrp	x12, <page>
               	add	x12, x12, #0x110
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x12, <page>
               	add	x12, x12, #0x116
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x12, <page>
               	add	x12, x12, #0x11d
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x1, [x11]
               	bl	<addr>
               	cbz	x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, #0xf8
               	lsl	x11, x20, #3
               	add	x1, x1, x11
               	ldr	x0, [x0]
               	str	x0, [x1]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0xf8
               	lsl	x20, x20, #3
               	add	x0, x0, x20
               	ldr	x0, [x0]
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	adrp	x15, <page>
               	add	x15, x15, #0x148
               	ldr	x15, [x15]
               	ldrsw	x15, [x15]
               	cmp	x15, #0x1
               	cset	x15, ne
               	stur	x15, [x29, #-0x10]
               	cbnz	x15, <addr>
               	adrp	x14, <page>
               	add	x14, x14, #0x148
               	ldr	x14, [x14]
               	add	x14, x14, #0x4
               	ldrsw	x14, [x14]
               	cmp	x14, #0x4
               	cset	x14, ne
               	stur	x14, [x29, #-0x10]
               	b	<addr>
               	ldur	x14, [x29, #-0x10]
               	stur	x14, [x29, #-0x8]
               	cbnz	x14, <addr>
               	adrp	x15, <page>
               	add	x15, x15, #0x148
               	ldr	x15, [x15]
               	add	x15, x15, #0x8
               	ldrsw	x15, [x15]
               	cmp	x15, #0x4
               	cset	x15, ne
               	stur	x15, [x29, #-0x8]
               	b	<addr>
               	ldur	x15, [x29, #-0x8]
               	cbz	x15, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x15, <page>
               	add	x15, x15, #0x160
               	ldr	x15, [x15]
               	ldrsw	x15, [x15]
               	cmp	x15, #0x2
               	cset	x15, ne
               	stur	x15, [x29, #-0x20]
               	cbnz	x15, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x160
               	ldr	x0, [x0]
               	add	x0, x0, #0x4
               	ldrsw	x0, [x0]
               	cmp	x0, #0x8
               	cset	x0, ne
               	stur	x0, [x29, #-0x20]
               	b	<addr>
               	ldur	x0, [x29, #-0x20]
               	stur	x0, [x29, #-0x18]
               	cbnz	x0, <addr>
               	adrp	x15, <page>
               	add	x15, x15, #0x160
               	ldr	x15, [x15]
               	add	x15, x15, #0x8
               	ldrsw	x15, [x15]
               	cmp	x15, #0x8
               	cset	x15, ne
               	stur	x15, [x29, #-0x18]
               	b	<addr>
               	ldur	x15, [x29, #-0x18]
               	cbz	x15, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x15, <page>
               	add	x15, x15, #0x178
               	ldr	x15, [x15]
               	ldrsw	x15, [x15]
               	cmp	x15, #0x0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x15, <page>
               	add	x15, x15, #0x178
               	ldr	x15, [x15]
               	add	x15, x15, #0x8
               	ldr	x15, [x15]
               	ldrb	w15, [x15]
               	mov	x17, #0x72              // =114
               	eor	x15, x15, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x15, x17
               	cmp	x15, #0x0
               	cset	x15, ne
               	stur	x15, [x29, #-0x28]
               	cbnz	x15, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x178
               	ldr	x0, [x0]
               	add	x0, x0, #0x8
               	ldr	x0, [x0]
               	add	x0, x0, #0x1
               	ldrb	w0, [x0]
               	mov	x17, #0x6f              // =111
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	stur	x0, [x29, #-0x28]
               	b	<addr>
               	ldur	x0, [x29, #-0x28]
               	cbz	x0, <addr>
               	mov	x15, #0x4               // =4
               	mov	x0, x15
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x178
               	ldr	x0, [x0]
               	add	x0, x0, #0x10
               	ldr	x0, [x0]
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x15, #0x5               // =5
               	mov	x0, x15
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x1a0
               	ldr	x0, [x0]
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	cset	x0, ne
               	stur	x0, [x29, #-0x38]
               	cbnz	x0, <addr>
               	adrp	x15, <page>
               	add	x15, x15, #0x1a0
               	ldr	x15, [x15]
               	add	x15, x15, #0x4
               	ldrsw	x15, [x15]
               	cmp	x15, #0x0
               	cset	x15, ne
               	stur	x15, [x29, #-0x38]
               	b	<addr>
               	ldur	x15, [x29, #-0x38]
               	stur	x15, [x29, #-0x30]
               	cbnz	x15, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a0
               	ldr	x0, [x0]
               	add	x0, x0, #0x8
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	cset	x0, ne
               	stur	x0, [x29, #-0x30]
               	b	<addr>
               	ldur	x0, [x29, #-0x30]
               	cbz	x0, <addr>
               	mov	x15, #0x6               // =6
               	mov	x0, x15
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
