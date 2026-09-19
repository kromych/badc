
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
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, #0x4
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrb	w3, [x1]
               	cbz	x3, <addr>
               	ldrb	w3, [x1]
               	ldrb	w4, [x2]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	add	x2, x2, #0x1
               	ldrb	w3, [x1]
               	cbnz	x3, <addr>
               	ldrb	w1, [x1]
               	ldrb	w2, [x2]
               	cmp	w1, w2
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w2, [x1, #0x7]
               	cbnz	w2, <addr>
               	ldrb	w2, [x1, #0xb]
               	cbz	w2, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x2, [x1, #0xc]
               	cmp	w2, #0x7
               	b.ne	<addr>
               	ldrsw	x1, [x1]
               	cmp	w1, #0x5
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x10
               	stp	xzr, xzr, [x1]
               	mov	x2, #0x77               // =119
               	strb	w2, [x1, #0x4]
               	mov	x2, #0x78               // =120
               	strb	w2, [x1, #0x5]
               	mov	x2, #0x79               // =121
               	strb	w2, [x1, #0x6]
               	mov	x2, #0x7a               // =122
               	strb	w2, [x1, #0x7]
               	mov	x2, #0x0                // =0
               	strb	w2, [x1, #0x8]
               	strb	w2, [x1, #0x9]
               	strb	w2, [x1, #0xa]
               	strb	w2, [x1, #0xb]
               	add	x2, x0, #0x6
               	str	w2, [x1, #0xc]
               	add	x2, x0, #0x4
               	str	w2, [x1]
               	add	x1, x1, #0x4
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrb	w3, [x1]
               	cbz	x3, <addr>
               	ldrb	w3, [x1]
               	ldrb	w4, [x2]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	add	x2, x2, #0x1
               	ldrb	w3, [x1]
               	cbnz	x3, <addr>
               	ldrb	w1, [x1]
               	ldrb	w2, [x2]
               	cmp	w1, w2
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x10
               	ldrsw	x2, [x1, #0xc]
               	add	x3, x0, #0x6
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrsw	x1, [x1]
               	add	x0, x0, #0x4
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
