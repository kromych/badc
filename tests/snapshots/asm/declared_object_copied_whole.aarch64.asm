
declared_object_copied_whole.aarch64:	file format elf64-littleaarch64

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

<chain>:
               	and	x1, x0, #0x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	strb	wzr, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	strb	w1, [x0]
               	ldrb	w16, [x0]
               	strb	w16, [x2]
               	ret

<to_global>:
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	stp	xzr, xzr, [x1]
               	stp	xzr, xzr, [x1, #0x10]
               	stp	xzr, xzr, [x1, #0x20]
               	stp	xzr, xzr, [x1, #0x30]
               	stp	xzr, xzr, [x1, #0x40]
               	str	xzr, [x1, #0x50]
               	str	w0, [x1, #0x54]
               	add	x2, x0, #0x1
               	str	w2, [x1, #0x34]
               	add	x2, x0, #0x2
               	str	w2, [x1, #0x38]
               	add	x0, x0, #0x3
               	str	w0, [x1, #0x44]
               	ret

<to_local>:
               	add	x1, x0, #0x1
               	mov	x17, #0x64              // =100
               	mul	x0, x0, x17
               	add	x0, x0, x1
               	ret

<through_member>:
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	stp	xzr, xzr, [x0, #0x30]
               	stp	xzr, xzr, [x0, #0x40]
               	str	xzr, [x0, #0x50]
               	add	x2, x0, #0x44
               	str	w1, [x0, #0x54]
               	add	x0, x1, #0x1
               	str	w0, [x2]
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w1, [x0]
               	and	x1, x1, #0xfffffffffffffffe
               	strb	w1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w1, [x0]
               	and	x1, x1, #0xfffffffffffffffe
               	strb	w1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0]
               	and	x0, x0, #0x1
               	cmp	w0, #0x1
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0]
               	and	x0, x0, #0x1
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x63               // =99
               	str	x1, [x0]
               	str	w1, [x0, #0x50]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	cbnz	x1, <addr>
               	ldrsw	x1, [x0, #0x50]
               	cbz	w1, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x1, [x0, #0x54]
               	cmp	w1, #0x5
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0x34]
               	cmp	w1, #0x6
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0x38]
               	cmp	w1, #0x7
               	b.ne	<addr>
               	ldrsw	x0, [x0, #0x44]
               	cmp	w0, #0x8
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	bl	<addr>
               	cmp	w0, #0x195
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x58
               	mov	x1, #0x63               // =99
               	str	x1, [x0, #0x10]
               	str	w1, [x0, #0x54]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	bl	<addr>
               	sub	x0, x29, #0x58
               	ldr	x1, [x0, #0x10]
               	cbz	x1, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x1, [x0, #0x54]
               	cmp	w1, #0x7
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0x44]
               	cmp	w1, #0x8
               	b.ne	<addr>
               	ldrsw	x0, [x0, #0x30]
               	cbz	w0, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
