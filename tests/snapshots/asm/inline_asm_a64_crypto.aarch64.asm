
inline_asm_a64_crypto.aarch64:	file format elf64-littleaarch64

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
               	mov	x16, #0x2a              // =42
               	str	x16, [sp]
               	ldr	x1, [sp]
               	dup	v0.4s, w1
               	aesmc	v0.16b, v0.16b
               	aesimc	v0.16b, v0.16b
               	mov	w0, v0.s[0]
               	cmp	w0, #0x2a
               	b.ne	<addr>
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
