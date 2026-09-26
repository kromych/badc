
atomic_op_fetch.aarch64:	file format elf64-littleaarch64

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
               	mov	x2, #0xa                // =10
               	stur	w2, [x29, #-0x8]
               	sub	x1, x29, #0x8
               	mov	x3, #0x5                // =5
               	ldaddal	w3, w0, [x1]
               	add	x0, x0, #0x5
               	cmp	w0, #0xf
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	neg	x16, x0
               	ldaddal	w16, w4, [x1]
               	sub	x4, x4, #0x3
               	cmp	w4, #0xc
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x4, #0xf                // =15
               	mvn	x16, x4
               	ldclral	w16, w5, [x1]
               	and	x4, x5, x4
               	cmp	w4, #0xc
               	b.eq	<addr>
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x4, #0x1                // =1
               	ldsetal	w4, w5, [x1]
               	orr	x4, x5, x4
               	cmp	w4, #0xd
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldeoral	w0, w1, [x1]
               	eor	x0, x1, x0
               	cmp	w0, #0xe
               	b.eq	<addr>
               	mov	x0, x3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x8]
               	cmp	w0, #0xe
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x64               // =100
               	stur	x0, [x29, #-0x10]
               	sub	x1, x29, #0x10
               	mov	x0, #0x7                // =7
               	ldaddal	x0, x3, [x1]
               	add	x3, x3, #0x7
               	cmp	x3, #0x6b
               	b.eq	<addr>
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	neg	x16, x2
               	ldaddal	x16, x0, [x1]
               	sub	x0, x0, #0xa
               	cmp	x0, #0x61
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x10]
               	cmp	x0, #0x61
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
