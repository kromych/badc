
nested_designator_string_member.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x2, x0
               	ldrb	w3, [x2]
               	cbz	x3, <addr>
               	b	<addr>
               	add	x2, x2, #0x1
               	add	x1, x1, #0x1
               	b	<addr>
               	ldrb	w0, [x2]
               	ldrb	w1, [x1]
               	cmp	x0, x1
               	cset	x0, eq
               	ret
               	ldrb	w0, [x2]
               	ldrb	w3, [x1]
               	cmp	x0, x3
               	cset	x3, eq
               	cbz	x3, <addr>
               	b	<addr>
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	mov	x20, x0
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	add	x0, x21, #0x4
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w0, [x21, #0x7]
               	cmp	x0, #0x0
               	cset	x22, ne
               	cbnz	x22, <addr>
               	ldrb	w0, [x21, #0xb]
               	cmp	x0, #0x0
               	cset	x22, ne
               	cbz	x22, <addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x21, #0xc]
               	cmp	x0, #0x7
               	cset	x22, ne
               	cbnz	x22, <addr>
               	ldrsw	x0, [x21]
               	cmp	x0, #0x5
               	cset	x22, ne
               	cbz	x22, <addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, #0x77               // =119
               	sub	x1, x29, #0x10
               	strb	w0, [x1, #0x4]
               	mov	x0, #0x78               // =120
               	sub	x1, x29, #0x10
               	strb	w0, [x1, #0x5]
               	mov	x0, #0x79               // =121
               	sub	x1, x29, #0x10
               	strb	w0, [x1, #0x6]
               	mov	x0, #0x7a               // =122
               	sub	x1, x29, #0x10
               	strb	w0, [x1, #0x7]
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x10
               	strb	w0, [x1, #0x8]
               	sub	x1, x29, #0x10
               	strb	w0, [x1, #0x9]
               	sub	x1, x29, #0x10
               	strb	w0, [x1, #0xa]
               	sub	x1, x29, #0x10
               	strb	w0, [x1, #0xb]
               	add	x0, x20, #0x6
               	sub	x1, x29, #0x10
               	str	w0, [x1, #0xc]
               	add	x0, x20, #0x4
               	sub	x1, x29, #0x10
               	str	w0, [x1]
               	sub	x0, x29, #0x10
               	add	x0, x0, #0x4
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldrb	w0, [x0, #0x8]
               	cmp	x0, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x10
               	ldrb	w0, [x0, #0xb]
               	cmp	x0, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldrsw	x0, [x0, #0xc]
               	add	x1, x20, #0x6
               	sxtw	x1, w1
               	cmp	x0, x1
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x10
               	ldrsw	x0, [x0]
               	add	x1, x20, #0x4
               	sxtw	x1, w1
               	cmp	x0, x1
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x6                // =6
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
