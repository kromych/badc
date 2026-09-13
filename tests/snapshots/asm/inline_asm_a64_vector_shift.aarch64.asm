
inline_asm_a64_vector_shift.aarch64:	file format elf64-littleaarch64

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
               	sub	x16, x29, #0x8
               	str	x16, [sp]
               	mov	x16, #0x5               // =5
               	str	x16, [sp, #0x8]
               	ldr	x1, [sp, #0x8]
               	dup	v0.4s, w1
               	shl	v0.4s, v0.4s, #0x3
               	fmov	w0, s0
               	ldr	x16, [sp]
               	str	w0, [x16]
               	ldursw	x0, [x29, #-0x8]
               	cmp	w0, #0x28
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x8
               	str	x16, [sp]
               	mov	x16, #-0x54             // =-84
               	str	x16, [sp, #0x8]
               	ldr	x1, [sp, #0x8]
               	dup	v0.4s, w1
               	sshr	v0.4s, v0.4s, #0x1
               	fmov	w0, s0
               	ldr	x16, [sp]
               	str	w0, [x16]
               	ldursw	x0, [x29, #-0x8]
               	mov	x17, #-0x2a             // =-42
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x8
               	str	x16, [sp]
               	mov	x16, #0xa8              // =168
               	str	x16, [sp, #0x8]
               	ldr	x1, [sp, #0x8]
               	dup	v0.4s, w1
               	ushr	v0.4s, v0.4s, #0x2
               	fmov	w0, s0
               	ldr	x16, [sp]
               	str	w0, [x16]
               	ldursw	x0, [x29, #-0x8]
               	cmp	w0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
