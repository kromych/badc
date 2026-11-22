
aggregate_conditional_reads_each_word.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<pick_pair>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x2, #0x4                // =4
               	cbz	w1, <addr>
               	sub	x0, x29, #0x20
               	stur	x2, [x29, #-0x20]
               	mov	x1, #0x5                // =5
               	stur	x1, [x29, #-0x18]
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0x64              // =100
               	mul	x1, x1, x17
               	add	x0, x1, x0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #-0x4               // =-4
               	sub	x0, x29, #0x10
               	stur	x1, [x29, #-0x10]
               	mov	x1, #-0x5               // =-5
               	stur	x1, [x29, #-0x8]
               	b	<addr>

<pick_triple>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	mov	x2, #0x2                // =2
               	cbz	w1, <addr>
               	sub	x0, x29, #0x30
               	stur	x2, [x29, #-0x30]
               	mov	x1, #0x4                // =4
               	stur	x1, [x29, #-0x28]
               	mov	x1, #0x6                // =6
               	stur	x1, [x29, #-0x20]
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	ldr	x0, [x0, #0x10]
               	mov	x17, #0xa               // =10
               	mul	x2, x2, x17
               	add	x1, x1, x2
               	mov	x17, #0x64              // =100
               	mul	x0, x0, x17
               	add	x0, x1, x0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	stp	xzr, xzr, [x0]
               	str	xzr, [x0, #0x10]
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x0, <page>
               	ldrsw	x2, [x0, #0x24]
               	adrp	x1, <page>
               	mov	x3, #0x5                // =5
               	mov	x4, #0x0                // =0
               	ldrsw	x5, [x1, #0x20]
               	cmp	w5, #0x0
               	csel	x3, x3, x4, ge
               	eor	x2, x2, x3
               	str	w2, [x0, #0x24]
               	cmp	w2, #0x5
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x1, #0x20]
               	cmp	w0, #0x0
               	b.lt	<addr>
               	mov	x0, #0x4                // =4
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	cmp	x0, #0x195
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	cmn	x0, #0x195
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	cmp	x0, #0x282
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
