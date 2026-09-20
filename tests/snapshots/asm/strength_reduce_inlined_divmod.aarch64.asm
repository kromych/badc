
strength_reduce_inlined_divmod.aarch64:	file format elf64-littleaarch64

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
               	str	xzr, [x0]
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
               	mov	x1, #0x80000000         // =2147483648
               	str	x1, [x0, #0x50]
               	mov	x1, #0x7f               // =127
               	str	x1, [x0, #0x58]
               	mov	x1, #-0x80              // =-128
               	str	x1, [x0, #0x60]
               	mov	x1, #0xff               // =255
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

<ints>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xb0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	mov	x4, #0x6667             // =26215
               	movk	x4, #0x6666, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x2, #0xa                // =10
               	stur	w2, [x29, #-0xa8]
               	ldr	x1, [x5, x0, lsl #3]
               	sxtw	x1, w1
               	mul	x3, x1, x4
               	asr	x3, x3, #34
               	lsr	x6, x3, #63
               	add	x3, x3, x6
               	ldursw	x6, [x29, #-0xa8]
               	sdiv	x6, x1, x6
               	cmp	x3, x6
               	b.ne	<addr>
               	msub	x2, x3, x2, x1
               	sxtw	x2, w2
               	ldursw	x3, [x29, #-0xa8]
               	sdiv	x17, x1, x3
               	msub	x1, x17, x3, x1
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
               	mov	x0, #0x0                // =0
               	mov	x4, #0x2493             // =9363
               	movk	x4, #0x9249, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x2, #0x7                // =7
               	stur	w2, [x29, #-0xa0]
               	ldr	x1, [x5, x0, lsl #3]
               	sxtw	x1, w1
               	mul	x3, x1, x4
               	asr	x3, x3, #34
               	lsr	x6, x3, #63
               	add	x3, x3, x6
               	ldursw	x6, [x29, #-0xa0]
               	sdiv	x6, x1, x6
               	cmp	x3, x6
               	b.ne	<addr>
               	msub	x2, x3, x2, x1
               	sxtw	x2, w2
               	ldursw	x3, [x29, #-0xa0]
               	sdiv	x17, x1, x3
               	msub	x1, x17, x3, x1
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
               	mov	x5, #0x2493             // =9363
               	movk	x5, #0x9249, lsl #16
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x2
               	mov	x3, #-0x7               // =-7
               	stur	w3, [x29, #-0x98]
               	ldr	x1, [x6, x0, lsl #3]
               	sxtw	x1, w1
               	mul	x4, x1, x5
               	asr	x4, x4, #34
               	lsr	x7, x4, #63
               	add	x4, x4, x7
               	sub	x4, x2, x4
               	ldursw	x7, [x29, #-0x98]
               	sdiv	x7, x1, x7
               	cmp	x4, x7
               	b.ne	<addr>
               	msub	x3, x4, x3, x1
               	sxtw	x3, w3
               	ldursw	x4, [x29, #-0x98]
               	sdiv	x17, x1, x4
               	msub	x1, x17, x4, x1
               	cmp	x3, x1
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
               	stur	w1, [x29, #-0x90]
               	ldr	x1, [x2, x0, lsl #3]
               	sxtw	x1, w1
               	ldursw	x3, [x29, #-0x90]
               	sdiv	x3, x1, x3
               	cmp	x1, x3
               	b.ne	<addr>
               	sub	x3, x1, x1
               	sxtw	x3, w3
               	ldursw	x4, [x29, #-0x90]
               	sdiv	x17, x1, x4
               	msub	x1, x17, x4, x1
               	cmp	x3, x1
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
               	mov	x4, #-0x80000000        // =-2147483648
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, x2
               	mov	x0, #-0x1               // =-1
               	stur	w0, [x29, #-0x88]
               	ldr	x0, [x5, x1, lsl #3]
               	sxtw	x0, w0
               	cmp	w0, w4
               	b.eq	<addr>
               	sub	x3, x2, x0
               	ldursw	x6, [x29, #-0x88]
               	sdiv	x6, x0, x6
               	cmp	w3, w6
               	b.ne	<addr>
               	add	x3, x0, x3
               	sxtw	x3, w3
               	ldursw	x6, [x29, #-0x88]
               	sdiv	x17, x0, x6
               	msub	x0, x17, x6, x0
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
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x1, #0x2                // =2
               	stur	w1, [x29, #-0x80]
               	ldr	x1, [x3, x0, lsl #3]
               	sxtw	x1, w1
               	lsr	x2, x1, #63
               	add	x2, x1, x2
               	asr	x2, x2, #1
               	ldursw	x4, [x29, #-0x80]
               	sdiv	x4, x1, x4
               	cmp	x2, x4
               	b.ne	<addr>
               	lsl	x2, x2, #1
               	sub	x2, x1, x2
               	sxtw	x2, w2
               	ldursw	x4, [x29, #-0x80]
               	sdiv	x17, x1, x4
               	msub	x1, x17, x4, x1
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
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, x2
               	mov	x3, #-0x2               // =-2
               	stur	w3, [x29, #-0x78]
               	ldr	x0, [x5, x1, lsl #3]
               	sxtw	x0, w0
               	lsr	x4, x0, #63
               	add	x4, x0, x4
               	asr	x4, x4, #1
               	sub	x4, x2, x4
               	ldursw	x6, [x29, #-0x78]
               	sdiv	x6, x0, x6
               	cmp	x4, x6
               	b.ne	<addr>
               	msub	x3, x4, x3, x0
               	sxtw	x3, w3
               	ldursw	x4, [x29, #-0x78]
               	sdiv	x17, x0, x4
               	msub	x0, x17, x4, x0
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
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x1, #0x400              // =1024
               	stur	w1, [x29, #-0x70]
               	ldr	x1, [x3, x0, lsl #3]
               	sxtw	x1, w1
               	lsr	x2, x1, #54
               	add	x2, x1, x2
               	asr	x2, x2, #10
               	ldursw	x4, [x29, #-0x70]
               	sdiv	x4, x1, x4
               	cmp	x2, x4
               	b.ne	<addr>
               	lsl	x2, x2, #10
               	sub	x2, x1, x2
               	sxtw	x2, w2
               	ldursw	x4, [x29, #-0x70]
               	sdiv	x17, x1, x4
               	msub	x1, x17, x4, x1
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
               	mov	x0, #0x0                // =0
               	mov	x4, #0x1                // =1
               	movk	x4, #0x4000, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x2, #0x7fffffff         // =2147483647
               	stur	w2, [x29, #-0x68]
               	ldr	x1, [x5, x0, lsl #3]
               	sxtw	x1, w1
               	mul	x3, x1, x4
               	asr	x3, x3, #61
               	lsr	x6, x3, #63
               	add	x3, x3, x6
               	ldursw	x6, [x29, #-0x68]
               	sdiv	x6, x1, x6
               	cmp	x3, x6
               	b.ne	<addr>
               	msub	x2, x3, x2, x1
               	sxtw	x2, w2
               	ldursw	x3, [x29, #-0x68]
               	sdiv	x17, x1, x3
               	msub	x1, x17, x3, x1
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
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, x2
               	mov	x3, #-0x80000000        // =-2147483648
               	stur	w3, [x29, #-0x60]
               	ldr	x0, [x5, x1, lsl #3]
               	sxtw	x0, w0
               	lsr	x4, x0, #33
               	add	x4, x0, x4
               	asr	x4, x4, #31
               	sub	x4, x2, x4
               	ldursw	x6, [x29, #-0x60]
               	sdiv	x6, x0, x6
               	cmp	x4, x6
               	b.ne	<addr>
               	msub	x3, x4, x3, x0
               	sxtw	x3, w3
               	ldursw	x4, [x29, #-0x60]
               	sdiv	x17, x0, x4
               	msub	x0, x17, x4, x0
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
               	mov	x2, #0x0                // =0
               	mov	x5, #0x1                // =1
               	movk	x5, #0x4000, lsl #16
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x2
               	mov	x3, #-0x7fffffff        // =-2147483647
               	stur	w3, [x29, #-0x58]
               	ldr	x1, [x6, x0, lsl #3]
               	sxtw	x1, w1
               	mul	x4, x1, x5
               	asr	x4, x4, #61
               	lsr	x7, x4, #63
               	add	x4, x4, x7
               	sub	x4, x2, x4
               	ldursw	x7, [x29, #-0x58]
               	sdiv	x7, x1, x7
               	cmp	x4, x7
               	b.ne	<addr>
               	msub	x3, x4, x3, x1
               	sxtw	x3, w3
               	ldursw	x4, [x29, #-0x58]
               	sdiv	x17, x1, x4
               	msub	x1, x17, x4, x1
               	cmp	x3, x1
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
               	mov	x4, #0x6667             // =26215
               	movk	x4, #0x6666, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x2, #0xa                // =10
               	stur	w2, [x29, #-0x50]
               	ldr	x1, [x5, x0, lsl #3]
               	mov	w1, w1
               	lsr	x3, x1, #1
               	mul	x3, x3, x4
               	lsr	x3, x3, #33
               	ldur	w6, [x29, #-0x50]
               	udiv	x6, x1, x6
               	cmp	w3, w6
               	b.ne	<addr>
               	msub	x2, x3, x2, x1
               	mov	w2, w2
               	ldur	w3, [x29, #-0x50]
               	udiv	x17, x1, x3
               	msub	x1, x17, x3, x1
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
               	mov	x0, #0x0                // =0
               	mov	x4, #0x4925             // =18725
               	movk	x4, #0x2492, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x2, #0x7                // =7
               	stur	w2, [x29, #-0x48]
               	ldr	x1, [x5, x0, lsl #3]
               	mov	w1, w1
               	mul	x3, x1, x4
               	lsr	x3, x3, #32
               	sub	x6, x1, x3
               	lsr	x6, x6, #1
               	add	x3, x6, x3
               	lsr	x3, x3, #2
               	ldur	w6, [x29, #-0x48]
               	udiv	x6, x1, x6
               	cmp	w3, w6
               	b.ne	<addr>
               	msub	x2, x3, x2, x1
               	mov	w2, w2
               	ldur	w3, [x29, #-0x48]
               	udiv	x17, x1, x3
               	msub	x1, x17, x3, x1
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
               	mov	x0, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x1, #0x1                // =1
               	stur	w1, [x29, #-0x40]
               	ldr	x1, [x2, x0, lsl #3]
               	mov	w1, w1
               	ldur	w3, [x29, #-0x40]
               	udiv	x3, x1, x3
               	cmp	w1, w3
               	b.ne	<addr>
               	sub	x3, x1, x1
               	mov	w3, w3
               	ldur	w4, [x29, #-0x40]
               	udiv	x17, x1, x4
               	msub	x1, x17, x4, x1
               	cmp	x3, x1
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
               	mov	x1, #0x40               // =64
               	stur	w1, [x29, #-0x38]
               	ldr	x1, [x3, x0, lsl #3]
               	mov	w1, w1
               	lsr	x2, x1, #6
               	ldur	w4, [x29, #-0x38]
               	udiv	x4, x1, x4
               	cmp	w2, w4
               	b.ne	<addr>
               	lsl	x2, x2, #6
               	sub	x2, x1, x2
               	mov	w2, w2
               	ldur	w4, [x29, #-0x38]
               	udiv	x17, x1, x4
               	msub	x1, x17, x4, x1
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
               	mov	x0, #0x0                // =0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x1, #0x80000000         // =2147483648
               	stur	w1, [x29, #-0x30]
               	ldr	x1, [x3, x0, lsl #3]
               	mov	w1, w1
               	lsr	x2, x1, #31
               	ldur	w4, [x29, #-0x30]
               	udiv	x4, x1, x4
               	cmp	w2, w4
               	b.ne	<addr>
               	lsl	x2, x2, #31
               	sub	x2, x1, x2
               	mov	w2, w2
               	ldur	w4, [x29, #-0x30]
               	udiv	x17, x1, x4
               	msub	x1, x17, x4, x1
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
               	mov	x0, #0x0                // =0
               	mov	x2, #0x1                // =1
               	movk	x2, #0x8000, lsl #16
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	stur	w2, [x29, #-0x28]
               	ldr	x1, [x4, x0, lsl #3]
               	mov	w1, w1
               	cmp	x1, x2
               	cset	x3, hs
               	ldur	w5, [x29, #-0x28]
               	udiv	x5, x1, x5
               	cmp	w3, w5
               	b.ne	<addr>
               	msub	x3, x3, x2, x1
               	mov	w3, w3
               	ldur	w5, [x29, #-0x28]
               	udiv	x17, x1, x5
               	msub	x1, x17, x5, x1
               	cmp	x3, x1
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
               	mov	x4, #0xfffffffe         // =4294967294
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x2, #0xfffffffe         // =4294967294
               	stur	w2, [x29, #-0x20]
               	ldr	x1, [x5, x0, lsl #3]
               	mov	w1, w1
               	cmp	x1, x4
               	cset	x3, hs
               	ldur	w6, [x29, #-0x20]
               	udiv	x6, x1, x6
               	cmp	w3, w6
               	b.ne	<addr>
               	msub	x2, x3, x2, x1
               	mov	w2, w2
               	ldur	w3, [x29, #-0x20]
               	udiv	x17, x1, x3
               	msub	x1, x17, x3, x1
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
               	mov	x0, #0x0                // =0
               	mov	x4, #0xffffffff         // =4294967295
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x2, #0xffffffff         // =4294967295
               	stur	w2, [x29, #-0x18]
               	ldr	x1, [x5, x0, lsl #3]
               	mov	w1, w1
               	cmp	x1, x4
               	cset	x3, hs
               	ldur	w6, [x29, #-0x18]
               	udiv	x6, x1, x6
               	cmp	w3, w6
               	b.ne	<addr>
               	msub	x2, x3, x2, x1
               	mov	w2, w2
               	ldur	w3, [x29, #-0x18]
               	udiv	x17, x1, x3
               	msub	x1, x17, x3, x1
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
               	mov	x0, #0x0                // =0
               	mov	x2, #0xfffd             // =65533
               	movk	x2, #0xffff, lsl #16
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x1, #-0x3               // =-3
               	stur	w1, [x29, #-0x10]
               	ldr	x1, [x4, x0, lsl #3]
               	mov	w1, w1
               	cmp	x1, x2
               	cset	x3, hs
               	ldur	w5, [x29, #-0x10]
               	udiv	x5, x1, x5
               	cmp	w3, w5
               	b.ne	<addr>
               	msub	x3, x3, x2, x1
               	mov	w3, w3
               	ldur	w5, [x29, #-0x10]
               	udiv	x17, x1, x5
               	msub	x1, x17, x5, x1
               	cmp	x3, x1
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
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x1, #-0x1               // =-1
               	stur	w1, [x29, #-0x8]
               	ldr	x1, [x4, x0, lsl #3]
               	mov	w1, w1
               	cmp	x1, x3
               	cset	x2, hs
               	ldur	w5, [x29, #-0x8]
               	udiv	x5, x1, x5
               	cmp	w2, w5
               	b.ne	<addr>
               	mov	x5, #0xffffffff         // =4294967295
               	msub	x2, x2, x5, x1
               	mov	w2, w2
               	ldur	w5, [x29, #-0x8]
               	udiv	x17, x1, x5
               	msub	x1, x17, x5, x1
               	cmp	x2, x1
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

<wides>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xb0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	mov	x4, #0x5555555555555555 // =6148914691236517205
               	mov	x5, #0x6667             // =26215
               	movk	x5, #0x6666, lsl #16
               	movk	x5, #0x6666, lsl #32
               	movk	x5, #0x6666, lsl #48
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x2, #0xa                // =10
               	stur	x2, [x29, #-0xb0]
               	ldr	x1, [x6, x0, lsl #3]
               	cmp	x1, x4
               	b.eq	<addr>
               	smulh	x3, x1, x5
               	asr	x3, x3, #2
               	lsr	x7, x3, #63
               	add	x3, x3, x7
               	ldur	x7, [x29, #-0xb0]
               	sdiv	x7, x1, x7
               	cmp	x3, x7
               	b.ne	<addr>
               	msub	x2, x3, x2, x1
               	ldur	x3, [x29, #-0xb0]
               	sdiv	x17, x1, x3
               	msub	x1, x17, x3, x1
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
               	mov	x5, #0xf7cf             // =63439
               	movk	x5, #0xe353, lsl #16
               	movk	x5, #0x9ba5, lsl #32
               	movk	x5, #0x20c4, lsl #48
               	mov	x6, #0x5555555555555555 // =6148914691236517205
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	mov	x1, x2
               	mov	x3, #-0x3e8             // =-1000
               	stur	x3, [x29, #-0xa8]
               	ldr	x0, [x7, x1, lsl #3]
               	cmp	x0, x6
               	b.eq	<addr>
               	smulh	x4, x0, x5
               	asr	x4, x4, #7
               	lsr	x8, x4, #63
               	add	x4, x4, x8
               	sub	x4, x2, x4
               	ldur	x8, [x29, #-0xa8]
               	sdiv	x8, x0, x8
               	cmp	x4, x8
               	b.ne	<addr>
               	msub	x3, x4, x3, x0
               	ldur	x4, [x29, #-0xa8]
               	sdiv	x17, x0, x4
               	msub	x0, x17, x4, x0
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
               	mov	x1, #0x0                // =0
               	mov	x2, #0x5555555555555555 // =6148914691236517205
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0xa0]
               	ldr	x0, [x3, x1, lsl #3]
               	cmp	x0, x2
               	b.eq	<addr>
               	ldur	x4, [x29, #-0xa0]
               	sdiv	x4, x0, x4
               	cmp	x0, x4
               	b.ne	<addr>
               	sub	x4, x0, x0
               	ldur	x5, [x29, #-0xa0]
               	sdiv	x17, x0, x5
               	msub	x0, x17, x5, x0
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
               	mov	x2, #0x0                // =0
               	mov	x4, #-0x8000000000000000 // =-9223372036854775808
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, x2
               	mov	x0, #-0x1               // =-1
               	stur	x0, [x29, #-0x98]
               	ldr	x0, [x5, x1, lsl #3]
               	cmp	x0, x4
               	b.eq	<addr>
               	sub	x3, x2, x0
               	ldur	x6, [x29, #-0x98]
               	sdiv	x6, x0, x6
               	cmp	x3, x6
               	b.ne	<addr>
               	add	x3, x0, x3
               	ldur	x6, [x29, #-0x98]
               	sdiv	x17, x0, x6
               	msub	x0, x17, x6, x0
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
               	mov	x1, #0x0                // =0
               	mov	x3, #0x5555555555555555 // =6148914691236517205
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x0, #0x1000             // =4096
               	stur	x0, [x29, #-0x90]
               	ldr	x0, [x4, x1, lsl #3]
               	cmp	x0, x3
               	b.eq	<addr>
               	asr	x2, x0, #63
               	lsr	x2, x2, #52
               	add	x2, x0, x2
               	asr	x2, x2, #12
               	ldur	x5, [x29, #-0x90]
               	sdiv	x5, x0, x5
               	cmp	x2, x5
               	b.ne	<addr>
               	lsl	x2, x2, #12
               	sub	x2, x0, x2
               	ldur	x5, [x29, #-0x90]
               	sdiv	x17, x0, x5
               	msub	x0, x17, x5, x0
               	cmp	x2, x0
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
               	mov	x5, #-0xffff            // =-65535
               	movk	x5, #0x8000, lsl #16
               	movk	x5, #0x7fff, lsl #48
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x2, #0x100000001        // =4294967297
               	stur	x2, [x29, #-0x88]
               	ldr	x1, [x6, x0, lsl #3]
               	cmp	x1, x4
               	b.eq	<addr>
               	smulh	x3, x1, x5
               	asr	x3, x3, #31
               	lsr	x7, x3, #63
               	add	x3, x3, x7
               	ldur	x7, [x29, #-0x88]
               	sdiv	x7, x1, x7
               	cmp	x3, x7
               	b.ne	<addr>
               	msub	x2, x3, x2, x1
               	ldur	x3, [x29, #-0x88]
               	sdiv	x17, x1, x3
               	msub	x1, x17, x3, x1
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
               	mov	x0, #0x0                // =0
               	mov	x4, #0x1                // =1
               	movk	x4, #0x4000, lsl #48
               	mov	x5, #0x5555555555555555 // =6148914691236517205
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x2, #0x7fffffffffffffff // =9223372036854775807
               	stur	x2, [x29, #-0x80]
               	ldr	x1, [x6, x0, lsl #3]
               	cmp	x1, x5
               	b.eq	<addr>
               	smulh	x3, x1, x4
               	asr	x3, x3, #61
               	lsr	x7, x3, #63
               	add	x3, x3, x7
               	ldur	x7, [x29, #-0x80]
               	sdiv	x7, x1, x7
               	cmp	x3, x7
               	b.ne	<addr>
               	msub	x2, x3, x2, x1
               	ldur	x3, [x29, #-0x80]
               	sdiv	x17, x1, x3
               	msub	x1, x17, x3, x1
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
               	mov	x5, #0x5555555555555555 // =6148914691236517205
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x1, x2
               	mov	x3, #-0x8000000000000000 // =-9223372036854775808
               	stur	x3, [x29, #-0x78]
               	ldr	x0, [x6, x1, lsl #3]
               	cmp	x0, x5
               	b.eq	<addr>
               	asr	x4, x0, #63
               	lsr	x4, x4, #1
               	add	x4, x0, x4
               	asr	x4, x4, #63
               	sub	x4, x2, x4
               	ldur	x7, [x29, #-0x78]
               	sdiv	x7, x0, x7
               	cmp	x4, x7
               	b.ne	<addr>
               	msub	x3, x4, x3, x0
               	ldur	x4, [x29, #-0x78]
               	sdiv	x17, x0, x4
               	msub	x0, x17, x4, x0
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
               	mov	x4, #0x5555555555555555 // =6148914691236517205
               	mov	x5, #0x6667             // =26215
               	movk	x5, #0x6666, lsl #16
               	movk	x5, #0x6666, lsl #32
               	movk	x5, #0x6666, lsl #48
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x2, #0xa                // =10
               	stur	x2, [x29, #-0x70]
               	ldr	x1, [x6, x0, lsl #3]
               	cmp	x1, x4
               	b.eq	<addr>
               	lsr	x3, x1, #1
               	umulh	x3, x3, x5
               	lsr	x3, x3, #1
               	ldur	x7, [x29, #-0x70]
               	udiv	x7, x1, x7
               	cmp	x3, x7
               	b.ne	<addr>
               	msub	x2, x3, x2, x1
               	ldur	x3, [x29, #-0x70]
               	udiv	x17, x1, x3
               	msub	x1, x17, x3, x1
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
               	mov	x1, #0x0                // =0
               	mov	x4, #0x2493             // =9363
               	movk	x4, #0x9249, lsl #16
               	movk	x4, #0x4924, lsl #32
               	movk	x4, #0x2492, lsl #48
               	mov	x5, #0x5555555555555555 // =6148914691236517205
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x2, #0x7                // =7
               	stur	x2, [x29, #-0x68]
               	ldr	x0, [x6, x1, lsl #3]
               	cmp	x0, x5
               	b.eq	<addr>
               	umulh	x3, x0, x4
               	sub	x7, x0, x3
               	lsr	x7, x7, #1
               	add	x3, x7, x3
               	lsr	x3, x3, #2
               	ldur	x7, [x29, #-0x68]
               	udiv	x7, x0, x7
               	cmp	x3, x7
               	b.ne	<addr>
               	msub	x2, x3, x2, x0
               	ldur	x3, [x29, #-0x68]
               	udiv	x17, x0, x3
               	msub	x0, x17, x3, x0
               	cmp	x2, x0
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
               	mov	x3, #0x5555555555555555 // =6148914691236517205
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x1, #0x100000000        // =4294967296
               	stur	x1, [x29, #-0x60]
               	ldr	x1, [x4, x0, lsl #3]
               	cmp	x1, x3
               	b.eq	<addr>
               	lsr	x2, x1, #32
               	ldur	x5, [x29, #-0x60]
               	udiv	x5, x1, x5
               	cmp	x2, x5
               	b.ne	<addr>
               	lsl	x2, x2, #32
               	sub	x2, x1, x2
               	ldur	x5, [x29, #-0x60]
               	udiv	x17, x1, x5
               	msub	x1, x17, x5, x1
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
               	mov	x0, #0x0                // =0
               	mov	x4, #0x5555555555555555 // =6148914691236517205
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x2, #-0x8000000000000000 // =-9223372036854775808
               	stur	x2, [x29, #-0x58]
               	ldr	x1, [x5, x0, lsl #3]
               	cmp	x1, x4
               	b.eq	<addr>
               	lsr	x3, x1, #63
               	ldur	x6, [x29, #-0x58]
               	udiv	x6, x1, x6
               	cmp	x3, x6
               	b.ne	<addr>
               	msub	x2, x3, x2, x1
               	ldur	x3, [x29, #-0x58]
               	udiv	x17, x1, x3
               	msub	x1, x17, x3, x1
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
               	mov	x0, #0x0                // =0
               	mov	x4, #-0x7fffffffffffffff // =-9223372036854775807
               	mov	x5, #0x5555555555555555 // =6148914691236517205
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x2, #-0x7fffffffffffffff // =-9223372036854775807
               	stur	x2, [x29, #-0x50]
               	ldr	x1, [x6, x0, lsl #3]
               	cmp	x1, x5
               	b.eq	<addr>
               	cmp	x1, x4
               	cset	x3, hs
               	ldur	x7, [x29, #-0x50]
               	udiv	x7, x1, x7
               	cmp	x3, x7
               	b.ne	<addr>
               	msub	x2, x3, x2, x1
               	ldur	x3, [x29, #-0x50]
               	udiv	x17, x1, x3
               	msub	x1, x17, x3, x1
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
               	mov	x0, #0x0                // =0
               	mov	x3, #-0x1               // =-1
               	mov	x4, #0x5555555555555555 // =6148914691236517205
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, #-0x1               // =-1
               	stur	x1, [x29, #-0x48]
               	ldr	x1, [x5, x0, lsl #3]
               	cmp	x1, x4
               	b.eq	<addr>
               	cmp	x1, x3
               	cset	x2, hs
               	ldur	x6, [x29, #-0x48]
               	udiv	x6, x1, x6
               	cmp	x2, x6
               	b.ne	<addr>
               	add	x2, x1, x2
               	ldur	x6, [x29, #-0x48]
               	udiv	x17, x1, x6
               	msub	x1, x17, x6, x1
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
               	mov	x0, #0x0                // =0
               	mov	x4, #-0x3               // =-3
               	mov	x5, #0x5555555555555555 // =6148914691236517205
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x2, #-0x3               // =-3
               	stur	x2, [x29, #-0x40]
               	ldr	x1, [x6, x0, lsl #3]
               	cmp	x1, x5
               	b.eq	<addr>
               	cmp	x1, x4
               	cset	x3, hs
               	ldur	x7, [x29, #-0x40]
               	udiv	x7, x1, x7
               	cmp	x3, x7
               	b.ne	<addr>
               	msub	x2, x3, x2, x1
               	ldur	x3, [x29, #-0x40]
               	udiv	x17, x1, x3
               	msub	x1, x17, x3, x1
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
               	mov	x0, #0x0                // =0
               	mov	x4, #0x5555555555555555 // =6148914691236517205
               	mov	x5, #0x6667             // =26215
               	movk	x5, #0x6666, lsl #16
               	movk	x5, #0x6666, lsl #32
               	movk	x5, #0x6666, lsl #48
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x2, #0xa                // =10
               	stur	x2, [x29, #-0x38]
               	ldr	x1, [x6, x0, lsl #3]
               	cmp	x1, x4
               	b.eq	<addr>
               	smulh	x3, x1, x5
               	asr	x3, x3, #2
               	lsr	x7, x3, #63
               	add	x3, x3, x7
               	ldur	x7, [x29, #-0x38]
               	sdiv	x7, x1, x7
               	cmp	x3, x7
               	b.ne	<addr>
               	msub	x2, x3, x2, x1
               	ldur	x3, [x29, #-0x38]
               	sdiv	x17, x1, x3
               	msub	x1, x17, x3, x1
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
               	mov	x5, #0x4925             // =18725
               	movk	x5, #0x2492, lsl #16
               	movk	x5, #0x9249, lsl #32
               	movk	x5, #0x4924, lsl #48
               	mov	x6, #0x5555555555555555 // =6148914691236517205
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	mov	x1, x2
               	mov	x3, #-0x7               // =-7
               	stur	x3, [x29, #-0x30]
               	ldr	x0, [x7, x1, lsl #3]
               	cmp	x0, x6
               	b.eq	<addr>
               	smulh	x4, x0, x5
               	asr	x4, x4, #1
               	lsr	x8, x4, #63
               	add	x4, x4, x8
               	sub	x4, x2, x4
               	ldur	x8, [x29, #-0x30]
               	sdiv	x8, x0, x8
               	cmp	x4, x8
               	b.ne	<addr>
               	msub	x3, x4, x3, x0
               	ldur	x4, [x29, #-0x30]
               	sdiv	x17, x0, x4
               	msub	x0, x17, x4, x0
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
               	mov	x1, #0x0                // =0
               	mov	x3, #0x5555555555555555 // =6148914691236517205
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x0, #0x40000000         // =1073741824
               	stur	x0, [x29, #-0x28]
               	ldr	x0, [x4, x1, lsl #3]
               	cmp	x0, x3
               	b.eq	<addr>
               	asr	x2, x0, #63
               	lsr	x2, x2, #34
               	add	x2, x0, x2
               	asr	x2, x2, #30
               	ldur	x5, [x29, #-0x28]
               	sdiv	x5, x0, x5
               	cmp	x2, x5
               	b.ne	<addr>
               	lsl	x2, x2, #30
               	sub	x2, x0, x2
               	ldur	x5, [x29, #-0x28]
               	sdiv	x17, x0, x5
               	msub	x0, x17, x5, x0
               	cmp	x2, x0
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
               	mov	x4, #-0x8000000000000000 // =-9223372036854775808
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, x2
               	mov	x0, #-0x1               // =-1
               	stur	x0, [x29, #-0x20]
               	ldr	x0, [x5, x1, lsl #3]
               	cmp	x0, x4
               	b.eq	<addr>
               	sub	x3, x2, x0
               	ldur	x6, [x29, #-0x20]
               	sdiv	x6, x0, x6
               	cmp	x3, x6
               	b.ne	<addr>
               	add	x3, x0, x3
               	ldur	x6, [x29, #-0x20]
               	sdiv	x17, x0, x6
               	msub	x0, x17, x6, x0
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
               	mov	x4, #0x5555555555555555 // =6148914691236517205
               	mov	x5, #0x6667             // =26215
               	movk	x5, #0x6666, lsl #16
               	movk	x5, #0x6666, lsl #32
               	movk	x5, #0x6666, lsl #48
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x2, #0xa                // =10
               	stur	x2, [x29, #-0x18]
               	ldr	x1, [x6, x0, lsl #3]
               	cmp	x1, x4
               	b.eq	<addr>
               	lsr	x3, x1, #1
               	umulh	x3, x3, x5
               	lsr	x3, x3, #1
               	ldur	x7, [x29, #-0x18]
               	udiv	x7, x1, x7
               	cmp	x3, x7
               	b.ne	<addr>
               	msub	x2, x3, x2, x1
               	ldur	x3, [x29, #-0x18]
               	udiv	x17, x1, x3
               	msub	x1, x17, x3, x1
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
               	mov	x0, #0x0                // =0
               	mov	x2, #0x1                // =1
               	movk	x2, #0x8000, lsl #16
               	mov	x4, #-0xffff            // =-65535
               	movk	x4, #0x8000, lsl #16
               	movk	x4, #0x3fff, lsl #48
               	mov	x5, #0x5555555555555555 // =6148914691236517205
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	stur	x2, [x29, #-0x10]
               	ldr	x1, [x6, x0, lsl #3]
               	cmp	x1, x5
               	b.eq	<addr>
               	umulh	x3, x1, x4
               	lsr	x3, x3, #29
               	ldur	x7, [x29, #-0x10]
               	udiv	x7, x1, x7
               	cmp	x3, x7
               	b.ne	<addr>
               	msub	x3, x3, x2, x1
               	ldur	x7, [x29, #-0x10]
               	udiv	x17, x1, x7
               	msub	x1, x17, x7, x1
               	cmp	x3, x1
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
               	mov	x4, #-0x3               // =-3
               	mov	x5, #0x5555555555555555 // =6148914691236517205
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x2, #-0x3               // =-3
               	stur	x2, [x29, #-0x8]
               	ldr	x1, [x6, x0, lsl #3]
               	cmp	x1, x5
               	b.eq	<addr>
               	cmp	x1, x4
               	cset	x3, hs
               	ldur	x7, [x29, #-0x8]
               	udiv	x7, x1, x7
               	cmp	x3, x7
               	b.ne	<addr>
               	msub	x2, x3, x2, x1
               	ldur	x3, [x29, #-0x8]
               	udiv	x17, x1, x3
               	msub	x1, x17, x3, x1
               	cmp	x2, x1
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

<converted>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x90
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	mov	x4, #0x5556             // =21846
               	movk	x4, #0x5555, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x2, #0x3                // =3
               	sturb	w2, [x29, #-0x88]
               	ldr	x1, [x5, x0, lsl #3]
               	sxtb	x1, w1
               	mul	x3, x1, x4
               	asr	x3, x3, #32
               	lsr	x6, x3, #63
               	add	x3, x3, x6
               	ldursb	x6, [x29, #-0x88]
               	sdiv	x6, x1, x6
               	cmp	w3, w6
               	b.ne	<addr>
               	msub	x2, x3, x2, x1
               	sxtw	x2, w2
               	ldursb	x3, [x29, #-0x88]
               	sdiv	x17, x1, x3
               	msub	x1, x17, x3, x1
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
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, x2
               	mov	x3, #-0x80              // =-128
               	sturb	w3, [x29, #-0x80]
               	ldr	x0, [x5, x1, lsl #3]
               	sxtb	x0, w0
               	lsr	x4, x0, #57
               	add	x4, x0, x4
               	asr	x4, x4, #7
               	sub	x4, x2, x4
               	ldursb	x6, [x29, #-0x80]
               	sdiv	x6, x0, x6
               	cmp	w4, w6
               	b.ne	<addr>
               	msub	x3, x4, x3, x0
               	sxtw	x3, w3
               	ldursb	x4, [x29, #-0x80]
               	sdiv	x17, x0, x4
               	msub	x0, x17, x4, x0
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
               	mov	x2, #0x0                // =0
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x0, x2
               	mov	x1, #-0x1               // =-1
               	sturb	w1, [x29, #-0x78]
               	ldr	x1, [x4, x0, lsl #3]
               	sxtb	x1, w1
               	sub	x3, x2, x1
               	ldursb	x5, [x29, #-0x78]
               	sdiv	x5, x1, x5
               	cmp	w3, w5
               	b.ne	<addr>
               	add	x3, x1, x3
               	ldursb	x5, [x29, #-0x78]
               	sdiv	x17, x1, x5
               	msub	x1, x17, x5, x1
               	cmp	x3, x1
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
               	mov	x4, #0x5556             // =21846
               	movk	x4, #0x5555, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x2, #0x3                // =3
               	sturb	w2, [x29, #-0x70]
               	ldr	x1, [x5, x0, lsl #3]
               	and	x1, x1, #0xff
               	mul	x3, x1, x4
               	lsr	x3, x3, #32
               	ldurb	w6, [x29, #-0x70]
               	sdiv	x6, x1, x6
               	cmp	w3, w6
               	b.ne	<addr>
               	msub	x2, x3, x2, x1
               	sxtw	x2, w2
               	ldurb	w3, [x29, #-0x70]
               	sdiv	x17, x1, x3
               	msub	x1, x17, x3, x1
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
               	mov	x0, #0x0                // =0
               	mov	x4, #0x102              // =258
               	movk	x4, #0x101, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x2, #0xff               // =255
               	sturb	w2, [x29, #-0x68]
               	ldr	x1, [x5, x0, lsl #3]
               	and	x1, x1, #0xff
               	mul	x3, x1, x4
               	lsr	x3, x3, #32
               	ldurb	w6, [x29, #-0x68]
               	sdiv	x6, x1, x6
               	cmp	w3, w6
               	b.ne	<addr>
               	msub	x2, x3, x2, x1
               	sxtw	x2, w2
               	ldurb	w3, [x29, #-0x68]
               	sdiv	x17, x1, x3
               	msub	x1, x17, x3, x1
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
               	mov	x0, #0x0                // =0
               	mov	x4, #0x6667             // =26215
               	movk	x4, #0x6666, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x2, #0xa                // =10
               	sturh	w2, [x29, #-0x60]
               	ldr	x1, [x5, x0, lsl #3]
               	sxth	x1, w1
               	mul	x3, x1, x4
               	asr	x3, x3, #34
               	lsr	x6, x3, #63
               	add	x3, x3, x6
               	ldursh	x6, [x29, #-0x60]
               	sdiv	x6, x1, x6
               	cmp	w3, w6
               	b.ne	<addr>
               	msub	x2, x3, x2, x1
               	sxtw	x2, w2
               	ldursh	x3, [x29, #-0x60]
               	sdiv	x17, x1, x3
               	msub	x1, x17, x3, x1
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
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, x2
               	mov	x3, #-0x8000            // =-32768
               	sturh	w3, [x29, #-0x58]
               	ldr	x0, [x5, x1, lsl #3]
               	sxth	x0, w0
               	lsr	x4, x0, #49
               	add	x4, x0, x4
               	asr	x4, x4, #15
               	sub	x4, x2, x4
               	ldursh	x6, [x29, #-0x58]
               	sdiv	x6, x0, x6
               	cmp	w4, w6
               	b.ne	<addr>
               	msub	x3, x4, x3, x0
               	sxtw	x3, w3
               	ldursh	x4, [x29, #-0x58]
               	sdiv	x17, x0, x4
               	msub	x0, x17, x4, x0
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
               	mov	x4, #0xaaab             // =43691
               	movk	x4, #0xaaaa, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x2, #0x3                // =3
               	stur	w2, [x29, #-0x50]
               	ldr	x1, [x5, x0, lsl #3]
               	mov	w1, w1
               	mul	x3, x1, x4
               	lsr	x3, x3, #33
               	ldur	w6, [x29, #-0x50]
               	udiv	x6, x1, x6
               	cmp	w3, w6
               	b.ne	<addr>
               	msub	x2, x3, x2, x1
               	mov	w2, w2
               	ldur	w3, [x29, #-0x50]
               	udiv	x17, x1, x3
               	msub	x1, x17, x3, x1
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
               	mov	x0, #0x0                // =0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x1, #0x80000000         // =2147483648
               	stur	w1, [x29, #-0x48]
               	ldr	x1, [x3, x0, lsl #3]
               	mov	w1, w1
               	lsr	x2, x1, #31
               	ldur	w4, [x29, #-0x48]
               	udiv	x4, x1, x4
               	cmp	w2, w4
               	b.ne	<addr>
               	lsl	x2, x2, #31
               	sub	x2, x1, x2
               	mov	w2, w2
               	ldur	w4, [x29, #-0x48]
               	udiv	x17, x1, x4
               	msub	x1, x17, x4, x1
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
               	mov	x0, #0x0                // =0
               	mov	x2, #0xfffd             // =65533
               	movk	x2, #0xffff, lsl #16
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x1, #-0x3               // =-3
               	stur	w1, [x29, #-0x40]
               	ldr	x1, [x4, x0, lsl #3]
               	mov	w1, w1
               	cmp	x1, x2
               	cset	x3, hs
               	ldur	w5, [x29, #-0x40]
               	udiv	x5, x1, x5
               	cmp	w3, w5
               	b.ne	<addr>
               	msub	x3, x3, x2, x1
               	mov	w3, w3
               	ldur	w5, [x29, #-0x40]
               	udiv	x17, x1, x5
               	msub	x1, x17, x5, x1
               	cmp	x3, x1
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
               	mov	x4, #0x5556             // =21846
               	movk	x4, #0x5555, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x2, #0x3                // =3
               	stur	x2, [x29, #-0x38]
               	ldr	x1, [x5, x0, lsl #3]
               	sxtw	x1, w1
               	mul	x3, x1, x4
               	asr	x3, x3, #32
               	lsr	x6, x3, #63
               	add	x3, x3, x6
               	ldur	x6, [x29, #-0x38]
               	sdiv	x6, x1, x6
               	cmp	x3, x6
               	b.ne	<addr>
               	msub	x2, x3, x2, x1
               	ldur	x3, [x29, #-0x38]
               	sdiv	x17, x1, x3
               	msub	x1, x17, x3, x1
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
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x0, x2
               	mov	x1, #-0x1               // =-1
               	stur	x1, [x29, #-0x30]
               	ldr	x1, [x4, x0, lsl #3]
               	sxtw	x1, w1
               	sub	x3, x2, x1
               	ldur	x5, [x29, #-0x30]
               	sdiv	x5, x1, x5
               	cmp	x3, x5
               	b.ne	<addr>
               	add	x3, x1, x3
               	ldur	x5, [x29, #-0x30]
               	sdiv	x17, x1, x5
               	msub	x1, x17, x5, x1
               	cmp	x3, x1
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
               	stur	x1, [x29, #-0x28]
               	ldr	x1, [x2, x0, lsl #3]
               	sxtw	x1, w1
               	ldur	x3, [x29, #-0x28]
               	sdiv	x3, x1, x3
               	cbnz	x3, <addr>
               	ldur	x3, [x29, #-0x28]
               	sdiv	x17, x1, x3
               	msub	x3, x17, x3, x1
               	cmp	x1, x3
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
               	mov	x1, x2
               	mov	x3, #-0x80000000        // =-2147483648
               	stur	x3, [x29, #-0x20]
               	ldr	x0, [x5, x1, lsl #3]
               	sxtw	x0, w0
               	lsr	x4, x0, #33
               	add	x4, x0, x4
               	asr	x4, x4, #31
               	sub	x4, x2, x4
               	ldur	x6, [x29, #-0x20]
               	sdiv	x6, x0, x6
               	cmp	x4, x6
               	b.ne	<addr>
               	msub	x3, x4, x3, x0
               	ldur	x4, [x29, #-0x20]
               	sdiv	x17, x0, x4
               	msub	x0, x17, x4, x0
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
               	mov	x4, #0x4925             // =18725
               	movk	x4, #0x2492, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x2, #0x7                // =7
               	stur	x2, [x29, #-0x18]
               	ldr	x1, [x5, x0, lsl #3]
               	mov	w1, w1
               	mul	x3, x1, x4
               	lsr	x3, x3, #32
               	sub	x6, x1, x3
               	lsr	x6, x6, #1
               	add	x3, x6, x3
               	lsr	x3, x3, #2
               	ldur	x6, [x29, #-0x18]
               	sdiv	x6, x1, x6
               	cmp	x3, x6
               	b.ne	<addr>
               	msub	x2, x3, x2, x1
               	ldur	x3, [x29, #-0x18]
               	sdiv	x17, x1, x3
               	msub	x1, x17, x3, x1
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
               	mov	x5, #0x4925             // =18725
               	movk	x5, #0x2492, lsl #16
               	movk	x5, #0x9249, lsl #32
               	movk	x5, #0x4924, lsl #48
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x2
               	mov	x3, #-0x7               // =-7
               	stur	x3, [x29, #-0x10]
               	ldr	x1, [x6, x0, lsl #3]
               	mov	w1, w1
               	smulh	x4, x1, x5
               	asr	x4, x4, #1
               	lsr	x7, x4, #63
               	add	x4, x4, x7
               	sub	x4, x2, x4
               	ldur	x7, [x29, #-0x10]
               	sdiv	x7, x1, x7
               	cmp	x4, x7
               	b.ne	<addr>
               	msub	x3, x4, x3, x1
               	ldur	x4, [x29, #-0x10]
               	sdiv	x17, x1, x4
               	msub	x1, x17, x4, x1
               	cmp	x3, x1
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
               	mov	x4, #0xffffffff         // =4294967295
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x2, #0xffffffff         // =4294967295
               	stur	x2, [x29, #-0x8]
               	ldr	x1, [x5, x0, lsl #3]
               	mov	w1, w1
               	cmp	x1, x4
               	cset	x3, hs
               	ldur	x6, [x29, #-0x8]
               	sdiv	x6, x1, x6
               	cmp	x3, x6
               	b.ne	<addr>
               	msub	x2, x3, x2, x1
               	ldur	x3, [x29, #-0x8]
               	sdiv	x17, x1, x3
               	msub	x1, x17, x3, x1
               	cmp	x2, x1
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

<fixed>:
               	sxtw	x0, w0
               	mov	x17, #0x2493            // =9363
               	movk	x17, #0x9249, lsl #16
               	mul	x1, x0, x17
               	asr	x1, x1, #34
               	lsr	x2, x1, #63
               	add	x1, x1, x2
               	mov	w0, w0
               	mov	x2, #0x3e8              // =1000
               	lsr	x3, x0, #3
               	mov	x17, #0x4dd3            // =19923
               	movk	x17, #0x1062, lsl #16
               	mul	x3, x3, x17
               	lsr	x3, x3, #35
               	msub	x0, x3, x2, x0
               	add	x0, x1, x0
               	sxtw	x0, w0
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x50]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	bl	<addr>
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x20, #0x0               // =0
               	stur	w20, [x29, #-0x18]
               	mov	x23, #0x7               // =7
               	stur	w23, [x29, #-0x10]
               	mov	x0, #0x3e8              // =1000
               	stur	w0, [x29, #-0x8]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x21, x20
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, x21, lsl #3]
               	sxtw	x22, w0
               	mov	x2, #0x3e8              // =1000
               	mov	x1, x23
               	bl	<addr>
               	ldursw	x1, [x29, #-0x10]
               	sdiv	x1, x22, x1
               	mov	w2, w22
               	ldur	w3, [x29, #-0x8]
               	udiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	add	x1, x1, x2
               	sxtw	x1, w1
               	cmp	x0, x1
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x18]
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	sdiv	x1, x22, x0
               	msub	x0, x1, x0, x22
               	add	x0, x1, x0
               	add	x20, x20, x0
               	add	x21, x21, #0x1
               	cmp	w21, #0x18
               	b.lt	<addr>
               	sxtw	x0, w20
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x20, [x0]
               	b	<addr>
