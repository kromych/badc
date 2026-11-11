
named_data_section_bounds.aarch64:	file format elf64-littleaarch64

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
               	mov	x1, #0x0                // =0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x2, x1
               	mov	x3, x1
               	cmp	x0, x4
               	b.hs	<addr>
               	ldrsw	x5, [x0, #0x8]
               	ldr	x6, [x0]
               	ldrb	w6, [x6, #0x1]
               	mov	x7, #0x3e8              // =1000
               	cmp	w6, #0x0
               	csel	x6, x7, x1, ne
               	add	x5, x5, x6
               	add	x3, x3, x5
               	add	x0, x0, #0x10
               	add	x2, x2, #0x1
               	cmp	x0, x4
               	b.lo	<addr>
               	cmp	w2, #0x3
               	b.ne	<addr>
               	cmp	w3, #0x141
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x2, x0, x1
               	asr	x3, x2, #63
               	add	x2, x2, x3, lsr #62
               	asr	x2, x2, #2
               	cmp	x2, #0x2
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	cmp	x2, x1
               	b.lo	<addr>
               	cmp	x2, x0
               	b.hs	<addr>
               	cmp	x3, x1
               	b.lo	<addr>
               	cmp	x3, x0
               	b.hs	<addr>
               	ldrsw	x0, [x2]
               	cbnz	w0, <addr>
               	ldrsw	x0, [x3]
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x18]
               	adrp	x1, <page>
               	ldrsw	x1, [x1, #0x20]
               	add	x0, x0, x1
               	adrp	x1, <page>
               	ldrsw	x1, [x1, #0x50]
               	add	x0, x0, x1
               	mov	x1, #0x0                // =0
               	mov	x2, #0x4                // =4
               	cmp	w0, #0x3
               	csel	x0, x1, x2, eq
               	ret
