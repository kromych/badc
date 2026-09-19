
flexible_array_member_2d.aarch64:	file format elf64-littleaarch64

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
               	ldrsw	x1, [x0]
               	cmp	w1, #0x3
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldrb	w1, [x0, #0x5]
               	eor	x1, x1, #0x7
               	cmp	w1, #0x0
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x7]
               	eor	x1, x1, #0xc
               	cmp	w1, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldrb	w1, [x0, #0xa]
               	eor	x1, x1, #0x1
               	cmp	w1, #0x0
               	b.ne	<addr>
               	ldrb	w1, [x0, #0xb]
               	mov	x17, #0x16              // =22
               	eor	x1, x1, x17
               	cmp	w1, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldrb	w1, [x0, #0xc]
               	eor	x1, x1, #0x1
               	cmp	w1, #0x0
               	b.ne	<addr>
               	ldrb	w1, [x0, #0xd]
               	mov	x17, #0x5               // =5
               	eor	x1, x1, x17
               	cmp	w1, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	ldrb	w0, [x0, #0xf]
               	mov	x17, #0xa               // =10
               	eor	x0, x0, x17
               	cmp	w0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x0                // =0
               	ret
