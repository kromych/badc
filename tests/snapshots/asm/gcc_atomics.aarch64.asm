
gcc_atomics.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x10
               	mov	x0, #0xa                // =10
               	stur	w0, [x29, #-0x10]
               	sub	x0, x29, #0x10
               	ldar	w1, [x0]
               	cmp	w1, #0xa
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	cbnz	w2, <addr>
               	mov	x2, #0x1                // =1
               	str	w2, [x1]
               	mov	x1, #0x14               // =20
               	stlr	w1, [x0]
               	ldursw	x1, [x29, #-0x10]
               	cmp	w1, #0x14
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	cbnz	w2, <addr>
               	mov	x2, #0x2                // =2
               	str	w2, [x1]
               	mov	x1, #0x1e               // =30
               	swpal	w1, w1, [x0]
               	cmp	w1, #0x14
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	cbnz	w2, <addr>
               	mov	x2, #0x3                // =3
               	str	w2, [x1]
               	ldursw	x1, [x29, #-0x10]
               	cmp	w1, #0x1e
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	cbnz	w2, <addr>
               	mov	x2, #0x4                // =4
               	str	w2, [x1]
               	mov	x1, #0x64               // =100
               	stur	w1, [x29, #-0x10]
               	mov	x1, #0x5                // =5
               	ldaddal	w1, w2, [x0]
               	cmp	w2, #0x64
               	b.ne	<addr>
               	ldursw	x2, [x29, #-0x10]
               	cmp	w2, #0x69
               	b.eq	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x3, [x2]
               	cbnz	w3, <addr>
               	str	w1, [x2]
               	neg	x16, x1
               	ldaddal	w16, w1, [x0]
               	cmp	w1, #0x69
               	b.ne	<addr>
               	ldursw	x1, [x29, #-0x10]
               	cmp	w1, #0x64
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	cbnz	w2, <addr>
               	mov	x2, #0x6                // =6
               	str	w2, [x1]
               	mov	x1, #0xf0               // =240
               	stur	w1, [x29, #-0x10]
               	mov	x1, #0x3c               // =60
               	mvn	x16, x1
               	ldclral	w16, w1, [x0]
               	cmp	w1, #0xf0
               	b.ne	<addr>
               	ldursw	x1, [x29, #-0x10]
               	cmp	w1, #0x30
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	cbnz	w2, <addr>
               	mov	x2, #0x7                // =7
               	str	w2, [x1]
               	mov	x1, #0xf                // =15
               	ldsetal	w1, w0, [x0]
               	cmp	w0, #0x30
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x10]
               	cmp	w0, #0x3f
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	cbnz	w1, <addr>
               	mov	x1, #0x8                // =8
               	str	w1, [x0]
               	sub	x1, x29, #0x10
               	mov	x0, #0xff               // =255
               	ldeoral	w0, w0, [x1]
               	cmp	w0, #0x3f
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x10]
               	cmp	w0, #0xc0
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	cbnz	w2, <addr>
               	mov	x2, #0x9                // =9
               	str	w2, [x0]
               	mov	x0, #0x7                // =7
               	stur	w0, [x29, #-0x10]
               	mov	x2, #0x8                // =8
               	mov	x3, x0
               	casal	w3, w2, [x1]
               	cmp	w3, #0x7
               	cset	x2, eq
               	cmp	w2, #0x1
               	b.ne	<addr>
               	ldursw	x2, [x29, #-0x10]
               	cmp	w2, #0x8
               	b.eq	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x3, [x2]
               	cbnz	w3, <addr>
               	mov	x3, #0xa                // =10
               	str	w3, [x2]
               	mov	x3, #0x9                // =9
               	mov	x2, x0
               	casal	w2, w3, [x1]
               	cmp	w2, #0x7
               	cset	x3, eq
               	cbz	x3, <addr>
               	mov	x2, x0
               	cbnz	w3, <addr>
               	ldursw	x3, [x29, #-0x10]
               	cmp	w3, #0x8
               	b.ne	<addr>
               	cmp	w2, #0x8
               	b.eq	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x3, [x2]
               	cbnz	w3, <addr>
               	mov	x3, #0xb                // =11
               	str	w3, [x2]
               	mov	x2, #0x64               // =100
               	stur	w2, [x29, #-0x10]
               	ldaddal	w0, w2, [x1]
               	cmp	w2, #0x64
               	b.ne	<addr>
               	ldursw	x2, [x29, #-0x10]
               	cmp	w2, #0x6b
               	b.eq	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x3, [x2]
               	cbnz	w3, <addr>
               	mov	x3, #0xc                // =12
               	str	w3, [x2]
               	neg	x16, x0
               	ldaddal	w16, w0, [x1]
               	sub	x0, x0, #0x7
               	cmp	w0, #0x64
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x10]
               	cmp	w0, #0x64
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	cbnz	w1, <addr>
               	mov	x1, #0xd                // =13
               	str	w1, [x0]
               	sub	x0, x29, #0x10
               	mov	x1, #0x1                // =1
               	ldaddal	w1, w1, [x0]
               	add	x1, x1, #0x1
               	cmp	w1, #0x65
               	b.ne	<addr>
               	ldursw	x1, [x29, #-0x10]
               	cmp	w1, #0x65
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	cbnz	w2, <addr>
               	mov	x2, #0xe                // =14
               	str	w2, [x1]
               	mov	x1, #0xcc               // =204
               	stur	w1, [x29, #-0x10]
               	mov	x1, #0x33               // =51
               	ldsetal	w1, w1, [x0]
               	cmp	w1, #0xcc
               	b.ne	<addr>
               	ldursw	x1, [x29, #-0x10]
               	cmp	w1, #0xff
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	cbnz	w2, <addr>
               	mov	x2, #0xf                // =15
               	str	w2, [x1]
               	mov	x1, #0xf                // =15
               	mvn	x16, x1
               	ldclral	w16, w2, [x0]
               	and	x1, x2, x1
               	cmp	w1, #0xf
               	b.ne	<addr>
               	ldursw	x1, [x29, #-0x10]
               	cmp	w1, #0xf
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	cbnz	w2, <addr>
               	mov	x2, #0x10               // =16
               	str	w2, [x1]
               	mov	x1, #0xff               // =255
               	ldeoral	w1, w2, [x0]
               	eor	x1, x2, x1
               	cmp	w1, #0xf0
               	b.ne	<addr>
               	ldursw	x1, [x29, #-0x10]
               	cmp	w1, #0xf0
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	cbnz	w2, <addr>
               	mov	x2, #0x11               // =17
               	str	w2, [x1]
               	mov	x1, #0x5                // =5
               	stur	w1, [x29, #-0x10]
               	mov	x2, #0x6                // =6
               	mov	x3, x1
               	casal	w3, w2, [x0]
               	cmp	w3, #0x5
               	b.ne	<addr>
               	ldursw	x3, [x29, #-0x10]
               	cmp	w3, #0x6
               	b.eq	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x4, [x3]
               	cbnz	w4, <addr>
               	mov	x4, #0x12               // =18
               	str	w4, [x3]
               	mov	x3, #0x7                // =7
               	casal	w1, w3, [x0]
               	cmp	w1, #0x6
               	b.ne	<addr>
               	ldursw	x1, [x29, #-0x10]
               	cmp	w1, #0x6
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x3, [x1]
               	cbnz	w3, <addr>
               	mov	x3, #0x13               // =19
               	str	w3, [x1]
               	mov	x1, #0x8                // =8
               	mov	x3, x2
               	casal	w3, w1, [x0]
               	cmp	w3, #0x6
               	cset	x0, eq
               	cmp	w0, #0x1
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x10]
               	cmp	w0, #0x8
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	cbnz	w1, <addr>
               	mov	x1, #0x14               // =20
               	str	w1, [x0]
               	sub	x0, x29, #0x10
               	mov	x1, #0x9                // =9
               	casal	w2, w1, [x0]
               	cmp	w2, #0x6
               	b.eq	<addr>
               	ldursw	x1, [x29, #-0x10]
               	cmp	w1, #0x8
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	cbnz	w2, <addr>
               	mov	x2, #0x15               // =21
               	str	w2, [x1]
               	mov	x1, #0x1                // =1
               	stur	w1, [x29, #-0x10]
               	mov	x2, #0x2                // =2
               	swpa	w2, w2, [x0]
               	cmp	w2, #0x1
               	b.ne	<addr>
               	ldursw	x2, [x29, #-0x10]
               	cmp	w2, #0x2
               	b.eq	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x3, [x2]
               	cbnz	w3, <addr>
               	mov	x3, #0x16               // =22
               	str	w3, [x2]
               	mov	x2, #0x0                // =0
               	stlr	w2, [x0]
               	ldursw	x0, [x29, #-0x10]
               	cbz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x3, [x0]
               	cbnz	w3, <addr>
               	mov	x3, #0x17               // =23
               	str	w3, [x0]
               	sturb	w2, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	swpalb	w1, w3, [x0]
               	and	x3, x3, #0xff
               	cbnz	w3, <addr>
               	ldurb	w3, [x29, #-0x8]
               	cbnz	w3, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x4, [x3]
               	cbnz	w4, <addr>
               	mov	x4, #0x18               // =24
               	str	w4, [x3]
               	swpalb	w1, w1, [x0]
               	and	x1, x1, #0xff
               	cbnz	w1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x3, [x1]
               	cbnz	w3, <addr>
               	mov	x3, #0x19               // =25
               	str	w3, [x1]
               	stlrb	w2, [x0]
               	ldurb	w0, [x29, #-0x8]
               	cbz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	cbnz	w1, <addr>
               	mov	x1, #0x1a               // =26
               	str	w1, [x0]
               	dmb	ish
               	dmb	ish
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
