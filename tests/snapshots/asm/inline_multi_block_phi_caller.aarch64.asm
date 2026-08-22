
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
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x17, #0xaaab            // =43691
               	movk	x17, #0xaaaa, lsl #16
               	mul	x3, x0, x17
               	lsr	x3, x3, #33
               	mov	x17, #0x3               // =3
               	mul	x3, x3, x17
               	sub	x4, x0, x3
               	mov	w3, w2
               	mov	w4, w4
               	cmp	w4, #0x1
               	b.lo	<addr>
               	cmp	w4, #0x1
               	b.eq	<addr>
               	mov	w5, w0
               	mov	w7, w3
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	w5, w5
               	mov	x17, #0x3               // =3
               	and	x5, x5, x17
               	mov	w7, w7
               	str	w7, [x4, x5, lsl #2]
               	mov	x17, #0x4e6d            // =20077
               	movk	x17, #0x41c6, lsl #16
               	mul	x2, x3, x17
               	mov	w2, w2
               	mov	x17, #0x3039            // =12345
               	add	x2, x2, x17
               	mov	w2, w2
               	b	<addr>
               	mov	w5, w0
               	mov	w7, w3
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	w5, w5
               	mov	x17, #0x3               // =3
               	and	x5, x5, x17
               	ldr	w8, [x4, x5, lsl #2]
               	mov	w7, w7
               	eor	x7, x8, x7
               	str	w7, [x4, x5, lsl #2]
               	b	<addr>
               	mov	w5, w0
               	mov	w7, w3
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	w5, w5
               	mov	x17, #0x3               // =3
               	and	x5, x5, x17
               	ldr	w8, [x4, x5, lsl #2]
               	mov	w7, w7
               	add	x7, x8, x7
               	str	w7, [x4, x5, lsl #2]
               	b	<addr>
               	add	x1, x0, #0x1
               	mov	w0, w1
               	mov	w3, w6
               	cmp	w0, w3
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
               	mov	w0, w0
               	mov	x17, #0x7f              // =127
               	and	x0, x0, x17
               	sxtw	x0, w0
               	ret
