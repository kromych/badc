
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
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	stur	w0, [x29, #-0x8]
               	cmp	w0, #0x1
               	b.ne	<addr>
               	ldursw	x4, [x29, #-0x8]
               	ldrsw	x3, [x1]
               	add	x5, x3, #0x1
               	str	w5, [x1]
               	str	w4, [x2, x3, lsl #2]
               	b	<addr>
               	cmp	w0, #0x2
               	b.eq	<addr>
               	ldursw	x4, [x29, #-0x8]
               	ldrsw	x3, [x1]
               	add	x5, x3, #0x1
               	str	w5, [x1]
               	str	w4, [x2, x3, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	ldursw	x2, [x29, #-0x10]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x4, x1, #0x1
               	str	w4, [x0]
               	str	w2, [x3, x1, lsl #2]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x2, [x29, #-0x8]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x4, x1, #0x1
               	str	w4, [x0]
               	str	w2, [x3, x1, lsl #2]
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
               	ldursw	x3, [x29, #-0x8]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x4, x2, #0x1
               	str	w4, [x0]
               	str	w3, [x1, x2, lsl #2]
               	ldursw	x3, [x29, #-0x10]
               	ldrsw	x2, [x0]
               	add	x4, x2, #0x1
               	str	w4, [x0]
               	str	w3, [x1, x2, lsl #2]
               	ldursw	x3, [x29, #-0x18]
               	ldrsw	x2, [x0]
               	add	x4, x2, #0x1
               	str	w4, [x0]
               	str	w3, [x1, x2, lsl #2]
               	mov	x0, #0x3e7              // =999
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x3, [x29, #-0x8]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x4, x2, #0x1
               	str	w4, [x0]
               	str	w3, [x1, x2, lsl #2]
               	ldursw	x3, [x29, #-0x10]
               	ldrsw	x2, [x0]
               	add	x4, x2, #0x1
               	str	w4, [x0]
               	str	w3, [x1, x2, lsl #2]
               	ldursw	x3, [x29, #-0x18]
               	ldrsw	x2, [x0]
               	add	x4, x2, #0x1
               	str	w4, [x0]
               	str	w3, [x1, x2, lsl #2]
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	wzr, [x0]
               	mov	x4, #0x1                // =1
               	stur	w4, [x29, #-0x18]
               	mov	x5, #0x2                // =2
               	stur	w5, [x29, #-0x10]
               	mov	x1, #0x3                // =3
               	stur	w1, [x29, #-0x8]
               	mov	x6, x1
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x3, [x0]
               	add	x7, x3, #0x1
               	str	w7, [x0]
               	str	w6, [x1, x3, lsl #2]
               	ldursw	x6, [x29, #-0x10]
               	ldrsw	x3, [x0]
               	add	x7, x3, #0x1
               	str	w7, [x0]
               	str	w6, [x1, x3, lsl #2]
               	ldursw	x6, [x29, #-0x18]
               	ldrsw	x3, [x0]
               	add	x7, x3, #0x1
               	str	w7, [x0]
               	str	w6, [x1, x3, lsl #2]
               	ldrsw	x3, [x0]
               	cmp	w3, #0x3
               	b.ne	<addr>
               	ldrsw	x3, [x1]
               	cmp	w3, #0x3
               	b.ne	<addr>
               	ldrsw	x3, [x1, #0x4]
               	cmp	w3, #0x2
               	b.ne	<addr>
               	ldrsw	x3, [x1, #0x8]
               	cmp	w3, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	str	wzr, [x0]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	w4, [x3]
               	stur	wzr, [x29, #-0x8]
               	ldrsw	x4, [x3]
               	str	wzr, [x3]
               	mov	x3, #0x2bc              // =700
               	ldrsw	x2, [x0]
               	add	x6, x2, #0x1
               	str	w6, [x0]
               	str	w3, [x1, x2, lsl #2]
               	cmp	w4, #0x1
               	b.eq	<addr>
               	mov	x0, x5
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	cmp	w1, #0x1
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	w1, #0x2bc
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	str	wzr, [x0]
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x0, [x1]
               	cmp	w0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	cbnz	w2, <addr>
               	ldrsw	x2, [x0, #0x4]
               	cmp	w2, #0x1
               	b.ne	<addr>
               	ldrsw	x2, [x0, #0x8]
               	cmp	w2, #0x2
               	b.ne	<addr>
               	ldrsw	x0, [x0, #0xc]
               	cmp	w0, #0x32
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	str	wzr, [x1]
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cmp	w0, #0x3e7
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x0, [x1]
               	cmp	w0, #0x3
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	cmp	w2, #0xc
               	b.ne	<addr>
               	ldrsw	x2, [x0, #0x4]
               	cmp	w2, #0xb
               	b.ne	<addr>
               	ldrsw	x0, [x0, #0x8]
               	cmp	w0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	str	w0, [x1]
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	cmp	w1, #0x3
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	cmp	w2, #0xc
               	b.ne	<addr>
               	ldrsw	x2, [x1, #0x4]
               	cmp	w2, #0xb
               	b.ne	<addr>
               	ldrsw	x2, [x1, #0x8]
               	cmp	w2, #0xa
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	str	wzr, [x0]
               	mov	x5, #0x28               // =40
               	stur	w5, [x29, #-0x10]
               	mov	x6, #0x29               // =41
               	stur	w6, [x29, #-0x8]
               	sub	x3, x29, #0x8
               	ldrsw	x7, [x3]
               	ldrsw	x4, [x0]
               	add	x8, x4, #0x1
               	str	w8, [x0]
               	str	w7, [x1, x4, lsl #2]
               	sub	x4, x29, #0x10
               	ldrsw	x8, [x4]
               	ldrsw	x7, [x0]
               	add	x9, x7, #0x1
               	str	w9, [x0]
               	str	w8, [x1, x7, lsl #2]
               	ldrsw	x7, [x0]
               	cmp	w7, #0x2
               	b.ne	<addr>
               	ldrsw	x7, [x1]
               	cmp	w7, #0x29
               	b.ne	<addr>
               	ldrsw	x7, [x1, #0x4]
               	cmp	w7, #0x28
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	str	wzr, [x0]
               	stur	w5, [x29, #-0x10]
               	stur	w6, [x29, #-0x8]
               	ldrsw	x6, [x3]
               	ldrsw	x5, [x0]
               	add	x7, x5, #0x1
               	str	w7, [x0]
               	str	w6, [x1, x5, lsl #2]
               	ldrsw	x6, [x4]
               	ldrsw	x5, [x0]
               	add	x7, x5, #0x1
               	str	w7, [x0]
               	str	w6, [x1, x5, lsl #2]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	cmp	w1, #0x2
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x5, [x1]
               	cmp	w5, #0x29
               	b.ne	<addr>
               	ldrsw	x5, [x1, #0x4]
               	cmp	w5, #0x28
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	str	wzr, [x0]
               	mov	x5, #0x14               // =20
               	stur	w5, [x29, #-0x10]
               	mov	x2, #0x15               // =21
               	stur	w2, [x29, #-0x8]
               	ldrsw	x6, [x3]
               	ldrsw	x3, [x0]
               	add	x7, x3, #0x1
               	str	w7, [x0]
               	str	w6, [x1, x3, lsl #2]
               	ldrsw	x4, [x4]
               	ldrsw	x3, [x0]
               	add	x6, x3, #0x1
               	str	w6, [x0]
               	str	w4, [x1, x3, lsl #2]
               	ldrsw	x3, [x0]
               	cmp	w3, #0x2
               	b.ne	<addr>
               	ldrsw	x3, [x1]
               	cmp	w3, #0x15
               	b.ne	<addr>
               	ldrsw	x3, [x1, #0x4]
               	cmp	w3, #0x14
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0x0                // =0
               	str	w3, [x0]
               	stur	w5, [x29, #-0x10]
               	stur	w2, [x29, #-0x8]
               	mov	x4, x2
               	ldrsw	x2, [x0]
               	add	x5, x2, #0x1
               	str	w5, [x0]
               	str	w4, [x1, x2, lsl #2]
               	ldursw	x4, [x29, #-0x10]
               	ldrsw	x2, [x0]
               	add	x5, x2, #0x1
               	str	w5, [x0]
               	str	w4, [x1, x2, lsl #2]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x2
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	cmp	w1, #0x15
               	b.ne	<addr>
               	ldrsw	x0, [x0, #0x4]
               	cmp	w0, #0x14
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
