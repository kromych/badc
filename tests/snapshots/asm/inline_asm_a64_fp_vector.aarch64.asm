
inline_asm_a64_fp_vector.aarch64:	file format elf64-littleaarch64

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
               	mov	x16, #0x41a80000        // =1101529088
               	dup	v0.4s, w16
               	fadd	v0.4s, v0.4s, v0.4s
               	fmov	w0, s0
               	stur	w0, [x29, #-0x8]
               	ldur	s0, [x29, #-0x8]
               	mov	x16, #0x42280000        // =1109917696
               	fmov	s1, w16
               	fcmp	s0, s1
               	b.ne	<addr>
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
