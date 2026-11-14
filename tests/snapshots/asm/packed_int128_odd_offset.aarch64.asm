
packed_int128_odd_offset.aarch64:	file format elf64-littleaarch64

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
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	cbz	x2, <addr>
               	ldr	x2, [x0]
               	ldr	x3, [x0, #0x8]
               	add	x1, x2, #0x1
               	cmp	x1, x2
               	cset	x2, lo
               	add	x2, x3, x2
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	cmp	w1, #0xc
               	b.ne	<addr>
               	cmp	x2, #0x3
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	add	x3, x1, #0x1
               	cmp	x3, x1
               	cset	x1, lo
               	add	x1, x2, x1
               	str	x3, [x0]
               	str	x1, [x0, #0x8]
               	cmp	w3, #0xd
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ret
               	mov	x1, #0xa                // =10
               	mov	x2, #0xe                // =14
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x10]
               	adrp	x1, <addr>
               	ldrb	w1, [x1, #0x1e]
               	add	x0, x0, x1
               	ret
               	cmp	x1, #0xb
               	b.ne	<addr>
               	mov	x0, #0x6                // =6
               	ret
