
nested_block_decl_alignment.aarch64:	file format elf64-littleaarch64

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

<nested_auto>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x40
               	mov	x16, sp
               	and	sp, x16, #0xffffffffffffffc0
               	mov	x1, sp
               	mov	x0, #0x0                // =0
               	mov	x2, #0x7                // =7
               	strb	w2, [x1]
               	mov	x1, sp
               	mov	x17, #0x3f              // =63
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	mov	x0, sp
               	ldrb	w0, [x0]
               	mov	x17, #0x7               // =7
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	sub	sp, x29, #0x10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>

<nested_auto_typed>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	sub	sp, sp, #0x40
               	mov	x16, sp
               	and	sp, x16, #0xffffffffffffffc0
               	mov	x1, sp
               	mov	x0, #0x0                // =0
               	mov	x2, #0x9                // =9
               	str	w2, [x1]
               	mov	x1, sp
               	mov	x17, #0x3f              // =63
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	mov	x0, sp
               	ldr	w0, [x0]
               	mov	x17, #0x9               // =9
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	sub	sp, x29, #0x50
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>

<main>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x2, #0x3                // =3
               	str	w2, [x1]
               	mov	x17, #0x3f              // =63
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w0, [x0]
               	mov	x17, #0x3               // =3
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	sxtw	x1, w0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x2, #0x5                // =5
               	strb	w2, [x0]
               	mov	x17, #0x7f              // =127
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x2, eq
               	mov	x0, #0x0                // =0
               	cbz	x2, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0]
               	mov	x17, #0x5               // =5
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	add	x20, x1, x0
               	bl	<addr>
               	add	x20, x20, x0
               	bl	<addr>
               	add	x0, x20, x0
               	sxtw	x0, w0
               	cmp	x0, #0x4
               	b.ne	<addr>
               	mov	x0, #0x2a               // =42
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
