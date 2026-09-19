
range_minmax_constant_p_sign.aarch64:	file format elf64-littleaarch64

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
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x0, #0x2710             // =10000
               	str	w0, [x5]
               	ldrsw	x0, [x5]
               	mov	x1, #0x0                // =0
               	cmp	w0, #0x0
               	b.le	<addr>
               	sxtw	x2, w0
               	mov	x3, #0x1000             // =4096
               	cmp	x2, x3
               	b.lo	<addr>
               	mov	x2, x3
               	mov	w2, w2
               	add	x1, x1, x2
               	sub	x0, x0, x2
               	cmp	w0, #0x0
               	b.gt	<addr>
               	mov	x17, #0x2710            // =10000
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x1                // =1
               	str	w0, [x5]
               	ldrsw	x0, [x5]
               	mov	x1, #0x0                // =0
               	cmp	w0, #0x0
               	b.le	<addr>
               	sxtw	x2, w0
               	mov	x3, #0x1000             // =4096
               	cmp	x2, x3
               	b.lo	<addr>
               	mov	x2, x3
               	mov	w2, w2
               	add	x1, x1, x2
               	sub	x0, x0, x2
               	cmp	w0, #0x0
               	b.gt	<addr>
               	cmp	x1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x1, #0x0                // =0
               	str	w1, [x5]
               	ldrsw	x0, [x5]
               	cmp	w0, #0x0
               	b.le	<addr>
               	sxtw	x2, w0
               	mov	x3, #0x1000             // =4096
               	cmp	x2, x3
               	b.lo	<addr>
               	mov	x2, x3
               	mov	w2, w2
               	add	x1, x1, x2
               	sub	x0, x0, x2
               	cmp	w0, #0x0
               	b.gt	<addr>
               	cbz	x1, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x0                // =0
               	ret
