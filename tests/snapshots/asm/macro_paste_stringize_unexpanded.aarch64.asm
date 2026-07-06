
macro_paste_stringize_unexpanded.aarch64:	file format elf64-littleaarch64

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
               	mov	x1, #0x1                // =1
               	str	w1, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x1, #0x2                // =2
               	str	w1, [x2]
               	ldrsw	x0, [x0]
               	sxtw	x1, w1
               	add	x0, x0, x1
               	sxtw	x0, w0
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w1, [x0]
               	mov	x17, #0x56              // =86
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	cset	x1, ne
               	mov	x2, #0x1                // =1
               	cbnz	x1, <addr>
               	ldrb	w1, [x0, #0x1]
               	mov	x17, #0x41              // =65
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x2, ne
               	mov	x1, #0x1                // =1
               	cbnz	x2, <addr>
               	ldrb	w1, [x0, #0x2]
               	mov	x17, #0x4c              // =76
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldrb	w0, [x0, #0x3]
               	cmp	x0, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x4                // =4
               	ret
