
builtin_bit_count_edges.aarch64:	file format elf64-littleaarch64

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

<check32>:
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x0, [x1]
               	ldr	x4, [x1]
               	str	x0, [x1]
               	ldr	x6, [x1]
               	mov	w1, w0
               	clz	w5, w4
               	mov	x2, #0x0                // =0
               	mov	x3, #0x1f               // =31
               	sub	x3, x3, x2
               	lsr	x3, x1, x3
               	tbnz	w3, #0x0, <addr>
               	add	x2, x2, #0x1
               	cmp	w2, #0x20
               	b.lt	<addr>
               	cmp	w5, w2
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	rbit	w5, w4
               	clz	w5, w5
               	mov	x2, #0x0                // =0
               	lsr	x3, x1, x2
               	tbnz	w3, #0x0, <addr>
               	add	x2, x2, #0x1
               	cmp	w2, #0x20
               	b.lt	<addr>
               	cmp	w5, w2
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	fmov	s16, w4
               	cnt	v16.8b, v16.8b
               	addv	b16, v16.8b
               	fmov	w7, s16
               	mov	x2, #0x0                // =0
               	mov	x3, x2
               	lsr	x5, x1, x2
               	and	x5, x5, #0x1
               	add	x3, x3, x5
               	add	x2, x2, #0x1
               	cmp	w2, #0x20
               	b.lt	<addr>
               	cmp	w7, w3
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	lsl	x2, x6, #1
               	eor	x2, x6, x2
               	orr	x2, x2, #0x1
               	clz	w7, w2
               	lsr	x3, x1, #31
               	mov	x2, #0x0                // =0
               	mov	x5, #0x1e               // =30
               	sub	x5, x5, x2
               	lsr	x5, x1, x5
               	and	x5, x5, #0x1
               	cmp	w5, w3
               	b.ne	<addr>
               	add	x2, x2, #0x1
               	cmp	w2, #0x1f
               	b.lt	<addr>
               	cmp	w7, w2
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	rbit	w2, w6
               	clz	w2, w2
               	add	x3, x2, #0x1
               	lsr	x2, x2, #5
               	sub	x2, x2, #0x1
               	and	x5, x3, x2
               	mov	x2, #0x0                // =0
               	lsr	x3, x1, x2
               	tbnz	w3, #0x0, <addr>
               	add	x2, x2, #0x1
               	cmp	w2, #0x20
               	b.lt	<addr>
               	cmp	w2, #0x20
               	b.ne	<addr>
               	mov	x2, #0x0                // =0
               	cmp	w5, w2
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	fmov	s16, w4
               	cnt	v16.8b, v16.8b
               	addv	b16, v16.8b
               	fmov	w2, s16
               	and	x6, x2, #0x1
               	mov	x2, #0x0                // =0
               	mov	x3, x2
               	lsr	x5, x1, x2
               	and	x5, x5, #0x1
               	add	x3, x3, x5
               	add	x2, x2, #0x1
               	cmp	w2, #0x20
               	b.lt	<addr>
               	and	x2, x3, #0x1
               	cmp	w6, w2
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x0, [x2]
               	ldr	x2, [x2]
               	clz	w5, w2
               	mov	x2, #0x0                // =0
               	mov	x3, #0x1f               // =31
               	sub	x3, x3, x2
               	lsr	x3, x1, x3
               	tbnz	w3, #0x0, <addr>
               	add	x2, x2, #0x1
               	cmp	w2, #0x20
               	b.lt	<addr>
               	cmp	w5, w2
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x0, [x2]
               	ldr	x2, [x2]
               	rbit	w5, w2
               	clz	w5, w5
               	mov	x2, #0x0                // =0
               	lsr	x3, x1, x2
               	tbnz	w3, #0x0, <addr>
               	add	x2, x2, #0x1
               	cmp	w2, #0x20
               	b.lt	<addr>
               	cmp	w5, w2
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x0, [x2]
               	ldr	x0, [x2]
               	fmov	s16, w0
               	cnt	v16.8b, v16.8b
               	addv	b16, v16.8b
               	fmov	w5, s16
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	lsr	x3, x1, x0
               	and	x3, x3, #0x1
               	add	x2, x2, x3
               	add	x0, x0, #0x1
               	cmp	w0, #0x20
               	b.lt	<addr>
               	cmp	w5, w2
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ret
               	clz	w0, w4
               	sub	x3, x0, #0x21
               	mov	x0, #0x0                // =0
               	mov	x2, #0x1f               // =31
               	sub	x2, x2, x0
               	lsr	x2, x1, x2
               	tbnz	w2, #0x0, <addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x20
               	b.lt	<addr>
               	sub	x0, x0, #0x21
               	cmp	w3, w0
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ret
               	and	x0, x4, #0xffff
               	fmov	s16, w0
               	cnt	v16.8b, v16.8b
               	addv	b16, v16.8b
               	fmov	w6, s16
               	and	x3, x1, #0xffff
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	lsr	x5, x3, x0
               	and	x5, x5, #0x1
               	add	x2, x2, x5
               	add	x0, x0, #0x1
               	cmp	w0, #0x20
               	b.lt	<addr>
               	cmp	w6, w2
               	b.eq	<addr>
               	mov	x0, #0x19               // =25
               	ret
               	and	x0, x4, #0xffff
               	clz	w5, w0
               	and	x2, x1, #0xffff
               	mov	x0, #0x0                // =0
               	mov	x3, #0x1f               // =31
               	sub	x3, x3, x0
               	lsr	x3, x2, x3
               	tbnz	w3, #0x0, <addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x20
               	b.lt	<addr>
               	cmp	w5, w0
               	b.eq	<addr>
               	mov	x0, #0x1a               // =26
               	ret
               	clz	w0, w4
               	mov	x17, #0x4240            // =16960
               	movk	x17, #0xf, lsl #16
               	mul	x0, x0, x17
               	rbit	w2, w4
               	clz	w2, w2
               	mov	x17, #0x3e8             // =1000
               	mul	x2, x2, x17
               	add	x0, x0, x2
               	fmov	s16, w4
               	cnt	v16.8b, v16.8b
               	addv	b16, v16.8b
               	fmov	w2, s16
               	add	x4, x0, x2
               	mov	x0, #0x0                // =0
               	mov	x2, #0x1f               // =31
               	sub	x2, x2, x0
               	lsr	x2, x1, x2
               	tbnz	w2, #0x0, <addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x20
               	b.lt	<addr>
               	mov	x17, #0x4240            // =16960
               	movk	x17, #0xf, lsl #16
               	mul	x3, x0, x17
               	mov	x0, #0x0                // =0
               	lsr	x2, x1, x0
               	tbnz	w2, #0x0, <addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x20
               	b.lt	<addr>
               	mov	x17, #0x3e8             // =1000
               	mul	x0, x0, x17
               	add	x5, x3, x0
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	lsr	x3, x1, x0
               	and	x3, x3, #0x1
               	add	x2, x2, x3
               	add	x0, x0, #0x1
               	cmp	w0, #0x20
               	b.lt	<addr>
               	sxtw	x0, w2
               	add	x0, x5, x0
               	cmp	x4, x0
               	b.eq	<addr>
               	mov	x0, #0x1d               // =29
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	add	x2, x2, #0x1
               	b	<addr>

