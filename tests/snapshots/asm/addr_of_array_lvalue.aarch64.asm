
addr_of_array_lvalue.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x50
               	sub	x0, x29, #0x30
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	add	x1, x0, #0xc
               	str	x1, [x0, #0x28]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x1, #0x2a               // =42
               	str	w1, [x2, #0x5c]
               	mov	x1, #0x7                // =7
               	str	w1, [x2, #0x2c]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x4, [x1, #0xc]
               	cmp	w4, #0x4
               	b.ne	<addr>
               	ldrsw	x4, [x1, #0xc]
               	cmp	w4, #0x4
               	b.ne	<addr>
               	ldrsw	x4, [x1, #0x4]
               	cmp	w4, #0x2
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x4, [x2, #0x5c]
               	cmp	w4, #0x2a
               	b.ne	<addr>
               	ldrsw	x4, [x2, #0x5c]
               	cmp	w4, #0x2a
               	b.ne	<addr>
               	ldrsw	x4, [x2, #0x5c]
               	cmp	w4, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x4, [x1, #0x4]
               	cmp	w4, #0x2
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x4, [x0, #0x8]
               	cmp	w4, #0x3
               	b.ne	<addr>
               	ldrsw	x4, [x0, #0x4]
               	cmp	w4, #0x2
               	b.ne	<addr>
               	ldrsw	x4, [x0, #0x20]
               	cmp	w4, #0x6
               	b.ne	<addr>
               	ldrsw	x4, [x0, #0x18]
               	cmp	w4, #0x4
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [x0, #0x28]
               	ldrsw	x0, [x0, #0x10]
               	cmp	w0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x3, #0x8]
               	cmp	w0, #0x9
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x3, [x0]
               	ldrsw	x3, [x3, #0x8]
               	cmp	w3, #0x3
               	b.ne	<addr>
               	ldr	x3, [x0]
               	ldrsw	x3, [x3, #0xc]
               	cmp	w3, #0x4
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [x0]
               	ldrsw	x0, [x0, #0xc]
               	cmp	w0, #0x4
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x3, [x0]
               	ldrsw	x3, [x3, #0x5c]
               	cmp	w3, #0x2a
               	b.ne	<addr>
               	ldr	x0, [x0]
               	ldrsw	x0, [x0, #0x2c]
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x3, x1, #0x8
               	sub	x0, x3, x1
               	asr	x4, x0, #63
               	lsr	x5, x4, #61
               	add	x5, x0, x5
               	asr	x5, x5, #3
               	cmp	x5, #0x1
               	b.ne	<addr>
               	cmp	x0, #0x8
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x1, [x1, #0xc]
               	cmp	w1, #0x4
               	b.ne	<addr>
               	ldrsw	x1, [x2, #0x5c]
               	cmp	w1, #0x2a
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x40
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x16, [x2]
               	str	x16, [x1]
               	ldr	w16, [x2, #0x8]
               	str	w16, [x1, #0x8]
               	ldrsw	x1, [x3, #0x4]
               	cmp	w1, #0x4
               	b.ne	<addr>
               	add	x1, x0, #0xf
               	and	x1, x1, #0xfffffffffffffff0
               	cmp	x1, #0x10
               	b.ne	<addr>
               	lsr	x1, x4, #62
               	add	x0, x0, x1
               	asr	x0, x0, #2
               	add	x0, x0, #0x3
               	and	x0, x0, #0xfffffffffffffffc
               	cmp	x0, #0x4
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x0]
               	ldr	x1, [x1]
               	ldrsw	x1, [x1]
               	add	x1, x2, x1
               	cmp	w1, #0x3
               	b.eq	<addr>
               	mov	x0, #0x1a               // =26
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	stur	x0, [x29, #-0x48]
               	stur	x1, [x29, #-0x38]
               	cmp	x0, x0
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	cbz	x0, <addr>
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x38]
               	cmp	x0, x0
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	b	<addr>
               	ldrsw	x0, [x2, #0x5c]
               	cmp	w0, #0x2a
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x17               // =23
               	b	<addr>
               	mov	x0, #0x1b               // =27
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x13               // =19
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
