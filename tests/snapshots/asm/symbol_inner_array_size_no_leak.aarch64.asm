
symbol_inner_array_size_no_leak.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x15, x0
               	sxtw	x14, w1
               	mov	x13, #0x0               // =0
               	stur	w13, [x29, #-0x8]
               	b	<addr>
               	ldursw	x13, [x29, #-0x8]
               	cmp	x13, x14
               	b.ge	<addr>
               	b	<addr>
               	sub	x12, x29, #0x8
               	ldrsw	x13, [x12]
               	add	x13, x13, #0x1
               	str	w13, [x12]
               	b	<addr>
               	ldursw	x13, [x29, #-0x8]
               	lsl	x11, x13, #1
               	add	x11, x15, x11
               	mov	x17, #0x3               // =3
               	mul	x13, x13, x17
               	sxtw	x13, w13
               	sxth	x13, w13
               	strh	w13, [x11]
               	b	<addr>
               	sub	x14, x14, #0x1
               	sxtw	x14, w14
               	lsl	x14, x14, #1
               	add	x15, x15, x14
               	ldrsh	x0, [x15]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	sub	x20, x29, #0x10
               	mov	x21, #0x8               // =8
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x15
               	b.eq	<addr>
               	mov	x21, #0x1               // =1
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldrsh	x21, [x0]
               	cmp	x21, #0x0
               	cset	x21, ne
               	stur	x21, [x29, #-0x30]
               	cbnz	x21, <addr>
               	sub	x0, x29, #0x10
               	add	x0, x0, #0xe
               	ldrsh	x21, [x0]
               	cmp	x21, #0x15
               	cset	x21, ne
               	stur	x21, [x29, #-0x30]
               	b	<addr>
               	ldur	x21, [x29, #-0x30]
               	cbz	x21, <addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x21, x29, #0x28
               	add	x21, x21, #0xe
               	mov	x0, #0x63               // =99
               	strh	w0, [x21]
               	sub	x20, x29, #0x28
               	add	x20, x20, #0xe
               	ldrsh	x0, [x20]
               	cmp	x0, #0x63
               	b.eq	<addr>
               	mov	x20, #0x3               // =3
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
