
compound_literal_multidim.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	add	x0, x0, #0x0
               	add	x0, x0, #0x0
               	ldrsb	x0, [x0]
               	add	x0, x0, #0x0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	add	x1, x1, #0x0
               	ldrsb	x1, [x1, #0x1]
               	add	x0, x0, x1
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	add	x1, x1, #0x0
               	ldrsb	x1, [x1, #0x2]
               	add	x0, x0, x1
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	add	x1, x1, #0x3
               	add	x1, x1, #0x0
               	ldrsb	x1, [x1]
               	add	x0, x0, x1
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	add	x1, x1, #0x3
               	ldrsb	x1, [x1, #0x1]
               	add	x0, x0, x1
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	add	x1, x1, #0x3
               	ldrsb	x1, [x1, #0x2]
               	add	x0, x0, x1
               	cmp	w0, #0x15
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldrsb	x0, [x0, #0x5]
               	cmp	w0, #0x6
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldrsw	x0, [x0]
               	cmp	w0, #0xa
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldrsw	x0, [x0, #0xc]
               	cmp	w0, #0xd
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldrsw	x0, [x0, #0x10]
               	cmp	w0, #0xe
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x18
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x0]
               	strb	w10, [x2]
               	ldrb	w10, [x0, #0x1]
               	strb	w10, [x2, #0x1]
               	ldrb	w10, [x0, #0x2]
               	strb	w10, [x2, #0x2]
               	ldrb	w10, [x0, #0x3]
               	strb	w10, [x2, #0x3]
               	ldrb	w10, [x0, #0x4]
               	strb	w10, [x2, #0x4]
               	ldrb	w10, [x0, #0x5]
               	strb	w10, [x2, #0x5]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	mov	x0, #0x0                // =0
               	mov	x3, x0
               	mov	x1, x0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x1]
               	strb	w10, [x2]
               	ldrb	w10, [x1, #0x1]
               	strb	w10, [x2, #0x1]
               	ldrb	w10, [x1, #0x2]
               	strb	w10, [x2, #0x2]
               	ldrb	w10, [x1, #0x3]
               	strb	w10, [x2, #0x3]
               	ldrb	w10, [x1, #0x4]
               	strb	w10, [x2, #0x4]
               	ldrb	w10, [x1, #0x5]
               	strb	w10, [x2, #0x5]
               	ldr	x10, [sp], #0x10
               	mov	x1, x2
               	sub	x3, x29, #0x28
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x3]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x3, #0x10]
               	ldr	x10, [sp], #0x10
               	mov	x1, x3
               	mov	x4, x0
               	mov	x4, x0
               	mov	x1, x0
               	mov	x4, x0
               	mov	x1, x0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x3]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x3, #0x10]
               	ldr	x10, [sp], #0x10
               	mov	x1, x3
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [sp], #0x10
               	mov	x1, x2
               	mov	x2, x0
               	mov	x1, x0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x3]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x3, #0x10]
               	ldr	x10, [sp], #0x10
               	mov	x1, x3
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldrsw	x0, [x0, #0x4]
               	cmp	w0, #0x15
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldrsw	x0, [x0, #0x8]
               	cmp	w0, #0x16
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x18
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	mov	x1, x0
               	sub	x1, x29, #0x28
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x1]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [x2, #0x10]
               	str	x10, [x1, #0x10]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0x20
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x1]
               	ldrb	w10, [x2, #0x8]
               	strb	w10, [x1, #0x8]
               	ldrb	w10, [x2, #0x9]
               	strb	w10, [x1, #0x9]
               	ldrb	w10, [x2, #0xa]
               	strb	w10, [x1, #0xa]
               	ldrb	w10, [x2, #0xb]
               	strb	w10, [x1, #0xb]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	w1, #0x4
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	ldrsw	x1, [x1, #0x10]
               	cmp	w1, #0x5
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	ldrsw	x1, [x1, #0x8]
               	cmp	w1, #0x9
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	ldrsw	x1, [x1]
               	cmp	w1, #0x6
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	ldrsw	x1, [x1]
               	cmp	w1, #0x4
               	cset	x1, ne
               	cbnz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	ldrsw	x1, [x1, #0x8]
               	cmp	w1, #0x6
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
