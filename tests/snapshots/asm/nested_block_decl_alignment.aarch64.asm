
nested_block_decl_alignment.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
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
               	tst	x1, #0x3f
               	mov	x2, #0x1                // =1
               	csel	x2, x0, x2, ne
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x3, #0x5                // =5
               	strb	w3, [x1]
               	tst	x1, #0x7f
               	mov	x3, #0x1                // =1
               	csel	x1, x0, x3, ne
               	add	x1, x2, x1
               	mov	x2, sp
               	mov	x3, #0x7                // =7
               	strb	w3, [sp]
               	tst	x2, #0x3f
               	mov	x3, #0x1                // =1
               	csel	x2, x0, x3, ne
               	add	x1, x1, x2
               	mov	x2, sp
               	mov	x3, #0x9                // =9
               	str	w3, [sp]
               	tst	x2, #0x3f
               	mov	x3, #0x1                // =1
               	csel	x0, x0, x3, ne
               	add	x0, x1, x0
               	mov	x1, #0x2a               // =42
               	cmp	w0, #0x4
               	csel	x0, x1, x0, eq
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
