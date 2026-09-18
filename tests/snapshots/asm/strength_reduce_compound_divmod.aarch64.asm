
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
               	mov	x1, #0x0                // =0
               	mov	x7, #0xa                // =10
               	mov	x8, #0x6667             // =26215
               	movk	x8, #0x6666, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	mov	x0, #0xa                // =10
               	stur	w0, [x29, #-0xe0]
               	sxtw	x0, w1
               	ldr	x0, [x5, x0, lsl #3]
               	sxtw	x0, w0
               	mul	x4, x0, x8
               	asr	x2, x4, #34
               	lsr	x6, x2, #63
               	add	x3, x2, x6
               	mul	x2, x3, x7
               	sub	x2, x0, x2
               	ldursw	x4, [x29, #-0xe0]
               	sdiv	x6, x0, x4
               	ldursw	x4, [x29, #-0xe0]
               	sdiv	x17, x0, x4
               	msub	x0, x17, x4, x0
               	cmp	w3, w6
               	b.ne	<addr>
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
               	mov	x1, #0x0                // =0
               	mov	x7, #0x7                // =7
               	mov	x8, #0x2493             // =9363
               	movk	x8, #0x9249, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	mov	x0, #0x7                // =7
               	stur	w0, [x29, #-0xd8]
               	sxtw	x0, w1
               	ldr	x0, [x5, x0, lsl #3]
               	sxtw	x0, w0
               	mul	x4, x0, x8
               	asr	x2, x4, #34
               	lsr	x6, x2, #63
               	add	x3, x2, x6
               	mul	x2, x3, x7
               	sub	x2, x0, x2
               	ldursw	x4, [x29, #-0xd8]
               	sdiv	x6, x0, x4
               	ldursw	x4, [x29, #-0xd8]
               	sdiv	x17, x0, x4
               	msub	x0, x17, x4, x0
               	cmp	w3, w6
               	b.ne	<addr>
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
               	mov	x3, #0x0                // =0
               	mov	x9, #-0x7               // =-7
               	mov	x10, #0x2493            // =9363
               	movk	x10, #0x9249, lsl #16
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x1, x3
               	b	<addr>
               	mov	x0, #-0x7               // =-7
               	stur	w0, [x29, #-0xd0]
               	sxtw	x0, w1
               	ldr	x0, [x6, x0, lsl #3]
               	sxtw	x0, w0
               	mul	x5, x0, x10
               	asr	x2, x5, #34
               	lsr	x7, x2, #63
               	add	x8, x2, x7
               	sub	x4, x3, x8
               	mul	x2, x4, x9
               	sub	x2, x0, x2
               	ldursw	x5, [x29, #-0xd0]
               	sdiv	x7, x0, x5
               	ldursw	x5, [x29, #-0xd0]
               	sdiv	x17, x0, x5
               	msub	x0, x17, x5, x0
               	cmp	w4, w7
               	b.ne	<addr>
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
               	mov	x1, #0x0                // =0
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	mov	x0, #0x10               // =16
               	stur	w0, [x29, #-0xc8]
               	sxtw	x0, w1
               	ldr	x0, [x4, x0, lsl #3]
               	sxtw	x0, w0
               	lsr	x2, x0, #60
               	add	x3, x0, x2
               	asr	x5, x3, #4
               	and	x3, x3, #0xf
               	sub	x2, x3, x2
               	ldursw	x3, [x29, #-0xc8]
               	sdiv	x6, x0, x3
               	ldursw	x3, [x29, #-0xc8]
               	sdiv	x17, x0, x3
               	msub	x0, x17, x3, x0
               	cmp	w5, w6
               	b.ne	<addr>
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
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, x4
               	b	<addr>
               	mov	x0, #-0x10              // =-16
               	stur	w0, [x29, #-0xc0]
               	sxtw	x0, w1
               	ldr	x0, [x5, x0, lsl #3]
               	sxtw	x0, w0
               	lsr	x2, x0, #60
               	add	x3, x0, x2
               	asr	x6, x3, #4
               	sub	x6, x4, x6
               	and	x3, x3, #0xf
               	sub	x2, x3, x2
               	ldursw	x3, [x29, #-0xc0]
               	sdiv	x7, x0, x3
               	ldursw	x3, [x29, #-0xc0]
               	sdiv	x17, x0, x3
               	msub	x0, x17, x3, x0
               	cmp	w6, w7
               	b.ne	<addr>
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
               	mov	x1, #0x0                // =0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	mov	x0, #0x1                // =1
               	stur	w0, [x29, #-0xb8]
               	sxtw	x0, w1
               	ldr	x0, [x3, x0, lsl #3]
               	sxtw	x0, w0
               	ldursw	x2, [x29, #-0xb8]
               	sdiv	x4, x0, x2
               	ldursw	x2, [x29, #-0xb8]
               	sdiv	x17, x0, x2
               	msub	x2, x17, x2, x0
               	cmp	w0, w4
               	b.ne	<addr>
               	cbnz	x2, <addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x18
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
               	mov	x1, x3
               	b	<addr>
               	mov	x0, #-0x1               // =-1
               	stur	w0, [x29, #-0xb0]
               	sxtw	x0, w1
               	ldr	x0, [x4, x0, lsl #3]
               	sxtw	x0, w0
               	cmp	w0, w7
               	b.eq	<addr>
               	sub	x5, x3, x0
               	ldursw	x2, [x29, #-0xb0]
               	sdiv	x6, x0, x2
               	ldursw	x2, [x29, #-0xb0]
               	sdiv	x17, x0, x2
               	msub	x0, x17, x2, x0
               	cmp	w5, w6
               	b.ne	<addr>
               	cbnz	x0, <addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	mov	x7, #0x1                // =1
               	movk	x7, #0x4000, lsl #16
               	mov	x8, #0x7fffffff         // =2147483647
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	mov	x0, #0x7fffffff         // =2147483647
               	stur	w0, [x29, #-0xa8]
               	sxtw	x0, w1
               	ldr	x0, [x5, x0, lsl #3]
               	sxtw	x0, w0
               	mul	x4, x0, x7
               	asr	x2, x4, #61
               	lsr	x6, x2, #63
               	add	x3, x2, x6
               	mul	x2, x3, x8
               	sub	x2, x0, x2
               	ldursw	x4, [x29, #-0xa8]
               	sdiv	x6, x0, x4
               	ldursw	x4, [x29, #-0xa8]
               	sdiv	x17, x0, x4
               	msub	x0, x17, x4, x0
               	cmp	w3, w6
               	b.ne	<addr>
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
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, x4
               	b	<addr>
               	mov	x0, #-0x80000000        // =-2147483648
               	stur	w0, [x29, #-0xa0]
               	sxtw	x0, w1
               	ldr	x0, [x5, x0, lsl #3]
               	sxtw	x0, w0
               	lsr	x2, x0, #33
               	add	x3, x0, x2
               	asr	x6, x3, #31
               	sub	x6, x4, x6
               	and	x3, x3, #0x7fffffff
               	sub	x2, x3, x2
               	ldursw	x3, [x29, #-0xa0]
               	sdiv	x7, x0, x3
               	ldursw	x3, [x29, #-0xa0]
               	sdiv	x17, x0, x3
               	msub	x0, x17, x3, x0
               	cmp	w6, w7
               	b.ne	<addr>
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
               	mov	x1, #0x0                // =0
               	mov	x7, #0xa                // =10
               	mov	x8, #0x6667             // =26215
               	movk	x8, #0x6666, lsl #16
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	mov	x0, #0xa                // =10
               	stur	w0, [x29, #-0x98]
               	sxtw	x0, w1
               	ldr	x0, [x4, x0, lsl #3]
               	mov	w0, w0
               	lsr	x5, x0, #1
               	mul	x6, x5, x8
               	lsr	x3, x6, #33
               	mul	x5, x3, x7
               	sub	x5, x0, x5
               	ldur	w6, [x29, #-0x98]
               	udiv	x6, x0, x6
               	mov	w6, w6
               	ldur	w2, [x29, #-0x98]
               	udiv	x17, x0, x2
               	msub	x0, x17, x2, x0
               	cmp	w3, w6
               	b.ne	<addr>
               	mov	w2, w5
               	mov	w0, w0
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
               	mov	x1, #0x0                // =0
               	mov	x10, #0x7               // =7
               	mov	x11, #0x4925            // =18725
               	movk	x11, #0x2492, lsl #16
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	mov	x0, #0x7                // =7
               	stur	w0, [x29, #-0x90]
               	sxtw	x0, w1
               	ldr	x0, [x4, x0, lsl #3]
               	mov	w0, w0
               	mul	x5, x0, x11
               	lsr	x2, x5, #32
               	sub	x6, x0, x2
               	lsr	x7, x6, #1
               	add	x8, x7, x2
               	lsr	x9, x8, #2
               	mov	w12, w9
               	mul	x2, x9, x10
               	sub	x5, x0, x2
               	ldur	w2, [x29, #-0x90]
               	udiv	x2, x0, x2
               	mov	w6, w2
               	ldur	w2, [x29, #-0x90]
               	udiv	x17, x0, x2
               	msub	x0, x17, x2, x0
               	cmp	w12, w6
               	b.ne	<addr>
               	mov	w2, w5
               	mov	w0, w0
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
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	mov	x1, #0x8                // =8
               	stur	w1, [x29, #-0x88]
               	sxtw	x1, w0
               	ldr	x1, [x4, x1, lsl #3]
               	mov	w1, w1
               	lsr	x5, x1, #3
               	and	x3, x1, #0x7
               	ldur	w6, [x29, #-0x88]
               	udiv	x6, x1, x6
               	mov	w6, w6
               	ldur	w2, [x29, #-0x88]
               	udiv	x17, x1, x2
               	msub	x1, x17, x2, x1
               	cmp	w5, w6
               	b.ne	<addr>
               	mov	w1, w1
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
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	mov	x1, #0x1                // =1
               	stur	w1, [x29, #-0x80]
               	sxtw	x1, w0
               	ldr	x1, [x3, x1, lsl #3]
               	mov	w1, w1
               	ldur	w4, [x29, #-0x80]
               	udiv	x4, x1, x4
               	mov	w4, w4
               	ldur	w2, [x29, #-0x80]
               	udiv	x17, x1, x2
               	msub	x2, x17, x2, x1
               	cmp	w1, w4
               	b.ne	<addr>
               	mov	w1, w2
               	cbnz	x1, <addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	mov	x2, #0x1                // =1
               	movk	x2, #0x8000, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	stur	w2, [x29, #-0x78]
               	sxtw	x0, w1
               	ldr	x0, [x5, x0, lsl #3]
               	mov	w0, w0
               	cmp	w0, w2
               	cset	x4, hs
               	mul	x6, x4, x2
               	sub	x6, x0, x6
               	ldur	w7, [x29, #-0x78]
               	udiv	x7, x0, x7
               	mov	w7, w7
               	ldur	w3, [x29, #-0x78]
               	udiv	x17, x0, x3
               	msub	x0, x17, x3, x0
               	cmp	w4, w7
               	b.ne	<addr>
               	mov	w3, w6
               	mov	w0, w0
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
               	mov	x2, #0x2800             // =10240
               	movk	x2, #0xee6b, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	stur	w2, [x29, #-0x70]
               	sxtw	x0, w1
               	ldr	x0, [x5, x0, lsl #3]
               	mov	w0, w0
               	cmp	w0, w2
               	cset	x4, hs
               	mul	x6, x4, x2
               	sub	x6, x0, x6
               	ldur	w7, [x29, #-0x70]
               	udiv	x7, x0, x7
               	mov	w7, w7
               	ldur	w3, [x29, #-0x70]
               	udiv	x17, x0, x3
               	msub	x0, x17, x3, x0
               	cmp	w4, w7
               	b.ne	<addr>
               	mov	w3, w6
               	mov	w0, w0
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
               	mov	x4, #0xffffffff         // =4294967295
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	mov	x0, #0xffffffff         // =4294967295
               	stur	w0, [x29, #-0x68]
               	sxtw	x0, w1
               	ldr	x0, [x5, x0, lsl #3]
               	mov	w0, w0
               	cmp	w0, w4
               	cset	x3, hs
               	mul	x6, x3, x4
               	sub	x6, x0, x6
               	ldur	w7, [x29, #-0x68]
               	udiv	x7, x0, x7
               	mov	w7, w7
               	ldur	w2, [x29, #-0x68]
               	udiv	x17, x0, x2
               	msub	x0, x17, x2, x0
               	cmp	w3, w7
               	b.ne	<addr>
               	mov	w2, w6
               	mov	w0, w0
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
               	mov	x8, #0xa                // =10
               	mov	x9, #0x5555555555555555 // =6148914691236517205
               	mov	x3, #0x6667             // =26215
               	movk	x3, #0x6666, lsl #16
               	movk	x3, #0x6666, lsl #32
               	movk	x3, #0x6666, lsl #48
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	mov	x1, #0xa                // =10
               	stur	x1, [x29, #-0x60]
               	sxtw	x1, w0
               	ldr	x1, [x4, x1, lsl #3]
               	cmp	x1, x9
               	b.eq	<addr>
               	smulh	x5, x1, x3
               	asr	x2, x5, #2
               	lsr	x6, x2, #63
               	add	x7, x2, x6
               	mul	x2, x7, x8
               	sub	x5, x1, x2
               	ldur	x2, [x29, #-0x60]
               	sdiv	x6, x1, x2
               	ldur	x2, [x29, #-0x60]
               	sdiv	x17, x1, x2
               	msub	x1, x17, x2, x1
               	cmp	x7, x6
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
               	mov	x3, #0x0                // =0
               	mov	x10, #-0x3e8            // =-1000
               	mov	x4, #0xf7cf             // =63439
               	movk	x4, #0xe353, lsl #16
               	movk	x4, #0x9ba5, lsl #32
               	movk	x4, #0x20c4, lsl #48
               	mov	x11, #0x5555555555555555 // =6148914691236517205
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, x3
               	b	<addr>
               	mov	x0, #-0x3e8             // =-1000
               	stur	x0, [x29, #-0x58]
               	sxtw	x0, w1
               	ldr	x0, [x5, x0, lsl #3]
               	cmp	x0, x11
               	b.eq	<addr>
               	smulh	x6, x0, x4
               	asr	x2, x6, #7
               	lsr	x7, x2, #63
               	add	x8, x2, x7
               	sub	x9, x3, x8
               	mul	x2, x9, x10
               	sub	x6, x0, x2
               	ldur	x2, [x29, #-0x58]
               	sdiv	x7, x0, x2
               	ldur	x2, [x29, #-0x58]
               	sdiv	x17, x0, x2
               	msub	x0, x17, x2, x0
               	cmp	x9, x7
               	b.ne	<addr>
               	cmp	x6, x0
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
               	mov	x6, #0x5555555555555555 // =6148914691236517205
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	mov	x0, #0x1000             // =4096
               	stur	x0, [x29, #-0x50]
               	sxtw	x0, w1
               	ldr	x0, [x3, x0, lsl #3]
               	cmp	x0, x6
               	b.eq	<addr>
               	asr	x4, x0, #63
               	lsr	x2, x4, #52
               	add	x5, x0, x2
               	asr	x7, x5, #12
               	and	x4, x5, #0xfff
               	sub	x4, x4, x2
               	ldur	x2, [x29, #-0x50]
               	sdiv	x5, x0, x2
               	ldur	x2, [x29, #-0x50]
               	sdiv	x17, x0, x2
               	msub	x0, x17, x2, x0
               	cmp	x7, x5
               	b.ne	<addr>
               	cmp	x4, x0
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x18
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
               	b	<addr>
               	mov	x1, #-0x1               // =-1
               	stur	x1, [x29, #-0x48]
               	sxtw	x1, w0
               	ldr	x1, [x4, x1, lsl #3]
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
               	mov	x7, #0x5555555555555555 // =6148914691236517205
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x1, x3
               	b	<addr>
               	mov	x0, #-0x8000000000000000 // =-9223372036854775808
               	stur	x0, [x29, #-0x40]
               	sxtw	x0, w1
               	ldr	x0, [x4, x0, lsl #3]
               	cmp	x0, x7
               	b.eq	<addr>
               	asr	x5, x0, #63
               	lsr	x2, x5, #1
               	add	x6, x0, x2
               	asr	x8, x6, #63
               	sub	x8, x3, x8
               	and	x5, x6, #0x7fffffffffffffff
               	sub	x5, x5, x2
               	ldur	x2, [x29, #-0x40]
               	sdiv	x6, x0, x2
               	ldur	x2, [x29, #-0x40]
               	sdiv	x17, x0, x2
               	msub	x0, x17, x2, x0
               	cmp	x8, x6
               	b.ne	<addr>
               	cmp	x5, x0
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
               	mov	x7, #0xa                // =10
               	mov	x8, #0x5555555555555555 // =6148914691236517205
               	mov	x3, #0x6667             // =26215
               	movk	x3, #0x6666, lsl #16
               	movk	x3, #0x6666, lsl #32
               	movk	x3, #0x6666, lsl #48
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	mov	x1, #0xa                // =10
               	stur	x1, [x29, #-0x38]
               	sxtw	x1, w0
               	ldr	x1, [x4, x1, lsl #3]
               	cmp	x1, x8
               	b.eq	<addr>
               	lsr	x2, x1, #1
               	umulh	x5, x2, x3
               	lsr	x6, x5, #1
               	mul	x2, x6, x7
               	sub	x5, x1, x2
               	ldur	x2, [x29, #-0x38]
               	udiv	x9, x1, x2
               	ldur	x2, [x29, #-0x38]
               	udiv	x17, x1, x2
               	msub	x1, x17, x2, x1
               	cmp	x6, x9
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
               	mov	x1, #0x0                // =0
               	mov	x9, #0x7                // =7
               	mov	x3, #0x2493             // =9363
               	movk	x3, #0x9249, lsl #16
               	movk	x3, #0x4924, lsl #32
               	movk	x3, #0x2492, lsl #48
               	mov	x10, #0x5555555555555555 // =6148914691236517205
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	mov	x0, #0x7                // =7
               	stur	x0, [x29, #-0x30]
               	sxtw	x0, w1
               	ldr	x0, [x4, x0, lsl #3]
               	cmp	x0, x10
               	b.eq	<addr>
               	umulh	x2, x0, x3
               	sub	x5, x0, x2
               	lsr	x6, x5, #1
               	add	x7, x6, x2
               	lsr	x8, x7, #2
               	mul	x2, x8, x9
               	sub	x5, x0, x2
               	ldur	x2, [x29, #-0x30]
               	udiv	x6, x0, x2
               	ldur	x2, [x29, #-0x30]
               	udiv	x17, x0, x2
               	msub	x0, x17, x2, x0
               	cmp	x8, x6
               	b.ne	<addr>
               	cmp	x5, x0
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
               	mov	x3, #-0x7fffffffffffffff // =-9223372036854775807
               	mov	x6, #0x5555555555555555 // =6148914691236517205
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	mov	x1, #-0x7fffffffffffffff // =-9223372036854775807
               	stur	x1, [x29, #-0x28]
               	sxtw	x1, w0
               	ldr	x1, [x4, x1, lsl #3]
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
               	mov	x1, #0x0                // =0
               	mov	x3, #0xd70b             // =55051
               	movk	x3, #0x70a3, lsl #16
               	movk	x3, #0xa3d, lsl #32
               	movk	x3, #0xa3d7, lsl #48
               	mov	x9, #0x64               // =100
               	mov	x10, #0x5555555555555555 // =6148914691236517205
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	mov	x0, #0x64               // =100
               	stur	x0, [x29, #-0x20]
               	sxtw	x0, w1
               	ldr	x0, [x4, x0, lsl #3]
               	cmp	x0, x10
               	b.eq	<addr>
               	smulh	x5, x0, x3
               	add	x6, x5, x0
               	asr	x2, x6, #6
               	lsr	x7, x2, #63
               	add	x8, x2, x7
               	mul	x2, x8, x9
               	sub	x5, x0, x2
               	ldur	x2, [x29, #-0x20]
               	sdiv	x6, x0, x2
               	ldur	x2, [x29, #-0x20]
               	sdiv	x17, x0, x2
               	msub	x0, x17, x2, x0
               	cmp	x8, x6
               	b.ne	<addr>
               	cmp	x5, x0
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x3, #0x0                // =0
               	mov	x9, #-0x3               // =-3
               	mov	x10, #0x5555555555555555 // =6148914691236517205
               	mov	x4, #0x5556             // =21846
               	movk	x4, #0x5555, lsl #16
               	movk	x4, #0x5555, lsl #32
               	movk	x4, #0x5555, lsl #48
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, x3
               	b	<addr>
               	mov	x0, #-0x3               // =-3
               	stur	x0, [x29, #-0x18]
               	sxtw	x0, w1
               	ldr	x0, [x5, x0, lsl #3]
               	cmp	x0, x10
               	b.eq	<addr>
               	smulh	x2, x0, x4
               	lsr	x6, x2, #63
               	add	x7, x2, x6
               	sub	x8, x3, x7
               	mul	x2, x8, x9
               	sub	x6, x0, x2
               	ldur	x2, [x29, #-0x18]
               	sdiv	x7, x0, x2
               	ldur	x2, [x29, #-0x18]
               	sdiv	x17, x0, x2
               	msub	x0, x17, x2, x0
               	cmp	x8, x7
               	b.ne	<addr>
               	cmp	x6, x0
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
               	mov	x7, #0x64               // =100
               	mov	x3, #0xf5c3             // =62915
               	movk	x3, #0x5c28, lsl #16
               	movk	x3, #0xc28f, lsl #32
               	movk	x3, #0x28f5, lsl #48
               	mov	x8, #0x5555555555555555 // =6148914691236517205
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	mov	x1, #0x64               // =100
               	stur	x1, [x29, #-0x10]
               	sxtw	x1, w0
               	ldr	x1, [x4, x1, lsl #3]
               	cmp	x1, x8
               	b.eq	<addr>
               	lsr	x2, x1, #2
               	umulh	x5, x2, x3
               	lsr	x6, x5, #2
               	mul	x2, x6, x7
               	sub	x5, x1, x2
               	ldur	x2, [x29, #-0x10]
               	udiv	x9, x1, x2
               	ldur	x2, [x29, #-0x10]
               	udiv	x17, x1, x2
               	msub	x1, x17, x2, x1
               	cmp	x6, x9
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
               	mov	x1, #0x0                // =0
               	mov	x9, #0x7                // =7
               	mov	x3, #0x2493             // =9363
               	movk	x3, #0x9249, lsl #16
               	movk	x3, #0x4924, lsl #32
               	movk	x3, #0x2492, lsl #48
               	mov	x10, #0x5555555555555555 // =6148914691236517205
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	mov	x0, #0x7                // =7
               	stur	x0, [x29, #-0x8]
               	sxtw	x0, w1
               	ldr	x0, [x4, x0, lsl #3]
               	cmp	x0, x10
               	b.eq	<addr>
               	umulh	x2, x0, x3
               	sub	x5, x0, x2
               	lsr	x6, x5, #1
               	add	x7, x6, x2
               	lsr	x8, x7, #2
               	mul	x2, x8, x9
               	sub	x5, x0, x2
               	ldur	x2, [x29, #-0x8]
               	udiv	x6, x0, x2
               	ldur	x2, [x29, #-0x8]
               	udiv	x17, x0, x2
               	msub	x0, x17, x2, x0
               	cmp	x8, x6
               	b.ne	<addr>
               	cmp	x5, x0
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
               	mov	x1, #0x0                // =0
               	mov	x7, #0x3                // =3
               	mov	x8, #0x5556             // =21846
               	movk	x8, #0x5555, lsl #16
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	mov	x0, #0x3                // =3
               	stur	w0, [x29, #-0xa8]
               	sxtw	x0, w1
               	ldr	x0, [x3, x0, lsl #3]
               	sxtb	x0, w0
               	mul	x4, x0, x8
               	asr	x2, x4, #32
               	lsr	x5, x2, #63
               	add	x6, x2, x5
               	sxtb	x9, w6
               	mul	x2, x6, x7
               	sub	x4, x0, x2
               	sxtb	x5, w4
               	ldursw	x2, [x29, #-0xa8]
               	sdiv	x2, x0, x2
               	sxtb	x6, w2
               	ldursw	x2, [x29, #-0xa8]
               	sdiv	x17, x0, x2
               	msub	x0, x17, x2, x0
               	sxtb	x2, w0
               	cmp	w9, w6
               	b.ne	<addr>
               	cmp	w5, w2
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x3, #0x0                // =0
               	mov	x9, #-0x5               // =-5
               	mov	x10, #0x6667            // =26215
               	movk	x10, #0x6666, lsl #16
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x1, x3
               	b	<addr>
               	mov	x0, #-0x5               // =-5
               	stur	w0, [x29, #-0xa0]
               	sxtw	x0, w1
               	ldr	x0, [x4, x0, lsl #3]
               	sxtb	x0, w0
               	mul	x5, x0, x10
               	asr	x2, x5, #33
               	lsr	x6, x2, #63
               	add	x7, x2, x6
               	sub	x8, x3, x7
               	sxtb	x11, w8
               	mul	x2, x8, x9
               	sub	x5, x0, x2
               	sxtb	x6, w5
               	ldursw	x2, [x29, #-0xa0]
               	sdiv	x2, x0, x2
               	sxtb	x7, w2
               	ldursw	x2, [x29, #-0xa0]
               	sdiv	x17, x0, x2
               	msub	x0, x17, x2, x0
               	sxtb	x2, w0
               	cmp	w11, w7
               	b.ne	<addr>
               	cmp	w6, w2
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x3, #0x0                // =0
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x1, x3
               	b	<addr>
               	mov	x0, #-0x1               // =-1
               	stur	w0, [x29, #-0x98]
               	sxtw	x0, w1
               	ldr	x0, [x4, x0, lsl #3]
               	sxtb	x0, w0
               	sub	x2, x3, x0
               	sxtb	x5, w2
               	ldursw	x2, [x29, #-0x98]
               	sdiv	x2, x0, x2
               	sxtb	x6, w2
               	ldursw	x2, [x29, #-0x98]
               	sdiv	x17, x0, x2
               	msub	x0, x17, x2, x0
               	sxtb	x2, w0
               	cmp	w5, w6
               	b.ne	<addr>
               	cbnz	x2, <addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	mov	x8, #0x3                // =3
               	mov	x9, #0x5556             // =21846
               	movk	x9, #0x5555, lsl #16
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	mov	x0, #0x3                // =3
               	stur	w0, [x29, #-0x90]
               	sxtw	x0, w1
               	ldr	x0, [x4, x0, lsl #3]
               	and	x0, x0, #0xff
               	mul	x5, x0, x9
               	asr	x2, x5, #32
               	lsr	x6, x2, #63
               	add	x7, x2, x6
               	and	x10, x7, #0xff
               	mul	x2, x7, x8
               	sub	x5, x0, x2
               	ldursw	x2, [x29, #-0x90]
               	sdiv	x2, x0, x2
               	and	x6, x2, #0xff
               	ldursw	x2, [x29, #-0x90]
               	sdiv	x17, x0, x2
               	msub	x0, x17, x2, x0
               	cmp	w10, w6
               	b.ne	<addr>
               	and	x2, x5, #0xff
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
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	mov	x1, #0x10               // =16
               	stur	w1, [x29, #-0x88]
               	sxtw	x1, w0
               	ldr	x1, [x4, x1, lsl #3]
               	and	x1, x1, #0xff
               	add	x3, x1, #0x0
               	asr	x5, x3, #4
               	and	x3, x3, #0xf
               	sub	x3, x3, #0x0
               	ldursw	x6, [x29, #-0x88]
               	sdiv	x6, x1, x6
               	and	x6, x6, #0xff
               	ldursw	x2, [x29, #-0x88]
               	sdiv	x17, x1, x2
               	msub	x1, x17, x2, x1
               	cmp	w5, w6
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
               	mov	x3, #0x0                // =0
               	mov	x10, #-0x7              // =-7
               	mov	x11, #0x2493            // =9363
               	movk	x11, #0x9249, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, x3
               	b	<addr>
               	mov	x0, #-0x7               // =-7
               	stur	w0, [x29, #-0x80]
               	sxtw	x0, w1
               	ldr	x0, [x5, x0, lsl #3]
               	and	x0, x0, #0xff
               	mul	x6, x0, x11
               	asr	x2, x6, #34
               	lsr	x7, x2, #63
               	add	x8, x2, x7
               	sub	x9, x3, x8
               	and	x12, x9, #0xff
               	mul	x2, x9, x10
               	sub	x6, x0, x2
               	ldursw	x2, [x29, #-0x80]
               	sdiv	x2, x0, x2
               	and	x7, x2, #0xff
               	ldursw	x2, [x29, #-0x80]
               	sdiv	x17, x0, x2
               	msub	x0, x17, x2, x0
               	cmp	w12, w7
               	b.ne	<addr>
               	and	x2, x6, #0xff
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
               	mov	x1, #0x0                // =0
               	mov	x7, #0xa                // =10
               	mov	x8, #0x6667             // =26215
               	movk	x8, #0x6666, lsl #16
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	mov	x0, #0xa                // =10
               	stur	w0, [x29, #-0x78]
               	sxtw	x0, w1
               	ldr	x0, [x3, x0, lsl #3]
               	sxth	x0, w0
               	mul	x4, x0, x8
               	asr	x2, x4, #34
               	lsr	x5, x2, #63
               	add	x6, x2, x5
               	sxth	x9, w6
               	mul	x2, x6, x7
               	sub	x4, x0, x2
               	sxth	x5, w4
               	ldursw	x2, [x29, #-0x78]
               	sdiv	x2, x0, x2
               	sxth	x6, w2
               	ldursw	x2, [x29, #-0x78]
               	sdiv	x17, x0, x2
               	msub	x0, x17, x2, x0
               	sxth	x2, w0
               	cmp	w9, w6
               	b.ne	<addr>
               	cmp	w5, w2
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x3, #0x0                // =0
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x1, x3
               	b	<addr>
               	mov	x0, #-0x1               // =-1
               	stur	w0, [x29, #-0x70]
               	sxtw	x0, w1
               	ldr	x0, [x4, x0, lsl #3]
               	sxth	x0, w0
               	sub	x2, x3, x0
               	sxth	x5, w2
               	ldursw	x2, [x29, #-0x70]
               	sdiv	x2, x0, x2
               	sxth	x6, w2
               	ldursw	x2, [x29, #-0x70]
               	sdiv	x17, x0, x2
               	msub	x0, x17, x2, x0
               	sxth	x2, w0
               	cmp	w5, w6
               	b.ne	<addr>
               	cbnz	x2, <addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	mov	x8, #0x3e8              // =1000
               	mov	x9, #0x4dd3             // =19923
               	movk	x9, #0x1062, lsl #16
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	mov	x0, #0x3e8              // =1000
               	stur	w0, [x29, #-0x68]
               	sxtw	x0, w1
               	ldr	x0, [x4, x0, lsl #3]
               	and	x0, x0, #0xffff
               	mul	x5, x0, x9
               	asr	x2, x5, #38
               	lsr	x6, x2, #63
               	add	x7, x2, x6
               	and	x10, x7, #0xffff
               	mul	x2, x7, x8
               	sub	x5, x0, x2
               	ldursw	x2, [x29, #-0x68]
               	sdiv	x2, x0, x2
               	and	x6, x2, #0xffff
               	ldursw	x2, [x29, #-0x68]
               	sdiv	x17, x0, x2
               	msub	x0, x17, x2, x0
               	cmp	w10, w6
               	b.ne	<addr>
               	and	x2, x5, #0xffff
               	and	x0, x0, #0xffff
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
               	mov	x1, #0x0                // =0
               	mov	x10, #0x7               // =7
               	mov	x11, #0x4925            // =18725
               	movk	x11, #0x2492, lsl #16
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	mov	x0, #0x7                // =7
               	stur	w0, [x29, #-0x60]
               	sxtw	x0, w1
               	ldr	x0, [x4, x0, lsl #3]
               	and	x0, x0, #0xffff
               	mul	x5, x0, x11
               	lsr	x2, x5, #32
               	sub	x6, x0, x2
               	lsr	x7, x6, #1
               	add	x8, x7, x2
               	lsr	x9, x8, #2
               	and	x12, x9, #0xffff
               	mul	x2, x9, x10
               	sub	x5, x0, x2
               	ldur	w2, [x29, #-0x60]
               	udiv	x2, x0, x2
               	and	x6, x2, #0xffff
               	ldur	w2, [x29, #-0x60]
               	udiv	x17, x0, x2
               	msub	x0, x17, x2, x0
               	cmp	w12, w6
               	b.ne	<addr>
               	and	x2, x5, #0xffff
               	and	x0, x0, #0xffff
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
               	mov	x8, #0x3                // =3
               	mov	x9, #0xaaab             // =43691
               	movk	x9, #0xaaaa, lsl #16
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	b	<addr>
               	mov	x1, #0x3                // =3
               	stur	w1, [x29, #-0x58]
               	sxtw	x1, w0
               	ldr	x1, [x6, x1, lsl #3]
               	mov	w2, w1
               	mul	x5, x2, x9
               	lsr	x4, x5, #33
               	mul	x5, x4, x8
               	sub	x5, x2, x5
               	ldur	w7, [x29, #-0x58]
               	udiv	x7, x2, x7
               	ldur	w3, [x29, #-0x58]
               	udiv	x17, x2, x3
               	msub	x1, x17, x3, x2
               	cmp	w4, w7
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
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	mov	x1, #0x80000000         // =2147483648
               	stur	w1, [x29, #-0x50]
               	sxtw	x1, w0
               	ldr	x1, [x5, x1, lsl #3]
               	mov	w2, w1
               	lsr	x6, x2, #31
               	and	x4, x1, #0x7fffffff
               	ldur	w7, [x29, #-0x50]
               	udiv	x7, x2, x7
               	ldur	w3, [x29, #-0x50]
               	udiv	x17, x2, x3
               	msub	x1, x17, x3, x2
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
               	mov	x1, #0x0                // =0
               	mov	x8, #0x3                // =3
               	mov	x5, #0x5556             // =21846
               	movk	x5, #0x5555, lsl #16
               	movk	x5, #0x5555, lsl #32
               	movk	x5, #0x5555, lsl #48
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	b	<addr>
               	mov	x0, #0x3                // =3
               	stur	x0, [x29, #-0x48]
               	sxtw	x0, w1
               	ldr	x0, [x6, x0, lsl #3]
               	sxtw	x0, w0
               	smulh	x2, x0, x5
               	lsr	x4, x2, #63
               	add	x3, x2, x4
               	mul	x2, x3, x8
               	sub	x2, x0, x2
               	ldur	x4, [x29, #-0x48]
               	sdiv	x7, x0, x4
               	ldur	x4, [x29, #-0x48]
               	sdiv	x17, x0, x4
               	msub	x0, x17, x4, x0
               	cmp	w3, w7
               	b.ne	<addr>
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
               	mov	x1, #0x0                // =0
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	mov	x0, #0x100000000        // =4294967296
               	stur	x0, [x29, #-0x40]
               	sxtw	x0, w1
               	ldr	x0, [x4, x0, lsl #3]
               	sxtw	x0, w0
               	asr	x3, x0, #63
               	lsr	x2, x3, #32
               	add	x5, x0, x2
               	asr	x6, x5, #32
               	mov	w3, w5
               	sub	x2, x3, x2
               	ldur	x3, [x29, #-0x40]
               	sdiv	x5, x0, x3
               	ldur	x3, [x29, #-0x40]
               	sdiv	x17, x0, x3
               	msub	x0, x17, x3, x0
               	cmp	w6, w5
               	b.ne	<addr>
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
               	mov	x1, #0x0                // =0
               	mov	x9, #0x7                // =7
               	mov	x5, #0x2493             // =9363
               	movk	x5, #0x9249, lsl #16
               	movk	x5, #0x4924, lsl #32
               	movk	x5, #0x2492, lsl #48
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	b	<addr>
               	mov	x0, #0x7                // =7
               	stur	x0, [x29, #-0x38]
               	sxtw	x0, w1
               	ldr	x0, [x6, x0, lsl #3]
               	sxtw	x0, w0
               	umulh	x2, x0, x5
               	sub	x4, x0, x2
               	lsr	x7, x4, #1
               	add	x8, x7, x2
               	lsr	x3, x8, #2
               	mul	x2, x3, x9
               	sub	x2, x0, x2
               	ldur	x4, [x29, #-0x38]
               	udiv	x7, x0, x4
               	ldur	x4, [x29, #-0x38]
               	udiv	x17, x0, x4
               	msub	x0, x17, x4, x0
               	cmp	w3, w7
               	b.ne	<addr>
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
               	mov	x1, #0x0                // =0
               	mov	x9, #0x7                // =7
               	mov	x4, #0x4925             // =18725
               	movk	x4, #0x2492, lsl #16
               	movk	x4, #0x9249, lsl #32
               	movk	x4, #0x4924, lsl #48
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	mov	x0, #0x7                // =7
               	stur	x0, [x29, #-0x30]
               	sxtw	x0, w1
               	ldr	x0, [x5, x0, lsl #3]
               	mov	w0, w0
               	smulh	x6, x0, x4
               	asr	x2, x6, #1
               	lsr	x7, x2, #63
               	add	x8, x2, x7
               	mov	w10, w8
               	mul	x2, x8, x9
               	sub	x6, x0, x2
               	ldur	x2, [x29, #-0x30]
               	sdiv	x2, x0, x2
               	mov	w7, w2
               	ldur	x2, [x29, #-0x30]
               	sdiv	x17, x0, x2
               	msub	x0, x17, x2, x0
               	cmp	w10, w7
               	b.ne	<addr>
               	mov	w2, w6
               	mov	w0, w0
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
               	mov	x3, #0x0                // =0
               	mov	x11, #-0x7              // =-7
               	mov	x5, #0x4925             // =18725
               	movk	x5, #0x2492, lsl #16
               	movk	x5, #0x9249, lsl #32
               	movk	x5, #0x4924, lsl #48
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x1, x3
               	b	<addr>
               	mov	x0, #-0x7               // =-7
               	stur	x0, [x29, #-0x28]
               	sxtw	x0, w1
               	ldr	x0, [x6, x0, lsl #3]
               	mov	w0, w0
               	smulh	x7, x0, x5
               	asr	x2, x7, #1
               	lsr	x8, x2, #63
               	add	x9, x2, x8
               	sub	x10, x3, x9
               	mov	w12, w10
               	mul	x2, x10, x11
               	sub	x7, x0, x2
               	ldur	x2, [x29, #-0x28]
               	sdiv	x2, x0, x2
               	mov	w8, w2
               	ldur	x2, [x29, #-0x28]
               	sdiv	x17, x0, x2
               	msub	x0, x17, x2, x0
               	cmp	w12, w8
               	b.ne	<addr>
               	mov	w2, w7
               	mov	w0, w0
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
               	mov	x1, #0x0                // =0
               	mov	x8, #0xa                // =10
               	mov	x3, #0x6667             // =26215
               	movk	x3, #0x6666, lsl #16
               	movk	x3, #0x6666, lsl #32
               	movk	x3, #0x6666, lsl #48
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	mov	x0, #0xa                // =10
               	stur	x0, [x29, #-0x20]
               	sxtw	x0, w1
               	ldr	x0, [x4, x0, lsl #3]
               	mov	w0, w0
               	lsr	x5, x0, #1
               	umulh	x6, x5, x3
               	lsr	x7, x6, #1
               	mov	w9, w7
               	mul	x5, x7, x8
               	sub	x5, x0, x5
               	ldur	x6, [x29, #-0x20]
               	udiv	x6, x0, x6
               	mov	w6, w6
               	ldur	x2, [x29, #-0x20]
               	udiv	x17, x0, x2
               	msub	x0, x17, x2, x0
               	cmp	w9, w6
               	b.ne	<addr>
               	mov	w2, w5
               	mov	w0, w0
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
               	mov	x1, #0x0                // =0
               	mov	x3, #0xe38f             // =58255
               	movk	x3, #0x8e38, lsl #16
               	movk	x3, #0x38e3, lsl #32
               	movk	x3, #0xe38e, lsl #48
               	mov	x6, #0x9                // =9
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	mov	x0, #0x9                // =9
               	stur	x0, [x29, #-0x18]
               	sxtw	x0, w1
               	ldr	x0, [x4, x0, lsl #3]
               	sxth	x0, w0
               	umulh	x2, x0, x3
               	lsr	x5, x2, #3
               	sxth	x7, w5
               	mul	x2, x5, x6
               	sub	x5, x0, x2
               	sxth	x8, w5
               	ldur	x2, [x29, #-0x18]
               	udiv	x2, x0, x2
               	sxth	x9, w2
               	ldur	x2, [x29, #-0x18]
               	udiv	x17, x0, x2
               	msub	x0, x17, x2, x0
               	sxth	x2, w0
               	cmp	w7, w9
               	b.ne	<addr>
               	cmp	w8, w2
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x3, #0x0                // =0
               	mov	x10, #-0xa              // =-10
               	mov	x11, #0x5555555555555555 // =6148914691236517205
               	mov	x4, #0x6667             // =26215
               	movk	x4, #0x6666, lsl #16
               	movk	x4, #0x6666, lsl #32
               	movk	x4, #0x6666, lsl #48
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, x3
               	b	<addr>
               	mov	x0, #-0xa               // =-10
               	stur	w0, [x29, #-0x10]
               	sxtw	x0, w1
               	ldr	x0, [x5, x0, lsl #3]
               	cmp	x0, x11
               	b.eq	<addr>
               	smulh	x6, x0, x4
               	asr	x2, x6, #2
               	lsr	x7, x2, #63
               	add	x8, x2, x7
               	sub	x9, x3, x8
               	mul	x2, x9, x10
               	sub	x6, x0, x2
               	ldursw	x2, [x29, #-0x10]
               	sdiv	x7, x0, x2
               	ldursw	x2, [x29, #-0x10]
               	sdiv	x17, x0, x2
               	msub	x0, x17, x2, x0
               	cmp	x9, x7
               	b.ne	<addr>
               	cmp	x6, x0
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
               	mov	x7, #0xa                // =10
               	mov	x8, #0x5555555555555555 // =6148914691236517205
               	mov	x3, #0x6667             // =26215
               	movk	x3, #0x6666, lsl #16
               	movk	x3, #0x6666, lsl #32
               	movk	x3, #0x6666, lsl #48
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	mov	x1, #0xa                // =10
               	stur	w1, [x29, #-0x8]
               	sxtw	x1, w0
               	ldr	x1, [x4, x1, lsl #3]
               	cmp	x1, x8
               	b.eq	<addr>
               	lsr	x2, x1, #1
               	umulh	x5, x2, x3
               	lsr	x6, x5, #1
               	mul	x2, x6, x7
               	sub	x5, x1, x2
               	ldursw	x2, [x29, #-0x8]
               	udiv	x9, x1, x2
               	ldursw	x2, [x29, #-0x8]
               	udiv	x17, x1, x2
               	msub	x1, x17, x2, x1
               	cmp	x6, x9
               	b.ne	<addr>
               	cmp	x5, x1
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
               	adrp	x12, <page>
               	add	x12, x12, <lo12>
               	ldrsw	x0, [x12]
               	add	x0, x0, #0x1
               	str	w0, [x12]
               	mov	x0, #0x0                // =0
               	mov	x5, #0xa                // =10
               	mov	x4, #0x6667             // =26215
               	movk	x4, #0x6666, lsl #16
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	sxtw	x2, w0
               	ldr	x3, [x1, x2, lsl #3]
               	stur	w3, [x29, #-0x28]
               	ldr	x3, [x1, x2, lsl #3]
               	stur	w3, [x29, #-0x20]
               	mov	x3, #0xa                // =10
               	stur	w3, [x29, #-0x18]
               	ldursw	x3, [x29, #-0x28]
               	mul	x3, x3, x4
               	asr	x3, x3, #34
               	lsr	x6, x3, #63
               	add	x3, x3, x6
               	stur	w3, [x29, #-0x28]
               	ldursw	x3, [x29, #-0x20]
               	ldursw	x6, [x29, #-0x18]
               	sdiv	x3, x3, x6
               	stur	w3, [x29, #-0x20]
               	ldursw	x3, [x29, #-0x28]
               	ldursw	x6, [x29, #-0x20]
               	cmp	w3, w6
               	b.ne	<addr>
               	ldr	x3, [x1, x2, lsl #3]
               	stur	w3, [x29, #-0x28]
               	ldr	x2, [x1, x2, lsl #3]
               	stur	w2, [x29, #-0x20]
               	ldursw	x2, [x29, #-0x28]
               	mul	x3, x2, x4
               	asr	x3, x3, #34
               	lsr	x6, x3, #63
               	add	x3, x3, x6
               	mul	x3, x3, x5
               	sub	x2, x2, x3
               	stur	w2, [x29, #-0x28]
               	ldursw	x3, [x29, #-0x20]
               	ldursw	x2, [x29, #-0x18]
               	sdiv	x17, x3, x2
               	msub	x2, x17, x2, x3
               	stur	w2, [x29, #-0x20]
               	ldursw	x2, [x29, #-0x28]
               	ldursw	x3, [x29, #-0x20]
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x12]
               	add	x0, x0, #0x1
               	str	w0, [x12]
               	mov	x0, #0x0                // =0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	sub	x4, x29, #0x88
               	sxtw	x1, w0
               	ldr	x2, [x3, x1, lsl #3]
               	str	w2, [x4, x1, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	mov	x4, #0x0                // =0
               	mov	x9, #-0x9               // =-9
               	mov	x5, #0x8e39             // =36409
               	movk	x5, #0x38e3, lsl #16
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x2, x4
               	b	<addr>
               	mov	x0, #-0x9               // =-9
               	stur	w0, [x29, #-0x10]
               	sxtw	x0, w2
               	ldr	x1, [x6, x0, lsl #3]
               	sxtw	x1, w1
               	ldursw	x3, [x29, #-0x10]
               	sdiv	x3, x1, x3
               	sub	x1, x29, #0x88
               	ldrsw	x7, [x1, x0, lsl #2]
               	mul	x7, x7, x5
               	asr	x7, x7, #33
               	lsr	x8, x7, #63
               	add	x7, x7, x8
               	sub	x7, x4, x7
               	str	w7, [x1, x0, lsl #2]
               	ldrsw	x7, [x1, x0, lsl #2]
               	cmp	w7, w3
               	b.ne	<addr>
               	ldrsw	x7, [x1, x0, lsl #2]
               	cmp	w7, w3
               	b.ne	<addr>
               	sxtw	x7, w3
               	ldursw	x3, [x29, #-0x10]
               	sdiv	x17, x7, x3
               	msub	x3, x17, x3, x7
               	ldrsw	x7, [x1, x0, lsl #2]
               	mul	x8, x7, x5
               	asr	x8, x8, #33
               	lsr	x10, x8, #63
               	add	x8, x8, x10
               	sub	x8, x4, x8
               	mul	x8, x8, x9
               	sub	x7, x7, x8
               	str	w7, [x1, x0, lsl #2]
               	ldrsw	x0, [x1, x0, lsl #2]
               	cmp	w0, w3
               	b.ne	<addr>
               	add	x2, x2, #0x1
               	cmp	w2, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x12]
               	add	x0, x0, #0x1
               	str	w0, [x12]
               	mov	x1, #0x0                // =0
               	mov	x6, #0x3                // =3
               	mov	x5, #0x5556             // =21846
               	movk	x5, #0x5555, lsl #16
               	mov	x9, #0x5556             // =21846
               	movk	x9, #0x5555, lsl #16
               	movk	x9, #0x5555, lsl #32
               	movk	x9, #0x5555, lsl #48
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	b	<addr>
               	mov	x2, #0x3                // =3
               	stur	w2, [x29, #-0x8]
               	sub	x2, x29, #0x90
               	sub	x4, x29, #0x30
               	sxtw	x3, w1
               	ldr	x7, [x0, x3, lsl #3]
               	and	x7, x7, #0x7ff
               	ldr	w8, [x4]
               	and	x8, x8, #0xfffffffffffff800
               	orr	x8, x8, x7
               	str	w8, [x4]
               	lsl	x7, x7, #53
               	asr	x7, x7, #53
               	and	x7, x7, #0x7ff
               	ldr	w10, [x2]
               	and	x10, x10, #0xfffffffffffff800
               	orr	x10, x10, x7
               	str	w10, [x2]
               	ldr	x7, [x0, x3, lsl #3]
               	and	x7, x7, #0x1fff
               	mov	w8, w8
               	and	x8, x8, #0xffffffffff0007ff
               	lsl	x7, x7, #11
               	orr	x8, x8, x7
               	str	w8, [x4]
               	mov	w8, w10
               	and	x8, x8, #0xffffffffff0007ff
               	orr	x7, x8, x7
               	str	w7, [x2]
               	ldr	x7, [x0, x3, lsl #3]
               	and	x7, x7, #0xffffffffff
               	ldr	x8, [x4]
               	and	x8, x8, #0xffffff
               	lsl	x7, x7, #24
               	orr	x8, x8, x7
               	str	x8, [x4]
               	asr	x7, x7, #24
               	and	x7, x7, #0xffffffffff
               	ldr	x8, [x2]
               	and	x8, x8, #0xffffff
               	lsl	x7, x7, #24
               	orr	x8, x8, x7
               	str	x8, [x2]
               	ldr	w7, [x2]
               	and	x8, x7, #0x7ff
               	lsl	x8, x8, #53
               	asr	x8, x8, #53
               	mul	x8, x8, x5
               	asr	x8, x8, #32
               	lsr	x10, x8, #63
               	add	x8, x8, x10
               	and	x8, x8, #0x7ff
               	and	x7, x7, #0xfffffffffffff800
               	orr	x7, x7, x8
               	str	w7, [x2]
               	ldr	w8, [x4]
               	and	x10, x8, #0x7ff
               	lsl	x10, x10, #53
               	asr	x10, x10, #53
               	ldursw	x11, [x29, #-0x8]
               	sdiv	x10, x10, x11
               	and	x10, x10, #0x7ff
               	and	x8, x8, #0xfffffffffffff800
               	orr	x8, x8, x10
               	str	w8, [x4]
               	mov	w10, w7
               	asr	x11, x10, #11
               	and	x11, x11, #0x1fff
               	mul	x11, x11, x5
               	asr	x11, x11, #32
               	lsr	x13, x11, #63
               	add	x11, x11, x13
               	and	x11, x11, #0x1fff
               	and	x7, x10, #0xffffffffff0007ff
               	lsl	x10, x11, #11
               	orr	x7, x7, x10
               	str	w7, [x2]
               	mov	w7, w8
               	asr	x10, x7, #11
               	and	x10, x10, #0x1fff
               	ldursw	x11, [x29, #-0x8]
               	sdiv	x10, x10, x11
               	and	x10, x10, #0x1fff
               	and	x7, x7, #0xffffffffff0007ff
               	lsl	x8, x10, #11
               	orr	x7, x7, x8
               	str	w7, [x4]
               	ldr	x7, [x2]
               	asr	x8, x7, #24
               	and	x8, x8, #0xffffffffff
               	lsl	x8, x8, #24
               	asr	x8, x8, #24
               	smulh	x8, x8, x9
               	lsr	x10, x8, #63
               	add	x8, x8, x10
               	and	x8, x8, #0xffffffffff
               	and	x10, x7, #0xffffff
               	lsl	x7, x8, #24
               	orr	x8, x10, x7
               	str	x8, [x2]
               	sub	x2, x29, #0x30
               	ldr	x7, [x2]
               	asr	x7, x7, #24
               	and	x7, x7, #0xffffffffff
               	lsl	x7, x7, #24
               	asr	x7, x7, #24
               	ldursw	x10, [x29, #-0x8]
               	sdiv	x7, x7, x10
               	and	x7, x7, #0xffffffffff
               	ldr	x10, [x4]
               	and	x10, x10, #0xffffff
               	lsl	x7, x7, #24
               	orr	x10, x10, x7
               	str	x10, [x4]
               	sub	x4, x29, #0x90
               	ldr	w7, [x4]
               	and	x7, x7, #0x7ff
               	lsl	x7, x7, #53
               	asr	x7, x7, #53
               	ldr	w11, [x2]
               	and	x11, x11, #0x7ff
               	lsl	x11, x11, #53
               	asr	x11, x11, #53
               	cmp	x7, x11
               	b.ne	<addr>
               	ldr	w7, [x4]
               	asr	x7, x7, #11
               	and	x7, x7, #0x1fff
               	ldr	w11, [x2]
               	asr	x11, x11, #11
               	and	x11, x11, #0x1fff
               	cmp	w7, w11
               	cset	x7, ne
               	cbnz	x7, <addr>
               	asr	x7, x8, #24
               	and	x7, x7, #0xffffffffff
               	lsl	x7, x7, #24
               	asr	x7, x7, #24
               	asr	x8, x10, #24
               	and	x8, x8, #0xffffffffff
               	lsl	x8, x8, #24
               	asr	x8, x8, #24
               	cmp	x7, x8
               	cset	x7, ne
               	cbnz	x7, <addr>
               	ldr	x7, [x0, x3, lsl #3]
               	and	x7, x7, #0x7ff
               	ldr	w8, [x2]
               	and	x8, x8, #0xfffffffffffff800
               	orr	x8, x8, x7
               	str	w8, [x2]
               	lsl	x7, x7, #53
               	asr	x7, x7, #53
               	and	x7, x7, #0x7ff
               	ldr	w10, [x4]
               	and	x10, x10, #0xfffffffffffff800
               	orr	x10, x10, x7
               	str	w10, [x4]
               	ldr	x7, [x0, x3, lsl #3]
               	and	x7, x7, #0x1fff
               	mov	w8, w8
               	and	x8, x8, #0xffffffffff0007ff
               	lsl	x7, x7, #11
               	orr	x8, x8, x7
               	str	w8, [x2]
               	mov	w8, w10
               	and	x8, x8, #0xffffffffff0007ff
               	orr	x7, x8, x7
               	str	w7, [x4]
               	ldr	x3, [x0, x3, lsl #3]
               	and	x3, x3, #0xffffffffff
               	ldr	x7, [x2]
               	and	x7, x7, #0xffffff
               	lsl	x3, x3, #24
               	orr	x7, x7, x3
               	str	x7, [x2]
               	asr	x3, x3, #24
               	and	x3, x3, #0xffffffffff
               	ldr	x7, [x4]
               	and	x7, x7, #0xffffff
               	lsl	x3, x3, #24
               	orr	x7, x7, x3
               	str	x7, [x4]
               	ldr	w3, [x4]
               	and	x7, x3, #0x7ff
               	lsl	x7, x7, #53
               	asr	x7, x7, #53
               	mul	x8, x7, x5
               	asr	x8, x8, #32
               	lsr	x10, x8, #63
               	add	x8, x8, x10
               	mul	x8, x8, x6
               	sub	x7, x7, x8
               	and	x7, x7, #0x7ff
               	and	x3, x3, #0xfffffffffffff800
               	orr	x3, x3, x7
               	str	w3, [x4]
               	ldr	w8, [x2]
               	and	x7, x8, #0x7ff
               	lsl	x7, x7, #53
               	asr	x10, x7, #53
               	ldursw	x7, [x29, #-0x8]
               	sdiv	x17, x10, x7
               	msub	x7, x17, x7, x10
               	and	x10, x7, #0x7ff
               	and	x7, x8, #0xfffffffffffff800
               	orr	x7, x7, x10
               	str	w7, [x2]
               	mov	w2, w3
               	asr	x8, x2, #11
               	and	x8, x8, #0x1fff
               	mul	x10, x8, x5
               	asr	x10, x10, #32
               	lsr	x11, x10, #63
               	add	x10, x10, x11
               	mul	x10, x10, x6
               	sub	x8, x8, x10
               	and	x8, x8, #0x1fff
               	and	x2, x2, #0xffffffffff0007ff
               	lsl	x3, x8, #11
               	orr	x2, x2, x3
               	str	w2, [x4]
               	sub	x2, x29, #0x30
               	mov	w4, w7
               	asr	x3, x4, #11
               	and	x8, x3, #0x1fff
               	ldursw	x3, [x29, #-0x8]
               	sdiv	x17, x8, x3
               	msub	x3, x17, x3, x8
               	and	x3, x3, #0x1fff
               	and	x4, x4, #0xffffffffff0007ff
               	lsl	x3, x3, #11
               	orr	x3, x4, x3
               	str	w3, [x2]
               	sub	x3, x29, #0x90
               	ldr	x4, [x3]
               	asr	x7, x4, #24
               	and	x7, x7, #0xffffffffff
               	lsl	x7, x7, #24
               	asr	x7, x7, #24
               	smulh	x8, x7, x9
               	lsr	x10, x8, #63
               	add	x8, x8, x10
               	mul	x8, x8, x6
               	sub	x7, x7, x8
               	and	x7, x7, #0xffffffffff
               	and	x8, x4, #0xffffff
               	lsl	x4, x7, #24
               	orr	x7, x8, x4
               	str	x7, [x3]
               	ldr	x8, [x2]
               	asr	x4, x8, #24
               	and	x4, x4, #0xffffffffff
               	lsl	x4, x4, #24
               	asr	x10, x4, #24
               	ldursw	x4, [x29, #-0x8]
               	sdiv	x17, x10, x4
               	msub	x4, x17, x4, x10
               	and	x4, x4, #0xffffffffff
               	and	x8, x8, #0xffffff
               	lsl	x4, x4, #24
               	orr	x8, x8, x4
               	str	x8, [x2]
               	ldr	w4, [x3]
               	and	x4, x4, #0x7ff
               	lsl	x4, x4, #53
               	asr	x4, x4, #53
               	ldr	w10, [x2]
               	and	x10, x10, #0x7ff
               	lsl	x10, x10, #53
               	asr	x10, x10, #53
               	cmp	x4, x10
               	b.ne	<addr>
               	ldr	w3, [x3]
               	asr	x3, x3, #11
               	and	x3, x3, #0x1fff
               	ldr	w2, [x2]
               	asr	x2, x2, #11
               	and	x2, x2, #0x1fff
               	cmp	w3, w2
               	cset	x2, ne
               	cbnz	x2, <addr>
               	asr	x2, x7, #24
               	and	x2, x2, #0xffffffffff
               	lsl	x2, x2, #24
               	asr	x2, x2, #24
               	asr	x3, x8, #24
               	and	x3, x3, #0xffffffffff
               	lsl	x3, x3, #24
               	asr	x3, x3, #24
               	cmp	x2, x3
               	cset	x2, ne
               	cbnz	x2, <addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x18
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x12]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x12]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x12]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x12]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x12]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x12]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x12]
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
