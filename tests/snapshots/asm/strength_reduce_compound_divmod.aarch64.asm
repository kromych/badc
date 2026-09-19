
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

<fill>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	mov	x1, #0x1                // =1
               	str	x1, [x0, #0x8]
               	mov	x1, #-0x1               // =-1
               	str	x1, [x0, #0x10]
               	mov	x1, #0x2                // =2
               	str	x1, [x0, #0x18]
               	mov	x1, #-0x2               // =-2
               	str	x1, [x0, #0x20]
               	mov	x1, #0x7fffffff         // =2147483647
               	str	x1, [x0, #0x28]
               	mov	x1, #-0x80000000        // =-2147483648
               	str	x1, [x0, #0x30]
               	mov	x1, #0x7fffffffffffffff // =9223372036854775807
               	str	x1, [x0, #0x38]
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	str	x1, [x0, #0x40]
               	mov	x1, #0xffffffff         // =4294967295
               	str	x1, [x0, #0x48]
               	mov	x1, #0x7f               // =127
               	str	x1, [x0, #0x50]
               	mov	x1, #-0x80              // =-128
               	str	x1, [x0, #0x58]
               	mov	x1, #0xff               // =255
               	str	x1, [x0, #0x60]
               	mov	x1, #0x7fff             // =32767
               	str	x1, [x0, #0x68]
               	mov	x1, #-0x8000            // =-32768
               	str	x1, [x0, #0x70]
               	mov	x1, #0xffff             // =65535
               	str	x1, [x0, #0x78]
               	mov	x1, #0xbc00             // =48128
               	movk	x1, #0xbf46, lsl #16
               	movk	x1, #0xee21, lsl #32
               	movk	x1, #0x2cea, lsl #48
               	str	x1, [x0, #0x80]
               	mov	x1, #0x8d4f             // =36175
               	movk	x1, #0x1a1a, lsl #16
               	movk	x1, #0x754d, lsl #32
               	movk	x1, #0xaa80, lsl #48
               	str	x1, [x0, #0x88]
               	mov	x1, #0x8932             // =35122
               	movk	x1, #0x6d27, lsl #16
               	movk	x1, #0x904a, lsl #32
               	movk	x1, #0xb3c4, lsl #48
               	str	x1, [x0, #0x90]
               	mov	x1, #0x6d19             // =27929
               	movk	x1, #0x7684, lsl #16
               	movk	x1, #0xcf42, lsl #32
               	movk	x1, #0xbc69, lsl #48
               	str	x1, [x0, #0x98]
               	mov	x1, #0x15b4             // =5556
               	movk	x1, #0x6a5b, lsl #16
               	movk	x1, #0x2fd5, lsl #32
               	movk	x1, #0x377b, lsl #48
               	str	x1, [x0, #0xa0]
               	mov	x1, #0x9df3             // =40435
               	movk	x1, #0xeaf2, lsl #16
               	movk	x1, #0x15de, lsl #32
               	movk	x1, #0x64d8, lsl #48
               	str	x1, [x0, #0xa8]
               	mov	x1, #0xd206             // =53766
               	movk	x1, #0xb2d7, lsl #16
               	movk	x1, #0x100d, lsl #32
               	movk	x1, #0xf66e, lsl #48
               	str	x1, [x0, #0xb0]
               	mov	x1, #0x665d             // =26205
               	movk	x1, #0x7e06, lsl #16
               	movk	x1, #0xe6a5, lsl #32
               	movk	x1, #0x1069, lsl #48
               	str	x1, [x0, #0xb8]
               	ret

<plain>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xe0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
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
               	lsr	x6, x2, #63
               	add	x2, x2, x6
               	mul	x6, x2, x3
               	sub	x6, x1, x6
               	ldursw	x7, [x29, #-0xe0]
               	sdiv	x7, x1, x7
               	ldursw	x8, [x29, #-0xe0]
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
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
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
               	lsr	x6, x2, #63
               	add	x2, x2, x6
               	mul	x6, x2, x3
               	sub	x6, x1, x6
               	ldursw	x7, [x29, #-0xd8]
               	sdiv	x7, x1, x7
               	ldursw	x8, [x29, #-0xd8]
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
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x2, #0x0                // =0
               	mov	x4, #-0x7               // =-7
               	mov	x5, #0x2493             // =9363
               	movk	x5, #0x9249, lsl #16
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x2
               	mov	x1, #-0x7               // =-7
               	stur	w1, [x29, #-0xd0]
               	ldr	x1, [x6, x0, lsl #3]
               	sxtw	x1, w1
               	mul	x3, x1, x5
               	asr	x3, x3, #34
               	lsr	x7, x3, #63
               	add	x3, x3, x7
               	sub	x3, x2, x3
               	mul	x7, x3, x4
               	sub	x7, x1, x7
               	ldursw	x8, [x29, #-0xd0]
               	sdiv	x8, x1, x8
               	ldursw	x9, [x29, #-0xd0]
               	sdiv	x17, x1, x9
               	msub	x1, x17, x9, x1
               	cmp	w3, w8
               	b.ne	<addr>
               	cmp	w7, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
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
               	sdiv	x3, x1, x3
               	ldursw	x6, [x29, #-0xc8]
               	sdiv	x17, x1, x6
               	msub	x1, x17, x6, x1
               	cmp	w5, w3
               	b.ne	<addr>
               	cmp	w2, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x2, #0x0                // =0
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x0, x2
               	mov	x1, #-0x10              // =-16
               	stur	w1, [x29, #-0xc0]
               	ldr	x1, [x5, x0, lsl #3]
               	sxtw	x1, w1
               	lsr	x3, x1, #60
               	add	x4, x1, x3
               	asr	x6, x4, #4
               	sub	x6, x2, x6
               	and	x4, x4, #0xf
               	sub	x3, x4, x3
               	ldursw	x4, [x29, #-0xc0]
               	sdiv	x4, x1, x4
               	ldursw	x7, [x29, #-0xc0]
               	sdiv	x17, x1, x7
               	msub	x1, x17, x7, x1
               	cmp	w6, w4
               	b.ne	<addr>
               	cmp	w3, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x1, #0x1                // =1
               	stur	w1, [x29, #-0xb8]
               	ldr	x1, [x2, x0, lsl #3]
               	sxtw	x1, w1
               	ldursw	x3, [x29, #-0xb8]
               	sdiv	x3, x1, x3
               	ldursw	x4, [x29, #-0xb8]
               	sdiv	x17, x1, x4
               	msub	x4, x17, x4, x1
               	cmp	w1, w3
               	b.ne	<addr>
               	cbnz	w4, <addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x2, #0x0                // =0
               	mov	x3, #-0x80000000        // =-2147483648
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x0, x2
               	mov	x1, #-0x1               // =-1
               	stur	w1, [x29, #-0xb0]
               	ldr	x1, [x4, x0, lsl #3]
               	sxtw	x1, w1
               	cmp	w1, w3
               	b.eq	<addr>
               	sub	x5, x2, x1
               	ldursw	x6, [x29, #-0xb0]
               	sdiv	x6, x1, x6
               	ldursw	x7, [x29, #-0xb0]
               	sdiv	x17, x1, x7
               	msub	x1, x17, x7, x1
               	cmp	w5, w6
               	b.ne	<addr>
               	cbnz	w1, <addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
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
               	lsr	x6, x2, #63
               	add	x2, x2, x6
               	mul	x6, x2, x4
               	sub	x6, x1, x6
               	ldursw	x7, [x29, #-0xa8]
               	sdiv	x7, x1, x7
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
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x2, #0x0                // =0
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x0, x2
               	mov	x1, #-0x80000000        // =-2147483648
               	stur	w1, [x29, #-0xa0]
               	ldr	x1, [x5, x0, lsl #3]
               	sxtw	x1, w1
               	lsr	x3, x1, #33
               	add	x4, x1, x3
               	asr	x6, x4, #31
               	sub	x6, x2, x6
               	and	x4, x4, #0x7fffffff
               	sub	x3, x4, x3
               	ldursw	x4, [x29, #-0xa0]
               	sdiv	x4, x1, x4
               	ldursw	x7, [x29, #-0xa0]
               	sdiv	x17, x1, x7
               	msub	x1, x17, x7, x1
               	cmp	w6, w4
               	b.ne	<addr>
               	cmp	w3, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	mov	x3, #0xa                // =10
               	mov	x4, #0x6667             // =26215
               	movk	x4, #0x6666, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, #0xa                // =10
               	stur	w1, [x29, #-0x98]
               	ldr	x1, [x5, x0, lsl #3]
               	mov	w1, w1
               	lsr	x2, x1, #1
               	mul	x2, x2, x4
               	lsr	x2, x2, #33
               	mul	x6, x2, x3
               	sub	x6, x1, x6
               	ldur	w7, [x29, #-0x98]
               	udiv	x7, x1, x7
               	ldur	w8, [x29, #-0x98]
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
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	mov	x3, #0x7                // =7
               	mov	x4, #0x4925             // =18725
               	movk	x4, #0x2492, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, #0x7                // =7
               	stur	w1, [x29, #-0x90]
               	ldr	x1, [x5, x0, lsl #3]
               	mov	w1, w1
               	mul	x2, x1, x4
               	lsr	x2, x2, #32
               	sub	x6, x1, x2
               	lsr	x6, x6, #1
               	add	x2, x6, x2
               	lsr	x2, x2, #2
               	mul	x6, x2, x3
               	sub	x6, x1, x6
               	ldur	w7, [x29, #-0x90]
               	udiv	x7, x1, x7
               	ldur	w8, [x29, #-0x90]
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
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x1, #0x8                // =8
               	stur	w1, [x29, #-0x88]
               	ldr	x2, [x3, x0, lsl #3]
               	mov	w1, w2
               	lsr	x4, x1, #3
               	and	x2, x2, #0x7
               	ldur	w5, [x29, #-0x88]
               	udiv	x5, x1, x5
               	ldur	w6, [x29, #-0x88]
               	udiv	x17, x1, x6
               	msub	x1, x17, x6, x1
               	cmp	w4, w5
               	b.ne	<addr>
               	cmp	w2, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x1, #0x1                // =1
               	stur	w1, [x29, #-0x80]
               	ldr	x1, [x3, x0, lsl #3]
               	mov	w2, w1
               	ldur	w4, [x29, #-0x80]
               	udiv	x4, x2, x4
               	ldur	w5, [x29, #-0x80]
               	udiv	x17, x2, x5
               	msub	x2, x17, x5, x2
               	cmp	w1, w4
               	b.ne	<addr>
               	cbnz	w2, <addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	mov	x1, #0x1                // =1
               	movk	x1, #0x8000, lsl #16
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	stur	w1, [x29, #-0x78]
               	ldr	x2, [x3, x0, lsl #3]
               	cmp	w2, w1
               	cset	x4, hs
               	mov	w2, w2
               	cmp	x2, x1
               	cset	x5, hs
               	mul	x5, x5, x1
               	sub	x5, x2, x5
               	ldur	w6, [x29, #-0x78]
               	udiv	x6, x2, x6
               	ldur	w7, [x29, #-0x78]
               	udiv	x17, x2, x7
               	msub	x2, x17, x7, x2
               	cmp	w4, w6
               	b.ne	<addr>
               	cmp	w5, w2
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	mov	x1, #0x2800             // =10240
               	movk	x1, #0xee6b, lsl #16
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	stur	w1, [x29, #-0x70]
               	ldr	x2, [x3, x0, lsl #3]
               	cmp	w2, w1
               	cset	x4, hs
               	mov	w2, w2
               	cmp	x2, x1
               	cset	x5, hs
               	mul	x5, x5, x1
               	sub	x5, x2, x5
               	ldur	w6, [x29, #-0x70]
               	udiv	x6, x2, x6
               	ldur	w7, [x29, #-0x70]
               	udiv	x17, x2, x7
               	msub	x2, x17, x7, x2
               	cmp	w4, w6
               	b.ne	<addr>
               	cmp	w5, w2
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	mov	x2, #0xffffffff         // =4294967295
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x1, #0xffffffff         // =4294967295
               	stur	w1, [x29, #-0x68]
               	ldr	x1, [x3, x0, lsl #3]
               	cmp	w1, w2
               	cset	x4, hs
               	mov	w1, w1
               	cmp	x1, x2
               	cset	x5, hs
               	mul	x5, x5, x2
               	sub	x5, x1, x5
               	ldur	w6, [x29, #-0x68]
               	udiv	x6, x1, x6
               	ldur	w7, [x29, #-0x68]
               	udiv	x17, x1, x7
               	msub	x1, x17, x7, x1
               	cmp	w4, w6
               	b.ne	<addr>
               	cmp	w5, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
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
               	lsr	x7, x2, #63
               	add	x2, x2, x7
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
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x2, #0x0                // =0
               	mov	x4, #-0x3e8             // =-1000
               	mov	x5, #0xf7cf             // =63439
               	movk	x5, #0xe353, lsl #16
               	movk	x5, #0x9ba5, lsl #32
               	movk	x5, #0x20c4, lsl #48
               	mov	x6, #0x5555555555555555 // =6148914691236517205
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	mov	x1, x2
               	mov	x0, #-0x3e8             // =-1000
               	stur	x0, [x29, #-0x58]
               	ldr	x0, [x7, x1, lsl #3]
               	cmp	x0, x6
               	b.eq	<addr>
               	smulh	x3, x0, x5
               	asr	x3, x3, #7
               	lsr	x8, x3, #63
               	add	x3, x3, x8
               	sub	x3, x2, x3
               	mul	x8, x3, x4
               	sub	x8, x0, x8
               	ldur	x9, [x29, #-0x58]
               	sdiv	x9, x0, x9
               	ldur	x10, [x29, #-0x58]
               	sdiv	x17, x0, x10
               	msub	x0, x17, x10, x0
               	cmp	x3, x9
               	b.ne	<addr>
               	cmp	x8, x0
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
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
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x2, #0x0                // =0
               	mov	x3, #-0x8000000000000000 // =-9223372036854775808
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x0, x2
               	mov	x1, #-0x1               // =-1
               	stur	x1, [x29, #-0x48]
               	ldr	x1, [x4, x0, lsl #3]
               	cmp	x1, x3
               	b.eq	<addr>
               	sub	x5, x2, x1
               	ldur	x6, [x29, #-0x48]
               	sdiv	x6, x1, x6
               	ldur	x7, [x29, #-0x48]
               	sdiv	x17, x1, x7
               	msub	x1, x17, x7, x1
               	cmp	x5, x6
               	b.ne	<addr>
               	cbnz	x1, <addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x2, #0x0                // =0
               	mov	x5, #0x5555555555555555 // =6148914691236517205
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x1, x2
               	mov	x0, #-0x8000000000000000 // =-9223372036854775808
               	stur	x0, [x29, #-0x40]
               	ldr	x0, [x6, x1, lsl #3]
               	cmp	x0, x5
               	b.eq	<addr>
               	asr	x3, x0, #63
               	lsr	x3, x3, #1
               	add	x4, x0, x3
               	asr	x7, x4, #63
               	sub	x7, x2, x7
               	and	x4, x4, #0x7fffffffffffffff
               	sub	x3, x4, x3
               	ldur	x4, [x29, #-0x40]
               	sdiv	x4, x0, x4
               	ldur	x8, [x29, #-0x40]
               	sdiv	x17, x0, x8
               	msub	x0, x17, x8, x0
               	cmp	x7, x4
               	b.ne	<addr>
               	cmp	x3, x0
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
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
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
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
               	lsr	x7, x7, #1
               	add	x2, x7, x2
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
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
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
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
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
               	lsr	x7, x2, #63
               	add	x2, x2, x7
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
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x2, #0x0                // =0
               	mov	x4, #-0x3               // =-3
               	mov	x5, #0x5555555555555555 // =6148914691236517205
               	mov	x6, #0x5556             // =21846
               	movk	x6, #0x5555, lsl #16
               	movk	x6, #0x5555, lsl #32
               	movk	x6, #0x5555, lsl #48
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	mov	x1, x2
               	mov	x0, #-0x3               // =-3
               	stur	x0, [x29, #-0x18]
               	ldr	x0, [x7, x1, lsl #3]
               	cmp	x0, x5
               	b.eq	<addr>
               	smulh	x3, x0, x6
               	lsr	x8, x3, #63
               	add	x3, x3, x8
               	sub	x3, x2, x3
               	mul	x8, x3, x4
               	sub	x8, x0, x8
               	ldur	x9, [x29, #-0x18]
               	sdiv	x9, x0, x9
               	ldur	x10, [x29, #-0x18]
               	sdiv	x17, x0, x10
               	msub	x0, x17, x10, x0
               	cmp	x3, x9
               	b.ne	<addr>
               	cmp	x8, x0
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
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
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
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
               	lsr	x7, x7, #1
               	add	x2, x7, x2
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
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret

<converted>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xb0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
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
               	lsr	x6, x2, #63
               	add	x2, x2, x6
               	mul	x6, x2, x3
               	sub	x6, x1, x6
               	ldursw	x7, [x29, #-0xa8]
               	sdiv	x7, x1, x7
               	sxtb	x7, w7
               	ldursw	x8, [x29, #-0xa8]
               	sdiv	x17, x1, x8
               	msub	x1, x17, x8, x1
               	sxtb	x1, w1
               	cmp	w2, w7
               	b.ne	<addr>
               	cmp	w6, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x2, #0x0                // =0
               	mov	x4, #-0x5               // =-5
               	mov	x5, #0x6667             // =26215
               	movk	x5, #0x6666, lsl #16
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x2
               	mov	x1, #-0x5               // =-5
               	stur	w1, [x29, #-0xa0]
               	ldr	x1, [x6, x0, lsl #3]
               	sxtb	x1, w1
               	mul	x3, x1, x5
               	asr	x3, x3, #33
               	lsr	x7, x3, #63
               	add	x3, x3, x7
               	sub	x3, x2, x3
               	mul	x7, x3, x4
               	sub	x7, x1, x7
               	ldursw	x8, [x29, #-0xa0]
               	sdiv	x8, x1, x8
               	sxtb	x8, w8
               	ldursw	x9, [x29, #-0xa0]
               	sdiv	x17, x1, x9
               	msub	x1, x17, x9, x1
               	sxtb	x1, w1
               	cmp	w3, w8
               	b.ne	<addr>
               	cmp	w7, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x2, #0x0                // =0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x0, x2
               	mov	x1, #-0x1               // =-1
               	stur	w1, [x29, #-0x98]
               	ldr	x1, [x3, x0, lsl #3]
               	sxtb	x1, w1
               	sub	x4, x2, x1
               	sxtb	x4, w4
               	ldursw	x5, [x29, #-0x98]
               	sdiv	x5, x1, x5
               	sxtb	x5, w5
               	ldursw	x6, [x29, #-0x98]
               	sdiv	x17, x1, x6
               	msub	x1, x17, x6, x1
               	sxtb	x1, w1
               	cmp	w4, w5
               	b.ne	<addr>
               	cbnz	w1, <addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
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
               	and	x1, x1, #0xff
               	cmp	w6, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
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
               	and	x1, x1, #0xff
               	cmp	w4, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x2, #0x0                // =0
               	mov	x4, #-0x7               // =-7
               	mov	x5, #0x2493             // =9363
               	movk	x5, #0x9249, lsl #16
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x2
               	mov	x1, #-0x7               // =-7
               	stur	w1, [x29, #-0x80]
               	ldr	x1, [x6, x0, lsl #3]
               	and	x1, x1, #0xff
               	mul	x3, x1, x5
               	asr	x3, x3, #34
               	lsr	x7, x3, #63
               	add	x3, x3, x7
               	sub	x3, x2, x3
               	and	x7, x3, #0xff
               	mul	x3, x3, x4
               	sub	x3, x1, x3
               	ldursw	x8, [x29, #-0x80]
               	sdiv	x8, x1, x8
               	and	x8, x8, #0xff
               	ldursw	x9, [x29, #-0x80]
               	sdiv	x17, x1, x9
               	msub	x1, x17, x9, x1
               	cmp	w7, w8
               	b.ne	<addr>
               	and	x1, x1, #0xff
               	cmp	w3, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
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
               	lsr	x6, x2, #63
               	add	x2, x2, x6
               	mul	x6, x2, x3
               	sub	x6, x1, x6
               	ldursw	x7, [x29, #-0x78]
               	sdiv	x7, x1, x7
               	sxth	x7, w7
               	ldursw	x8, [x29, #-0x78]
               	sdiv	x17, x1, x8
               	msub	x1, x17, x8, x1
               	sxth	x1, w1
               	cmp	w2, w7
               	b.ne	<addr>
               	cmp	w6, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x2, #0x0                // =0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x0, x2
               	mov	x1, #-0x1               // =-1
               	stur	w1, [x29, #-0x70]
               	ldr	x1, [x3, x0, lsl #3]
               	sxth	x1, w1
               	sub	x4, x2, x1
               	sxth	x4, w4
               	ldursw	x5, [x29, #-0x70]
               	sdiv	x5, x1, x5
               	sxth	x5, w5
               	ldursw	x6, [x29, #-0x70]
               	sdiv	x17, x1, x6
               	msub	x1, x17, x6, x1
               	sxth	x1, w1
               	cmp	w4, w5
               	b.ne	<addr>
               	cbnz	w1, <addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
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
               	and	x1, x1, #0xffff
               	cmp	w6, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
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
               	udiv	x7, x1, x7
               	ldur	w8, [x29, #-0x60]
               	udiv	x17, x1, x8
               	msub	x1, x17, x8, x1
               	cmp	w2, w7
               	b.ne	<addr>
               	and	x1, x1, #0xffff
               	cmp	w6, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	mov	x3, #0x3                // =3
               	mov	x4, #0xaaab             // =43691
               	movk	x4, #0xaaaa, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, #0x3                // =3
               	stur	w1, [x29, #-0x58]
               	ldr	x1, [x5, x0, lsl #3]
               	mov	w1, w1
               	mul	x2, x1, x4
               	lsr	x2, x2, #33
               	mul	x6, x2, x3
               	sub	x6, x1, x6
               	ldur	w7, [x29, #-0x58]
               	udiv	x7, x1, x7
               	ldur	w8, [x29, #-0x58]
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
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x1, #0x80000000         // =2147483648
               	stur	w1, [x29, #-0x50]
               	ldr	x2, [x3, x0, lsl #3]
               	mov	w1, w2
               	lsr	x4, x1, #31
               	and	x2, x2, #0x7fffffff
               	ldur	w5, [x29, #-0x50]
               	udiv	x5, x1, x5
               	ldur	w6, [x29, #-0x50]
               	udiv	x17, x1, x6
               	msub	x1, x17, x6, x1
               	cmp	w4, w5
               	b.ne	<addr>
               	cmp	w2, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
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
               	lsr	x6, x2, #63
               	add	x2, x2, x6
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
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
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
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
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
               	lsr	x6, x6, #1
               	add	x2, x6, x2
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
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
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
               	lsr	x6, x6, #1
               	add	x2, x6, x2
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
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x2, #0x0                // =0
               	mov	x4, #-0x7               // =-7
               	mov	x5, #0x4925             // =18725
               	movk	x5, #0x2492, lsl #16
               	movk	x5, #0x9249, lsl #32
               	movk	x5, #0x4924, lsl #48
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x2
               	mov	x1, #-0x7               // =-7
               	stur	x1, [x29, #-0x28]
               	ldr	x1, [x6, x0, lsl #3]
               	mov	w1, w1
               	smulh	x3, x1, x5
               	asr	x3, x3, #1
               	lsr	x7, x3, #63
               	add	x3, x3, x7
               	sub	x3, x2, x3
               	mul	x7, x3, x4
               	sub	x7, x1, x7
               	ldur	x8, [x29, #-0x28]
               	sdiv	x8, x1, x8
               	ldur	x9, [x29, #-0x28]
               	sdiv	x17, x1, x9
               	msub	x1, x17, x9, x1
               	cmp	w3, w8
               	b.ne	<addr>
               	cmp	w7, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
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
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
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
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x2, #0x0                // =0
               	mov	x4, #-0xa               // =-10
               	mov	x5, #0x5555555555555555 // =6148914691236517205
               	mov	x6, #0x6667             // =26215
               	movk	x6, #0x6666, lsl #16
               	movk	x6, #0x6666, lsl #32
               	movk	x6, #0x6666, lsl #48
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	mov	x1, x2
               	mov	x0, #-0xa               // =-10
               	stur	w0, [x29, #-0x10]
               	ldr	x0, [x7, x1, lsl #3]
               	cmp	x0, x5
               	b.eq	<addr>
               	smulh	x3, x0, x6
               	asr	x3, x3, #2
               	lsr	x8, x3, #63
               	add	x3, x3, x8
               	sub	x3, x2, x3
               	mul	x8, x3, x4
               	sub	x8, x0, x8
               	ldursw	x9, [x29, #-0x10]
               	sdiv	x9, x0, x9
               	ldursw	x10, [x29, #-0x10]
               	sdiv	x17, x0, x10
               	msub	x0, x17, x10, x0
               	cmp	x3, x9
               	b.ne	<addr>
               	cmp	x8, x0
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
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
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret

<places>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x90
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	mov	x5, #0xa                // =10
               	mov	x2, #0x6667             // =26215
               	movk	x2, #0x6666, lsl #16
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x3, [x1, x0, lsl #3]
               	stur	w3, [x29, #-0x28]
               	ldr	x3, [x1, x0, lsl #3]
               	stur	w3, [x29, #-0x20]
               	mov	x3, #0xa                // =10
               	stur	w3, [x29, #-0x18]
               	ldursw	x3, [x29, #-0x28]
               	mul	x3, x3, x2
               	asr	x3, x3, #34
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	stur	w3, [x29, #-0x28]
               	ldursw	x3, [x29, #-0x20]
               	ldursw	x4, [x29, #-0x18]
               	sdiv	x3, x3, x4
               	stur	w3, [x29, #-0x20]
               	ldursw	x3, [x29, #-0x28]
               	ldursw	x4, [x29, #-0x20]
               	cmp	w3, w4
               	b.ne	<addr>
               	ldr	x3, [x1, x0, lsl #3]
               	stur	w3, [x29, #-0x28]
               	ldr	x3, [x1, x0, lsl #3]
               	stur	w3, [x29, #-0x20]
               	ldursw	x3, [x29, #-0x28]
               	mul	x4, x3, x2
               	asr	x4, x4, #34
               	lsr	x6, x4, #63
               	add	x4, x4, x6
               	mul	x4, x4, x5
               	sub	x3, x3, x4
               	stur	w3, [x29, #-0x28]
               	ldursw	x3, [x29, #-0x20]
               	ldursw	x4, [x29, #-0x18]
               	sdiv	x17, x3, x4
               	msub	x3, x17, x4, x3
               	stur	w3, [x29, #-0x20]
               	ldursw	x3, [x29, #-0x28]
               	ldursw	x4, [x29, #-0x20]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x2, x29, #0x88
               	ldr	x3, [x1, x0, lsl #3]
               	str	w3, [x2, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	mov	x2, #0x0                // =0
               	mov	x6, #-0x9               // =-9
               	mov	x4, #0x8e39             // =36409
               	movk	x4, #0x38e3, lsl #16
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	mov	x0, x2
               	mov	x1, #-0x9               // =-9
               	stur	w1, [x29, #-0x10]
               	ldr	x1, [x7, x0, lsl #3]
               	sxtw	x1, w1
               	ldursw	x3, [x29, #-0x10]
               	sdiv	x3, x1, x3
               	sub	x1, x29, #0x88
               	ldrsw	x5, [x1, x0, lsl #2]
               	mul	x5, x5, x4
               	asr	x5, x5, #33
               	lsr	x8, x5, #63
               	add	x5, x5, x8
               	sub	x5, x2, x5
               	str	w5, [x1, x0, lsl #2]
               	cmp	w5, w3
               	b.ne	<addr>
               	ldrsw	x5, [x1, x0, lsl #2]
               	cmp	w5, w3
               	b.ne	<addr>
               	sxtw	x3, w3
               	ldursw	x5, [x29, #-0x10]
               	sdiv	x17, x3, x5
               	msub	x8, x17, x5, x3
               	ldrsw	x3, [x1, x0, lsl #2]
               	mul	x5, x3, x4
               	asr	x5, x5, #33
               	lsr	x9, x5, #63
               	add	x5, x5, x9
               	sub	x5, x2, x5
               	mul	x5, x5, x6
               	sub	x3, x3, x5
               	str	w3, [x1, x0, lsl #2]
               	mov	x1, x3
               	cmp	w1, w8
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	mov	x5, #0x3                // =3
               	mov	x4, #0x5556             // =21846
               	movk	x4, #0x5555, lsl #16
               	mov	x8, #0x5556             // =21846
               	movk	x8, #0x5555, lsl #16
               	movk	x8, #0x5555, lsl #32
               	movk	x8, #0x5555, lsl #48
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x0, #0x3                // =3
               	stur	w0, [x29, #-0x8]
               	sub	x0, x29, #0x90
               	sub	x2, x29, #0x30
               	ldr	x6, [x3, x1, lsl #3]
               	and	x6, x6, #0x7ff
               	ldr	w7, [x2]
               	and	x7, x7, #0xfffffffffffff800
               	orr	x7, x7, x6
               	str	w7, [x2]
               	lsl	x6, x6, #53
               	asr	x6, x6, #53
               	and	x6, x6, #0x7ff
               	ldr	w9, [x0]
               	and	x9, x9, #0xfffffffffffff800
               	orr	x6, x9, x6
               	str	w6, [x0]
               	ldr	x9, [x3, x1, lsl #3]
               	and	x9, x9, #0x1fff
               	and	x10, x7, #0xffffffffff0007ff
               	lsl	x7, x9, #11
               	orr	x9, x10, x7
               	str	w9, [x2]
               	and	x6, x6, #0xffffffffff0007ff
               	orr	x6, x6, x7
               	str	w6, [x0]
               	ldr	x6, [x3, x1, lsl #3]
               	and	x6, x6, #0xffffffffff
               	ldr	x7, [x2]
               	and	x7, x7, #0xffffff
               	lsl	x6, x6, #24
               	orr	x7, x7, x6
               	str	x7, [x2]
               	asr	x6, x6, #24
               	and	x6, x6, #0xffffffffff
               	ldr	x7, [x0]
               	and	x7, x7, #0xffffff
               	lsl	x6, x6, #24
               	orr	x6, x7, x6
               	str	x6, [x0]
               	ldr	w6, [x0]
               	and	x7, x6, #0x7ff
               	lsl	x7, x7, #53
               	asr	x7, x7, #53
               	mul	x7, x7, x4
               	asr	x7, x7, #32
               	lsr	x9, x7, #63
               	add	x7, x7, x9
               	and	x7, x7, #0x7ff
               	and	x6, x6, #0xfffffffffffff800
               	orr	x6, x6, x7
               	str	w6, [x0]
               	ldr	w7, [x2]
               	and	x9, x7, #0x7ff
               	lsl	x9, x9, #53
               	asr	x9, x9, #53
               	ldursw	x10, [x29, #-0x8]
               	sdiv	x9, x9, x10
               	and	x9, x9, #0x7ff
               	and	x7, x7, #0xfffffffffffff800
               	orr	x7, x7, x9
               	str	w7, [x2]
               	mov	w9, w6
               	asr	x9, x9, #11
               	and	x9, x9, #0x1fff
               	mul	x9, x9, x4
               	lsr	x9, x9, #32
               	and	x6, x6, #0xffffffffff0007ff
               	lsl	x9, x9, #11
               	orr	x6, x6, x9
               	str	w6, [x0]
               	mov	w6, w7
               	asr	x6, x6, #11
               	and	x6, x6, #0x1fff
               	ldursw	x9, [x29, #-0x8]
               	sdiv	x6, x6, x9
               	and	x6, x6, #0x1fff
               	and	x7, x7, #0xffffffffff0007ff
               	lsl	x6, x6, #11
               	orr	x6, x7, x6
               	str	w6, [x2]
               	ldr	x6, [x0]
               	asr	x7, x6, #24
               	and	x7, x7, #0xffffffffff
               	lsl	x7, x7, #24
               	asr	x7, x7, #24
               	smulh	x7, x7, x8
               	lsr	x9, x7, #63
               	add	x7, x7, x9
               	and	x7, x7, #0xffffffffff
               	and	x6, x6, #0xffffff
               	lsl	x7, x7, #24
               	orr	x6, x6, x7
               	str	x6, [x0]
               	ldr	x7, [x2]
               	asr	x9, x7, #24
               	and	x9, x9, #0xffffffffff
               	lsl	x9, x9, #24
               	asr	x9, x9, #24
               	ldursw	x10, [x29, #-0x8]
               	sdiv	x9, x9, x10
               	and	x9, x9, #0xffffffffff
               	and	x7, x7, #0xffffff
               	lsl	x9, x9, #24
               	orr	x7, x7, x9
               	str	x7, [x2]
               	ldr	w0, [x0]
               	and	x0, x0, #0x7ff
               	lsl	x0, x0, #53
               	asr	x0, x0, #53
               	sub	x2, x29, #0x30
               	ldr	w9, [x2]
               	and	x9, x9, #0x7ff
               	lsl	x9, x9, #53
               	asr	x9, x9, #53
               	cmp	w0, w9
               	b.ne	<addr>
               	sub	x0, x29, #0x90
               	ldr	w9, [x0]
               	asr	x9, x9, #11
               	and	x9, x9, #0x1fff
               	ldr	w10, [x2]
               	asr	x10, x10, #11
               	and	x10, x10, #0x1fff
               	cmp	w9, w10
               	b.ne	<addr>
               	asr	x6, x6, #24
               	and	x6, x6, #0xffffffffff
               	lsl	x6, x6, #24
               	asr	x6, x6, #24
               	asr	x7, x7, #24
               	and	x7, x7, #0xffffffffff
               	lsl	x7, x7, #24
               	asr	x7, x7, #24
               	cmp	x6, x7
               	b.ne	<addr>
               	ldr	x6, [x3, x1, lsl #3]
               	and	x6, x6, #0x7ff
               	ldr	w7, [x2]
               	and	x7, x7, #0xfffffffffffff800
               	orr	x7, x7, x6
               	str	w7, [x2]
               	lsl	x6, x6, #53
               	asr	x6, x6, #53
               	and	x6, x6, #0x7ff
               	ldr	w9, [x0]
               	and	x9, x9, #0xfffffffffffff800
               	orr	x6, x9, x6
               	str	w6, [x0]
               	ldr	x9, [x3, x1, lsl #3]
               	and	x9, x9, #0x1fff
               	and	x10, x7, #0xffffffffff0007ff
               	lsl	x7, x9, #11
               	orr	x9, x10, x7
               	str	w9, [x2]
               	and	x6, x6, #0xffffffffff0007ff
               	orr	x6, x6, x7
               	str	w6, [x0]
               	ldr	x6, [x3, x1, lsl #3]
               	and	x6, x6, #0xffffffffff
               	ldr	x7, [x2]
               	and	x7, x7, #0xffffff
               	lsl	x6, x6, #24
               	orr	x7, x7, x6
               	str	x7, [x2]
               	asr	x6, x6, #24
               	and	x6, x6, #0xffffffffff
               	ldr	x7, [x0]
               	and	x7, x7, #0xffffff
               	lsl	x6, x6, #24
               	orr	x6, x7, x6
               	str	x6, [x0]
               	ldr	w6, [x0]
               	and	x7, x6, #0x7ff
               	lsl	x7, x7, #53
               	asr	x7, x7, #53
               	mul	x9, x7, x4
               	asr	x9, x9, #32
               	lsr	x10, x9, #63
               	add	x9, x9, x10
               	mul	x9, x9, x5
               	sub	x7, x7, x9
               	and	x7, x7, #0x7ff
               	and	x6, x6, #0xfffffffffffff800
               	orr	x6, x6, x7
               	str	w6, [x0]
               	ldr	w7, [x2]
               	and	x9, x7, #0x7ff
               	lsl	x9, x9, #53
               	asr	x9, x9, #53
               	ldursw	x10, [x29, #-0x8]
               	sdiv	x17, x9, x10
               	msub	x9, x17, x10, x9
               	and	x9, x9, #0x7ff
               	and	x7, x7, #0xfffffffffffff800
               	orr	x7, x7, x9
               	str	w7, [x2]
               	mov	w9, w6
               	asr	x9, x9, #11
               	and	x9, x9, #0x1fff
               	mul	x10, x9, x4
               	lsr	x10, x10, #32
               	mul	x10, x10, x5
               	sub	x9, x9, x10
               	and	x6, x6, #0xffffffffff0007ff
               	lsl	x9, x9, #11
               	orr	x6, x6, x9
               	str	w6, [x0]
               	mov	w6, w7
               	asr	x6, x6, #11
               	and	x6, x6, #0x1fff
               	ldursw	x9, [x29, #-0x8]
               	sdiv	x17, x6, x9
               	msub	x6, x17, x9, x6
               	and	x6, x6, #0x1fff
               	and	x7, x7, #0xffffffffff0007ff
               	lsl	x6, x6, #11
               	orr	x6, x7, x6
               	str	w6, [x2]
               	ldr	x2, [x0]
               	asr	x6, x2, #24
               	and	x6, x6, #0xffffffffff
               	lsl	x6, x6, #24
               	asr	x6, x6, #24
               	smulh	x7, x6, x8
               	lsr	x9, x7, #63
               	add	x7, x7, x9
               	mul	x7, x7, x5
               	sub	x6, x6, x7
               	and	x6, x6, #0xffffffffff
               	and	x2, x2, #0xffffff
               	lsl	x6, x6, #24
               	orr	x2, x2, x6
               	str	x2, [x0]
               	sub	x0, x29, #0x30
               	ldr	x6, [x0]
               	asr	x7, x6, #24
               	and	x7, x7, #0xffffffffff
               	lsl	x7, x7, #24
               	asr	x7, x7, #24
               	ldursw	x9, [x29, #-0x8]
               	sdiv	x17, x7, x9
               	msub	x7, x17, x9, x7
               	and	x7, x7, #0xffffffffff
               	and	x6, x6, #0xffffff
               	lsl	x7, x7, #24
               	orr	x6, x6, x7
               	str	x6, [x0]
               	sub	x7, x29, #0x90
               	ldr	w9, [x7]
               	and	x9, x9, #0x7ff
               	lsl	x9, x9, #53
               	asr	x9, x9, #53
               	ldr	w10, [x0]
               	and	x10, x10, #0x7ff
               	lsl	x10, x10, #53
               	asr	x10, x10, #53
               	cmp	w9, w10
               	b.ne	<addr>
               	ldr	w7, [x7]
               	asr	x7, x7, #11
               	and	x7, x7, #0x1fff
               	ldr	w0, [x0]
               	asr	x0, x0, #11
               	and	x0, x0, #0x1fff
               	cmp	w7, w0
               	b.ne	<addr>
               	asr	x0, x2, #24
               	and	x0, x0, #0xffffffffff
               	lsl	x0, x0, #24
               	asr	x0, x0, #24
               	asr	x2, x6, #24
               	and	x2, x2, #0xffffffffff
               	lsl	x2, x2, #24
               	asr	x2, x2, #24
               	cmp	x0, x2
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x18
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret
