
bool_normalize_c99.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xa0
               	mov	x0, #0x3                // =3
               	stur	w0, [x29, #-0x30]
               	sub	x0, x29, #0x30
               	cmp	x0, #0x0
               	cset	x0, ne
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	mov	x1, #0x0                // =0
               	fmov	d16, x0
               	fmov	d17, x1
               	fcmp	d16, d17
               	cset	x0, ne
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	fmov	d16, x0
               	fmov	d17, x0
               	fcmp	d16, d17
               	cset	x0, ne
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x58
               	mov	x1, #0x1                // =1
               	strb	w1, [x0]
               	sub	x0, x29, #0x58
               	mov	x1, #0x7                // =7
               	str	w1, [x0, #0x4]
               	sub	x0, x29, #0x58
               	mov	x1, #0x0                // =0
               	strb	w1, [x0, #0x8]
               	sub	x0, x29, #0x58
               	ldrb	w0, [x0]
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x58
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x58
               	ldrb	w0, [x0, #0x8]
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x60
               	mov	x2, #0x0                // =0
               	mov	x0, #0x1                // =1
               	strb	w0, [x1]
               	sub	x1, x29, #0x60
               	strb	w2, [x1, #0x1]
               	sub	x1, x29, #0x60
               	strb	w0, [x1, #0x2]
               	sub	x1, x29, #0x60
               	ldrb	w1, [x1]
               	cmp	x1, #0x1
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x60
               	ldrb	w0, [x0, #0x1]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x60
               	ldrb	w0, [x0, #0x2]
               	cmp	x0, #0x1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
