
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
               	str	wzr, [x0]
               	mov	x2, #0x1                // =1
               	str	w2, [x0]
               	mov	x2, #0x2                // =2
               	str	w2, [x0]
               	mov	x2, #0x3                // =3
               	str	w2, [x0]
               	ldrsw	x2, [x0]
               	cmp	w2, #0x3
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	str	wzr, [x0]
               	mov	x2, #0x1                // =1
               	str	w2, [x0]
               	mov	x2, #0x2                // =2
               	str	w2, [x0]
               	ldrsw	x2, [x0]
               	cmp	w2, #0x2
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	str	wzr, [x0]
               	mov	x2, #0x1                // =1
               	str	w2, [x0]
               	mov	x2, #0x2                // =2
               	str	w2, [x0]
               	mov	x2, #0x3                // =3
               	str	w2, [x0]
               	ldrsw	x2, [x0]
               	cmp	w2, #0x3
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	str	wzr, [x0]
               	mov	x1, #0x1                // =1
               	str	w1, [x0]
               	mov	x1, #0x2                // =2
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
