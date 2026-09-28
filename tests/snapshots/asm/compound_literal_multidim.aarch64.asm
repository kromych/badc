
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
               	ldr	x1, [x0]
               	ldrsb	x1, [x1]
               	ldr	x2, [x0]
               	ldrsb	x2, [x2, #0x1]
               	add	x1, x1, x2
               	ldr	x2, [x0]
               	ldrsb	x2, [x2, #0x2]
               	add	x1, x1, x2
               	ldr	x2, [x0]
               	add	x2, x2, #0x3
               	ldrsb	x2, [x2]
               	add	x1, x1, x2
               	ldr	x2, [x0]
               	add	x2, x2, #0x3
               	ldrsb	x2, [x2, #0x1]
               	add	x1, x1, x2
               	ldr	x2, [x0]
               	add	x2, x2, #0x3
               	ldrsb	x2, [x2, #0x2]
               	add	x1, x1, x2
               	cmp	w1, #0x15
               	b.ne	<addr>
               	ldr	x0, [x0]
               	ldrsb	x0, [x0, #0x5]
               	cmp	w0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	ldrsw	x1, [x1]
               	cmp	w1, #0xa
               	b.ne	<addr>
               	ldr	x1, [x0]
               	ldrsw	x1, [x1, #0xc]
               	cmp	w1, #0xd
               	b.ne	<addr>
               	ldr	x0, [x0]
               	ldrsw	x0, [x0, #0x10]
               	cmp	w0, #0xe
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x18
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w16, [x0]
               	str	w16, [x1]
               	ldrh	w16, [x0, #0x4]
               	strh	w16, [x1, #0x4]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w16, [x0]
               	str	w16, [x1]
               	ldrh	w16, [x0, #0x4]
               	strh	w16, [x1, #0x4]
               	sub	x0, x29, #0x28
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldr	x16, [x2, #0x10]
               	str	x16, [x0, #0x10]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldr	x16, [x2, #0x10]
               	str	x16, [x0, #0x10]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x16, [x2]
               	str	x16, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x0, #0x10]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x2, [x1]
               	ldrsw	x2, [x2, #0x4]
               	cmp	w2, #0x15
               	b.ne	<addr>
               	ldr	x1, [x1]
               	ldrsw	x1, [x1, #0x8]
               	cmp	w1, #0x16
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	w1, #0x18
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x0, #0x10]
               	sub	x0, x29, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldr	w16, [x1, #0x8]
               	str	w16, [x0, #0x8]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldrsw	x0, [x0, #0x10]
               	cmp	w0, #0x5
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldrsw	x0, [x0, #0x8]
               	cmp	w0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldrsw	x0, [x0]
               	cmp	w0, #0x6
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	ldrsw	x1, [x1]
               	cmp	w1, #0x4
               	b.ne	<addr>
               	ldr	x0, [x0]
               	ldrsw	x0, [x0, #0x8]
               	cmp	w0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
