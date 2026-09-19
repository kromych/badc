
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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x1, [x0, #0x80]
               	mov	x1, #0x8d4f             // =36175
               	movk	x1, #0x1a1a, lsl #16
               	movk	x1, #0x754d, lsl #32
               	movk	x1, #0xaa80, lsl #48
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x1, [x0, #0x88]
               	mov	x1, #0x8932             // =35122
               	movk	x1, #0x6d27, lsl #16
               	movk	x1, #0x904a, lsl #32
               	movk	x1, #0xb3c4, lsl #48
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x1, [x0, #0x90]
               	mov	x1, #0x6d19             // =27929
               	movk	x1, #0x7684, lsl #16
               	movk	x1, #0xcf42, lsl #32
               	movk	x1, #0xbc69, lsl #48
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x1, [x0, #0x98]
               	mov	x1, #0x15b4             // =5556
               	movk	x1, #0x6a5b, lsl #16
               	movk	x1, #0x2fd5, lsl #32
               	movk	x1, #0x377b, lsl #48
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x1, [x0, #0xa0]
               	mov	x1, #0x9df3             // =40435
               	movk	x1, #0xeaf2, lsl #16
               	movk	x1, #0x15de, lsl #32
               	movk	x1, #0x64d8, lsl #48
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x1, [x0, #0xa8]
               	mov	x1, #0xd206             // =53766
               	movk	x1, #0xb2d7, lsl #16
               	movk	x1, #0x100d, lsl #32
               	movk	x1, #0xf66e, lsl #48
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x1, [x0, #0xb0]
               	mov	x1, #0x665d             // =26205
               	movk	x1, #0x7e06, lsl #16
               	movk	x1, #0xe6a5, lsl #32
               	movk	x1, #0x1069, lsl #48
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x1, [x0, #0xb8]
               	ret

<ints>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xb0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x1
               	str	w0, [x2]
               	mov	x0, #0x0                // =0
               	mov	x9, #0x6667             // =26215
               	movk	x9, #0x6666, lsl #16
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	cmp	w0, #0x18
               	b.ge	<addr>
               	mov	x5, #0xa                // =10
               	stur	w5, [x29, #-0xa8]
               	ldr	x1, [x6, x0, lsl #3]
               	sxtw	x1, w1
               	mul	x7, x1, x9
               	asr	x3, x7, #34
               	lsr	x8, x3, #63
               	add	x4, x3, x8
               	ldursw	x10, [x29, #-0xa8]
               	sdiv	x10, x1, x10
               	cmp	x4, x10
               	b.ne	<addr>
               	msub	x3, x4, x5, x1
               	sxtw	x4, w3
               	ldursw	x3, [x29, #-0xa8]
               	sdiv	x17, x1, x3
               	msub	x1, x17, x3, x1
               	cmp	x4, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x1
               	str	w0, [x2]
               	mov	x0, #0x0                // =0
               	mov	x9, #0x2493             // =9363
               	movk	x9, #0x9249, lsl #16
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	cmp	w0, #0x18
               	b.ge	<addr>
               	mov	x5, #0x7                // =7
               	stur	w5, [x29, #-0xa0]
               	ldr	x1, [x6, x0, lsl #3]
               	sxtw	x1, w1
               	mul	x7, x1, x9
               	asr	x3, x7, #34
               	lsr	x8, x3, #63
               	add	x4, x3, x8
               	ldursw	x10, [x29, #-0xa0]
               	sdiv	x10, x1, x10
               	cmp	x4, x10
               	b.ne	<addr>
               	msub	x3, x4, x5, x1
               	sxtw	x4, w3
               	ldursw	x3, [x29, #-0xa0]
               	sdiv	x17, x1, x3
               	msub	x1, x17, x3, x1
               	cmp	x4, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x1
               	str	w0, [x2]
               	mov	x5, #0x0                // =0
               	mov	x11, #0x2493            // =9363
               	movk	x11, #0x9249, lsl #16
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	mov	x0, x5
               	cmp	w0, #0x18
               	b.ge	<addr>
               	mov	x6, #-0x7               // =-7
               	stur	w6, [x29, #-0x98]
               	ldr	x1, [x7, x0, lsl #3]
               	sxtw	x1, w1
               	mul	x8, x1, x11
               	asr	x3, x8, #34
               	lsr	x9, x3, #63
               	add	x10, x3, x9
               	sub	x4, x5, x10
               	ldursw	x12, [x29, #-0x98]
               	sdiv	x12, x1, x12
               	cmp	x4, x12
               	b.ne	<addr>
               	msub	x3, x4, x6, x1
               	sxtw	x4, w3
               	ldursw	x3, [x29, #-0x98]
               	sdiv	x17, x1, x3
               	msub	x1, x17, x3, x1
               	cmp	x4, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x1
               	str	w0, [x2]
               	mov	x0, #0x0                // =0
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	cmp	w0, #0x18
               	b.ge	<addr>
               	mov	x1, #0x1                // =1
               	stur	w1, [x29, #-0x90]
               	ldr	x1, [x4, x0, lsl #3]
               	sxtw	x1, w1
               	ldursw	x3, [x29, #-0x90]
               	sdiv	x3, x1, x3
               	cmp	x1, x3
               	b.ne	<addr>
               	lsr	x3, x1, #0
               	sub	x3, x1, x3
               	sxtw	x5, w3
               	ldursw	x3, [x29, #-0x90]
               	sdiv	x17, x1, x3
               	msub	x1, x17, x3, x1
               	cmp	x5, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x1
               	str	w0, [x2]
               	mov	x4, #0x0                // =0
               	mov	x7, #-0x80000000        // =-2147483648
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x1, x4
               	cmp	w1, #0x18
               	b.ge	<addr>
               	mov	x5, #-0x1               // =-1
               	stur	w5, [x29, #-0x88]
               	ldr	x0, [x6, x1, lsl #3]
               	sxtw	x0, w0
               	cmp	w0, w7
               	b.eq	<addr>
               	sub	x3, x4, x0
               	ldursw	x8, [x29, #-0x88]
               	sdiv	x8, x0, x8
               	cmp	w3, w8
               	b.ne	<addr>
               	msub	x3, x3, x5, x0
               	sxtw	x5, w3
               	ldursw	x3, [x29, #-0x88]
               	sdiv	x17, x0, x3
               	msub	x0, x17, x3, x0
               	cmp	x5, x0
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x1
               	str	w0, [x2]
               	mov	x1, #0x0                // =0
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	cmp	w1, #0x18
               	b.ge	<addr>
               	mov	x0, #0x2                // =2
               	stur	w0, [x29, #-0x80]
               	ldr	x0, [x4, x1, lsl #3]
               	sxtw	x0, w0
               	lsr	x5, x0, #63
               	add	x6, x0, x5
               	asr	x3, x6, #1
               	ldursw	x7, [x29, #-0x80]
               	sdiv	x7, x0, x7
               	cmp	x3, x7
               	b.ne	<addr>
               	lsl	x3, x3, #1
               	sub	x3, x0, x3
               	sxtw	x5, w3
               	ldursw	x3, [x29, #-0x80]
               	sdiv	x17, x0, x3
               	msub	x0, x17, x3, x0
               	cmp	x5, x0
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x1
               	str	w0, [x2]
               	mov	x4, #0x0                // =0
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x1, x4
               	cmp	w1, #0x18
               	b.ge	<addr>
               	mov	x5, #-0x2               // =-2
               	stur	w5, [x29, #-0x78]
               	ldr	x0, [x6, x1, lsl #3]
               	sxtw	x0, w0
               	lsr	x7, x0, #63
               	add	x8, x0, x7
               	asr	x9, x8, #1
               	sub	x3, x4, x9
               	ldursw	x10, [x29, #-0x78]
               	sdiv	x10, x0, x10
               	cmp	x3, x10
               	b.ne	<addr>
               	msub	x3, x3, x5, x0
               	sxtw	x5, w3
               	ldursw	x3, [x29, #-0x78]
               	sdiv	x17, x0, x3
               	msub	x0, x17, x3, x0
               	cmp	x5, x0
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x1
               	str	w0, [x2]
               	mov	x1, #0x0                // =0
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	cmp	w1, #0x18
               	b.ge	<addr>
               	mov	x0, #0x400              // =1024
               	stur	w0, [x29, #-0x70]
               	ldr	x0, [x4, x1, lsl #3]
               	sxtw	x0, w0
               	lsr	x5, x0, #54
               	add	x6, x0, x5
               	asr	x3, x6, #10
               	ldursw	x7, [x29, #-0x70]
               	sdiv	x7, x0, x7
               	cmp	x3, x7
               	b.ne	<addr>
               	lsl	x3, x3, #10
               	sub	x3, x0, x3
               	sxtw	x5, w3
               	ldursw	x3, [x29, #-0x70]
               	sdiv	x17, x0, x3
               	msub	x0, x17, x3, x0
               	cmp	x5, x0
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x1
               	str	w0, [x2]
               	mov	x0, #0x0                // =0
               	mov	x9, #0x1                // =1
               	movk	x9, #0x4000, lsl #16
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	cmp	w0, #0x18
               	b.ge	<addr>
               	mov	x5, #0x7fffffff         // =2147483647
               	stur	w5, [x29, #-0x68]
               	ldr	x1, [x6, x0, lsl #3]
               	sxtw	x1, w1
               	mul	x7, x1, x9
               	asr	x3, x7, #61
               	lsr	x8, x3, #63
               	add	x4, x3, x8
               	ldursw	x10, [x29, #-0x68]
               	sdiv	x10, x1, x10
               	cmp	x4, x10
               	b.ne	<addr>
               	msub	x3, x4, x5, x1
               	sxtw	x4, w3
               	ldursw	x3, [x29, #-0x68]
               	sdiv	x17, x1, x3
               	msub	x1, x17, x3, x1
               	cmp	x4, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x1
               	str	w0, [x2]
               	mov	x4, #0x0                // =0
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x1, x4
               	cmp	w1, #0x18
               	b.ge	<addr>
               	mov	x5, #-0x80000000        // =-2147483648
               	stur	w5, [x29, #-0x60]
               	ldr	x0, [x6, x1, lsl #3]
               	sxtw	x0, w0
               	lsr	x7, x0, #33
               	add	x8, x0, x7
               	asr	x9, x8, #31
               	sub	x3, x4, x9
               	ldursw	x10, [x29, #-0x60]
               	sdiv	x10, x0, x10
               	cmp	x3, x10
               	b.ne	<addr>
               	msub	x3, x3, x5, x0
               	sxtw	x5, w3
               	ldursw	x3, [x29, #-0x60]
               	sdiv	x17, x0, x3
               	msub	x0, x17, x3, x0
               	cmp	x5, x0
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x1
               	str	w0, [x2]
               	mov	x5, #0x0                // =0
               	mov	x11, #0x1               // =1
               	movk	x11, #0x4000, lsl #16
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	mov	x0, x5
               	cmp	w0, #0x18
               	b.ge	<addr>
               	mov	x6, #-0x7fffffff        // =-2147483647
               	stur	w6, [x29, #-0x58]
               	ldr	x1, [x7, x0, lsl #3]
               	sxtw	x1, w1
               	mul	x8, x1, x11
               	asr	x3, x8, #61
               	lsr	x9, x3, #63
               	add	x10, x3, x9
               	sub	x4, x5, x10
               	ldursw	x12, [x29, #-0x58]
               	sdiv	x12, x1, x12
               	cmp	x4, x12
               	b.ne	<addr>
               	msub	x3, x4, x6, x1
               	sxtw	x4, w3
               	ldursw	x3, [x29, #-0x58]
               	sdiv	x17, x1, x3
               	msub	x1, x17, x3, x1
               	cmp	x4, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x1
               	str	w0, [x2]
               	mov	x0, #0x0                // =0
               	mov	x9, #0x6667             // =26215
               	movk	x9, #0x6666, lsl #16
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	cmp	w0, #0x18
               	b.ge	<addr>
               	mov	x5, #0xa                // =10
               	stur	w5, [x29, #-0x50]
               	ldr	x1, [x6, x0, lsl #3]
               	mov	w3, w1
               	lsr	x7, x3, #1
               	mul	x8, x7, x9
               	lsr	x4, x8, #33
               	ldur	w10, [x29, #-0x50]
               	udiv	x10, x3, x10
               	cmp	w4, w10
               	b.ne	<addr>
               	msub	x4, x4, x5, x3
               	mov	w4, w4
               	ldur	w1, [x29, #-0x50]
               	udiv	x17, x3, x1
               	msub	x1, x17, x1, x3
               	cmp	x4, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x1
               	str	w0, [x2]
               	mov	x0, #0x0                // =0
               	mov	x12, #0x4925            // =18725
               	movk	x12, #0x2492, lsl #16
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	cmp	w0, #0x18
               	b.ge	<addr>
               	mov	x6, #0x7                // =7
               	stur	w6, [x29, #-0x48]
               	ldr	x1, [x7, x0, lsl #3]
               	mov	w3, w1
               	mul	x8, x3, x12
               	lsr	x4, x8, #32
               	sub	x9, x3, x4
               	lsr	x10, x9, #1
               	add	x11, x10, x4
               	lsr	x5, x11, #2
               	ldur	w13, [x29, #-0x48]
               	udiv	x13, x3, x13
               	cmp	w5, w13
               	b.ne	<addr>
               	msub	x4, x5, x6, x3
               	mov	w4, w4
               	ldur	w1, [x29, #-0x48]
               	udiv	x17, x3, x1
               	msub	x1, x17, x1, x3
               	cmp	x4, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x1
               	str	w0, [x2]
               	mov	x0, #0x0                // =0
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	cmp	w0, #0x18
               	b.ge	<addr>
               	mov	x1, #0x1                // =1
               	stur	w1, [x29, #-0x40]
               	ldr	x1, [x4, x0, lsl #3]
               	mov	w3, w1
               	ldur	w5, [x29, #-0x40]
               	udiv	x5, x3, x5
               	cmp	w3, w5
               	b.ne	<addr>
               	lsr	x5, x3, #0
               	sub	x5, x3, x5
               	mov	w5, w5
               	ldur	w1, [x29, #-0x40]
               	udiv	x17, x3, x1
               	msub	x1, x17, x1, x3
               	cmp	x5, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x1
               	str	w0, [x2]
               	mov	x0, #0x0                // =0
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cmp	w0, #0x18
               	b.ge	<addr>
               	mov	x1, #0x40               // =64
               	stur	w1, [x29, #-0x38]
               	ldr	x1, [x5, x0, lsl #3]
               	mov	w3, w1
               	lsr	x4, x3, #6
               	ldur	w6, [x29, #-0x38]
               	udiv	x6, x3, x6
               	cmp	w4, w6
               	b.ne	<addr>
               	lsl	x4, x4, #6
               	sub	x4, x3, x4
               	mov	w4, w4
               	ldur	w1, [x29, #-0x38]
               	udiv	x17, x3, x1
               	msub	x1, x17, x1, x3
               	cmp	x4, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x1
               	str	w0, [x2]
               	mov	x0, #0x0                // =0
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cmp	w0, #0x18
               	b.ge	<addr>
               	mov	x1, #0x80000000         // =2147483648
               	stur	w1, [x29, #-0x30]
               	ldr	x1, [x5, x0, lsl #3]
               	mov	w3, w1
               	lsr	x4, x3, #31
               	ldur	w6, [x29, #-0x30]
               	udiv	x6, x3, x6
               	cmp	w4, w6
               	b.ne	<addr>
               	lsl	x4, x4, #31
               	sub	x4, x3, x4
               	mov	w4, w4
               	ldur	w1, [x29, #-0x30]
               	udiv	x17, x3, x1
               	msub	x1, x17, x1, x3
               	cmp	x4, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x1
               	str	w0, [x2]
               	mov	x0, #0x0                // =0
               	mov	x4, #0x1                // =1
               	movk	x4, #0x8000, lsl #16
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	cmp	w0, #0x18
               	b.ge	<addr>
               	stur	w4, [x29, #-0x28]
               	ldr	x1, [x6, x0, lsl #3]
               	mov	w3, w1
               	cmp	x3, x4
               	cset	x5, hs
               	ldur	w7, [x29, #-0x28]
               	udiv	x7, x3, x7
               	cmp	w5, w7
               	b.ne	<addr>
               	msub	x5, x5, x4, x3
               	mov	w5, w5
               	ldur	w1, [x29, #-0x28]
               	udiv	x17, x3, x1
               	msub	x1, x17, x1, x3
               	cmp	x5, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x1
               	str	w0, [x2]
               	mov	x0, #0x0                // =0
               	mov	x7, #0xfffffffe         // =4294967294
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	cmp	w0, #0x18
               	b.ge	<addr>
               	mov	x5, #0xfffffffe         // =4294967294
               	stur	w5, [x29, #-0x20]
               	ldr	x1, [x6, x0, lsl #3]
               	mov	w3, w1
               	cmp	x3, x7
               	cset	x4, hs
               	ldur	w8, [x29, #-0x20]
               	udiv	x8, x3, x8
               	cmp	w4, w8
               	b.ne	<addr>
               	msub	x4, x4, x5, x3
               	mov	w4, w4
               	ldur	w1, [x29, #-0x20]
               	udiv	x17, x3, x1
               	msub	x1, x17, x1, x3
               	cmp	x4, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x1
               	str	w0, [x2]
               	mov	x0, #0x0                // =0
               	mov	x7, #0xffffffff         // =4294967295
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	cmp	w0, #0x18
               	b.ge	<addr>
               	mov	x5, #0xffffffff         // =4294967295
               	stur	w5, [x29, #-0x18]
               	ldr	x1, [x6, x0, lsl #3]
               	mov	w3, w1
               	cmp	x3, x7
               	cset	x4, hs
               	ldur	w8, [x29, #-0x18]
               	udiv	x8, x3, x8
               	cmp	w4, w8
               	b.ne	<addr>
               	msub	x4, x4, x5, x3
               	mov	w4, w4
               	ldur	w1, [x29, #-0x18]
               	udiv	x17, x3, x1
               	msub	x1, x17, x1, x3
               	cmp	x4, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x1
               	str	w0, [x2]
               	mov	x0, #0x0                // =0
               	mov	x5, #0xfffd             // =65533
               	movk	x5, #0xffff, lsl #16
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	cmp	w0, #0x18
               	b.ge	<addr>
               	mov	x1, #-0x3               // =-3
               	stur	w1, [x29, #-0x10]
               	ldr	x1, [x6, x0, lsl #3]
               	mov	w3, w1
               	cmp	x3, x5
               	cset	x4, hs
               	ldur	w7, [x29, #-0x10]
               	udiv	x7, x3, x7
               	cmp	w4, w7
               	b.ne	<addr>
               	msub	x4, x4, x5, x3
               	mov	w4, w4
               	ldur	w1, [x29, #-0x10]
               	udiv	x17, x3, x1
               	msub	x1, x17, x1, x3
               	cmp	x4, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x1
               	str	w0, [x2]
               	mov	x0, #0x0                // =0
               	mov	x7, #0xffffffff         // =4294967295
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cmp	w0, #0x18
               	b.ge	<addr>
               	mov	x1, #-0x1               // =-1
               	stur	w1, [x29, #-0x8]
               	ldr	x1, [x5, x0, lsl #3]
               	mov	w3, w1
               	cmp	x3, x7
               	cset	x4, hs
               	ldur	w6, [x29, #-0x8]
               	udiv	x6, x3, x6
               	cmp	w4, w6
               	b.ne	<addr>
               	mov	x6, #0xffffffff         // =4294967295
               	msub	x4, x4, x6, x3
               	mov	w4, w4
               	ldur	w1, [x29, #-0x8]
               	udiv	x17, x3, x1
               	msub	x1, x17, x1, x3
               	cmp	x4, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret

<wides>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xb0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x1
               	str	w0, [x2]
               	mov	x0, #0x0                // =0
               	mov	x10, #0x5555555555555555 // =6148914691236517205
               	mov	x6, #0x6667             // =26215
               	movk	x6, #0x6666, lsl #16
               	movk	x6, #0x6666, lsl #32
               	movk	x6, #0x6666, lsl #48
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	cmp	w0, #0x18
               	b.ge	<addr>
               	mov	x4, #0xa                // =10
               	stur	x4, [x29, #-0xb0]
               	ldr	x1, [x7, x0, lsl #3]
               	cmp	x1, x10
               	b.eq	<addr>
               	smulh	x8, x1, x6
               	asr	x3, x8, #2
               	lsr	x9, x3, #63
               	add	x5, x3, x9
               	ldur	x11, [x29, #-0xb0]
               	sdiv	x11, x1, x11
               	cmp	x5, x11
               	b.ne	<addr>
               	msub	x4, x5, x4, x1
               	ldur	x3, [x29, #-0xb0]
               	sdiv	x17, x1, x3
               	msub	x1, x17, x3, x1
               	cmp	x4, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x1
               	str	w0, [x2]
               	mov	x4, #0x0                // =0
               	mov	x7, #0xf7cf             // =63439
               	movk	x7, #0xe353, lsl #16
               	movk	x7, #0x9ba5, lsl #32
               	movk	x7, #0x20c4, lsl #48
               	mov	x12, #0x5555555555555555 // =6148914691236517205
               	adrp	x8, <page>
               	add	x8, x8, <lo12>
               	mov	x0, x4
               	cmp	w0, #0x18
               	b.ge	<addr>
               	mov	x5, #-0x3e8             // =-1000
               	stur	x5, [x29, #-0xa8]
               	ldr	x1, [x8, x0, lsl #3]
               	cmp	x1, x12
               	b.eq	<addr>
               	smulh	x9, x1, x7
               	asr	x3, x9, #7
               	lsr	x10, x3, #63
               	add	x11, x3, x10
               	sub	x6, x4, x11
               	ldur	x13, [x29, #-0xa8]
               	sdiv	x13, x1, x13
               	cmp	x6, x13
               	b.ne	<addr>
               	msub	x5, x6, x5, x1
               	ldur	x3, [x29, #-0xa8]
               	sdiv	x17, x1, x3
               	msub	x1, x17, x3, x1
               	cmp	x5, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x1
               	str	w0, [x2]
               	mov	x0, #0x0                // =0
               	mov	x5, #0x5555555555555555 // =6148914691236517205
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	cmp	w0, #0x18
               	b.ge	<addr>
               	mov	x1, #0x1                // =1
               	stur	x1, [x29, #-0xa0]
               	ldr	x1, [x4, x0, lsl #3]
               	cmp	x1, x5
               	b.eq	<addr>
               	ldur	x3, [x29, #-0xa0]
               	sdiv	x3, x1, x3
               	cmp	x1, x3
               	b.ne	<addr>
               	lsr	x3, x1, #0
               	sub	x6, x1, x3
               	ldur	x3, [x29, #-0xa0]
               	sdiv	x17, x1, x3
               	msub	x1, x17, x3, x1
               	cmp	x6, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x1
               	str	w0, [x2]
               	mov	x3, #0x0                // =0
               	mov	x7, #-0x8000000000000000 // =-9223372036854775808
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x3
               	cmp	w0, #0x18
               	b.ge	<addr>
               	mov	x4, #-0x1               // =-1
               	stur	x4, [x29, #-0x98]
               	ldr	x1, [x6, x0, lsl #3]
               	cmp	x1, x7
               	b.eq	<addr>
               	sub	x5, x3, x1
               	ldur	x8, [x29, #-0x98]
               	sdiv	x8, x1, x8
               	cmp	x5, x8
               	b.ne	<addr>
               	msub	x5, x5, x4, x1
               	ldur	x4, [x29, #-0x98]
               	sdiv	x17, x1, x4
               	msub	x1, x17, x4, x1
               	cmp	x5, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x1
               	str	w0, [x2]
               	mov	x0, #0x0                // =0
               	mov	x8, #0x5555555555555555 // =6148914691236517205
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	cmp	w0, #0x18
               	b.ge	<addr>
               	mov	x1, #0x1000             // =4096
               	stur	x1, [x29, #-0x90]
               	ldr	x1, [x4, x0, lsl #3]
               	cmp	x1, x8
               	b.eq	<addr>
               	asr	x3, x1, #63
               	lsr	x5, x3, #52
               	add	x6, x1, x5
               	asr	x7, x6, #12
               	ldur	x9, [x29, #-0x90]
               	sdiv	x9, x1, x9
               	cmp	x7, x9
               	b.ne	<addr>
               	lsl	x3, x7, #12
               	sub	x5, x1, x3
               	ldur	x3, [x29, #-0x90]
               	sdiv	x17, x1, x3
               	msub	x1, x17, x3, x1
               	cmp	x5, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x1
               	str	w0, [x2]
               	mov	x0, #0x0                // =0
               	mov	x10, #0x5555555555555555 // =6148914691236517205
               	mov	x6, #-0xffff            // =-65535
               	movk	x6, #0x8000, lsl #16
               	movk	x6, #0x7fff, lsl #48
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	cmp	w0, #0x18
               	b.ge	<addr>
               	mov	x4, #0x100000001        // =4294967297
               	stur	x4, [x29, #-0x88]
               	ldr	x1, [x7, x0, lsl #3]
               	cmp	x1, x10
               	b.eq	<addr>
               	smulh	x8, x1, x6
               	asr	x3, x8, #31
               	lsr	x9, x3, #63
               	add	x5, x3, x9
               	ldur	x11, [x29, #-0x88]
               	sdiv	x11, x1, x11
               	cmp	x5, x11
               	b.ne	<addr>
               	msub	x4, x5, x4, x1
               	ldur	x3, [x29, #-0x88]
               	sdiv	x17, x1, x3
               	msub	x1, x17, x3, x1
               	cmp	x4, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x1
               	str	w0, [x2]
               	mov	x0, #0x0                // =0
               	mov	x6, #0x1                // =1
               	movk	x6, #0x4000, lsl #48
               	mov	x10, #0x5555555555555555 // =6148914691236517205
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	cmp	w0, #0x18
               	b.ge	<addr>
               	mov	x4, #0x7fffffffffffffff // =9223372036854775807
               	stur	x4, [x29, #-0x80]
               	ldr	x1, [x7, x0, lsl #3]
               	cmp	x1, x10
               	b.eq	<addr>
               	smulh	x8, x1, x6
               	asr	x3, x8, #61
               	lsr	x9, x3, #63
               	add	x5, x3, x9
               	ldur	x11, [x29, #-0x80]
               	sdiv	x11, x1, x11
               	cmp	x5, x11
               	b.ne	<addr>
               	msub	x4, x5, x4, x1
               	ldur	x3, [x29, #-0x80]
               	sdiv	x17, x1, x3
               	msub	x1, x17, x3, x1
               	cmp	x4, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x1
               	str	w0, [x2]
               	mov	x3, #0x0                // =0
               	mov	x11, #0x5555555555555555 // =6148914691236517205
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x1, x3
               	cmp	w1, #0x18
               	b.ge	<addr>
               	mov	x4, #-0x8000000000000000 // =-9223372036854775808
               	stur	x4, [x29, #-0x78]
               	ldr	x0, [x6, x1, lsl #3]
               	cmp	x0, x11
               	b.eq	<addr>
               	asr	x7, x0, #63
               	lsr	x8, x7, #1
               	add	x9, x0, x8
               	asr	x10, x9, #63
               	sub	x5, x3, x10
               	ldur	x12, [x29, #-0x78]
               	sdiv	x12, x0, x12
               	cmp	x5, x12
               	b.ne	<addr>
               	msub	x5, x5, x4, x0
               	ldur	x4, [x29, #-0x78]
               	sdiv	x17, x0, x4
               	msub	x0, x17, x4, x0
               	cmp	x5, x0
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x1
               	str	w0, [x2]
               	mov	x0, #0x0                // =0
               	mov	x9, #0x5555555555555555 // =6148914691236517205
               	mov	x5, #0x6667             // =26215
               	movk	x5, #0x6666, lsl #16
               	movk	x5, #0x6666, lsl #32
               	movk	x5, #0x6666, lsl #48
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	cmp	w0, #0x18
               	b.ge	<addr>
               	mov	x3, #0xa                // =10
               	stur	x3, [x29, #-0x70]
               	ldr	x1, [x6, x0, lsl #3]
               	cmp	x1, x9
               	b.eq	<addr>
               	lsr	x7, x1, #1
               	umulh	x8, x7, x5
               	lsr	x4, x8, #1
               	ldur	x10, [x29, #-0x70]
               	udiv	x10, x1, x10
               	cmp	x4, x10
               	b.ne	<addr>
               	msub	x4, x4, x3, x1
               	ldur	x3, [x29, #-0x70]
               	udiv	x17, x1, x3
               	msub	x1, x17, x3, x1
               	cmp	x4, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x1
               	str	w0, [x2]
               	mov	x0, #0x0                // =0
               	mov	x6, #0x2493             // =9363
               	movk	x6, #0x9249, lsl #16
               	movk	x6, #0x4924, lsl #32
               	movk	x6, #0x2492, lsl #48
               	mov	x11, #0x5555555555555555 // =6148914691236517205
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	cmp	w0, #0x18
               	b.ge	<addr>
               	mov	x4, #0x7                // =7
               	stur	x4, [x29, #-0x68]
               	ldr	x1, [x7, x0, lsl #3]
               	cmp	x1, x11
               	b.eq	<addr>
               	umulh	x3, x1, x6
               	sub	x8, x1, x3
               	lsr	x9, x8, #1
               	add	x10, x9, x3
               	lsr	x5, x10, #2
               	ldur	x12, [x29, #-0x68]
               	udiv	x12, x1, x12
               	cmp	x5, x12
               	b.ne	<addr>
               	msub	x4, x5, x4, x1
               	ldur	x3, [x29, #-0x68]
               	udiv	x17, x1, x3
               	msub	x1, x17, x3, x1
               	cmp	x4, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x1
               	str	w0, [x2]
               	mov	x0, #0x0                // =0
               	mov	x5, #0x5555555555555555 // =6148914691236517205
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	cmp	w0, #0x18
               	b.ge	<addr>
               	mov	x1, #0x100000000        // =4294967296
               	stur	x1, [x29, #-0x60]
               	ldr	x1, [x4, x0, lsl #3]
               	cmp	x1, x5
               	b.eq	<addr>
               	lsr	x3, x1, #32
               	ldur	x6, [x29, #-0x60]
               	udiv	x6, x1, x6
               	cmp	x3, x6
               	b.ne	<addr>
               	lsl	x3, x3, #32
               	sub	x6, x1, x3
               	ldur	x3, [x29, #-0x60]
               	udiv	x17, x1, x3
               	msub	x1, x17, x3, x1
               	cmp	x6, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x1
               	str	w0, [x2]
               	mov	x0, #0x0                // =0
               	mov	x6, #0x5555555555555555 // =6148914691236517205
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cmp	w0, #0x18
               	b.ge	<addr>
               	mov	x3, #-0x8000000000000000 // =-9223372036854775808
               	stur	x3, [x29, #-0x58]
               	ldr	x1, [x5, x0, lsl #3]
               	cmp	x1, x6
               	b.eq	<addr>
               	lsr	x4, x1, #63
               	ldur	x7, [x29, #-0x58]
               	udiv	x7, x1, x7
               	cmp	x4, x7
               	b.ne	<addr>
               	msub	x4, x4, x3, x1
               	ldur	x3, [x29, #-0x58]
               	udiv	x17, x1, x3
               	msub	x1, x17, x3, x1
               	cmp	x4, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x1
               	str	w0, [x2]
               	mov	x0, #0x0                // =0
               	mov	x6, #-0x7fffffffffffffff // =-9223372036854775807
               	mov	x7, #0x5555555555555555 // =6148914691236517205
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cmp	w0, #0x18
               	b.ge	<addr>
               	mov	x3, #-0x7fffffffffffffff // =-9223372036854775807
               	stur	x3, [x29, #-0x50]
               	ldr	x1, [x5, x0, lsl #3]
               	cmp	x1, x7
               	b.eq	<addr>
               	cmp	x1, x6
               	cset	x4, hs
               	ldur	x8, [x29, #-0x50]
               	udiv	x8, x1, x8
               	cmp	x4, x8
               	b.ne	<addr>
               	msub	x4, x4, x3, x1
               	ldur	x3, [x29, #-0x50]
               	udiv	x17, x1, x3
               	msub	x1, x17, x3, x1
               	cmp	x4, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x1
               	str	w0, [x2]
               	mov	x0, #0x0                // =0
               	mov	x6, #-0x1               // =-1
               	mov	x7, #0x5555555555555555 // =6148914691236517205
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cmp	w0, #0x18
               	b.ge	<addr>
               	mov	x3, #-0x1               // =-1
               	stur	x3, [x29, #-0x48]
               	ldr	x1, [x5, x0, lsl #3]
               	cmp	x1, x7
               	b.eq	<addr>
               	cmp	x1, x6
               	cset	x4, hs
               	ldur	x8, [x29, #-0x48]
               	udiv	x8, x1, x8
               	cmp	x4, x8
               	b.ne	<addr>
               	msub	x4, x4, x3, x1
               	ldur	x3, [x29, #-0x48]
               	udiv	x17, x1, x3
               	msub	x1, x17, x3, x1
               	cmp	x4, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x1
               	str	w0, [x2]
               	mov	x0, #0x0                // =0
               	mov	x6, #-0x3               // =-3
               	mov	x7, #0x5555555555555555 // =6148914691236517205
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cmp	w0, #0x18
               	b.ge	<addr>
               	mov	x3, #-0x3               // =-3
               	stur	x3, [x29, #-0x40]
               	ldr	x1, [x5, x0, lsl #3]
               	cmp	x1, x7
               	b.eq	<addr>
               	cmp	x1, x6
               	cset	x4, hs
               	ldur	x8, [x29, #-0x40]
               	udiv	x8, x1, x8
               	cmp	x4, x8
               	b.ne	<addr>
               	msub	x4, x4, x3, x1
               	ldur	x3, [x29, #-0x40]
               	udiv	x17, x1, x3
               	msub	x1, x17, x3, x1
               	cmp	x4, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x1
               	str	w0, [x2]
               	mov	x0, #0x0                // =0
               	mov	x10, #0x5555555555555555 // =6148914691236517205
               	mov	x6, #0x6667             // =26215
               	movk	x6, #0x6666, lsl #16
               	movk	x6, #0x6666, lsl #32
               	movk	x6, #0x6666, lsl #48
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	cmp	w0, #0x18
               	b.ge	<addr>
               	mov	x4, #0xa                // =10
               	stur	x4, [x29, #-0x38]
               	ldr	x1, [x7, x0, lsl #3]
               	cmp	x1, x10
               	b.eq	<addr>
               	smulh	x8, x1, x6
               	asr	x3, x8, #2
               	lsr	x9, x3, #63
               	add	x5, x3, x9
               	ldur	x11, [x29, #-0x38]
               	sdiv	x11, x1, x11
               	cmp	x5, x11
               	b.ne	<addr>
               	msub	x4, x5, x4, x1
               	ldur	x3, [x29, #-0x38]
               	sdiv	x17, x1, x3
               	msub	x1, x17, x3, x1
               	cmp	x4, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x1
               	str	w0, [x2]
               	mov	x4, #0x0                // =0
               	mov	x7, #0x4925             // =18725
               	movk	x7, #0x2492, lsl #16
               	movk	x7, #0x9249, lsl #32
               	movk	x7, #0x4924, lsl #48
               	mov	x12, #0x5555555555555555 // =6148914691236517205
               	adrp	x8, <page>
               	add	x8, x8, <lo12>
               	mov	x0, x4
               	cmp	w0, #0x18
               	b.ge	<addr>
               	mov	x5, #-0x7               // =-7
               	stur	x5, [x29, #-0x30]
               	ldr	x1, [x8, x0, lsl #3]
               	cmp	x1, x12
               	b.eq	<addr>
               	smulh	x9, x1, x7
               	asr	x3, x9, #1
               	lsr	x10, x3, #63
               	add	x11, x3, x10
               	sub	x6, x4, x11
               	ldur	x13, [x29, #-0x30]
               	sdiv	x13, x1, x13
               	cmp	x6, x13
               	b.ne	<addr>
               	msub	x5, x6, x5, x1
               	ldur	x3, [x29, #-0x30]
               	sdiv	x17, x1, x3
               	msub	x1, x17, x3, x1
               	cmp	x5, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x1
               	str	w0, [x2]
               	mov	x0, #0x0                // =0
               	mov	x8, #0x5555555555555555 // =6148914691236517205
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	cmp	w0, #0x18
               	b.ge	<addr>
               	mov	x1, #0x40000000         // =1073741824
               	stur	x1, [x29, #-0x28]
               	ldr	x1, [x4, x0, lsl #3]
               	cmp	x1, x8
               	b.eq	<addr>
               	asr	x3, x1, #63
               	lsr	x5, x3, #34
               	add	x6, x1, x5
               	asr	x7, x6, #30
               	ldur	x9, [x29, #-0x28]
               	sdiv	x9, x1, x9
               	cmp	x7, x9
               	b.ne	<addr>
               	lsl	x3, x7, #30
               	sub	x5, x1, x3
               	ldur	x3, [x29, #-0x28]
               	sdiv	x17, x1, x3
               	msub	x1, x17, x3, x1
               	cmp	x5, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x1
               	str	w0, [x2]
               	mov	x3, #0x0                // =0
               	mov	x7, #-0x8000000000000000 // =-9223372036854775808
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x3
               	cmp	w0, #0x18
               	b.ge	<addr>
               	mov	x4, #-0x1               // =-1
               	stur	x4, [x29, #-0x20]
               	ldr	x1, [x6, x0, lsl #3]
               	cmp	x1, x7
               	b.eq	<addr>
               	sub	x5, x3, x1
               	ldur	x8, [x29, #-0x20]
               	sdiv	x8, x1, x8
               	cmp	x5, x8
               	b.ne	<addr>
               	msub	x5, x5, x4, x1
               	ldur	x4, [x29, #-0x20]
               	sdiv	x17, x1, x4
               	msub	x1, x17, x4, x1
               	cmp	x5, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x1
               	str	w0, [x2]
               	mov	x0, #0x0                // =0
               	mov	x9, #0x5555555555555555 // =6148914691236517205
               	mov	x5, #0x6667             // =26215
               	movk	x5, #0x6666, lsl #16
               	movk	x5, #0x6666, lsl #32
               	movk	x5, #0x6666, lsl #48
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	cmp	w0, #0x18
               	b.ge	<addr>
               	mov	x3, #0xa                // =10
               	stur	x3, [x29, #-0x18]
               	ldr	x1, [x6, x0, lsl #3]
               	cmp	x1, x9
               	b.eq	<addr>
               	lsr	x7, x1, #1
               	umulh	x8, x7, x5
               	lsr	x4, x8, #1
               	ldur	x10, [x29, #-0x18]
               	udiv	x10, x1, x10
               	cmp	x4, x10
               	b.ne	<addr>
               	msub	x4, x4, x3, x1
               	ldur	x3, [x29, #-0x18]
               	udiv	x17, x1, x3
               	msub	x1, x17, x3, x1
               	cmp	x4, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x1
               	str	w0, [x2]
               	mov	x0, #0x0                // =0
               	mov	x3, #0x1                // =1
               	movk	x3, #0x8000, lsl #16
               	mov	x5, #-0xffff            // =-65535
               	movk	x5, #0x8000, lsl #16
               	movk	x5, #0x3fff, lsl #48
               	mov	x8, #0x5555555555555555 // =6148914691236517205
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	cmp	w0, #0x18
               	b.ge	<addr>
               	stur	x3, [x29, #-0x10]
               	ldr	x1, [x6, x0, lsl #3]
               	cmp	x1, x8
               	b.eq	<addr>
               	umulh	x7, x1, x5
               	lsr	x4, x7, #29
               	ldur	x9, [x29, #-0x10]
               	udiv	x9, x1, x9
               	cmp	x4, x9
               	b.ne	<addr>
               	msub	x7, x4, x3, x1
               	ldur	x4, [x29, #-0x10]
               	udiv	x17, x1, x4
               	msub	x1, x17, x4, x1
               	cmp	x7, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x1
               	str	w0, [x2]
               	mov	x0, #0x0                // =0
               	mov	x6, #-0x3               // =-3
               	mov	x7, #0x5555555555555555 // =6148914691236517205
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cmp	w0, #0x18
               	b.ge	<addr>
               	mov	x3, #-0x3               // =-3
               	stur	x3, [x29, #-0x8]
               	ldr	x1, [x5, x0, lsl #3]
               	cmp	x1, x7
               	b.eq	<addr>
               	cmp	x1, x6
               	cset	x4, hs
               	ldur	x8, [x29, #-0x8]
               	udiv	x8, x1, x8
               	cmp	x4, x8
               	b.ne	<addr>
               	msub	x4, x4, x3, x1
               	ldur	x3, [x29, #-0x8]
               	udiv	x17, x1, x3
               	msub	x1, x17, x3, x1
               	cmp	x4, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x2]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret

<converted>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x90
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x0, [x3]
               	add	x0, x0, #0x1
               	str	w0, [x3]
               	mov	x0, #0x0                // =0
               	mov	x9, #0x5556             // =21846
               	movk	x9, #0x5555, lsl #16
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	cmp	w0, #0x18
               	b.ge	<addr>
               	mov	x5, #0x3                // =3
               	sturb	w5, [x29, #-0x88]
               	ldr	x1, [x6, x0, lsl #3]
               	sxtb	x1, w1
               	mul	x7, x1, x9
               	asr	x2, x7, #32
               	lsr	x8, x2, #63
               	add	x4, x2, x8
               	ldursb	x10, [x29, #-0x88]
               	sdiv	x10, x1, x10
               	cmp	w4, w10
               	b.ne	<addr>
               	msub	x2, x4, x5, x1
               	sxtw	x4, w2
               	ldursb	x2, [x29, #-0x88]
               	sdiv	x17, x1, x2
               	msub	x1, x17, x2, x1
               	cmp	x4, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x3]
               	add	x0, x0, #0x1
               	str	w0, [x3]
               	mov	x4, #0x0                // =0
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x1, x4
               	cmp	w1, #0x18
               	b.ge	<addr>
               	mov	x5, #-0x80              // =-128
               	sturb	w5, [x29, #-0x80]
               	ldr	x0, [x6, x1, lsl #3]
               	sxtb	x0, w0
               	lsr	x7, x0, #57
               	add	x8, x0, x7
               	asr	x9, x8, #7
               	sub	x2, x4, x9
               	ldursb	x10, [x29, #-0x80]
               	sdiv	x10, x0, x10
               	cmp	w2, w10
               	b.ne	<addr>
               	msub	x2, x2, x5, x0
               	sxtw	x5, w2
               	ldursb	x2, [x29, #-0x80]
               	sdiv	x17, x0, x2
               	msub	x0, x17, x2, x0
               	cmp	x5, x0
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x3]
               	add	x0, x0, #0x1
               	str	w0, [x3]
               	mov	x4, #0x0                // =0
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x4
               	cmp	w0, #0x18
               	b.ge	<addr>
               	mov	x5, #-0x1               // =-1
               	sturb	w5, [x29, #-0x78]
               	ldr	x1, [x6, x0, lsl #3]
               	sxtb	x1, w1
               	sub	x2, x4, x1
               	ldursb	x7, [x29, #-0x78]
               	sdiv	x7, x1, x7
               	cmp	w2, w7
               	b.ne	<addr>
               	msub	x2, x2, x5, x1
               	sxtw	x5, w2
               	ldursb	x2, [x29, #-0x78]
               	sdiv	x17, x1, x2
               	msub	x1, x17, x2, x1
               	cmp	x5, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x3]
               	add	x0, x0, #0x1
               	str	w0, [x3]
               	mov	x1, #0x0                // =0
               	mov	x7, #0x5556             // =21846
               	movk	x7, #0x5555, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cmp	w1, #0x18
               	b.ge	<addr>
               	mov	x4, #0x3                // =3
               	sturb	w4, [x29, #-0x70]
               	ldr	x0, [x5, x1, lsl #3]
               	and	x0, x0, #0xff
               	mul	x6, x0, x7
               	lsr	x2, x6, #32
               	ldurb	w8, [x29, #-0x70]
               	sdiv	x8, x0, x8
               	cmp	w2, w8
               	b.ne	<addr>
               	msub	x2, x2, x4, x0
               	sxtw	x4, w2
               	ldurb	w2, [x29, #-0x70]
               	sdiv	x17, x0, x2
               	msub	x0, x17, x2, x0
               	cmp	x4, x0
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x3]
               	add	x0, x0, #0x1
               	str	w0, [x3]
               	mov	x1, #0x0                // =0
               	mov	x7, #0x102              // =258
               	movk	x7, #0x101, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cmp	w1, #0x18
               	b.ge	<addr>
               	mov	x4, #0xff               // =255
               	sturb	w4, [x29, #-0x68]
               	ldr	x0, [x5, x1, lsl #3]
               	and	x0, x0, #0xff
               	mul	x6, x0, x7
               	lsr	x2, x6, #32
               	ldurb	w8, [x29, #-0x68]
               	sdiv	x8, x0, x8
               	cmp	w2, w8
               	b.ne	<addr>
               	msub	x2, x2, x4, x0
               	sxtw	x4, w2
               	ldurb	w2, [x29, #-0x68]
               	sdiv	x17, x0, x2
               	msub	x0, x17, x2, x0
               	cmp	x4, x0
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x3]
               	add	x0, x0, #0x1
               	str	w0, [x3]
               	mov	x0, #0x0                // =0
               	mov	x9, #0x6667             // =26215
               	movk	x9, #0x6666, lsl #16
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	cmp	w0, #0x18
               	b.ge	<addr>
               	mov	x5, #0xa                // =10
               	sturh	w5, [x29, #-0x60]
               	ldr	x1, [x6, x0, lsl #3]
               	sxth	x1, w1
               	mul	x7, x1, x9
               	asr	x2, x7, #34
               	lsr	x8, x2, #63
               	add	x4, x2, x8
               	ldursh	x10, [x29, #-0x60]
               	sdiv	x10, x1, x10
               	cmp	w4, w10
               	b.ne	<addr>
               	msub	x2, x4, x5, x1
               	sxtw	x4, w2
               	ldursh	x2, [x29, #-0x60]
               	sdiv	x17, x1, x2
               	msub	x1, x17, x2, x1
               	cmp	x4, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x3]
               	add	x0, x0, #0x1
               	str	w0, [x3]
               	mov	x4, #0x0                // =0
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x1, x4
               	cmp	w1, #0x18
               	b.ge	<addr>
               	mov	x5, #-0x8000            // =-32768
               	sturh	w5, [x29, #-0x58]
               	ldr	x0, [x6, x1, lsl #3]
               	sxth	x0, w0
               	lsr	x7, x0, #49
               	add	x8, x0, x7
               	asr	x9, x8, #15
               	sub	x2, x4, x9
               	ldursh	x10, [x29, #-0x58]
               	sdiv	x10, x0, x10
               	cmp	w2, w10
               	b.ne	<addr>
               	msub	x2, x2, x5, x0
               	sxtw	x5, w2
               	ldursh	x2, [x29, #-0x58]
               	sdiv	x17, x0, x2
               	msub	x0, x17, x2, x0
               	cmp	x5, x0
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x3]
               	add	x0, x0, #0x1
               	str	w0, [x3]
               	mov	x0, #0x0                // =0
               	mov	x8, #0xaaab             // =43691
               	movk	x8, #0xaaaa, lsl #16
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	cmp	w0, #0x18
               	b.ge	<addr>
               	mov	x5, #0x3                // =3
               	stur	w5, [x29, #-0x50]
               	ldr	x1, [x6, x0, lsl #3]
               	mov	w2, w1
               	mul	x7, x2, x8
               	lsr	x4, x7, #33
               	ldur	w9, [x29, #-0x50]
               	udiv	x9, x2, x9
               	cmp	w4, w9
               	b.ne	<addr>
               	msub	x4, x4, x5, x2
               	mov	w5, w4
               	ldur	w4, [x29, #-0x50]
               	udiv	x17, x2, x4
               	msub	x1, x17, x4, x2
               	cmp	x5, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x3]
               	add	x0, x0, #0x1
               	str	w0, [x3]
               	mov	x0, #0x0                // =0
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cmp	w0, #0x18
               	b.ge	<addr>
               	mov	x1, #0x80000000         // =2147483648
               	stur	w1, [x29, #-0x48]
               	ldr	x1, [x5, x0, lsl #3]
               	mov	w2, w1
               	lsr	x4, x2, #31
               	ldur	w6, [x29, #-0x48]
               	udiv	x6, x2, x6
               	cmp	w4, w6
               	b.ne	<addr>
               	lsl	x4, x4, #31
               	sub	x4, x2, x4
               	mov	w6, w4
               	ldur	w4, [x29, #-0x48]
               	udiv	x17, x2, x4
               	msub	x1, x17, x4, x2
               	cmp	x6, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x3]
               	add	x0, x0, #0x1
               	str	w0, [x3]
               	mov	x0, #0x0                // =0
               	mov	x5, #0xfffd             // =65533
               	movk	x5, #0xffff, lsl #16
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	cmp	w0, #0x18
               	b.ge	<addr>
               	mov	x1, #-0x3               // =-3
               	stur	w1, [x29, #-0x40]
               	ldr	x1, [x6, x0, lsl #3]
               	mov	w2, w1
               	cmp	x2, x5
               	cset	x4, hs
               	ldur	w7, [x29, #-0x40]
               	udiv	x7, x2, x7
               	cmp	w4, w7
               	b.ne	<addr>
               	msub	x4, x4, x5, x2
               	mov	w7, w4
               	ldur	w4, [x29, #-0x40]
               	udiv	x17, x2, x4
               	msub	x1, x17, x4, x2
               	cmp	x7, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x3]
               	add	x0, x0, #0x1
               	str	w0, [x3]
               	mov	x0, #0x0                // =0
               	mov	x9, #0x5556             // =21846
               	movk	x9, #0x5555, lsl #16
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	cmp	w0, #0x18
               	b.ge	<addr>
               	mov	x4, #0x3                // =3
               	stur	x4, [x29, #-0x38]
               	ldr	x1, [x6, x0, lsl #3]
               	sxtw	x1, w1
               	mul	x7, x1, x9
               	asr	x2, x7, #32
               	lsr	x8, x2, #63
               	add	x5, x2, x8
               	ldur	x10, [x29, #-0x38]
               	sdiv	x10, x1, x10
               	cmp	x5, x10
               	b.ne	<addr>
               	msub	x4, x5, x4, x1
               	ldur	x2, [x29, #-0x38]
               	sdiv	x17, x1, x2
               	msub	x1, x17, x2, x1
               	cmp	x4, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x3]
               	add	x0, x0, #0x1
               	str	w0, [x3]
               	mov	x2, #0x0                // =0
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x2
               	cmp	w0, #0x18
               	b.ge	<addr>
               	mov	x4, #-0x1               // =-1
               	stur	x4, [x29, #-0x30]
               	ldr	x1, [x6, x0, lsl #3]
               	sxtw	x1, w1
               	sub	x5, x2, x1
               	ldur	x7, [x29, #-0x30]
               	sdiv	x7, x1, x7
               	cmp	x5, x7
               	b.ne	<addr>
               	msub	x5, x5, x4, x1
               	ldur	x4, [x29, #-0x30]
               	sdiv	x17, x1, x4
               	msub	x1, x17, x4, x1
               	cmp	x5, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x3]
               	add	x0, x0, #0x1
               	str	w0, [x3]
               	mov	x0, #0x0                // =0
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	cmp	w0, #0x18
               	b.ge	<addr>
               	mov	x1, #0x100000000        // =4294967296
               	stur	x1, [x29, #-0x28]
               	ldr	x1, [x4, x0, lsl #3]
               	sxtw	x1, w1
               	ldur	x2, [x29, #-0x28]
               	sdiv	x2, x1, x2
               	cbnz	x2, <addr>
               	sub	x5, x1, #0x0
               	ldur	x2, [x29, #-0x28]
               	sdiv	x17, x1, x2
               	msub	x1, x17, x2, x1
               	cmp	x5, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x3]
               	add	x0, x0, #0x1
               	str	w0, [x3]
               	mov	x2, #0x0                // =0
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x1, x2
               	cmp	w1, #0x18
               	b.ge	<addr>
               	mov	x4, #-0x80000000        // =-2147483648
               	stur	x4, [x29, #-0x20]
               	ldr	x0, [x6, x1, lsl #3]
               	sxtw	x0, w0
               	lsr	x7, x0, #33
               	add	x8, x0, x7
               	asr	x9, x8, #31
               	sub	x5, x2, x9
               	ldur	x10, [x29, #-0x20]
               	sdiv	x10, x0, x10
               	cmp	x5, x10
               	b.ne	<addr>
               	msub	x5, x5, x4, x0
               	ldur	x4, [x29, #-0x20]
               	sdiv	x17, x0, x4
               	msub	x0, x17, x4, x0
               	cmp	x5, x0
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x3]
               	add	x0, x0, #0x1
               	str	w0, [x3]
               	mov	x0, #0x0                // =0
               	mov	x12, #0x4925            // =18725
               	movk	x12, #0x2492, lsl #16
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	cmp	w0, #0x18
               	b.ge	<addr>
               	mov	x5, #0x7                // =7
               	stur	x5, [x29, #-0x18]
               	ldr	x1, [x7, x0, lsl #3]
               	mov	w2, w1
               	mul	x8, x2, x12
               	lsr	x4, x8, #32
               	sub	x9, x2, x4
               	lsr	x10, x9, #1
               	add	x11, x10, x4
               	lsr	x6, x11, #2
               	ldur	x13, [x29, #-0x18]
               	sdiv	x13, x2, x13
               	cmp	x6, x13
               	b.ne	<addr>
               	msub	x4, x6, x5, x2
               	ldur	x1, [x29, #-0x18]
               	sdiv	x17, x2, x1
               	msub	x1, x17, x1, x2
               	cmp	x4, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x3]
               	add	x0, x0, #0x1
               	str	w0, [x3]
               	mov	x5, #0x0                // =0
               	mov	x8, #0x4925             // =18725
               	movk	x8, #0x2492, lsl #16
               	movk	x8, #0x9249, lsl #32
               	movk	x8, #0x4924, lsl #48
               	adrp	x9, <page>
               	add	x9, x9, <lo12>
               	mov	x0, x5
               	cmp	w0, #0x18
               	b.ge	<addr>
               	mov	x6, #-0x7               // =-7
               	stur	x6, [x29, #-0x10]
               	ldr	x1, [x9, x0, lsl #3]
               	mov	w2, w1
               	smulh	x10, x2, x8
               	asr	x4, x10, #1
               	lsr	x11, x4, #63
               	add	x12, x4, x11
               	sub	x7, x5, x12
               	ldur	x13, [x29, #-0x10]
               	sdiv	x13, x2, x13
               	cmp	x7, x13
               	b.ne	<addr>
               	msub	x4, x7, x6, x2
               	ldur	x1, [x29, #-0x10]
               	sdiv	x17, x2, x1
               	msub	x1, x17, x1, x2
               	cmp	x4, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	ldrsw	x0, [x3]
               	add	x0, x0, #0x1
               	str	w0, [x3]
               	mov	x0, #0x0                // =0
               	mov	x7, #0xffffffff         // =4294967295
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	cmp	w0, #0x18
               	b.ge	<addr>
               	mov	x4, #0xffffffff         // =4294967295
               	stur	x4, [x29, #-0x8]
               	ldr	x1, [x6, x0, lsl #3]
               	mov	w2, w1
               	cmp	x2, x7
               	cset	x5, hs
               	ldur	x8, [x29, #-0x8]
               	sdiv	x8, x2, x8
               	cmp	x5, x8
               	b.ne	<addr>
               	msub	x4, x5, x4, x2
               	ldur	x1, [x29, #-0x8]
               	sdiv	x17, x2, x1
               	msub	x1, x17, x1, x2
               	cmp	x4, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x3]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x3]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x3]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x3]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x3]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x3]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x3]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x3]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x3]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x3]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x3]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x3]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x3]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x3]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x3]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x3]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x3]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x3]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x3]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x3]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x3]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x3]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x3]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x3]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x3]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x3]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x3]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x3]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x3]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x3]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x3]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x3]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x3]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x3]
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
               	add	x3, x1, x2
               	mov	w0, w0
               	mov	x1, #0x3e8              // =1000
               	lsr	x2, x0, #3
               	mov	x17, #0x4dd3            // =19923
               	movk	x17, #0x1062, lsl #16
               	mul	x2, x2, x17
               	lsr	x2, x2, #35
               	msub	x0, x2, x1, x0
               	add	x0, x3, x0
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
               	cmp	w21, #0x18
               	b.ge	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, x21, lsl #3]
               	sxtw	x22, w0
               	mov	x2, #0x3e8              // =1000
               	mov	x1, x23
               	bl	<addr>
               	mov	x2, x0
               	ldursw	x0, [x29, #-0x10]
               	sdiv	x3, x22, x0
               	mov	w1, w22
               	ldur	w0, [x29, #-0x8]
               	udiv	x17, x1, x0
               	msub	x0, x17, x0, x1
               	add	x0, x3, x0
               	sxtw	x0, w0
               	cmp	x2, x0
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
