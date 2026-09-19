
section_attr_aligned_placement.aarch64:	file format elf64-littleaarch64

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

<page_buf_end>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x2, lsl #12   // =0x2000
               	ret

<main>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	and	x1, x0, #0xfff
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	and	x1, x4, #0x3f
               	cbz	x1, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	and	x1, x6, #0x3f
               	cbz	x1, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	and	x1, x2, #0xf
               	cbz	x1, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	and	x3, x1, #0xfff
               	cbz	x3, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	and	x3, x3, #0x1f
               	cbz	x3, <addr>
               	mov	x0, #0x6                // =6
               	ret
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	and	x3, x7, #0x7f
               	cbz	x3, <addr>
               	mov	x0, #0x7                // =7
               	ret
               	mov	x3, #0x1                // =1
               	strb	w3, [x0]
               	mov	x17, #0x1fff            // =8191
               	add	x5, x0, x17
               	mov	x3, #0x2                // =2
               	strb	w3, [x5]
               	mov	x3, #0x15               // =21
               	str	w3, [x4]
               	mov	x3, #0x3                // =3
               	strb	w3, [x1, #0xfff]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x8, #0x4                // =4
               	strb	w8, [x3, #0x9]
               	ldrb	w8, [x0]
               	ldrb	w5, [x5]
               	add	x5, x8, x5
               	cmp	w5, #0x3
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ret
               	ldrsw	x4, [x4]
               	ldrsw	x5, [x6]
               	add	x4, x4, x5
               	cmp	w4, #0x20
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ret
               	ldr	x4, [x2]
               	ldr	x2, [x2, #0x8]
               	add	x2, x4, x2
               	cmp	x2, #0x3
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ret
               	ldrb	w1, [x1, #0xfff]
               	eor	x1, x1, #0x3
               	cbz	w1, <addr>
               	mov	x0, #0xb                // =11
               	ret
               	ldrb	w1, [x3, #0x9]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x2, [x2]
               	add	x1, x1, x2
               	cmp	w1, #0xb
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ret
               	ldrsw	x1, [x7]
               	cmp	w1, #0x3
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	w1, #0x5
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ret
               	add	x1, x0, #0x2, lsl #12   // =0x2000
               	cmp	x1, x1
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ret
               	mov	x0, #0x0                // =0
               	ret
