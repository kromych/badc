
zero_length_array.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x3                // =3
               	str	w1, [x0]
               	mov	x1, #0xa                // =10
               	strb	w1, [x0, #0x4]
               	mov	x1, #0x14               // =20
               	strb	w1, [x0, #0x5]
               	mov	x1, #0x1e               // =30
               	strb	w1, [x0, #0x6]
               	ldrsw	x1, [x0]
               	cmp	x1, #0x3
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldrb	w1, [x0, #0x4]
               	mov	x17, #0xa               // =10
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	cset	x2, ne
               	mov	x1, #0x1                // =1
               	cbnz	x2, <addr>
               	ldrb	w1, [x0, #0x5]
               	mov	x17, #0x14              // =20
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldrb	w1, [x0, #0x6]
               	mov	x17, #0x1e              // =30
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	add	x1, x0, #0x4
               	add	x0, x0, #0x4
               	cmp	x1, x0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	str	w1, [x0]
               	mov	x1, #0xab               // =171
               	strb	w1, [x0, #0x4]
               	mov	x1, #0xcd               // =205
               	strb	w1, [x0, #0x5]
               	ldrb	w1, [x0, #0x4]
               	mov	x17, #0xab              // =171
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldrb	w1, [x0, #0x5]
               	mov	x17, #0xcd              // =205
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	ldrh	w0, [x0, #0x4]
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	cmp	x0, #0xab
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
