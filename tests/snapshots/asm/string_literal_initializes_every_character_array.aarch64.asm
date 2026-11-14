
string_literal_initializes_every_character_array.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x60
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldrb	w16, [x1, #0x10]
               	strb	w16, [x0, #0x10]
               	sub	x1, x29, #0x28
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldrb	w16, [x2, #0x10]
               	strb	w16, [x1, #0x10]
               	sub	x1, x29, #0x60
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	w16, [x2]
               	str	w16, [x1]
               	sub	x1, x29, #0x58
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrb	w16, [x2]
               	strb	w16, [x1]
               	sub	x1, x29, #0x50
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrh	w16, [x2]
               	strh	w16, [x1]
               	sub	x1, x29, #0x48
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x16, [x2]
               	str	x16, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x0, x29, #0x28
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	cbz	x0, <addr>
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x1, #0x61               // =97
               	movk	x1, #0x62, lsl #32
               	stur	x1, [x29, #-0x40]
               	mov	x1, #0x7100000000       // =485331304448
               	stur	x1, [x29, #-0x38]
               	sub	x1, x29, #0x28
               	str	xzr, [x1]
               	str	wzr, [x1, #0x8]
               	mov	x1, #0x6261             // =25185
               	movk	x1, #0x7100, lsl #16
               	stur	w1, [x29, #-0x28]
               	ldur	w1, [x29, #-0x3c]
               	cmp	w1, #0x62
               	b.ne	<addr>
               	ldursw	x1, [x29, #-0x34]
               	cmp	w1, #0x71
               	b.ne	<addr>
               	ldurb	w1, [x29, #-0x27]
               	cmp	w1, #0x62
               	b.ne	<addr>
               	ldurb	w1, [x29, #-0x25]
               	cmp	w1, #0x71
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w2, [x1, #0x3]
               	cmp	w2, #0x5
               	b.ne	<addr>
               	ldrsw	x1, [x1, #0x8]
               	cbz	w1, <addr>
               	mov	x0, #0x7                // =7
               	b	<addr>
               	mov	x0, #0x6                // =6
               	b	<addr>
               	ldurb	w0, [x29, #-0x5e]
               	cmp	w0, #0x7a
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x58]
               	cmp	w0, #0x62
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x4f]
               	cmp	w0, #0x63
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x43]
               	cmp	w0, #0x64
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
