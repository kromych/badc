
inline_phi_caller_leaf_helper.aarch64:	file format elf64-littleaarch64

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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x4, x29, #0x20
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x4]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [x0, #0x10]
               	str	x10, [x4, #0x10]
               	ldr	x10, [x0, #0x18]
               	str	x10, [x4, #0x18]
               	ldr	x10, [sp], #0x10
               	mov	x0, x4
               	mov	x1, #0xe667             // =58983
               	movk	x1, #0x6a09, lsl #16
               	mov	x2, #0xae85             // =44677
               	movk	x2, #0xbb67, lsl #16
               	mov	x3, #0xf372             // =62322
               	movk	x3, #0x3c6e, lsl #16
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	w5, w1
               	mov	w6, w2
               	mov	w7, w3
               	mov	w3, w5
               	mov	w8, w6
               	and	x8, x3, x8
               	mvn	x3, x3
               	mov	w3, w3
               	mov	w7, w7
               	and	x3, x3, x7
               	eor	x3, x8, x3
               	mov	w7, w3
               	sxtw	x3, w0
               	ldr	w8, [x4, x3, lsl #2]
               	add	x7, x7, x8
               	mov	w7, w7
               	mov	w1, w7
               	add	x0, x3, #0x1
               	mov	x3, x6
               	mov	x2, x5
               	cmp	w0, #0x8
               	b.lt	<addr>
               	mov	w0, w1
               	mov	w1, w2
               	eor	x0, x0, x1
               	mov	w1, w3
               	eor	x0, x0, x1
               	mov	w0, w0
               	mov	x17, #0xffef            // =65519
               	movk	x17, #0xff6f, lsl #16
               	cmp	w0, w17
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
