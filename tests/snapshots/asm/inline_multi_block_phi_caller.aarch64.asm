
inline_multi_block_phi_caller.aarch64:	file format elf64-littleaarch64

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
               	mov	x1, #0x1                // =1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w4, [x0]
               	mov	x0, #0x0                // =0
               	mov	x5, #0x3                // =3
               	mov	x6, #0x3039             // =12345
               	mov	x7, #0x4e6d             // =20077
               	movk	x7, #0x41c6, lsl #16
               	mov	x8, #0xaaab             // =43691
               	movk	x8, #0xaaaa, lsl #16
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	cmp	w0, w4
               	b.hs	<addr>
               	mul	x3, x0, x8
               	lsr	x3, x3, #33
               	mul	x3, x3, x5
               	sub	x3, x0, x3
               	cmp	w3, #0x1
               	b.lo	<addr>
               	cmp	w3, #0x1
               	b.eq	<addr>
               	and	x3, x0, #0x3
               	str	w1, [x2, x3, lsl #2]
               	b	<addr>
               	and	x3, x0, #0x3
               	ldr	w9, [x2, x3, lsl #2]
               	eor	x9, x9, x1
               	str	w9, [x2, x3, lsl #2]
               	b	<addr>
               	and	x3, x0, #0x3
               	ldr	w9, [x2, x3, lsl #2]
               	add	x9, x9, x1
               	str	w9, [x2, x3, lsl #2]
               	mul	x1, x1, x7
               	add	x1, x1, x6
               	add	x0, x0, #0x1
               	cmp	w0, w4
               	b.lo	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w1, [x0]
               	ldr	w2, [x0, #0x4]
               	eor	x1, x1, x2
               	ldr	w2, [x0, #0x8]
               	eor	x1, x1, x2
               	ldr	w0, [x0, #0xc]
               	eor	x0, x1, x0
               	and	x0, x0, #0x7f
               	ret
