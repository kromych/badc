
inline_asm_a64_reduce.aarch64:	file format elf64-littleaarch64

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
               	sub	x16, x29, #0x8
               	str	x16, [sp]
               	mov	x16, #0xa               // =10
               	str	x16, [sp, #0x8]
               	mov	x16, #0xc               // =12
               	str	x16, [sp, #0x10]
               	mov	x16, #0xb               // =11
               	str	x16, [sp, #0x18]
               	mov	x16, #0x9               // =9
               	str	x16, [sp, #0x20]
               	ldr	x1, [sp, #0x8]
               	ldr	x2, [sp, #0x10]
               	ldr	x3, [sp, #0x18]
               	ldr	x4, [sp, #0x20]
               	mov	v0.s[0], w1
               	mov	v0.s[1], w2
               	mov	v0.s[2], w3
               	mov	v0.s[3], w4
               	addv	s0, v0.4s
               	mov	w0, v0.s[0]
               	ldr	x16, [sp]
               	str	w0, [x16]
               	ldursw	x0, [x29, #-0x8]
               	cmp	w0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x8
               	str	x16, [sp]
               	mov	x16, #0x2               // =2
               	str	x16, [sp, #0x8]
               	ldr	x1, [sp, #0x8]
               	dup	v0.16b, w1
               	saddlv	h0, v0.16b
               	umov	w0, v0.h[0]
               	ldr	x16, [sp]
               	str	w0, [x16]
               	ldursw	x0, [x29, #-0x8]
               	cmp	w0, #0x20
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
