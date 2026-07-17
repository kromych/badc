
inline_multi_block_phi_caller.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x1, #0x1                // =1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w5, [x0]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	w2, w0
               	mov	x3, #0x3                // =3
               	udiv	x17, x2, x3
               	msub	x4, x17, x3, x2
               	mov	w3, w1
               	mov	w4, w4
               	cmp	x4, #0x1
               	b.lo	<addr>
               	cmp	x4, #0x1
               	b.eq	<addr>
               	mov	w4, w2
               	mov	w6, w3
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	w3, w4
               	mov	x17, #0x3               // =3
               	and	x3, x3, x17
               	mov	w4, w6
               	str	w4, [x2, x3, lsl #2]
               	mov	w1, w1
               	mov	x17, #0x4e6d            // =20077
               	movk	x17, #0x41c6, lsl #16
               	mul	x1, x1, x17
               	mov	w1, w1
               	mov	x17, #0x3039            // =12345
               	add	x1, x1, x17
               	mov	w1, w1
               	b	<addr>
               	mov	w4, w2
               	mov	w6, w3
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	w3, w4
               	mov	x17, #0x3               // =3
               	and	x3, x3, x17
               	ldr	w4, [x2, x3, lsl #2]
               	mov	w6, w6
               	eor	x4, x4, x6
               	str	w4, [x2, x3, lsl #2]
               	b	<addr>
               	cmp	x4, #0x0
               	b.ne	<addr>
               	mov	w4, w2
               	mov	w6, w3
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	w3, w4
               	mov	x17, #0x3               // =3
               	and	x3, x3, x17
               	ldr	w4, [x2, x3, lsl #2]
               	mov	w6, w6
               	add	x4, x4, x6
               	str	w4, [x2, x3, lsl #2]
               	b	<addr>
               	mov	w0, w0
               	add	x0, x0, #0x1
               	mov	w2, w0
               	mov	w3, w5
               	cmp	x2, x3
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
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ret
