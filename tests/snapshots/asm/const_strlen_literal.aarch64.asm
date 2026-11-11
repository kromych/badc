
const_strlen_literal.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x50
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x0, x29, #0x48
               	bl	<addr>
               	sub	x0, x29, #0x48
               	bl	<addr>
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	blr	x1
               	cmp	x0, #0xb
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x4, sp
               	mov	x0, #0x8                // =8
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x0, sp
               	sub	x0, x0, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x0
               	mov	x2, #0x78               // =120
               	strb	w2, [x0]
               	strb	wzr, [x0, #0x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w2, [x0]
               	cbz	x2, <addr>
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
               	mov	x0, #0x15               // =21
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	sp, x4
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w1, [x0]
               	cmp	w1, #0x1
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x1c]
               	cmp	w1, #0x5
               	b.eq	<addr>
               	mov	x0, #0x1f               // =31
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x0, #0x4
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w2, [x0]
               	cbz	x2, <addr>
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
               	mov	x0, #0x20               // =32
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w1, [x0, #0x20]
               	cmp	w1, #0x2
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x3c]
               	cmp	w1, #0x4
               	b.eq	<addr>
               	mov	x0, #0x21               // =33
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x0, #0x24
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w2, [x0]
               	cbz	x2, <addr>
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
               	mov	x0, #0x22               // =34
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	cmp	x1, #0x1
               	b.ne	<addr>
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x23               // =35
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
