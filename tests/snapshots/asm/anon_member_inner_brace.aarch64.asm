
anon_member_inner_brace.aarch64:	file format elf64-littleaarch64

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
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w2, [x1]
               	ldrb	w3, [x0]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrb	w2, [x1, #0x4]
               	ldrb	w3, [x0, #0x4]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrb	w2, [x1, #0x8]
               	ldrb	w3, [x0, #0x8]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrsw	x2, [x1, #0xc]
               	ldrsw	x3, [x0, #0xc]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrb	w1, [x1, #0x10]
               	ldrb	w2, [x0, #0x10]
               	cmp	w1, w2
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w2, [x1]
               	ldrb	w3, [x0]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrb	w2, [x1, #0x4]
               	ldrb	w3, [x0, #0x4]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrb	w2, [x1, #0x8]
               	ldrb	w3, [x0, #0x8]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrsw	x2, [x1, #0xc]
               	ldrsw	x3, [x0, #0xc]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrb	w1, [x1, #0x10]
               	ldrb	w0, [x0, #0x10]
               	cmp	w1, w0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x1]
               	ldrsw	x3, [x0]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrsw	x2, [x1, #0x4]
               	ldrsw	x3, [x0, #0x4]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrsw	x2, [x1, #0x8]
               	ldrsw	x3, [x0, #0x8]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrsw	x2, [x1, #0xc]
               	ldrsw	x3, [x0, #0xc]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrsw	x2, [x1, #0x10]
               	ldrsw	x3, [x0, #0x10]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrsw	x1, [x1, #0x14]
               	ldrsw	x2, [x0, #0x14]
               	cmp	w1, w2
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	ldrsw	x3, [x0]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrsw	x2, [x1, #0x4]
               	ldrsw	x3, [x0, #0x4]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrsw	x2, [x1, #0x8]
               	ldrsw	x3, [x0, #0x8]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrsw	x2, [x1, #0xc]
               	ldrsw	x3, [x0, #0xc]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrsw	x2, [x1, #0x10]
               	ldrsw	x3, [x0, #0x10]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrsw	x1, [x1, #0x14]
               	ldrsw	x0, [x0, #0x14]
               	cmp	w1, w0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	cmp	w1, #0x1
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0x4]
               	cmp	w1, #0x2
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0xc]
               	cmp	w1, #0x3
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	ldrb	w1, [x0, #0x8]
               	eor	x1, x1, #0x7
               	cbnz	w1, <addr>
               	ldrb	w1, [x0, #0x9]
               	eor	x1, x1, #0x8
               	cbnz	w1, <addr>
               	ldrb	w0, [x0, #0xa]
               	cbz	w0, <addr>
               	mov	x0, #0x6                // =6
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w1, [x0]
               	cmp	w1, #0x1
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x4]
               	cmp	w1, #0x2
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x8]
               	cmp	w1, #0x3
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0xc]
               	cmp	w1, #0x4
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x10]
               	cmp	w1, #0x5
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	ldrb	w1, [x0]
               	cmp	w1, #0x1
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x4]
               	cmp	w1, #0x2
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x8]
               	cmp	w1, #0x3
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0xc]
               	cmp	w1, #0x4
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x10]
               	cmp	w1, #0x5
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w2, [x1]
               	ldrb	w3, [x0]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrb	w2, [x1, #0x4]
               	ldrb	w3, [x0, #0x4]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrb	w2, [x1, #0x8]
               	ldrb	w3, [x0, #0x8]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrsw	x2, [x1, #0xc]
               	ldrsw	x3, [x0, #0xc]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrb	w1, [x1, #0x10]
               	ldrb	w0, [x0, #0x10]
               	cmp	w1, w0
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ret
               	mov	x0, #0x0                // =0
               	ret
