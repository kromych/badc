
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
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	str	w0, [x2]
               	sub	x1, x29, #0x40
               	stp	xzr, xzr, [x1]
               	stp	xzr, xzr, [x1, #0x10]
               	stp	xzr, xzr, [x1, #0x20]
               	stp	xzr, xzr, [x1, #0x30]
               	ldrsw	x3, [x2]
               	add	x3, x3, #0x1
               	str	w3, [x2]
               	mov	x3, #0xd                // =13
               	str	w3, [x1]
               	mov	x3, #0x9                // =9
               	str	x3, [x1, #0x8]
               	add	x3, x1, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x3]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	add	x3, x1, #0x20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x3]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x3, #0x5                // =5
               	str	w3, [x1, #0x30]
               	mov	x3, #0x6                // =6
               	str	x3, [x1, #0x38]
               	ldrsw	x2, [x2]
               	cmp	w2, #0x1
               	b.eq	<addr>
               	mov	x0, #0x65               // =101
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	lsl	x3, x0, #4
               	add	x2, x1, x3
               	ldrsw	x4, [x2]
               	cmp	w4, #0xd
               	b.ne	<addr>
               	ldr	x2, [x2, #0x8]
               	cmp	x2, #0x9
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	sub	x0, x29, #0x40
               	ldrsw	x1, [x0, #0x30]
               	cmp	w1, #0x5
               	b.ne	<addr>
               	ldr	x0, [x0, #0x38]
               	cmp	x0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x50
               	stp	xzr, xzr, [x1]
               	stp	xzr, xzr, [x1, #0x10]
               	stp	xzr, xzr, [x1, #0x20]
               	stp	xzr, xzr, [x1, #0x30]
               	stp	xzr, xzr, [x1, #0x40]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	mov	x2, #0xd                // =13
               	str	w2, [x1, #0x10]
               	mov	x2, #0x9                // =9
               	str	x2, [x1, #0x18]
               	add	x3, x1, #0x20
               	add	x2, x1, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x3]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	add	x3, x1, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x3]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, #0x5                // =5
               	str	w2, [x1, #0x40]
               	mov	x2, #0x6                // =6
               	str	x2, [x1, #0x48]
               	ldrsw	x0, [x0]
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x67               // =103
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x1]
               	cbnz	x0, <addr>
               	ldr	x0, [x1, #0x8]
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	lsl	x3, x0, #4
               	add	x2, x1, x3
               	ldrsw	x4, [x2]
               	cmp	w4, #0xd
               	b.ne	<addr>
               	ldr	x2, [x2, #0x8]
               	cmp	x2, #0x9
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.le	<addr>
               	sub	x0, x29, #0x50
               	ldrsw	x1, [x0, #0x40]
               	cmp	w1, #0x5
               	b.ne	<addr>
               	ldr	x0, [x0, #0x48]
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
               	str	w2, [x0]
               	mov	x2, #0x1                // =1
               	str	x2, [x0, #0x8]
               	add	x2, x0, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	add	x2, x0, #0x20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	ldrsw	x2, [x1]
               	add	x2, x2, #0x1
               	str	w2, [x1]
               	mov	x2, #0x11               // =17
               	str	w2, [x0, #0x10]
               	mov	x2, #0x2                // =2
               	str	x2, [x0, #0x18]
               	ldrsw	x1, [x1]
               	cmp	w1, #0x4
               	b.eq	<addr>
               	mov	x0, #0x68               // =104
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x1, [x0]
               	cmp	w1, #0xd
               	b.ne	<addr>
               	ldr	x1, [x0, #0x8]
               	cmp	x1, #0x1
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0x20]
               	cmp	w1, #0xd
               	b.ne	<addr>
               	ldr	x1, [x0, #0x28]
               	cmp	x1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0, #0x10]
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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	str	w1, [x0]
               	mov	x2, x1
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	ldrsw	x0, [x0]
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x69               // =105
               	ret
               	mov	x0, x1
               	ret

<check_row_range>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	str	w0, [x2]
               	sub	x1, x29, #0x20
               	stp	xzr, xzr, [x1]
               	stp	xzr, xzr, [x1, #0x10]
               	ldrsw	x3, [x2]
               	add	x3, x3, #0x1
               	str	w3, [x2]
               	mov	x3, #0x1d               // =29
               	str	w3, [x1]
               	mov	x3, #0x5                // =5
               	str	w3, [x1, #0x4]
               	ldr	x3, [x1]
               	str	x3, [x1, #0x8]
               	str	x3, [x1, #0x10]
               	ldrsw	x2, [x2]
               	cmp	w2, #0x1
               	b.eq	<addr>
               	mov	x0, #0x6a               // =106
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	lsl	x3, x0, #3
               	add	x2, x1, x3
               	ldrsw	x4, [x2]
               	cmp	w4, #0x1d
               	b.ne	<addr>
               	ldrsw	x2, [x2, #0x4]
               	cmp	w2, #0x5
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	sub	x0, x29, #0x20
               	ldrsw	x1, [x0, #0x18]
               	cbnz	x1, <addr>
               	ldrsw	x0, [x0, #0x1c]
               	cbz	x0, <addr>
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
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x11               // =17
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1d               // =29
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
