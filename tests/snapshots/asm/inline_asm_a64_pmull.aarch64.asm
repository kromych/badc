
inline_asm_a64_pmull.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	mov	x0, #0x3                // =3
               	mov	x1, #0x3                // =3
               	sub	x2, x29, #0x18
               	sub	sp, sp, #0x50
               	str	x0, [sp, #0x18]
               	str	x1, [sp, #0x20]
               	str	x2, [sp, #0x28]
               	str	d0, [sp, #0x30]
               	str	d1, [sp, #0x38]
               	str	d2, [sp, #0x40]
               	str	x2, [sp]
               	str	x0, [sp, #0x8]
               	str	x1, [sp, #0x10]
               	ldr	x1, [sp, #0x8]
               	ldr	x2, [sp, #0x10]
               	dup	v1.8b, w1
               	dup	v2.8b, w2
               	pmull	v0.8h, v1.8b, v2.8b
               	umov	w0, v0.h[0]
               	ldr	x16, [sp]
               	str	w0, [x16]
               	ldr	x0, [sp, #0x18]
               	ldr	x1, [sp, #0x20]
               	ldr	x2, [sp, #0x28]
               	ldr	d0, [sp, #0x30]
               	ldr	d1, [sp, #0x38]
               	ldr	d2, [sp, #0x40]
               	add	sp, sp, #0x50
               	ldursw	x0, [x29, #-0x18]
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	mov	x1, #0x6                // =6
               	sub	x2, x29, #0x20
               	sub	sp, sp, #0x50
               	str	x0, [sp, #0x18]
               	str	x1, [sp, #0x20]
               	str	x2, [sp, #0x28]
               	str	d0, [sp, #0x30]
               	str	d1, [sp, #0x38]
               	str	d2, [sp, #0x40]
               	str	x2, [sp]
               	str	x0, [sp, #0x8]
               	str	x1, [sp, #0x10]
               	ldr	x1, [sp, #0x8]
               	ldr	x2, [sp, #0x10]
               	dup	v1.8b, w1
               	dup	v2.8b, w2
               	pmull	v0.8h, v1.8b, v2.8b
               	umov	w0, v0.h[0]
               	ldr	x16, [sp]
               	str	w0, [x16]
               	ldr	x0, [sp, #0x18]
               	ldr	x1, [sp, #0x20]
               	ldr	x2, [sp, #0x28]
               	ldr	d0, [sp, #0x30]
               	ldr	d1, [sp, #0x38]
               	ldr	d2, [sp, #0x40]
               	add	sp, sp, #0x50
               	ldursw	x0, [x29, #-0x20]
               	cmp	x0, #0x12
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	sub	x1, x29, #0x28
               	sub	sp, sp, #0x50
               	str	x0, [sp, #0x18]
               	str	x1, [sp, #0x20]
               	str	x2, [sp, #0x28]
               	str	d0, [sp, #0x30]
               	str	d1, [sp, #0x38]
               	str	d2, [sp, #0x40]
               	str	x1, [sp]
               	str	x0, [sp, #0x8]
               	str	x0, [sp, #0x10]
               	ldr	x1, [sp, #0x8]
               	ldr	x2, [sp, #0x10]
               	fmov	d1, x1
               	fmov	d2, x2
               	pmull	v0.1q, v1.1d, v2.1d
               	mov	x0, v0.d[0]
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x18]
               	ldr	x1, [sp, #0x20]
               	ldr	x2, [sp, #0x28]
               	ldr	d0, [sp, #0x30]
               	ldr	d1, [sp, #0x38]
               	ldr	d2, [sp, #0x40]
               	add	sp, sp, #0x50
               	ldur	x0, [x29, #-0x28]
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