<check64>:
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x0, [x1]
               	ldr	x3, [x1]
               	str	x0, [x1]
               	ldr	x5, [x1]
               	clz	x4, x3
               	mov	x1, #0x0                // =0
               	mov	x2, #0x3f               // =63
               	sub	x2, x2, x1
               	lsr	x2, x0, x2
               	tbnz	w2, #0x0, <addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x40
               	b.lt	<addr>
               	cmp	w4, w1
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ret
               	rbit	x4, x3
               	clz	x4, x4
               	mov	x1, #0x0                // =0
               	lsr	x2, x0, x1
               	tbnz	w2, #0x0, <addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x40
               	b.lt	<addr>
               	cmp	w4, w1
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ret
               	fmov	d16, x3
               	cnt	v16.8b, v16.8b
               	addv	b16, v16.8b
               	fmov	w6, s16
               	mov	x1, #0x0                // =0
               	mov	x2, x1
               	lsr	x4, x0, x1
               	and	x4, x4, #0x1
               	add	x2, x2, x4
               	add	x1, x1, #0x1
               	cmp	w1, #0x40
               	b.lt	<addr>
               	cmp	w6, w2
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ret
               	lsl	x1, x5, #1
               	eor	x1, x5, x1
               	orr	x1, x1, #0x1
               	clz	x6, x1
               	lsr	x2, x0, #63
               	mov	x1, #0x0                // =0
               	mov	x4, #0x3e               // =62
               	sub	x4, x4, x1
               	lsr	x4, x0, x4
               	and	x4, x4, #0x1
               	cmp	w4, w2
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x3f
               	b.lt	<addr>
               	cmp	w6, w1
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ret
               	rbit	x1, x5
               	clz	x1, x1
               	add	x2, x1, #0x1
               	lsr	x1, x1, #6
               	sub	x1, x1, #0x1
               	and	x4, x2, x1
               	mov	x1, #0x0                // =0
               	lsr	x2, x0, x1
               	tbnz	w2, #0x0, <addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x40
               	b.lt	<addr>
               	cmp	w1, #0x40
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	cmp	w4, w1
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ret
               	fmov	d16, x3
               	cnt	v16.8b, v16.8b
               	addv	b16, v16.8b
               	fmov	w1, s16
               	and	x5, x1, #0x1
               	mov	x1, #0x0                // =0
               	mov	x2, x1
               	lsr	x4, x0, x1
               	and	x4, x4, #0x1
               	add	x2, x2, x4
               	add	x1, x1, #0x1
               	cmp	w1, #0x40
               	b.lt	<addr>
               	and	x1, x2, #0x1
               	cmp	w5, w1
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	ret
               	rbit	x1, x3
               	clz	x1, x1
               	sub	x4, x1, #0x41
               	mov	x1, #0x0                // =0
               	lsr	x2, x0, x1
               	tbnz	w2, #0x0, <addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x40
               	b.lt	<addr>
               	sub	x1, x1, #0x41
               	cmp	w4, w1
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	ret
               	mov	w1, w3
               	fmov	d16, x1
               	cnt	v16.8b, v16.8b
               	addv	b16, v16.8b
               	fmov	w6, s16
               	mov	w4, w0
               	mov	x1, #0x0                // =0
               	mov	x2, x1
               	lsr	x5, x4, x1
               	and	x5, x5, #0x1
               	add	x2, x2, x5
               	add	x1, x1, #0x1
               	cmp	w1, #0x40
               	b.lt	<addr>
               	cmp	w6, w2
               	b.eq	<addr>
               	mov	x0, #0x1b               // =27
               	ret
               	orr	x1, x3, #0x100000000
               	clz	x5, x1
               	orr	x2, x0, #0x100000000
               	mov	x1, #0x0                // =0
               	mov	x4, #0x3f               // =63
               	sub	x4, x4, x1
               	lsr	x4, x2, x4
               	tbnz	w4, #0x0, <addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x40
               	b.lt	<addr>
               	cmp	w5, w1
               	b.eq	<addr>
               	mov	x0, #0x1c               // =28
               	ret
               	clz	x1, x3
               	mov	x17, #0x4240            // =16960
               	movk	x17, #0xf, lsl #16
               	mul	x1, x1, x17
               	rbit	x2, x3
               	clz	x2, x2
               	mov	x17, #0x3e8             // =1000
               	mul	x2, x2, x17
               	add	x1, x1, x2
               	fmov	d16, x3
               	cnt	v16.8b, v16.8b
               	addv	b16, v16.8b
               	fmov	w2, s16
               	add	x4, x1, x2
               	mov	x1, #0x0                // =0
               	mov	x2, #0x3f               // =63
               	sub	x2, x2, x1
               	lsr	x2, x0, x2
               	tbnz	w2, #0x0, <addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x40
               	b.lt	<addr>
               	mov	x17, #0x4240            // =16960
               	movk	x17, #0xf, lsl #16
               	mul	x3, x1, x17
               	mov	x1, #0x0                // =0
               	lsr	x2, x0, x1
               	tbnz	w2, #0x0, <addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x40
               	b.lt	<addr>
               	mov	x17, #0x3e8             // =1000
               	mul	x1, x1, x17
               	add	x5, x3, x1
               	mov	x1, #0x0                // =0
               	mov	x2, x1
               	lsr	x3, x0, x1
               	and	x3, x3, #0x1
               	add	x2, x2, x3
               	add	x1, x1, #0x1
               	cmp	w1, #0x40
               	b.lt	<addr>
               	sxtw	x0, w2
               	add	x0, x5, x0
               	cmp	x4, x0
               	b.eq	<addr>
               	mov	x0, #0x1e               // =30
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	add	x1, x1, #0x1
               	b	<addr>

