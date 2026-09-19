
macro_alias_tail_invocation.aarch64:	file format elf64-littleaarch64

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
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x0, [x2]
               	cbz	x0, <addr>
               	mov	x1, #0xb                // =11
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x3, [x0]
               	add	x3, x3, #0x1
               	str	w3, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	w1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	cmp	w1, #0x1
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x3, [x1]
               	cmp	w3, #0xb
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldrsw	x3, [x2]
               	cbz	x3, <addr>
               	mov	x3, #0x16               // =22
               	ldrsw	x4, [x0]
               	add	x4, x4, #0x1
               	str	w4, [x0]
               	str	w3, [x1]
               	ldrsw	x3, [x0]
               	cmp	w3, #0x2
               	b.ne	<addr>
               	ldrsw	x3, [x1]
               	cmp	w3, #0x16
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldrsw	x3, [x2]
               	cbz	x3, <addr>
               	mov	x3, #0x21               // =33
               	ldrsw	x4, [x0]
               	add	x4, x4, #0x1
               	str	w4, [x0]
               	str	w3, [x1]
               	ldrsw	x3, [x0]
               	cmp	w3, #0x3
               	b.ne	<addr>
               	ldrsw	x3, [x1]
               	cmp	w3, #0x21
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x3, #0x0                // =0
               	str	w3, [x2]
               	ldrsw	x0, [x0]
               	cmp	w0, #0x3
               	b.ne	<addr>
               	ldrsw	x0, [x1]
               	cmp	w0, #0x21
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, x3
               	ret
