
inline_phi_caller_leaf_helper.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	w0, w0
               	mov	w1, w1
               	and	x1, x0, x1
               	mvn	x0, x0
               	mov	w0, w0
               	mov	w2, w2
               	and	x0, x0, x2
               	eor	x0, x1, x0
               	ret

<digest>:
               	sxtw	x1, w1
               	mov	x6, #0xe667             // =58983
               	movk	x6, #0x6a09, lsl #16
               	mov	x5, #0xae85             // =44677
               	movk	x5, #0xbb67, lsl #16
               	mov	x4, #0xf372             // =62322
               	movk	x4, #0x3c6e, lsl #16
               	mov	x3, #0x0                // =0
               	b	<addr>
               	mov	w7, w6
               	mov	w8, w5
               	mov	w4, w4
               	mov	w7, w7
               	mov	w8, w8
               	and	x8, x7, x8
               	mvn	x7, x7
               	mov	w7, w7
               	mov	w4, w4
               	and	x4, x7, x4
               	eor	x4, x8, x4
               	ldr	w7, [x0, x2, lsl #2]
               	add	x4, x4, x7
               	mov	w7, w4
               	mov	w4, w5
               	mov	w5, w6
               	mov	w6, w7
               	add	x3, x2, #0x1
               	sxtw	x2, w3
               	cmp	x2, x1
               	b.lt	<addr>
               	mov	w0, w6
               	mov	w1, w5
               	eor	x0, x0, x1
               	mov	w1, w4
               	eor	x0, x0, x1
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	x0, x29, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x1, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x20
               	mov	x1, #0x8                // =8
               	bl	<addr>
               	mov	x17, #0xffef            // =65519
               	movk	x17, #0xff6f, lsl #16
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x1                // =1
               	b	<addr>
