
strength_reduce_compound_divmod.aarch64:	file format elf64-littleaarch64

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

<plain>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xe0
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0xf0]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0xf0]
               	mov	x0, #0x0                // =0
               	mov	x3, #0xa                // =10
               	mov	x4, #0x6667             // =26215
               	movk	x4, #0x6666, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, #0xa                // =10
               	stur	w1, [x29, #-0xe0]
               	ldr	x1, [x5, x0, lsl #3]
               	sxtw	x1, w1
               	mul	x2, x1, x4
               	asr	x2, x2, #34
               	add	x2, x2, x2, lsr #63
               	mul	x6, x2, x3
               	sub	x6, x1, x6
               	ldursw	x7, [x29, #-0xe0]
               	sdiv	w7, w1, w7
               	ldursw	x8, [x29, #-0xe0]
               	sdiv	w17, w1, w8
               	msub	w1, w17, w8, w1
               	cmp	w2, w7
               	b.ne	<addr>
               	cmp	w6, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0xf0]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0xf0]
               	mov	x0, #0x0                // =0
               	mov	x3, #0x7                // =7
               	mov	x4, #0x2493             // =9363
               	movk	x4, #0x9249, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, #0x7                // =7
               	stur	w1, [x29, #-0xd8]
               	ldr	x1, [x5, x0, lsl #3]
               	sxtw	x1, w1
               	mul	x2, x1, x4
               	asr	x2, x2, #34
               	add	x2, x2, x2, lsr #63
               	mul	x6, x2, x3
               	sub	x6, x1, x6
               	ldursw	x7, [x29, #-0xd8]
               	sdiv	w7, w1, w7
               	ldursw	x8, [x29, #-0xd8]
               	sdiv	w17, w1, w8
               	msub	w1, w17, w8, w1
               	cmp	w2, w7
               	b.ne	<addr>
               	cmp	w6, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0xf0]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0xf0]
               	mov	x0, #0x0                // =0
               	mov	x3, #-0x7               // =-7
               	mov	x4, #0x2493             // =9363
               	movk	x4, #0x9249, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, #-0x7               // =-7
               	stur	w1, [x29, #-0xd0]
               	ldr	x1, [x5, x0, lsl #3]
               	sxtw	x1, w1
               	mul	x2, x1, x4
               	asr	x2, x2, #34
               	add	x2, x2, x2, lsr #63
               	neg	x2, x2
               	mul	x6, x2, x3
               	sub	x6, x1, x6
               	ldursw	x7, [x29, #-0xd0]
               	sdiv	w7, w1, w7
               	ldursw	x8, [x29, #-0xd0]
               	sdiv	w17, w1, w8
               	msub	w1, w17, w8, w1
               	cmp	w2, w7
               	b.ne	<addr>
               	cmp	w6, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0xf0]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0xf0]
               	mov	x0, #0x0                // =0
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x1, #0x10               // =16
               	stur	w1, [x29, #-0xc8]
               	ldr	x1, [x4, x0, lsl #3]
               	sxtw	x1, w1
               	lsr	x2, x1, #60
               	add	x3, x1, x2
               	asr	x5, x3, #4
               	and	x3, x3, #0xf
               	sub	x2, x3, x2
               	ldursw	x3, [x29, #-0xc8]
               	sdiv	w3, w1, w3
               	ldursw	x6, [x29, #-0xc8]
               	sdiv	w17, w1, w6
               	msub	w1, w17, w6, w1
               	cmp	w5, w3
               	b.ne	<addr>
               	cmp	w2, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0xf0]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0xf0]
               	mov	x0, #0x0                // =0
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x1, #-0x10              // =-16
               	stur	w1, [x29, #-0xc0]
               	ldr	x1, [x4, x0, lsl #3]
               	sxtw	x1, w1
               	lsr	x2, x1, #60
               	add	x3, x1, x2
               	asr	x5, x3, #4
               	neg	x5, x5
               	and	x3, x3, #0xf
               	sub	x2, x3, x2
               	ldursw	x3, [x29, #-0xc0]
               	sdiv	w3, w1, w3
               	ldursw	x6, [x29, #-0xc0]
               	sdiv	w17, w1, w6
               	msub	w1, w17, w6, w1
               	cmp	w5, w3
               	b.ne	<addr>
               	cmp	w2, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0xf0]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0xf0]
               	mov	x0, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x1, #0x1                // =1
               	stur	w1, [x29, #-0xb8]
               	ldr	x1, [x2, x0, lsl #3]
               	ldursw	x3, [x29, #-0xb8]
               	sdiv	w3, w1, w3
               	ldursw	x4, [x29, #-0xb8]
               	sdiv	w17, w1, w4
               	msub	w4, w17, w4, w1
               	cmp	w1, w3
               	b.ne	<addr>
               	cbnz	w4, <addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0xf0]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0xf0]
               	mov	x0, #0x0                // =0
               	mov	x2, #-0x80000000        // =-2147483648
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x1, #-0x1               // =-1
               	stur	w1, [x29, #-0xb0]
               	ldr	x1, [x3, x0, lsl #3]
               	cmp	w1, w2
               	b.eq	<addr>
               	neg	x4, x1
               	ldursw	x5, [x29, #-0xb0]
               	sdiv	w5, w1, w5
               	ldursw	x6, [x29, #-0xb0]
               	sdiv	w17, w1, w6
               	msub	w1, w17, w6, w1
               	cmp	w4, w5
               	b.ne	<addr>
               	cbnz	w1, <addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0xf0]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0xf0]
               	mov	x0, #0x0                // =0
               	mov	x3, #0x1                // =1
               	movk	x3, #0x4000, lsl #16
               	mov	x4, #0x7fffffff         // =2147483647
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, #0x7fffffff         // =2147483647
               	stur	w1, [x29, #-0xa8]
               	ldr	x1, [x5, x0, lsl #3]
               	sxtw	x1, w1
               	mul	x2, x1, x3
               	asr	x2, x2, #61
               	add	x2, x2, x2, lsr #63
               	mul	x6, x2, x4
               	sub	x6, x1, x6
               	ldursw	x7, [x29, #-0xa8]
               	sdiv	w7, w1, w7
               	ldursw	x8, [x29, #-0xa8]
               	sdiv	w17, w1, w8
               	msub	w1, w17, w8, w1
               	cmp	w2, w7
               	b.ne	<addr>
               	cmp	w6, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0xf0]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0xf0]
               	mov	x0, #0x0                // =0
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x1, #-0x80000000        // =-2147483648
               	stur	w1, [x29, #-0xa0]
               	ldr	x1, [x4, x0, lsl #3]
               	sxtw	x1, w1
               	lsr	x2, x1, #33
               	add	x3, x1, x2
               	asr	x5, x3, #31
               	neg	x5, x5
               	and	x3, x3, #0x7fffffff
               	sub	x2, x3, x2
               	ldursw	x3, [x29, #-0xa0]
               	sdiv	w3, w1, w3
               	ldursw	x6, [x29, #-0xa0]
               	sdiv	w17, w1, w6
               	msub	w1, w17, w6, w1
               	cmp	w5, w3
               	b.ne	<addr>
               	cmp	w2, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0xf0]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0xf0]
               	mov	x0, #0x0                // =0
               	mov	x4, #0xa                // =10
               	mov	x5, #0x6667             // =26215
               	movk	x5, #0x6666, lsl #16
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x1, #0xa                // =10
               	stur	w1, [x29, #-0x98]
               	ldr	x1, [x6, x0, lsl #3]
               	mov	w2, w1
               	lsr	x3, x2, #1
               	mul	x3, x3, x5
               	lsr	x3, x3, #33
               	mul	x7, x3, x4
               	sub	x2, x2, x7
               	ldur	w7, [x29, #-0x98]
               	udiv	w7, w1, w7
               	ldur	w8, [x29, #-0x98]
               	udiv	w17, w1, w8
               	msub	w1, w17, w8, w1
               	cmp	w3, w7
               	b.ne	<addr>
               	cmp	w2, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0xf0]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0xf0]
               	mov	x0, #0x0                // =0
               	mov	x4, #0x7                // =7
               	mov	x5, #0x4925             // =18725
               	movk	x5, #0x2492, lsl #16
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x1, #0x7                // =7
               	stur	w1, [x29, #-0x90]
               	ldr	x1, [x6, x0, lsl #3]
               	mov	w2, w1
               	mul	x3, x2, x5
               	lsr	x3, x3, #32
               	sub	x7, x2, x3
               	add	x3, x3, x7, lsr #1
               	lsr	x3, x3, #2
               	mul	x7, x3, x4
               	sub	x2, x2, x7
               	ldur	w7, [x29, #-0x90]
               	udiv	w7, w1, w7
               	ldur	w8, [x29, #-0x90]
               	udiv	w17, w1, w8
               	msub	w1, w17, w8, w1
               	cmp	w3, w7
               	b.ne	<addr>
               	cmp	w2, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0xf0]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0xf0]
               	mov	x0, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x1, #0x8                // =8
               	stur	w1, [x29, #-0x88]
               	ldr	x1, [x2, x0, lsl #3]
               	mov	w3, w1
               	lsr	x3, x3, #3
               	and	x4, x1, #0x7
               	ldur	w5, [x29, #-0x88]
               	udiv	w5, w1, w5
               	ldur	w6, [x29, #-0x88]
               	udiv	w17, w1, w6
               	msub	w1, w17, w6, w1
               	cmp	w3, w5
               	b.ne	<addr>
               	cmp	w4, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0xf0]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0xf0]
               	mov	x0, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x1, #0x1                // =1
               	stur	w1, [x29, #-0x80]
               	ldr	x1, [x2, x0, lsl #3]
               	ldur	w3, [x29, #-0x80]
               	udiv	w3, w1, w3
               	ldur	w4, [x29, #-0x80]
               	udiv	w17, w1, w4
               	msub	w4, w17, w4, w1
               	cmp	w1, w3
               	b.ne	<addr>
               	cbnz	w4, <addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0xf0]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0xf0]
               	mov	x0, #0x0                // =0
               	mov	x1, #0x1                // =1
               	movk	x1, #0x8000, lsl #16
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	stur	w1, [x29, #-0x78]
               	ldr	x2, [x4, x0, lsl #3]
               	cmp	w2, w1
               	cset	x5, hs
               	mov	w3, w2
               	cmp	x3, x1
               	cset	x6, hs
               	mul	x6, x6, x1
               	sub	x3, x3, x6
               	ldur	w6, [x29, #-0x78]
               	udiv	w6, w2, w6
               	ldur	w7, [x29, #-0x78]
               	udiv	w17, w2, w7
               	msub	w2, w17, w7, w2
               	cmp	w5, w6
               	b.ne	<addr>
               	cmp	w3, w2
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0xf0]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0xf0]
               	mov	x0, #0x0                // =0
               	mov	x1, #0x2800             // =10240
               	movk	x1, #0xee6b, lsl #16
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	stur	w1, [x29, #-0x70]
               	ldr	x2, [x4, x0, lsl #3]
               	cmp	w2, w1
               	cset	x5, hs
               	mov	w3, w2
               	cmp	x3, x1
               	cset	x6, hs
               	mul	x6, x6, x1
               	sub	x3, x3, x6
               	ldur	w6, [x29, #-0x70]
               	udiv	w6, w2, w6
               	ldur	w7, [x29, #-0x70]
               	udiv	w17, w2, w7
               	msub	w2, w17, w7, w2
               	cmp	w5, w6
               	b.ne	<addr>
               	cmp	w3, w2
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0xf0]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0xf0]
               	mov	x0, #0x0                // =0
               	mov	x2, #0xffffffff         // =4294967295
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x1, #0xffffffff         // =4294967295
               	stur	w1, [x29, #-0x68]
               	ldr	x1, [x4, x0, lsl #3]
               	cmp	w1, w2
               	cset	x5, hs
               	mov	w3, w1
               	cmp	x3, x2
               	cset	x6, hs
               	mul	x6, x6, x2
               	sub	x3, x3, x6
               	ldur	w6, [x29, #-0x68]
               	udiv	w6, w1, w6
               	ldur	w7, [x29, #-0x68]
               	udiv	w17, w1, w7
               	msub	w1, w17, w7, w1
               	cmp	w5, w6
               	b.ne	<addr>
               	cmp	w3, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0xf0]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0xf0]
               	mov	x0, #0x0                // =0
               	mov	x3, #0xa                // =10
               	mov	x4, #0x5555555555555555 // =6148914691236517205
               	mov	x5, #0x6667             // =26215
               	movk	x5, #0x6666, lsl #16
               	movk	x5, #0x6666, lsl #32
               	movk	x5, #0x6666, lsl #48
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x1, #0xa                // =10
               	stur	x1, [x29, #-0x60]
               	ldr	x1, [x6, x0, lsl #3]
               	cmp	x1, x4
               	b.eq	<addr>
               	smulh	x2, x1, x5
               	asr	x2, x2, #2
               	add	x2, x2, x2, lsr #63
               	mul	x7, x2, x3
               	sub	x7, x1, x7
               	ldur	x8, [x29, #-0x60]
               	sdiv	x8, x1, x8
               	ldur	x9, [x29, #-0x60]
               	sdiv	x17, x1, x9
               	msub	x1, x17, x9, x1
               	cmp	x2, x8
               	b.ne	<addr>
               	cmp	x7, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0xf0]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0xf0]
               	mov	x0, #0x0                // =0
               	mov	x3, #-0x3e8             // =-1000
               	mov	x4, #0xf7cf             // =63439
               	movk	x4, #0xe353, lsl #16
               	movk	x4, #0x9ba5, lsl #32
               	movk	x4, #0x20c4, lsl #48
               	mov	x5, #0x5555555555555555 // =6148914691236517205
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x1, #-0x3e8             // =-1000
               	stur	x1, [x29, #-0x58]
               	ldr	x1, [x6, x0, lsl #3]
               	cmp	x1, x5
               	b.eq	<addr>
               	smulh	x2, x1, x4
               	asr	x2, x2, #7
               	add	x2, x2, x2, lsr #63
               	neg	x2, x2
               	mul	x7, x2, x3
               	sub	x7, x1, x7
               	ldur	x8, [x29, #-0x58]
               	sdiv	x8, x1, x8
               	ldur	x9, [x29, #-0x58]
               	sdiv	x17, x1, x9
               	msub	x1, x17, x9, x1
               	cmp	x2, x8
               	b.ne	<addr>
               	cmp	x7, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0xf0]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0xf0]
               	mov	x0, #0x0                // =0
               	mov	x4, #0x5555555555555555 // =6148914691236517205
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, #0x1000             // =4096
               	stur	x1, [x29, #-0x50]
               	ldr	x1, [x5, x0, lsl #3]
               	cmp	x1, x4
               	b.eq	<addr>
               	asr	x2, x1, #63
               	lsr	x2, x2, #52
               	add	x3, x1, x2
               	asr	x6, x3, #12
               	and	x3, x3, #0xfff
               	sub	x2, x3, x2
               	ldur	x3, [x29, #-0x50]
               	sdiv	x3, x1, x3
               	ldur	x7, [x29, #-0x50]
               	sdiv	x17, x1, x7
               	msub	x1, x17, x7, x1
               	cmp	x6, x3
               	b.ne	<addr>
               	cmp	x2, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0xf0]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0xf0]
               	mov	x0, #0x0                // =0
               	mov	x2, #-0x8000000000000000 // =-9223372036854775808
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x1, #-0x1               // =-1
               	stur	x1, [x29, #-0x48]
               	ldr	x1, [x3, x0, lsl #3]
               	cmp	x1, x2
               	b.eq	<addr>
               	neg	x4, x1
               	ldur	x5, [x29, #-0x48]
               	sdiv	x5, x1, x5
               	ldur	x6, [x29, #-0x48]
               	sdiv	x17, x1, x6
               	msub	x1, x17, x6, x1
               	cmp	x4, x5
               	b.ne	<addr>
               	cbnz	x1, <addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0xf0]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0xf0]
               	mov	x0, #0x0                // =0
               	mov	x4, #0x5555555555555555 // =6148914691236517205
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	stur	x1, [x29, #-0x40]
               	ldr	x1, [x5, x0, lsl #3]
               	cmp	x1, x4
               	b.eq	<addr>
               	asr	x2, x1, #63
               	lsr	x2, x2, #1
               	add	x3, x1, x2
               	asr	x6, x3, #63
               	neg	x6, x6
               	and	x3, x3, #0x7fffffffffffffff
               	sub	x2, x3, x2
               	ldur	x3, [x29, #-0x40]
               	sdiv	x3, x1, x3
               	ldur	x7, [x29, #-0x40]
               	sdiv	x17, x1, x7
               	msub	x1, x17, x7, x1
               	cmp	x6, x3
               	b.ne	<addr>
               	cmp	x2, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0xf0]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0xf0]
               	mov	x0, #0x0                // =0
               	mov	x3, #0xa                // =10
               	mov	x4, #0x5555555555555555 // =6148914691236517205
               	mov	x5, #0x6667             // =26215
               	movk	x5, #0x6666, lsl #16
               	movk	x5, #0x6666, lsl #32
               	movk	x5, #0x6666, lsl #48
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x1, #0xa                // =10
               	stur	x1, [x29, #-0x38]
               	ldr	x1, [x6, x0, lsl #3]
               	cmp	x1, x4
               	b.eq	<addr>
               	lsr	x2, x1, #1
               	umulh	x2, x2, x5
               	lsr	x2, x2, #1
               	mul	x7, x2, x3
               	sub	x7, x1, x7
               	ldur	x8, [x29, #-0x38]
               	udiv	x8, x1, x8
               	ldur	x9, [x29, #-0x38]
               	udiv	x17, x1, x9
               	msub	x1, x17, x9, x1
               	cmp	x2, x8
               	b.ne	<addr>
               	cmp	x7, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0xf0]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0xf0]
               	mov	x1, #0x0                // =0
               	mov	x3, #0x7                // =7
               	mov	x4, #0x2493             // =9363
               	movk	x4, #0x9249, lsl #16
               	movk	x4, #0x4924, lsl #32
               	movk	x4, #0x2492, lsl #48
               	mov	x5, #0x5555555555555555 // =6148914691236517205
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, #0x7                // =7
               	stur	x0, [x29, #-0x30]
               	ldr	x0, [x6, x1, lsl #3]
               	cmp	x0, x5
               	b.eq	<addr>
               	umulh	x2, x0, x4
               	sub	x7, x0, x2
               	add	x2, x2, x7, lsr #1
               	lsr	x2, x2, #2
               	mul	x7, x2, x3
               	sub	x7, x0, x7
               	ldur	x8, [x29, #-0x30]
               	udiv	x8, x0, x8
               	ldur	x9, [x29, #-0x30]
               	udiv	x17, x0, x9
               	msub	x0, x17, x9, x0
               	cmp	x2, x8
               	b.ne	<addr>
               	cmp	x7, x0
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0xf0]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0xf0]
               	mov	x0, #0x0                // =0
               	mov	x2, #-0x7fffffffffffffff // =-9223372036854775807
               	mov	x4, #0x5555555555555555 // =6148914691236517205
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, #-0x7fffffffffffffff // =-9223372036854775807
               	stur	x1, [x29, #-0x28]
               	ldr	x1, [x5, x0, lsl #3]
               	cmp	x1, x4
               	b.eq	<addr>
               	cmp	x1, x2
               	cset	x3, hs
               	mul	x6, x3, x2
               	sub	x6, x1, x6
               	ldur	x7, [x29, #-0x28]
               	udiv	x7, x1, x7
               	ldur	x8, [x29, #-0x28]
               	udiv	x17, x1, x8
               	msub	x1, x17, x8, x1
               	cmp	x3, x7
               	b.ne	<addr>
               	cmp	x6, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0xf0]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0xf0]
               	mov	x1, #0x0                // =0
               	mov	x3, #0xd70b             // =55051
               	movk	x3, #0x70a3, lsl #16
               	movk	x3, #0xa3d, lsl #32
               	movk	x3, #0xa3d7, lsl #48
               	mov	x4, #0x64               // =100
               	mov	x5, #0x5555555555555555 // =6148914691236517205
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, #0x64               // =100
               	stur	x0, [x29, #-0x20]
               	ldr	x0, [x6, x1, lsl #3]
               	cmp	x0, x5
               	b.eq	<addr>
               	smulh	x2, x0, x3
               	add	x2, x2, x0
               	asr	x2, x2, #6
               	add	x2, x2, x2, lsr #63
               	mul	x7, x2, x4
               	sub	x7, x0, x7
               	ldur	x8, [x29, #-0x20]
               	sdiv	x8, x0, x8
               	ldur	x9, [x29, #-0x20]
               	sdiv	x17, x0, x9
               	msub	x0, x17, x9, x0
               	cmp	x2, x8
               	b.ne	<addr>
               	cmp	x7, x0
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0xf0]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0xf0]
               	mov	x0, #0x0                // =0
               	mov	x3, #-0x3               // =-3
               	mov	x4, #0x5555555555555555 // =6148914691236517205
               	mov	x5, #0x5556             // =21846
               	movk	x5, #0x5555, lsl #16
               	movk	x5, #0x5555, lsl #32
               	movk	x5, #0x5555, lsl #48
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x1, #-0x3               // =-3
               	stur	x1, [x29, #-0x18]
               	ldr	x1, [x6, x0, lsl #3]
               	cmp	x1, x4
               	b.eq	<addr>
               	smulh	x2, x1, x5
               	add	x2, x2, x2, lsr #63
               	neg	x2, x2
               	mul	x7, x2, x3
               	sub	x7, x1, x7
               	ldur	x8, [x29, #-0x18]
               	sdiv	x8, x1, x8
               	ldur	x9, [x29, #-0x18]
               	sdiv	x17, x1, x9
               	msub	x1, x17, x9, x1
               	cmp	x2, x8
               	b.ne	<addr>
               	cmp	x7, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0xf0]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0xf0]
               	mov	x0, #0x0                // =0
               	mov	x3, #0x64               // =100
               	mov	x4, #0xf5c3             // =62915
               	movk	x4, #0x5c28, lsl #16
               	movk	x4, #0xc28f, lsl #32
               	movk	x4, #0x28f5, lsl #48
               	mov	x5, #0x5555555555555555 // =6148914691236517205
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x1, #0x64               // =100
               	stur	x1, [x29, #-0x10]
               	ldr	x1, [x6, x0, lsl #3]
               	cmp	x1, x5
               	b.eq	<addr>
               	lsr	x2, x1, #2
               	umulh	x2, x2, x4
               	lsr	x2, x2, #2
               	mul	x7, x2, x3
               	sub	x7, x1, x7
               	ldur	x8, [x29, #-0x10]
               	udiv	x8, x1, x8
               	ldur	x9, [x29, #-0x10]
               	udiv	x17, x1, x9
               	msub	x1, x17, x9, x1
               	cmp	x2, x8
               	b.ne	<addr>
               	cmp	x7, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0xf0]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0xf0]
               	mov	x1, #0x0                // =0
               	mov	x3, #0x7                // =7
               	mov	x4, #0x2493             // =9363
               	movk	x4, #0x9249, lsl #16
               	movk	x4, #0x4924, lsl #32
               	movk	x4, #0x2492, lsl #48
               	mov	x5, #0x5555555555555555 // =6148914691236517205
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, #0x7                // =7
               	stur	x0, [x29, #-0x8]
               	ldr	x0, [x6, x1, lsl #3]
               	cmp	x0, x5
               	b.eq	<addr>
               	umulh	x2, x0, x4
               	sub	x7, x0, x2
               	add	x2, x2, x7, lsr #1
               	lsr	x2, x2, #2
               	mul	x7, x2, x3
               	sub	x7, x0, x7
               	ldur	x8, [x29, #-0x8]
               	udiv	x8, x0, x8
               	ldur	x9, [x29, #-0x8]
               	udiv	x17, x0, x9
               	msub	x0, x17, x9, x0
               	cmp	x2, x8
               	b.ne	<addr>
               	cmp	x7, x0
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x18
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	x0, x0, #0x64
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	x0, x0, #0x64
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	x0, x0, #0x64
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	x0, x0, #0x64
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	x0, x0, #0x64
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	x0, x0, #0x64
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	x0, x0, #0x64
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	x0, x0, #0x64
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	x0, x0, #0x64
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	x0, x0, #0x64
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	x0, x0, #0x64
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	x0, x0, #0x64
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	x0, x0, #0x64
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	x0, x0, #0x64
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	x0, x0, #0x64
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	x0, x0, #0x64
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	x0, x0, #0x64
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	x0, x0, #0x64
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	x0, x0, #0x64
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	x0, x0, #0x64
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	x0, x0, #0x64
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	x0, x0, #0x64
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	x0, x0, #0x64
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	x0, x0, #0x64
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	x0, x0, #0x64
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	x0, x0, #0x64
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	x0, x0, #0x64
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	x0, x0, #0x64
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret

<converted>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xb0
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0xf0]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0xf0]
               	mov	x0, #0x0                // =0
               	mov	x3, #0x3                // =3
               	mov	x4, #0x5556             // =21846
               	movk	x4, #0x5555, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, #0x3                // =3
               	stur	w1, [x29, #-0xa8]
               	ldr	x1, [x5, x0, lsl #3]
               	sxtb	x1, w1
               	mul	x2, x1, x4
               	asr	x2, x2, #32
               	add	x2, x2, x2, lsr #63
               	mul	x6, x2, x3
               	sub	x6, x1, x6
               	ldursw	x7, [x29, #-0xa8]
               	sdiv	x7, x1, x7
               	sxtb	x7, w7
               	ldursw	x8, [x29, #-0xa8]
               	sdiv	x17, x1, x8
               	msub	x1, x17, x8, x1
               	cmp	w2, w7
               	b.ne	<addr>
               	cmp	w6, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0xf0]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0xf0]
               	mov	x0, #0x0                // =0
               	mov	x3, #-0x5               // =-5
               	mov	x4, #0x6667             // =26215
               	movk	x4, #0x6666, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, #-0x5               // =-5
               	stur	w1, [x29, #-0xa0]
               	ldr	x1, [x5, x0, lsl #3]
               	sxtb	x1, w1
               	mul	x2, x1, x4
               	asr	x2, x2, #33
               	add	x2, x2, x2, lsr #63
               	neg	x2, x2
               	mul	x6, x2, x3
               	sub	x6, x1, x6
               	ldursw	x7, [x29, #-0xa0]
               	sdiv	x7, x1, x7
               	sxtb	x7, w7
               	ldursw	x8, [x29, #-0xa0]
               	sdiv	x17, x1, x8
               	msub	x1, x17, x8, x1
               	cmp	w2, w7
               	b.ne	<addr>
               	cmp	w6, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0xf0]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0xf0]
               	mov	x0, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x1, #-0x1               // =-1
               	stur	w1, [x29, #-0x98]
               	ldr	x1, [x2, x0, lsl #3]
               	sxtb	x1, w1
               	neg	x3, x1
               	sxtb	x3, w3
               	ldursw	x4, [x29, #-0x98]
               	sdiv	x4, x1, x4
               	sxtb	x4, w4
               	ldursw	x5, [x29, #-0x98]
               	sdiv	x17, x1, x5
               	msub	x1, x17, x5, x1
               	cmp	w3, w4
               	b.ne	<addr>
               	cbnz	w1, <addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0xf0]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0xf0]
               	mov	x0, #0x0                // =0
               	mov	x3, #0x3                // =3
               	mov	x4, #0x5556             // =21846
               	movk	x4, #0x5555, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, #0x3                // =3
               	stur	w1, [x29, #-0x90]
               	ldr	x1, [x5, x0, lsl #3]
               	and	x1, x1, #0xff
               	mul	x2, x1, x4
               	lsr	x2, x2, #32
               	mul	x6, x2, x3
               	sub	x6, x1, x6
               	ldursw	x7, [x29, #-0x90]
               	sdiv	x7, x1, x7
               	and	x7, x7, #0xff
               	ldursw	x8, [x29, #-0x90]
               	sdiv	x17, x1, x8
               	msub	x1, x17, x8, x1
               	cmp	w2, w7
               	b.ne	<addr>
               	cmp	w6, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0xf0]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0xf0]
               	mov	x0, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x1, #0x10               // =16
               	stur	w1, [x29, #-0x88]
               	ldr	x1, [x2, x0, lsl #3]
               	and	x1, x1, #0xff
               	lsr	x3, x1, #4
               	and	x4, x1, #0xf
               	ldursw	x5, [x29, #-0x88]
               	sdiv	x5, x1, x5
               	and	x5, x5, #0xff
               	ldursw	x6, [x29, #-0x88]
               	sdiv	x17, x1, x6
               	msub	x1, x17, x6, x1
               	cmp	w3, w5
               	b.ne	<addr>
               	cmp	w4, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0xf0]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0xf0]
               	mov	x0, #0x0                // =0
               	mov	x3, #-0x7               // =-7
               	mov	x4, #0x2493             // =9363
               	movk	x4, #0x9249, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, #-0x7               // =-7
               	stur	w1, [x29, #-0x80]
               	ldr	x1, [x5, x0, lsl #3]
               	and	x1, x1, #0xff
               	mul	x2, x1, x4
               	asr	x2, x2, #34
               	add	x2, x2, x2, lsr #63
               	neg	x2, x2
               	and	x6, x2, #0xff
               	mul	x2, x2, x3
               	sub	x2, x1, x2
               	ldursw	x7, [x29, #-0x80]
               	sdiv	x7, x1, x7
               	and	x7, x7, #0xff
               	ldursw	x8, [x29, #-0x80]
               	sdiv	x17, x1, x8
               	msub	x1, x17, x8, x1
               	cmp	w6, w7
               	b.ne	<addr>
               	cmp	w2, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0xf0]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0xf0]
               	mov	x0, #0x0                // =0
               	mov	x3, #0xa                // =10
               	mov	x4, #0x6667             // =26215
               	movk	x4, #0x6666, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, #0xa                // =10
               	stur	w1, [x29, #-0x78]
               	ldr	x1, [x5, x0, lsl #3]
               	sxth	x1, w1
               	mul	x2, x1, x4
               	asr	x2, x2, #34
               	add	x2, x2, x2, lsr #63
               	mul	x6, x2, x3
               	sub	x6, x1, x6
               	ldursw	x7, [x29, #-0x78]
               	sdiv	x7, x1, x7
               	sxth	x7, w7
               	ldursw	x8, [x29, #-0x78]
               	sdiv	x17, x1, x8
               	msub	x1, x17, x8, x1
               	cmp	w2, w7
               	b.ne	<addr>
               	cmp	w6, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0xf0]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0xf0]
               	mov	x0, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x1, #-0x1               // =-1
               	stur	w1, [x29, #-0x70]
               	ldr	x1, [x2, x0, lsl #3]
               	sxth	x1, w1
               	neg	x3, x1
               	sxth	x3, w3
               	ldursw	x4, [x29, #-0x70]
               	sdiv	x4, x1, x4
               	sxth	x4, w4
               	ldursw	x5, [x29, #-0x70]
               	sdiv	x17, x1, x5
               	msub	x1, x17, x5, x1
               	cmp	w3, w4
               	b.ne	<addr>
               	cbnz	w1, <addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0xf0]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0xf0]
               	mov	x0, #0x0                // =0
               	mov	x3, #0x3e8              // =1000
               	mov	x4, #0x8938             // =35128
               	movk	x4, #0x41, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, #0x3e8              // =1000
               	stur	w1, [x29, #-0x68]
               	ldr	x1, [x5, x0, lsl #3]
               	and	x1, x1, #0xffff
               	mul	x2, x1, x4
               	lsr	x2, x2, #32
               	mul	x6, x2, x3
               	sub	x6, x1, x6
               	ldursw	x7, [x29, #-0x68]
               	sdiv	x7, x1, x7
               	and	x7, x7, #0xffff
               	ldursw	x8, [x29, #-0x68]
               	sdiv	x17, x1, x8
               	msub	x1, x17, x8, x1
               	cmp	w2, w7
               	b.ne	<addr>
               	cmp	w6, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0xf0]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0xf0]
               	mov	x0, #0x0                // =0
               	mov	x3, #0x7                // =7
               	mov	x4, #0x4925             // =18725
               	movk	x4, #0x2492, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, #0x7                // =7
               	stur	w1, [x29, #-0x60]
               	ldr	x1, [x5, x0, lsl #3]
               	and	x1, x1, #0xffff
               	mul	x2, x1, x4
               	lsr	x2, x2, #32
               	mul	x6, x2, x3
               	sub	x6, x1, x6
               	ldur	w7, [x29, #-0x60]
               	udiv	w7, w1, w7
               	ldur	w8, [x29, #-0x60]
               	udiv	w17, w1, w8
               	msub	w1, w17, w8, w1
               	cmp	w2, w7
               	b.ne	<addr>
               	cmp	w6, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0xf0]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0xf0]
               	mov	x0, #0x0                // =0
               	mov	x4, #0x3                // =3
               	mov	x5, #0xaaab             // =43691
               	movk	x5, #0xaaaa, lsl #16
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x1, #0x3                // =3
               	stur	w1, [x29, #-0x58]
               	ldr	x1, [x6, x0, lsl #3]
               	mov	w2, w1
               	mul	x3, x2, x5
               	lsr	x3, x3, #33
               	mul	x7, x3, x4
               	sub	x2, x2, x7
               	ldur	w7, [x29, #-0x58]
               	udiv	w7, w1, w7
               	ldur	w8, [x29, #-0x58]
               	udiv	w17, w1, w8
               	msub	w1, w17, w8, w1
               	cmp	w3, w7
               	b.ne	<addr>
               	cmp	w2, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0xf0]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0xf0]
               	mov	x0, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x1, #0x80000000         // =2147483648
               	stur	w1, [x29, #-0x50]
               	ldr	x1, [x2, x0, lsl #3]
               	mov	w3, w1
               	lsr	x3, x3, #31
               	and	x4, x1, #0x7fffffff
               	ldur	w5, [x29, #-0x50]
               	udiv	w5, w1, w5
               	ldur	w6, [x29, #-0x50]
               	udiv	w17, w1, w6
               	msub	w1, w17, w6, w1
               	cmp	w3, w5
               	b.ne	<addr>
               	cmp	w4, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0xf0]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0xf0]
               	mov	x0, #0x0                // =0
               	mov	x3, #0x3                // =3
               	mov	x4, #0x5556             // =21846
               	movk	x4, #0x5555, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, #0x3                // =3
               	stur	x1, [x29, #-0x48]
               	ldr	x1, [x5, x0, lsl #3]
               	sxtw	x1, w1
               	mul	x2, x1, x4
               	asr	x2, x2, #32
               	add	x2, x2, x2, lsr #63
               	mul	x6, x2, x3
               	sub	x6, x1, x6
               	ldur	x7, [x29, #-0x48]
               	sdiv	x7, x1, x7
               	ldur	x8, [x29, #-0x48]
               	sdiv	x17, x1, x8
               	msub	x1, x17, x8, x1
               	cmp	w2, w7
               	b.ne	<addr>
               	cmp	w6, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0xf0]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0xf0]
               	mov	x0, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x1, #0x100000000        // =4294967296
               	stur	x1, [x29, #-0x40]
               	ldr	x1, [x2, x0, lsl #3]
               	sxtw	x1, w1
               	ldur	x3, [x29, #-0x40]
               	sdiv	x3, x1, x3
               	ldur	x4, [x29, #-0x40]
               	sdiv	x17, x1, x4
               	msub	x4, x17, x4, x1
               	cbnz	w3, <addr>
               	cmp	w1, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0xf0]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0xf0]
               	mov	x0, #0x0                // =0
               	mov	x3, #0x7                // =7
               	mov	x4, #0x2493             // =9363
               	movk	x4, #0x9249, lsl #16
               	movk	x4, #0x4924, lsl #32
               	movk	x4, #0x2492, lsl #48
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, #0x7                // =7
               	stur	x1, [x29, #-0x38]
               	ldr	x1, [x5, x0, lsl #3]
               	sxtw	x1, w1
               	umulh	x2, x1, x4
               	sub	x6, x1, x2
               	add	x2, x2, x6, lsr #1
               	lsr	x2, x2, #2
               	mul	x6, x2, x3
               	sub	x6, x1, x6
               	ldur	x7, [x29, #-0x38]
               	udiv	x7, x1, x7
               	ldur	x8, [x29, #-0x38]
               	udiv	x17, x1, x8
               	msub	x1, x17, x8, x1
               	cmp	w2, w7
               	b.ne	<addr>
               	cmp	w6, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0xf0]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0xf0]
               	mov	x0, #0x0                // =0
               	mov	x3, #0x7                // =7
               	mov	x4, #0x4925             // =18725
               	movk	x4, #0x2492, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, #0x7                // =7
               	stur	x1, [x29, #-0x30]
               	ldr	x1, [x5, x0, lsl #3]
               	mov	w1, w1
               	mul	x2, x1, x4
               	lsr	x2, x2, #32
               	sub	x6, x1, x2
               	add	x2, x2, x6, lsr #1
               	lsr	x2, x2, #2
               	mul	x6, x2, x3
               	sub	x6, x1, x6
               	ldur	x7, [x29, #-0x30]
               	sdiv	x7, x1, x7
               	ldur	x8, [x29, #-0x30]
               	sdiv	x17, x1, x8
               	msub	x1, x17, x8, x1
               	cmp	w2, w7
               	b.ne	<addr>
               	cmp	w6, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0xf0]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0xf0]
               	mov	x0, #0x0                // =0
               	mov	x3, #-0x7               // =-7
               	mov	x4, #0x4925             // =18725
               	movk	x4, #0x2492, lsl #16
               	movk	x4, #0x9249, lsl #32
               	movk	x4, #0x4924, lsl #48
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, #-0x7               // =-7
               	stur	x1, [x29, #-0x28]
               	ldr	x1, [x5, x0, lsl #3]
               	mov	w1, w1
               	smulh	x2, x1, x4
               	asr	x2, x2, #1
               	add	x2, x2, x2, lsr #63
               	neg	x2, x2
               	mul	x6, x2, x3
               	sub	x6, x1, x6
               	ldur	x7, [x29, #-0x28]
               	sdiv	x7, x1, x7
               	ldur	x8, [x29, #-0x28]
               	sdiv	x17, x1, x8
               	msub	x1, x17, x8, x1
               	cmp	w2, w7
               	b.ne	<addr>
               	cmp	w6, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0xf0]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0xf0]
               	mov	x0, #0x0                // =0
               	mov	x3, #0xa                // =10
               	mov	x4, #0x6667             // =26215
               	movk	x4, #0x6666, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, #0xa                // =10
               	stur	x1, [x29, #-0x20]
               	ldr	x1, [x5, x0, lsl #3]
               	mov	w1, w1
               	lsr	x2, x1, #1
               	mul	x2, x2, x4
               	lsr	x2, x2, #33
               	mul	x6, x2, x3
               	sub	x6, x1, x6
               	ldur	x7, [x29, #-0x20]
               	udiv	x7, x1, x7
               	ldur	x8, [x29, #-0x20]
               	udiv	x17, x1, x8
               	msub	x1, x17, x8, x1
               	cmp	w2, w7
               	b.ne	<addr>
               	cmp	w6, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0xf0]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0xf0]
               	mov	x0, #0x0                // =0
               	mov	x3, #0xe38f             // =58255
               	movk	x3, #0x8e38, lsl #16
               	movk	x3, #0x38e3, lsl #32
               	movk	x3, #0xe38e, lsl #48
               	mov	x4, #0x9                // =9
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, #0x9                // =9
               	stur	x1, [x29, #-0x18]
               	ldr	x1, [x5, x0, lsl #3]
               	sxth	x1, w1
               	umulh	x2, x1, x3
               	lsr	x2, x2, #3
               	sxth	x6, w2
               	mul	x2, x2, x4
               	sub	x2, x1, x2
               	ldur	x7, [x29, #-0x18]
               	udiv	x7, x1, x7
               	sxth	x7, w7
               	ldur	x8, [x29, #-0x18]
               	udiv	x17, x1, x8
               	msub	x1, x17, x8, x1
               	sxth	x1, w1
               	cmp	w6, w7
               	b.ne	<addr>
               	cmp	w2, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0xf0]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0xf0]
               	mov	x0, #0x0                // =0
               	mov	x3, #-0xa               // =-10
               	mov	x4, #0x5555555555555555 // =6148914691236517205
               	mov	x5, #0x6667             // =26215
               	movk	x5, #0x6666, lsl #16
               	movk	x5, #0x6666, lsl #32
               	movk	x5, #0x6666, lsl #48
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x1, #-0xa               // =-10
               	stur	w1, [x29, #-0x10]
               	ldr	x1, [x6, x0, lsl #3]
               	cmp	x1, x4
               	b.eq	<addr>
               	smulh	x2, x1, x5
               	asr	x2, x2, #2
               	add	x2, x2, x2, lsr #63
               	neg	x2, x2
               	mul	x7, x2, x3
               	sub	x7, x1, x7
               	ldursw	x8, [x29, #-0x10]
               	sdiv	x8, x1, x8
               	ldursw	x9, [x29, #-0x10]
               	sdiv	x17, x1, x9
               	msub	x1, x17, x9, x1
               	cmp	x2, x8
               	b.ne	<addr>
               	cmp	x7, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0xf0]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0xf0]
               	mov	x0, #0x0                // =0
               	mov	x3, #0xa                // =10
               	mov	x4, #0x5555555555555555 // =6148914691236517205
               	mov	x5, #0x6667             // =26215
               	movk	x5, #0x6666, lsl #16
               	movk	x5, #0x6666, lsl #32
               	movk	x5, #0x6666, lsl #48
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x1, #0xa                // =10
               	stur	w1, [x29, #-0x8]
               	ldr	x1, [x6, x0, lsl #3]
               	cmp	x1, x4
               	b.eq	<addr>
               	lsr	x2, x1, #1
               	umulh	x2, x2, x5
               	lsr	x2, x2, #1
               	mul	x7, x2, x3
               	sub	x7, x1, x7
               	ldursw	x8, [x29, #-0x8]
               	udiv	x8, x1, x8
               	ldursw	x9, [x29, #-0x8]
               	udiv	x17, x1, x9
               	msub	x1, x17, x9, x1
               	cmp	x2, x8
               	b.ne	<addr>
               	cmp	x7, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	x0, x0, #0x64
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	x0, x0, #0x64
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	x0, x0, #0x64
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	x0, x0, #0x64
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	x0, x0, #0x64
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	x0, x0, #0x64
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	x0, x0, #0x64
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	x0, x0, #0x64
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	x0, x0, #0x64
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	x0, x0, #0x64
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	x0, x0, #0x64
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	x0, x0, #0x64
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	x0, x0, #0x64
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	x0, x0, #0x64
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	x0, x0, #0x64
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	x0, x0, #0x64
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	x0, x0, #0x64
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	x0, x0, #0x64
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	x0, x0, #0x64
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	x0, x0, #0x64
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	x0, x0, #0x64
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	str	x20, [sp, #-0xb0]!
               	stp	x29, x30, [sp, #0xa0]
               	add	x29, sp, #0xa0
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	str	xzr, [x20]
               	mov	x0, #0x1                // =1
               	str	x0, [x20, #0x8]
               	mov	x0, #-0x1               // =-1
               	str	x0, [x20, #0x10]
               	mov	x0, #0x2                // =2
               	str	x0, [x20, #0x18]
               	mov	x0, #-0x2               // =-2
               	str	x0, [x20, #0x20]
               	mov	x0, #0x7fffffff         // =2147483647
               	str	x0, [x20, #0x28]
               	mov	x0, #-0x80000000        // =-2147483648
               	str	x0, [x20, #0x30]
               	mov	x0, #0x7fffffffffffffff // =9223372036854775807
               	str	x0, [x20, #0x38]
               	mov	x0, #-0x8000000000000000 // =-9223372036854775808
               	str	x0, [x20, #0x40]
               	mov	x0, #0xffffffff         // =4294967295
               	str	x0, [x20, #0x48]
               	mov	x0, #0x7f               // =127
               	str	x0, [x20, #0x50]
               	mov	x0, #-0x80              // =-128
               	str	x0, [x20, #0x58]
               	mov	x0, #0xff               // =255
               	str	x0, [x20, #0x60]
               	mov	x0, #0x7fff             // =32767
               	str	x0, [x20, #0x68]
               	mov	x0, #-0x8000            // =-32768
               	str	x0, [x20, #0x70]
               	mov	x0, #0xffff             // =65535
               	str	x0, [x20, #0x78]
               	mov	x0, #0xbc00             // =48128
               	movk	x0, #0xbf46, lsl #16
               	movk	x0, #0xee21, lsl #32
               	movk	x0, #0x2cea, lsl #48
               	str	x0, [x20, #0x80]
               	mov	x0, #0x8d4f             // =36175
               	movk	x0, #0x1a1a, lsl #16
               	movk	x0, #0x754d, lsl #32
               	movk	x0, #0xaa80, lsl #48
               	str	x0, [x20, #0x88]
               	mov	x0, #0x8932             // =35122
               	movk	x0, #0x6d27, lsl #16
               	movk	x0, #0x904a, lsl #32
               	movk	x0, #0xb3c4, lsl #48
               	str	x0, [x20, #0x90]
               	mov	x0, #0x6d19             // =27929
               	movk	x0, #0x7684, lsl #16
               	movk	x0, #0xcf42, lsl #32
               	movk	x0, #0xbc69, lsl #48
               	str	x0, [x20, #0x98]
               	mov	x0, #0x15b4             // =5556
               	movk	x0, #0x6a5b, lsl #16
               	movk	x0, #0x2fd5, lsl #32
               	movk	x0, #0x377b, lsl #48
               	str	x0, [x20, #0xa0]
               	mov	x0, #0x9df3             // =40435
               	movk	x0, #0xeaf2, lsl #16
               	movk	x0, #0x15de, lsl #32
               	movk	x0, #0x64d8, lsl #48
               	str	x0, [x20, #0xa8]
               	mov	x0, #0xd206             // =53766
               	movk	x0, #0xb2d7, lsl #16
               	movk	x0, #0x100d, lsl #32
               	movk	x0, #0xf66e, lsl #48
               	str	x0, [x20, #0xb0]
               	mov	x0, #0x665d             // =26205
               	movk	x0, #0x7e06, lsl #16
               	movk	x0, #0xe6a5, lsl #32
               	movk	x0, #0x1069, lsl #48
               	str	x0, [x20, #0xb8]
               	bl	<addr>
               	cbz	w0, <addr>
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x20, [sp], #0xb0
               	ret
               	bl	<addr>
               	cbz	w0, <addr>
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x20, [sp], #0xb0
               	ret
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0xf0]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0xf0]
               	mov	x4, #0xa                // =10
               	mov	x1, #0x6667             // =26215
               	movk	x1, #0x6666, lsl #16
               	mov	x0, #0x0                // =0
               	ldr	x2, [x20, x0, lsl #3]
               	stur	w2, [x29, #-0x28]
               	ldr	x2, [x20, x0, lsl #3]
               	stur	w2, [x29, #-0x20]
               	mov	x2, #0xa                // =10
               	stur	w2, [x29, #-0x18]
               	ldursw	x2, [x29, #-0x28]
               	mul	x2, x2, x1
               	asr	x2, x2, #34
               	add	x2, x2, x2, lsr #63
               	stur	w2, [x29, #-0x28]
               	ldursw	x2, [x29, #-0x20]
               	ldursw	x3, [x29, #-0x18]
               	sdiv	x2, x2, x3
               	stur	w2, [x29, #-0x20]
               	ldursw	x2, [x29, #-0x28]
               	ldursw	x3, [x29, #-0x20]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldr	x2, [x20, x0, lsl #3]
               	stur	w2, [x29, #-0x28]
               	ldr	x2, [x20, x0, lsl #3]
               	stur	w2, [x29, #-0x20]
               	ldursw	x2, [x29, #-0x28]
               	mul	x3, x2, x1
               	asr	x3, x3, #34
               	add	x3, x3, x3, lsr #63
               	mul	x3, x3, x4
               	sub	x2, x2, x3
               	stur	w2, [x29, #-0x28]
               	ldursw	x2, [x29, #-0x20]
               	ldursw	x3, [x29, #-0x18]
               	sdiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	stur	w2, [x29, #-0x20]
               	ldursw	x2, [x29, #-0x28]
               	ldursw	x3, [x29, #-0x20]
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0xf0]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0xf0]
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x88
               	ldr	x2, [x20, x0, lsl #3]
               	str	w2, [x1, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	mov	x5, #-0x9               // =-9
               	mov	x3, #0x8e39             // =36409
               	movk	x3, #0x38e3, lsl #16
               	mov	x0, #0x0                // =0
               	mov	x1, #-0x9               // =-9
               	stur	w1, [x29, #-0x10]
               	ldr	x1, [x20, x0, lsl #3]
               	ldursw	x2, [x29, #-0x10]
               	sdiv	w1, w1, w2
               	sxtw	x2, w1
               	sub	x1, x29, #0x88
               	ldrsw	x4, [x1, x0, lsl #2]
               	mul	x4, x4, x3
               	asr	x4, x4, #33
               	add	x4, x4, x4, lsr #63
               	neg	x4, x4
               	str	w4, [x1, x0, lsl #2]
               	cmp	w4, w2
               	b.ne	<addr>
               	cmp	w4, w2
               	b.ne	<addr>
               	ldursw	x4, [x29, #-0x10]
               	sdiv	x17, x2, x4
               	msub	x6, x17, x4, x2
               	ldrsw	x2, [x1, x0, lsl #2]
               	mul	x4, x2, x3
               	asr	x4, x4, #33
               	add	x4, x4, x4, lsr #63
               	neg	x4, x4
               	mul	x4, x4, x5
               	sub	x2, x2, x4
               	str	w2, [x1, x0, lsl #2]
               	mov	x1, x2
               	cmp	w1, w6
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0xf0]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0xf0]
               	mov	x3, #0x3                // =3
               	mov	x2, #0x5556             // =21846
               	movk	x2, #0x5555, lsl #16
               	mov	x6, #0x5556             // =21846
               	movk	x6, #0x5555, lsl #16
               	movk	x6, #0x5555, lsl #32
               	movk	x6, #0x5555, lsl #48
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x4, #0x3                // =3
               	stur	w4, [x29, #-0x8]
               	ldr	x4, [x1, x0, lsl #3]
               	and	x5, x4, #0x7ff
               	ldur	w7, [x29, #-0x30]
               	and	x7, x7, #0xfffffffffffff800
               	orr	x5, x7, x5
               	stur	w5, [x29, #-0x30]
               	ubfx	x4, x4, #0, #11
               	ldur	w7, [x29, #-0x90]
               	and	x7, x7, #0xfffffffffffff800
               	orr	x4, x7, x4
               	stur	w4, [x29, #-0x90]
               	ldr	x7, [x1, x0, lsl #3]
               	and	x7, x7, #0x1fff
               	and	x8, x5, #0xffffffffff0007ff
               	lsl	x5, x7, #11
               	orr	x7, x8, x5
               	stur	w7, [x29, #-0x30]
               	and	x4, x4, #0xffffffffff0007ff
               	orr	x4, x4, x5
               	stur	w4, [x29, #-0x90]
               	ldr	x4, [x1, x0, lsl #3]
               	ldur	x5, [x29, #-0x30]
               	and	x5, x5, #0xffffff
               	lsl	x4, x4, #24
               	orr	x5, x5, x4
               	stur	x5, [x29, #-0x30]
               	asr	x4, x4, #24
               	ldur	x5, [x29, #-0x90]
               	and	x5, x5, #0xffffff
               	orr	x4, x5, x4, lsl #24
               	stur	x4, [x29, #-0x90]
               	ldur	w4, [x29, #-0x90]
               	sbfx	x5, x4, #0, #11
               	mul	x5, x5, x2
               	asr	x5, x5, #32
               	add	x5, x5, x5, lsr #63
               	and	x5, x5, #0x7ff
               	and	x4, x4, #0xfffffffffffff800
               	orr	x4, x4, x5
               	stur	w4, [x29, #-0x90]
               	ldur	w5, [x29, #-0x30]
               	sbfx	x7, x5, #0, #11
               	ldursw	x8, [x29, #-0x8]
               	sdiv	x7, x7, x8
               	and	x7, x7, #0x7ff
               	and	x5, x5, #0xfffffffffffff800
               	orr	x5, x5, x7
               	stur	w5, [x29, #-0x30]
               	mov	w7, w4
               	ubfx	x7, x7, #11, #13
               	mul	x7, x7, x2
               	lsr	x7, x7, #32
               	and	x4, x4, #0xffffffffff0007ff
               	orr	x4, x4, x7, lsl #11
               	stur	w4, [x29, #-0x90]
               	mov	w4, w5
               	ubfx	x4, x4, #11, #13
               	ldursw	x7, [x29, #-0x8]
               	sdiv	x4, x4, x7
               	and	x4, x4, #0x1fff
               	and	x5, x5, #0xffffffffff0007ff
               	orr	x4, x5, x4, lsl #11
               	stur	w4, [x29, #-0x30]
               	ldur	x4, [x29, #-0x90]
               	asr	x5, x4, #24
               	smulh	x5, x5, x6
               	add	x5, x5, x5, lsr #63
               	and	x4, x4, #0xffffff
               	orr	x4, x4, x5, lsl #24
               	stur	x4, [x29, #-0x90]
               	ldur	x5, [x29, #-0x30]
               	asr	x7, x5, #24
               	ldursw	x8, [x29, #-0x8]
               	sdiv	x7, x7, x8
               	and	x5, x5, #0xffffff
               	orr	x5, x5, x7, lsl #24
               	stur	x5, [x29, #-0x30]
               	ldur	w7, [x29, #-0x90]
               	sbfx	x9, x7, #0, #11
               	ldur	w8, [x29, #-0x30]
               	sbfx	x10, x8, #0, #11
               	cmp	w9, w10
               	b.ne	<addr>
               	ubfx	x7, x7, #11, #13
               	ubfx	x8, x8, #11, #13
               	cmp	w7, w8
               	b.ne	<addr>
               	asr	x4, x4, #24
               	asr	x5, x5, #24
               	cmp	x4, x5
               	b.ne	<addr>
               	ldr	x4, [x1, x0, lsl #3]
               	and	x5, x4, #0x7ff
               	ldur	w7, [x29, #-0x30]
               	and	x7, x7, #0xfffffffffffff800
               	orr	x5, x7, x5
               	stur	w5, [x29, #-0x30]
               	ubfx	x4, x4, #0, #11
               	ldur	w7, [x29, #-0x90]
               	and	x7, x7, #0xfffffffffffff800
               	orr	x4, x7, x4
               	stur	w4, [x29, #-0x90]
               	ldr	x7, [x1, x0, lsl #3]
               	and	x7, x7, #0x1fff
               	and	x8, x5, #0xffffffffff0007ff
               	lsl	x5, x7, #11
               	orr	x7, x8, x5
               	stur	w7, [x29, #-0x30]
               	and	x4, x4, #0xffffffffff0007ff
               	orr	x4, x4, x5
               	stur	w4, [x29, #-0x90]
               	ldr	x4, [x1, x0, lsl #3]
               	ldur	x5, [x29, #-0x30]
               	and	x5, x5, #0xffffff
               	lsl	x4, x4, #24
               	orr	x5, x5, x4
               	stur	x5, [x29, #-0x30]
               	asr	x4, x4, #24
               	ldur	x5, [x29, #-0x90]
               	and	x5, x5, #0xffffff
               	orr	x4, x5, x4, lsl #24
               	stur	x4, [x29, #-0x90]
               	ldur	w4, [x29, #-0x90]
               	sbfx	x5, x4, #0, #11
               	mul	x7, x5, x2
               	asr	x7, x7, #32
               	add	x7, x7, x7, lsr #63
               	mul	x7, x7, x3
               	sub	x5, x5, x7
               	and	x5, x5, #0x7ff
               	and	x4, x4, #0xfffffffffffff800
               	orr	x4, x4, x5
               	stur	w4, [x29, #-0x90]
               	ldur	w5, [x29, #-0x30]
               	sbfx	x7, x5, #0, #11
               	ldursw	x8, [x29, #-0x8]
               	sdiv	x17, x7, x8
               	msub	x7, x17, x8, x7
               	and	x7, x7, #0x7ff
               	and	x5, x5, #0xfffffffffffff800
               	orr	x5, x5, x7
               	stur	w5, [x29, #-0x30]
               	mov	w7, w4
               	ubfx	x7, x7, #11, #13
               	mul	x8, x7, x2
               	lsr	x8, x8, #32
               	mul	x8, x8, x3
               	sub	x7, x7, x8
               	and	x4, x4, #0xffffffffff0007ff
               	orr	x4, x4, x7, lsl #11
               	stur	w4, [x29, #-0x90]
               	mov	w4, w5
               	ubfx	x4, x4, #11, #13
               	ldursw	x7, [x29, #-0x8]
               	sdiv	x17, x4, x7
               	msub	x4, x17, x7, x4
               	and	x5, x5, #0xffffffffff0007ff
               	orr	x4, x5, x4, lsl #11
               	stur	w4, [x29, #-0x30]
               	ldur	x4, [x29, #-0x90]
               	asr	x5, x4, #24
               	smulh	x7, x5, x6
               	add	x7, x7, x7, lsr #63
               	mul	x7, x7, x3
               	sub	x5, x5, x7
               	and	x4, x4, #0xffffff
               	orr	x4, x4, x5, lsl #24
               	stur	x4, [x29, #-0x90]
               	ldur	x5, [x29, #-0x30]
               	asr	x7, x5, #24
               	ldursw	x8, [x29, #-0x8]
               	sdiv	x17, x7, x8
               	msub	x7, x17, x8, x7
               	and	x5, x5, #0xffffff
               	orr	x5, x5, x7, lsl #24
               	stur	x5, [x29, #-0x30]
               	ldur	w7, [x29, #-0x90]
               	sbfx	x9, x7, #0, #11
               	ldur	w8, [x29, #-0x30]
               	sbfx	x10, x8, #0, #11
               	cmp	w9, w10
               	b.ne	<addr>
               	ubfx	x7, x7, #11, #13
               	ubfx	x8, x8, #11, #13
               	cmp	w7, w8
               	b.ne	<addr>
               	asr	x4, x4, #24
               	asr	x5, x5, #24
               	cmp	x4, x5
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x20, [sp], #0xb0
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	x0, x0, #0x64
               	b	<addr>
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	b	<addr>
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	x0, x0, #0x64
               	b	<addr>
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	b	<addr>
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	b	<addr>
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	add	x0, x0, #0x64
               	b	<addr>
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xf0]
               	b	<addr>
