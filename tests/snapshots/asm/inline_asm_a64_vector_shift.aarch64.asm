
inline_asm_a64_vector_shift.aarch64:	file format elf64-littleaarch64

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
               	mov	x16, #0x5               // =5
               	dup	v0.4s, w16
               	shl	v0.4s, v0.4s, #0x3
               	fmov	w0, s0
               	cmp	w0, #0x28
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x16, #-0x54             // =-84
               	dup	v0.4s, w16
               	sshr	v0.4s, v0.4s, #0x1
               	fmov	w0, s0
               	mov	x17, #-0x2a             // =-42
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x16, #0xa8              // =168
               	dup	v0.4s, w16
               	ushr	v0.4s, v0.4s, #0x2
               	fmov	w0, s0
               	cmp	w0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x2a               // =42
               	ret
