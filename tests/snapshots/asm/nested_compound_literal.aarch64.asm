
nested_compound_literal.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	x0, [sp, #-0x10]!
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldur	x0, [x29, #0x10]
               	sub	x1, x29, #0x10
               	adrp	x2, <page>
               	add	x2, x2, #0xf0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x1]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xe0
               	str	x20, [sp]
               	sub	x0, x29, #0x20
               	adrp	x1, <page>
               	add	x1, x1, #0x100
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldrb	w10, [x1, #0x8]
               	strb	w10, [x0, #0x8]
               	ldrb	w10, [x1, #0x9]
               	strb	w10, [x0, #0x9]
               	ldrb	w10, [x1, #0xa]
               	strb	w10, [x0, #0xa]
               	ldrb	w10, [x1, #0xb]
               	strb	w10, [x0, #0xb]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x20
               	sub	x1, x29, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldrb	w10, [x0, #0x8]
               	strb	w10, [x1, #0x8]
               	ldrb	w10, [x0, #0x9]
               	strb	w10, [x1, #0x9]
               	ldrb	w10, [x0, #0xa]
               	strb	w10, [x1, #0xa]
               	ldrb	w10, [x0, #0xb]
               	strb	w10, [x1, #0xb]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x10
               	ldrsw	x0, [x0]
               	cmp	x0, #0x3
               	cset	x0, ne
               	mov	x20, #0x1               // =1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x10
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x4
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x20, ne
               	cbnz	x20, <addr>
               	sub	x0, x29, #0x10
               	ldrsw	x0, [x0, #0x8]
               	cmp	x0, #0x5
               	cset	x20, ne
               	cbz	x20, <addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x30
               	adrp	x1, <page>
               	add	x1, x1, #0x10c
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldrb	w10, [x1, #0x8]
               	strb	w10, [x0, #0x8]
               	ldrb	w10, [x1, #0x9]
               	strb	w10, [x0, #0x9]
               	ldrb	w10, [x1, #0xa]
               	strb	w10, [x0, #0xa]
               	ldrb	w10, [x1, #0xb]
               	strb	w10, [x0, #0xb]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x30
               	ldrsw	x0, [x0]
               	cmp	x0, #0x6
               	cset	x0, ne
               	mov	x20, #0x1               // =1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x30
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x7
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x20, ne
               	cbnz	x20, <addr>
               	sub	x0, x29, #0x30
               	ldrsw	x0, [x0, #0x8]
               	cmp	x0, #0x8
               	cset	x20, ne
               	cbz	x20, <addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0xd0
               	ldrsw	x0, [x0]
               	cmp	x0, #0x1
               	cset	x0, ne
               	mov	x20, #0x1               // =1
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0xd0
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x2
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x20, ne
               	cbnz	x20, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0xd0
               	ldrsw	x0, [x0, #0x8]
               	cmp	x0, #0x9
               	cset	x20, ne
               	cbz	x20, <addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x50
               	adrp	x1, <page>
               	add	x1, x1, #0x118
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x50
               	sub	x1, x29, #0x40
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x40
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x7
               	cset	x20, ne
               	cbnz	x20, <addr>
               	sub	x0, x29, #0x40
               	ldrsw	x0, [x0]
               	cmp	x0, #0x2a
               	cset	x20, ne
               	cbz	x20, <addr>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0xe0
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x3
               	cset	x20, ne
               	cbnz	x20, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0xe0
               	ldrsw	x0, [x0]
               	cmp	x0, #0x5
               	cset	x20, ne
               	cbz	x20, <addr>
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xc0
               	bl	<addr>
               	sub	x0, x29, #0xc0
               	sub	x1, x29, #0x60
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x60
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x2
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x60
               	ldrsw	x0, [x0]
               	cmp	x0, #0xb
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x6                // =6
               	ldr	x20, [sp]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
