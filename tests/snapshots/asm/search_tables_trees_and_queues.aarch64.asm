
search_tables_trees_and_queues.aarch64:	file format elf64-littleaarch64

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

<cmp>:
               	ldrsw	x0, [x0]
               	ldrsw	x1, [x1]
               	sub	x0, x0, x1
               	ret

<collect>:
               	eor	x2, x1, #0x1
               	cbz	w2, <addr>
               	eor	x1, x1, #0x3
               	cbnz	w1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	cmp	w2, #0x8
               	b.ge	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x2, [x1]
               	add	x4, x2, #0x1
               	str	w4, [x1]
               	ldr	x0, [x0]
               	ldrsw	x0, [x0]
               	str	w0, [x3, x2, lsl #2]
               	ret

<main>:
               	stp	x20, x21, [sp, #-0xc0]!
               	stp	x29, x30, [sp, #0xb0]
               	add	x29, sp, #0xb0
               	stur	xzr, [x29, #-0x98]
               	mov	x0, #0x1e               // =30
               	stur	w0, [x29, #-0x90]
               	mov	x0, #0x28               // =40
               	stur	w0, [x29, #-0x88]
               	sub	x0, x29, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	mov	x0, #0x3                // =3
               	stur	x0, [x29, #-0x80]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x98
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	ldr	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	cmp	x1, x0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0xb0]
               	ldp	x20, x21, [sp], #0xc0
               	ret
               	add	x0, x0, #0x4
               	sub	x1, x29, #0x98
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	ldr	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x2, x0, #0x4
               	cmp	x1, x2
               	b.ne	<addr>
               	add	x0, x0, #0x8
               	sub	x1, x29, #0x98
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	ldr	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x2, x0, #0x8
               	cmp	x1, x2
               	b.ne	<addr>
               	add	x0, x0, #0xc
               	sub	x1, x29, #0x98
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	ldr	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x2, x0, #0xc
               	cmp	x1, x2
               	b.ne	<addr>
               	add	x0, x0, #0x10
               	sub	x1, x29, #0x98
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	ldr	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x2, x0, #0x10
               	cmp	x1, x2
               	b.ne	<addr>
               	add	x0, x0, #0x14
               	sub	x1, x29, #0x98
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	ldr	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x2, x0, #0x14
               	cmp	x1, x2
               	b.ne	<addr>
               	add	x0, x0, #0x10
               	sub	x1, x29, #0x98
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	ldr	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, #0x10
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0xb0]
               	ldp	x20, x21, [sp], #0xc0
               	ret
               	sub	x0, x29, #0x90
               	sub	x1, x29, #0x98
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	cbz	x0, <addr>
               	sub	x0, x29, #0x88
               	sub	x1, x29, #0x98
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0xb0]
               	ldp	x20, x21, [sp], #0xc0
               	ret
               	ldur	x0, [x29, #-0x98]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x6
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	cmp	w1, #0xa
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0x8]
               	cmp	w1, #0x1e
               	b.ne	<addr>
               	ldrsw	x0, [x0, #0x14]
               	cmp	w0, #0x46
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0xb0]
               	ldp	x20, x21, [sp], #0xc0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x4
               	sub	x1, x29, #0x98
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x4
               	sub	x1, x29, #0x98
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0xb0]
               	ldp	x20, x21, [sp], #0xc0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	wzr, [x0]
               	ldur	x0, [x29, #-0x98]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x5
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x4]
               	cmp	w0, #0x1e
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0xb0]
               	ldp	x20, x21, [sp], #0xc0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x98
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x4
               	sub	x1, x29, #0x98
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x8
               	sub	x1, x29, #0x98
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0xc
               	sub	x1, x29, #0x98
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x10
               	sub	x1, x29, #0x98
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x14
               	sub	x1, x29, #0x98
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	ldur	x0, [x29, #-0x98]
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0xb0]
               	ldp	x20, x21, [sp], #0xc0
               	ret
               	sub	x0, x29, #0x88
               	sub	x1, x29, #0x20
               	sub	x2, x29, #0x80
               	mov	x3, #0x4                // =4
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	bl	<addr>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x28
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x80]
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0xb0]
               	ldp	x20, x21, [sp], #0xc0
               	ret
               	sub	x1, x29, #0x20
               	mov	x3, #0x4                // =4
               	add	x0, x1, #0x4
               	sub	x2, x29, #0x80
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	bl	<addr>
               	sub	x1, x29, #0x20
               	add	x2, x1, #0x4
               	cmp	x0, x2
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x80]
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0xb0]
               	ldp	x20, x21, [sp], #0xc0
               	ret
               	sub	x0, x29, #0x88
               	sub	x2, x29, #0x80
               	mov	x3, #0x4                // =4
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	bl	<addr>
               	sub	x1, x29, #0x20
               	add	x1, x1, #0xc
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0xb0]
               	ldp	x20, x21, [sp], #0xc0
               	ret
               	sub	x0, x29, #0x68
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x0, #0x10]
               	sub	x0, x29, #0x50
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x0, #0x10]
               	sub	x0, x29, #0x38
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x0, #0x10]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x20, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x21, x0
               	mov	x0, #0x10               // =16
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0xb0]
               	ldp	x20, x21, [sp], #0xc0
               	ret
               	sub	x0, x29, #0x78
               	stur	x20, [x29, #-0x78]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	stur	x1, [x29, #-0x70]
               	mov	x2, #0x1                // =1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0xb0]
               	ldp	x20, x21, [sp], #0xc0
               	ret
               	sub	x0, x29, #0x78
               	stur	x21, [x29, #-0x78]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, #0x4
               	stur	x1, [x29, #-0x70]
               	mov	x2, #0x1                // =1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0xb0]
               	ldp	x20, x21, [sp], #0xc0
               	ret
               	sub	x0, x29, #0x78
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	stur	x1, [x29, #-0x78]
               	mov	x2, #0x0                // =0
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	ldr	x0, [x0, #0x8]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp, #0xb0]
               	ldp	x20, x21, [sp], #0xc0
               	ret
               	sub	x0, x29, #0x78
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	stur	x1, [x29, #-0x78]
               	mov	x2, #0x0                // =0
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0xf                // =15
               	ldp	x29, x30, [sp, #0xb0]
               	ldp	x20, x21, [sp], #0xc0
               	ret
               	bl	<addr>
               	mov	x0, x20
               	bl	<addr>
               	mov	x0, x21
               	bl	<addr>
               	sub	x0, x29, #0x68
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	sub	x0, x29, #0x38
               	sub	x1, x29, #0x68
               	bl	<addr>
               	sub	x0, x29, #0x50
               	sub	x1, x29, #0x68
               	bl	<addr>
               	sub	x1, x29, #0x68
               	ldur	x2, [x29, #-0x68]
               	sub	x0, x29, #0x50
               	cmp	x2, x0
               	b.ne	<addr>
               	ldur	x2, [x29, #-0x50]
               	sub	x3, x29, #0x38
               	cmp	x2, x3
               	b.ne	<addr>
               	ldur	x2, [x29, #-0x30]
               	cmp	x2, x0
               	b.ne	<addr>
               	ldur	x2, [x29, #-0x48]
               	cmp	x2, x1
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	ldp	x29, x30, [sp, #0xb0]
               	ldp	x20, x21, [sp], #0xc0
               	ret
               	bl	<addr>
               	sub	x0, x29, #0x68
               	ldur	x1, [x29, #-0x68]
               	sub	x2, x29, #0x38
               	cmp	x1, x2
               	b.ne	<addr>
               	ldur	x1, [x29, #-0x30]
               	cmp	x1, x0
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	ldp	x29, x30, [sp, #0xb0]
               	ldp	x20, x21, [sp], #0xc0
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0xb0]
               	ldp	x20, x21, [sp], #0xc0
               	ret
