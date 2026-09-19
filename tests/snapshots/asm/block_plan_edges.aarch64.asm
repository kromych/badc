
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

<scaled>:
               	mov	x2, x0
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	madd	x1, x0, x2, x1
               	add	x0, x0, #0x1
               	cmp	w0, #0x3e8
               	b.lt	<addr>
               	mov	x0, x1
               	ret

<split16>:
               	mov	x2, x0
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	and	x3, x0, #0x7
               	ldrsw	x4, [x2, x3, lsl #2]
               	tbz	w4, #0x0, <addr>
               	ldrsw	x3, [x2, x3, lsl #2]
               	add	x1, x1, x3
               	b	<addr>
               	sub	x1, x1, x0
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, x1
               	ret

<low_word_skip>:
               	mov	x0, #0x0                // =0
               	ret

<mask_skip>:
               	mov	x0, #0x0                // =0
               	ret

<low_word_trips>:
               	mov	x2, x0
               	mov	x0, #0x0                // =0
               	mov	x1, #0x3                // =3
               	movk	x1, #0x1, lsl #32
               	tbz	w1, #0x0, <addr>
               	add	x0, x0, #0x3
               	b	<addr>
               	add	x0, x0, #0x5
               	sub	x1, x1, x2
               	cbnz	w1, <addr>
               	ret

<wraps>:
               	mov	x2, x0
               	mov	x0, #0x0                // =0
               	mov	x1, #0xfffffffe         // =4294967294
               	mov	x3, #0x7                // =7
               	tbz	w1, #0x0, <addr>
               	lsl	x4, x2, #1
               	add	x0, x0, x4
               	b	<addr>
               	mul	x4, x2, x3
               	add	x0, x0, x4
               	add	x1, x1, #0x1
               	eor	x4, x1, #0x1
               	cbnz	w4, <addr>
               	mov	w0, w0
               	ret

<after_skip>:
               	mov	x0, #0x1                // =1
               	ret

<two_entries>:
               	mov	x2, x0
               	sxtw	x1, w1
               	mov	x3, #0x100000000        // =4294967296
               	mov	x0, #0x0                // =0
               	cbnz	x1, <addr>
               	mov	x2, x3
               	b	<addr>
               	tbz	w2, #0x0, <addr>
               	b	<addr>
               	cbnz	w2, <addr>
               	ret
               	add	x0, x0, #0x3
               	add	x2, x2, #0x1
               	b	<addr>
               	add	x0, x0, #0x5
               	b	<addr>

<value_after>:
               	mov	x0, #0x0                // =0
               	mov	x1, #0x100000000        // =4294967296
               	sxtw	x2, w1
               	b	<addr>
               	tbz	w1, #0x0, <addr>
               	add	x0, x0, #0x3
               	b	<addr>
               	add	x0, x0, #0x5
               	add	x1, x1, #0x1
               	sxtw	x2, w1
               	cbnz	w2, <addr>
               	mov	x17, #0xa               // =10
               	mul	x0, x0, x17
               	add	x0, x0, x2
               	ret

<main>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x1, #0x1                // =1
               	mov	x0, #0x2                // =2
               	mov	x2, #0x0                // =0
               	mov	x3, x1
               	mov	x2, x1
               	cmp	w2, #0x1
               	b.lt	<addr>
               	mov	x17, #0x3               // =3
               	mul	x1, x3, x17
               	add	x0, x1, x0
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x1, #0x1                // =1
               	mov	x2, #0x2                // =2
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
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
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x1, #0x1                // =1
               	mov	x2, #0x2                // =2
               	mov	x0, #0x0                // =0
               	tbz	w0, #0x0, <addr>
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
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x1, #0x1                // =1
               	mov	x2, #0x2                // =2
               	mov	x0, #0x0                // =0
               	tbz	w0, #0x0, <addr>
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
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x2, #0x1                // =1
               	mov	x0, #0x2                // =2
               	mov	x1, #0x3                // =3
               	mov	x3, #0x0                // =0
               	mov	x4, x2
               	mov	x3, x2
               	mov	x16, x4
               	mov	x4, x0
               	mov	x0, x1
               	mov	x1, x16
               	cmp	w3, #0x1
               	b.lt	<addr>
               	mov	x17, #0x64              // =100
               	mul	x2, x4, x17
               	mov	x17, #0xa               // =10
               	mul	x0, x0, x17
               	add	x0, x2, x0
               	add	x0, x0, x1
               	cmp	x0, #0xe7
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x1, #0x1                // =1
               	mov	x2, #0x2                // =2
               	mov	x3, #0x3                // =3
               	mov	x4, #0x3                // =3
               	mov	x5, #0x5556             // =21846
               	movk	x5, #0x5555, lsl #16
               	mov	x0, #0x0                // =0
               	mul	x6, x0, x5
               	lsr	x6, x6, #32
               	mul	x6, x6, x4
               	sub	x6, x0, x6
               	cbnz	w6, <addr>
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
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x4, #0x1                // =1
               	mov	x1, #0x2                // =2
               	mov	x2, #0x3                // =3
               	mov	x5, #0x3                // =3
               	mov	x6, #0x5556             // =21846
               	movk	x6, #0x5555, lsl #16
               	mov	x0, #0x0                // =0
               	mov	x3, x4
               	mul	x7, x0, x6
               	lsr	x7, x7, #32
               	mul	x7, x7, x5
               	sub	x7, x0, x7
               	cbnz	w7, <addr>
               	mov	x16, x1
               	mov	x1, x2
               	mov	x2, x3
               	mov	x3, x16
               	add	x0, x0, #0x1
               	cmp	w0, #0x7
               	b.lt	<addr>
               	mov	x17, #0x64              // =100
               	mul	x0, x3, x17
               	mov	x17, #0xa               // =10
               	mul	x1, x1, x17
               	add	x0, x0, x1
               	add	x0, x0, x2
               	cmp	x0, #0x7b
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x1, #0x3ff0000000000000 // =4607182418800017408
               	mov	x2, #0x4000000000000000 // =4611686018427387904
               	mov	x0, #0x0                // =0
               	mov	x17, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d0, x17
               	mov	x17, #0x4000000000000000 // =4611686018427387904
               	fmov	d1, x17
               	mov	x0, x4
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
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x1, #0x3ff0000000000000 // =4607182418800017408
               	mov	x2, #0x4000000000000000 // =4611686018427387904
               	mov	x0, #0x0                // =0
               	mov	x17, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d0, x17
               	mov	x17, #0x4000000000000000 // =4611686018427387904
               	fmov	d1, x17
               	cbz	x0, <addr>
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
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x1, #0x3ff0000000000000 // =4607182418800017408
               	mov	x2, #0x4000000000000000 // =4611686018427387904
               	mov	x0, #0x0                // =0
               	mov	x17, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d0, x17
               	mov	x17, #0x4000000000000000 // =4611686018427387904
               	fmov	d1, x17
               	tbz	w0, #0x0, <addr>
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
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	mov	x1, #0x5                // =5
               	bl	<addr>
               	cmp	x0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x20               // =32
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x20, #0x1               // =1
               	mov	x1, #0x5                // =5
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x21               // =33
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x2                // =2
               	mov	x1, #0x5                // =5
               	bl	<addr>
               	cmp	x0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x22               // =34
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x3                // =3
               	mov	x1, #0x5                // =5
               	bl	<addr>
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x23               // =35
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	add	x0, x0, #0x1
               	cmp	w0, #0x9
               	b.lt	<addr>
               	cmp	w0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x24               // =36
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	ldrb	w3, [x2, x0]
               	tbz	w3, #0x0, <addr>
               	add	x1, x1, #0x1
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	cmp	w1, #0x5
               	b.eq	<addr>
               	mov	x0, #0x25               // =37
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	add	x1, x1, #0x3
               	mov	x0, x20
               	cmp	w0, #0x1
               	b.lt	<addr>
               	cmp	x1, #0x3
               	b.ne	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	ldrsw	x3, [x2, x0, lsl #2]
               	add	x1, x1, x3
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	cmp	x1, #0x9
               	b.eq	<addr>
               	mov	x0, #0x28               // =40
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
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
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	cbz	x2, <addr>
               	add	x0, x0, #0x1
               	ldrb	w2, [x1, x0]
               	cbnz	x2, <addr>
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x29               // =41
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	mov	x1, #0x1                // =1
               	mov	x2, x0
               	cmp	w1, #0x1
               	b.lt	<addr>
               	mov	x0, #0x1                // =1
               	cmp	w0, #0x1
               	b.lt	<addr>
               	mov	x2, #0x0                // =0
               	mov	x1, x2
               	mov	x0, #0x0                // =0
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
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x2, #0x1                // =1
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	add	x0, x0, #0x1
               	mov	x2, x1
               	cbnz	w2, <addr>
               	eor	x0, x0, #0x1
               	cbnz	w0, <addr>
               	mov	x0, #0xff               // =255
               	mov	x1, #0x0                // =0
               	lsr	x0, x0, #1
               	add	x1, x1, #0x1
               	cbnz	w0, <addr>
               	eor	x0, x1, #0x8
               	cbz	w0, <addr>
               	mov	x0, #0x2d               // =45
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x17, #0x3e58            // =15960
               	movk	x17, #0xf, lsl #16
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, #-0x1               // =-1
               	bl	<addr>
               	mov	x17, #-0x9f2c           // =-40748
               	movk	x17, #0xfff8, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2e               // =46
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x17, #-0x3c             // =-60
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2f               // =47
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x30               // =48
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x31               // =49
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cmp	x0, #0xb
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x32               // =50
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	eor	x0, x0, #0x10
               	cbnz	w0, <addr>
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	eor	x0, x0, #0x30
               	cbz	w0, <addr>
               	mov	x0, #0x33               // =51
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	cmp	x0, #0x1
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x34               // =52
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #-0x3               // =-3
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	cmp	x0, #0xb
               	b.eq	<addr>
               	mov	x0, #0x35               // =53
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x36               // =54
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x2a               // =42
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
