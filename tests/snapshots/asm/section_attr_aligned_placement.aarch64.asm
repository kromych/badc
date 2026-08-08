
section_attr_aligned_placement.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<page_buf_end>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x17, #0x2000            // =8192
               	add	x0, x0, x17
               	ret

<main>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x17, #0xfff             // =4095
               	and	x1, x0, x17
               	cmp	x1, #0x0
               	cset	x1, ne
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x17, #0x3f              // =63
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	cset	x1, ne
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x17, #0x3f              // =63
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	cset	x1, ne
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x17, #0xf               // =15
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	cset	x1, ne
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x17, #0xfff             // =4095
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	cset	x1, ne
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x17, #0x1f              // =31
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	cset	x1, ne
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	mov	x0, #0x6                // =6
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x17, #0x7f              // =127
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	cset	x1, ne
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	mov	x0, #0x7                // =7
               	ret
               	mov	x1, #0x1                // =1
               	strb	w1, [x0]
               	mov	x17, #0x1fff            // =8191
               	add	x1, x0, x17
               	mov	x2, #0x2                // =2
               	strb	w2, [x1]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, #0x15               // =21
               	str	w3, [x2]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, #0x3                // =3
               	strb	w3, [x2, #0xfff]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, #0x4                // =4
               	strb	w3, [x2, #0x9]
               	ldrb	w2, [x0]
               	ldrb	w1, [x1]
               	add	x1, x2, x1
               	sxtw	x1, w1
               	cmp	x1, #0x3
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x2, [x2]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	cmp	x1, #0x20
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x2, [x1]
               	ldr	x1, [x1, #0x8]
               	add	x1, x2, x1
               	cmp	x1, #0x3
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w1, [x1, #0xfff]
               	mov	x17, #0x3               // =3
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w1, [x1, #0x9]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x2, [x2]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	cmp	x1, #0xb
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	x1, #0x3
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	x1, #0x5
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ret
               	mov	x17, #0x2000            // =8192
               	add	x1, x0, x17
               	mov	x17, #0x2000            // =8192
               	add	x0, x0, x17
               	cmp	x1, x0
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ret
               	mov	x0, #0x0                // =0
               	ret
