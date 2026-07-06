
block_scope_extern.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldrsw	x1, [x0]
               	cmp	x1, #0x3
               	cset	x2, ne
               	cbnz	x2, <addr>
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x4
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	ldrsw	x2, [x0, #0x4]
               	add	x1, x1, x2
               	ldrsw	x0, [x0, #0x8]
               	add	x0, x1, x0
               	sxtw	x0, w0
               	cmp	x0, #0x3c
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x9                // =9
               	str	w1, [x0]
               	sxtw	x0, w1
               	cmp	x0, #0x9
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	ret
               	mov	x1, #0x5                // =5
               	b	<addr>
               	b	<addr>
