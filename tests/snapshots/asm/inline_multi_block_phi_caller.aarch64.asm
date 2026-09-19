
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
               	mov	x2, #0x1                // =1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w6, [x0]
               	mov	x3, #0x0                // =0
               	mov	x7, #0x3                // =3
               	mov	x8, #0x3039             // =12345
               	mov	x9, #0x4e6d             // =20077
               	movk	x9, #0x41c6, lsl #16
               	mov	x10, #0xaaab            // =43691
               	movk	x10, #0xaaaa, lsl #16
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	w0, w3
               	cmp	w0, w6
               	b.hs	<addr>
               	mul	x4, x0, x10
               	lsr	x4, x4, #33
               	mul	x4, x4, x7
               	sub	x4, x0, x4
               	cmp	w4, #0x1
               	b.lo	<addr>
               	cmp	w4, #0x1
               	b.eq	<addr>
               	and	x4, x0, #0x3
               	str	w2, [x1, x4, lsl #2]
               	b	<addr>
               	and	x4, x0, #0x3
               	ldr	w11, [x1, x4, lsl #2]
               	eor	x5, x11, x2
               	str	w5, [x1, x4, lsl #2]
               	b	<addr>
               	and	x4, x0, #0x3
               	ldr	w11, [x1, x4, lsl #2]
               	add	x5, x11, x2
               	str	w5, [x1, x4, lsl #2]
               	mul	x2, x2, x9
               	mov	w2, w2
               	add	x2, x2, x8
               	mov	w2, w2
               	add	x3, x0, #0x1
               	mov	w0, w3
               	cmp	w0, w6
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
               	sxtw	x0, w0
               	ret
