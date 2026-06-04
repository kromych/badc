
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
               	sxtw	x1, w1
               	mov	x2, #0x0                // =0
               	stur	w2, [x29, #-0x8]
               	b	<addr>
               	ldursw	x2, [x29, #-0x8]
               	cmp	x2, x1
               	b.ge	<addr>
               	b	<addr>
               	sub	x2, x29, #0x8
               	ldrsw	x3, [x2]
               	add	x3, x3, #0x1
               	str	w3, [x2]
               	b	<addr>
               	ldursw	x2, [x29, #-0x8]
               	lsl	x3, x2, #1
               	add	x3, x0, x3
               	mov	x17, #0x3               // =3
               	mul	x2, x2, x17
               	sxtw	x2, w2
               	sxth	x2, w2
               	strh	w2, [x3]
               	b	<addr>
               	sub	x1, x1, #0x1
               	sxtw	x1, w1
               	lsl	x1, x1, #1
               	add	x0, x0, x1
               	ldrsh	x0, [x0]
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
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldrsh	x0, [x0]
               	cmp	x0, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x10
               	add	x0, x0, #0xe
               	ldrsh	x0, [x0]
               	cmp	x0, #0x15
               	cset	x1, ne
               	b	<addr>
               	cbz	x1, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x28
               	add	x0, x0, #0xe
               	mov	x1, #0x63               // =99
               	strh	w1, [x0]
               	sub	x0, x29, #0x28
               	add	x0, x0, #0xe
               	ldrsh	x0, [x0]
               	cmp	x0, #0x63
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
