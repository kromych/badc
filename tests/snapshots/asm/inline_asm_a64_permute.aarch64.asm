
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
               	mov	x16, #0x7               // =7
               	mov	x17, #0x2a              // =42
               	dup	v0.4s, w16
               	dup	v1.4s, w17
               	zip1	v2.4s, v0.4s, v1.4s
               	mov	w0, v2.s[1]
               	cmp	w0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x16, #0x7               // =7
               	mov	x17, #0x2a              // =42
               	dup	v0.4s, w16
               	dup	v1.4s, w17
               	ext	v2.16b, v0.16b, v1.16b, #0x4
               	mov	w0, v2.s[3]
               	cmp	w0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x2a               // =42
               	ret
