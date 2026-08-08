
attribute_cleanup.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	str	w1, [x0]
               	mov	x1, #0x1                // =1
               	stur	w1, [x29, #-0x68]
               	mov	x2, #0x2                // =2
               	stur	w2, [x29, #-0x60]
               	mov	x3, #0x3                // =3
               	stur	w3, [x29, #-0x58]
               	sub	x1, x29, #0x58
               	ldrsw	x2, [x1]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x1, [x0]
               	add	x4, x1, #0x1
               	str	w4, [x0]
               	str	w2, [x3, x1, lsl #2]
               	sub	x1, x29, #0x60
               	ldrsw	x2, [x1]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x1, [x0]
               	add	x4, x1, #0x1
               	str	w4, [x0]
               	str	w2, [x3, x1, lsl #2]
               	sub	x1, x29, #0x68
               	ldrsw	x2, [x1]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x1, [x0]
               	add	x4, x1, #0x1
               	str	w4, [x0]
               	str	w2, [x3, x1, lsl #2]
               	ldrsw	x1, [x0]
               	cmp	x1, #0x3
               	cset	x1, ne
               	mov	x2, #0x1                // =1
               	cbnz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	x1, #0x3
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x2, ne
               	mov	x1, #0x1                // =1
               	cbnz	x2, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1, #0x4]
               	cmp	x1, #0x2
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1, #0x8]
               	cmp	x1, #0x1
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	str	w1, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x1                // =1
               	str	w2, [x1]
               	mov	x2, #0x0                // =0
               	stur	w2, [x29, #-0x50]
               	ldrsw	x1, [x1]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, #0x0                // =0
               	str	w3, [x2]
               	mov	x4, #0x2bc              // =700
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x2, [x0]
               	add	x5, x2, #0x1
               	str	w5, [x0]
               	str	w4, [x3, x2, lsl #2]
               	cmp	x1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x1, [x0]
               	cmp	x1, #0x1
               	cset	x1, ne
               	cbnz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	x1, #0x2bc
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	str	w1, [x0]
               	mov	x1, #0x32               // =50
               	stur	w1, [x29, #-0x48]
               	mov	x1, #0x0                // =0
               	b	<addr>
               	stur	w2, [x29, #-0x40]
               	cmp	x2, #0x1
               	b.ne	<addr>
               	sub	x3, x29, #0x40
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
               	sub	x3, x29, #0x40
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
               	sub	x1, x29, #0x48
               	ldrsw	x2, [x1]
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
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	x1, #0x0
               	cset	x1, ne
               	mov	x2, #0x1                // =1
               	cbnz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1, #0x4]
               	cmp	x1, #0x1
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x2, ne
               	mov	x1, #0x1                // =1
               	cbnz	x2, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1, #0x8]
               	cmp	x1, #0x2
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1, #0xc]
               	cmp	x1, #0x32
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	str	w1, [x0]
               	mov	x1, #0xa                // =10
               	stur	w1, [x29, #-0x38]
               	mov	x1, #0xb                // =11
               	stur	w1, [x29, #-0x30]
               	mov	x1, #0xc                // =12
               	stur	w1, [x29, #-0x28]
               	sub	x1, x29, #0x28
               	ldrsw	x2, [x1]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x1, [x0]
               	add	x4, x1, #0x1
               	str	w4, [x0]
               	str	w2, [x3, x1, lsl #2]
               	sub	x1, x29, #0x30
               	ldrsw	x2, [x1]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x1, [x0]
               	add	x4, x1, #0x1
               	str	w4, [x0]
               	str	w2, [x3, x1, lsl #2]
               	sub	x1, x29, #0x38
               	ldrsw	x2, [x1]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x1, [x0]
               	add	x4, x1, #0x1
               	str	w4, [x0]
               	str	w2, [x3, x1, lsl #2]
               	mov	x1, #0x3e7              // =999
               	ldrsw	x1, [x0]
               	cmp	x1, #0x3
               	cset	x1, ne
               	mov	x2, #0x1                // =1
               	cbnz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	x1, #0xc
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x2, ne
               	mov	x1, #0x1                // =1
               	cbnz	x2, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1, #0x4]
               	cmp	x1, #0xb
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1, #0x8]
               	cmp	x1, #0xa
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	str	w1, [x0]
               	mov	x1, #0xa                // =10
               	stur	w1, [x29, #-0x38]
               	mov	x1, #0xb                // =11
               	stur	w1, [x29, #-0x30]
               	mov	x1, #0xc                // =12
               	stur	w1, [x29, #-0x28]
               	sub	x1, x29, #0x28
               	ldrsw	x2, [x1]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x1, [x0]
               	add	x4, x1, #0x1
               	str	w4, [x0]
               	str	w2, [x3, x1, lsl #2]
               	sub	x1, x29, #0x30
               	ldrsw	x2, [x1]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x1, [x0]
               	add	x4, x1, #0x1
               	str	w4, [x0]
               	str	w2, [x3, x1, lsl #2]
               	sub	x1, x29, #0x38
               	ldrsw	x2, [x1]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x1, [x0]
               	add	x4, x1, #0x1
               	str	w4, [x0]
               	str	w2, [x3, x1, lsl #2]
               	mov	x1, #0x0                // =0
               	ldrsw	x1, [x0]
               	cmp	x1, #0x3
               	cset	x1, ne
               	mov	x2, #0x1                // =1
               	cbnz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	x1, #0xc
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x2, ne
               	mov	x1, #0x1                // =1
               	cbnz	x2, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1, #0x4]
               	cmp	x1, #0xb
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1, #0x8]
               	cmp	x1, #0xa
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	str	w1, [x0]
               	mov	x1, #0x28               // =40
               	stur	w1, [x29, #-0x20]
               	mov	x1, #0x29               // =41
               	stur	w1, [x29, #-0x18]
               	sub	x1, x29, #0x18
               	ldrsw	x2, [x1]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x1, [x0]
               	add	x4, x1, #0x1
               	str	w4, [x0]
               	str	w2, [x3, x1, lsl #2]
               	sub	x1, x29, #0x20
               	ldrsw	x2, [x1]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x1, [x0]
               	add	x4, x1, #0x1
               	str	w4, [x0]
               	str	w2, [x3, x1, lsl #2]
               	mov	x1, #0x2a               // =42
               	ldrsw	x1, [x0]
               	cmp	x1, #0x2
               	cset	x2, ne
               	mov	x1, #0x1                // =1
               	cbnz	x2, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	x1, #0x29
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1, #0x4]
               	cmp	x1, #0x28
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	str	w1, [x0]
               	mov	x1, #0x28               // =40
               	stur	w1, [x29, #-0x20]
               	mov	x1, #0x29               // =41
               	stur	w1, [x29, #-0x18]
               	sub	x1, x29, #0x18
               	ldrsw	x2, [x1]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x1, [x0]
               	add	x4, x1, #0x1
               	str	w4, [x0]
               	str	w2, [x3, x1, lsl #2]
               	sub	x1, x29, #0x20
               	ldrsw	x2, [x1]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x1, [x0]
               	add	x4, x1, #0x1
               	str	w4, [x0]
               	str	w2, [x3, x1, lsl #2]
               	mov	x1, #0x2b               // =43
               	ldrsw	x1, [x0]
               	cmp	x1, #0x2
               	cset	x2, ne
               	mov	x1, #0x1                // =1
               	cbnz	x2, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	x1, #0x29
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1, #0x4]
               	cmp	x1, #0x28
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	str	w1, [x0]
               	mov	x1, #0x14               // =20
               	stur	w1, [x29, #-0x10]
               	mov	x1, #0x15               // =21
               	stur	w1, [x29, #-0x8]
               	sub	x1, x29, #0x8
               	ldrsw	x2, [x1]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x1, [x0]
               	add	x4, x1, #0x1
               	str	w4, [x0]
               	str	w2, [x3, x1, lsl #2]
               	sub	x1, x29, #0x10
               	ldrsw	x2, [x1]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x1, [x0]
               	add	x4, x1, #0x1
               	str	w4, [x0]
               	str	w2, [x3, x1, lsl #2]
               	mov	x1, #0x1e               // =30
               	ldrsw	x1, [x0]
               	cmp	x1, #0x2
               	cset	x2, ne
               	mov	x1, #0x1                // =1
               	cbnz	x2, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	x1, #0x15
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1, #0x4]
               	cmp	x1, #0x14
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	str	w1, [x0]
               	mov	x1, #0x14               // =20
               	stur	w1, [x29, #-0x10]
               	mov	x1, #0x15               // =21
               	stur	w1, [x29, #-0x8]
               	sub	x1, x29, #0x8
               	ldrsw	x2, [x1]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x1, [x0]
               	add	x4, x1, #0x1
               	str	w4, [x0]
               	str	w2, [x3, x1, lsl #2]
               	sub	x1, x29, #0x10
               	ldrsw	x2, [x1]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x1, [x0]
               	add	x4, x1, #0x1
               	str	w4, [x0]
               	str	w2, [x3, x1, lsl #2]
               	mov	x1, #0x1f               // =31
               	ldrsw	x0, [x0]
               	cmp	x0, #0x2
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x15
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x14
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	sub	x1, x29, #0x40
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
               	b	<addr>
               	b	<addr>
