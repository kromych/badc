
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
               	ldursw	x11, [x29, #-0x8]
               	lsl	x12, x11, #1
               	add	x12, x15, x12
               	mov	x17, #0x3               // =3
               	mul	x11, x11, x17
               	sxtw	x11, w11
               	sxth	x11, w11
               	strh	w11, [x12]
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
               	sub	sp, sp, #0x30
               	sub	x0, x29, #0x10
               	mov	x1, #0x8                // =8
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x15
               	b.eq	<addr>
               	mov	x1, #0x1                // =1
               	mov	x0, x1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldrsh	x0, [x0]
               	cmp	x0, #0x0
               	cset	x0, ne
               	stur	x0, [x29, #-0x30]
               	cbnz	x0, <addr>
               	sub	x1, x29, #0x10
               	add	x1, x1, #0xe
               	ldrsh	x1, [x1]
               	cmp	x1, #0x15
               	cset	x1, ne
               	stur	x1, [x29, #-0x30]
               	b	<addr>
               	ldur	x1, [x29, #-0x30]
               	cbz	x1, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x28
               	add	x1, x1, #0xe
               	mov	x0, #0x63               // =99
               	strh	w0, [x1]
               	sub	x13, x29, #0x28
               	add	x13, x13, #0xe
               	ldrsh	x13, [x13]
               	cmp	x13, #0x63
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x13, #0x0               // =0
               	mov	x0, x13
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
