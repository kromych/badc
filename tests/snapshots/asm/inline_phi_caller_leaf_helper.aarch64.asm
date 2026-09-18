
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
               	sub	sp, sp, #0x20
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
               	mov	x1, #0xe667             // =58983
               	movk	x1, #0x6a09, lsl #16
               	mov	x2, #0xae85             // =44677
               	movk	x2, #0xbb67, lsl #16
               	mov	x3, #0xf372             // =62322
               	movk	x3, #0x3c6e, lsl #16
               	mov	x0, #0x0                // =0
               	b	<addr>
               	and	x5, x1, x2
               	mvn	x6, x1
               	mov	w6, w6
               	and	x3, x6, x3
               	eor	x3, x5, x3
               	sxtw	x5, w0
               	ldr	w5, [x4, x5, lsl #2]
               	add	x3, x3, x5
               	mov	w3, w3
               	add	x0, x0, #0x1
               	mov	x16, x2
               	mov	x2, x1
               	mov	x1, x3
               	mov	x3, x16
               	cmp	w0, #0x8
               	b.lt	<addr>
               	eor	x0, x1, x2
               	eor	x0, x0, x3
               	mov	x17, #0xffef            // =65519
               	movk	x17, #0xff6f, lsl #16
               	cmp	w0, w17
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