<check_long>:
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x0, [x1]
               	ldr	x4, [x1]
               	str	x0, [x1]
               	ldr	x5, [x1]
               	clz	x3, x4
               	mov	x1, #0x0                // =0
               	mov	x2, #0x3f               // =63
               	sub	x2, x2, x1
               	lsr	x2, x0, x2
               	tbnz	w2, #0x0, <addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x40
               	b.lt	<addr>
               	cmp	w3, w1
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	ret
               	rbit	x3, x4
               	clz	x3, x3
               	mov	x1, #0x0                // =0
               	lsr	x2, x0, x1
               	tbnz	w2, #0x0, <addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x40
               	b.lt	<addr>
               	cmp	w3, w1
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	ret
               	fmov	d16, x4
               	cnt	v16.8b, v16.8b
               	addv	b16, v16.8b
               	fmov	w6, s16
               	mov	x1, #0x0                // =0
               	mov	x2, x1
               	lsr	x3, x0, x1
               	and	x3, x3, #0x1
               	add	x2, x2, x3
               	add	x1, x1, #0x1
               	cmp	w1, #0x40
               	b.lt	<addr>
               	cmp	w6, w2
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	ret
               	lsl	x1, x5, #1
               	eor	x1, x5, x1
               	orr	x1, x1, #0x1
               	clz	x6, x1
               	lsr	x2, x0, #63
               	mov	x1, #0x0                // =0
               	mov	x3, #0x3e               // =62
               	sub	x3, x3, x1
               	lsr	x3, x0, x3
               	and	x3, x3, #0x1
               	cmp	w3, w2
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x3f
               	b.lt	<addr>
               	cmp	w6, w1
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	ret
               	rbit	x1, x5
               	clz	x1, x1
               	add	x2, x1, #0x1
               	lsr	x1, x1, #6
               	sub	x1, x1, #0x1
               	and	x3, x2, x1
               	mov	x1, #0x0                // =0
               	lsr	x2, x0, x1
               	tbnz	w2, #0x0, <addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x40
               	b.lt	<addr>
               	cmp	w1, #0x40
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	cmp	w3, w1
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	ret
               	fmov	d16, x4
               	cnt	v16.8b, v16.8b
               	addv	b16, v16.8b
               	fmov	w1, s16
               	and	x4, x1, #0x1
               	mov	x1, #0x0                // =0
               	mov	x2, x1
               	lsr	x3, x0, x1
               	and	x3, x3, #0x1
               	add	x2, x2, x3
               	add	x1, x1, #0x1
               	cmp	w1, #0x40
               	b.lt	<addr>
               	and	x0, x2, #0x1
               	cmp	w4, w0
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	add	x1, x1, #0x1
               	b	<addr>

