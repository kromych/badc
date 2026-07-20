
inline_asm_a64_vector_arith2.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x10
               	sxtw	x0, w0
               	sxtw	x1, w1
               	sxtw	x2, w2
               	sub	x3, x29, #0x8
               	sub	sp, sp, #0x60
               	str	x0, [sp, #0x20]
               	str	x1, [sp, #0x28]
               	str	x2, [sp, #0x30]
               	str	x3, [sp, #0x38]
               	str	d0, [sp, #0x40]
               	str	d1, [sp, #0x48]
               	str	d2, [sp, #0x50]
               	str	x3, [sp]
               	str	x0, [sp, #0x8]
               	str	x1, [sp, #0x10]
               	str	x2, [sp, #0x18]
               	ldr	x1, [sp, #0x8]
               	ldr	x2, [sp, #0x10]
               	ldr	x3, [sp, #0x18]
               	dup	v0.4s, w1
               	dup	v1.4s, w2
               	dup	v2.4s, w3
               	mla	v0.4s, v1.4s, v2.4s
               	mov	w0, v0.s[0]
               	ldr	x16, [sp]
               	str	w0, [x16]
               	ldr	x0, [sp, #0x20]
               	ldr	x1, [sp, #0x28]
               	ldr	x2, [sp, #0x30]
               	ldr	x3, [sp, #0x38]
               	ldr	d0, [sp, #0x40]
               	ldr	d1, [sp, #0x48]
               	ldr	d2, [sp, #0x50]
               	add	sp, sp, #0x60
               	ldursw	x0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<uabd_diff>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x2, x29, #0x8
               	mov	w0, w0
               	mov	w1, w1
               	sub	sp, sp, #0x40
               	str	x0, [sp, #0x18]
               	str	x1, [sp, #0x20]
               	str	x2, [sp, #0x28]
               	str	d0, [sp, #0x30]
               	str	d1, [sp, #0x38]
               	str	x2, [sp]
               	str	x0, [sp, #0x8]
               	str	x1, [sp, #0x10]
               	ldr	x1, [sp, #0x8]
               	ldr	x2, [sp, #0x10]
               	dup	v0.4s, w1
               	dup	v1.4s, w2
               	uabd	v0.4s, v0.4s, v1.4s
               	mov	w0, v0.s[0]
               	ldr	x16, [sp]
               	str	w0, [x16]
               	ldr	x0, [sp, #0x18]
               	ldr	x1, [sp, #0x20]
               	ldr	x2, [sp, #0x28]
               	ldr	d0, [sp, #0x30]
               	ldr	d1, [sp, #0x38]
               	add	sp, sp, #0x40
               	ldursw	x0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<sqadd_saturates>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sxtw	x0, w0
               	sub	x1, x29, #0x8
               	sub	sp, sp, #0x30
               	str	x0, [sp, #0x10]
               	str	x1, [sp, #0x18]
               	str	d0, [sp, #0x20]
               	str	x1, [sp]
               	str	x0, [sp, #0x8]
               	ldr	x1, [sp, #0x8]
               	dup	v0.4s, w1
               	sqadd	v0.4s, v0.4s, v0.4s
               	mov	w0, v0.s[0]
               	ldr	x16, [sp]
               	str	w0, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	x1, [sp, #0x18]
               	ldr	d0, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldursw	x0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x2                // =2
               	mov	x1, #0x8                // =8
               	mov	x2, #0x5                // =5
               	bl	<addr>
               	cmp	x0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x64               // =100
               	mov	x1, #0x3a               // =58
               	bl	<addr>
               	cmp	x0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0x7fff, lsl #16
               	bl	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x7fff, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	ldp	x29, x30, [sp], #0x10
               	ret
