
runtime_range_designator_struct.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<check_struct_ranges>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xd0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x1, #0x0                // =0
               	str	w1, [x3]
               	sub	x0, x29, #0xc0
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	x1, [x0, #0x10]
               	str	x1, [x0, #0x18]
               	str	x1, [x0, #0x20]
               	str	x1, [x0, #0x28]
               	str	x1, [x0, #0x30]
               	str	x1, [x0, #0x38]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0xd                // =13
               	sub	x1, x29, #0xc0
               	str	w0, [x1]
               	mov	x1, #0x9                // =9
               	sub	x0, x29, #0xc0
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0xc0
               	add	x1, x0, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0xc0
               	add	x1, x0, #0x20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x1, #0x5                // =5
               	sub	x0, x29, #0xc0
               	str	w1, [x0, #0x30]
               	mov	x1, #0x6                // =6
               	sub	x0, x29, #0xc0
               	str	x1, [x0, #0x38]
               	ldrsw	x0, [x3]
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x65               // =101
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0xc0
               	lsl	x4, x1, #4
               	add	x2, x2, x4
               	ldrsw	x2, [x2]
               	cmp	x2, #0xd
               	cset	x2, ne
               	cbnz	x2, <addr>
               	sub	x2, x29, #0xc0
               	lsl	x4, x1, #4
               	add	x2, x2, x4
               	ldr	x2, [x2, #0x8]
               	cmp	x2, #0x9
               	cset	x2, ne
               	cbz	x2, <addr>
               	b	<addr>
               	b	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x3
               	b.lt	<addr>
               	sub	x0, x29, #0xc0
               	ldrsw	x0, [x0, #0x30]
               	cmp	x0, #0x5
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0xc0
               	ldr	x0, [x0, #0x38]
               	cmp	x0, #0x6
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x80
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	x1, [x0, #0x10]
               	str	x1, [x0, #0x18]
               	str	x1, [x0, #0x20]
               	str	x1, [x0, #0x28]
               	str	x1, [x0, #0x30]
               	str	x1, [x0, #0x38]
               	str	x1, [x0, #0x40]
               	str	x1, [x0, #0x48]
               	ldrsw	x0, [x3]
               	add	x0, x0, #0x1
               	str	w0, [x3]
               	mov	x1, #0xd                // =13
               	sub	x0, x29, #0x80
               	str	w1, [x0, #0x10]
               	mov	x1, #0x9                // =9
               	sub	x0, x29, #0x80
               	str	x1, [x0, #0x18]
               	sub	x0, x29, #0x80
               	add	x1, x0, #0x20
               	add	x0, x0, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x80
               	add	x1, x0, #0x30
               	add	x0, x0, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x1, #0x5                // =5
               	sub	x0, x29, #0x80
               	str	w1, [x0, #0x40]
               	mov	x1, #0x6                // =6
               	sub	x0, x29, #0x80
               	str	x1, [x0, #0x48]
               	ldrsw	x0, [x3]
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x67               // =103
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x80
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x80
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
               	sub	x2, x29, #0x80
               	lsl	x4, x1, #4
               	add	x2, x2, x4
               	ldrsw	x2, [x2]
               	cmp	x2, #0xd
               	cset	x2, ne
               	cbnz	x2, <addr>
               	sub	x2, x29, #0x80
               	lsl	x4, x1, #4
               	add	x2, x2, x4
               	ldr	x2, [x2, #0x8]
               	cmp	x2, #0x9
               	cset	x2, ne
               	cbz	x2, <addr>
               	b	<addr>
               	b	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x3
               	b.le	<addr>
               	sub	x0, x29, #0x80
               	ldrsw	x0, [x0, #0x40]
               	cmp	x0, #0x5
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x80
               	ldr	x0, [x0, #0x48]
               	cmp	x0, #0x6
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0xd0
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
               	ldrsw	x0, [x3]
               	add	x0, x0, #0x1
               	str	w0, [x3]
               	mov	x0, #0xd                // =13
               	sub	x1, x29, #0x30
               	str	w0, [x1]
               	mov	x1, #0x1                // =1
               	sub	x0, x29, #0x30
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x30
               	add	x1, x0, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x30
               	add	x1, x0, #0x20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	ldrsw	x0, [x3]
               	add	x0, x0, #0x1
               	str	w0, [x3]
               	mov	x1, #0x11               // =17
               	sub	x0, x29, #0x30
               	str	w1, [x0, #0x10]
               	mov	x1, #0x2                // =2
               	sub	x0, x29, #0x30
               	str	x1, [x0, #0x18]
               	ldrsw	x0, [x3]
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x68               // =104
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x30
               	ldrsw	x0, [x0]
               	cmp	x0, #0xd
               	cset	x0, ne
               	mov	x1, #0x1                // =1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x30
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x1
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x30
               	ldrsw	x0, [x0, #0x20]
               	cmp	x0, #0xd
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x30
               	ldr	x0, [x0, #0x28]
               	cmp	x0, #0x1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x30
               	ldrsw	x0, [x0, #0x10]
               	cmp	x0, #0x11
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x30
               	ldr	x0, [x0, #0x18]
               	cmp	x0, #0x2
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_member_range>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x1, #0x0                // =0
               	str	w1, [x2]
               	sub	x0, x29, #0x18
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	x1, [x0, #0x10]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x11               // =17
               	sub	x0, x29, #0x18
               	str	w1, [x0, #0x4]
               	sub	x0, x29, #0x18
               	mov	x1, #0x11               // =17
               	str	w1, [x0, #0x8]
               	sub	x0, x29, #0x18
               	mov	x1, #0x11               // =17
               	str	w1, [x0, #0xc]
               	mov	x1, #0x8                // =8
               	sub	x0, x29, #0x18
               	str	w1, [x0, #0x14]
               	ldrsw	x0, [x2]
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x69               // =105
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x18
               	ldrsw	x0, [x0, #0x10]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>

<check_row_range>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x1, #0x0                // =0
               	str	w1, [x2]
               	sub	x0, x29, #0x20
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	x1, [x0, #0x10]
               	str	x1, [x0, #0x18]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x1d               // =29
               	sub	x1, x29, #0x20
               	str	w0, [x1]
               	mov	x1, #0x5                // =5
               	sub	x0, x29, #0x20
               	str	w1, [x0, #0x4]
               	sub	x0, x29, #0x20
               	ldr	x1, [x0]
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x20
               	ldr	x1, [x0]
               	str	x1, [x0, #0x10]
               	ldrsw	x0, [x2]
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x6a               // =106
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x20
               	lsl	x3, x1, #3
               	add	x2, x2, x3
               	ldrsw	x2, [x2]
               	cmp	x2, #0x1d
               	cset	x2, ne
               	cbnz	x2, <addr>
               	sub	x2, x29, #0x20
               	lsl	x3, x1, #3
               	add	x2, x2, x3
               	ldrsw	x2, [x2, #0x4]
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
               	ldrsw	x0, [x0, #0x18]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x20
               	ldrsw	x0, [x0, #0x1c]
               	cmp	x0, #0x0
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
