
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
               	sub	sp, sp, #0x20
               	adrp	x1, <page>
               	str	wzr, [x1, #0x130]
               	mov	x5, #0x1                // =1
               	stur	w5, [x29, #-0x18]
               	mov	x0, #0x2                // =2
               	stur	w0, [x29, #-0x10]
               	mov	x2, #0x3                // =3
               	stur	w2, [x29, #-0x8]
               	mov	x6, #0x3                // =3
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x4, [x1, #0x130]
               	add	x7, x4, #0x1
               	str	w7, [x1, #0x130]
               	str	w6, [x2, x4, lsl #2]
               	ldursw	x6, [x29, #-0x10]
               	ldrsw	x4, [x1, #0x130]
               	add	x7, x4, #0x1
               	str	w7, [x1, #0x130]
               	str	w6, [x2, x4, lsl #2]
               	ldursw	x6, [x29, #-0x18]
               	ldrsw	x4, [x1, #0x130]
               	add	x7, x4, #0x1
               	str	w7, [x1, #0x130]
               	str	w6, [x2, x4, lsl #2]
               	ldrsw	x4, [x1, #0x130]
               	cmp	w4, #0x3
               	b.ne	<addr>
               	ldrsw	x4, [x2]
               	cmp	w4, #0x3
               	b.ne	<addr>
               	ldrsw	x4, [x2, #0x4]
               	cmp	w4, #0x2
               	b.ne	<addr>
               	ldrsw	x4, [x2, #0x8]
               	cmp	w4, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	str	wzr, [x1, #0x130]
               	adrp	x4, <page>
               	str	w5, [x4, #0x138]
               	stur	wzr, [x29, #-0x8]
               	ldrsw	x5, [x4, #0x138]
               	str	wzr, [x4, #0x138]
               	mov	x4, #0x2bc              // =700
               	ldrsw	x3, [x1, #0x130]
               	add	x6, x3, #0x1
               	str	w6, [x1, #0x130]
               	str	w4, [x2, x3, lsl #2]
               	cmp	w5, #0x1
               	b.eq	<addr>
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	ldrsw	x0, [x1, #0x130]
               	cmp	w0, #0x1
               	b.ne	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x0, [x2]
               	cmp	w0, #0x2bc
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	str	w0, [x1, #0x130]
               	mov	x3, #0x32               // =50
               	stur	w3, [x29, #-0x18]
               	stur	w0, [x29, #-0x8]
               	cmp	w0, #0x1
               	b.ne	<addr>
               	ldursw	x4, [x29, #-0x8]
               	ldrsw	x3, [x1, #0x130]
               	add	x5, x3, #0x1
               	str	w5, [x1, #0x130]
               	str	w4, [x2, x3, lsl #2]
               	b	<addr>
               	cmp	w0, #0x2
               	b.eq	<addr>
               	ldursw	x4, [x29, #-0x8]
               	ldrsw	x3, [x1, #0x130]
               	add	x5, x3, #0x1
               	str	w5, [x1, #0x130]
               	str	w4, [x2, x3, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	ldursw	x2, [x29, #-0x18]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x130]
               	add	x4, x1, #0x1
               	str	w4, [x0, #0x130]
               	str	w2, [x3, x1, lsl #2]
               	ldrsw	x0, [x0, #0x130]
               	cmp	w0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x0, [x1]
               	cbnz	w0, <addr>
               	ldrsw	x0, [x1, #0x4]
               	cmp	w0, #0x1
               	b.ne	<addr>
               	ldrsw	x0, [x1, #0x8]
               	cmp	w0, #0x2
               	b.ne	<addr>
               	ldrsw	x0, [x1, #0xc]
               	cmp	w0, #0x32
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	str	wzr, [x0, #0x130]
               	mov	x3, #0xa                // =10
               	stur	w3, [x29, #-0x18]
               	mov	x4, #0xb                // =11
               	stur	w4, [x29, #-0x10]
               	mov	x5, #0xc                // =12
               	stur	w5, [x29, #-0x8]
               	mov	x7, #0xc                // =12
               	ldrsw	x6, [x0, #0x130]
               	add	x8, x6, #0x1
               	str	w8, [x0, #0x130]
               	str	w7, [x1, x6, lsl #2]
               	ldursw	x7, [x29, #-0x10]
               	ldrsw	x6, [x0, #0x130]
               	add	x8, x6, #0x1
               	str	w8, [x0, #0x130]
               	str	w7, [x1, x6, lsl #2]
               	ldursw	x7, [x29, #-0x18]
               	ldrsw	x6, [x0, #0x130]
               	add	x8, x6, #0x1
               	str	w8, [x0, #0x130]
               	str	w7, [x1, x6, lsl #2]
               	ldrsw	x6, [x0, #0x130]
               	cmp	w6, #0x3
               	b.ne	<addr>
               	ldrsw	x6, [x1]
               	cmp	w6, #0xc
               	b.ne	<addr>
               	ldrsw	x6, [x1, #0x4]
               	cmp	w6, #0xb
               	b.ne	<addr>
               	ldrsw	x1, [x1, #0x8]
               	cmp	w1, #0xa
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	str	wzr, [x0, #0x130]
               	stur	w3, [x29, #-0x18]
               	stur	w4, [x29, #-0x10]
               	stur	w5, [x29, #-0x8]
               	mov	x3, #0xc                // =12
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x0, #0x130]
               	add	x4, x2, #0x1
               	str	w4, [x0, #0x130]
               	str	w3, [x1, x2, lsl #2]
               	ldursw	x3, [x29, #-0x10]
               	ldrsw	x2, [x0, #0x130]
               	add	x4, x2, #0x1
               	str	w4, [x0, #0x130]
               	str	w3, [x1, x2, lsl #2]
               	ldursw	x3, [x29, #-0x18]
               	adrp	x0, <page>
               	ldrsw	x2, [x0, #0x130]
               	add	x4, x2, #0x1
               	str	w4, [x0, #0x130]
               	str	w3, [x1, x2, lsl #2]
               	ldrsw	x2, [x0, #0x130]
               	cmp	w2, #0x3
               	b.ne	<addr>
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
               	str	wzr, [x0, #0x130]
               	mov	x3, #0x28               // =40
               	stur	w3, [x29, #-0x20]
               	mov	x4, #0x29               // =41
               	stur	w4, [x29, #-0x8]
               	mov	x6, #0x29               // =41
               	ldrsw	x5, [x0, #0x130]
               	add	x7, x5, #0x1
               	str	w7, [x0, #0x130]
               	str	w6, [x1, x5, lsl #2]
               	ldursw	x6, [x29, #-0x20]
               	ldrsw	x5, [x0, #0x130]
               	add	x7, x5, #0x1
               	str	w7, [x0, #0x130]
               	str	w6, [x1, x5, lsl #2]
               	ldrsw	x5, [x0, #0x130]
               	cmp	w5, #0x2
               	b.ne	<addr>
               	ldrsw	x5, [x1]
               	cmp	w5, #0x29
               	b.ne	<addr>
               	ldrsw	x5, [x1, #0x4]
               	cmp	w5, #0x28
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	str	wzr, [x0, #0x130]
               	stur	w3, [x29, #-0x20]
               	stur	w4, [x29, #-0x8]
               	mov	x4, #0x29               // =41
               	ldrsw	x3, [x0, #0x130]
               	add	x5, x3, #0x1
               	str	w5, [x0, #0x130]
               	str	w4, [x1, x3, lsl #2]
               	ldursw	x4, [x29, #-0x20]
               	adrp	x0, <page>
               	ldrsw	x3, [x0, #0x130]
               	add	x5, x3, #0x1
               	str	w5, [x0, #0x130]
               	str	w4, [x1, x3, lsl #2]
               	ldrsw	x1, [x0, #0x130]
               	cmp	w1, #0x2
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x3, [x1]
               	cmp	w3, #0x29
               	b.ne	<addr>
               	ldrsw	x3, [x1, #0x4]
               	cmp	w3, #0x28
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	str	wzr, [x0, #0x130]
               	mov	x3, #0x14               // =20
               	stur	w3, [x29, #-0x18]
               	mov	x4, #0x15               // =21
               	stur	w4, [x29, #-0x10]
               	mov	x6, #0x15               // =21
               	ldrsw	x5, [x0, #0x130]
               	add	x7, x5, #0x1
               	str	w7, [x0, #0x130]
               	str	w6, [x1, x5, lsl #2]
               	ldursw	x6, [x29, #-0x18]
               	ldrsw	x5, [x0, #0x130]
               	add	x7, x5, #0x1
               	str	w7, [x0, #0x130]
               	str	w6, [x1, x5, lsl #2]
               	ldrsw	x5, [x0, #0x130]
               	cmp	w5, #0x2
               	b.ne	<addr>
               	ldrsw	x5, [x1]
               	cmp	w5, #0x15
               	b.ne	<addr>
               	ldrsw	x5, [x1, #0x4]
               	cmp	w5, #0x14
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	str	wzr, [x0, #0x130]
               	stur	w3, [x29, #-0x18]
               	stur	w4, [x29, #-0x10]
               	mov	x3, #0x15               // =21
               	ldrsw	x2, [x0, #0x130]
               	add	x4, x2, #0x1
               	str	w4, [x0, #0x130]
               	str	w3, [x1, x2, lsl #2]
               	ldursw	x3, [x29, #-0x18]
               	ldrsw	x2, [x0, #0x130]
               	add	x4, x2, #0x1
               	str	w4, [x0, #0x130]
               	str	w3, [x1, x2, lsl #2]
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x130]
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
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x2, [x29, #-0x8]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x130]
               	add	x4, x1, #0x1
               	str	w4, [x0, #0x130]
               	str	w2, [x3, x1, lsl #2]
               	b	<addr>
