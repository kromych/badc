
nested_designator_string_member.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	ldrb	w2, [x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x0]
               	ldrb	w3, [x1]
               	cmp	x2, x3
               	cset	x2, eq
               	cbz	x2, <addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	b	<addr>
               	b	<addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	x0, x1
               	cset	x0, eq
               	sxtw	x0, w0
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x60]!
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	mov	x21, x0
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	add	x0, x20, #0x4
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	ldrb	w0, [x20, #0x7]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldrb	w0, [x20, #0xb]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	ldrsw	x0, [x20, #0xc]
               	cmp	x0, #0x7
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldrsw	x0, [x20]
               	cmp	x0, #0x5
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
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
               	mov	x1, #0x77               // =119
               	sub	x0, x29, #0x10
               	strb	w1, [x0, #0x4]
               	mov	x1, #0x78               // =120
               	sub	x0, x29, #0x10
               	strb	w1, [x0, #0x5]
               	mov	x1, #0x79               // =121
               	sub	x0, x29, #0x10
               	strb	w1, [x0, #0x6]
               	mov	x1, #0x7a               // =122
               	sub	x0, x29, #0x10
               	strb	w1, [x0, #0x7]
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x10
               	strb	w0, [x1, #0x8]
               	sub	x1, x29, #0x10
               	strb	w0, [x1, #0x9]
               	sub	x1, x29, #0x10
               	strb	w0, [x1, #0xa]
               	sub	x1, x29, #0x10
               	strb	w0, [x1, #0xb]
               	add	x0, x21, #0x6
               	sub	x1, x29, #0x10
               	str	w0, [x1, #0xc]
               	add	x0, x21, #0x4
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
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	sub	x0, x29, #0x10
               	ldrb	w0, [x0, #0x8]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x10
               	ldrb	w0, [x0, #0xb]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	sub	x0, x29, #0x10
               	ldrsw	x1, [x0, #0xc]
               	add	x0, x21, #0x6
               	sxtw	x0, w0
               	cmp	x1, x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x10
               	ldrsw	x1, [x0]
               	add	x0, x21, #0x4
               	sxtw	x0, w0
               	cmp	x1, x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
