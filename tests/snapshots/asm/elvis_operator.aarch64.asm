
elvis_operator.aarch64:	file format elf64-littleaarch64

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
               	mov	x1, #0x0                // =0
               	stur	w1, [x29, #-0x10]
               	mov	x2, #0x5                // =5
               	stur	w2, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x8]
               	cbz	x0, <addr>
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x10]
               	cbz	x0, <addr>
               	cmp	x0, #0x63
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	w1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x3, [x0]
               	add	x3, x3, #0x1
               	str	w3, [x0]
               	mov	x3, #0x7                // =7
               	mov	x0, x3
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	w1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x64               // =100
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	cbz	x0, <addr>
               	ldrsb	x0, [x0]
               	cmp	x0, #0x78
               	b.eq	<addr>
               	mov	x0, x2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldursw	x0, [x29, #-0x10]
               	cbz	x0, <addr>
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, x3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x10]
               	cbz	x0, <addr>
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x100000000        // =4294967296
               	ldursw	x0, [x29, #-0x8]
               	cbz	x0, <addr>
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x10]
               	cbz	x0, <addr>
               	mov	x17, #0x100000000       // =4294967296
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x1
               	b	<addr>
               	mov	x0, x1
               	b	<addr>
               	ldursw	x0, [x29, #-0x8]
               	cbz	x0, <addr>
               	b	<addr>
               	mov	x0, #0x63               // =99
               	b	<addr>
               	ldursw	x0, [x29, #-0x10]
               	cbz	x0, <addr>
               	b	<addr>
               	ldursw	x0, [x29, #-0x8]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	b	<addr>
               	mov	x0, #0x63               // =99
               	b	<addr>
               	mov	x0, #0x63               // =99
               	b	<addr>
