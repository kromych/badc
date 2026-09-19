
overaligned_type_placement.aarch64:	file format elf64-littleaarch64

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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	and	x0, x0, #0x3f
               	cbz	w0, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	and	x0, x1, #0x7f
               	cbz	w0, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	and	x0, x4, #0x3f
               	cbz	w0, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	and	x2, x0, #0x7f
               	cbz	w2, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	and	x2, x2, #0x3f
               	cbz	w2, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	and	x3, x2, #0x7f
               	cbz	w3, <addr>
               	mov	x0, #0x6                // =6
               	ret
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	and	x5, x3, #0x7f
               	cbz	w5, <addr>
               	mov	x0, #0x7                // =7
               	ret
               	mov	x5, #0xb                // =11
               	str	w5, [x1]
               	mov	x5, #0x16               // =22
               	str	w5, [x0]
               	mov	x5, #0x21               // =33
               	str	w5, [x2]
               	mov	x5, #0x2c               // =44
               	str	w5, [x3]
               	ldrsw	x1, [x1]
               	cmp	w1, #0xb
               	b.ne	<addr>
               	ldrsw	x1, [x0]
               	cmp	w1, #0x16
               	b.ne	<addr>
               	ldrsw	x1, [x2]
               	cmp	w1, #0x21
               	b.ne	<addr>
               	ldrsw	x1, [x3]
               	cmp	w1, #0x2c
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ret
               	ldrsw	x1, [x4]
               	cmp	w1, #0x1
               	b.ne	<addr>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x16
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ret
               	mov	x0, #0x0                // =0
               	ret
