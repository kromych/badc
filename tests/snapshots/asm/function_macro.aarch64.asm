
function_macro.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	str	x1, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	x0, [x29, #0x10]
               	stur	x1, [x29, #0x20]
               	b	<addr>
               	ldur	x1, [x29, #0x10]
               	ldrb	w1, [x1]
               	stur	x1, [x29, #-0x8]
               	cbz	x1, <addr>
               	b	<addr>
               	add	x1, x29, #0x10
               	ldr	x0, [x1]
               	add	x0, x0, #0x1
               	str	x0, [x1]
               	add	x13, x29, #0x20
               	ldr	x0, [x13]
               	add	x0, x0, #0x1
               	str	x0, [x13]
               	b	<addr>
               	ldur	x0, [x29, #0x10]
               	ldrb	w0, [x0]
               	cmp	x0, #0x0
               	cset	x0, eq
               	stur	x0, [x29, #-0x10]
               	cbz	x0, <addr>
               	b	<addr>
               	ldur	x0, [x29, #0x10]
               	ldrb	w0, [x0]
               	ldur	x1, [x29, #0x20]
               	ldrb	w1, [x1]
               	cmp	x0, x1
               	cset	x0, eq
               	stur	x0, [x29, #-0x8]
               	b	<addr>
               	ldur	x0, [x29, #-0x8]
               	cbz	x0, <addr>
               	b	<addr>
               	ldur	x1, [x29, #0x20]
               	ldrb	w1, [x1]
               	cmp	x1, #0x0
               	cset	x1, eq
               	stur	x1, [x29, #-0x10]
               	b	<addr>
               	ldur	x1, [x29, #-0x10]
               	mov	x0, x1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	adrp	x19, <page>
               	add	x19, x19, #0xd0
               	mov	x20, x19
               	adrp	x19, <page>
               	add	x19, x19, #0xdb
               	mov	x21, x19
               	adrp	x19, <page>
               	add	x19, x19, #0xe6
               	mov	x22, x19
               	adrp	x19, <page>
               	add	x19, x19, #0xf1
               	mov	x1, x19
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x1, #0x15               // =21
               	mov	x0, x1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0xfc
               	mov	x1, x19
               	mov	x0, x21
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x1, #0x16               // =22
               	mov	x0, x1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x107
               	mov	x1, x19
               	mov	x0, x22
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x1, #0x17               // =23
               	mov	x0, x1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x21, #0x18              // =24
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x20
               	mov	x1, x22
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x22, #0x19              // =25
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x19, [sp]
               	adrp	x19, <page>
               	add	x19, x19, #0x112
               	mov	x0, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x11d
               	mov	x1, x19
               	bl	<addr>
               	mov	x13, x0
               	cmp	x13, #0x0
               	b.ne	<addr>
               	mov	x1, #0x1f               // =31
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x13, #0x0               // =0
               	mov	x0, x13
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x19, [sp]
               	bl	<addr>
               	sxtw	x14, w0
               	cmp	x14, #0x0
               	b.eq	<addr>
               	sxtw	x0, w0
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	mov	x14, x0
               	sxtw	x0, w14
               	cmp	x0, #0x0
               	b.eq	<addr>
               	sxtw	x14, w14
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x128
               	mov	x0, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x12d
               	mov	x1, x19
               	bl	<addr>
               	mov	x13, x0
               	cmp	x13, #0x0
               	b.ne	<addr>
               	mov	x1, #0x29               // =41
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x13, #0x0               // =0
               	mov	x0, x13
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
