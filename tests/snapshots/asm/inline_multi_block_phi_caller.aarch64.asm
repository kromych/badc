
inline_multi_block_phi_caller.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x2, x0
               	mov	x3, x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	w1, w2
               	mov	x17, #0x3               // =3
               	and	x1, x1, x17
               	ldr	w2, [x0, x1, lsl #2]
               	mov	w3, w3
               	add	x2, x2, x3
               	str	w2, [x0, x1, lsl #2]
               	mov	x0, #0x0                // =0
               	ret

<acc_xor>:
               	mov	x2, x0
               	mov	x3, x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	w1, w2
               	mov	x17, #0x3               // =3
               	and	x1, x1, x17
               	ldr	w2, [x0, x1, lsl #2]
               	mov	w3, w3
               	eor	x2, x2, x3
               	str	w2, [x0, x1, lsl #2]
               	mov	x0, #0x0                // =0
               	ret

<acc_def>:
               	mov	x2, x0
               	mov	x3, x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	w1, w2
               	mov	x17, #0x3               // =3
               	and	x1, x1, x17
               	mov	w2, w3
               	str	w2, [x0, x1, lsl #2]
               	mov	x0, #0x0                // =0
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x30]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x21, #0x1               // =1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w22, [x0]
               	mov	x20, #0x0               // =0
               	b	<addr>
               	mov	w0, w20
               	mov	x1, #0x3                // =3
               	udiv	x17, x0, x1
               	msub	x2, x17, x1, x0
               	mov	w1, w21
               	mov	w2, w2
               	cmp	x2, #0x1
               	b.lo	<addr>
               	cmp	x2, #0x1
               	b.eq	<addr>
               	mov	w0, w0
               	mov	w1, w1
               	bl	<addr>
               	mov	w0, w21
               	mov	x17, #0x4e6d            // =20077
               	movk	x17, #0x41c6, lsl #16
               	mul	x0, x0, x17
               	mov	w0, w0
               	mov	x17, #0x3039            // =12345
               	add	x0, x0, x17
               	mov	w21, w0
               	b	<addr>
               	mov	w0, w0
               	mov	w1, w1
               	bl	<addr>
               	b	<addr>
               	cmp	x2, #0x0
               	b.ne	<addr>
               	mov	w0, w0
               	mov	w1, w1
               	bl	<addr>
               	b	<addr>
               	mov	w0, w20
               	add	x20, x0, #0x1
               	mov	w0, w20
               	mov	w1, w22
               	cmp	x0, x1
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
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
