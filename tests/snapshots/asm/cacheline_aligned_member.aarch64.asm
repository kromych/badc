
cacheline_aligned_member.aarch64:	file format elf64-littleaarch64

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
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x2, x1, x1
               	mov	x0, #0x1                // =1
               	cbnz	x2, <addr>
               	add	x2, x1, #0x40
               	sub	x2, x2, x1
               	cmp	w2, #0x40
               	cset	x2, ne
               	cbnz	x2, <addr>
               	add	x2, x1, #0x44
               	sub	x1, x2, x1
               	cmp	w1, #0x44
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x8                // =8
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x1, x1, x1
               	cbnz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x1, x0, #0x40
               	sub	x0, x1, x0
               	cmp	w0, #0x40
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x1, x0, #0x80
               	sub	x0, x1, x0
               	cmp	w0, #0x80
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x1, x0, #0x40
               	sub	x0, x1, x0
               	cmp	w0, #0x40
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x1, x0, #0xc0
               	sub	x0, x1, x0
               	cmp	w0, #0xc0
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x17, #0x3f              // =63
               	and	x0, x0, x17
               	cmp	w0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x11               // =17
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x17, #0x3f              // =63
               	and	x0, x0, x17
               	cmp	w0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x12               // =18
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x17, #0x3f              // =63
               	and	x0, x0, x17
               	cmp	w0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x13               // =19
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x40
               	mov	x17, #0x3f              // =63
               	and	x0, x0, x17
               	cmp	w0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x14               // =20
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	lsl	x1, x0, #6
               	add	x2, x2, x1
               	mov	x17, #0x3f              // =63
               	and	x2, x2, x17
               	cmp	w2, #0x0
               	cset	x2, ne
               	sxtw	x2, w2
               	cbnz	x2, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	add	x1, x2, x1
               	mov	x17, #0x3f              // =63
               	and	x1, x1, x17
               	cmp	w1, #0x0
               	cset	x1, ne
               	sxtw	x1, w1
               	cbnz	x1, <addr>
               	sxtw	x0, w0
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xb                // =11
               	str	w1, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x21               // =33
               	str	w2, [x1, #0xc0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x2c               // =44
               	str	w2, [x1, #0x40]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x37               // =55
               	str	w2, [x1]
               	ldrsw	x0, [x0]
               	cmp	w0, #0xb
               	mov	x0, #0x1                // =1
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1, #0xc0]
               	cmp	w1, #0x21
               	cset	x1, ne
               	cbnz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x40]
               	cmp	w0, #0x2c
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x37
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x17               // =23
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	b	<addr>
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x0, #0x16               // =22
               	ret
               	mov	x0, #0x15               // =21
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
