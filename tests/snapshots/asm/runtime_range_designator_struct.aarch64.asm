
runtime_range_designator_struct.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x90
               	adrp	x1, <page>
               	mov	x0, #0x0                // =0
               	str	w0, [x1, #0x34]
               	sub	x2, x29, #0x90
               	stp	xzr, xzr, [x2]
               	stp	xzr, xzr, [x2, #0x10]
               	stp	xzr, xzr, [x2, #0x20]
               	stp	xzr, xzr, [x2, #0x30]
               	ldrsw	x3, [x1, #0x34]
               	add	x3, x3, #0x1
               	str	w3, [x1, #0x34]
               	mov	x3, #0xd                // =13
               	stur	w3, [x29, #-0x90]
               	mov	x3, #0x9                // =9
               	stur	x3, [x29, #-0x88]
               	add	x3, x2, #0x10
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x3]
               	add	x3, x2, #0x20
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x3]
               	mov	x3, #0x5                // =5
               	stur	w3, [x29, #-0x60]
               	mov	x3, #0x6                // =6
               	stur	x3, [x29, #-0x58]
               	ldrsw	x1, [x1, #0x34]
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x65               // =101
               	cbz	x0, <addr>
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	mov	x0, #0x0                // =0
               	str	w0, [x1, #0x34]
               	mov	x2, #0x1                // =1
               	str	w2, [x1, #0x34]
               	ldrsw	x2, [x1, #0x34]
               	cmp	w2, #0x1
               	b.eq	<addr>
               	mov	x2, #0x69               // =105
               	cbz	x2, <addr>
               	mov	x0, x2
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	str	w0, [x1, #0x34]
               	sub	x2, x29, #0x70
               	stp	xzr, xzr, [x2]
               	stp	xzr, xzr, [x2, #0x10]
               	ldrsw	x3, [x1, #0x34]
               	add	x3, x3, #0x1
               	str	w3, [x1, #0x34]
               	mov	x3, #0x1d               // =29
               	stur	w3, [x29, #-0x70]
               	mov	x3, #0x5                // =5
               	stur	w3, [x29, #-0x6c]
               	ldur	x3, [x29, #-0x70]
               	stur	x3, [x29, #-0x68]
               	stur	x3, [x29, #-0x60]
               	ldrsw	x1, [x1, #0x34]
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x6a               // =106
               	cbz	x0, <addr>
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x1, x2, x0, lsl #3
               	ldrsw	x3, [x1]
               	cmp	w3, #0x1d
               	b.ne	<addr>
               	ldrsw	x1, [x1, #0x4]
               	cmp	w1, #0x5
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	ldursw	x0, [x29, #-0x58]
               	cbnz	w0, <addr>
               	ldursw	x0, [x29, #-0x54]
               	cbz	w0, <addr>
               	mov	x0, #0xc                // =12
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0xb                // =11
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
               	add	x1, x2, x0, lsl #4
               	ldrsw	x3, [x1]
               	cmp	w3, #0xd
               	b.ne	<addr>
               	ldr	x1, [x1, #0x8]
               	cmp	x1, #0x9
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	ldursw	x0, [x29, #-0x60]
               	cmp	w0, #0x5
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x58]
               	cmp	x0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	b	<addr>
               	sub	x2, x29, #0x50
               	stp	xzr, xzr, [x2]
               	stp	xzr, xzr, [x2, #0x10]
               	stp	xzr, xzr, [x2, #0x20]
               	stp	xzr, xzr, [x2, #0x30]
               	stp	xzr, xzr, [x2, #0x40]
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x34]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x34]
               	mov	x1, #0xd                // =13
               	stur	w1, [x29, #-0x40]
               	mov	x1, #0x9                // =9
               	stur	x1, [x29, #-0x38]
               	add	x3, x2, #0x20
               	add	x1, x2, #0x10
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	add	x3, x2, #0x30
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	mov	x1, #0x5                // =5
               	stur	w1, [x29, #-0x10]
               	mov	x1, #0x6                // =6
               	stur	x1, [x29, #-0x8]
               	ldrsw	x0, [x0, #0x34]
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x67               // =103
               	b	<addr>
               	ldursw	x0, [x29, #-0x50]
               	cbnz	w0, <addr>
               	ldur	x0, [x29, #-0x48]
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	mov	x0, #0x1                // =1
               	add	x1, x2, x0, lsl #4
               	ldrsw	x3, [x1]
               	cmp	w3, #0xd
               	b.ne	<addr>
               	ldr	x1, [x1, #0x8]
               	cmp	x1, #0x9
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.le	<addr>
               	ldursw	x0, [x29, #-0x10]
               	cmp	w0, #0x5
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	b	<addr>
               	sub	x0, x29, #0x30
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	adrp	x1, <page>
               	ldrsw	x2, [x1, #0x34]
               	add	x2, x2, #0x1
               	str	w2, [x1, #0x34]
               	mov	x2, #0xd                // =13
               	stur	w2, [x29, #-0x30]
               	mov	x2, #0x1                // =1
               	stur	x2, [x29, #-0x28]
               	add	x2, x0, #0x10
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	add	x2, x0, #0x20
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	ldrsw	x0, [x1, #0x34]
               	add	x0, x0, #0x1
               	str	w0, [x1, #0x34]
               	mov	x0, #0x11               // =17
               	stur	w0, [x29, #-0x20]
               	mov	x0, #0x2                // =2
               	stur	x0, [x29, #-0x18]
               	ldrsw	x0, [x1, #0x34]
               	cmp	w0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x68               // =104
               	b	<addr>
               	ldursw	x0, [x29, #-0x30]
               	cmp	w0, #0xd
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x28]
               	cmp	x0, #0x1
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x10]
               	cmp	w0, #0xd
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	b	<addr>
               	ldursw	x0, [x29, #-0x20]
               	cmp	w0, #0x11
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x7                // =7
               	b	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
