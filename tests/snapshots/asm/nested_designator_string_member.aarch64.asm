
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
               	sub	sp, sp, #0x10
               	mov	x5, x0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	add	x0, x2, #0x4
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w3, [x0]
               	cbz	x3, <addr>
               	ldrb	w3, [x0]
               	ldrb	w4, [x1]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	ldrb	w3, [x0]
               	cbnz	x3, <addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w0, [x2, #0x7]
               	cbnz	x0, <addr>
               	ldrb	w0, [x2, #0xb]
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2, #0xc]
               	cmp	w0, #0x7
               	b.ne	<addr>
               	ldrsw	x0, [x2]
               	cmp	w0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	stp	xzr, xzr, [x0]
               	mov	x1, #0x77               // =119
               	strb	w1, [x0, #0x4]
               	mov	x1, #0x78               // =120
               	strb	w1, [x0, #0x5]
               	mov	x1, #0x79               // =121
               	strb	w1, [x0, #0x6]
               	mov	x1, #0x7a               // =122
               	strb	w1, [x0, #0x7]
               	mov	x1, #0x0                // =0
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
               	ldrb	w2, [x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x0]
               	ldrb	w3, [x1]
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	ldrb	w2, [x0]
               	cbnz	x2, <addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldrsw	x2, [x0, #0xc]
               	add	x1, x5, #0x6
               	cmp	w2, w1
               	b.ne	<addr>
               	ldrsw	x1, [x0]
               	add	x0, x5, #0x4
               	cmp	w1, w0
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
