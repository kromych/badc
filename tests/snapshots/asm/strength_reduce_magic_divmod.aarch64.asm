
strength_reduce_magic_divmod.aarch64:	file format elf64-littleaarch64

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
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	str	x0, [x2]
               	mov	x1, #0x1                // =1
               	str	x1, [x2, #0x8]
               	mov	x1, #-0x1               // =-1
               	str	x1, [x2, #0x10]
               	mov	x1, #0x2                // =2
               	str	x1, [x2, #0x18]
               	mov	x1, #-0x2               // =-2
               	str	x1, [x2, #0x20]
               	mov	x1, #0x7fffffff         // =2147483647
               	str	x1, [x2, #0x28]
               	mov	x1, #-0x80000000        // =-2147483648
               	str	x1, [x2, #0x30]
               	mov	x1, #0x7fffffffffffffff // =9223372036854775807
               	str	x1, [x2, #0x38]
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	str	x1, [x2, #0x40]
               	mov	x1, #0xca07             // =51719
               	movk	x1, #0x3b9a, lsl #16
               	str	x1, [x2, #0x48]
               	mov	x1, #-0xca07            // =-51719
               	movk	x1, #0xc465, lsl #16
               	str	x1, [x2, #0x50]
               	mov	x1, #0xffffffff         // =4294967295
               	str	x1, [x2, #0x58]
               	mov	x3, #0xbc00             // =48128
               	movk	x3, #0xbf46, lsl #16
               	movk	x3, #0xee21, lsl #32
               	movk	x3, #0x2cea, lsl #48
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x3, [x1, #0x60]
               	mov	x3, #0x8d4f             // =36175
               	movk	x3, #0x1a1a, lsl #16
               	movk	x3, #0x754d, lsl #32
               	movk	x3, #0xaa80, lsl #48
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x3, [x1, #0x68]
               	mov	x3, #0x8932             // =35122
               	movk	x3, #0x6d27, lsl #16
               	movk	x3, #0x904a, lsl #32
               	movk	x3, #0xb3c4, lsl #48
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x3, [x1, #0x70]
               	mov	x3, #0x6d19             // =27929
               	movk	x3, #0x7684, lsl #16
               	movk	x3, #0xcf42, lsl #32
               	movk	x3, #0xbc69, lsl #48
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x3, [x1, #0x78]
               	mov	x3, #0x15b4             // =5556
               	movk	x3, #0x6a5b, lsl #16
               	movk	x3, #0x2fd5, lsl #32
               	movk	x3, #0x377b, lsl #48
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x3, [x1, #0x80]
               	mov	x3, #0x9df3             // =40435
               	movk	x3, #0xeaf2, lsl #16
               	movk	x3, #0x15de, lsl #32
               	movk	x3, #0x64d8, lsl #48
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x3, [x1, #0x88]
               	mov	x3, #0xd206             // =53766
               	movk	x3, #0xb2d7, lsl #16
               	movk	x3, #0x100d, lsl #32
               	movk	x3, #0xf66e, lsl #48
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x3, [x1, #0x90]
               	mov	x3, #0x665d             // =26205
               	movk	x3, #0x7e06, lsl #16
               	movk	x3, #0xe6a5, lsl #32
               	movk	x3, #0x1069, lsl #48
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x3, [x1, #0x98]
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cmp	w0, #0x14
               	b.ge	<addr>
               	sxtw	x1, w0
               	lsl	x3, x1, #3
               	add	x7, x6, x3
               	add	x3, x2, x3
               	ldr	x3, [x3]
               	str	x3, [x7]
               	ldr	x3, [x2, x1, lsl #3]
               	str	w3, [x4, x1, lsl #2]
               	ldr	x3, [x2, x1, lsl #3]
               	mov	w3, w3
               	str	w3, [x5, x1, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x14
               	b.lt	<addr>
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x1b0
               	bl	<addr>
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
               	cmp	w1, #0x14
               	b.ge	<addr>
               	mov	x2, #0x3                // =3
               	sub	x17, x29, #0x1a8
               	str	w2, [x17]
               	ldrsw	x2, [x4, w1, sxtw #2]
               	mul	x5, x2, x9
               	asr	x3, x5, #32
               	lsr	x6, x3, #63
               	add	x7, x3, x6
               	sub	x16, x29, #0x1a8
               	ldrsw	x10, [x16]
               	sdiv	x10, x2, x10
               	cmp	x7, x10
               	b.ne	<addr>
               	mul	x3, x7, x8
               	sub	x5, x2, x3
               	sub	x16, x29, #0x1a8
               	ldrsw	x3, [x16]
               	sdiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	cmp	x5, x2
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x14
               	b.lt	<addr>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	mov	x8, #0x5                // =5
               	mov	x9, #0x6667             // =26215
               	movk	x9, #0x6666, lsl #16
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	cmp	w1, #0x14
               	b.ge	<addr>
               	mov	x2, #0x5                // =5
               	sub	x17, x29, #0x1a0
               	str	w2, [x17]
               	ldrsw	x2, [x4, w1, sxtw #2]
               	mul	x5, x2, x9
               	asr	x3, x5, #33
               	lsr	x6, x3, #63
               	add	x7, x3, x6
               	sub	x16, x29, #0x1a0
               	ldrsw	x10, [x16]
               	sdiv	x10, x2, x10
               	cmp	x7, x10
               	b.ne	<addr>
               	mul	x3, x7, x8
               	sub	x5, x2, x3
               	sub	x16, x29, #0x1a0
               	ldrsw	x3, [x16]
               	sdiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	cmp	x5, x2
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x14
               	b.lt	<addr>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	mov	x8, #0x6                // =6
               	mov	x9, #0xaaab             // =43691
               	movk	x9, #0x2aaa, lsl #16
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	cmp	w1, #0x14
               	b.ge	<addr>
               	mov	x2, #0x6                // =6
               	sub	x17, x29, #0x198
               	str	w2, [x17]
               	ldrsw	x2, [x4, w1, sxtw #2]
               	mul	x5, x2, x9
               	asr	x3, x5, #32
               	lsr	x6, x3, #63
               	add	x7, x3, x6
               	sub	x16, x29, #0x198
               	ldrsw	x10, [x16]
               	sdiv	x10, x2, x10
               	cmp	x7, x10
               	b.ne	<addr>
               	mul	x3, x7, x8
               	sub	x5, x2, x3
               	sub	x16, x29, #0x198
               	ldrsw	x3, [x16]
               	sdiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	cmp	x5, x2
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x14
               	b.lt	<addr>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	mov	x8, #0x7                // =7
               	mov	x9, #0x2493             // =9363
               	movk	x9, #0x9249, lsl #16
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	cmp	w1, #0x14
               	b.ge	<addr>
               	mov	x2, #0x7                // =7
               	sub	x17, x29, #0x190
               	str	w2, [x17]
               	ldrsw	x2, [x4, w1, sxtw #2]
               	mul	x5, x2, x9
               	asr	x3, x5, #34
               	lsr	x6, x3, #63
               	add	x7, x3, x6
               	sub	x16, x29, #0x190
               	ldrsw	x10, [x16]
               	sdiv	x10, x2, x10
               	cmp	x7, x10
               	b.ne	<addr>
               	mul	x3, x7, x8
               	sub	x5, x2, x3
               	sub	x16, x29, #0x190
               	ldrsw	x3, [x16]
               	sdiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	cmp	x5, x2
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x14
               	b.lt	<addr>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	mov	x8, #0xa                // =10
               	mov	x9, #0x6667             // =26215
               	movk	x9, #0x6666, lsl #16
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	cmp	w1, #0x14
               	b.ge	<addr>
               	mov	x2, #0xa                // =10
               	sub	x17, x29, #0x188
               	str	w2, [x17]
               	ldrsw	x2, [x4, w1, sxtw #2]
               	mul	x5, x2, x9
               	asr	x3, x5, #34
               	lsr	x6, x3, #63
               	add	x7, x3, x6
               	sub	x16, x29, #0x188
               	ldrsw	x10, [x16]
               	sdiv	x10, x2, x10
               	cmp	x7, x10
               	b.ne	<addr>
               	mul	x3, x7, x8
               	sub	x5, x2, x3
               	sub	x16, x29, #0x188
               	ldrsw	x3, [x16]
               	sdiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	cmp	x5, x2
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x14
               	b.lt	<addr>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	mov	x8, #0x64               // =100
               	mov	x9, #0x851f             // =34079
               	movk	x9, #0x51eb, lsl #16
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	cmp	w1, #0x14
               	b.ge	<addr>
               	mov	x2, #0x64               // =100
               	sub	x17, x29, #0x180
               	str	w2, [x17]
               	ldrsw	x2, [x4, w1, sxtw #2]
               	mul	x5, x2, x9
               	asr	x3, x5, #37
               	lsr	x6, x3, #63
               	add	x7, x3, x6
               	sub	x16, x29, #0x180
               	ldrsw	x10, [x16]
               	sdiv	x10, x2, x10
               	cmp	x7, x10
               	b.ne	<addr>
               	mul	x3, x7, x8
               	sub	x5, x2, x3
               	sub	x16, x29, #0x180
               	ldrsw	x3, [x16]
               	sdiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	cmp	x5, x2
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x14
               	b.lt	<addr>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	mov	x8, #0x3e8              // =1000
               	mov	x9, #0x4dd3             // =19923
               	movk	x9, #0x1062, lsl #16
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	cmp	w1, #0x14
               	b.ge	<addr>
               	mov	x2, #0x3e8              // =1000
               	sub	x17, x29, #0x178
               	str	w2, [x17]
               	ldrsw	x2, [x4, w1, sxtw #2]
               	mul	x5, x2, x9
               	asr	x3, x5, #38
               	lsr	x6, x3, #63
               	add	x7, x3, x6
               	sub	x16, x29, #0x178
               	ldrsw	x10, [x16]
               	sdiv	x10, x2, x10
               	cmp	x7, x10
               	b.ne	<addr>
               	mul	x3, x7, x8
               	sub	x5, x2, x3
               	sub	x16, x29, #0x178
               	ldrsw	x3, [x16]
               	sdiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	cmp	x5, x2
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x14
               	b.lt	<addr>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	mov	x8, #0xffff             // =65535
               	mov	x9, #0x8001             // =32769
               	movk	x9, #0x8000, lsl #16
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	cmp	w1, #0x14
               	b.ge	<addr>
               	mov	x2, #0xffff             // =65535
               	sub	x17, x29, #0x170
               	str	w2, [x17]
               	ldrsw	x2, [x4, w1, sxtw #2]
               	mul	x5, x2, x9
               	asr	x3, x5, #47
               	lsr	x6, x3, #63
               	add	x7, x3, x6
               	sub	x16, x29, #0x170
               	ldrsw	x10, [x16]
               	sdiv	x10, x2, x10
               	cmp	x7, x10
               	b.ne	<addr>
               	mul	x3, x7, x8
               	sub	x5, x2, x3
               	sub	x16, x29, #0x170
               	ldrsw	x3, [x16]
               	sdiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	cmp	x5, x2
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x14
               	b.lt	<addr>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	mov	x4, #0x1                // =1
               	movk	x4, #0x1, lsl #16
               	mov	x9, #0x8001             // =32769
               	movk	x9, #0x7fff, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cmp	w1, #0x14
               	b.ge	<addr>
               	sub	x17, x29, #0x168
               	str	w4, [x17]
               	ldrsw	x2, [x5, w1, sxtw #2]
               	mul	x6, x2, x9
               	asr	x3, x6, #47
               	lsr	x7, x3, #63
               	add	x8, x3, x7
               	sub	x16, x29, #0x168
               	ldrsw	x10, [x16]
               	sdiv	x10, x2, x10
               	cmp	x8, x10
               	b.ne	<addr>
               	mul	x3, x8, x4
               	sub	x6, x2, x3
               	sub	x16, x29, #0x168
               	ldrsw	x3, [x16]
               	sdiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	cmp	x6, x2
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x14
               	b.lt	<addr>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	mov	x8, #0x1                // =1
               	movk	x8, #0x4000, lsl #16
               	mov	x9, #0x7fffffff         // =2147483647
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	cmp	w1, #0x14
               	b.ge	<addr>
               	mov	x2, #0x7fffffff         // =2147483647
               	sub	x17, x29, #0x160
               	str	w2, [x17]
               	ldrsw	x2, [x4, w1, sxtw #2]
               	mul	x5, x2, x8
               	asr	x3, x5, #61
               	lsr	x6, x3, #63
               	add	x7, x3, x6
               	sub	x16, x29, #0x160
               	ldrsw	x10, [x16]
               	sdiv	x10, x2, x10
               	cmp	x7, x10
               	b.ne	<addr>
               	mul	x3, x7, x9
               	sub	x5, x2, x3
               	sub	x16, x29, #0x160
               	ldrsw	x3, [x16]
               	sdiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	cmp	x5, x2
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x14
               	b.lt	<addr>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x4, #0x0                // =0
               	mov	x10, #-0x3              // =-3
               	mov	x11, #0x5556            // =21846
               	movk	x11, #0x5555, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x2, x4
               	cmp	w2, #0x14
               	b.ge	<addr>
               	mov	x1, #-0x3               // =-3
               	sub	x17, x29, #0x158
               	str	w1, [x17]
               	ldrsw	x1, [x5, w2, sxtw #2]
               	mul	x6, x1, x11
               	asr	x3, x6, #32
               	lsr	x7, x3, #63
               	add	x8, x3, x7
               	sub	x9, x4, x8
               	sub	x16, x29, #0x158
               	ldrsw	x12, [x16]
               	sdiv	x12, x1, x12
               	cmp	x9, x12
               	b.ne	<addr>
               	mul	x3, x9, x10
               	sub	x6, x1, x3
               	sub	x16, x29, #0x158
               	ldrsw	x3, [x16]
               	sdiv	x17, x1, x3
               	msub	x1, x17, x3, x1
               	cmp	x6, x1
               	b.ne	<addr>
               	add	x2, x2, #0x1
               	cmp	w2, #0x14
               	b.lt	<addr>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x4, #0x0                // =0
               	mov	x10, #-0x7              // =-7
               	mov	x11, #0x2493            // =9363
               	movk	x11, #0x9249, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x2, x4
               	cmp	w2, #0x14
               	b.ge	<addr>
               	mov	x1, #-0x7               // =-7
               	sub	x17, x29, #0x150
               	str	w1, [x17]
               	ldrsw	x1, [x5, w2, sxtw #2]
               	mul	x6, x1, x11
               	asr	x3, x6, #34
               	lsr	x7, x3, #63
               	add	x8, x3, x7
               	sub	x9, x4, x8
               	sub	x16, x29, #0x150
               	ldrsw	x12, [x16]
               	sdiv	x12, x1, x12
               	cmp	x9, x12
               	b.ne	<addr>
               	mul	x3, x9, x10
               	sub	x6, x1, x3
               	sub	x16, x29, #0x150
               	ldrsw	x3, [x16]
               	sdiv	x17, x1, x3
               	msub	x1, x17, x3, x1
               	cmp	x6, x1
               	b.ne	<addr>
               	add	x2, x2, #0x1
               	cmp	w2, #0x14
               	b.lt	<addr>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x4, #0x0                // =0
               	mov	x10, #-0x64             // =-100
               	mov	x11, #0x851f            // =34079
               	movk	x11, #0x51eb, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x2, x4
               	cmp	w2, #0x14
               	b.ge	<addr>
               	mov	x1, #-0x64              // =-100
               	sub	x17, x29, #0x148
               	str	w1, [x17]
               	ldrsw	x1, [x5, w2, sxtw #2]
               	mul	x6, x1, x11
               	asr	x3, x6, #37
               	lsr	x7, x3, #63
               	add	x8, x3, x7
               	sub	x9, x4, x8
               	sub	x16, x29, #0x148
               	ldrsw	x12, [x16]
               	sdiv	x12, x1, x12
               	cmp	x9, x12
               	b.ne	<addr>
               	mul	x3, x9, x10
               	sub	x6, x1, x3
               	sub	x16, x29, #0x148
               	ldrsw	x3, [x16]
               	sdiv	x17, x1, x3
               	msub	x1, x17, x3, x1
               	cmp	x6, x1
               	b.ne	<addr>
               	add	x2, x2, #0x1
               	cmp	w2, #0x14
               	b.lt	<addr>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x4, #0x0                // =0
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x2, x4
               	cmp	w2, #0x14
               	b.ge	<addr>
               	mov	x1, #-0x80000000        // =-2147483648
               	sub	x17, x29, #0x140
               	str	w1, [x17]
               	ldrsw	x1, [x5, w2, sxtw #2]
               	lsr	x3, x1, #33
               	add	x6, x1, x3
               	asr	x7, x6, #31
               	sub	x7, x4, x7
               	sub	x16, x29, #0x140
               	ldrsw	x8, [x16]
               	sdiv	x8, x1, x8
               	cmp	x7, x8
               	b.ne	<addr>
               	and	x6, x6, #0x7fffffff
               	sub	x6, x6, x3
               	sub	x16, x29, #0x140
               	ldrsw	x3, [x16]
               	sdiv	x17, x1, x3
               	msub	x1, x17, x3, x1
               	cmp	x6, x1
               	b.ne	<addr>
               	add	x2, x2, #0x1
               	cmp	w2, #0x14
               	b.lt	<addr>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	cmp	w1, #0x14
               	b.ge	<addr>
               	mov	x2, #0x1                // =1
               	sub	x17, x29, #0x138
               	str	w2, [x17]
               	ldrsw	x2, [x4, w1, sxtw #2]
               	sub	x16, x29, #0x138
               	ldrsw	x3, [x16]
               	sdiv	x3, x2, x3
               	cmp	x2, x3
               	b.ne	<addr>
               	sub	x16, x29, #0x138
               	ldrsw	x3, [x16]
               	sdiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	cbnz	x2, <addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x14
               	b.lt	<addr>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x2, #0x0                // =0
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	cmp	w2, #0x14
               	b.ge	<addr>
               	mov	x1, #0x8                // =8
               	sub	x17, x29, #0x130
               	str	w1, [x17]
               	ldrsw	x1, [x4, w2, sxtw #2]
               	lsr	x3, x1, #61
               	add	x5, x1, x3
               	asr	x6, x5, #3
               	sub	x16, x29, #0x130
               	ldrsw	x7, [x16]
               	sdiv	x7, x1, x7
               	cmp	x6, x7
               	b.ne	<addr>
               	and	x5, x5, #0x7
               	sub	x5, x5, x3
               	sub	x16, x29, #0x130
               	ldrsw	x3, [x16]
               	sdiv	x17, x1, x3
               	msub	x1, x17, x3, x1
               	cmp	x5, x1
               	b.ne	<addr>
               	add	x2, x2, #0x1
               	cmp	w2, #0x14
               	b.lt	<addr>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x4, #0x0                // =0
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x2, x4
               	cmp	w2, #0x14
               	b.ge	<addr>
               	mov	x1, #-0x8               // =-8
               	sub	x17, x29, #0x128
               	str	w1, [x17]
               	ldrsw	x1, [x5, w2, sxtw #2]
               	lsr	x3, x1, #61
               	add	x6, x1, x3
               	asr	x7, x6, #3
               	sub	x7, x4, x7
               	sub	x16, x29, #0x128
               	ldrsw	x8, [x16]
               	sdiv	x8, x1, x8
               	cmp	x7, x8
               	b.ne	<addr>
               	and	x6, x6, #0x7
               	sub	x6, x6, x3
               	sub	x16, x29, #0x128
               	ldrsw	x3, [x16]
               	sdiv	x17, x1, x3
               	msub	x1, x17, x3, x1
               	cmp	x6, x1
               	b.ne	<addr>
               	add	x2, x2, #0x1
               	cmp	w2, #0x14
               	b.lt	<addr>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x2, #0x0                // =0
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	cmp	w2, #0x14
               	b.ge	<addr>
               	mov	x1, #0x40000000         // =1073741824
               	sub	x17, x29, #0x120
               	str	w1, [x17]
               	ldrsw	x1, [x4, w2, sxtw #2]
               	lsr	x3, x1, #34
               	add	x5, x1, x3
               	asr	x6, x5, #30
               	sub	x16, x29, #0x120
               	ldrsw	x7, [x16]
               	sdiv	x7, x1, x7
               	cmp	x6, x7
               	b.ne	<addr>
               	and	x5, x5, #0x3fffffff
               	sub	x5, x5, x3
               	sub	x16, x29, #0x120
               	ldrsw	x3, [x16]
               	sdiv	x17, x1, x3
               	msub	x1, x17, x3, x1
               	cmp	x5, x1
               	b.ne	<addr>
               	add	x2, x2, #0x1
               	cmp	w2, #0x14
               	b.lt	<addr>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	mov	x6, #0x3                // =3
               	mov	x7, #0xaaab             // =43691
               	movk	x7, #0xaaaa, lsl #16
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	cmp	w1, #0x14
               	b.ge	<addr>
               	mov	x2, #0x3                // =3
               	sub	x17, x29, #0x118
               	str	w2, [x17]
               	ldr	w2, [x4, w1, sxtw #2]
               	mul	x3, x2, x7
               	lsr	x5, x3, #33
               	sub	x16, x29, #0x118
               	ldr	w8, [x16]
               	udiv	x8, x2, x8
               	cmp	x5, x8
               	b.ne	<addr>
               	mul	x3, x5, x6
               	sub	x5, x2, x3
               	sub	x16, x29, #0x118
               	ldr	w3, [x16]
               	udiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	cmp	x5, x2
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x14
               	b.lt	<addr>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x2, #0x0                // =0
               	mov	x10, #0x7               // =7
               	mov	x11, #0x4925            // =18725
               	movk	x11, #0x2492, lsl #16
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	cmp	w2, #0x14
               	b.ge	<addr>
               	mov	x1, #0x7                // =7
               	sub	x17, x29, #0x110
               	str	w1, [x17]
               	ldr	w1, [x4, w2, sxtw #2]
               	mul	x5, x1, x11
               	lsr	x3, x5, #32
               	sub	x6, x1, x3
               	lsr	x7, x6, #1
               	add	x8, x7, x3
               	lsr	x9, x8, #2
               	sub	x16, x29, #0x110
               	ldr	w12, [x16]
               	udiv	x12, x1, x12
               	cmp	x9, x12
               	b.ne	<addr>
               	mul	x3, x9, x10
               	sub	x5, x1, x3
               	sub	x16, x29, #0x110
               	ldr	w3, [x16]
               	udiv	x17, x1, x3
               	msub	x1, x17, x3, x1
               	cmp	x5, x1
               	b.ne	<addr>
               	add	x2, x2, #0x1
               	cmp	w2, #0x14
               	b.lt	<addr>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	mov	x7, #0xa                // =10
               	mov	x8, #0x6667             // =26215
               	movk	x8, #0x6666, lsl #16
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	cmp	w1, #0x14
               	b.ge	<addr>
               	mov	x2, #0xa                // =10
               	sub	x17, x29, #0x108
               	str	w2, [x17]
               	ldr	w2, [x4, w1, sxtw #2]
               	lsr	x3, x2, #1
               	mul	x5, x3, x8
               	lsr	x6, x5, #33
               	sub	x16, x29, #0x108
               	ldr	w9, [x16]
               	udiv	x9, x2, x9
               	cmp	x6, x9
               	b.ne	<addr>
               	mul	x3, x6, x7
               	sub	x5, x2, x3
               	sub	x16, x29, #0x108
               	ldr	w3, [x16]
               	udiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	cmp	x5, x2
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x14
               	b.lt	<addr>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	mov	x7, #0xe                // =14
               	mov	x8, #0x2493             // =9363
               	movk	x8, #0x9249, lsl #16
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	cmp	w1, #0x14
               	b.ge	<addr>
               	mov	x2, #0xe                // =14
               	stur	w2, [x29, #-0x100]
               	ldr	w2, [x4, w1, sxtw #2]
               	lsr	x3, x2, #1
               	mul	x5, x3, x8
               	lsr	x6, x5, #34
               	ldur	w9, [x29, #-0x100]
               	udiv	x9, x2, x9
               	cmp	x6, x9
               	b.ne	<addr>
               	mul	x3, x6, x7
               	sub	x5, x2, x3
               	ldur	w3, [x29, #-0x100]
               	udiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	cmp	x5, x2
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x14
               	b.lt	<addr>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	mov	x7, #0x64               // =100
               	mov	x8, #0x70a4             // =28836
               	movk	x8, #0xa3d, lsl #16
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	cmp	w1, #0x14
               	b.ge	<addr>
               	mov	x2, #0x64               // =100
               	stur	w2, [x29, #-0xf8]
               	ldr	w2, [x4, w1, sxtw #2]
               	lsr	x3, x2, #2
               	mul	x5, x3, x8
               	lsr	x6, x5, #32
               	ldur	w9, [x29, #-0xf8]
               	udiv	x9, x2, x9
               	cmp	x6, x9
               	b.ne	<addr>
               	mul	x3, x6, x7
               	sub	x5, x2, x3
               	ldur	w3, [x29, #-0xf8]
               	udiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	cmp	x5, x2
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x14
               	b.lt	<addr>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	mov	x7, #0x3e8              // =1000
               	mov	x8, #0x4dd3             // =19923
               	movk	x8, #0x1062, lsl #16
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	cmp	w1, #0x14
               	b.ge	<addr>
               	mov	x2, #0x3e8              // =1000
               	stur	w2, [x29, #-0xf0]
               	ldr	w2, [x4, w1, sxtw #2]
               	lsr	x3, x2, #3
               	mul	x5, x3, x8
               	lsr	x6, x5, #35
               	ldur	w9, [x29, #-0xf0]
               	udiv	x9, x2, x9
               	cmp	x6, x9
               	b.ne	<addr>
               	mul	x3, x6, x7
               	sub	x5, x2, x3
               	ldur	w3, [x29, #-0xf0]
               	udiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	cmp	x5, x2
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x14
               	b.lt	<addr>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x2, #0x0                // =0
               	mov	x10, #0x3               // =3
               	mov	x11, #0x7fffffff        // =2147483647
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	cmp	w2, #0x14
               	b.ge	<addr>
               	mov	x1, #0x7fffffff         // =2147483647
               	stur	w1, [x29, #-0xe8]
               	ldr	w1, [x4, w2, sxtw #2]
               	mul	x5, x1, x10
               	lsr	x3, x5, #32
               	sub	x6, x1, x3
               	lsr	x7, x6, #1
               	add	x8, x7, x3
               	lsr	x9, x8, #30
               	ldur	w12, [x29, #-0xe8]
               	udiv	x12, x1, x12
               	cmp	x9, x12
               	b.ne	<addr>
               	mul	x3, x9, x11
               	sub	x5, x1, x3
               	ldur	w3, [x29, #-0xe8]
               	udiv	x17, x1, x3
               	msub	x1, x17, x3, x1
               	cmp	x5, x1
               	b.ne	<addr>
               	add	x2, x2, #0x1
               	cmp	w2, #0x14
               	b.lt	<addr>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	mov	x3, #0x1                // =1
               	movk	x3, #0x8000, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cmp	w1, #0x14
               	b.ge	<addr>
               	stur	w3, [x29, #-0xe0]
               	ldr	w2, [x5, w1, sxtw #2]
               	cmp	w2, w3
               	cset	x4, hs
               	ldur	w6, [x29, #-0xe0]
               	udiv	x6, x2, x6
               	cmp	x4, x6
               	b.ne	<addr>
               	mul	x4, x4, x3
               	sub	x6, x2, x4
               	ldur	w4, [x29, #-0xe0]
               	udiv	x17, x2, x4
               	msub	x2, x17, x4, x2
               	cmp	x6, x2
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x14
               	b.lt	<addr>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	mov	x3, #0xfffb             // =65531
               	movk	x3, #0xffff, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cmp	w1, #0x14
               	b.ge	<addr>
               	stur	w3, [x29, #-0xd8]
               	ldr	w2, [x5, w1, sxtw #2]
               	cmp	w2, w3
               	cset	x4, hs
               	ldur	w6, [x29, #-0xd8]
               	udiv	x6, x2, x6
               	cmp	x4, x6
               	b.ne	<addr>
               	mul	x4, x4, x3
               	sub	x6, x2, x4
               	ldur	w4, [x29, #-0xd8]
               	udiv	x17, x2, x4
               	msub	x2, x17, x4, x2
               	cmp	x6, x2
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x14
               	b.lt	<addr>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	cmp	w1, #0x14
               	b.ge	<addr>
               	mov	x2, #0x1                // =1
               	stur	w2, [x29, #-0xd0]
               	ldr	w2, [x4, w1, sxtw #2]
               	ldur	w3, [x29, #-0xd0]
               	udiv	x3, x2, x3
               	cmp	x2, x3
               	b.ne	<addr>
               	ldur	w3, [x29, #-0xd0]
               	udiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	cbnz	x2, <addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x14
               	b.lt	<addr>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	cmp	w1, #0x14
               	b.ge	<addr>
               	mov	x2, #0x10               // =16
               	stur	w2, [x29, #-0xc8]
               	ldr	w2, [x4, w1, sxtw #2]
               	lsr	x3, x2, #4
               	ldur	w5, [x29, #-0xc8]
               	udiv	x5, x2, x5
               	cmp	x3, x5
               	b.ne	<addr>
               	and	x5, x2, #0xf
               	ldur	w3, [x29, #-0xc8]
               	udiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	cmp	x5, x2
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x14
               	b.lt	<addr>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	mov	x8, #0x3                // =3
               	mov	x4, #0x5556             // =21846
               	movk	x4, #0x5555, lsl #16
               	movk	x4, #0x5555, lsl #32
               	movk	x4, #0x5555, lsl #48
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cmp	w1, #0x14
               	b.ge	<addr>
               	mov	x2, #0x3                // =3
               	stur	x2, [x29, #-0xc0]
               	ldr	x2, [x5, w1, sxtw #3]
               	smulh	x3, x2, x4
               	lsr	x6, x3, #63
               	add	x7, x3, x6
               	ldur	x9, [x29, #-0xc0]
               	sdiv	x9, x2, x9
               	cmp	x7, x9
               	b.ne	<addr>
               	mul	x3, x7, x8
               	sub	x6, x2, x3
               	ldur	x3, [x29, #-0xc0]
               	sdiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	cmp	x6, x2
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x14
               	b.lt	<addr>
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
               	cmp	w1, #0x14
               	b.ge	<addr>
               	mov	x2, #0x7                // =7
               	stur	x2, [x29, #-0xb8]
               	ldr	x2, [x5, w1, sxtw #3]
               	smulh	x6, x2, x4
               	asr	x3, x6, #1
               	lsr	x7, x3, #63
               	add	x8, x3, x7
               	ldur	x10, [x29, #-0xb8]
               	sdiv	x10, x2, x10
               	cmp	x8, x10
               	b.ne	<addr>
               	mul	x3, x8, x9
               	sub	x6, x2, x3
               	ldur	x3, [x29, #-0xb8]
               	sdiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	cmp	x6, x2
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x14
               	b.lt	<addr>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	mov	x9, #0xa                // =10
               	mov	x4, #0x6667             // =26215
               	movk	x4, #0x6666, lsl #16
               	movk	x4, #0x6666, lsl #32
               	movk	x4, #0x6666, lsl #48
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cmp	w1, #0x14
               	b.ge	<addr>
               	mov	x2, #0xa                // =10
               	stur	x2, [x29, #-0xb0]
               	ldr	x2, [x5, w1, sxtw #3]
               	smulh	x6, x2, x4
               	asr	x3, x6, #2
               	lsr	x7, x3, #63
               	add	x8, x3, x7
               	ldur	x10, [x29, #-0xb0]
               	sdiv	x10, x2, x10
               	cmp	x8, x10
               	b.ne	<addr>
               	mul	x3, x8, x9
               	sub	x6, x2, x3
               	ldur	x3, [x29, #-0xb0]
               	sdiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	cmp	x6, x2
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x14
               	b.lt	<addr>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	mov	x9, #0x3e8              // =1000
               	mov	x4, #0xf7cf             // =63439
               	movk	x4, #0xe353, lsl #16
               	movk	x4, #0x9ba5, lsl #32
               	movk	x4, #0x20c4, lsl #48
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cmp	w1, #0x14
               	b.ge	<addr>
               	mov	x2, #0x3e8              // =1000
               	stur	x2, [x29, #-0xa8]
               	ldr	x2, [x5, w1, sxtw #3]
               	smulh	x6, x2, x4
               	asr	x3, x6, #7
               	lsr	x7, x3, #63
               	add	x8, x3, x7
               	ldur	x10, [x29, #-0xa8]
               	sdiv	x10, x2, x10
               	cmp	x8, x10
               	b.ne	<addr>
               	mul	x3, x8, x9
               	sub	x6, x2, x3
               	ldur	x3, [x29, #-0xa8]
               	sdiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	cmp	x6, x2
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x14
               	b.lt	<addr>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	mov	x4, #0x8fe5             // =36837
               	movk	x4, #0x12a2, lsl #16
               	movk	x4, #0x5f31, lsl #32
               	movk	x4, #0x8970, lsl #48
               	mov	x5, #0xca07             // =51719
               	movk	x5, #0x3b9a, lsl #16
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	cmp	w1, #0x14
               	b.ge	<addr>
               	stur	x5, [x29, #-0xa0]
               	ldr	x2, [x6, w1, sxtw #3]
               	smulh	x7, x2, x4
               	add	x8, x7, x2
               	asr	x3, x8, #29
               	lsr	x9, x3, #63
               	add	x10, x3, x9
               	ldur	x11, [x29, #-0xa0]
               	sdiv	x11, x2, x11
               	cmp	x10, x11
               	b.ne	<addr>
               	mul	x3, x10, x5
               	sub	x7, x2, x3
               	ldur	x3, [x29, #-0xa0]
               	sdiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	cmp	x7, x2
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x14
               	b.lt	<addr>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	mov	x4, #0x1                // =1
               	movk	x4, #0x4000, lsl #48
               	mov	x9, #0x7fffffffffffffff // =9223372036854775807
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cmp	w1, #0x14
               	b.ge	<addr>
               	mov	x2, #0x7fffffffffffffff // =9223372036854775807
               	stur	x2, [x29, #-0x98]
               	ldr	x2, [x5, w1, sxtw #3]
               	smulh	x6, x2, x4
               	asr	x3, x6, #61
               	lsr	x7, x3, #63
               	add	x8, x3, x7
               	ldur	x10, [x29, #-0x98]
               	sdiv	x10, x2, x10
               	cmp	x8, x10
               	b.ne	<addr>
               	mul	x3, x8, x9
               	sub	x6, x2, x3
               	ldur	x3, [x29, #-0x98]
               	sdiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	cmp	x6, x2
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x14
               	b.lt	<addr>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x4, #0x0                // =0
               	mov	x10, #-0x3              // =-3
               	mov	x5, #0x5556             // =21846
               	movk	x5, #0x5555, lsl #16
               	movk	x5, #0x5555, lsl #32
               	movk	x5, #0x5555, lsl #48
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x1, x4
               	cmp	w1, #0x14
               	b.ge	<addr>
               	mov	x2, #-0x3               // =-3
               	stur	x2, [x29, #-0x90]
               	ldr	x2, [x6, w1, sxtw #3]
               	smulh	x3, x2, x5
               	lsr	x7, x3, #63
               	add	x8, x3, x7
               	sub	x9, x4, x8
               	ldur	x11, [x29, #-0x90]
               	sdiv	x11, x2, x11
               	cmp	x9, x11
               	b.ne	<addr>
               	mul	x3, x9, x10
               	sub	x7, x2, x3
               	ldur	x3, [x29, #-0x90]
               	sdiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	cmp	x7, x2
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x14
               	b.lt	<addr>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x4, #0x0                // =0
               	mov	x11, #-0x7              // =-7
               	mov	x5, #0x4925             // =18725
               	movk	x5, #0x2492, lsl #16
               	movk	x5, #0x9249, lsl #32
               	movk	x5, #0x4924, lsl #48
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x1, x4
               	cmp	w1, #0x14
               	b.ge	<addr>
               	mov	x2, #-0x7               // =-7
               	stur	x2, [x29, #-0x88]
               	ldr	x2, [x6, w1, sxtw #3]
               	smulh	x7, x2, x5
               	asr	x3, x7, #1
               	lsr	x8, x3, #63
               	add	x9, x3, x8
               	sub	x10, x4, x9
               	ldur	x12, [x29, #-0x88]
               	sdiv	x12, x2, x12
               	cmp	x10, x12
               	b.ne	<addr>
               	mul	x3, x10, x11
               	sub	x7, x2, x3
               	ldur	x3, [x29, #-0x88]
               	sdiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	cmp	x7, x2
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x14
               	b.lt	<addr>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x4, #0x0                // =0
               	mov	x5, #0x8fe5             // =36837
               	movk	x5, #0x12a2, lsl #16
               	movk	x5, #0x5f31, lsl #32
               	movk	x5, #0x8970, lsl #48
               	mov	x6, #-0xca07            // =-51719
               	movk	x6, #0xc465, lsl #16
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	mov	x2, x4
               	cmp	w2, #0x14
               	b.ge	<addr>
               	stur	x6, [x29, #-0x80]
               	ldr	x1, [x7, w2, sxtw #3]
               	smulh	x8, x1, x5
               	add	x9, x8, x1
               	asr	x3, x9, #29
               	lsr	x10, x3, #63
               	add	x11, x3, x10
               	sub	x12, x4, x11
               	ldur	x13, [x29, #-0x80]
               	sdiv	x13, x1, x13
               	cmp	x12, x13
               	b.ne	<addr>
               	mul	x3, x12, x6
               	sub	x8, x1, x3
               	ldur	x3, [x29, #-0x80]
               	sdiv	x17, x1, x3
               	msub	x1, x17, x3, x1
               	cmp	x8, x1
               	b.ne	<addr>
               	add	x2, x2, #0x1
               	cmp	w2, #0x14
               	b.lt	<addr>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x4, #0x0                // =0
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, x4
               	cmp	w1, #0x14
               	b.ge	<addr>
               	mov	x2, #-0x8000000000000000 // =-9223372036854775808
               	stur	x2, [x29, #-0x78]
               	ldr	x2, [x5, w1, sxtw #3]
               	asr	x6, x2, #63
               	lsr	x3, x6, #1
               	add	x7, x2, x3
               	asr	x8, x7, #63
               	sub	x8, x4, x8
               	ldur	x9, [x29, #-0x78]
               	sdiv	x9, x2, x9
               	cmp	x8, x9
               	b.ne	<addr>
               	and	x6, x7, #0x7fffffffffffffff
               	sub	x6, x6, x3
               	ldur	x3, [x29, #-0x78]
               	sdiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	cmp	x6, x2
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x14
               	b.lt	<addr>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	cmp	w1, #0x14
               	b.ge	<addr>
               	mov	x2, #0x1                // =1
               	stur	x2, [x29, #-0x70]
               	ldr	x2, [x4, w1, sxtw #3]
               	ldur	x3, [x29, #-0x70]
               	sdiv	x3, x2, x3
               	cmp	x2, x3
               	b.ne	<addr>
               	ldur	x3, [x29, #-0x70]
               	sdiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	cbnz	x2, <addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x14
               	b.lt	<addr>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	cmp	w1, #0x14
               	b.ge	<addr>
               	mov	x2, #0x400              // =1024
               	stur	x2, [x29, #-0x68]
               	ldr	x2, [x4, w1, sxtw #3]
               	asr	x5, x2, #63
               	lsr	x3, x5, #54
               	add	x6, x2, x3
               	asr	x7, x6, #10
               	ldur	x8, [x29, #-0x68]
               	sdiv	x8, x2, x8
               	cmp	x7, x8
               	b.ne	<addr>
               	and	x5, x6, #0x3ff
               	sub	x5, x5, x3
               	ldur	x3, [x29, #-0x68]
               	sdiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	cmp	x5, x2
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x14
               	b.lt	<addr>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x4, #0x0                // =0
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, x4
               	cmp	w1, #0x14
               	b.ge	<addr>
               	mov	x2, #-0x400             // =-1024
               	stur	x2, [x29, #-0x60]
               	ldr	x2, [x5, w1, sxtw #3]
               	asr	x6, x2, #63
               	lsr	x3, x6, #54
               	add	x7, x2, x3
               	asr	x8, x7, #10
               	sub	x8, x4, x8
               	ldur	x9, [x29, #-0x60]
               	sdiv	x9, x2, x9
               	cmp	x8, x9
               	b.ne	<addr>
               	and	x6, x7, #0x3ff
               	sub	x6, x6, x3
               	ldur	x3, [x29, #-0x60]
               	sdiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	cmp	x6, x2
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x14
               	b.lt	<addr>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	mov	x4, #0xaaab             // =43691
               	movk	x4, #0xaaaa, lsl #16
               	movk	x4, #0xaaaa, lsl #32
               	movk	x4, #0xaaaa, lsl #48
               	mov	x7, #0x3                // =3
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cmp	w1, #0x14
               	b.ge	<addr>
               	mov	x2, #0x3                // =3
               	stur	x2, [x29, #-0x58]
               	ldr	x2, [x5, w1, sxtw #3]
               	umulh	x3, x2, x4
               	lsr	x6, x3, #1
               	ldur	x8, [x29, #-0x58]
               	udiv	x8, x2, x8
               	cmp	x6, x8
               	b.ne	<addr>
               	mul	x3, x6, x7
               	sub	x6, x2, x3
               	ldur	x3, [x29, #-0x58]
               	udiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	cmp	x6, x2
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x14
               	b.lt	<addr>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	mov	x10, #0x7               // =7
               	mov	x4, #0x2493             // =9363
               	movk	x4, #0x9249, lsl #16
               	movk	x4, #0x4924, lsl #32
               	movk	x4, #0x2492, lsl #48
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cmp	w1, #0x14
               	b.ge	<addr>
               	mov	x2, #0x7                // =7
               	stur	x2, [x29, #-0x50]
               	ldr	x2, [x5, w1, sxtw #3]
               	umulh	x3, x2, x4
               	sub	x6, x2, x3
               	lsr	x7, x6, #1
               	add	x8, x7, x3
               	lsr	x9, x8, #2
               	ldur	x11, [x29, #-0x50]
               	udiv	x11, x2, x11
               	cmp	x9, x11
               	b.ne	<addr>
               	mul	x3, x9, x10
               	sub	x6, x2, x3
               	ldur	x3, [x29, #-0x50]
               	udiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	cmp	x6, x2
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x14
               	b.lt	<addr>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	mov	x8, #0xa                // =10
               	mov	x4, #0x6667             // =26215
               	movk	x4, #0x6666, lsl #16
               	movk	x4, #0x6666, lsl #32
               	movk	x4, #0x6666, lsl #48
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cmp	w1, #0x14
               	b.ge	<addr>
               	mov	x2, #0xa                // =10
               	stur	x2, [x29, #-0x48]
               	ldr	x2, [x5, w1, sxtw #3]
               	lsr	x3, x2, #1
               	umulh	x6, x3, x4
               	lsr	x7, x6, #1
               	ldur	x9, [x29, #-0x48]
               	udiv	x9, x2, x9
               	cmp	x7, x9
               	b.ne	<addr>
               	mul	x3, x7, x8
               	sub	x6, x2, x3
               	ldur	x3, [x29, #-0x48]
               	udiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	cmp	x6, x2
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x14
               	b.lt	<addr>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	mov	x8, #0xe                // =14
               	mov	x4, #0x4925             // =18725
               	movk	x4, #0x2492, lsl #16
               	movk	x4, #0x9249, lsl #32
               	movk	x4, #0x4924, lsl #48
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cmp	w1, #0x14
               	b.ge	<addr>
               	mov	x2, #0xe                // =14
               	stur	x2, [x29, #-0x40]
               	ldr	x2, [x5, w1, sxtw #3]
               	lsr	x3, x2, #1
               	umulh	x6, x3, x4
               	lsr	x7, x6, #1
               	ldur	x9, [x29, #-0x40]
               	udiv	x9, x2, x9
               	cmp	x7, x9
               	b.ne	<addr>
               	mul	x3, x7, x8
               	sub	x6, x2, x3
               	ldur	x3, [x29, #-0x40]
               	udiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	cmp	x6, x2
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x14
               	b.lt	<addr>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	mov	x4, #0x8fe5             // =36837
               	movk	x4, #0x12a2, lsl #16
               	movk	x4, #0x5f31, lsl #32
               	movk	x4, #0x8970, lsl #48
               	mov	x5, #0xca07             // =51719
               	movk	x5, #0x3b9a, lsl #16
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	cmp	w1, #0x14
               	b.ge	<addr>
               	stur	x5, [x29, #-0x38]
               	ldr	x2, [x6, w1, sxtw #3]
               	umulh	x3, x2, x4
               	lsr	x7, x3, #29
               	ldur	x8, [x29, #-0x38]
               	udiv	x8, x2, x8
               	cmp	x7, x8
               	b.ne	<addr>
               	mul	x3, x7, x5
               	sub	x7, x2, x3
               	ldur	x3, [x29, #-0x38]
               	udiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	cmp	x7, x2
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x14
               	b.lt	<addr>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	mov	x4, #-0x7fffffffffffffff // =-9223372036854775807
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cmp	w1, #0x14
               	b.ge	<addr>
               	mov	x2, #-0x7fffffffffffffff // =-9223372036854775807
               	stur	x2, [x29, #-0x30]
               	ldr	x2, [x5, w1, sxtw #3]
               	cmp	x2, x4
               	cset	x3, hs
               	ldur	x6, [x29, #-0x30]
               	udiv	x6, x2, x6
               	cmp	x3, x6
               	b.ne	<addr>
               	mul	x3, x3, x4
               	sub	x6, x2, x3
               	ldur	x3, [x29, #-0x30]
               	udiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	cmp	x6, x2
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x14
               	b.lt	<addr>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	mov	x4, #-0x5               // =-5
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cmp	w1, #0x14
               	b.ge	<addr>
               	mov	x2, #-0x5               // =-5
               	stur	x2, [x29, #-0x28]
               	ldr	x2, [x5, w1, sxtw #3]
               	cmp	x2, x4
               	cset	x3, hs
               	ldur	x6, [x29, #-0x28]
               	udiv	x6, x2, x6
               	cmp	x3, x6
               	b.ne	<addr>
               	mul	x3, x3, x4
               	sub	x6, x2, x3
               	ldur	x3, [x29, #-0x28]
               	udiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	cmp	x6, x2
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x14
               	b.lt	<addr>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	cmp	w1, #0x14
               	b.ge	<addr>
               	mov	x2, #0x1                // =1
               	stur	x2, [x29, #-0x20]
               	ldr	x2, [x4, w1, sxtw #3]
               	ldur	x3, [x29, #-0x20]
               	udiv	x3, x2, x3
               	cmp	x2, x3
               	b.ne	<addr>
               	ldur	x3, [x29, #-0x20]
               	udiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	cbnz	x2, <addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x14
               	b.lt	<addr>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	cmp	w1, #0x14
               	b.ge	<addr>
               	mov	x2, #0x400              // =1024
               	stur	x2, [x29, #-0x18]
               	ldr	x2, [x4, w1, sxtw #3]
               	lsr	x3, x2, #10
               	ldur	x5, [x29, #-0x18]
               	udiv	x5, x2, x5
               	cmp	x3, x5
               	b.ne	<addr>
               	and	x5, x2, #0x3ff
               	ldur	x3, [x29, #-0x18]
               	udiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	cmp	x5, x2
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x14
               	b.lt	<addr>
               	mov	x0, #-0x3039            // =-12345
               	stur	w0, [x29, #-0x10]
               	mov	x0, #-0x4cb             // =-1227
               	movk	x0, #0x8e04, lsl #16
               	movk	x0, #0xfee0, lsl #32
               	stur	x0, [x29, #-0x8]
               	ldursw	x1, [x29, #-0x10]
               	mov	x0, #0x0                // =0
               	sub	x1, x0, x1
               	mov	x17, #0x3039            // =12345
               	cmp	x1, x17
               	b.ne	<addr>
               	ldursw	x1, [x29, #-0x10]
               	ldur	x1, [x29, #-0x8]
               	sub	x1, x0, x1
               	mov	x17, #0x4cb             // =1227
               	movk	x17, #0x71fb, lsl #16
               	movk	x17, #0x11f, lsl #32
               	cmp	x1, x17
               	b.ne	<addr>
               	ldur	x1, [x29, #-0x8]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5b               // =91
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5a               // =90
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
