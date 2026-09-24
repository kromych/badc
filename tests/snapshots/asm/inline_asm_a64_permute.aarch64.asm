
inline_asm_a64_permute.aarch64:	file format elf64-littleaarch64

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
               	mov	x16, #0x7               // =7
               	str	x16, [sp]
               	mov	x16, #0x2a              // =42
               	str	x16, [sp, #0x8]
               	ldr	x1, [sp]
               	ldr	x2, [sp, #0x8]
               	dup	v0.4s, w1
               	dup	v1.4s, w2
               	zip1	v2.4s, v0.4s, v1.4s
               	mov	w0, v2.s[1]
               	cmp	w0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x7               // =7
               	str	x16, [sp]
               	mov	x16, #0x2a              // =42
               	str	x16, [sp, #0x8]
               	ldr	x1, [sp]
               	ldr	x2, [sp, #0x8]
               	dup	v0.4s, w1
               	dup	v1.4s, w2
               	ext	v2.16b, v0.16b, v1.16b, #0x4
               	mov	w0, v2.s[3]
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
