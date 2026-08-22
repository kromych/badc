
attribute_cleanup.aarch64:	file format elf64-littleaarch64

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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	str	w1, [x0]
               	mov	x2, #0x1                // =1
               	stur	w2, [x29, #-0x20]
               	mov	x3, #0x2                // =2
               	stur	w3, [x29, #-0x18]
               	mov	x4, #0x3                // =3
               	stur	w4, [x29, #-0x10]
               	sub	x2, x29, #0x10
               	ldrsw	x3, [x2]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldrsw	x2, [x0]
               	add	x5, x2, #0x1
               	str	w5, [x0]
               	str	w3, [x4, x2, lsl #2]
               	sub	x2, x29, #0x18
               	ldrsw	x3, [x2]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldrsw	x2, [x0]
               	add	x5, x2, #0x1
               	str	w5, [x0]
               	str	w3, [x4, x2, lsl #2]
               	sub	x2, x29, #0x20
               	ldrsw	x3, [x2]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldrsw	x2, [x0]
               	add	x5, x2, #0x1
               	str	w5, [x0]
               	str	w3, [x4, x2, lsl #2]
               	ldrsw	x2, [x0]
               	cmp	x2, #0x3
               	mov	x3, #0x1                // =1
               	b.ne	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x2, [x2]
               	cmp	x2, #0x3
               	cset	x2, ne
               	cbnz	x2, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x2, [x2, #0x4]
               	cmp	x2, #0x2
               	cset	x2, ne
               	cbnz	x2, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x2, [x2, #0x8]
               	cmp	x2, #0x1
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, x3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	str	w1, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	w3, [x2]
               	stur	w1, [x29, #-0x8]
               	ldrsw	x2, [x2]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	w1, [x3]
               	mov	x5, #0x2bc              // =700
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldrsw	x3, [x0]
               	add	x6, x3, #0x1
               	str	w6, [x0]
               	str	w5, [x4, x3, lsl #2]
               	cmp	x2, #0x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x2, [x0]
               	cmp	x2, #0x1
               	cset	x2, ne
               	cbnz	x2, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x2, [x2]
               	cmp	x2, #0x2bc
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	str	w1, [x0]
               	mov	x2, #0x32               // =50
               	stur	w2, [x29, #-0x18]
               	b	<addr>
               	stur	w2, [x29, #-0x10]
               	cmp	x2, #0x1
               	b.ne	<addr>
               	sub	x3, x29, #0x10
               	ldrsw	x4, [x3]
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldrsw	x3, [x0]
               	add	x6, x3, #0x1
               	str	w6, [x0]
               	str	w4, [x5, x3, lsl #2]
               	b	<addr>
               	cmp	x2, #0x2
               	b.eq	<addr>
               	sub	x3, x29, #0x10
               	ldrsw	x4, [x3]
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldrsw	x3, [x0]
               	add	x6, x3, #0x1
               	str	w6, [x0]
               	str	w4, [x5, x3, lsl #2]
               	add	x1, x2, #0x1
               	sxtw	x2, w1
               	cmp	x2, #0x3
               	b.lt	<addr>
               	sub	x7, x29, #0x18
               	ldrsw	x2, [x7]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x1, [x0]
               	add	x4, x1, #0x1
               	str	w4, [x0]
               	str	w2, [x3, x1, lsl #2]
               	ldrsw	x1, [x0]
               	cmp	x1, #0x4
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	mov	x1, #0x1                // =1
               	cbnz	x2, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x2, [x2, #0x4]
               	cmp	x2, #0x1
               	cset	x2, ne
               	cbnz	x2, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x2, [x2, #0x8]
               	cmp	x2, #0x2
               	cset	x2, ne
               	cbnz	x2, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x2, [x2, #0xc]
               	cmp	x2, #0x32
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x6, #0x0                // =0
               	str	w6, [x0]
               	mov	x2, #0xa                // =10
               	stur	w2, [x29, #-0x20]
               	mov	x3, #0xb                // =11
               	stur	w3, [x29, #-0x18]
               	mov	x4, #0xc                // =12
               	stur	w4, [x29, #-0x10]
               	sub	x8, x29, #0x10
               	ldrsw	x9, [x8]
               	adrp	x10, <page>
               	add	x10, x10, <lo12>
               	ldrsw	x5, [x0]
               	add	x11, x5, #0x1
               	str	w11, [x0]
               	str	w9, [x10, x5, lsl #2]
               	ldrsw	x7, [x7]
               	adrp	x9, <page>
               	add	x9, x9, <lo12>
               	ldrsw	x5, [x0]
               	add	x10, x5, #0x1
               	str	w10, [x0]
               	str	w7, [x9, x5, lsl #2]
               	sub	x7, x29, #0x20
               	ldrsw	x9, [x7]
               	adrp	x10, <page>
               	add	x10, x10, <lo12>
               	ldrsw	x5, [x0]
               	add	x11, x5, #0x1
               	str	w11, [x0]
               	str	w9, [x10, x5, lsl #2]
               	mov	x5, #0x3e7              // =999
               	ldrsw	x5, [x0]
               	cmp	x5, #0x3
               	b.ne	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldrsw	x5, [x5]
               	cmp	x5, #0xc
               	cset	x5, ne
               	cbnz	x5, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1, #0x4]
               	cmp	x1, #0xb
               	cset	x1, ne
               	cbnz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1, #0x8]
               	cmp	x1, #0xa
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	str	w6, [x0]
               	stur	w2, [x29, #-0x20]
               	stur	w3, [x29, #-0x18]
               	stur	w4, [x29, #-0x10]
               	ldrsw	x2, [x8]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x1, [x0]
               	add	x4, x1, #0x1
               	str	w4, [x0]
               	str	w2, [x3, x1, lsl #2]
               	sub	x8, x29, #0x18
               	ldrsw	x2, [x8]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x1, [x0]
               	add	x4, x1, #0x1
               	str	w4, [x0]
               	str	w2, [x3, x1, lsl #2]
               	ldrsw	x2, [x7]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x1, [x0]
               	add	x4, x1, #0x1
               	str	w4, [x0]
               	str	w2, [x3, x1, lsl #2]
               	ldrsw	x1, [x0]
               	cmp	x1, #0x3
               	mov	x1, #0x1                // =1
               	b.ne	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x2, [x2]
               	cmp	x2, #0xc
               	cset	x2, ne
               	cbnz	x2, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x2, [x2, #0x4]
               	cmp	x2, #0xb
               	cset	x2, ne
               	cbnz	x2, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x2, [x2, #0x8]
               	cmp	x2, #0xa
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x4, #0x0                // =0
               	str	w4, [x0]
               	mov	x2, #0x28               // =40
               	stur	w2, [x29, #-0x18]
               	mov	x3, #0x29               // =41
               	stur	w3, [x29, #-0x10]
               	sub	x6, x29, #0x10
               	ldrsw	x7, [x6]
               	adrp	x9, <page>
               	add	x9, x9, <lo12>
               	ldrsw	x5, [x0]
               	add	x10, x5, #0x1
               	str	w10, [x0]
               	str	w7, [x9, x5, lsl #2]
               	ldrsw	x7, [x8]
               	adrp	x8, <page>
               	add	x8, x8, <lo12>
               	ldrsw	x5, [x0]
               	add	x9, x5, #0x1
               	str	w9, [x0]
               	str	w7, [x8, x5, lsl #2]
               	mov	x5, #0x2a               // =42
               	ldrsw	x5, [x0]
               	cmp	x5, #0x2
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	x1, #0x29
               	cset	x1, ne
               	cbnz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1, #0x4]
               	cmp	x1, #0x28
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	str	w4, [x0]
               	stur	w2, [x29, #-0x18]
               	stur	w3, [x29, #-0x10]
               	ldrsw	x2, [x6]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x1, [x0]
               	add	x5, x1, #0x1
               	str	w5, [x0]
               	str	w2, [x3, x1, lsl #2]
               	sub	x3, x29, #0x18
               	ldrsw	x2, [x3]
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldrsw	x1, [x0]
               	add	x6, x1, #0x1
               	str	w6, [x0]
               	str	w2, [x5, x1, lsl #2]
               	mov	x1, #0x2b               // =43
               	ldrsw	x1, [x0]
               	cmp	x1, #0x2
               	mov	x1, #0x1                // =1
               	b.ne	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x2, [x2]
               	cmp	x2, #0x29
               	cset	x2, ne
               	cbnz	x2, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x2, [x2, #0x4]
               	cmp	x2, #0x28
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	str	w4, [x0]
               	mov	x4, #0x14               // =20
               	stur	w4, [x29, #-0x18]
               	mov	x5, #0x15               // =21
               	stur	w5, [x29, #-0x10]
               	sub	x6, x29, #0x10
               	ldrsw	x7, [x6]
               	adrp	x8, <page>
               	add	x8, x8, <lo12>
               	ldrsw	x2, [x0]
               	add	x9, x2, #0x1
               	str	w9, [x0]
               	str	w7, [x8, x2, lsl #2]
               	ldrsw	x3, [x3]
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	ldrsw	x2, [x0]
               	add	x8, x2, #0x1
               	str	w8, [x0]
               	str	w3, [x7, x2, lsl #2]
               	mov	x2, #0x1e               // =30
               	ldrsw	x2, [x0]
               	cmp	x2, #0x2
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	x1, #0x15
               	cset	x1, ne
               	cbnz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1, #0x4]
               	cmp	x1, #0x14
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x0                // =0
               	str	w2, [x0]
               	stur	w4, [x29, #-0x18]
               	stur	w5, [x29, #-0x10]
               	ldrsw	x3, [x6]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldrsw	x1, [x0]
               	add	x5, x1, #0x1
               	str	w5, [x0]
               	str	w3, [x4, x1, lsl #2]
               	sub	x1, x29, #0x18
               	ldrsw	x3, [x1]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldrsw	x1, [x0]
               	add	x5, x1, #0x1
               	str	w5, [x0]
               	str	w3, [x4, x1, lsl #2]
               	mov	x1, #0x1f               // =31
               	ldrsw	x0, [x0]
               	cmp	x0, #0x2
               	mov	x0, #0x1                // =1
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x15
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x14
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x5, x1
               	b	<addr>
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	sub	x1, x29, #0x10
               	ldrsw	x2, [x1]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x1, [x0]
               	add	x4, x1, #0x1
               	str	w4, [x0]
               	str	w2, [x3, x1, lsl #2]
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x2, x3
               	b	<addr>
               	mov	x2, x3
               	b	<addr>
