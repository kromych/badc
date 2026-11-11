
overaligned_bss_placement.aarch64:	file format elf64-littleaarch64

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
               	and	x1, x0, #0x3f
               	cbz	w1, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	and	x2, x1, #0x7f
               	cbz	w2, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	and	x3, x2, #0xff
               	cbz	w3, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x3, #0x1                // =1
               	strb	w3, [x0]
               	mov	x3, #0x2                // =2
               	strb	w3, [x1]
               	mov	x3, #0x3                // =3
               	strb	w3, [x2]
               	adrp	x4, <page>
               	mov	x3, #0x4                // =4
               	str	w3, [x4, #0x500]
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	add	x0, x0, x1
               	ldrb	w1, [x2]
               	add	x0, x0, x1
               	add	x0, x0, #0x4
               	mov	x1, #0x0                // =0
               	cmp	w0, #0xa
               	csel	x0, x1, x3, eq
               	ret
