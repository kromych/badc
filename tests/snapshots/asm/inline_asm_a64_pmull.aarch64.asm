
inline_asm_a64_pmull.aarch64:	file format elf64-littleaarch64

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
               	mov	x16, #0x3               // =3
               	str	x16, [sp]
               	mov	x16, #0x3               // =3
               	str	x16, [sp, #0x8]
               	ldr	x1, [sp]
               	ldr	x2, [sp, #0x8]
               	dup	v1.8b, w1
               	dup	v2.8b, w2
               	pmull	v0.8h, v1.8b, v2.8b
               	umov	w0, v0.h[0]
               	cmp	w0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x7               // =7
               	str	x16, [sp]
               	mov	x16, #0x6               // =6
               	str	x16, [sp, #0x8]
               	ldr	x1, [sp]
               	ldr	x2, [sp, #0x8]
               	dup	v1.8b, w1
               	dup	v2.8b, w2
               	pmull	v0.8h, v1.8b, v2.8b
               	umov	w0, v0.h[0]
               	cmp	w0, #0x12
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x3               // =3
               	str	x16, [sp]
               	mov	x16, #0x3               // =3
               	str	x16, [sp, #0x8]
               	ldr	x1, [sp]
               	ldr	x2, [sp, #0x8]
               	fmov	d1, x1
               	fmov	d2, x2
               	pmull	v0.1q, v1.1d, v2.1d
               	mov	x0, v0.d[0]
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
