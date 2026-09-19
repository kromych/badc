
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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x0, x0
               	cbnz	w1, <addr>
               	add	x1, x0, #0x40
               	sub	x1, x1, x0
               	cmp	w1, #0x40
               	b.ne	<addr>
               	add	x1, x0, #0x44
               	sub	x0, x1, x0
               	cmp	w0, #0x44
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x0, x0
               	cbnz	w1, <addr>
               	add	x1, x0, #0x40
               	sub	x1, x1, x0
               	cmp	w1, #0x40
               	b.ne	<addr>
               	add	x1, x0, #0x80
               	sub	x0, x1, x0
               	cmp	w0, #0x80
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x4, x0, #0x40
               	sub	x1, x4, x0
               	cmp	w1, #0x40
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ret
               	add	x5, x0, #0xc0
               	sub	x1, x5, x0
               	cmp	w1, #0xc0
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	and	x1, x2, #0x3f
               	cbz	x1, <addr>
               	mov	x0, #0x11               // =17
               	ret
               	cbz	x1, <addr>
               	mov	x0, #0x12               // =18
               	ret
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	and	x1, x6, #0x3f
               	cbz	x1, <addr>
               	mov	x0, #0x13               // =19
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x3, x1, #0x40
               	and	x3, x3, #0x3f
               	cbz	x3, <addr>
               	mov	x0, #0x14               // =20
               	ret
               	and	x3, x0, #0x3f
               	cbz	x3, <addr>
               	mov	x0, #0x15               // =21
               	ret
               	cbz	x3, <addr>
               	mov	x0, #0x16               // =22
               	ret
               	and	x3, x4, #0x3f
               	cbnz	x3, <addr>
               	cbnz	x3, <addr>
               	add	x4, x0, #0x80
               	and	x3, x4, #0x3f
               	cbnz	x3, <addr>
               	cbnz	x3, <addr>
               	and	x3, x5, #0x3f
               	cbnz	x3, <addr>
               	cbnz	x3, <addr>
               	mov	x3, #0xb                // =11
               	str	w3, [x2]
               	mov	x3, #0x21               // =33
               	str	w3, [x0, #0xc0]
               	mov	x3, #0x2c               // =44
               	str	w3, [x1, #0x40]
               	mov	x3, #0x37               // =55
               	str	w3, [x6]
               	ldrsw	x2, [x2]
               	cmp	w2, #0xb
               	b.ne	<addr>
               	ldrsw	x0, [x0, #0xc0]
               	cmp	w0, #0x21
               	b.ne	<addr>
               	ldrsw	x0, [x1, #0x40]
               	cmp	w0, #0x2c
               	b.ne	<addr>
               	ldrsw	x0, [x6]
               	cmp	w0, #0x37
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	ret
               	mov	x0, #0x0                // =0
               	ret
