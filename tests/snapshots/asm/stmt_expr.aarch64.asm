
stmt_expr.aarch64:	file format elf64-littleaarch64

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

<bump>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, x1
               	ret

<main>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	str	w1, [x0]
               	mov	x2, x1
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	mov	x3, x2
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	lsl	x2, x2, #1
               	add	x2, x3, x2
               	cmp	w2, #0x8
               	b.ne	<addr>
               	ldrsw	x2, [x0]
               	cmp	w2, #0x3
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	str	w1, [x0]
               	mov	x2, x1
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	mov	x3, x2
               	mov	x17, #0xa               // =10
               	mul	x3, x3, x17
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	mov	x17, #0x64              // =100
               	mul	x2, x2, x17
               	cmp	w3, #0xa
               	b.ne	<addr>
               	cmp	w2, #0xc8
               	b.ne	<addr>
               	ldrsw	x2, [x0]
               	cmp	w2, #0x2
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	str	w1, [x0]
               	mov	x2, x1
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	mov	x3, x2
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	add	x2, x3, x2
               	cmp	w2, #0x5
               	b.ne	<addr>
               	ldrsw	x2, [x0]
               	cmp	w2, #0x3
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	str	w1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	mov	x0, #0x0                // =0
               	ret
