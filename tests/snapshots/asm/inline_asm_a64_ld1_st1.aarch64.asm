
inline_asm_a64_ld1_st1.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x20
               	sxtw	x0, w0
               	sub	x1, x29, #0x8
               	sub	x2, x29, #0x18
               	sub	sp, sp, #0x30
               	str	x0, [sp, #0x18]
               	str	x1, [sp, #0x20]
               	str	x2, [sp, #0x28]
               	str	x1, [sp]
               	str	x0, [sp, #0x8]
               	str	x2, [sp, #0x10]
               	ldr	x1, [sp, #0x8]
               	ldr	x2, [sp, #0x10]
               	dup	v0.4s, w1
               	st1	{ v0.4s }, [x2]
               	ld1	{ v1.4s }, [x2]
               	mov	w0, v1.s[3]
               	ldr	x16, [sp]
               	str	w0, [x16]
               	ldr	x0, [sp, #0x18]
               	ldr	x1, [sp, #0x20]
               	ldr	x2, [sp, #0x28]
               	add	sp, sp, #0x30
               	ldursw	x0, [x29, #-0x8]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<st1_ld1_multi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sxtw	x0, w0
               	sxtw	x1, w1
               	sub	x2, x29, #0x8
               	sub	x3, x29, #0x28
               	sub	sp, sp, #0x40
               	str	x0, [sp, #0x20]
               	str	x1, [sp, #0x28]
               	str	x2, [sp, #0x30]
               	str	x3, [sp, #0x38]
               	str	x2, [sp]
               	str	x0, [sp, #0x8]
               	str	x1, [sp, #0x10]
               	str	x3, [sp, #0x18]
               	ldr	x1, [sp, #0x8]
               	ldr	x2, [sp, #0x10]
               	ldr	x3, [sp, #0x18]
               	dup	v0.4s, w1
               	dup	v1.4s, w2
               	st1	{ v0.4s, v1.4s }, [x3]
               	ld1	{ v2.4s, v3.4s }, [x3]
               	mov	w0, v3.s[0]
               	ldr	x16, [sp]
               	str	w0, [x16]
               	ldr	x0, [sp, #0x20]
               	ldr	x1, [sp, #0x28]
               	ldr	x2, [sp, #0x30]
               	ldr	x3, [sp, #0x38]
               	add	sp, sp, #0x40
               	ldursw	x0, [x29, #-0x8]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x2a               // =42
               	bl	<addr>
               	cmp	x0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	mov	x1, #0x2a               // =42
               	bl	<addr>
               	cmp	x0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	ldp	x29, x30, [sp], #0x10
               	ret
