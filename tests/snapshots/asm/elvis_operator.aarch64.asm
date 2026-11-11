
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
               	sub	sp, sp, #0x10
               	stur	wzr, [x29, #-0x10]
               	mov	x0, #0x5                // =5
               	stur	w0, [x29, #-0x8]
               	ldursw	x1, [x29, #-0x8]
               	cbz	x1, <addr>
               	cmp	w1, #0x5
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x1, [x29, #-0x10]
               	cbz	x1, <addr>
               	cmp	w1, #0x63
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	str	wzr, [x1, #0x30]
               	mov	x3, #0x1                // =1
               	str	w3, [x1, #0x30]
               	str	wzr, [x1, #0x30]
               	mov	x2, #0x1                // =1
               	str	w2, [x1, #0x30]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	cbz	x1, <addr>
               	ldrb	w1, [x1]
               	cmp	w1, #0x78
               	b.eq	<addr>
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x10]
               	cbz	x0, <addr>
               	cmp	w0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x10]
               	cbz	x0, <addr>
               	cmp	w0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x8]
               	cbz	x0, <addr>
               	cmp	w0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x10]
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x8]
               	mov	x1, #0x63               // =99
               	cmp	x0, #0x0
               	csel	x0, x0, x1, ne
               	b	<addr>
               	ldursw	x0, [x29, #-0x10]
               	cbnz	x0, <addr>
               	ldursw	x0, [x29, #-0x8]
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
