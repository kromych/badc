
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
               	mov	x7, #0xa                // =10
               	mov	x8, #0x6667             // =26215
               	movk	x8, #0x6666, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, #0xa                // =10
               	stur	w1, [x29, #-0xe0]
               	ldr	x1, [x5, x0, lsl #3]
               	sxtw	x1, w1
               	mul	x2, x1, x8
               	asr	x2, x2, #34
               	lsr	x3, x2, #63
               	add	x2, x2, x3
               	mul	x3, x2, x7
               	sub	x3, x1, x3
               	ldursw	x4, [x29, #-0xe0]
               	sdiv	x6, x1, x4
               	ldursw	x4, [x29, #-0xe0]
               	sdiv	x17, x1, x4
               	msub	x1, x17, x4, x1
               	cmp	w2, w6
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
               	mov	x7, #0x7                // =7
               	mov	x8, #0x2493             // =9363
               	movk	x8, #0x9249, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, #0x7                // =7
               	stur	w1, [x29, #-0xd8]
               	ldr	x1, [x5, x0, lsl #3]
               	sxtw	x1, w1
               	mul	x2, x1, x8
               	asr	x2, x2, #34
               	lsr	x3, x2, #63
               	add	x2, x2, x3
               	mul	x3, x2, x7
               	sub	x3, x1, x3
               	ldursw	x4, [x29, #-0xd8]
               	sdiv	x6, x1, x4
               	ldursw	x4, [x29, #-0xd8]
               	sdiv	x17, x1, x4
               	msub	x1, x17, x4, x1
               	cmp	w2, w6
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
               	mov	x5, #0x0                // =0
               	mov	x8, #-0x7               // =-7
               	mov	x9, #0x2493             // =9363
               	movk	x9, #0x9249, lsl #16
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x5
               	mov	x1, #-0x7               // =-7
               	stur	w1, [x29, #-0xd0]
               	ldr	x1, [x6, x0, lsl #3]
               	sxtw	x1, w1
               	mul	x2, x1, x9
               	asr	x2, x2, #34
               	lsr	x3, x2, #63
               	add	x2, x2, x3
               	sub	x2, x5, x2
               	mul	x3, x2, x8
               	sub	x3, x1, x3
               	ldursw	x4, [x29, #-0xd0]
               	sdiv	x7, x1, x4
               	ldursw	x4, [x29, #-0xd0]
               	sdiv	x17, x1, x4
               	msub	x1, x17, x4, x1
               	cmp	w2, w7
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
               	sdiv	x6, x1, x3
               	ldursw	x3, [x29, #-0xc8]
               	sdiv	x17, x1, x3
               	msub	x1, x17, x3, x1
               	cmp	w5, w6
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
               	mov	x4, #0x0                // =0
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x0, x4
               	mov	x1, #-0x10              // =-16
               	stur	w1, [x29, #-0xc0]
               	ldr	x1, [x5, x0, lsl #3]
               	sxtw	x1, w1
               	lsr	x2, x1, #60
               	add	x3, x1, x2
               	asr	x6, x3, #4
               	sub	x6, x4, x6
               	and	x3, x3, #0xf
               	sub	x2, x3, x2
               	ldursw	x3, [x29, #-0xc0]
               	sdiv	x7, x1, x3
               	ldursw	x3, [x29, #-0xc0]
               	sdiv	x17, x1, x3
               	msub	x1, x17, x3, x1
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
               	mov	x0, #0x0                // =0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x1, #0x1                // =1
               	stur	w1, [x29, #-0xb8]
               	ldr	x1, [x3, x0, lsl #3]
               	sxtw	x1, w1
               	ldursw	x2, [x29, #-0xb8]
               	sdiv	x4, x1, x2
               	ldursw	x2, [x29, #-0xb8]
               	sdiv	x17, x1, x2
               	msub	x2, x17, x2, x1
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
               	mov	x3, #0x0                // =0
               	mov	x7, #-0x80000000        // =-2147483648
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x0, x3
               	mov	x1, #-0x1               // =-1
               	stur	w1, [x29, #-0xb0]
               	ldr	x1, [x4, x0, lsl #3]
               	sxtw	x1, w1
               	cmp	w1, w7
               	b.eq	<addr>
               	sub	x5, x3, x1
               	ldursw	x2, [x29, #-0xb0]
               	sdiv	x6, x1, x2
               	ldursw	x2, [x29, #-0xb0]
               	sdiv	x17, x1, x2
               	msub	x1, x17, x2, x1
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
               	mov	x7, #0x1                // =1
               	movk	x7, #0x4000, lsl #16
               	mov	x8, #0x7fffffff         // =2147483647
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, #0x7fffffff         // =2147483647
               	stur	w1, [x29, #-0xa8]
               	ldr	x1, [x5, x0, lsl #3]
               	sxtw	x1, w1
               	mul	x2, x1, x7
               	asr	x2, x2, #61
               	lsr	x3, x2, #63
               	add	x2, x2, x3
               	mul	x3, x2, x8
               	sub	x3, x1, x3
               	ldursw	x4, [x29, #-0xa8]
               	sdiv	x6, x1, x4
               	ldursw	x4, [x29, #-0xa8]
               	sdiv	x17, x1, x4
               	msub	x1, x17, x4, x1
               	cmp	w2, w6
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
               	mov	x4, #0x0                // =0
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x0, x4
               	mov	x1, #-0x80000000        // =-2147483648
               	stur	w1, [x29, #-0xa0]
               	ldr	x1, [x5, x0, lsl #3]
               	sxtw	x1, w1
               	lsr	x2, x1, #33
               	add	x3, x1, x2
               	asr	x6, x3, #31
               	sub	x6, x4, x6
               	and	x3, x3, #0x7fffffff
               	sub	x2, x3, x2
               	ldursw	x3, [x29, #-0xa0]
               	sdiv	x7, x1, x3
               	ldursw	x3, [x29, #-0xa0]
               	sdiv	x17, x1, x3
               	msub	x1, x17, x3, x1
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
               	mov	x0, #0x0                // =0
               	mov	x7, #0xa                // =10
               	mov	x8, #0x6667             // =26215
               	movk	x8, #0x6666, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, #0xa                // =10
               	stur	w1, [x29, #-0x98]
               	ldr	x1, [x5, x0, lsl #3]
               	mov	w2, w1
               	lsr	x4, x2, #1
               	mul	x6, x4, x8
               	lsr	x3, x6, #33
               	mul	x4, x3, x7
               	sub	x4, x2, x4
               	ldur	w6, [x29, #-0x98]
               	udiv	x6, x2, x6
               	ldur	w1, [x29, #-0x98]
               	udiv	x17, x2, x1
               	msub	x1, x17, x1, x2
               	cmp	w3, w6
               	b.ne	<addr>
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
               	mov	x0, #0x0                // =0
               	mov	x10, #0x7               // =7
               	mov	x11, #0x4925            // =18725
               	movk	x11, #0x2492, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, #0x7                // =7
               	stur	w1, [x29, #-0x90]
               	ldr	x2, [x5, x0, lsl #3]
               	mov	w1, w2
               	mul	x6, x1, x11
               	lsr	x3, x6, #32
               	sub	x7, x1, x3
               	lsr	x8, x7, #1
               	add	x9, x8, x3
               	lsr	x4, x9, #2
               	mul	x3, x4, x10
               	sub	x3, x1, x3
               	ldur	w6, [x29, #-0x90]
               	udiv	x6, x1, x6
               	ldur	w2, [x29, #-0x90]
               	udiv	x17, x1, x2
               	msub	x1, x17, x2, x1
               	cmp	w4, w6
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
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x1, #0x8                // =8
               	stur	w1, [x29, #-0x88]
               	ldr	x1, [x4, x0, lsl #3]
               	mov	w2, w1
               	lsr	x5, x2, #3
               	and	x3, x1, #0x7
               	ldur	w6, [x29, #-0x88]
               	udiv	x6, x2, x6
               	ldur	w1, [x29, #-0x88]
               	udiv	x17, x2, x1
               	msub	x1, x17, x1, x2
               	cmp	w5, w6
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
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x1, #0x1                // =1
               	stur	w1, [x29, #-0x80]
               	ldr	x1, [x4, x0, lsl #3]
               	mov	w2, w1
               	ldur	w3, [x29, #-0x80]
               	udiv	x5, x2, x3
               	ldur	w3, [x29, #-0x80]
               	udiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	cmp	w1, w5
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
               	mov	x3, #0x1                // =1
               	movk	x3, #0x8000, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	stur	w3, [x29, #-0x78]
               	ldr	x1, [x5, x0, lsl #3]
               	cmp	w1, w3
               	cset	x6, hs
               	mov	w2, w1
               	cmp	x2, x3
               	cset	x4, hs
               	mul	x4, x4, x3
               	sub	x4, x2, x4
               	ldur	w7, [x29, #-0x78]
               	udiv	x7, x2, x7
               	ldur	w1, [x29, #-0x78]
               	udiv	x17, x2, x1
               	msub	x1, x17, x1, x2
               	cmp	w6, w7
               	b.ne	<addr>
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
               	mov	x0, #0x0                // =0
               	mov	x3, #0x2800             // =10240
               	movk	x3, #0xee6b, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	stur	w3, [x29, #-0x70]
               	ldr	x1, [x5, x0, lsl #3]
               	cmp	w1, w3
               	cset	x6, hs
               	mov	w2, w1
               	cmp	x2, x3
               	cset	x4, hs
               	mul	x4, x4, x3
               	sub	x4, x2, x4
               	ldur	w7, [x29, #-0x70]
               	udiv	x7, x2, x7
               	ldur	w1, [x29, #-0x70]
               	udiv	x17, x2, x1
               	msub	x1, x17, x1, x2
               	cmp	w6, w7
               	b.ne	<addr>
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
               	mov	x0, #0x0                // =0
               	mov	x3, #0xffffffff         // =4294967295
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, #0xffffffff         // =4294967295
               	stur	w1, [x29, #-0x68]
               	ldr	x1, [x5, x0, lsl #3]
               	cmp	w1, w3
               	cset	x6, hs
               	mov	w2, w1
               	cmp	x2, x3
               	cset	x4, hs
               	mul	x4, x4, x3
               	sub	x4, x2, x4
               	ldur	w7, [x29, #-0x68]
               	udiv	x7, x2, x7
               	ldur	w1, [x29, #-0x68]
               	udiv	x17, x2, x1
               	msub	x1, x17, x1, x2
               	cmp	w6, w7
               	b.ne	<addr>
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
               	mov	x0, #0x0                // =0
               	mov	x5, #0xa                // =10
               	mov	x6, #0x5555555555555555 // =6148914691236517205
               	mov	x7, #0x6667             // =26215
               	movk	x7, #0x6666, lsl #16
               	movk	x7, #0x6666, lsl #32
               	movk	x7, #0x6666, lsl #48
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x1, #0xa                // =10
               	stur	x1, [x29, #-0x60]
               	ldr	x1, [x3, x0, lsl #3]
               	cmp	x1, x6
               	b.eq	<addr>
               	smulh	x2, x1, x7
               	asr	x2, x2, #2
               	lsr	x4, x2, #63
               	add	x4, x2, x4
               	mul	x2, x4, x5
               	sub	x8, x1, x2
               	ldur	x2, [x29, #-0x60]
               	sdiv	x9, x1, x2
               	ldur	x2, [x29, #-0x60]
               	sdiv	x17, x1, x2
               	msub	x1, x17, x2, x1
               	cmp	x4, x9
               	b.ne	<addr>
               	cmp	x8, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x3, #0x0                // =0
               	mov	x6, #-0x3e8             // =-1000
               	mov	x7, #0xf7cf             // =63439
               	movk	x7, #0xe353, lsl #16
               	movk	x7, #0x9ba5, lsl #32
               	movk	x7, #0x20c4, lsl #48
               	mov	x8, #0x5555555555555555 // =6148914691236517205
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x0, x3
               	mov	x1, #-0x3e8             // =-1000
               	stur	x1, [x29, #-0x58]
               	ldr	x1, [x4, x0, lsl #3]
               	cmp	x1, x8
               	b.eq	<addr>
               	smulh	x2, x1, x7
               	asr	x2, x2, #7
               	lsr	x5, x2, #63
               	add	x2, x2, x5
               	sub	x5, x3, x2
               	mul	x2, x5, x6
               	sub	x9, x1, x2
               	ldur	x2, [x29, #-0x58]
               	sdiv	x10, x1, x2
               	ldur	x2, [x29, #-0x58]
               	sdiv	x17, x1, x2
               	msub	x1, x17, x2, x1
               	cmp	x5, x10
               	b.ne	<addr>
               	cmp	x9, x1
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
               	mov	x5, #0x5555555555555555 // =6148914691236517205
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x1, #0x1000             // =4096
               	stur	x1, [x29, #-0x50]
               	ldr	x1, [x3, x0, lsl #3]
               	cmp	x1, x5
               	b.eq	<addr>
               	asr	x2, x1, #63
               	lsr	x2, x2, #52
               	add	x4, x1, x2
               	asr	x6, x4, #12
               	and	x4, x4, #0xfff
               	sub	x4, x4, x2
               	ldur	x2, [x29, #-0x50]
               	sdiv	x7, x1, x2
               	ldur	x2, [x29, #-0x50]
               	sdiv	x17, x1, x2
               	msub	x1, x17, x2, x1
               	cmp	x6, x7
               	b.ne	<addr>
               	cmp	x4, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x3, #0x0                // =0
               	mov	x5, #-0x8000000000000000 // =-9223372036854775808
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x0, x3
               	mov	x1, #-0x1               // =-1
               	stur	x1, [x29, #-0x48]
               	ldr	x1, [x4, x0, lsl #3]
               	cmp	x1, x5
               	b.eq	<addr>
               	sub	x6, x3, x1
               	ldur	x2, [x29, #-0x48]
               	sdiv	x7, x1, x2
               	ldur	x2, [x29, #-0x48]
               	sdiv	x17, x1, x2
               	msub	x1, x17, x2, x1
               	cmp	x6, x7
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
               	mov	x3, #0x0                // =0
               	mov	x6, #0x5555555555555555 // =6148914691236517205
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x0, x3
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	stur	x1, [x29, #-0x40]
               	ldr	x1, [x4, x0, lsl #3]
               	cmp	x1, x6
               	b.eq	<addr>
               	asr	x2, x1, #63
               	lsr	x2, x2, #1
               	add	x5, x1, x2
               	asr	x7, x5, #63
               	sub	x7, x3, x7
               	and	x5, x5, #0x7fffffffffffffff
               	sub	x5, x5, x2
               	ldur	x2, [x29, #-0x40]
               	sdiv	x8, x1, x2
               	ldur	x2, [x29, #-0x40]
               	sdiv	x17, x1, x2
               	msub	x1, x17, x2, x1
               	cmp	x7, x8
               	b.ne	<addr>
               	cmp	x5, x1
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
               	mov	x5, #0xa                // =10
               	mov	x6, #0x5555555555555555 // =6148914691236517205
               	mov	x7, #0x6667             // =26215
               	movk	x7, #0x6666, lsl #16
               	movk	x7, #0x6666, lsl #32
               	movk	x7, #0x6666, lsl #48
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x1, #0xa                // =10
               	stur	x1, [x29, #-0x38]
               	ldr	x1, [x3, x0, lsl #3]
               	cmp	x1, x6
               	b.eq	<addr>
               	lsr	x2, x1, #1
               	umulh	x2, x2, x7
               	lsr	x4, x2, #1
               	mul	x2, x4, x5
               	sub	x8, x1, x2
               	ldur	x2, [x29, #-0x38]
               	udiv	x9, x1, x2
               	ldur	x2, [x29, #-0x38]
               	udiv	x17, x1, x2
               	msub	x1, x17, x2, x1
               	cmp	x4, x9
               	b.ne	<addr>
               	cmp	x8, x1
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
               	mov	x5, #0x7                // =7
               	mov	x6, #0x2493             // =9363
               	movk	x6, #0x9249, lsl #16
               	movk	x6, #0x4924, lsl #32
               	movk	x6, #0x2492, lsl #48
               	mov	x7, #0x5555555555555555 // =6148914691236517205
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x1, #0x7                // =7
               	stur	x1, [x29, #-0x30]
               	ldr	x1, [x3, x0, lsl #3]
               	cmp	x1, x7
               	b.eq	<addr>
               	umulh	x2, x1, x6
               	sub	x4, x1, x2
               	lsr	x4, x4, #1
               	add	x2, x4, x2
               	lsr	x4, x2, #2
               	mul	x2, x4, x5
               	sub	x8, x1, x2
               	ldur	x2, [x29, #-0x30]
               	udiv	x9, x1, x2
               	ldur	x2, [x29, #-0x30]
               	udiv	x17, x1, x2
               	msub	x1, x17, x2, x1
               	cmp	x4, x9
               	b.ne	<addr>
               	cmp	x8, x1
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
               	mov	x3, #-0x7fffffffffffffff // =-9223372036854775807
               	mov	x6, #0x5555555555555555 // =6148914691236517205
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x1, #-0x7fffffffffffffff // =-9223372036854775807
               	stur	x1, [x29, #-0x28]
               	ldr	x1, [x4, x0, lsl #3]
               	cmp	x1, x6
               	b.eq	<addr>
               	cmp	x1, x3
               	cset	x5, hs
               	mul	x2, x5, x3
               	sub	x7, x1, x2
               	ldur	x2, [x29, #-0x28]
               	udiv	x8, x1, x2
               	ldur	x2, [x29, #-0x28]
               	udiv	x17, x1, x2
               	msub	x1, x17, x2, x1
               	cmp	x5, x8
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
               	mov	x0, #0x0                // =0
               	mov	x5, #0xd70b             // =55051
               	movk	x5, #0x70a3, lsl #16
               	movk	x5, #0xa3d, lsl #32
               	movk	x5, #0xa3d7, lsl #48
               	mov	x6, #0x64               // =100
               	mov	x7, #0x5555555555555555 // =6148914691236517205
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x1, #0x64               // =100
               	stur	x1, [x29, #-0x20]
               	ldr	x1, [x3, x0, lsl #3]
               	cmp	x1, x7
               	b.eq	<addr>
               	smulh	x2, x1, x5
               	add	x2, x2, x1
               	asr	x2, x2, #6
               	lsr	x4, x2, #63
               	add	x4, x2, x4
               	mul	x2, x4, x6
               	sub	x8, x1, x2
               	ldur	x2, [x29, #-0x20]
               	sdiv	x9, x1, x2
               	ldur	x2, [x29, #-0x20]
               	sdiv	x17, x1, x2
               	msub	x1, x17, x2, x1
               	cmp	x4, x9
               	b.ne	<addr>
               	cmp	x8, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x3, #0x0                // =0
               	mov	x6, #-0x3               // =-3
               	mov	x7, #0x5555555555555555 // =6148914691236517205
               	mov	x8, #0x5556             // =21846
               	movk	x8, #0x5555, lsl #16
               	movk	x8, #0x5555, lsl #32
               	movk	x8, #0x5555, lsl #48
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x0, x3
               	mov	x1, #-0x3               // =-3
               	stur	x1, [x29, #-0x18]
               	ldr	x1, [x4, x0, lsl #3]
               	cmp	x1, x7
               	b.eq	<addr>
               	smulh	x2, x1, x8
               	lsr	x5, x2, #63
               	add	x2, x2, x5
               	sub	x5, x3, x2
               	mul	x2, x5, x6
               	sub	x9, x1, x2
               	ldur	x2, [x29, #-0x18]
               	sdiv	x10, x1, x2
               	ldur	x2, [x29, #-0x18]
               	sdiv	x17, x1, x2
               	msub	x1, x17, x2, x1
               	cmp	x5, x10
               	b.ne	<addr>
               	cmp	x9, x1
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
               	mov	x5, #0x64               // =100
               	mov	x6, #0xf5c3             // =62915
               	movk	x6, #0x5c28, lsl #16
               	movk	x6, #0xc28f, lsl #32
               	movk	x6, #0x28f5, lsl #48
               	mov	x7, #0x5555555555555555 // =6148914691236517205
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x1, #0x64               // =100
               	stur	x1, [x29, #-0x10]
               	ldr	x1, [x3, x0, lsl #3]
               	cmp	x1, x7
               	b.eq	<addr>
               	lsr	x2, x1, #2
               	umulh	x2, x2, x6
               	lsr	x4, x2, #2
               	mul	x2, x4, x5
               	sub	x8, x1, x2
               	ldur	x2, [x29, #-0x10]
               	udiv	x9, x1, x2
               	ldur	x2, [x29, #-0x10]
               	udiv	x17, x1, x2
               	msub	x1, x17, x2, x1
               	cmp	x4, x9
               	b.ne	<addr>
               	cmp	x8, x1
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
               	mov	x5, #0x7                // =7
               	mov	x6, #0x2493             // =9363
               	movk	x6, #0x9249, lsl #16
               	movk	x6, #0x4924, lsl #32
               	movk	x6, #0x2492, lsl #48
               	mov	x7, #0x5555555555555555 // =6148914691236517205
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x1, #0x7                // =7
               	stur	x1, [x29, #-0x8]
               	ldr	x1, [x3, x0, lsl #3]
               	cmp	x1, x7
               	b.eq	<addr>
               	umulh	x2, x1, x6
               	sub	x4, x1, x2
               	lsr	x4, x4, #1
               	add	x2, x4, x2
               	lsr	x4, x2, #2
               	mul	x2, x4, x5
               	sub	x8, x1, x2
               	ldur	x2, [x29, #-0x8]
               	udiv	x9, x1, x2
               	ldur	x2, [x29, #-0x8]
               	udiv	x17, x1, x2
               	msub	x1, x17, x2, x1
               	cmp	x4, x9
               	b.ne	<addr>
               	cmp	x8, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
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
               	mov	x6, #0x3                // =3
               	mov	x7, #0x5556             // =21846
               	movk	x7, #0x5555, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, #0x3                // =3
               	stur	w1, [x29, #-0xa8]
               	ldr	x1, [x5, x0, lsl #3]
               	sxtb	x1, w1
               	mul	x2, x1, x7
               	asr	x2, x2, #32
               	lsr	x3, x2, #63
               	add	x2, x2, x3
               	mul	x3, x2, x6
               	sub	x3, x1, x3
               	ldursw	x4, [x29, #-0xa8]
               	sdiv	x4, x1, x4
               	sxtb	x8, w4
               	ldursw	x4, [x29, #-0xa8]
               	sdiv	x17, x1, x4
               	msub	x1, x17, x4, x1
               	sxtb	x4, w1
               	cmp	w2, w8
               	b.ne	<addr>
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
               	mov	x5, #0x0                // =0
               	mov	x7, #-0x5               // =-5
               	mov	x8, #0x6667             // =26215
               	movk	x8, #0x6666, lsl #16
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x5
               	mov	x1, #-0x5               // =-5
               	stur	w1, [x29, #-0xa0]
               	ldr	x1, [x6, x0, lsl #3]
               	sxtb	x1, w1
               	mul	x2, x1, x8
               	asr	x2, x2, #33
               	lsr	x3, x2, #63
               	add	x2, x2, x3
               	sub	x2, x5, x2
               	mul	x3, x2, x7
               	sub	x3, x1, x3
               	ldursw	x4, [x29, #-0xa0]
               	sdiv	x4, x1, x4
               	sxtb	x9, w4
               	ldursw	x4, [x29, #-0xa0]
               	sdiv	x17, x1, x4
               	msub	x1, x17, x4, x1
               	sxtb	x4, w1
               	cmp	w2, w9
               	b.ne	<addr>
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
               	mov	x3, #0x0                // =0
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x0, x3
               	mov	x1, #-0x1               // =-1
               	stur	w1, [x29, #-0x98]
               	ldr	x1, [x4, x0, lsl #3]
               	sxtb	x1, w1
               	sub	x2, x3, x1
               	sxtb	x5, w2
               	ldursw	x2, [x29, #-0x98]
               	sdiv	x2, x1, x2
               	sxtb	x6, w2
               	ldursw	x2, [x29, #-0x98]
               	sdiv	x17, x1, x2
               	msub	x1, x17, x2, x1
               	sxtb	x2, w1
               	cmp	w5, w6
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
               	mov	x1, #0x0                // =0
               	mov	x6, #0x3                // =3
               	mov	x7, #0x5556             // =21846
               	movk	x7, #0x5555, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x0, #0x3                // =3
               	stur	w0, [x29, #-0x90]
               	ldr	x0, [x5, x1, lsl #3]
               	and	x0, x0, #0xff
               	mul	x2, x0, x7
               	lsr	x2, x2, #32
               	mul	x3, x2, x6
               	sub	x3, x0, x3
               	ldursw	x4, [x29, #-0x90]
               	sdiv	x4, x0, x4
               	and	x8, x4, #0xff
               	ldursw	x4, [x29, #-0x90]
               	sdiv	x17, x0, x4
               	msub	x0, x17, x4, x0
               	cmp	w2, w8
               	b.ne	<addr>
               	and	x0, x0, #0xff
               	cmp	w3, w0
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x0, #0x10               // =16
               	stur	w0, [x29, #-0x88]
               	ldr	x0, [x4, x1, lsl #3]
               	and	x0, x0, #0xff
               	lsr	x5, x0, #4
               	and	x2, x0, #0xf
               	ldursw	x3, [x29, #-0x88]
               	sdiv	x3, x0, x3
               	and	x6, x3, #0xff
               	ldursw	x3, [x29, #-0x88]
               	sdiv	x17, x0, x3
               	msub	x0, x17, x3, x0
               	cmp	w5, w6
               	b.ne	<addr>
               	and	x0, x0, #0xff
               	cmp	w2, w0
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x4, #0x0                // =0
               	mov	x6, #-0x7               // =-7
               	mov	x7, #0x2493             // =9363
               	movk	x7, #0x9249, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, x4
               	mov	x0, #-0x7               // =-7
               	stur	w0, [x29, #-0x80]
               	ldr	x0, [x5, x1, lsl #3]
               	and	x0, x0, #0xff
               	mul	x2, x0, x7
               	asr	x2, x2, #34
               	lsr	x3, x2, #63
               	add	x2, x2, x3
               	sub	x2, x4, x2
               	and	x8, x2, #0xff
               	mul	x2, x2, x6
               	sub	x2, x0, x2
               	ldursw	x3, [x29, #-0x80]
               	sdiv	x3, x0, x3
               	and	x9, x3, #0xff
               	ldursw	x3, [x29, #-0x80]
               	sdiv	x17, x0, x3
               	msub	x0, x17, x3, x0
               	cmp	w8, w9
               	b.ne	<addr>
               	and	x0, x0, #0xff
               	cmp	w2, w0
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
               	mov	x6, #0xa                // =10
               	mov	x7, #0x6667             // =26215
               	movk	x7, #0x6666, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, #0xa                // =10
               	stur	w1, [x29, #-0x78]
               	ldr	x1, [x5, x0, lsl #3]
               	sxth	x1, w1
               	mul	x2, x1, x7
               	asr	x2, x2, #34
               	lsr	x3, x2, #63
               	add	x2, x2, x3
               	mul	x3, x2, x6
               	sub	x3, x1, x3
               	ldursw	x4, [x29, #-0x78]
               	sdiv	x4, x1, x4
               	sxth	x8, w4
               	ldursw	x4, [x29, #-0x78]
               	sdiv	x17, x1, x4
               	msub	x1, x17, x4, x1
               	sxth	x4, w1
               	cmp	w2, w8
               	b.ne	<addr>
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
               	mov	x3, #0x0                // =0
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x0, x3
               	mov	x1, #-0x1               // =-1
               	stur	w1, [x29, #-0x70]
               	ldr	x1, [x4, x0, lsl #3]
               	sxth	x1, w1
               	sub	x2, x3, x1
               	sxth	x5, w2
               	ldursw	x2, [x29, #-0x70]
               	sdiv	x2, x1, x2
               	sxth	x6, w2
               	ldursw	x2, [x29, #-0x70]
               	sdiv	x17, x1, x2
               	msub	x1, x17, x2, x1
               	sxth	x2, w1
               	cmp	w5, w6
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
               	mov	x1, #0x0                // =0
               	mov	x6, #0x3e8              // =1000
               	mov	x7, #0x8938             // =35128
               	movk	x7, #0x41, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x0, #0x3e8              // =1000
               	stur	w0, [x29, #-0x68]
               	ldr	x0, [x5, x1, lsl #3]
               	and	x0, x0, #0xffff
               	mul	x2, x0, x7
               	lsr	x2, x2, #32
               	mul	x3, x2, x6
               	sub	x3, x0, x3
               	ldursw	x4, [x29, #-0x68]
               	sdiv	x4, x0, x4
               	and	x8, x4, #0xffff
               	ldursw	x4, [x29, #-0x68]
               	sdiv	x17, x0, x4
               	msub	x0, x17, x4, x0
               	cmp	w2, w8
               	b.ne	<addr>
               	and	x0, x0, #0xffff
               	cmp	w3, w0
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	mov	x7, #0x7                // =7
               	mov	x8, #0x4925             // =18725
               	movk	x8, #0x2492, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x0, #0x7                // =7
               	stur	w0, [x29, #-0x60]
               	ldr	x0, [x5, x1, lsl #3]
               	and	x0, x0, #0xffff
               	mul	x2, x0, x8
               	lsr	x2, x2, #32
               	mul	x3, x2, x7
               	sub	x3, x0, x3
               	ldur	w4, [x29, #-0x60]
               	udiv	x6, x0, x4
               	ldur	w4, [x29, #-0x60]
               	udiv	x17, x0, x4
               	msub	x0, x17, x4, x0
               	cmp	w2, w6
               	b.ne	<addr>
               	and	x0, x0, #0xffff
               	cmp	w3, w0
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
               	mov	x8, #0x3                // =3
               	mov	x9, #0xaaab             // =43691
               	movk	x9, #0xaaaa, lsl #16
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x1, #0x3                // =3
               	stur	w1, [x29, #-0x58]
               	ldr	x1, [x6, x0, lsl #3]
               	mov	w2, w1
               	mul	x4, x2, x9
               	lsr	x3, x4, #33
               	mul	x4, x3, x8
               	sub	x4, x2, x4
               	ldur	w5, [x29, #-0x58]
               	udiv	x7, x2, x5
               	ldur	w5, [x29, #-0x58]
               	udiv	x17, x2, x5
               	msub	x1, x17, x5, x2
               	cmp	w3, w7
               	b.ne	<addr>
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
               	mov	x1, #0x0                // =0
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x0, #0x80000000         // =2147483648
               	stur	w0, [x29, #-0x50]
               	ldr	x0, [x5, x1, lsl #3]
               	mov	w2, w0
               	lsr	x6, x2, #31
               	and	x3, x0, #0x7fffffff
               	ldur	w4, [x29, #-0x50]
               	udiv	x7, x2, x4
               	ldur	w4, [x29, #-0x50]
               	udiv	x17, x2, x4
               	msub	x0, x17, x4, x2
               	cmp	w6, w7
               	b.ne	<addr>
               	cmp	w3, w0
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
               	mov	x7, #0x3                // =3
               	mov	x8, #0x5556             // =21846
               	movk	x8, #0x5555, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, #0x3                // =3
               	stur	x1, [x29, #-0x48]
               	ldr	x1, [x5, x0, lsl #3]
               	sxtw	x1, w1
               	mul	x2, x1, x8
               	asr	x2, x2, #32
               	lsr	x3, x2, #63
               	add	x2, x2, x3
               	mul	x3, x2, x7
               	sub	x3, x1, x3
               	ldur	x4, [x29, #-0x48]
               	sdiv	x6, x1, x4
               	ldur	x4, [x29, #-0x48]
               	sdiv	x17, x1, x4
               	msub	x1, x17, x4, x1
               	cmp	w2, w6
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
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x1, #0x100000000        // =4294967296
               	stur	x1, [x29, #-0x40]
               	ldr	x1, [x4, x0, lsl #3]
               	sxtw	x1, w1
               	ldur	x2, [x29, #-0x40]
               	sdiv	x2, x1, x2
               	ldur	x3, [x29, #-0x40]
               	sdiv	x17, x1, x3
               	msub	x3, x17, x3, x1
               	cbnz	w2, <addr>
               	cmp	w1, w3
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
               	mov	x7, #0x7                // =7
               	mov	x8, #0x2493             // =9363
               	movk	x8, #0x9249, lsl #16
               	movk	x8, #0x4924, lsl #32
               	movk	x8, #0x2492, lsl #48
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, #0x7                // =7
               	stur	x1, [x29, #-0x38]
               	ldr	x1, [x5, x0, lsl #3]
               	sxtw	x1, w1
               	umulh	x2, x1, x8
               	sub	x3, x1, x2
               	lsr	x3, x3, #1
               	add	x2, x3, x2
               	lsr	x2, x2, #2
               	mul	x3, x2, x7
               	sub	x3, x1, x3
               	ldur	x4, [x29, #-0x38]
               	udiv	x6, x1, x4
               	ldur	x4, [x29, #-0x38]
               	udiv	x17, x1, x4
               	msub	x1, x17, x4, x1
               	cmp	w2, w6
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
               	mov	x10, #0x7               // =7
               	mov	x11, #0x4925            // =18725
               	movk	x11, #0x2492, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, #0x7                // =7
               	stur	x1, [x29, #-0x30]
               	ldr	x2, [x5, x0, lsl #3]
               	mov	w1, w2
               	mul	x6, x1, x11
               	lsr	x3, x6, #32
               	sub	x7, x1, x3
               	lsr	x8, x7, #1
               	add	x9, x8, x3
               	lsr	x4, x9, #2
               	mul	x3, x4, x10
               	sub	x3, x1, x3
               	ldur	x6, [x29, #-0x30]
               	sdiv	x6, x1, x6
               	ldur	x2, [x29, #-0x30]
               	sdiv	x17, x1, x2
               	msub	x1, x17, x2, x1
               	cmp	w4, w6
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
               	mov	x4, #0x0                // =0
               	mov	x11, #-0x7              // =-7
               	mov	x6, #0x4925             // =18725
               	movk	x6, #0x2492, lsl #16
               	movk	x6, #0x9249, lsl #32
               	movk	x6, #0x4924, lsl #48
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	mov	x0, x4
               	mov	x1, #-0x7               // =-7
               	stur	x1, [x29, #-0x28]
               	ldr	x1, [x7, x0, lsl #3]
               	mov	w2, w1
               	smulh	x8, x2, x6
               	asr	x3, x8, #1
               	lsr	x9, x3, #63
               	add	x10, x3, x9
               	sub	x5, x4, x10
               	mul	x3, x5, x11
               	sub	x3, x2, x3
               	ldur	x8, [x29, #-0x28]
               	sdiv	x8, x2, x8
               	ldur	x1, [x29, #-0x28]
               	sdiv	x17, x2, x1
               	msub	x1, x17, x1, x2
               	cmp	w5, w8
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
               	mov	x7, #0xa                // =10
               	mov	x8, #0x6667             // =26215
               	movk	x8, #0x6666, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, #0xa                // =10
               	stur	x1, [x29, #-0x20]
               	ldr	x1, [x5, x0, lsl #3]
               	mov	w2, w1
               	lsr	x4, x2, #1
               	mul	x6, x4, x8
               	lsr	x3, x6, #33
               	mul	x4, x3, x7
               	sub	x4, x2, x4
               	ldur	x6, [x29, #-0x20]
               	udiv	x6, x2, x6
               	ldur	x1, [x29, #-0x20]
               	udiv	x17, x2, x1
               	msub	x1, x17, x1, x2
               	cmp	w3, w6
               	b.ne	<addr>
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
               	mov	x0, #0x0                // =0
               	mov	x5, #0xe38f             // =58255
               	movk	x5, #0x8e38, lsl #16
               	movk	x5, #0x38e3, lsl #32
               	movk	x5, #0xe38e, lsl #48
               	mov	x6, #0x9                // =9
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x1, #0x9                // =9
               	stur	x1, [x29, #-0x18]
               	ldr	x1, [x4, x0, lsl #3]
               	sxth	x1, w1
               	umulh	x2, x1, x5
               	lsr	x2, x2, #3
               	sxth	x7, w2
               	mul	x2, x2, x6
               	sub	x2, x1, x2
               	ldur	x3, [x29, #-0x18]
               	udiv	x3, x1, x3
               	sxth	x8, w3
               	ldur	x3, [x29, #-0x18]
               	udiv	x17, x1, x3
               	msub	x1, x17, x3, x1
               	sxth	x3, w1
               	cmp	w7, w8
               	b.ne	<addr>
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x3, #0x0                // =0
               	mov	x6, #-0xa               // =-10
               	mov	x7, #0x5555555555555555 // =6148914691236517205
               	mov	x8, #0x6667             // =26215
               	movk	x8, #0x6666, lsl #16
               	movk	x8, #0x6666, lsl #32
               	movk	x8, #0x6666, lsl #48
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x0, x3
               	mov	x1, #-0xa               // =-10
               	stur	w1, [x29, #-0x10]
               	ldr	x1, [x4, x0, lsl #3]
               	cmp	x1, x7
               	b.eq	<addr>
               	smulh	x2, x1, x8
               	asr	x2, x2, #2
               	lsr	x5, x2, #63
               	add	x2, x2, x5
               	sub	x5, x3, x2
               	mul	x2, x5, x6
               	sub	x9, x1, x2
               	ldursw	x2, [x29, #-0x10]
               	sdiv	x10, x1, x2
               	ldursw	x2, [x29, #-0x10]
               	sdiv	x17, x1, x2
               	msub	x1, x17, x2, x1
               	cmp	x5, x10
               	b.ne	<addr>
               	cmp	x9, x1
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
               	mov	x5, #0xa                // =10
               	mov	x6, #0x5555555555555555 // =6148914691236517205
               	mov	x7, #0x6667             // =26215
               	movk	x7, #0x6666, lsl #16
               	movk	x7, #0x6666, lsl #32
               	movk	x7, #0x6666, lsl #48
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x1, #0xa                // =10
               	stur	w1, [x29, #-0x8]
               	ldr	x1, [x3, x0, lsl #3]
               	cmp	x1, x6
               	b.eq	<addr>
               	lsr	x2, x1, #1
               	umulh	x2, x2, x7
               	lsr	x4, x2, #1
               	mul	x2, x4, x5
               	sub	x8, x1, x2
               	ldursw	x2, [x29, #-0x8]
               	udiv	x9, x1, x2
               	ldursw	x2, [x29, #-0x8]
               	udiv	x17, x1, x2
               	msub	x1, x17, x2, x1
               	cmp	x4, x9
               	b.ne	<addr>
               	cmp	x8, x1
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
               	mov	x3, #0x6667             // =26215
               	movk	x3, #0x6666, lsl #16
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x2, [x1, x0, lsl #3]
               	stur	w2, [x29, #-0x28]
               	ldr	x2, [x1, x0, lsl #3]
               	stur	w2, [x29, #-0x20]
               	mov	x2, #0xa                // =10
               	stur	w2, [x29, #-0x18]
               	ldursw	x2, [x29, #-0x28]
               	mul	x2, x2, x3
               	asr	x2, x2, #34
               	lsr	x4, x2, #63
               	add	x2, x2, x4
               	stur	w2, [x29, #-0x28]
               	ldursw	x2, [x29, #-0x20]
               	ldursw	x4, [x29, #-0x18]
               	sdiv	x2, x2, x4
               	stur	w2, [x29, #-0x20]
               	ldursw	x2, [x29, #-0x28]
               	ldursw	x4, [x29, #-0x20]
               	cmp	w2, w4
               	b.ne	<addr>
               	ldr	x2, [x1, x0, lsl #3]
               	stur	w2, [x29, #-0x28]
               	ldr	x2, [x1, x0, lsl #3]
               	stur	w2, [x29, #-0x20]
               	ldursw	x2, [x29, #-0x28]
               	mul	x4, x2, x3
               	asr	x4, x4, #34
               	lsr	x6, x4, #63
               	add	x4, x4, x6
               	mul	x4, x4, x5
               	sub	x2, x2, x4
               	stur	w2, [x29, #-0x28]
               	ldursw	x4, [x29, #-0x20]
               	ldursw	x2, [x29, #-0x18]
               	sdiv	x17, x4, x2
               	msub	x2, x17, x2, x4
               	stur	w2, [x29, #-0x20]
               	ldursw	x2, [x29, #-0x28]
               	ldursw	x4, [x29, #-0x20]
               	cmp	w2, w4
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
               	sub	x3, x29, #0x88
               	ldr	x1, [x2, x0, lsl #3]
               	str	w1, [x3, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	mov	x3, #0x0                // =0
               	mov	x8, #-0x9               // =-9
               	mov	x4, #0x8e39             // =36409
               	movk	x4, #0x38e3, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x0, x3
               	mov	x1, #-0x9               // =-9
               	stur	w1, [x29, #-0x10]
               	ldr	x1, [x5, x0, lsl #3]
               	sxtw	x1, w1
               	ldursw	x2, [x29, #-0x10]
               	sdiv	x2, x1, x2
               	sub	x1, x29, #0x88
               	ldrsw	x6, [x1, x0, lsl #2]
               	mul	x6, x6, x4
               	asr	x6, x6, #33
               	lsr	x7, x6, #63
               	add	x6, x6, x7
               	sub	x6, x3, x6
               	str	w6, [x1, x0, lsl #2]
               	cmp	w6, w2
               	b.ne	<addr>
               	ldrsw	x6, [x1, x0, lsl #2]
               	cmp	w6, w2
               	b.ne	<addr>
               	sxtw	x6, w2
               	ldursw	x2, [x29, #-0x10]
               	sdiv	x17, x6, x2
               	msub	x2, x17, x2, x6
               	ldrsw	x6, [x1, x0, lsl #2]
               	mul	x7, x6, x4
               	asr	x7, x7, #33
               	lsr	x9, x7, #63
               	add	x7, x7, x9
               	sub	x7, x3, x7
               	mul	x7, x7, x8
               	sub	x6, x6, x7
               	str	w6, [x1, x0, lsl #2]
               	mov	x1, x6
               	cmp	w1, w2
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
               	mov	x7, #0x3                // =3
               	mov	x4, #0x5556             // =21846
               	movk	x4, #0x5555, lsl #16
               	mov	x8, #0x5556             // =21846
               	movk	x8, #0x5555, lsl #16
               	movk	x8, #0x5555, lsl #32
               	movk	x8, #0x5555, lsl #48
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x1, #0x3                // =3
               	stur	w1, [x29, #-0x8]
               	sub	x1, x29, #0x90
               	sub	x3, x29, #0x30
               	ldr	x5, [x2, x0, lsl #3]
               	and	x6, x5, #0x7ff
               	ldr	w5, [x3]
               	and	x5, x5, #0xfffffffffffff800
               	orr	x5, x5, x6
               	str	w5, [x3]
               	lsl	x6, x6, #53
               	asr	x6, x6, #53
               	and	x9, x6, #0x7ff
               	ldr	w6, [x1]
               	and	x6, x6, #0xfffffffffffff800
               	orr	x6, x6, x9
               	str	w6, [x1]
               	ldr	x9, [x2, x0, lsl #3]
               	and	x9, x9, #0x1fff
               	and	x10, x5, #0xffffffffff0007ff
               	lsl	x5, x9, #11
               	orr	x9, x10, x5
               	str	w9, [x3]
               	and	x6, x6, #0xffffffffff0007ff
               	orr	x5, x6, x5
               	str	w5, [x1]
               	ldr	x5, [x2, x0, lsl #3]
               	and	x5, x5, #0xffffffffff
               	ldr	x6, [x3]
               	and	x6, x6, #0xffffff
               	lsl	x5, x5, #24
               	orr	x6, x6, x5
               	str	x6, [x3]
               	asr	x5, x5, #24
               	and	x5, x5, #0xffffffffff
               	ldr	x6, [x1]
               	and	x6, x6, #0xffffff
               	lsl	x5, x5, #24
               	orr	x6, x6, x5
               	str	x6, [x1]
               	ldr	w5, [x1]
               	and	x6, x5, #0x7ff
               	lsl	x6, x6, #53
               	asr	x6, x6, #53
               	mul	x6, x6, x4
               	asr	x6, x6, #32
               	lsr	x9, x6, #63
               	add	x6, x6, x9
               	and	x6, x6, #0x7ff
               	and	x5, x5, #0xfffffffffffff800
               	orr	x5, x5, x6
               	str	w5, [x1]
               	ldr	w6, [x3]
               	and	x9, x6, #0x7ff
               	lsl	x9, x9, #53
               	asr	x9, x9, #53
               	ldursw	x10, [x29, #-0x8]
               	sdiv	x9, x9, x10
               	and	x9, x9, #0x7ff
               	and	x6, x6, #0xfffffffffffff800
               	orr	x6, x6, x9
               	str	w6, [x3]
               	mov	w9, w5
               	asr	x9, x9, #11
               	and	x9, x9, #0x1fff
               	mul	x9, x9, x4
               	lsr	x9, x9, #32
               	and	x5, x5, #0xffffffffff0007ff
               	lsl	x9, x9, #11
               	orr	x5, x5, x9
               	str	w5, [x1]
               	mov	w5, w6
               	asr	x5, x5, #11
               	and	x5, x5, #0x1fff
               	ldursw	x9, [x29, #-0x8]
               	sdiv	x5, x5, x9
               	and	x5, x5, #0x1fff
               	and	x6, x6, #0xffffffffff0007ff
               	lsl	x5, x5, #11
               	orr	x5, x6, x5
               	str	w5, [x3]
               	ldr	x5, [x1]
               	asr	x6, x5, #24
               	and	x6, x6, #0xffffffffff
               	lsl	x6, x6, #24
               	asr	x6, x6, #24
               	smulh	x6, x6, x8
               	lsr	x9, x6, #63
               	add	x6, x6, x9
               	and	x6, x6, #0xffffffffff
               	and	x9, x5, #0xffffff
               	lsl	x5, x6, #24
               	orr	x6, x9, x5
               	str	x6, [x1]
               	ldr	x5, [x3]
               	asr	x9, x5, #24
               	and	x9, x9, #0xffffffffff
               	lsl	x9, x9, #24
               	asr	x9, x9, #24
               	ldursw	x10, [x29, #-0x8]
               	sdiv	x9, x9, x10
               	and	x9, x9, #0xffffffffff
               	and	x10, x5, #0xffffff
               	lsl	x5, x9, #24
               	orr	x9, x10, x5
               	str	x9, [x3]
               	ldr	w1, [x1]
               	and	x1, x1, #0x7ff
               	lsl	x1, x1, #53
               	asr	x1, x1, #53
               	sub	x3, x29, #0x30
               	ldr	w5, [x3]
               	and	x5, x5, #0x7ff
               	lsl	x5, x5, #53
               	asr	x5, x5, #53
               	cmp	w1, w5
               	b.ne	<addr>
               	sub	x1, x29, #0x90
               	ldr	w5, [x1]
               	asr	x5, x5, #11
               	and	x5, x5, #0x1fff
               	ldr	w10, [x3]
               	asr	x10, x10, #11
               	and	x10, x10, #0x1fff
               	cmp	w5, w10
               	b.ne	<addr>
               	asr	x5, x6, #24
               	and	x5, x5, #0xffffffffff
               	lsl	x5, x5, #24
               	asr	x5, x5, #24
               	asr	x6, x9, #24
               	and	x6, x6, #0xffffffffff
               	lsl	x6, x6, #24
               	asr	x6, x6, #24
               	cmp	x5, x6
               	b.ne	<addr>
               	ldr	x5, [x2, x0, lsl #3]
               	and	x6, x5, #0x7ff
               	ldr	w5, [x3]
               	and	x5, x5, #0xfffffffffffff800
               	orr	x5, x5, x6
               	str	w5, [x3]
               	lsl	x6, x6, #53
               	asr	x6, x6, #53
               	and	x9, x6, #0x7ff
               	ldr	w6, [x1]
               	and	x6, x6, #0xfffffffffffff800
               	orr	x6, x6, x9
               	str	w6, [x1]
               	ldr	x9, [x2, x0, lsl #3]
               	and	x9, x9, #0x1fff
               	and	x10, x5, #0xffffffffff0007ff
               	lsl	x5, x9, #11
               	orr	x9, x10, x5
               	str	w9, [x3]
               	and	x6, x6, #0xffffffffff0007ff
               	orr	x5, x6, x5
               	str	w5, [x1]
               	ldr	x5, [x2, x0, lsl #3]
               	and	x5, x5, #0xffffffffff
               	ldr	x6, [x3]
               	and	x6, x6, #0xffffff
               	lsl	x5, x5, #24
               	orr	x6, x6, x5
               	str	x6, [x3]
               	asr	x5, x5, #24
               	and	x5, x5, #0xffffffffff
               	ldr	x6, [x1]
               	and	x6, x6, #0xffffff
               	lsl	x5, x5, #24
               	orr	x6, x6, x5
               	str	x6, [x1]
               	ldr	w5, [x1]
               	and	x6, x5, #0x7ff
               	lsl	x6, x6, #53
               	asr	x6, x6, #53
               	mul	x9, x6, x4
               	asr	x9, x9, #32
               	lsr	x10, x9, #63
               	add	x9, x9, x10
               	mul	x9, x9, x7
               	sub	x6, x6, x9
               	and	x6, x6, #0x7ff
               	and	x5, x5, #0xfffffffffffff800
               	orr	x5, x5, x6
               	str	w5, [x1]
               	ldr	w9, [x3]
               	and	x6, x9, #0x7ff
               	lsl	x6, x6, #53
               	asr	x10, x6, #53
               	ldursw	x6, [x29, #-0x8]
               	sdiv	x17, x10, x6
               	msub	x6, x17, x6, x10
               	and	x10, x6, #0x7ff
               	and	x6, x9, #0xfffffffffffff800
               	orr	x6, x6, x10
               	str	w6, [x3]
               	mov	w9, w5
               	asr	x9, x9, #11
               	and	x9, x9, #0x1fff
               	mul	x10, x9, x4
               	lsr	x10, x10, #32
               	mul	x10, x10, x7
               	sub	x9, x9, x10
               	and	x5, x5, #0xffffffffff0007ff
               	lsl	x9, x9, #11
               	orr	x5, x5, x9
               	str	w5, [x1]
               	mov	w5, w6
               	asr	x5, x5, #11
               	and	x9, x5, #0x1fff
               	ldursw	x5, [x29, #-0x8]
               	sdiv	x17, x9, x5
               	msub	x5, x17, x5, x9
               	and	x5, x5, #0x1fff
               	and	x6, x6, #0xffffffffff0007ff
               	lsl	x5, x5, #11
               	orr	x5, x6, x5
               	str	w5, [x3]
               	ldr	x3, [x1]
               	asr	x5, x3, #24
               	and	x5, x5, #0xffffffffff
               	lsl	x5, x5, #24
               	asr	x5, x5, #24
               	smulh	x6, x5, x8
               	lsr	x9, x6, #63
               	add	x6, x6, x9
               	mul	x6, x6, x7
               	sub	x5, x5, x6
               	and	x5, x5, #0xffffffffff
               	and	x6, x3, #0xffffff
               	lsl	x3, x5, #24
               	orr	x5, x6, x3
               	str	x5, [x1]
               	sub	x1, x29, #0x30
               	ldr	x6, [x1]
               	asr	x3, x6, #24
               	and	x3, x3, #0xffffffffff
               	lsl	x3, x3, #24
               	asr	x9, x3, #24
               	ldursw	x3, [x29, #-0x8]
               	sdiv	x17, x9, x3
               	msub	x3, x17, x3, x9
               	and	x3, x3, #0xffffffffff
               	and	x6, x6, #0xffffff
               	lsl	x3, x3, #24
               	orr	x6, x6, x3
               	str	x6, [x1]
               	sub	x3, x29, #0x90
               	ldr	w9, [x3]
               	and	x9, x9, #0x7ff
               	lsl	x9, x9, #53
               	asr	x9, x9, #53
               	ldr	w10, [x1]
               	and	x10, x10, #0x7ff
               	lsl	x10, x10, #53
               	asr	x10, x10, #53
               	cmp	w9, w10
               	b.ne	<addr>
               	ldr	w3, [x3]
               	asr	x3, x3, #11
               	and	x3, x3, #0x1fff
               	ldr	w1, [x1]
               	asr	x1, x1, #11
               	and	x1, x1, #0x1fff
               	cmp	w3, w1
               	b.ne	<addr>
               	asr	x1, x5, #24
               	and	x1, x1, #0xffffffffff
               	lsl	x1, x1, #24
               	asr	x1, x1, #24
               	asr	x3, x6, #24
               	and	x3, x3, #0xffffffffff
               	lsl	x3, x3, #24
               	asr	x3, x3, #24
               	cmp	x1, x3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
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
