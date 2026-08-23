
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
               	mov	x4, #0x1                // =1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w7, [x0]
               	mov	x2, #0x0                // =0
               	mov	x3, #0x3                // =3
               	mov	x8, #0x3039             // =12345
               	mov	x9, #0x4e6d             // =20077
               	movk	x9, #0x41c6, lsl #16
               	mov	x10, #0xaaab            // =43691
               	movk	x10, #0xaaaa, lsl #16
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	b	<addr>
               	mul	x5, x1, x10
               	lsr	x5, x5, #33
               	mul	x5, x5, x3
               	sub	x6, x1, x5
               	mov	w5, w4
               	mov	w6, w6
               	cmp	w6, #0x1
               	b.lo	<addr>
               	cmp	w6, #0x1
               	b.eq	<addr>
               	mov	w6, w1
               	mov	w11, w5
               	mov	w6, w6
               	and	x6, x6, x3
               	mov	w11, w11
               	str	w11, [x0, x6, lsl #2]
               	mul	x4, x5, x9
               	mov	w4, w4
               	add	x4, x4, x8
               	mov	w4, w4
               	b	<addr>
               	mov	w6, w1
               	mov	w11, w5
               	mov	w6, w6
               	and	x6, x6, x3
               	ldr	w12, [x0, x6, lsl #2]
               	mov	w11, w11
               	eor	x11, x12, x11
               	str	w11, [x0, x6, lsl #2]
               	b	<addr>
               	mov	w6, w1
               	mov	w11, w5
               	mov	w6, w6
               	and	x6, x6, x3
               	ldr	w12, [x0, x6, lsl #2]
               	mov	w11, w11
               	add	x11, x12, x11
               	str	w11, [x0, x6, lsl #2]
               	b	<addr>
               	add	x2, x1, #0x1
               	mov	w1, w2
               	mov	w5, w7
               	cmp	w1, w5
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
