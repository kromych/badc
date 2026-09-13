
inline_asm_a64_ld1_st1.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x50
               	sub	x16, x29, #0x28
               	str	x16, [sp]
               	mov	x16, #0x2a              // =42
               	str	x16, [sp, #0x8]
               	sub	x16, x29, #0x10
               	str	x16, [sp, #0x10]
               	ldr	x1, [sp, #0x8]
               	ldr	x2, [sp, #0x10]
               	dup	v0.4s, w1
               	st1	{ v0.4s }, [x2]
               	ld1	{ v1.4s }, [x2]
               	mov	w0, v1.s[3]
               	ldr	x16, [sp]
               	str	w0, [x16]
               	ldursw	x0, [x29, #-0x28]
               	cmp	w0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x28
               	str	x16, [sp]
               	mov	x16, #0x7               // =7
               	str	x16, [sp, #0x8]
               	mov	x16, #0x2a              // =42
               	str	x16, [sp, #0x10]
               	sub	x16, x29, #0x20
               	str	x16, [sp, #0x18]
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
               	ldursw	x0, [x29, #-0x28]
               	cmp	w0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
