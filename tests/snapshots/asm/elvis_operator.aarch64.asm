
elvis_operator.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	add	x2, x2, #0x1
               	str	w2, [x1]
               	sxtw	x0, w0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xc0
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x8]
               	mov	x0, #0x5                // =5
               	stur	w0, [x29, #-0x10]
               	ldursw	x0, [x29, #-0x10]
               	cbz	x0, <addr>
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x8]
               	cbz	x0, <addr>
               	cmp	x0, #0x63
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	str	w1, [x0]
               	mov	x0, #0x7                // =7
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	cmp	x0, #0x7
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	str	w0, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	cmp	x0, #0x64
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	cbz	x0, <addr>
               	ldrsb	x0, [x0]
               	cmp	x0, #0x78
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsb	x0, [x0]
               	cmp	x0, #0x75
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x8]
               	cbz	x0, <addr>
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x8]
               	cbz	x0, <addr>
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x100000000        // =4294967296
               	ldursw	x0, [x29, #-0x10]
               	cbz	x0, <addr>
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x8]
               	cbz	x0, <addr>
               	mov	x17, #0x100000000       // =4294967296
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x1
               	b	<addr>
               	mov	x0, x1
               	b	<addr>
               	ldursw	x0, [x29, #-0x10]
               	cbz	x0, <addr>
               	b	<addr>
               	mov	x0, #0x63               // =99
               	b	<addr>
               	ldursw	x0, [x29, #-0x8]
               	cbz	x0, <addr>
               	b	<addr>
               	ldursw	x0, [x29, #-0x10]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x64               // =100
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x64               // =100
               	b	<addr>
               	mov	x0, #0x63               // =99
               	b	<addr>
               	mov	x0, #0x63               // =99
               	b	<addr>
