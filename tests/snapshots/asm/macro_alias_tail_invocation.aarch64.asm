
macro_alias_tail_invocation.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<main>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	cbz	x1, <addr>
               	mov	x2, #0xb                // =11
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x3, [x1]
               	add	x3, x3, #0x1
               	str	w3, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	w2, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	x1, #0x1
               	cset	x1, ne
               	cbnz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	x1, #0xb
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldrsw	x1, [x0]
               	cbz	x1, <addr>
               	mov	x2, #0x16               // =22
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x3, [x1]
               	add	x3, x3, #0x1
               	str	w3, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	w2, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	x1, #0x2
               	cset	x1, ne
               	cbnz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	x1, #0x16
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldrsw	x1, [x0]
               	cbz	x1, <addr>
               	mov	x2, #0x21               // =33
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x3, [x1]
               	add	x3, x3, #0x1
               	str	w3, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	w2, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	x1, #0x3
               	cset	x1, ne
               	cbnz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	x1, #0x21
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x1, #0x0                // =0
               	str	w1, [x0]
               	sxtw	x0, w1
               	cbz	x0, <addr>
               	mov	x1, #0x2c               // =44
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	w1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x3
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x21
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
