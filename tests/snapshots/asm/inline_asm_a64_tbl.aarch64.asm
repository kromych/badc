
inline_asm_a64_tbl.aarch64:	file format elf64-littleaarch64

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
               	mov	x16, #0x2a              // =42
               	mov	x17, #0x3               // =3
               	dup	v1.16b, w16
               	dup	v2.16b, w17
               	tbl	v0.16b, { v1.16b }, v2.16b
               	umov	w0, v0.b[0]
               	cmp	w0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x16, #0x2a              // =42
               	mov	x17, #0x10              // =16
               	dup	v1.16b, w16
               	dup	v2.16b, w17
               	tbl	v0.16b, { v1.16b }, v2.16b
               	umov	w0, v0.b[0]
               	cbz	w0, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x2a               // =42
               	ret
