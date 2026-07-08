
posix_unix_headers.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x240
               	sub	x2, x29, #0x80
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x1, x2, x1
               	mov	x3, #0x0                // =0
               	strb	w3, [x1]
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	sxtw	x1, w0
               	cmp	x1, #0x80
               	b.lt	<addr>
               	sub	x0, x29, #0x80
               	add	x0, x0, #0x0
               	ldrb	w1, [x0]
               	mov	x17, #0x8               // =8
               	orr	x1, x1, x17
               	strb	w1, [x0]
               	sub	x0, x29, #0x80
               	ldrb	w1, [x0, #0x5]
               	mov	x17, #0x1               // =1
               	orr	x1, x1, x17
               	strb	w1, [x0, #0x5]
               	sub	x0, x29, #0x80
               	add	x0, x0, #0x0
               	ldrb	w0, [x0]
               	mov	x17, #0x8               // =8
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x80
               	ldrb	w0, [x0, #0x5]
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x240
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x80
               	add	x0, x0, #0x0
               	ldrb	w0, [x0]
               	mov	x17, #0x10              // =16
               	and	x0, x0, x17
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x240
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x80
               	add	x0, x0, #0x0
               	ldrb	w1, [x0]
               	mov	x17, #0xfff7            // =65527
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x2, x1, x17
               	strb	w2, [x0]
               	sub	x0, x29, #0x80
               	add	x0, x0, #0x0
               	ldrb	w0, [x0]
               	mov	x17, #0x8               // =8
               	and	x0, x0, x17
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x240
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x230
               	mov	x1, #0x78               // =120
               	strb	w1, [x0]
               	sub	x0, x29, #0x230
               	mov	x1, #0x79               // =121
               	strb	w1, [x0, #0x41]
               	sub	x0, x29, #0x230
               	ldrb	w0, [x0]
               	mov	x17, #0x78              // =120
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x230
               	ldrb	w0, [x0, #0x41]
               	mov	x17, #0x79              // =121
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x240
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x240
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
