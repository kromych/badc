
atomic_rmw_ops.aarch64:	file format elf64-littleaarch64

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
               	mov	x4, #0xa                // =10
               	stur	x4, [x29, #-0x18]
               	sub	x1, x29, #0x18
               	mov	x0, #0x5                // =5
               	ldaddal	x0, x2, [x1]
               	cmp	x2, #0xa
               	b.ne	<addr>
               	ldur	x2, [x29, #-0x18]
               	cmp	x2, #0xf
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x3                // =3
               	neg	x16, x2
               	ldaddal	x16, x3, [x1]
               	cmp	x3, #0xf
               	b.ne	<addr>
               	ldur	x3, [x29, #-0x18]
               	cmp	x3, #0xc
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x5, #0xf0               // =240
               	mvn	x16, x5
               	ldclral	x16, x3, [x1]
               	cmp	x3, #0xc
               	b.ne	<addr>
               	ldur	x3, [x29, #-0x18]
               	cbz	x3, <addr>
               	mov	x0, x2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldsetal	x0, x2, [x1]
               	cbnz	x2, <addr>
               	ldur	x2, [x29, #-0x18]
               	cmp	x2, #0x5
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x6                // =6
               	ldeoral	x2, x3, [x1]
               	cmp	x3, #0x5
               	b.ne	<addr>
               	ldur	x3, [x29, #-0x18]
               	cmp	x3, #0x3
               	b.eq	<addr>
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0x63               // =99
               	swpal	x3, x6, [x1]
               	cmp	x6, #0x3
               	b.ne	<addr>
               	ldur	x6, [x29, #-0x18]
               	cmp	x6, #0x63
               	b.eq	<addr>
               	mov	x0, x2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x6, #0x7                // =7
               	casal	x3, x6, [x1]
               	cmp	x3, #0x63
               	cset	x3, eq
               	cbnz	w3, <addr>
               	mov	x0, x6
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x3, [x29, #-0x18]
               	cmp	x3, #0x7
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0x64               // =100
               	mov	x6, #0x0                // =0
               	mov	x7, x3
               	casal	x7, x6, [x1]
               	cmp	x7, #0x64
               	cset	x1, eq
               	cbz	x1, <addr>
               	cbz	x1, <addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x1, [x29, #-0x18]
               	cmp	x1, #0x7
               	b.ne	<addr>
               	cmp	x3, #0x7
               	b.eq	<addr>
               	mov	x0, x4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x4                // =4
               	stur	w1, [x29, #-0x10]
               	sub	x1, x29, #0x10
               	mov	x3, #0x1                // =1
               	ldaddal	w3, w3, [x1]
               	cmp	w3, #0x4
               	b.ne	<addr>
               	ldursw	x3, [x29, #-0x10]
               	cmp	w3, #0x5
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #-0x1               // =-1
               	casal	w0, w3, [x1]
               	cmp	w0, #0x5
               	cset	x0, eq
               	cbnz	w0, <addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x10]
               	mov	x17, #-0x1              // =-1
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xc                // =12
               	stur	w0, [x29, #-0x8]
               	sub	x1, x29, #0x8
               	mvn	x16, x5
               	ldclral	w16, w0, [x1]
               	cmp	w0, #0xc
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x8]
               	cbz	w0, <addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	ldsetal	w0, w0, [x1]
               	cbnz	w0, <addr>
               	ldursw	x0, [x29, #-0x8]
               	cmp	w0, #0x5
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldeoral	w2, w0, [x1]
               	cmp	w0, #0x5
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x8]
               	cmp	w0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x6
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, x7
               	b	<addr>
