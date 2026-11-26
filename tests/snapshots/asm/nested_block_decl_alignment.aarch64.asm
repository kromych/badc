
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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x3                // =3
               	str	w1, [x0]
               	tst	x0, #0x3f
               	mov	x17, #0x1               // =1
               	csel	x1, xzr, x17, ne
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x2, #0x5                // =5
               	strb	w2, [x0]
               	tst	x0, #0x7f
               	mov	x17, #0x1               // =1
               	csel	x0, xzr, x17, ne
               	add	x0, x1, x0
               	mov	x1, sp
               	mov	x2, #0x7                // =7
               	strb	w2, [sp]
               	tst	x1, #0x3f
               	mov	x17, #0x1               // =1
               	csel	x1, xzr, x17, ne
               	add	x0, x0, x1
               	mov	x1, sp
               	mov	x2, #0x9                // =9
               	str	w2, [sp]
               	tst	x1, #0x3f
               	mov	x17, #0x1               // =1
               	csel	x1, xzr, x17, ne
               	add	x0, x0, x1
               	cmp	w0, #0x4
               	mov	x16, #0x2a              // =42
               	csel	x0, x16, x0, eq
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
