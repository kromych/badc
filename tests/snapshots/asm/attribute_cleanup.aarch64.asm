
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

<loopy>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0x32               // =50
               	stur	w0, [x29, #-0x10]
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	stur	w0, [x29, #-0x8]
               	cmp	w0, #0x1
               	b.ne	<addr>
               	sub	x3, x29, #0x8
               	ldrsw	x4, [x3]
               	ldrsw	x3, [x2]
               	add	x5, x3, #0x1
               	str	w5, [x2]
               	str	w4, [x1, x3, lsl #2]
               	b	<addr>
               	cmp	w0, #0x2
               	b.eq	<addr>
               	sub	x3, x29, #0x8
               	ldrsw	x4, [x3]
               	ldrsw	x3, [x2]
               	add	x5, x3, #0x1
               	str	w5, [x2]
               	str	w4, [x1, x3, lsl #2]
               	sxtw	x0, w0
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	sub	x0, x29, #0x10
               	ldrsw	x1, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x0, [x3]
               	add	x4, x0, #0x1
               	str	w4, [x3]
               	str	w1, [x2, x0, lsl #2]
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	ldrsw	x1, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x0, [x3]
               	add	x4, x0, #0x1
               	str	w4, [x3]
               	str	w1, [x2, x0, lsl #2]
               	b	<addr>

<nested>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sxtw	x0, w0
               	mov	x1, #0xa                // =10
               	stur	w1, [x29, #-0x18]
               	mov	x1, #0xb                // =11
               	stur	w1, [x29, #-0x10]
               	mov	x1, #0xc                // =12
               	stur	w1, [x29, #-0x8]
               	cbz	x0, <addr>
               	sub	x0, x29, #0x8
               	ldrsw	x1, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x0, [x3]
               	add	x4, x0, #0x1
               	str	w4, [x3]
               	str	w1, [x2, x0, lsl #2]
               	sub	x0, x29, #0x10
               	ldrsw	x1, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x0, [x3]
               	add	x4, x0, #0x1
               	str	w4, [x3]
               	str	w1, [x2, x0, lsl #2]
               	sub	x0, x29, #0x18
               	ldrsw	x1, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x0, [x3]
               	add	x4, x0, #0x1
               	str	w4, [x3]
               	str	w1, [x2, x0, lsl #2]
               	mov	x0, #0x3e7              // =999
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	ldrsw	x1, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x0, [x3]
               	add	x4, x0, #0x1
               	str	w4, [x3]
               	str	w1, [x2, x0, lsl #2]
               	sub	x0, x29, #0x10
               	ldrsw	x1, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x0, [x3]
               	add	x4, x0, #0x1
               	str	w4, [x3]
               	str	w1, [x2, x0, lsl #2]
               	sub	x0, x29, #0x18
               	ldrsw	x1, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x0, [x3]
               	add	x4, x0, #0x1
               	str	w4, [x3]
               	str	w1, [x2, x0, lsl #2]
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	str	x20, [sp, #-0x40]!
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x0                // =0
               	str	w1, [x20]
               	mov	x0, #0x1                // =1
               	stur	w0, [x29, #-0x18]
               	mov	x0, #0x2                // =2
               	stur	w0, [x29, #-0x10]
               	mov	x0, #0x3                // =3
               	stur	w0, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	ldrsw	x2, [x0]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x0, [x20]
               	add	x4, x0, #0x1
               	str	w4, [x20]
               	str	w2, [x3, x0, lsl #2]
               	sub	x0, x29, #0x10
               	ldrsw	x2, [x0]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x0, [x20]
               	add	x4, x0, #0x1
               	str	w4, [x20]
               	str	w2, [x3, x0, lsl #2]
               	sub	x0, x29, #0x18
               	ldrsw	x2, [x0]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x0, [x20]
               	add	x4, x0, #0x1
               	str	w4, [x20]
               	str	w2, [x3, x0, lsl #2]
               	ldrsw	x0, [x20]
               	cmp	w0, #0x3
               	mov	x2, #0x1                // =1
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x3
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x4]
               	cmp	w0, #0x2
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x8]
               	cmp	w0, #0x1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, x2
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	str	w1, [x20]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	w2, [x0]
               	stur	w1, [x29, #-0x8]
               	ldrsw	x2, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	w1, [x0]
               	mov	x4, #0x2bc              // =700
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x0, [x20]
               	add	x5, x0, #0x1
               	str	w5, [x20]
               	str	w4, [x3, x0, lsl #2]
               	cmp	w2, #0x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	ldrsw	x0, [x20]
               	cmp	w0, #0x1
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x2bc
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	str	w1, [x20]
               	bl	<addr>
               	ldrsw	x0, [x20]
               	cmp	w0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	mov	x1, #0x1                // =1
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x4]
               	cmp	w0, #0x1
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x8]
               	cmp	w0, #0x2
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0xc]
               	cmp	w0, #0x32
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	mov	x0, #0x0                // =0
               	str	w0, [x20]
               	mov	x0, x1
               	bl	<addr>
               	cmp	x0, #0x3e7
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	ldrsw	x0, [x20]
               	cmp	w0, #0x3
               	mov	x0, #0x1                // =1
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	w1, #0xc
               	cset	x1, ne
               	cbnz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x4]
               	cmp	w0, #0xb
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x8]
               	cmp	w0, #0xa
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	mov	x0, #0x0                // =0
               	str	w0, [x20]
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	ldrsw	x0, [x20]
               	cmp	w0, #0x3
               	mov	x0, #0x1                // =1
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	w1, #0xc
               	cset	x1, ne
               	cbnz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1, #0x4]
               	cmp	w1, #0xb
               	cset	x1, ne
               	cbnz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1, #0x8]
               	cmp	w1, #0xa
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	mov	x2, #0x0                // =0
               	str	w2, [x20]
               	mov	x3, #0x28               // =40
               	stur	w3, [x29, #-0x10]
               	mov	x4, #0x29               // =41
               	stur	w4, [x29, #-0x8]
               	sub	x5, x29, #0x8
               	ldrsw	x6, [x5]
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	ldrsw	x1, [x20]
               	add	x8, x1, #0x1
               	str	w8, [x20]
               	str	w6, [x7, x1, lsl #2]
               	sub	x6, x29, #0x10
               	ldrsw	x7, [x6]
               	adrp	x8, <page>
               	add	x8, x8, <lo12>
               	ldrsw	x1, [x20]
               	add	x9, x1, #0x1
               	str	w9, [x20]
               	str	w7, [x8, x1, lsl #2]
               	mov	x1, #0x2a               // =42
               	ldrsw	x1, [x20]
               	cmp	w1, #0x2
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x29
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x4]
               	cmp	w0, #0x28
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	str	w2, [x20]
               	stur	w3, [x29, #-0x10]
               	stur	w4, [x29, #-0x8]
               	ldrsw	x1, [x5]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x0, [x20]
               	add	x4, x0, #0x1
               	str	w4, [x20]
               	str	w1, [x3, x0, lsl #2]
               	ldrsw	x1, [x6]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x0, [x20]
               	add	x4, x0, #0x1
               	str	w4, [x20]
               	str	w1, [x3, x0, lsl #2]
               	mov	x0, #0x2b               // =43
               	ldrsw	x0, [x20]
               	cmp	w0, #0x2
               	mov	x0, #0x1                // =1
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	w1, #0x29
               	cset	x1, ne
               	cbnz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1, #0x4]
               	cmp	w1, #0x28
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	str	w2, [x20]
               	mov	x2, #0x14               // =20
               	stur	w2, [x29, #-0x10]
               	mov	x3, #0x15               // =21
               	stur	w3, [x29, #-0x8]
               	sub	x4, x29, #0x8
               	ldrsw	x5, [x4]
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	ldrsw	x1, [x20]
               	add	x7, x1, #0x1
               	str	w7, [x20]
               	str	w5, [x6, x1, lsl #2]
               	sub	x5, x29, #0x10
               	ldrsw	x6, [x5]
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	ldrsw	x1, [x20]
               	add	x8, x1, #0x1
               	str	w8, [x20]
               	str	w6, [x7, x1, lsl #2]
               	mov	x1, #0x1e               // =30
               	ldrsw	x1, [x20]
               	cmp	w1, #0x2
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x15
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x4]
               	cmp	w0, #0x14
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xf                // =15
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	mov	x1, #0x0                // =0
               	str	w1, [x20]
               	stur	w2, [x29, #-0x10]
               	stur	w3, [x29, #-0x8]
               	ldrsw	x2, [x4]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x0, [x20]
               	add	x4, x0, #0x1
               	str	w4, [x20]
               	str	w2, [x3, x0, lsl #2]
               	ldrsw	x2, [x5]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x0, [x20]
               	add	x4, x0, #0x1
               	str	w4, [x20]
               	str	w2, [x3, x0, lsl #2]
               	mov	x0, #0x1f               // =31
               	ldrsw	x0, [x20]
               	cmp	w0, #0x2
               	mov	x0, #0x1                // =1
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x15
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x4]
               	cmp	w0, #0x14
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x11               // =17
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	mov	x0, x1
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	b	<addr>
               	mov	x0, x1
               	b	<addr>
               	mov	x0, x1
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, x2
               	b	<addr>
               	mov	x0, x2
               	b	<addr>
