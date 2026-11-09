
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

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	mov	x16, sp
               	and	sp, x16, #0xffffffffffffffc0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x2, #0x3                // =3
               	str	w2, [x1]
               	and	x2, x1, #0x3f
               	cbnz	w2, <addr>
               	ldr	w1, [x1]
               	cmp	w1, #0x3
               	cset	x2, eq
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x3, #0x5                // =5
               	strb	w3, [x1]
               	and	x3, x1, #0x7f
               	cbnz	w3, <addr>
               	ldrb	w1, [x1]
               	cmp	w1, #0x5
               	cset	x1, eq
               	add	x2, x2, x1
               	mov	x1, sp
               	mov	x3, #0x7                // =7
               	strb	w3, [sp]
               	and	x1, x1, #0x3f
               	cbnz	w1, <addr>
               	ldrb	w1, [sp]
               	cmp	w1, #0x7
               	cset	x1, eq
               	add	x1, x2, x1
               	mov	x2, sp
               	mov	x3, #0x9                // =9
               	str	w3, [sp]
               	and	x2, x2, #0x3f
               	cbnz	w2, <addr>
               	ldr	w0, [sp]
               	cmp	w0, #0x9
               	cset	x0, eq
               	add	x0, x1, x0
               	cmp	w0, #0x4
               	b.ne	<addr>
               	mov	x0, #0x2a               // =42
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
