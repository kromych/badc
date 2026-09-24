
inline_asm_a64_ld1r.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x30
               	mov	x0, #0x2a               // =42
               	stur	w0, [x29, #-0x10]
               	sub	x16, x29, #0x10
               	ld1r	{ v0.4s }, [x16]
               	mov	w0, v0.s[3]
               	cmp	w0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x13               // =19
               	mov	x2, #0x17               // =23
               	sub	x0, x29, #0x18
               	str	xzr, [x0]
               	str	w1, [x0]
               	str	w2, [x0, #0x4]
               	sub	x16, x29, #0x8
               	str	x16, [sp]
               	sub	x16, x29, #0x18
               	str	x16, [sp, #0x8]
               	ldr	x2, [sp, #0x8]
               	ld2r	{ v0.4s, v1.4s }, [x2]
               	mov	w0, v0.s[2]
               	mov	w1, v1.s[1]
               	ldr	x16, [sp]
               	str	w1, [x16]
               	ldursw	x1, [x29, #-0x8]
               	add	x0, x0, x1
               	cmp	w0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
