
atomic_pointer_fetch_scales.aarch64:	file format elf64-littleaarch64

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
               	add	x1, x1, <lo12>
               	stur	x1, [x29, #-0x20]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	stur	x4, [x29, #-0x18]
               	stur	x1, [x29, #-0x10]
               	mov	x5, #0x5                // =5
               	stur	w5, [x29, #-0x8]
               	sub	x2, x29, #0x20
               	mov	x0, #0x4                // =4
               	ldaddal	x0, x3, [x2]
               	cmp	x3, x1
               	b.ne	<addr>
               	ldar	x3, [x2]
               	sub	x3, x3, x1
               	cmp	x3, #0x4
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0x8                // =8
               	stadd	x3, [x2]
               	ldar	x7, [x2]
               	add	x6, x1, #0xc
               	cmp	x7, x6
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	neg	x16, x0
               	ldaddal	x16, x7, [x2]
               	cmp	x7, x6
               	b.ne	<addr>
               	ldar	x6, [x2]
               	add	x7, x1, #0x8
               	cmp	x6, x7
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	neg	x16, x3
               	staddl	x16, [x2]
               	ldar	x2, [x2]
               	cmp	x2, x1
               	b.eq	<addr>
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x18
               	mov	x6, #0x48               // =72
               	ldaddal	x6, x16, [x2]
               	ldar	x2, [x2]
               	add	x4, x4, #0x48
               	cmp	x2, x4
               	b.eq	<addr>
               	mov	x0, x5
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x8
               	mov	x4, #0x2                // =2
               	ldaddal	w4, w4, [x2]
               	cmp	w4, #0x5
               	b.ne	<addr>
               	mov	x4, #0x1                // =1
               	neg	x16, x4
               	ldaddal	w16, w4, [x2]
               	cmp	w4, #0x7
               	b.ne	<addr>
               	ldar	w2, [x2]
               	cmp	w2, #0x6
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x10
               	ldaddal	x0, x16, [x2]
               	ldur	x0, [x29, #-0x10]
               	sub	x0, x0, x1
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	mov	x1, #0x4                // =4
               	ldaddal	x1, x16, [x0]
               	ldar	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, #0x4
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, x3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
