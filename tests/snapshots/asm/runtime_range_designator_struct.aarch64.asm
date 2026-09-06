
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
               	sub	sp, sp, #0x60
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x0, #0x0                // =0
               	str	w0, [x5]
               	sub	x1, x29, #0x40
               	str	x0, [x1]
               	str	x0, [x1, #0x8]
               	str	x0, [x1, #0x10]
               	str	x0, [x1, #0x18]
               	str	x0, [x1, #0x20]
               	str	x0, [x1, #0x28]
               	str	x0, [x1, #0x30]
               	str	x0, [x1, #0x38]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x3, [x2]
               	add	x3, x3, #0x1
               	str	w3, [x2]
               	mov	x2, #0xd                // =13
               	str	w2, [x1]
               	mov	x2, #0x9                // =9
               	str	x2, [x1, #0x8]
               	add	x2, x1, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	add	x2, x1, #0x20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, #0x5                // =5
               	str	w2, [x1, #0x30]
               	mov	x2, #0x6                // =6
               	str	x2, [x1, #0x38]
               	ldrsw	x2, [x5]
               	cmp	w2, #0x1
               	b.eq	<addr>
               	mov	x0, #0x65               // =101
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	sxtw	x2, w0
               	lsl	x4, x2, #4
               	add	x3, x1, x4
               	ldrsw	x6, [x3]
               	cmp	w6, #0xd
               	b.ne	<addr>
               	ldr	x3, [x3, #0x8]
               	cmp	x3, #0x9
               	cset	x3, ne
               	cbnz	x3, <addr>
               	add	x0, x2, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	sub	x0, x29, #0x40
               	ldrsw	x1, [x0, #0x30]
               	cmp	w1, #0x5
               	b.ne	<addr>
               	ldr	x0, [x0, #0x38]
               	cmp	x0, #0x6
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x50
               	mov	x0, #0x0                // =0
               	str	x0, [x1]
               	str	x0, [x1, #0x8]
               	str	x0, [x1, #0x10]
               	str	x0, [x1, #0x18]
               	str	x0, [x1, #0x20]
               	str	x0, [x1, #0x28]
               	str	x0, [x1, #0x30]
               	str	x0, [x1, #0x38]
               	str	x0, [x1, #0x40]
               	str	x0, [x1, #0x48]
               	ldrsw	x0, [x5]
               	add	x0, x0, #0x1
               	str	w0, [x5]
               	mov	x0, #0xd                // =13
               	str	w0, [x1, #0x10]
               	mov	x0, #0x9                // =9
               	str	x0, [x1, #0x18]
               	add	x2, x1, #0x20
               	add	x0, x1, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	add	x2, x1, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	mov	x0, #0x5                // =5
               	str	w0, [x1, #0x40]
               	mov	x0, #0x6                // =6
               	str	x0, [x1, #0x48]
               	ldrsw	x0, [x5]
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x67               // =103
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x1]
               	cbnz	x0, <addr>
               	ldr	x0, [x1, #0x8]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
               	sxtw	x2, w0
               	lsl	x4, x2, #4
               	add	x3, x1, x4
               	ldrsw	x6, [x3]
               	cmp	w6, #0xd
               	b.ne	<addr>
               	ldr	x3, [x3, #0x8]
               	cmp	x3, #0x9
               	cset	x3, ne
               	cbnz	x3, <addr>
               	add	x0, x2, #0x1
               	cmp	w0, #0x3
               	b.le	<addr>
               	sub	x0, x29, #0x50
               	ldrsw	x1, [x0, #0x40]
               	cmp	w1, #0x5
               	b.ne	<addr>
               	ldr	x0, [x0, #0x48]
               	cmp	x0, #0x6
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x30
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	x1, [x0, #0x10]
               	str	x1, [x0, #0x18]
               	str	x1, [x0, #0x20]
               	str	x1, [x0, #0x28]
               	ldrsw	x2, [x5]
               	add	x2, x2, #0x1
               	str	w2, [x5]
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
               	ldrsw	x2, [x5]
               	add	x2, x2, #0x1
               	str	w2, [x5]
               	mov	x2, #0x11               // =17
               	str	w2, [x0, #0x10]
               	mov	x2, #0x2                // =2
               	str	x2, [x0, #0x18]
               	ldrsw	x2, [x5]
               	cmp	w2, #0x4
               	b.eq	<addr>
               	mov	x0, #0x68               // =104
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x2, [x0]
               	cmp	w2, #0xd
               	b.ne	<addr>
               	ldr	x2, [x0, #0x8]
               	cmp	x2, #0x1
               	cset	x2, ne
               	cbnz	x2, <addr>
               	ldrsw	x2, [x0, #0x20]
               	cmp	w2, #0xd
               	cset	x2, ne
               	cbnz	x2, <addr>
               	ldr	x2, [x0, #0x28]
               	cmp	x2, #0x1
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0, #0x10]
               	cmp	w0, #0x11
               	b.ne	<addr>
               	mov	x0, x1
               	mov	x0, x1
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_member_range>:
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	str	w0, [x1]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x3, [x2]
               	add	x3, x3, #0x1
               	str	w3, [x2]
               	ldrsw	x1, [x1]
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x69               // =105
               	ret
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, x0
               	ret

<check_row_range>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	str	w0, [x2]
               	sub	x1, x29, #0x20
               	str	x0, [x1]
               	str	x0, [x1, #0x8]
               	str	x0, [x1, #0x10]
               	str	x0, [x1, #0x18]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x4, [x3]
               	add	x4, x4, #0x1
               	str	w4, [x3]
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
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	sxtw	x2, w0
               	lsl	x4, x2, #3
               	add	x3, x1, x4
               	ldrsw	x5, [x3]
               	cmp	w5, #0x1d
               	b.ne	<addr>
               	ldrsw	x3, [x3, #0x4]
               	cmp	w3, #0x5
               	cset	x3, ne
               	cbnz	x3, <addr>
               	add	x0, x2, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	sub	x0, x29, #0x20
               	ldrsw	x1, [x0, #0x18]
               	cbnz	x1, <addr>
               	ldrsw	x0, [x0, #0x1c]
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x30
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
