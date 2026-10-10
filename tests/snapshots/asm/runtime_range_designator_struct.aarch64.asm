
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

<check_struct_ranges>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	str	w0, [x1]
               	sub	x2, x29, #0x40
               	stp	xzr, xzr, [x2]
               	stp	xzr, xzr, [x2, #0x10]
               	stp	xzr, xzr, [x2, #0x20]
               	stp	xzr, xzr, [x2, #0x30]
               	ldrsw	x3, [x1]
               	add	x3, x3, #0x1
               	str	w3, [x1]
               	mov	x3, #0xd                // =13
               	stur	w3, [x29, #-0x40]
               	mov	x3, #0x9                // =9
               	stur	x3, [x29, #-0x38]
               	add	x3, x2, #0x10
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x3]
               	add	x3, x2, #0x20
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x3]
               	mov	x3, #0x5                // =5
               	stur	w3, [x29, #-0x10]
               	mov	x3, #0x6                // =6
               	stur	x3, [x29, #-0x8]
               	ldrsw	x1, [x1]
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x65               // =101
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	lsl	x1, x0, #4
               	add	x1, x2, x1
               	ldrsw	x3, [x1]
               	cmp	w3, #0xd
               	b.ne	<addr>
               	ldr	x1, [x1, #0x8]
               	cmp	x1, #0x9
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	ldursw	x0, [x29, #-0x10]
               	cmp	w0, #0x5
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x50
               	stp	xzr, xzr, [x2]
               	stp	xzr, xzr, [x2, #0x10]
               	stp	xzr, xzr, [x2, #0x20]
               	stp	xzr, xzr, [x2, #0x30]
               	stp	xzr, xzr, [x2, #0x40]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
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
               	ldrsw	x0, [x0]
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x67               // =103
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x50]
               	cbnz	w0, <addr>
               	ldur	x0, [x29, #-0x48]
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	lsl	x1, x0, #4
               	add	x1, x2, x1
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
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x30
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	add	x2, x2, #0x1
               	str	w2, [x1]
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
               	ldrsw	x0, [x1]
               	add	x0, x0, #0x1
               	str	w0, [x1]
               	mov	x0, #0x11               // =17
               	stur	w0, [x29, #-0x20]
               	mov	x0, #0x2                // =2
               	stur	x0, [x29, #-0x18]
               	ldrsw	x0, [x1]
               	cmp	w0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x68               // =104
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
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
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x20]
               	cmp	w0, #0x11
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_member_range>:
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	str	w0, [x1]
               	mov	x2, x0
               	add	x2, x2, #0x1
               	str	w2, [x1]
               	ldrsw	x1, [x1]
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x69               // =105
               	ret
               	ret

<check_row_range>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	str	w0, [x1]
               	sub	x2, x29, #0x20
               	stp	xzr, xzr, [x2]
               	stp	xzr, xzr, [x2, #0x10]
               	ldrsw	x3, [x1]
               	add	x3, x3, #0x1
               	str	w3, [x1]
               	mov	x3, #0x1d               // =29
               	stur	w3, [x29, #-0x20]
               	mov	x3, #0x5                // =5
               	stur	w3, [x29, #-0x1c]
               	ldur	x3, [x29, #-0x20]
               	stur	x3, [x29, #-0x18]
               	stur	x3, [x29, #-0x10]
               	ldrsw	x1, [x1]
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x6a               // =106
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	lsl	x1, x0, #3
               	add	x1, x2, x1
               	ldrsw	x3, [x1]
               	cmp	w3, #0x1d
               	b.ne	<addr>
               	ldrsw	x1, [x1, #0x4]
               	cmp	w1, #0x5
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	ldursw	x0, [x29, #-0x8]
               	cbnz	w0, <addr>
               	ldursw	x0, [x29, #-0x4]
               	cbz	w0, <addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0xd                // =13
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x11               // =17
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1d               // =29
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
