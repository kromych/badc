
bool_normalize_c99.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	ret

<take_bool>:
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xa0
               	b	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x1                // =1
               	cmp	x2, #0x1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0x1                // =1
               	cmp	x3, #0x1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0x1                // =1
               	cmp	x3, #0x1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0x3                // =3
               	stur	w3, [x29, #-0x30]
               	sub	x3, x29, #0x30
               	cmp	x3, #0x0
               	cset	x3, ne
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	cmp	x3, #0x1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0x3fe0000000000000 // =4602678819172646912
               	mov	x4, #0x0                // =0
               	fmov	d16, x3
               	fmov	d17, x4
               	fcmp	d16, d17
               	cset	x3, ne
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	cmp	x3, #0x1
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0x0                // =0
               	fmov	d16, x3
               	fmov	d17, x3
               	fcmp	d16, d17
               	cset	x3, ne
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	cmp	x3, #0x0
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x58
               	mov	x4, #0x1                // =1
               	strb	w4, [x3]
               	sub	x3, x29, #0x58
               	mov	x4, #0x7                // =7
               	str	w4, [x3, #0x4]
               	sub	x3, x29, #0x58
               	mov	x4, #0x0                // =0
               	strb	w4, [x3, #0x8]
               	sub	x3, x29, #0x58
               	ldrb	w3, [x3]
               	cmp	x3, #0x1
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x58
               	ldrsw	x3, [x3, #0x4]
               	cmp	x3, #0x7
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x58
               	ldrb	w3, [x3, #0x8]
               	cmp	x3, #0x0
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0x2a               // =42
               	sxtw	x3, w3
               	cmp	x3, #0x0
               	cset	x3, ne
               	cmp	x3, #0x1
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0x0                // =0
               	sxtw	x3, w3
               	cmp	x3, #0x0
               	cset	x3, ne
               	cmp	x3, #0x0
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0x1                // =1
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	cmp	x3, #0x1
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x60
               	mov	x4, #0x0                // =0
               	mov	x6, #0x1                // =1
               	strb	w6, [x3]
               	sub	x3, x29, #0x60
               	strb	w4, [x3, #0x1]
               	sub	x3, x29, #0x60
               	strb	w6, [x3, #0x2]
               	sub	x3, x29, #0x60
               	ldrb	w3, [x3]
               	cmp	x3, #0x1
               	cset	x3, ne
               	cbnz	x3, <addr>
               	sub	x3, x29, #0x60
               	ldrb	w3, [x3, #0x1]
               	cmp	x3, #0x0
               	cset	x3, ne
               	cmp	x3, #0x0
               	cset	x6, ne
               	cbnz	x6, <addr>
               	sub	x3, x29, #0x60
               	ldrb	w3, [x3, #0x2]
               	cmp	x3, #0x1
               	cset	x6, ne
               	cbz	x6, <addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x0, x1
               	add	x0, x0, x2
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	mov	x1, #0x0                // =0
               	cmp	x0, #0x0
               	cset	x2, eq
               	cbnz	x2, <addr>
               	mov	x2, x1
               	cbz	x2, <addr>
               	mov	x0, #0x12               // =18
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
