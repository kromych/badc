
inline_asm_a64_neon.aarch64:	file format elf64-littleaarch64

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
               	mov	x16, #0x15              // =21
               	dup	v0.4s, w16
               	add	v0.4s, v0.4s, v0.4s
               	fmov	w0, s0
               	cmp	w0, #0x2a
               	b.ne	<addr>
               	mov	x16, #0x2a              // =42
               	mov	x17, #0xa               // =10
               	dup	v0.4s, w16
               	dup	v1.4s, w17
               	smax	v0.4s, v0.4s, v1.4s
               	fmov	w0, s0
               	cmp	w0, #0x2a
               	b.ne	<addr>
               	mov	x0, #0x2a               // =42
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
