
stringize_whitespace.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x2, x1
               	mov	x1, x0
               	b	<addr>
               	ldrb	w0, [x1]
               	mov	x4, #0x0                // =0
               	cbz	x0, <addr>
               	b	<addr>
               	add	x1, x1, #0x1
               	add	x2, x2, #0x1
               	b	<addr>
               	ldrb	w0, [x1]
               	cmp	x0, #0x0
               	cset	x0, eq
               	mov	x3, #0x0                // =0
               	cbz	x0, <addr>
               	b	<addr>
               	ldrb	w0, [x2]
               	cmp	x0, #0x0
               	cset	x4, ne
               	b	<addr>
               	cbz	x4, <addr>
               	ldrb	w0, [x1]
               	ldrb	w3, [x2]
               	cmp	x0, x3
               	cset	x4, eq
               	b	<addr>
               	cbz	x4, <addr>
               	b	<addr>
               	ldrb	w0, [x2]
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x3, ne
               	b	<addr>
               	mov	x0, x3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x0, <page>
               	add	x0, x0, #0xd0
               	adrp	x1, <page>
               	add	x1, x1, #0xd2
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0xd4
               	adrp	x1, <page>
               	add	x1, x1, #0xd6
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0xd8
               	adrp	x1, <page>
               	add	x1, x1, #0xdc
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0xe0
               	adrp	x1, <page>
               	add	x1, x1, #0xeb
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0xf6
               	adrp	x1, <page>
               	add	x1, x1, #0xfb
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x100
               	adrp	x1, <page>
               	add	x1, x1, #0x104
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x108
               	adrp	x1, <page>
               	add	x1, x1, #0x10d
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
