
counted_loops_close_on_their_step.aarch64:	file format elf64-littleaarch64

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

<post64>:
               	mov	x2, #0x0                // =0
               	subs	x1, x1, #0x1
               	b.lo	<addr>
               	add	x2, x2, x2, lsl #2
               	ldrb	w3, [x0], #0x1
               	add	x2, x2, x3
               	subs	x1, x1, #0x1
               	b.hs	<addr>
               	mov	x0, x2
               	ret

<post32>:
               	mov	x2, #0x0                // =0
               	mov	w1, w1
               	subs	x1, x1, #0x1
               	b.lo	<addr>
               	add	x2, x2, x2, lsl #2
               	ldrb	w3, [x0], #0x1
               	add	x2, x2, x3
               	mov	w1, w1
               	subs	x1, x1, #0x1
               	b.hs	<addr>
               	mov	x0, x2
               	ret

<post_int>:
               	sxtw	x1, w1
               	mov	x2, #0x0                // =0
               	subs	x1, x1, #0x1
               	b.lo	<addr>
               	ldrb	w3, [x0], #0x1
               	and	x4, x1, #0x7
               	lsl	x3, x3, x4
               	eor	x2, x2, x3
               	subs	x1, x1, #0x1
               	b.hs	<addr>
               	mov	x0, x2
               	ret

<pre64>:
               	mov	x2, #0x0                // =0
               	add	x2, x2, x2, lsl #2
               	ldrb	w3, [x0], #0x1
               	add	x2, x2, x3
               	subs	x1, x1, #0x1
               	b.ne	<addr>
               	mov	x0, x2
               	ret

<pre32>:
               	mov	x2, #0x0                // =0
               	subs	w1, w1, #0x1
               	b.eq	<addr>
               	add	x2, x2, x2, lsl #2
               	ldrb	w3, [x0], #0x1
               	add	x2, x2, x3
               	subs	w1, w1, #0x1
               	b.ne	<addr>
               	mov	x0, x2
               	ret

<kept>:
               	mov	x3, #0x0                // =0
               	subs	x1, x1, #0x1
               	b.lo	<addr>
               	ldrb	w4, [x0], #0x1
               	add	x3, x3, x4
               	subs	x1, x1, #0x1
               	b.hs	<addr>
               	str	x1, [x2]
               	mov	x0, x3
               	ret

