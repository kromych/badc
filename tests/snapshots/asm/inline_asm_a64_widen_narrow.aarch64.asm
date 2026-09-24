
inline_asm_a64_widen_narrow.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x10
               	mov	x16, #0x14              // =20
               	str	x16, [sp]
               	mov	x16, #0x16              // =22
               	str	x16, [sp, #0x8]
               	ldr	x1, [sp]
               	ldr	x2, [sp, #0x8]
               	dup	v1.4h, w1
               	dup	v2.4h, w2
               	uaddl	v0.4s, v1.4h, v2.4h
               	mov	w0, v0.s[0]
               	cmp	w0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x2a              // =42
               	str	x16, [sp]
               	ldr	x1, [sp]
               	dup	v1.8h, w1
               	xtn	v0.8b, v1.8h
               	umov	w0, v0.b[0]
               	cmp	w0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
