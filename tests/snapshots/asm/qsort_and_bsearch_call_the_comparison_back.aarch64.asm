
qsort_and_bsearch_call_the_comparison_back.aarch64:	file format elf64-littleaarch64

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

<by_key>:
               	adrp	x2, <page>
               	ldrsw	x3, [x2, #0x50]
               	add	x3, x3, #0x1
               	str	w3, [x2, #0x50]
               	ldrsw	x0, [x0]
               	ldrsw	x1, [x1]
               	cmp	w0, w1
               	cset	x2, gt
               	cmp	w0, w1
               	cset	x0, lt
               	sub	x0, x2, x0
               	ret

<ints>:
               	ldrsw	x0, [x0]
               	ldrsw	x1, [x1]
               	sub	x0, x0, x1
               	ret

<names>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	ldr	x0, [x0]
               	ldr	x1, [x1]
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x210
               	stp	x20, x21, [sp]
               	stp	x22, x23, [sp, #0x10]
               	sub	x0, x29, #0x1a0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	mov	x1, #0xc                // =12
               	mov	x22, #0x4               // =4
               	adrp	x23, <page>
               	add	x23, x23, <lo12>
               	mov	x2, x22
               	mov	x3, x23
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [sp, #0x70]
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [sp, #0x74]
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [sp, #0x78]
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [sp, #0x7c]
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [sp, #0x80]
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [sp, #0x84]
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [sp, #0x88]
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [sp, #0x8c]
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [sp, #0x90]
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [sp, #0x94]
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [sp, #0x98]
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [sp, #0x9c]
               	bl	<addr>
               	sub	x0, x29, #0x1c8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldr	x16, [x1, #0x20]
               	str	x16, [x0, #0x20]
               	mov	x1, #0x5                // =5
               	mov	x2, #0x8                // =8
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [sp, #0x48]
               	ldr	x2, [sp, #0x50]
               	ldr	x3, [sp, #0x58]
               	ldr	x4, [sp, #0x60]
               	ldr	x5, [sp, #0x68]
               	bl	<addr>
               	mov	x1, #0x7                // =7
               	mov	x0, #0x0                // =0
               	mov	x17, #0x4e6d            // =20077
               	movk	x17, #0x41c6, lsl #16
               	mul	x1, x1, x17
               	mov	x17, #0x3039            // =12345
               	add	x1, x1, x17
               	sub	x2, x29, #0x140
               	add	x2, x2, x0, lsl #3
               	mov	w3, w1
               	ubfx	x3, x3, #16, #2
               	str	w3, [x2]
               	str	w0, [x2, #0x4]
               	add	x0, x0, #0x1
               	cmp	w0, #0x28
               	b.lt	<addr>
               	sub	x21, x29, #0x140
               	mov	x1, #0x28               // =40
               	mov	x2, #0x8                // =8
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x0, x21
               	bl	<addr>
               	mov	x0, #0x1                // =1
               	mov	x1, x0
               	sub	x2, x0, #0x1
               	add	x2, x21, x2, lsl #3
               	ldrsw	x2, [x2]
               	add	x3, x21, x0, lsl #3
               	ldrsw	x3, [x3]
               	cmp	w2, w3
               	cset	x2, le
               	and	x1, x1, x2
               	add	x0, x0, #0x1
               	cmp	w0, #0x28
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldrsw	x1, [x1, #0x50]
               	bl	<addr>
               	mov	x20, #0x0               // =0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x1, x21, x20, lsl #3
               	ldrsw	x1, [x1, #0x4]
               	bl	<addr>
               	add	x20, x20, #0x1
               	cmp	w20, #0x28
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sub	x20, x29, #0x170
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x20]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x20, #0x10]
               	ldr	x16, [x0, #0x20]
               	str	x16, [x20, #0x20]
               	ldr	w16, [x0, #0x28]
               	str	w16, [x20, #0x28]
               	str	wzr, [sp, #0x40]
               	ldrsw	x0, [sp, #0x40]
               	cmp	w0, #0x9
               	b.gt	<addr>
               	sub	x0, x29, #0x1d0
               	mov	x2, #0xb                // =11
               	mov	x1, x20
               	mov	x4, x23
               	mov	x3, x22
               	bl	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x1, [sp, #0x40]
               	cbz	x0, <addr>
               	sub	x2, x0, x20
               	asr	x0, x2, #63
               	add	x0, x2, x0, lsr #62
               	asr	x2, x0, #2
               	b	<addr>
               	mov	x2, #-0x1               // =-1
               	mov	x0, x3
               	bl	<addr>
               	ldrsw	x0, [sp, #0x40]
               	add	x0, x0, #0x1
               	str	w0, [sp, #0x40]
               	ldrsw	x0, [sp, #0x40]
               	cmp	w0, #0x9
               	b.le	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x0, [sp, #0x20]
               	sub	x0, x29, #0x1f0
               	sub	x1, x29, #0x1c8
               	mov	x2, #0x5                // =5
               	mov	x3, #0x8                // =8
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	bl	<addr>
               	mov	x20, x0
               	sub	x1, x29, #0x1e0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	mov	x0, #0x7                // =7
               	str	w0, [sp, #0x28]
               	sub	x0, x29, #0x1e8
               	mov	x2, #0x6                // =6
               	mov	x3, #0x4                // =4
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	bl	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	cbz	x20, <addr>
               	ldr	x1, [x20]
               	sub	x2, x29, #0x1e0
               	sub	x2, x0, x2
               	asr	x0, x2, #63
               	add	x0, x2, x0, lsr #62
               	asr	x2, x0, #2
               	mov	x0, x3
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