<reference>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	xzr, [x29, #-0x8]
               	stur	xzr, [x29, #-0x10]
               	b	<addr>
               	ldur	x2, [x29, #-0x8]
               	add	x2, x2, x2, lsl #2
               	ldur	x3, [x29, #-0x10]
               	ldrb	w3, [x0, x3]
               	add	x2, x2, x3
               	stur	x2, [x29, #-0x8]
               	ldur	x2, [x29, #-0x10]
               	add	x2, x2, #0x1
               	stur	x2, [x29, #-0x10]
               	ldur	x2, [x29, #-0x10]
               	cmp	x2, x1
               	b.lo	<addr>
               	ldur	x0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<negatives>:
               	cmn	x0, #0x7
               	cset	x2, eq
               	cmn	x0, #0xfff
               	cset	x3, ne
               	add	x2, x2, x3, lsl #1
               	mov	x17, #-0x1000           // =-4096
               	cmp	x0, x17
               	cset	x3, eq
               	add	x2, x2, x3, lsl #2
               	cmn	w1, #0x1
               	cset	x1, eq
               	add	x1, x2, x1, lsl #3
               	cmn	x0, #0x64
               	cset	x0, lt
               	add	x0, x1, x0, lsl #4
               	ret

<main>:
               	str	x20, [sp, #-0xf0]!
               	stp	x29, x30, [sp, #0xe0]
               	add	x29, sp, #0xe0
               	mov	x0, #0x0                // =0
               	mov	x1, #0x1d               // =29
               	sub	x2, x29, #0xc8
               	mul	x3, x0, x1
               	add	x3, x3, #0x3
               	and	x3, x3, #0xff
               	strb	w3, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0xc8
               	b.lt	<addr>
               	sub	x0, x29, #0xc8
               	mov	x1, #0xc8               // =200
               	bl	<addr>
               	mov	x20, x0
               	sub	x0, x29, #0xc8
               	mov	x1, #0xc8               // =200
               	bl	<addr>
               	cmp	x20, x0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x20, [sp], #0xf0
               	ret
               	sub	x0, x29, #0xc8
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x20, [sp], #0xf0
               	ret
               	sub	x0, x29, #0xc8
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	sub	x2, x29, #0xc8
               	ldurb	w1, [x29, #-0xc8]
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x20, [sp], #0xf0
               	ret
               	mov	x1, #0xc8               // =200
               	mov	x0, x2
               	bl	<addr>
               	mov	x20, x0
               	sub	x0, x29, #0xc8
               	mov	x1, #0xc8               // =200
               	bl	<addr>
               	cmp	w20, w0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x20, [sp], #0xf0
               	ret
               	sub	x0, x29, #0xc8
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x20, [sp], #0xf0
               	ret
               	sub	x0, x29, #0xc8
               	mov	x1, #0xc8               // =200
               	bl	<addr>
               	mov	x20, x0
               	sub	x0, x29, #0xc8
               	mov	x1, #0xc8               // =200
               	bl	<addr>
               	cmp	x20, x0
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x20, [sp], #0xf0
               	ret
               	sub	x0, x29, #0xc8
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	sub	x2, x29, #0xc8
               	ldurb	w1, [x29, #-0xc8]
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x20, [sp], #0xf0
               	ret
               	mov	x1, #0xc8               // =200
               	mov	x0, x2
               	bl	<addr>
               	mov	x20, x0
               	sub	x0, x29, #0xc8
               	mov	x1, #0xc7               // =199
               	bl	<addr>
               	cmp	w20, w0
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x20, [sp], #0xf0
               	ret
               	sub	x0, x29, #0xc8
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x20, [sp], #0xf0
               	ret
               	sub	x0, x29, #0xc8
               	ldurb	w1, [x29, #-0xc8]
               	lsl	x1, x1, #4
               	ldurb	w2, [x29, #-0xc7]
               	eor	x1, x1, x2, lsl #3
               	ldurb	w2, [x29, #-0xc6]
               	eor	x1, x1, x2, lsl #2
               	ldurb	w2, [x29, #-0xc5]
               	eor	x1, x1, x2, lsl #1
               	ldurb	w2, [x29, #-0xc4]
               	eor	x1, x1, x2
               	ldurb	w2, [x29, #-0xc3]
               	eor	x1, x1, x2, lsl #7
               	ldurb	w2, [x29, #-0xc2]
               	eor	x1, x1, x2, lsl #6
               	ldurb	w2, [x29, #-0xc1]
               	eor	x1, x1, x2, lsl #5
               	ldurb	w2, [x29, #-0xc0]
               	eor	x1, x1, x2, lsl #4
               	ldurb	w2, [x29, #-0xbf]
               	eor	x1, x1, x2, lsl #3
               	ldurb	w2, [x29, #-0xbe]
               	eor	x1, x1, x2, lsl #2
               	ldurb	w2, [x29, #-0xbd]
               	eor	x1, x1, x2, lsl #1
               	ldurb	w2, [x29, #-0xbc]
               	eor	x20, x1, x2
               	mov	x1, #0xd                // =13
               	bl	<addr>
               	cmp	w0, w20
               	b.ne	<addr>
               	sub	x0, x29, #0xc8
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x20, [sp], #0xf0
               	ret
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0xd0]
               	sub	x0, x29, #0xc8
               	mov	x1, #0xa                // =10
               	sub	x2, x29, #0xd0
               	bl	<addr>
               	ldurb	w1, [x29, #-0xc8]
               	ldurb	w2, [x29, #-0xc7]
               	add	x1, x1, x2
               	ldurb	w2, [x29, #-0xc6]
               	add	x1, x1, x2
               	ldurb	w2, [x29, #-0xc5]
               	add	x1, x1, x2
               	ldurb	w2, [x29, #-0xc4]
               	add	x1, x1, x2
               	ldurb	w2, [x29, #-0xc3]
               	add	x1, x1, x2
               	ldurb	w2, [x29, #-0xc2]
               	add	x1, x1, x2
               	ldurb	w2, [x29, #-0xc1]
               	add	x1, x1, x2
               	ldurb	w2, [x29, #-0xc0]
               	add	x1, x1, x2
               	ldurb	w2, [x29, #-0xbf]
               	add	x1, x1, x2
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x20, [sp], #0xf0
               	ret
               	ldur	x0, [x29, #-0xd0]
               	cmn	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x20, [sp], #0xf0
               	ret
               	mov	x0, #-0x7               // =-7
               	mov	x1, #-0x1               // =-1
               	bl	<addr>
               	cmp	w0, #0xb
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x20, [sp], #0xf0
               	ret
               	mov	x0, #-0xfff             // =-4095
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	cmp	w0, #0x10
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x20, [sp], #0xf0
               	ret
               	mov	x0, #-0x1000            // =-4096
               	mov	x1, #0x5                // =5
               	bl	<addr>
               	cmp	w0, #0x16
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x20, [sp], #0xf0
               	ret
               	mov	x0, #0x7                // =7
               	mov	x1, #-0x1               // =-1
               	bl	<addr>
               	cmp	w0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x20, [sp], #0xf0
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x20, [sp], #0xf0
               	ret
