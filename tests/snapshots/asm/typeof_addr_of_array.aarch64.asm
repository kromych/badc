
typeof_addr_of_array.aarch64:	file format elf64-littleaarch64

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
               	add	x1, x0, #0x0
               	ldrsw	x2, [x1]
               	cmp	w2, #0xa
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldrsw	x2, [x0, #0x4]
               	cmp	w2, #0x14
               	b.ne	<addr>
               	ldrsw	x2, [x0, #0x8]
               	cmp	w2, #0x1e
               	b.ne	<addr>
               	ldrsw	x2, [x0, #0xc]
               	cmp	w2, #0x28
               	b.ne	<addr>
               	ldrsw	x1, [x1]
               	cmp	w1, #0xa
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	ldrsw	x1, [x0, #0x4]
               	cmp	w1, #0x14
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0x8]
               	cmp	w1, #0x1e
               	b.ne	<addr>
               	ldrsw	x0, [x0, #0xc]
               	cmp	w0, #0x28
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ret
