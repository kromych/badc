
nested_designator_string_member.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x20
               	mov	x5, x0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	add	x0, x3, #0x4
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	ldrb	w2, [x0]
               	ldrb	w4, [x1]
               	cmp	w2, w4
               	cset	x2, eq
               	cbz	x2, <addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	ldrb	w2, [x0]
               	cbnz	x2, <addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	w0, w1
               	cset	x0, eq
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w0, [x3, #0x7]
               	cbnz	x0, <addr>
               	ldrb	w0, [x3, #0xb]
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x3, #0xc]
               	cmp	w0, #0x7
               	b.ne	<addr>
               	ldrsw	x0, [x3]
               	cmp	w0, #0x5
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	mov	x2, #0x77               // =119
               	strb	w2, [x0, #0x4]
               	mov	x2, #0x78               // =120
               	strb	w2, [x0, #0x5]
               	mov	x2, #0x79               // =121
               	strb	w2, [x0, #0x6]
               	mov	x2, #0x7a               // =122
               	strb	w2, [x0, #0x7]
               	strb	w1, [x0, #0x8]
               	strb	w1, [x0, #0x9]
               	strb	w1, [x0, #0xa]
               	strb	w1, [x0, #0xb]
               	add	x1, x5, #0x6
               	str	w1, [x0, #0xc]
               	add	x1, x5, #0x4
               	str	w1, [x0]
               	add	x0, x0, #0x4
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	ldrb	w2, [x0]
               	ldrb	w3, [x1]
               	cmp	w2, w3
               	cset	x2, eq
               	cbz	x2, <addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	ldrb	w2, [x0]
               	cbnz	x2, <addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	w0, w1
               	cset	x0, eq
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x0                // =0
               	mov	x0, x2
               	sub	x0, x29, #0x10
               	ldrsw	x3, [x0, #0xc]
               	add	x1, x5, #0x6
               	cmp	w3, w1
               	b.ne	<addr>
               	ldrsw	x1, [x0]
               	add	x0, x5, #0x4
               	cmp	w1, w0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
