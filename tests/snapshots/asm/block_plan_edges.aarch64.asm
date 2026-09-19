
block_plan_edges.aarch64:	file format elf64-littleaarch64

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

<dispatch>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	stur	w0, [x29, #-0x20]
               	stur	w1, [x29, #-0x10]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	and	x0, x0, #0x3
               	ldr	x0, [x1, x0, lsl #3]
               	br	x0
               	mov	x0, #0x6                // =6
               	stur	w0, [x29, #-0x10]
               	ldursw	x0, [x29, #-0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, #0xa                // =10
               	stur	w0, [x29, #-0x10]
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x1, #0x1                // =1
               	mov	x2, #0x2                // =2
               	mov	x0, #0x0                // =0
               	cmp	w0, #0x0
               	b.ge	<addr>
               	and	x3, x0, #0x1
               	cbz	x3, <addr>
               	mov	x16, x2
               	mov	x2, x1
               	mov	x1, x16
               	add	x0, x0, #0x1
               	cmp	w0, #0x0
               	b.lt	<addr>
               	mov	x17, #0x3               // =3
               	mul	x0, x1, x17
               	add	x0, x0, x2
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x1                // =1
               	mov	x2, #0x2                // =2
               	mov	x0, #0x0                // =0
               	cmp	w0, #0x1
               	b.ge	<addr>
               	and	x3, x0, #0x1
               	cbz	x3, <addr>
               	mov	x16, x2
               	mov	x2, x1
               	mov	x1, x16
               	add	x0, x0, #0x1
               	cmp	w0, #0x1
               	b.lt	<addr>
               	mov	x17, #0x3               // =3
               	mul	x0, x1, x17
               	add	x0, x0, x2
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x1                // =1
               	mov	x2, #0x2                // =2
               	mov	x0, #0x0                // =0
               	cmp	w0, #0x2
               	b.ge	<addr>
               	and	x3, x0, #0x1
               	cbz	x3, <addr>
               	mov	x16, x2
               	mov	x2, x1
               	mov	x1, x16
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	mov	x17, #0x3               // =3
               	mul	x0, x1, x17
               	add	x0, x0, x2
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x1                // =1
               	mov	x2, #0x2                // =2
               	mov	x0, #0x0                // =0
               	cmp	w0, #0x4
               	b.ge	<addr>
               	and	x3, x0, #0x1
               	cbz	x3, <addr>
               	mov	x16, x2
               	mov	x2, x1
               	mov	x1, x16
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	mov	x17, #0x3               // =3
               	mul	x0, x1, x17
               	add	x0, x0, x2
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x1                // =1
               	mov	x2, #0x2                // =2
               	mov	x0, #0x0                // =0
               	cmp	w0, #0x7
               	b.ge	<addr>
               	and	x3, x0, #0x1
               	cbz	x3, <addr>
               	mov	x16, x2
               	mov	x2, x1
               	mov	x1, x16
               	add	x0, x0, #0x1
               	cmp	w0, #0x7
               	b.lt	<addr>
               	mov	x17, #0x3               // =3
               	mul	x0, x1, x17
               	add	x0, x0, x2
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x1                // =1
               	mov	x2, #0x2                // =2
               	mov	x3, #0x3                // =3
               	mov	x6, #0x3                // =3
               	mov	x7, #0x5556             // =21846
               	movk	x7, #0x5555, lsl #16
               	mov	x0, #0x0                // =0
               	cmp	w0, #0x0
               	b.ge	<addr>
               	sxtw	x4, w0
               	mul	x5, x4, x7
               	asr	x5, x5, #32
               	lsr	x8, x5, #63
               	add	x5, x5, x8
               	mul	x5, x5, x6
               	sub	x4, x4, x5
               	cbnz	x4, <addr>
               	mov	x16, x2
               	mov	x2, x3
               	mov	x3, x1
               	mov	x1, x16
               	add	x0, x0, #0x1
               	cmp	w0, #0x0
               	b.lt	<addr>
               	mov	x17, #0x64              // =100
               	mul	x0, x1, x17
               	mov	x17, #0xa               // =10
               	mul	x1, x2, x17
               	add	x0, x0, x1
               	add	x0, x0, x3
               	cmp	x0, #0x7b
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x1                // =1
               	mov	x2, #0x2                // =2
               	mov	x3, #0x3                // =3
               	mov	x6, #0x3                // =3
               	mov	x7, #0x5556             // =21846
               	movk	x7, #0x5555, lsl #16
               	mov	x0, #0x0                // =0
               	cmp	w0, #0x1
               	b.ge	<addr>
               	sxtw	x4, w0
               	mul	x5, x4, x7
               	asr	x5, x5, #32
               	lsr	x8, x5, #63
               	add	x5, x5, x8
               	mul	x5, x5, x6
               	sub	x4, x4, x5
               	cbnz	x4, <addr>
               	mov	x16, x2
               	mov	x2, x3
               	mov	x3, x1
               	mov	x1, x16
               	add	x0, x0, #0x1
               	cmp	w0, #0x1
               	b.lt	<addr>
               	mov	x17, #0x64              // =100
               	mul	x0, x1, x17
               	mov	x17, #0xa               // =10
               	mul	x1, x2, x17
               	add	x0, x0, x1
               	add	x0, x0, x3
               	cmp	x0, #0xe7
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x1                // =1
               	mov	x2, #0x2                // =2
               	mov	x3, #0x3                // =3
               	mov	x6, #0x3                // =3
               	mov	x7, #0x5556             // =21846
               	movk	x7, #0x5555, lsl #16
               	mov	x0, #0x0                // =0
               	cmp	w0, #0x4
               	b.ge	<addr>
               	sxtw	x4, w0
               	mul	x5, x4, x7
               	asr	x5, x5, #32
               	lsr	x8, x5, #63
               	add	x5, x5, x8
               	mul	x5, x5, x6
               	sub	x4, x4, x5
               	cbnz	x4, <addr>
               	mov	x16, x2
               	mov	x2, x3
               	mov	x3, x1
               	mov	x1, x16
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	mov	x17, #0x64              // =100
               	mul	x0, x1, x17
               	mov	x17, #0xa               // =10
               	mul	x1, x2, x17
               	add	x0, x0, x1
               	add	x0, x0, x3
               	cmp	x0, #0x138
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x1                // =1
               	mov	x2, #0x2                // =2
               	mov	x3, #0x3                // =3
               	mov	x6, #0x3                // =3
               	mov	x7, #0x5556             // =21846
               	movk	x7, #0x5555, lsl #16
               	mov	x0, #0x0                // =0
               	cmp	w0, #0x7
               	b.ge	<addr>
               	sxtw	x4, w0
               	mul	x5, x4, x7
               	asr	x5, x5, #32
               	lsr	x8, x5, #63
               	add	x5, x5, x8
               	mul	x5, x5, x6
               	sub	x4, x4, x5
               	cbnz	x4, <addr>
               	mov	x16, x2
               	mov	x2, x3
               	mov	x3, x1
               	mov	x1, x16
               	add	x0, x0, #0x1
               	cmp	w0, #0x7
               	b.lt	<addr>
               	mov	x17, #0x64              // =100
               	mul	x0, x1, x17
               	mov	x17, #0xa               // =10
               	mul	x1, x2, x17
               	add	x0, x0, x1
               	add	x0, x0, x3
               	cmp	x0, #0x7b
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	mov	x1, x0
               	mov	x1, #0x7                // =7
               	mov	x1, #0xa                // =10
               	mov	x1, #0x3ff0000000000000 // =4607182418800017408
               	mov	x2, #0x4000000000000000 // =4611686018427387904
               	mov	x0, #0x0                // =0
               	mov	x17, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d0, x17
               	mov	x17, #0x4000000000000000 // =4611686018427387904
               	fmov	d1, x17
               	cmp	w0, #0x1
               	b.ge	<addr>
               	and	x1, x0, #0x1
               	cbz	x1, <addr>
               	fmov	d17, d1
               	fmov	d1, d0
               	fmov	d0, d17
               	add	x0, x0, #0x1
               	cmp	w0, #0x1
               	b.lt	<addr>
               	mov	x0, #0x4010000000000000 // =4616189618054758400
               	fmov	d17, x0
               	fmadd	d0, d0, d17, d1
               	mov	x0, #0x4018000000000000 // =4618441417868443648
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x3ff0000000000000 // =4607182418800017408
               	mov	x2, #0x4000000000000000 // =4611686018427387904
               	mov	x0, #0x0                // =0
               	mov	x17, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d0, x17
               	mov	x17, #0x4000000000000000 // =4611686018427387904
               	fmov	d1, x17
               	cmp	w0, #0x2
               	b.ge	<addr>
               	and	x1, x0, #0x1
               	cbz	x1, <addr>
               	fmov	d17, d1
               	fmov	d1, d0
               	fmov	d0, d17
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	mov	x0, #0x4010000000000000 // =4616189618054758400
               	fmov	d17, x0
               	fmadd	d0, d0, d17, d1
               	mov	x0, #0x4022000000000000 // =4621256167635550208
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x3ff0000000000000 // =4607182418800017408
               	mov	x2, #0x4000000000000000 // =4611686018427387904
               	mov	x0, #0x0                // =0
               	mov	x17, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d0, x17
               	mov	x17, #0x4000000000000000 // =4611686018427387904
               	fmov	d1, x17
               	cmp	w0, #0x4
               	b.ge	<addr>
               	and	x1, x0, #0x1
               	cbz	x1, <addr>
               	fmov	d17, d1
               	fmov	d1, d0
               	fmov	d0, d17
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	mov	x0, #0x4010000000000000 // =4616189618054758400
               	fmov	d17, x0
               	fmadd	d0, d0, d17, d1
               	mov	x0, #0x4018000000000000 // =4618441417868443648
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	mov	x0, #0xa                // =10
               	mov	x2, x0
               	mov	x0, #0x28               // =40
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	mov	x1, x0
               	mov	x0, #0x50               // =80
               	mov	x0, #0x0                // =0
               	mov	x0, #-0x1               // =-1
               	mov	x1, x0
               	mov	x0, #0x0                // =0
               	mov	x1, #0x5                // =5
               	bl	<addr>
               	cmp	x0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x20               // =32
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	mov	x1, #0x5                // =5
               	bl	<addr>
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x21               // =33
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	mov	x1, #0x5                // =5
               	bl	<addr>
               	cmp	x0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x22               // =34
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	mov	x1, #0x5                // =5
               	bl	<addr>
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x23               // =35
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	cmp	w0, #0x0
               	b.ge	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x0
               	b.lt	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	cmp	w0, #0x9
               	b.ge	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x9
               	b.lt	<addr>
               	cmp	w0, #0x9
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x24               // =36
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	cmp	w0, #0x8
               	b.ge	<addr>
               	sxtw	x3, w0
               	ldrb	w3, [x2, x3]
               	and	x3, x3, #0x1
               	cbz	x3, <addr>
               	add	x1, x1, #0x1
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	cmp	w1, #0x5
               	b.eq	<addr>
               	mov	x0, #0x25               // =37
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	cmp	w0, #0x0
               	b.ge	<addr>
               	sxtw	x3, w0
               	ldrb	w3, [x2, x3]
               	and	x3, x3, #0x1
               	cbz	x3, <addr>
               	add	x1, x1, #0x1
               	add	x0, x0, #0x1
               	cmp	w0, #0x0
               	b.lt	<addr>
               	cbz	x1, <addr>
               	mov	x0, #0x26               // =38
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	cmp	w0, #0x0
               	b.ge	<addr>
               	sxtw	x3, w0
               	ldrsw	x3, [x2, x3, lsl #2]
               	add	x1, x1, x3
               	add	x0, x0, #0x1
               	cmp	w0, #0x0
               	b.lt	<addr>
               	cbnz	x1, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x4, #-0x2               // =-2
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	cmp	w0, w4
               	b.ge	<addr>
               	sxtw	x3, w0
               	ldrsw	x3, [x2, x3, lsl #2]
               	add	x1, x1, x3
               	add	x0, x0, #0x1
               	cmp	w0, w4
               	b.lt	<addr>
               	cmp	x1, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x27               // =39
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	cmp	w0, #0x1
               	b.ge	<addr>
               	sxtw	x3, w0
               	ldrsw	x3, [x2, x3, lsl #2]
               	add	x1, x1, x3
               	add	x0, x0, #0x1
               	cmp	w0, #0x1
               	b.lt	<addr>
               	cmp	x1, #0x3
               	b.ne	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	cmp	w0, #0x8
               	b.ge	<addr>
               	sxtw	x3, w0
               	ldrsw	x3, [x2, x3, lsl #2]
               	add	x1, x1, x3
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	cmp	x1, #0x9
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x28               // =40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	cbz	x2, <addr>
               	add	x0, x0, #0x1
               	ldrb	w2, [x1, x0]
               	cbnz	x2, <addr>
               	cbnz	x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	cbz	x2, <addr>
               	add	x0, x0, #0x1
               	ldrb	w2, [x1, x0]
               	cbnz	x2, <addr>
               	cmp	x0, #0x1
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	cbz	x2, <addr>
               	add	x0, x0, #0x1
               	ldrb	w2, [x1, x0]
               	cbnz	x2, <addr>
               	cmp	x0, #0x7
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x29               // =41
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x4, #0x5                // =5
               	mov	x2, #0x0                // =0
               	mov	x1, x2
               	cmp	w2, #0x0
               	b.ge	<addr>
               	mov	x0, #0x0                // =0
               	cmp	w0, #0x5
               	b.ge	<addr>
               	mul	x3, x2, x4
               	add	x3, x3, x0
               	sxtw	x3, w3
               	add	x1, x1, x3
               	add	x0, x0, #0x1
               	cmp	w0, #0x5
               	b.lt	<addr>
               	add	x2, x2, #0x1
               	cmp	w2, #0x0
               	b.lt	<addr>
               	cbnz	x1, <addr>
               	mov	x4, #0x0                // =0
               	mov	x2, #0x0                // =0
               	mov	x1, x2
               	cmp	w2, #0x3
               	b.ge	<addr>
               	mov	x0, #0x0                // =0
               	cmp	w0, #0x0
               	b.ge	<addr>
               	mul	x3, x2, x4
               	add	x3, x3, x0
               	sxtw	x3, w3
               	add	x1, x1, x3
               	add	x0, x0, #0x1
               	cmp	w0, #0x0
               	b.lt	<addr>
               	add	x2, x2, #0x1
               	cmp	w2, #0x3
               	b.lt	<addr>
               	cmp	x1, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x2, #0x0                // =0
               	mov	x1, x2
               	cmp	w2, #0x1
               	b.ge	<addr>
               	mov	x0, #0x0                // =0
               	cmp	w0, #0x1
               	b.ge	<addr>
               	lsr	x3, x2, #0
               	add	x3, x3, x0
               	sxtw	x3, w3
               	add	x1, x1, x3
               	add	x0, x0, #0x1
               	cmp	w0, #0x1
               	b.lt	<addr>
               	add	x2, x2, #0x1
               	cmp	w2, #0x1
               	b.lt	<addr>
               	cmp	x1, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2b               // =43
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x0                // =0
               	mov	x1, x2
               	cmp	w2, #0x3
               	b.ge	<addr>
               	mov	x0, #0x0                // =0
               	cmp	w0, #0x4
               	b.ge	<addr>
               	lsl	x3, x2, #2
               	add	x3, x3, x0
               	sxtw	x3, w3
               	add	x1, x1, x3
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	add	x2, x2, #0x1
               	cmp	w2, #0x3
               	b.lt	<addr>
               	cmp	x1, #0x42
               	b.eq	<addr>
               	mov	x0, #0x2c               // =44
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	mov	x2, x1
               	mov	x0, #0x1                // =1
               	mov	x2, x1
               	cbz	x0, <addr>
               	mov	w0, w2
               	add	x2, x0, #0x1
               	mov	x0, x1
               	cbnz	x0, <addr>
               	mov	w0, w2
               	eor	x0, x0, #0x1
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, #0xff               // =255
               	mov	x1, #0x0                // =0
               	cbz	x0, <addr>
               	lsr	x0, x0, #1
               	mov	w1, w1
               	add	x1, x1, #0x1
               	cbnz	x0, <addr>
               	mov	w0, w1
               	eor	x0, x0, #0x8
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2d               // =45
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	ldp	x29, x30, [sp], #0x10
               	ret
