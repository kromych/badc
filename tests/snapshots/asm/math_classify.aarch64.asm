
math_classify.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<main>:
               	mov	x1, #0x0                // =0
               	fmov	d16, x1
               	fmov	d17, x1
               	fdiv	d0, d16, d17
               	fmov	x2, d0
               	ubfx	x0, x2, #52, #11
               	and	x2, x2, #0xfffffffffffff
               	cbnz	w0, <addr>
               	cmp	x2, #0x0
               	mov	x16, #0x3               // =3
               	mov	x17, #0x2               // =2
               	csel	x3, x16, x17, ne
               	cbz	w3, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	cbnz	w0, <addr>
               	cmp	x2, #0x0
               	mov	x16, #0x3               // =3
               	mov	x17, #0x2               // =2
               	csel	x1, x16, x17, ne
               	cmp	w1, #0x1
               	b.ne	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	cbnz	w0, <addr>
               	cmp	x2, #0x0
               	mov	x16, #0x3               // =3
               	mov	x17, #0x2               // =2
               	csel	x0, x16, x17, ne
               	cbz	w0, <addr>
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ret
               	fmov	x0, d0
               	ubfx	x1, x0, #52, #11
               	and	x0, x0, #0xfffffffffffff
               	cbnz	w1, <addr>
               	cmp	x0, #0x0
               	mov	x16, #0x3               // =3
               	mov	x17, #0x2               // =2
               	csel	x0, x16, x17, ne
               	cbz	w0, <addr>
               	mov	x0, #0xc                // =12
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	cmp	w1, #0x7ff
               	b.ne	<addr>
               	cmp	x0, #0x0
               	mov	x17, #0x1               // =1
               	csel	x0, xzr, x17, ne
               	b	<addr>
               	cmp	w0, #0x7ff
               	b.ne	<addr>
               	cmp	x2, #0x0
               	mov	x17, #0x1               // =1
               	csel	x0, xzr, x17, ne
               	b	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	cmp	w0, #0x7ff
               	b.ne	<addr>
               	cmp	x2, #0x0
               	mov	x17, #0x1               // =1
               	csel	x1, x1, x17, ne
               	b	<addr>
               	cmp	w0, #0x7ff
               	b.ne	<addr>
               	cmp	x2, #0x0
               	mov	x17, #0x1               // =1
               	csel	x3, x1, x17, ne
               	b	<addr>
