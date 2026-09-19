
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
               	cmp	w0, #0x3
               	b.ge	<addr>
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
               	ldrsw	x3, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	add	x4, x2, #0x1
               	str	w4, [x1]
               	str	w3, [x0, x2, lsl #2]
               	sub	x2, x29, #0x10
               	ldrsw	x3, [x2]
               	ldrsw	x2, [x1]
               	add	x4, x2, #0x1
               	str	w4, [x1]
               	str	w3, [x0, x2, lsl #2]
               	sub	x2, x29, #0x18
               	ldrsw	x3, [x2]
               	ldrsw	x2, [x1]
               	add	x4, x2, #0x1
               	str	w4, [x1]
               	str	w3, [x0, x2, lsl #2]
               	mov	x0, #0x3e7              // =999
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	ldrsw	x3, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	add	x4, x2, #0x1
               	str	w4, [x1]
               	str	w3, [x0, x2, lsl #2]
               	sub	x2, x29, #0x10
               	ldrsw	x3, [x2]
               	ldrsw	x2, [x1]
               	add	x4, x2, #0x1
               	str	w4, [x1]
               	str	w3, [x0, x2, lsl #2]
               	sub	x2, x29, #0x18
               	ldrsw	x3, [x2]
               	ldrsw	x2, [x1]
               	add	x4, x2, #0x1
               	str	w4, [x1]
               	str	w3, [x0, x2, lsl #2]
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	str	x20, [sp, #-0x40]!
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x0                // =0
               	str	w2, [x1]
               	mov	x4, #0x1                // =1
               	stur	w4, [x29, #-0x18]
               	mov	x5, #0x2                // =2
               	stur	w5, [x29, #-0x10]
               	mov	x0, #0x3                // =3
               	stur	w0, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	ldrsw	x6, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x3, [x1]
               	add	x7, x3, #0x1
               	str	w7, [x1]
               	str	w6, [x0, x3, lsl #2]
               	sub	x3, x29, #0x10
               	ldrsw	x6, [x3]
               	ldrsw	x3, [x1]
               	add	x7, x3, #0x1
               	str	w7, [x1]
               	str	w6, [x0, x3, lsl #2]
               	sub	x3, x29, #0x18
               	ldrsw	x6, [x3]
               	ldrsw	x3, [x1]
               	add	x7, x3, #0x1
               	str	w7, [x1]
               	str	w6, [x0, x3, lsl #2]
               	ldrsw	x3, [x1]
               	cmp	w3, #0x3
               	b.ne	<addr>
               	ldrsw	x3, [x0]
               	cmp	w3, #0x3
               	b.ne	<addr>
               	ldrsw	x3, [x0, #0x4]
               	cmp	w3, #0x2
               	b.ne	<addr>
               	ldrsw	x3, [x0, #0x8]
               	cmp	w3, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	str	w2, [x1]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	w4, [x3]
               	stur	w2, [x29, #-0x8]
               	ldrsw	x4, [x3]
               	str	w2, [x3]
               	mov	x3, #0x2bc              // =700
               	ldrsw	x2, [x1]
               	add	x6, x2, #0x1
               	str	w6, [x1]
               	str	w3, [x0, x2, lsl #2]
               	cmp	w4, #0x1
               	b.eq	<addr>
               	mov	x0, x5
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	ldrsw	x0, [x20]
               	cmp	w0, #0x1
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x2bc
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	mov	x0, #0x0                // =0
               	str	w0, [x20]
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
               	ldrsw	x1, [x0]
               	cbnz	x1, <addr>
               	ldrsw	x1, [x0, #0x4]
               	cmp	w1, #0x1
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0x8]
               	cmp	w1, #0x2
               	b.ne	<addr>
               	ldrsw	x0, [x0, #0xc]
               	cmp	w0, #0x32
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	str	w1, [x0]
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cmp	x0, #0x3e7
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
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
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	mov	x0, #0x0                // =0
               	str	w0, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
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
               	ldrsw	x2, [x0, #0x8]
               	cmp	w2, #0xa
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	mov	x2, #0x0                // =0
               	str	w2, [x1]
               	mov	x6, #0x28               // =40
               	stur	w6, [x29, #-0x10]
               	mov	x7, #0x29               // =41
               	stur	w7, [x29, #-0x8]
               	sub	x3, x29, #0x8
               	ldrsw	x5, [x3]
               	ldrsw	x4, [x1]
               	add	x8, x4, #0x1
               	str	w8, [x1]
               	str	w5, [x0, x4, lsl #2]
               	sub	x4, x29, #0x10
               	ldrsw	x8, [x4]
               	ldrsw	x5, [x1]
               	add	x9, x5, #0x1
               	str	w9, [x1]
               	str	w8, [x0, x5, lsl #2]
               	ldrsw	x5, [x1]
               	cmp	w5, #0x2
               	b.ne	<addr>
               	ldrsw	x5, [x0]
               	cmp	w5, #0x29
               	b.ne	<addr>
               	ldrsw	x5, [x0, #0x4]
               	cmp	w5, #0x28
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	str	w2, [x1]
               	stur	w6, [x29, #-0x10]
               	stur	w7, [x29, #-0x8]
               	ldrsw	x6, [x3]
               	ldrsw	x5, [x1]
               	add	x7, x5, #0x1
               	str	w7, [x1]
               	str	w6, [x0, x5, lsl #2]
               	ldrsw	x6, [x4]
               	ldrsw	x5, [x1]
               	add	x7, x5, #0x1
               	str	w7, [x1]
               	str	w6, [x0, x5, lsl #2]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x0, [x1]
               	cmp	w0, #0x2
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x5, [x0]
               	cmp	w5, #0x29
               	b.ne	<addr>
               	ldrsw	x5, [x0, #0x4]
               	cmp	w5, #0x28
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	str	w2, [x1]
               	mov	x5, #0x14               // =20
               	stur	w5, [x29, #-0x10]
               	mov	x6, #0x15               // =21
               	stur	w6, [x29, #-0x8]
               	ldrsw	x3, [x3]
               	ldrsw	x2, [x1]
               	add	x7, x2, #0x1
               	str	w7, [x1]
               	str	w3, [x0, x2, lsl #2]
               	ldrsw	x3, [x4]
               	ldrsw	x2, [x1]
               	add	x4, x2, #0x1
               	str	w4, [x1]
               	str	w3, [x0, x2, lsl #2]
               	ldrsw	x2, [x1]
               	cmp	w2, #0x2
               	b.ne	<addr>
               	ldrsw	x2, [x0]
               	cmp	w2, #0x15
               	b.ne	<addr>
               	ldrsw	x2, [x0, #0x4]
               	cmp	w2, #0x14
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	mov	x3, #0x0                // =0
               	str	w3, [x1]
               	stur	w5, [x29, #-0x10]
               	stur	w6, [x29, #-0x8]
               	sub	x2, x29, #0x8
               	ldrsw	x4, [x2]
               	ldrsw	x2, [x1]
               	add	x5, x2, #0x1
               	str	w5, [x1]
               	str	w4, [x0, x2, lsl #2]
               	sub	x2, x29, #0x10
               	ldrsw	x4, [x2]
               	ldrsw	x2, [x1]
               	add	x5, x2, #0x1
               	str	w5, [x1]
               	str	w4, [x0, x2, lsl #2]
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
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	mov	x0, x3
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
