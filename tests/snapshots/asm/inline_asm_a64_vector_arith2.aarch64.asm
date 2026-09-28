
inline_asm_a64_vector_arith2.aarch64:	file format elf64-littleaarch64

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
               	mov	x16, #0x2               // =2
               	str	x16, [sp]
               	mov	x16, #0x8               // =8
               	str	x16, [sp, #0x8]
               	mov	x16, #0x5               // =5
               	str	x16, [sp, #0x10]
               	ldr	x1, [sp]
               	ldr	x2, [sp, #0x8]
               	ldr	x3, [sp, #0x10]
               	dup	v0.4s, w1
               	dup	v1.4s, w2
               	dup	v2.4s, w3
               	mla	v0.4s, v1.4s, v2.4s
               	mov	w0, v0.s[0]
               	cmp	w0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x64              // =100
               	mov	x17, #0x3a              // =58
               	dup	v0.4s, w16
               	dup	v1.4s, w17
               	uabd	v0.4s, v0.4s, v1.4s
               	mov	w0, v0.s[0]
               	cmp	w0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x7fffffff        // =2147483647
               	dup	v0.4s, w16
               	sqadd	v0.4s, v0.4s, v0.4s
               	mov	w0, v0.s[0]
               	mov	x17, #0x7fffffff        // =2147483647
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
