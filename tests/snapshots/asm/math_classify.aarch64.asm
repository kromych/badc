
math_classify.aarch64:	file format elf64-littleaarch64

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
               	mov	x2, #0x0                // =0
               	fmov	d16, x2
               	fmov	d17, x2
               	fdiv	d0, d16, d17
               	fmov	x1, d0
               	ubfx	x0, x1, #52, #11
               	and	x1, x1, #0xfffffffffffff
               	cbnz	w0, <addr>
               	mov	x3, #0x2                // =2
               	mov	x4, #0x3                // =3
               	cmp	x1, #0x0
               	csel	x3, x4, x3, ne
               	cbz	w3, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	cbnz	w0, <addr>
               	mov	x2, #0x2                // =2
               	mov	x3, #0x3                // =3
               	cmp	x1, #0x0
               	csel	x2, x3, x2, ne
               	cmp	w2, #0x1
               	b.ne	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	cbnz	w0, <addr>
               	mov	x0, #0x2                // =2
               	mov	x2, #0x3                // =3
               	cmp	x1, #0x0
               	csel	x0, x2, x0, ne
               	cbz	w0, <addr>
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ret
               	fmov	x0, d0
               	ubfx	x1, x0, #52, #11
               	and	x0, x0, #0xfffffffffffff
               	cbnz	w1, <addr>
               	mov	x1, #0x2                // =2
               	mov	x2, #0x3                // =3
               	cmp	x0, #0x0
               	csel	x0, x2, x1, ne
               	cbz	w0, <addr>
               	mov	x0, #0xc                // =12
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	cmp	w1, #0x7ff
               	b.ne	<addr>
               	mov	x1, #0x1                // =1
               	mov	x2, #0x0                // =0
               	cmp	x0, #0x0
               	csel	x0, x2, x1, ne
               	b	<addr>
               	cmp	w0, #0x7ff
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	mov	x2, #0x0                // =0
               	cmp	x1, #0x0
               	csel	x0, x2, x0, ne
               	b	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	cmp	w0, #0x7ff
               	b.ne	<addr>
               	mov	x3, #0x1                // =1
               	cmp	x1, #0x0
               	csel	x2, x2, x3, ne
               	b	<addr>
               	cmp	w0, #0x7ff
               	b.ne	<addr>
               	mov	x3, #0x1                // =1
               	cmp	x1, #0x0
               	csel	x3, x2, x3, ne
               	b	<addr>
