
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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x2710             // =10000
               	str	w1, [x0]
               	ldrsw	x0, [x0]
               	mov	x2, #0x0                // =0
               	cmp	w0, #0x0
               	b.le	<addr>
               	mov	x1, #0x1000             // =4096
               	cmp	x0, x1
               	b.hs	<addr>
               	mov	x1, x0
               	add	x2, x2, x1
               	sub	x0, x0, x1
               	cmp	w0, #0x0
               	b.gt	<addr>
               	mov	x17, #0x2710            // =10000
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	str	w1, [x0]
               	ldrsw	x0, [x0]
               	mov	x2, #0x0                // =0
               	cmp	w0, #0x0
               	b.le	<addr>
               	mov	x1, #0x1000             // =4096
               	cmp	x0, x1
               	b.hs	<addr>
               	mov	x1, x0
               	add	x2, x2, x1
               	sub	x0, x0, x1
               	cmp	w0, #0x0
               	b.gt	<addr>
               	cmp	x2, #0x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x2, #0x0                // =0
               	str	w2, [x0]
               	ldrsw	x0, [x0]
               	cmp	w0, #0x0
               	b.le	<addr>
               	mov	x1, #0x1000             // =4096
               	cmp	x0, x1
               	b.hs	<addr>
               	mov	x1, x0
               	add	x2, x2, x1
               	sub	x0, x0, x1
               	cmp	w0, #0x0
               	b.gt	<addr>
               	cbz	x2, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x0                // =0
               	ret
