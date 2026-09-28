
addr_compare_disjoint_blocks.aarch64:	file format elf64-littleaarch64

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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	stur	w0, [x29, #-0x18]
               	sub	x2, x29, #0x18
               	sub	x3, x29, #0x8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	cmp	x3, x2
               	cset	x0, eq
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	strb	w0, [x1]
               	sxtb	x0, w0
               	cbz	w0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	cmp	x2, x3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	x2, x3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	cmp	w1, #0x4
               	b.lt	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	stur	w0, [x29, #-0x18]
               	sub	x1, x29, #0x10
               	add	x2, x1, #0x8
               	sub	x1, x29, #0x18
               	cmp	x2, x1
               	cset	x2, ne
               	cmp	w2, #0x1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x0                // =0
               	sturb	w2, [x29, #-0x18]
               	sub	x3, x29, #0x8
               	cmp	x3, x1
               	cset	x1, ne
               	orr	x1, x1, x1
               	cmp	w1, #0x1
               	b.eq	<addr>
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
