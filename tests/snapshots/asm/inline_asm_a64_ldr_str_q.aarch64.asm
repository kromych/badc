
inline_asm_a64_ldr_str_q.aarch64:	file format elf64-littleaarch64

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
               	mov	x16, #0x2a              // =42
               	str	x16, [sp]
               	sub	x16, x29, #0x10
               	str	x16, [sp, #0x8]
               	ldr	x1, [sp]
               	ldr	x2, [sp, #0x8]
               	dup	v0.4s, w1
               	str	q0, [x2]
               	ldr	q1, [x2]
               	mov	w0, v1.s[2]
               	cmp	w0, #0x2a
               	b.ne	<addr>
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
