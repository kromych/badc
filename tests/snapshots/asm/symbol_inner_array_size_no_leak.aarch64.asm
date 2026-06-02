
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
               	mov	x13, #0x0               // =0
               	stur	w13, [x29, #-0x8]
               	b	<addr>
               	ldursw	x13, [x29, #-0x8]
               	cmp	x13, x1
               	b.ge	<addr>
               	b	<addr>
               	sub	x12, x29, #0x8
               	ldrsw	x13, [x12]
               	add	x13, x13, #0x1
               	str	w13, [x12]
               	b	<addr>
               	ldursw	x11, [x29, #-0x8]
               	lsl	x12, x11, #1
               	add	x12, x0, x12
               	mov	x17, #0x3               // =3
               	mul	x11, x11, x17
               	sxtw	x11, w11
               	sxth	x11, w11
               	strh	w11, [x12]
               	b	<addr>
               	sub	x1, x1, #0x1
               	sxtw	x1, w1
               	lsl	x1, x1, #1
               	add	x0, x0, x1
               	ldrsh	x1, [x0]
               	mov	x0, x1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x0, x29, #0x10
               	mov	x1, #0x8                // =8
               	bl	<addr>
               	mov	x13, x0
               	sxtw	x13, w13
               	cmp	x13, #0x15
               	b.eq	<addr>
               	mov	x1, #0x1                // =1
               	mov	x0, x1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x10
               	ldrsh	x13, [x13]
               	cmp	x13, #0x0
               	cset	x13, ne
               	stur	x13, [x29, #-0x30]
               	cbnz	x13, <addr>
               	sub	x1, x29, #0x10
               	add	x1, x1, #0xe
               	ldrsh	x1, [x1]
               	cmp	x1, #0x15
               	cset	x1, ne
               	stur	x1, [x29, #-0x30]
               	b	<addr>
               	ldur	x1, [x29, #-0x30]
               	cbz	x1, <addr>
               	mov	x13, #0x2               // =2
               	mov	x0, x13
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x28
               	add	x1, x1, #0xe
               	mov	x13, #0x63              // =99
               	strh	w13, [x1]
               	sub	x0, x29, #0x28
               	add	x0, x0, #0xe
               	ldrsh	x0, [x0]
               	cmp	x0, #0x63
               	b.eq	<addr>
               	mov	x13, #0x3               // =3
               	mov	x0, x13
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
