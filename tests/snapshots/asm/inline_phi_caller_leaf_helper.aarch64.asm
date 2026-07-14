
inline_phi_caller_leaf_helper.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x5, x0
               	mov	x6, x1
               	sxtw	x6, w6
               	mov	x2, #0xe667             // =58983
               	movk	x2, #0x6a09, lsl #16
               	mov	x1, #0xae85             // =44677
               	movk	x1, #0xbb67, lsl #16
               	mov	x4, #0xf372             // =62322
               	movk	x4, #0x3c6e, lsl #16
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	w7, w2
               	mov	w8, w1
               	mov	w9, w4
               	mov	w4, w7
               	mov	w7, w8
               	and	x7, x4, x7
               	mvn	x4, x4
               	mov	w4, w4
               	mov	w8, w9
               	and	x4, x4, x8
               	eor	x4, x7, x4
               	mov	w4, w4
               	ldr	w7, [x5, x3, lsl #2]
               	add	x4, x4, x7
               	mov	w7, w4
               	mov	w4, w1
               	mov	w1, w2
               	mov	w2, w7
               	add	x0, x3, #0x1
               	sxtw	x3, w0
               	cmp	x3, x6
               	b.lt	<addr>
               	mov	w0, w2
               	mov	w1, w1
               	eor	x0, x0, x1
               	mov	w1, w4
               	eor	x0, x0, x1
               	mov	w0, w0
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
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
