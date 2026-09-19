
overaligned_data_placement.aarch64:	file format elf64-littleaarch64

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
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	and	x1, x0, #0x7f
               	cbz	x1, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	and	x1, x1, #0xff
               	cbz	x1, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	and	x1, x4, #0x3f
               	cbz	x1, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	and	x1, x5, #0x7f
               	cbz	x1, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	and	x2, x1, #0xff
               	cbz	x2, <addr>
               	mov	x0, #0x6                // =6
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	and	x2, x2, #0x3f
               	cbz	x2, <addr>
               	mov	x0, #0x7                // =7
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	and	x3, x2, #0x7f
               	cbz	x3, <addr>
               	mov	x0, #0x8                // =8
               	ret
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	and	x6, x3, #0xff
               	cbz	x6, <addr>
               	mov	x0, #0x9                // =9
               	ret
               	mov	x6, #0xb                // =11
               	str	w6, [x0]
               	mov	x7, #0x16               // =22
               	str	w7, [x1]
               	mov	x7, #0x21               // =33
               	str	w7, [x2]
               	mov	x7, #0x2c               // =44
               	str	w7, [x3]
               	ldrsw	x0, [x0]
               	cmp	w0, #0xb
               	b.ne	<addr>
               	ldrsw	x0, [x1]
               	cmp	w0, #0x16
               	b.ne	<addr>
               	ldrsw	x0, [x2]
               	cmp	w0, #0x21
               	b.ne	<addr>
               	ldrsw	x0, [x3]
               	cmp	w0, #0x2c
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ret
               	ldrsw	x0, [x4]
               	cmp	w0, #0x1
               	b.ne	<addr>
               	ldrsw	x0, [x5]
               	cmp	w0, #0x2
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x0, x6
               	ret
               	mov	x0, #0x0                // =0
               	ret