<main>:
               	stp	x20, x21, [sp, #-0x30]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, #0x0               // =0
               	mov	x0, x20
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, x20
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, x20
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x20, #-0x1              // =-1
               	mov	x0, x20
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, x20
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, x20
               	bl	<addr>
               	mov	x21, #0x0               // =0
               	cbnz	w0, <addr>
               	cmp	w21, #0x40
               	b.ge	<addr>
               	mov	x0, #0x1                // =1
               	lsl	x20, x0, x21
               	mov	x0, x20
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, x20
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, x20
               	bl	<addr>
               	cbnz	w0, <addr>
               	sub	x22, x20, #0x1
               	mov	x0, x22
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, x22
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, x22
               	bl	<addr>
               	cbnz	w0, <addr>
               	neg	x22, x20
               	mov	x0, x22
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, x22
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, x22
               	bl	<addr>
               	cbnz	w0, <addr>
               	orr	x20, x20, #0x8000000000000000
               	mov	x0, x20
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, x20
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, x20
               	bl	<addr>
               	add	x21, x21, #0x1
               	cbz	w0, <addr>
               	mov	x20, #0x0               // =0
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	cbnz	w0, <addr>
               	cmp	w20, #0xa
               	b.hs	<addr>
               	ldr	x21, [x22, x20, lsl #3]
               	mov	x0, x21
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, x21
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, x21
               	bl	<addr>
               	add	x20, x20, #0x1
               	cbz	w0, <addr>
               	cbz	w0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x1, x0
               	mov	x3, #-0x1               // =-1
               	lsr	x3, x3, x0
               	str	x3, [x2]
               	ldr	x3, [x2]
               	fmov	d16, x3
               	cnt	v16.8b, v16.8b
               	addv	b16, v16.8b
               	fmov	w3, s16
               	add	x1, x1, x3
               	add	x0, x0, #0x1
               	cmp	w0, #0x40
               	b.lt	<addr>
               	cmp	x1, #0x820
               	b.eq	<addr>
               	mov	x0, #0x18               // =24
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
