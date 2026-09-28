
inline_asm_a64_pmull.aarch64:	file format elf64-littleaarch64

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
               	mov	x16, #0x3               // =3
               	mov	x17, #0x3               // =3
               	dup	v1.8b, w16
               	dup	v2.8b, w17
               	pmull	v0.8h, v1.8b, v2.8b
               	umov	w0, v0.h[0]
               	cmp	w0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x16, #0x7               // =7
               	mov	x17, #0x6               // =6
               	dup	v1.8b, w16
               	dup	v2.8b, w17
               	pmull	v0.8h, v1.8b, v2.8b
               	umov	w0, v0.h[0]
               	cmp	w0, #0x12
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x16, #0x3               // =3
               	mov	x17, #0x3               // =3
               	fmov	d1, x16
               	fmov	d2, x17
               	pmull	v0.1q, v1.1d, v2.1d
               	mov	x0, v0.d[0]
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x2a               // =42
               	ret
