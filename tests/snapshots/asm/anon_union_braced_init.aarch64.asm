
anon_union_braced_init.aarch64:	file format elf64-littleaarch64

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

<opaque>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	x0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x70]!
               	stp	x29, x30, [sp, #0x60]
               	add	x29, sp, #0x60
               	mov	x0, #0x7                // =7
               	stur	w0, [x29, #-0x20]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x18]
               	ldursw	x20, [x29, #-0x20]
               	ldur	x21, [x29, #-0x18]
               	sub	x0, x29, #0x10
               	str	w20, [x0]
               	str	wzr, [x0, #0x4]
               	str	x21, [x0, #0x8]
               	bl	<addr>
               	ldrsw	x1, [x0]
               	cmp	w1, w20
               	b.ne	<addr>
               	ldr	x0, [x0, #0x8]
               	cmp	x0, x21
               	b.ne	<addr>
               	mov	x2, #0x1                // =1
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	sub	x0, x29, #0x50
               	str	w2, [x0]
               	str	wzr, [x0, #0x4]
               	str	x3, [x0, #0x8]
               	bl	<addr>
               	ldrsw	x1, [x0]
               	cmp	w1, #0x1
               	b.ne	<addr>
               	ldr	x1, [x0, #0x8]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	cmp	x1, x2
               	b.ne	<addr>
               	ldr	x0, [x0, #0x8]
               	ldrsw	x0, [x0]
               	cmp	w0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	bl	<addr>
               	ldrsw	x1, [x0]
               	cmp	w1, #0x3
               	b.ne	<addr>
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x63
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x2, #0x5                // =5
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	sub	x0, x29, #0x30
               	str	w2, [x0]
               	str	wzr, [x0, #0x4]
               	str	x3, [x0, #0x8]
               	bl	<addr>
               	ldrsw	x1, [x0]
               	cmp	w1, #0x5
               	b.ne	<addr>
               	ldr	x0, [x0, #0x8]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x20, x21, [sp], #0x70
               	ret
