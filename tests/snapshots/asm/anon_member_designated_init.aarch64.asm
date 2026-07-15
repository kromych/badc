
anon_member_designated_init.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xc0
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x8]
               	sub	x1, x29, #0x8
               	mov	x2, #0x10               // =16
               	mov	x0, #0x7                // =7
               	sub	x3, x29, #0xa0
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x4]
               	str	x10, [x3]
               	ldr	x10, [x4, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [x4, #0x10]
               	str	x10, [x3, #0x10]
               	ldr	x10, [sp], #0x10
               	sub	x3, x29, #0xa0
               	str	w0, [x3]
               	sub	x0, x29, #0xa0
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0xa0
               	str	x2, [x0, #0x10]
               	sub	x0, x29, #0xa0
               	ldrsw	x0, [x0]
               	cmp	x0, #0x7
               	cset	x2, eq
               	mov	x0, #0x0                // =0
               	cbz	x2, <addr>
               	sub	x0, x29, #0xa0
               	ldr	x0, [x0, #0x8]
               	cmp	x0, x1
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	sub	x0, x29, #0xa0
               	ldr	x0, [x0, #0x10]
               	cmp	x0, #0x10
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [sp], #0x10
               	mov	x0, #0x3                // =3
               	sub	x1, x29, #0x20
               	str	w0, [x1]
               	sub	x1, x29, #0x8
               	sub	x0, x29, #0x20
               	str	x1, [x0, #0x8]
               	mov	x1, #0x8                // =8
               	sub	x0, x29, #0x20
               	str	x1, [x0, #0x10]
               	sub	x0, x29, #0x20
               	ldrsw	x0, [x0]
               	cmp	x0, #0x3
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x20
               	ldr	x0, [x0, #0x8]
               	sub	x1, x29, #0x8
               	cmp	x0, x1
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x20
               	ldr	x0, [x0, #0x10]
               	cmp	x0, #0x8
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x1, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [sp], #0x10
               	mov	x0, #0x5                // =5
               	sub	x1, x29, #0x40
               	str	w0, [x1]
               	sub	x1, x29, #0x8
               	sub	x0, x29, #0x40
               	str	x1, [x0, #0x8]
               	mov	x1, #0x4                // =4
               	sub	x0, x29, #0x40
               	str	x1, [x0, #0x10]
               	mov	x1, #0x9                // =9
               	sub	x0, x29, #0x40
               	str	w1, [x0, #0x18]
               	sub	x0, x29, #0x40
               	ldrsw	x0, [x0]
               	cmp	x0, #0x5
               	cset	x0, ne
               	mov	x1, #0x1                // =1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x40
               	ldr	x0, [x0, #0x8]
               	sub	x1, x29, #0x8
               	cmp	x0, x1
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x40
               	ldr	x0, [x0, #0x10]
               	cmp	x0, #0x4
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x40
               	ldrsw	x0, [x0, #0x18]
               	cmp	x0, #0x9
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x58
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x58
               	ldrsw	x0, [x0]
               	cmp	x0, #0x1
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x58
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x2a
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	b	<addr>
               	b	<addr>
