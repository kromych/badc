
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
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, #0x0                // =0
               	str	w0, [x6]
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
               	ldrsw	x2, [x6]
               	cmp	x2, #0x1
               	b.eq	<addr>
               	mov	x0, #0x65               // =101
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	lsl	x5, x2, #4
               	add	x4, x1, x5
               	ldrsw	x3, [x4]
               	cmp	x3, #0xd
               	cset	x3, ne
               	cbnz	x3, <addr>
               	ldr	x3, [x4, #0x8]
               	cmp	x3, #0x9
               	cset	x3, ne
               	cbz	x3, <addr>
               	b	<addr>
               	b	<addr>
               	add	x0, x2, #0x1
               	sxtw	x2, w0
               	cmp	x2, #0x3
               	b.lt	<addr>
               	sub	x0, x29, #0x40
               	ldrsw	x1, [x0, #0x30]
               	cmp	x1, #0x5
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldr	x0, [x0, #0x38]
               	cmp	x0, #0x6
               	cset	x1, ne
               	cbz	x1, <addr>
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
               	ldrsw	x0, [x6]
               	add	x0, x0, #0x1
               	str	w0, [x6]
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
               	ldrsw	x0, [x6]
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x67               // =103
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x2, [x1]
               	cmp	x2, #0x0
               	cset	x0, ne
               	cbnz	x2, <addr>
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
               	lsl	x5, x2, #4
               	add	x4, x1, x5
               	ldrsw	x3, [x4]
               	cmp	x3, #0xd
               	cset	x3, ne
               	cbnz	x3, <addr>
               	ldr	x3, [x4, #0x8]
               	cmp	x3, #0x9
               	cset	x3, ne
               	cbz	x3, <addr>
               	b	<addr>
               	b	<addr>
               	add	x0, x2, #0x1
               	sxtw	x2, w0
               	cmp	x2, #0x3
               	b.le	<addr>
               	sub	x0, x29, #0x50
               	ldrsw	x1, [x0, #0x40]
               	cmp	x1, #0x5
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldr	x0, [x0, #0x48]
               	cmp	x0, #0x6
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x30
               	mov	x2, #0x0                // =0
               	str	x2, [x0]
               	str	x2, [x0, #0x8]
               	str	x2, [x0, #0x10]
               	str	x2, [x0, #0x18]
               	str	x2, [x0, #0x20]
               	str	x2, [x0, #0x28]
               	ldrsw	x1, [x6]
               	add	x1, x1, #0x1
               	str	w1, [x6]
               	mov	x1, #0xd                // =13
               	str	w1, [x0]
               	mov	x1, #0x1                // =1
               	str	x1, [x0, #0x8]
               	add	x3, x0, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	add	x3, x0, #0x20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	ldrsw	x3, [x6]
               	add	x3, x3, #0x1
               	str	w3, [x6]
               	mov	x3, #0x11               // =17
               	str	w3, [x0, #0x10]
               	mov	x3, #0x2                // =2
               	str	x3, [x0, #0x18]
               	ldrsw	x3, [x6]
               	cmp	x3, #0x4
               	b.eq	<addr>
               	mov	x0, #0x68               // =104
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x3, [x0]
               	cmp	x3, #0xd
               	b.ne	<addr>
               	ldr	x3, [x0, #0x8]
               	cmp	x3, #0x1
               	cset	x3, ne
               	cbnz	x3, <addr>
               	ldrsw	x1, [x0, #0x20]
               	cmp	x1, #0xd
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldr	x1, [x0, #0x28]
               	cmp	x1, #0x1
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x1, [x0, #0x10]
               	cmp	x1, #0x11
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldr	x0, [x0, #0x18]
               	cmp	x0, #0x2
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x2
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x3, x1
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
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
               	cmp	x1, #0x1
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
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	str	w0, [x1]
               	sub	x3, x29, #0x20
               	str	x0, [x3]
               	str	x0, [x3, #0x8]
               	str	x0, [x3, #0x10]
               	str	x0, [x3, #0x18]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x4, [x2]
               	add	x4, x4, #0x1
               	str	w4, [x2]
               	mov	x2, #0x1d               // =29
               	str	w2, [x3]
               	mov	x2, #0x5                // =5
               	str	w2, [x3, #0x4]
               	ldr	x2, [x3]
               	str	x2, [x3, #0x8]
               	str	x2, [x3, #0x10]
               	ldrsw	x1, [x1]
               	cmp	x1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x6a               // =106
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	lsl	x5, x1, #3
               	add	x4, x3, x5
               	ldrsw	x2, [x4]
               	cmp	x2, #0x1d
               	cset	x2, ne
               	cbnz	x2, <addr>
               	ldrsw	x2, [x4, #0x4]
               	cmp	x2, #0x5
               	cset	x2, ne
               	cbz	x2, <addr>
               	b	<addr>
               	b	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x3
               	b.lt	<addr>
               	sub	x0, x29, #0x20
               	ldrsw	x2, [x0, #0x18]
               	cmp	x2, #0x0
               	cset	x1, ne
               	cbnz	x2, <addr>
               	ldrsw	x0, [x0, #0x1c]
               	cmp	x0, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
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
