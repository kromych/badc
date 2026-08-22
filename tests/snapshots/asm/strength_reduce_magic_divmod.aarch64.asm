
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
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	str	x0, [x1]
               	mov	x0, #0x1                // =1
               	str	x0, [x1, #0x8]
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	str	x0, [x1, #0x10]
               	mov	x0, #0x2                // =2
               	str	x0, [x1, #0x18]
               	mov	x0, #0xfffe             // =65534
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	str	x0, [x1, #0x20]
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0x7fff, lsl #16
               	str	x0, [x1, #0x28]
               	mov	x0, #0x80000000         // =2147483648
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	str	x0, [x1, #0x30]
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0x7fff, lsl #48
               	str	x0, [x1, #0x38]
               	mov	x0, #-0x8000000000000000 // =-9223372036854775808
               	str	x0, [x1, #0x40]
               	mov	x0, #0xca07             // =51719
               	movk	x0, #0x3b9a, lsl #16
               	str	x0, [x1, #0x48]
               	mov	x0, #0x35f9             // =13817
               	movk	x0, #0xc465, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	str	x0, [x1, #0x50]
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	str	x0, [x1, #0x58]
               	mov	x0, #0xbc00             // =48128
               	movk	x0, #0xbf46, lsl #16
               	movk	x0, #0xee21, lsl #32
               	movk	x0, #0x2cea, lsl #48
               	str	x0, [x1, #0x60]
               	mov	x0, #0x8d4f             // =36175
               	movk	x0, #0x1a1a, lsl #16
               	movk	x0, #0x754d, lsl #32
               	movk	x0, #0xaa80, lsl #48
               	str	x0, [x1, #0x68]
               	mov	x0, #0x8932             // =35122
               	movk	x0, #0x6d27, lsl #16
               	movk	x0, #0x904a, lsl #32
               	movk	x0, #0xb3c4, lsl #48
               	str	x0, [x1, #0x70]
               	mov	x0, #0x6d19             // =27929
               	movk	x0, #0x7684, lsl #16
               	movk	x0, #0xcf42, lsl #32
               	movk	x0, #0xbc69, lsl #48
               	str	x0, [x1, #0x78]
               	mov	x0, #0x15b4             // =5556
               	movk	x0, #0x6a5b, lsl #16
               	movk	x0, #0x2fd5, lsl #32
               	movk	x0, #0x377b, lsl #48
               	str	x0, [x1, #0x80]
               	mov	x0, #0x9df3             // =40435
               	movk	x0, #0xeaf2, lsl #16
               	movk	x0, #0x15de, lsl #32
               	movk	x0, #0x64d8, lsl #48
               	str	x0, [x1, #0x88]
               	mov	x0, #0xd206             // =53766
               	movk	x0, #0xb2d7, lsl #16
               	movk	x0, #0x100d, lsl #32
               	movk	x0, #0xf66e, lsl #48
               	str	x0, [x1, #0x90]
               	mov	x0, #0x665d             // =26205
               	movk	x0, #0x7e06, lsl #16
               	movk	x0, #0xe6a5, lsl #32
               	movk	x0, #0x1069, lsl #48
               	str	x0, [x1, #0x98]
               	mov	x2, #0x0                // =0
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	lsl	x3, x0, #3
               	add	x4, x4, x3
               	add	x3, x1, x3
               	ldr	x3, [x3]
               	str	x3, [x4]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	x3, [x1, x0, lsl #3]
               	str	w3, [x4, x0, lsl #2]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x4, [x1, x0, lsl #3]
               	mov	w4, w4
               	str	w4, [x3, x0, lsl #2]
               	add	x2, x0, #0x1
               	sxtw	x0, w2
               	cmp	x0, #0x14
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
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
               	b	<addr>
               	mov	x0, #0x3                // =3
               	sub	x17, x29, #0x1a8
               	str	w0, [x17]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, x2, lsl #2]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x3, x0, x17
               	asr	x3, x3, #32
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	sub	x16, x29, #0x1a8
               	ldrsw	x4, [x16]
               	sdiv	x4, x0, x4
               	cmp	x3, x4
               	b.ne	<addr>
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x3, x0, x17
               	asr	x3, x3, #32
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	mov	x17, #0x3               // =3
               	mul	x3, x3, x17
               	sub	x3, x0, x3
               	sub	x16, x29, #0x1a8
               	ldrsw	x4, [x16]
               	sdiv	x17, x0, x4
               	msub	x0, x17, x4, x0
               	cmp	x3, x0
               	b.ne	<addr>
               	add	x1, x2, #0x1
               	sxtw	x2, w1
               	cmp	x2, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x5                // =5
               	sub	x17, x29, #0x1a0
               	str	w0, [x17]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, x2, lsl #2]
               	mov	x17, #0x6667            // =26215
               	movk	x17, #0x6666, lsl #16
               	mul	x3, x0, x17
               	asr	x3, x3, #33
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	sub	x16, x29, #0x1a0
               	ldrsw	x4, [x16]
               	sdiv	x4, x0, x4
               	cmp	x3, x4
               	b.ne	<addr>
               	mov	x17, #0x6667            // =26215
               	movk	x17, #0x6666, lsl #16
               	mul	x3, x0, x17
               	asr	x3, x3, #33
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	mov	x17, #0x5               // =5
               	mul	x3, x3, x17
               	sub	x3, x0, x3
               	sub	x16, x29, #0x1a0
               	ldrsw	x4, [x16]
               	sdiv	x17, x0, x4
               	msub	x0, x17, x4, x0
               	cmp	x3, x0
               	b.ne	<addr>
               	add	x1, x2, #0x1
               	sxtw	x2, w1
               	cmp	x2, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x6                // =6
               	sub	x17, x29, #0x198
               	str	w0, [x17]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, x2, lsl #2]
               	mov	x17, #0xaaab            // =43691
               	movk	x17, #0x2aaa, lsl #16
               	mul	x3, x0, x17
               	asr	x3, x3, #32
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	sub	x16, x29, #0x198
               	ldrsw	x4, [x16]
               	sdiv	x4, x0, x4
               	cmp	x3, x4
               	b.ne	<addr>
               	mov	x17, #0xaaab            // =43691
               	movk	x17, #0x2aaa, lsl #16
               	mul	x3, x0, x17
               	asr	x3, x3, #32
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	mov	x17, #0x6               // =6
               	mul	x3, x3, x17
               	sub	x3, x0, x3
               	sub	x16, x29, #0x198
               	ldrsw	x4, [x16]
               	sdiv	x17, x0, x4
               	msub	x0, x17, x4, x0
               	cmp	x3, x0
               	b.ne	<addr>
               	add	x1, x2, #0x1
               	sxtw	x2, w1
               	cmp	x2, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x7                // =7
               	sub	x17, x29, #0x190
               	str	w0, [x17]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, x2, lsl #2]
               	mov	x17, #0x2493            // =9363
               	movk	x17, #0x9249, lsl #16
               	mul	x3, x0, x17
               	asr	x3, x3, #34
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	sub	x16, x29, #0x190
               	ldrsw	x4, [x16]
               	sdiv	x4, x0, x4
               	cmp	x3, x4
               	b.ne	<addr>
               	mov	x17, #0x2493            // =9363
               	movk	x17, #0x9249, lsl #16
               	mul	x3, x0, x17
               	asr	x3, x3, #34
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	mov	x17, #0x7               // =7
               	mul	x3, x3, x17
               	sub	x3, x0, x3
               	sub	x16, x29, #0x190
               	ldrsw	x4, [x16]
               	sdiv	x17, x0, x4
               	msub	x0, x17, x4, x0
               	cmp	x3, x0
               	b.ne	<addr>
               	add	x1, x2, #0x1
               	sxtw	x2, w1
               	cmp	x2, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x0, #0xa                // =10
               	sub	x17, x29, #0x188
               	str	w0, [x17]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, x2, lsl #2]
               	mov	x17, #0x6667            // =26215
               	movk	x17, #0x6666, lsl #16
               	mul	x3, x0, x17
               	asr	x3, x3, #34
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	sub	x16, x29, #0x188
               	ldrsw	x4, [x16]
               	sdiv	x4, x0, x4
               	cmp	x3, x4
               	b.ne	<addr>
               	mov	x17, #0x6667            // =26215
               	movk	x17, #0x6666, lsl #16
               	mul	x3, x0, x17
               	asr	x3, x3, #34
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	mov	x17, #0xa               // =10
               	mul	x3, x3, x17
               	sub	x3, x0, x3
               	sub	x16, x29, #0x188
               	ldrsw	x4, [x16]
               	sdiv	x17, x0, x4
               	msub	x0, x17, x4, x0
               	cmp	x3, x0
               	b.ne	<addr>
               	add	x1, x2, #0x1
               	sxtw	x2, w1
               	cmp	x2, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x64               // =100
               	sub	x17, x29, #0x180
               	str	w0, [x17]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, x2, lsl #2]
               	mov	x17, #0x851f            // =34079
               	movk	x17, #0x51eb, lsl #16
               	mul	x3, x0, x17
               	asr	x3, x3, #37
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	sub	x16, x29, #0x180
               	ldrsw	x4, [x16]
               	sdiv	x4, x0, x4
               	cmp	x3, x4
               	b.ne	<addr>
               	mov	x17, #0x851f            // =34079
               	movk	x17, #0x51eb, lsl #16
               	mul	x3, x0, x17
               	asr	x3, x3, #37
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	mov	x17, #0x64              // =100
               	mul	x3, x3, x17
               	sub	x3, x0, x3
               	sub	x16, x29, #0x180
               	ldrsw	x4, [x16]
               	sdiv	x17, x0, x4
               	msub	x0, x17, x4, x0
               	cmp	x3, x0
               	b.ne	<addr>
               	add	x1, x2, #0x1
               	sxtw	x2, w1
               	cmp	x2, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x3e8              // =1000
               	sub	x17, x29, #0x178
               	str	w0, [x17]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, x2, lsl #2]
               	mov	x17, #0x4dd3            // =19923
               	movk	x17, #0x1062, lsl #16
               	mul	x3, x0, x17
               	asr	x3, x3, #38
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	sub	x16, x29, #0x178
               	ldrsw	x4, [x16]
               	sdiv	x4, x0, x4
               	cmp	x3, x4
               	b.ne	<addr>
               	mov	x17, #0x4dd3            // =19923
               	movk	x17, #0x1062, lsl #16
               	mul	x3, x0, x17
               	asr	x3, x3, #38
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	mov	x17, #0x3e8             // =1000
               	mul	x3, x3, x17
               	sub	x3, x0, x3
               	sub	x16, x29, #0x178
               	ldrsw	x4, [x16]
               	sdiv	x17, x0, x4
               	msub	x0, x17, x4, x0
               	cmp	x3, x0
               	b.ne	<addr>
               	add	x1, x2, #0x1
               	sxtw	x2, w1
               	cmp	x2, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x0, #0xffff             // =65535
               	sub	x17, x29, #0x170
               	str	w0, [x17]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, x2, lsl #2]
               	mov	x17, #0x8001            // =32769
               	movk	x17, #0x8000, lsl #16
               	mul	x3, x0, x17
               	asr	x3, x3, #47
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	sub	x16, x29, #0x170
               	ldrsw	x4, [x16]
               	sdiv	x4, x0, x4
               	cmp	x3, x4
               	b.ne	<addr>
               	mov	x17, #0x8001            // =32769
               	movk	x17, #0x8000, lsl #16
               	mul	x3, x0, x17
               	asr	x3, x3, #47
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	mov	x17, #0xffff            // =65535
               	mul	x3, x3, x17
               	sub	x3, x0, x3
               	sub	x16, x29, #0x170
               	ldrsw	x4, [x16]
               	sdiv	x17, x0, x4
               	msub	x0, x17, x4, x0
               	cmp	x3, x0
               	b.ne	<addr>
               	add	x1, x2, #0x1
               	sxtw	x2, w1
               	cmp	x2, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x1                // =1
               	movk	x0, #0x1, lsl #16
               	sub	x17, x29, #0x168
               	str	w0, [x17]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, x2, lsl #2]
               	mov	x17, #0x8001            // =32769
               	movk	x17, #0x7fff, lsl #16
               	mul	x3, x0, x17
               	asr	x3, x3, #47
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	sub	x16, x29, #0x168
               	ldrsw	x4, [x16]
               	sdiv	x4, x0, x4
               	cmp	x3, x4
               	b.ne	<addr>
               	mov	x17, #0x8001            // =32769
               	movk	x17, #0x7fff, lsl #16
               	mul	x3, x0, x17
               	asr	x3, x3, #47
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	mov	x17, #0x1               // =1
               	movk	x17, #0x1, lsl #16
               	mul	x3, x3, x17
               	sub	x3, x0, x3
               	sub	x16, x29, #0x168
               	ldrsw	x4, [x16]
               	sdiv	x17, x0, x4
               	msub	x0, x17, x4, x0
               	cmp	x3, x0
               	b.ne	<addr>
               	add	x1, x2, #0x1
               	sxtw	x2, w1
               	cmp	x2, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0x7fff, lsl #16
               	sub	x17, x29, #0x160
               	str	w0, [x17]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, x2, lsl #2]
               	mov	x17, #0x1               // =1
               	movk	x17, #0x4000, lsl #16
               	mul	x3, x0, x17
               	asr	x3, x3, #61
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	sub	x16, x29, #0x160
               	ldrsw	x4, [x16]
               	sdiv	x4, x0, x4
               	cmp	x3, x4
               	b.ne	<addr>
               	mov	x17, #0x1               // =1
               	movk	x17, #0x4000, lsl #16
               	mul	x3, x0, x17
               	asr	x3, x3, #61
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x7fff, lsl #16
               	mul	x3, x3, x17
               	sub	x3, x0, x3
               	sub	x16, x29, #0x160
               	ldrsw	x4, [x16]
               	sdiv	x17, x0, x4
               	msub	x0, x17, x4, x0
               	cmp	x3, x0
               	b.ne	<addr>
               	add	x1, x2, #0x1
               	sxtw	x2, w1
               	cmp	x2, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x0, #0xfffd             // =65533
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	sub	x17, x29, #0x158
               	str	w0, [x17]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, x2, lsl #2]
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x3, x0, x17
               	asr	x3, x3, #32
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	mov	x4, #0x0                // =0
               	sub	x3, x4, x3
               	sub	x16, x29, #0x158
               	ldrsw	x4, [x16]
               	sdiv	x4, x0, x4
               	cmp	x3, x4
               	b.ne	<addr>
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x3, x0, x17
               	asr	x3, x3, #32
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	mov	x4, #0x0                // =0
               	sub	x3, x4, x3
               	mov	x17, #0xfffd            // =65533
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x3, x3, x17
               	sub	x3, x0, x3
               	sub	x16, x29, #0x158
               	ldrsw	x4, [x16]
               	sdiv	x17, x0, x4
               	msub	x0, x17, x4, x0
               	cmp	x3, x0
               	b.ne	<addr>
               	add	x1, x2, #0x1
               	sxtw	x2, w1
               	cmp	x2, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x0, #0xfff9             // =65529
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	sub	x17, x29, #0x150
               	str	w0, [x17]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, x2, lsl #2]
               	mov	x17, #0x2493            // =9363
               	movk	x17, #0x9249, lsl #16
               	mul	x3, x0, x17
               	asr	x3, x3, #34
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	mov	x4, #0x0                // =0
               	sub	x3, x4, x3
               	sub	x16, x29, #0x150
               	ldrsw	x4, [x16]
               	sdiv	x4, x0, x4
               	cmp	x3, x4
               	b.ne	<addr>
               	mov	x17, #0x2493            // =9363
               	movk	x17, #0x9249, lsl #16
               	mul	x3, x0, x17
               	asr	x3, x3, #34
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	mov	x4, #0x0                // =0
               	sub	x3, x4, x3
               	mov	x17, #0xfff9            // =65529
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x3, x3, x17
               	sub	x3, x0, x3
               	sub	x16, x29, #0x150
               	ldrsw	x4, [x16]
               	sdiv	x17, x0, x4
               	msub	x0, x17, x4, x0
               	cmp	x3, x0
               	b.ne	<addr>
               	add	x1, x2, #0x1
               	sxtw	x2, w1
               	cmp	x2, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x0, #0xff9c             // =65436
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	sub	x17, x29, #0x148
               	str	w0, [x17]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, x2, lsl #2]
               	mov	x17, #0x851f            // =34079
               	movk	x17, #0x51eb, lsl #16
               	mul	x3, x0, x17
               	asr	x3, x3, #37
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	mov	x4, #0x0                // =0
               	sub	x3, x4, x3
               	sub	x16, x29, #0x148
               	ldrsw	x4, [x16]
               	sdiv	x4, x0, x4
               	cmp	x3, x4
               	b.ne	<addr>
               	mov	x17, #0x851f            // =34079
               	movk	x17, #0x51eb, lsl #16
               	mul	x3, x0, x17
               	asr	x3, x3, #37
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	mov	x4, #0x0                // =0
               	sub	x3, x4, x3
               	mov	x17, #0xff9c            // =65436
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x3, x3, x17
               	sub	x3, x0, x3
               	sub	x16, x29, #0x148
               	ldrsw	x4, [x16]
               	sdiv	x17, x0, x4
               	msub	x0, x17, x4, x0
               	cmp	x3, x0
               	b.ne	<addr>
               	add	x1, x2, #0x1
               	sxtw	x2, w1
               	cmp	x2, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x80000000         // =2147483648
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	sub	x17, x29, #0x140
               	str	w0, [x17]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, x2, lsl #2]
               	asr	x3, x0, #63
               	lsr	x3, x3, #33
               	add	x3, x0, x3
               	asr	x3, x3, #31
               	mov	x4, #0x0                // =0
               	sub	x3, x4, x3
               	sub	x16, x29, #0x140
               	ldrsw	x4, [x16]
               	sdiv	x4, x0, x4
               	cmp	x3, x4
               	b.ne	<addr>
               	asr	x3, x0, #63
               	lsr	x3, x3, #33
               	add	x4, x0, x3
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x7fff, lsl #16
               	and	x4, x4, x17
               	sub	x3, x4, x3
               	sub	x16, x29, #0x140
               	ldrsw	x4, [x16]
               	sdiv	x17, x0, x4
               	msub	x0, x17, x4, x0
               	cmp	x3, x0
               	b.ne	<addr>
               	add	x1, x2, #0x1
               	sxtw	x2, w1
               	cmp	x2, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x1                // =1
               	sub	x17, x29, #0x138
               	str	w1, [x17]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1, x2, lsl #2]
               	sub	x16, x29, #0x138
               	ldrsw	x3, [x16]
               	sdiv	x3, x1, x3
               	cmp	x1, x3
               	b.ne	<addr>
               	sub	x16, x29, #0x138
               	ldrsw	x3, [x16]
               	sdiv	x17, x1, x3
               	msub	x1, x17, x3, x1
               	cbnz	x1, <addr>
               	add	x0, x2, #0x1
               	sxtw	x2, w0
               	cmp	x2, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x8                // =8
               	sub	x17, x29, #0x130
               	str	w0, [x17]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, x2, lsl #2]
               	asr	x3, x0, #63
               	lsr	x3, x3, #61
               	add	x3, x0, x3
               	asr	x3, x3, #3
               	sub	x16, x29, #0x130
               	ldrsw	x4, [x16]
               	sdiv	x4, x0, x4
               	cmp	x3, x4
               	b.ne	<addr>
               	asr	x3, x0, #63
               	lsr	x3, x3, #61
               	add	x4, x0, x3
               	mov	x17, #0x7               // =7
               	and	x4, x4, x17
               	sub	x3, x4, x3
               	sub	x16, x29, #0x130
               	ldrsw	x4, [x16]
               	sdiv	x17, x0, x4
               	msub	x0, x17, x4, x0
               	cmp	x3, x0
               	b.ne	<addr>
               	add	x1, x2, #0x1
               	sxtw	x2, w1
               	cmp	x2, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x0, #0xfff8             // =65528
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	sub	x17, x29, #0x128
               	str	w0, [x17]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, x2, lsl #2]
               	asr	x3, x0, #63
               	lsr	x3, x3, #61
               	add	x3, x0, x3
               	asr	x3, x3, #3
               	mov	x4, #0x0                // =0
               	sub	x3, x4, x3
               	sub	x16, x29, #0x128
               	ldrsw	x4, [x16]
               	sdiv	x4, x0, x4
               	cmp	x3, x4
               	b.ne	<addr>
               	asr	x3, x0, #63
               	lsr	x3, x3, #61
               	add	x4, x0, x3
               	mov	x17, #0x7               // =7
               	and	x4, x4, x17
               	sub	x3, x4, x3
               	sub	x16, x29, #0x128
               	ldrsw	x4, [x16]
               	sdiv	x17, x0, x4
               	msub	x0, x17, x4, x0
               	cmp	x3, x0
               	b.ne	<addr>
               	add	x1, x2, #0x1
               	sxtw	x2, w1
               	cmp	x2, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x40000000         // =1073741824
               	sub	x17, x29, #0x120
               	str	w0, [x17]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, x2, lsl #2]
               	asr	x3, x0, #63
               	lsr	x3, x3, #34
               	add	x3, x0, x3
               	asr	x3, x3, #30
               	sub	x16, x29, #0x120
               	ldrsw	x4, [x16]
               	sdiv	x4, x0, x4
               	cmp	x3, x4
               	b.ne	<addr>
               	asr	x3, x0, #63
               	lsr	x3, x3, #34
               	add	x4, x0, x3
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x3fff, lsl #16
               	and	x4, x4, x17
               	sub	x3, x4, x3
               	sub	x16, x29, #0x120
               	ldrsw	x4, [x16]
               	sdiv	x17, x0, x4
               	msub	x0, x17, x4, x0
               	cmp	x3, x0
               	b.ne	<addr>
               	add	x1, x2, #0x1
               	sxtw	x2, w1
               	cmp	x2, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x2, #0x3                // =3
               	sub	x17, x29, #0x118
               	str	w2, [x17]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	w2, [x2, x1, lsl #2]
               	mov	w3, w2
               	mov	x17, #0xaaab            // =43691
               	movk	x17, #0xaaaa, lsl #16
               	mul	x4, x3, x17
               	lsr	x4, x4, #33
               	sub	x16, x29, #0x118
               	ldr	w5, [x16]
               	udiv	x3, x3, x5
               	cmp	x4, x3
               	b.ne	<addr>
               	mov	w2, w2
               	mov	x17, #0xaaab            // =43691
               	movk	x17, #0xaaaa, lsl #16
               	mul	x3, x2, x17
               	lsr	x3, x3, #33
               	mov	x17, #0x3               // =3
               	mul	x3, x3, x17
               	sub	x3, x2, x3
               	sub	x16, x29, #0x118
               	ldr	w4, [x16]
               	udiv	x17, x2, x4
               	msub	x2, x17, x4, x2
               	cmp	x3, x2
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x2, #0x7                // =7
               	sub	x17, x29, #0x110
               	str	w2, [x17]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	w3, [x2, x1, lsl #2]
               	mov	w2, w3
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x4, x2, x17
               	lsr	x4, x4, #32
               	sub	x5, x2, x4
               	lsr	x5, x5, #1
               	add	x4, x5, x4
               	lsr	x4, x4, #2
               	sub	x16, x29, #0x110
               	ldr	w5, [x16]
               	udiv	x2, x2, x5
               	cmp	x4, x2
               	b.ne	<addr>
               	mov	w2, w3
               	mov	x17, #0x4925            // =18725
               	movk	x17, #0x2492, lsl #16
               	mul	x3, x2, x17
               	lsr	x3, x3, #32
               	sub	x4, x2, x3
               	lsr	x4, x4, #1
               	add	x3, x4, x3
               	lsr	x3, x3, #2
               	mov	x17, #0x7               // =7
               	mul	x3, x3, x17
               	sub	x3, x2, x3
               	sub	x16, x29, #0x110
               	ldr	w4, [x16]
               	udiv	x17, x2, x4
               	msub	x2, x17, x4, x2
               	cmp	x3, x2
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x2, #0xa                // =10
               	sub	x17, x29, #0x108
               	str	w2, [x17]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	w2, [x2, x1, lsl #2]
               	mov	w3, w2
               	lsr	x4, x3, #1
               	mov	x17, #0x6667            // =26215
               	movk	x17, #0x6666, lsl #16
               	mul	x4, x4, x17
               	lsr	x4, x4, #33
               	sub	x16, x29, #0x108
               	ldr	w5, [x16]
               	udiv	x3, x3, x5
               	cmp	x4, x3
               	b.ne	<addr>
               	mov	w2, w2
               	lsr	x3, x2, #1
               	mov	x17, #0x6667            // =26215
               	movk	x17, #0x6666, lsl #16
               	mul	x3, x3, x17
               	lsr	x3, x3, #33
               	mov	x17, #0xa               // =10
               	mul	x3, x3, x17
               	sub	x3, x2, x3
               	sub	x16, x29, #0x108
               	ldr	w4, [x16]
               	udiv	x17, x2, x4
               	msub	x2, x17, x4, x2
               	cmp	x3, x2
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x2, #0xe                // =14
               	stur	w2, [x29, #-0x100]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	w2, [x2, x1, lsl #2]
               	mov	w3, w2
               	lsr	x4, x3, #1
               	mov	x17, #0x2493            // =9363
               	movk	x17, #0x9249, lsl #16
               	mul	x4, x4, x17
               	lsr	x4, x4, #34
               	ldur	w5, [x29, #-0x100]
               	udiv	x3, x3, x5
               	cmp	x4, x3
               	b.ne	<addr>
               	mov	w2, w2
               	lsr	x3, x2, #1
               	mov	x17, #0x2493            // =9363
               	movk	x17, #0x9249, lsl #16
               	mul	x3, x3, x17
               	lsr	x3, x3, #34
               	mov	x17, #0xe               // =14
               	mul	x3, x3, x17
               	sub	x3, x2, x3
               	ldur	w4, [x29, #-0x100]
               	udiv	x17, x2, x4
               	msub	x2, x17, x4, x2
               	cmp	x3, x2
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x2, #0x64               // =100
               	stur	w2, [x29, #-0xf8]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	w2, [x2, x1, lsl #2]
               	mov	w3, w2
               	lsr	x4, x3, #2
               	mov	x17, #0x70a4            // =28836
               	movk	x17, #0xa3d, lsl #16
               	mul	x4, x4, x17
               	lsr	x4, x4, #32
               	ldur	w5, [x29, #-0xf8]
               	udiv	x3, x3, x5
               	cmp	x4, x3
               	b.ne	<addr>
               	mov	w2, w2
               	lsr	x3, x2, #2
               	mov	x17, #0x70a4            // =28836
               	movk	x17, #0xa3d, lsl #16
               	mul	x3, x3, x17
               	lsr	x3, x3, #32
               	mov	x17, #0x64              // =100
               	mul	x3, x3, x17
               	sub	x3, x2, x3
               	ldur	w4, [x29, #-0xf8]
               	udiv	x17, x2, x4
               	msub	x2, x17, x4, x2
               	cmp	x3, x2
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x2, #0x3e8              // =1000
               	stur	w2, [x29, #-0xf0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	w2, [x2, x1, lsl #2]
               	mov	w3, w2
               	lsr	x4, x3, #3
               	mov	x17, #0x4dd3            // =19923
               	movk	x17, #0x1062, lsl #16
               	mul	x4, x4, x17
               	lsr	x4, x4, #35
               	ldur	w5, [x29, #-0xf0]
               	udiv	x3, x3, x5
               	cmp	x4, x3
               	b.ne	<addr>
               	mov	w2, w2
               	lsr	x3, x2, #3
               	mov	x17, #0x4dd3            // =19923
               	movk	x17, #0x1062, lsl #16
               	mul	x3, x3, x17
               	lsr	x3, x3, #35
               	mov	x17, #0x3e8             // =1000
               	mul	x3, x3, x17
               	sub	x3, x2, x3
               	ldur	w4, [x29, #-0xf0]
               	udiv	x17, x2, x4
               	msub	x2, x17, x4, x2
               	cmp	x3, x2
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x2, #0xffff             // =65535
               	movk	x2, #0x7fff, lsl #16
               	stur	w2, [x29, #-0xe8]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	w3, [x2, x1, lsl #2]
               	mov	w2, w3
               	mov	x17, #0x3               // =3
               	mul	x4, x2, x17
               	lsr	x4, x4, #32
               	sub	x5, x2, x4
               	lsr	x5, x5, #1
               	add	x4, x5, x4
               	lsr	x4, x4, #30
               	ldur	w5, [x29, #-0xe8]
               	udiv	x2, x2, x5
               	cmp	x4, x2
               	b.ne	<addr>
               	mov	w2, w3
               	mov	x17, #0x3               // =3
               	mul	x3, x2, x17
               	lsr	x3, x3, #32
               	sub	x4, x2, x3
               	lsr	x4, x4, #1
               	add	x3, x4, x3
               	lsr	x3, x3, #30
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x7fff, lsl #16
               	mul	x3, x3, x17
               	sub	x3, x2, x3
               	ldur	w4, [x29, #-0xe8]
               	udiv	x17, x2, x4
               	msub	x2, x17, x4, x2
               	cmp	x3, x2
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x2, #0x1                // =1
               	movk	x2, #0x8000, lsl #16
               	stur	w2, [x29, #-0xe0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	w2, [x2, x1, lsl #2]
               	mov	w3, w2
               	mov	x17, #0x1               // =1
               	movk	x17, #0x8000, lsl #16
               	cmp	x3, x17
               	cset	x4, hs
               	ldur	w5, [x29, #-0xe0]
               	udiv	x3, x3, x5
               	cmp	x4, x3
               	b.ne	<addr>
               	mov	w2, w2
               	mov	x17, #0x1               // =1
               	movk	x17, #0x8000, lsl #16
               	cmp	x2, x17
               	cset	x3, hs
               	mov	x17, #0x1               // =1
               	movk	x17, #0x8000, lsl #16
               	mul	x3, x3, x17
               	sub	x3, x2, x3
               	ldur	w4, [x29, #-0xe0]
               	udiv	x17, x2, x4
               	msub	x2, x17, x4, x2
               	cmp	x3, x2
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x2, #0xfffb             // =65531
               	movk	x2, #0xffff, lsl #16
               	stur	w2, [x29, #-0xd8]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	w2, [x2, x1, lsl #2]
               	mov	w3, w2
               	mov	x17, #0xfffb            // =65531
               	movk	x17, #0xffff, lsl #16
               	cmp	x3, x17
               	cset	x4, hs
               	ldur	w5, [x29, #-0xd8]
               	udiv	x3, x3, x5
               	cmp	x4, x3
               	b.ne	<addr>
               	mov	w2, w2
               	mov	x17, #0xfffb            // =65531
               	movk	x17, #0xffff, lsl #16
               	cmp	x2, x17
               	cset	x3, hs
               	mov	x17, #0xfffb            // =65531
               	movk	x17, #0xffff, lsl #16
               	mul	x3, x3, x17
               	sub	x3, x2, x3
               	ldur	w4, [x29, #-0xd8]
               	udiv	x17, x2, x4
               	msub	x2, x17, x4, x2
               	cmp	x3, x2
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x2, #0x1                // =1
               	stur	w2, [x29, #-0xd0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	w2, [x2, x1, lsl #2]
               	mov	w3, w2
               	ldur	w4, [x29, #-0xd0]
               	udiv	x4, x3, x4
               	cmp	x3, x4
               	b.ne	<addr>
               	mov	w2, w2
               	ldur	w3, [x29, #-0xd0]
               	udiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	cbnz	x2, <addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x2, #0x10               // =16
               	stur	w2, [x29, #-0xc8]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	w2, [x2, x1, lsl #2]
               	mov	w3, w2
               	lsr	x4, x3, #4
               	ldur	w5, [x29, #-0xc8]
               	udiv	x3, x3, x5
               	cmp	x4, x3
               	b.ne	<addr>
               	mov	w2, w2
               	mov	x17, #0xf               // =15
               	and	x3, x2, x17
               	ldur	w4, [x29, #-0xc8]
               	udiv	x17, x2, x4
               	msub	x2, x17, x4, x2
               	cmp	x3, x2
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x3                // =3
               	stur	x1, [x29, #-0xc0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1, x2, lsl #3]
               	mov	x3, #0x5556             // =21846
               	movk	x3, #0x5555, lsl #16
               	movk	x3, #0x5555, lsl #32
               	movk	x3, #0x5555, lsl #48
               	smulh	x3, x1, x3
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	ldur	x4, [x29, #-0xc0]
               	sdiv	x4, x1, x4
               	cmp	x3, x4
               	b.ne	<addr>
               	mov	x3, #0x5556             // =21846
               	movk	x3, #0x5555, lsl #16
               	movk	x3, #0x5555, lsl #32
               	movk	x3, #0x5555, lsl #48
               	smulh	x3, x1, x3
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	mov	x17, #0x3               // =3
               	mul	x3, x3, x17
               	sub	x3, x1, x3
               	ldur	x4, [x29, #-0xc0]
               	sdiv	x17, x1, x4
               	msub	x1, x17, x4, x1
               	cmp	x3, x1
               	b.ne	<addr>
               	add	x0, x2, #0x1
               	sxtw	x2, w0
               	cmp	x2, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x7                // =7
               	stur	x1, [x29, #-0xb8]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1, x2, lsl #3]
               	mov	x3, #0x4925             // =18725
               	movk	x3, #0x2492, lsl #16
               	movk	x3, #0x9249, lsl #32
               	movk	x3, #0x4924, lsl #48
               	smulh	x3, x1, x3
               	asr	x3, x3, #1
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	ldur	x4, [x29, #-0xb8]
               	sdiv	x4, x1, x4
               	cmp	x3, x4
               	b.ne	<addr>
               	mov	x3, #0x4925             // =18725
               	movk	x3, #0x2492, lsl #16
               	movk	x3, #0x9249, lsl #32
               	movk	x3, #0x4924, lsl #48
               	smulh	x3, x1, x3
               	asr	x3, x3, #1
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	mov	x17, #0x7               // =7
               	mul	x3, x3, x17
               	sub	x3, x1, x3
               	ldur	x4, [x29, #-0xb8]
               	sdiv	x17, x1, x4
               	msub	x1, x17, x4, x1
               	cmp	x3, x1
               	b.ne	<addr>
               	add	x0, x2, #0x1
               	sxtw	x2, w0
               	cmp	x2, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x1, #0xa                // =10
               	stur	x1, [x29, #-0xb0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1, x2, lsl #3]
               	mov	x3, #0x6667             // =26215
               	movk	x3, #0x6666, lsl #16
               	movk	x3, #0x6666, lsl #32
               	movk	x3, #0x6666, lsl #48
               	smulh	x3, x1, x3
               	asr	x3, x3, #2
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	ldur	x4, [x29, #-0xb0]
               	sdiv	x4, x1, x4
               	cmp	x3, x4
               	b.ne	<addr>
               	mov	x3, #0x6667             // =26215
               	movk	x3, #0x6666, lsl #16
               	movk	x3, #0x6666, lsl #32
               	movk	x3, #0x6666, lsl #48
               	smulh	x3, x1, x3
               	asr	x3, x3, #2
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	mov	x17, #0xa               // =10
               	mul	x3, x3, x17
               	sub	x3, x1, x3
               	ldur	x4, [x29, #-0xb0]
               	sdiv	x17, x1, x4
               	msub	x1, x17, x4, x1
               	cmp	x3, x1
               	b.ne	<addr>
               	add	x0, x2, #0x1
               	sxtw	x2, w0
               	cmp	x2, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x3e8              // =1000
               	stur	x1, [x29, #-0xa8]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1, x2, lsl #3]
               	mov	x3, #0xf7cf             // =63439
               	movk	x3, #0xe353, lsl #16
               	movk	x3, #0x9ba5, lsl #32
               	movk	x3, #0x20c4, lsl #48
               	smulh	x3, x1, x3
               	asr	x3, x3, #7
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	ldur	x4, [x29, #-0xa8]
               	sdiv	x4, x1, x4
               	cmp	x3, x4
               	b.ne	<addr>
               	mov	x3, #0xf7cf             // =63439
               	movk	x3, #0xe353, lsl #16
               	movk	x3, #0x9ba5, lsl #32
               	movk	x3, #0x20c4, lsl #48
               	smulh	x3, x1, x3
               	asr	x3, x3, #7
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	mov	x17, #0x3e8             // =1000
               	mul	x3, x3, x17
               	sub	x3, x1, x3
               	ldur	x4, [x29, #-0xa8]
               	sdiv	x17, x1, x4
               	msub	x1, x17, x4, x1
               	cmp	x3, x1
               	b.ne	<addr>
               	add	x0, x2, #0x1
               	sxtw	x2, w0
               	cmp	x2, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x0, #0xca07             // =51719
               	movk	x0, #0x3b9a, lsl #16
               	stur	x0, [x29, #-0xa0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, x2, lsl #3]
               	mov	x3, #0x8fe5             // =36837
               	movk	x3, #0x12a2, lsl #16
               	movk	x3, #0x5f31, lsl #32
               	movk	x3, #0x8970, lsl #48
               	smulh	x3, x0, x3
               	add	x3, x3, x0
               	asr	x3, x3, #29
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	ldur	x4, [x29, #-0xa0]
               	sdiv	x4, x0, x4
               	cmp	x3, x4
               	b.ne	<addr>
               	mov	x3, #0x8fe5             // =36837
               	movk	x3, #0x12a2, lsl #16
               	movk	x3, #0x5f31, lsl #32
               	movk	x3, #0x8970, lsl #48
               	smulh	x3, x0, x3
               	add	x3, x3, x0
               	asr	x3, x3, #29
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	mov	x17, #0xca07            // =51719
               	movk	x17, #0x3b9a, lsl #16
               	mul	x3, x3, x17
               	sub	x3, x0, x3
               	ldur	x4, [x29, #-0xa0]
               	sdiv	x17, x0, x4
               	msub	x0, x17, x4, x0
               	cmp	x3, x0
               	b.ne	<addr>
               	add	x1, x2, #0x1
               	sxtw	x2, w1
               	cmp	x2, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0x7fff, lsl #48
               	stur	x1, [x29, #-0x98]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1, x2, lsl #3]
               	mov	x3, #0x1                // =1
               	movk	x3, #0x4000, lsl #48
               	smulh	x3, x1, x3
               	asr	x3, x3, #61
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	ldur	x4, [x29, #-0x98]
               	sdiv	x4, x1, x4
               	cmp	x3, x4
               	b.ne	<addr>
               	mov	x3, #0x1                // =1
               	movk	x3, #0x4000, lsl #48
               	smulh	x3, x1, x3
               	asr	x3, x3, #61
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0x7fff, lsl #48
               	mul	x3, x3, x17
               	sub	x3, x1, x3
               	ldur	x4, [x29, #-0x98]
               	sdiv	x17, x1, x4
               	msub	x1, x17, x4, x1
               	cmp	x3, x1
               	b.ne	<addr>
               	add	x0, x2, #0x1
               	sxtw	x2, w0
               	cmp	x2, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x1, #0xfffd             // =65533
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	stur	x1, [x29, #-0x90]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1, x2, lsl #3]
               	mov	x3, #0x5556             // =21846
               	movk	x3, #0x5555, lsl #16
               	movk	x3, #0x5555, lsl #32
               	movk	x3, #0x5555, lsl #48
               	smulh	x3, x1, x3
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	mov	x4, #0x0                // =0
               	sub	x3, x4, x3
               	ldur	x4, [x29, #-0x90]
               	sdiv	x4, x1, x4
               	cmp	x3, x4
               	b.ne	<addr>
               	mov	x3, #0x5556             // =21846
               	movk	x3, #0x5555, lsl #16
               	movk	x3, #0x5555, lsl #32
               	movk	x3, #0x5555, lsl #48
               	smulh	x3, x1, x3
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	mov	x4, #0x0                // =0
               	sub	x3, x4, x3
               	mov	x17, #0xfffd            // =65533
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x3, x3, x17
               	sub	x3, x1, x3
               	ldur	x4, [x29, #-0x90]
               	sdiv	x17, x1, x4
               	msub	x1, x17, x4, x1
               	cmp	x3, x1
               	b.ne	<addr>
               	add	x0, x2, #0x1
               	sxtw	x2, w0
               	cmp	x2, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x1, #0xfff9             // =65529
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	stur	x1, [x29, #-0x88]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1, x2, lsl #3]
               	mov	x3, #0x4925             // =18725
               	movk	x3, #0x2492, lsl #16
               	movk	x3, #0x9249, lsl #32
               	movk	x3, #0x4924, lsl #48
               	smulh	x3, x1, x3
               	asr	x3, x3, #1
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	mov	x4, #0x0                // =0
               	sub	x3, x4, x3
               	ldur	x4, [x29, #-0x88]
               	sdiv	x4, x1, x4
               	cmp	x3, x4
               	b.ne	<addr>
               	mov	x3, #0x4925             // =18725
               	movk	x3, #0x2492, lsl #16
               	movk	x3, #0x9249, lsl #32
               	movk	x3, #0x4924, lsl #48
               	smulh	x3, x1, x3
               	asr	x3, x3, #1
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	mov	x4, #0x0                // =0
               	sub	x3, x4, x3
               	mov	x17, #0xfff9            // =65529
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x3, x3, x17
               	sub	x3, x1, x3
               	ldur	x4, [x29, #-0x88]
               	sdiv	x17, x1, x4
               	msub	x1, x17, x4, x1
               	cmp	x3, x1
               	b.ne	<addr>
               	add	x0, x2, #0x1
               	sxtw	x2, w0
               	cmp	x2, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x35f9             // =13817
               	movk	x0, #0xc465, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	stur	x0, [x29, #-0x80]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, x2, lsl #3]
               	mov	x3, #0x8fe5             // =36837
               	movk	x3, #0x12a2, lsl #16
               	movk	x3, #0x5f31, lsl #32
               	movk	x3, #0x8970, lsl #48
               	smulh	x3, x0, x3
               	add	x3, x3, x0
               	asr	x3, x3, #29
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	mov	x4, #0x0                // =0
               	sub	x3, x4, x3
               	ldur	x4, [x29, #-0x80]
               	sdiv	x4, x0, x4
               	cmp	x3, x4
               	b.ne	<addr>
               	mov	x3, #0x8fe5             // =36837
               	movk	x3, #0x12a2, lsl #16
               	movk	x3, #0x5f31, lsl #32
               	movk	x3, #0x8970, lsl #48
               	smulh	x3, x0, x3
               	add	x3, x3, x0
               	asr	x3, x3, #29
               	lsr	x4, x3, #63
               	add	x3, x3, x4
               	mov	x4, #0x0                // =0
               	sub	x3, x4, x3
               	mov	x17, #0x35f9            // =13817
               	movk	x17, #0xc465, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x3, x3, x17
               	sub	x3, x0, x3
               	ldur	x4, [x29, #-0x80]
               	sdiv	x17, x0, x4
               	msub	x0, x17, x4, x0
               	cmp	x3, x0
               	b.ne	<addr>
               	add	x1, x2, #0x1
               	sxtw	x2, w1
               	cmp	x2, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x0, #-0x8000000000000000 // =-9223372036854775808
               	stur	x0, [x29, #-0x78]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, x2, lsl #3]
               	asr	x3, x0, #63
               	lsr	x3, x3, #1
               	add	x3, x0, x3
               	asr	x3, x3, #63
               	mov	x4, #0x0                // =0
               	sub	x3, x4, x3
               	ldur	x4, [x29, #-0x78]
               	sdiv	x4, x0, x4
               	cmp	x3, x4
               	b.ne	<addr>
               	asr	x3, x0, #63
               	lsr	x3, x3, #1
               	add	x4, x0, x3
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0x7fff, lsl #48
               	and	x4, x4, x17
               	sub	x3, x4, x3
               	ldur	x4, [x29, #-0x78]
               	sdiv	x17, x0, x4
               	msub	x0, x17, x4, x0
               	cmp	x3, x0
               	b.ne	<addr>
               	add	x1, x2, #0x1
               	sxtw	x2, w1
               	cmp	x2, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x2, #0x1                // =1
               	stur	x2, [x29, #-0x70]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2, x1, lsl #3]
               	ldur	x3, [x29, #-0x70]
               	sdiv	x3, x2, x3
               	cmp	x2, x3
               	b.ne	<addr>
               	ldur	x3, [x29, #-0x70]
               	sdiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	cbnz	x2, <addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x400              // =1024
               	stur	x0, [x29, #-0x68]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, x2, lsl #3]
               	asr	x3, x0, #63
               	lsr	x3, x3, #54
               	add	x3, x0, x3
               	asr	x3, x3, #10
               	ldur	x4, [x29, #-0x68]
               	sdiv	x4, x0, x4
               	cmp	x3, x4
               	b.ne	<addr>
               	asr	x3, x0, #63
               	lsr	x3, x3, #54
               	add	x4, x0, x3
               	mov	x17, #0x3ff             // =1023
               	and	x4, x4, x17
               	sub	x3, x4, x3
               	ldur	x4, [x29, #-0x68]
               	sdiv	x17, x0, x4
               	msub	x0, x17, x4, x0
               	cmp	x3, x0
               	b.ne	<addr>
               	add	x1, x2, #0x1
               	sxtw	x2, w1
               	cmp	x2, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x0, #0xfc00             // =64512
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	stur	x0, [x29, #-0x60]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, x2, lsl #3]
               	asr	x3, x0, #63
               	lsr	x3, x3, #54
               	add	x3, x0, x3
               	asr	x3, x3, #10
               	mov	x4, #0x0                // =0
               	sub	x3, x4, x3
               	ldur	x4, [x29, #-0x60]
               	sdiv	x4, x0, x4
               	cmp	x3, x4
               	b.ne	<addr>
               	asr	x3, x0, #63
               	lsr	x3, x3, #54
               	add	x4, x0, x3
               	mov	x17, #0x3ff             // =1023
               	and	x4, x4, x17
               	sub	x3, x4, x3
               	ldur	x4, [x29, #-0x60]
               	sdiv	x17, x0, x4
               	msub	x0, x17, x4, x0
               	cmp	x3, x0
               	b.ne	<addr>
               	add	x1, x2, #0x1
               	sxtw	x2, w1
               	cmp	x2, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x3                // =3
               	stur	x1, [x29, #-0x58]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1, x2, lsl #3]
               	mov	x3, #0xaaab             // =43691
               	movk	x3, #0xaaaa, lsl #16
               	movk	x3, #0xaaaa, lsl #32
               	movk	x3, #0xaaaa, lsl #48
               	umulh	x3, x1, x3
               	lsr	x3, x3, #1
               	ldur	x4, [x29, #-0x58]
               	udiv	x4, x1, x4
               	cmp	x3, x4
               	b.ne	<addr>
               	mov	x3, #0xaaab             // =43691
               	movk	x3, #0xaaaa, lsl #16
               	movk	x3, #0xaaaa, lsl #32
               	movk	x3, #0xaaaa, lsl #48
               	umulh	x3, x1, x3
               	lsr	x3, x3, #1
               	mov	x17, #0x3               // =3
               	mul	x3, x3, x17
               	sub	x3, x1, x3
               	ldur	x4, [x29, #-0x58]
               	udiv	x17, x1, x4
               	msub	x1, x17, x4, x1
               	cmp	x3, x1
               	b.ne	<addr>
               	add	x0, x2, #0x1
               	sxtw	x2, w0
               	cmp	x2, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x7                // =7
               	stur	x0, [x29, #-0x50]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, x2, lsl #3]
               	mov	x3, #0x2493             // =9363
               	movk	x3, #0x9249, lsl #16
               	movk	x3, #0x4924, lsl #32
               	movk	x3, #0x2492, lsl #48
               	umulh	x3, x0, x3
               	sub	x4, x0, x3
               	lsr	x4, x4, #1
               	add	x3, x4, x3
               	lsr	x3, x3, #2
               	ldur	x4, [x29, #-0x50]
               	udiv	x4, x0, x4
               	cmp	x3, x4
               	b.ne	<addr>
               	mov	x3, #0x2493             // =9363
               	movk	x3, #0x9249, lsl #16
               	movk	x3, #0x4924, lsl #32
               	movk	x3, #0x2492, lsl #48
               	umulh	x3, x0, x3
               	sub	x4, x0, x3
               	lsr	x4, x4, #1
               	add	x3, x4, x3
               	lsr	x3, x3, #2
               	mov	x17, #0x7               // =7
               	mul	x3, x3, x17
               	sub	x3, x0, x3
               	ldur	x4, [x29, #-0x50]
               	udiv	x17, x0, x4
               	msub	x0, x17, x4, x0
               	cmp	x3, x0
               	b.ne	<addr>
               	add	x1, x2, #0x1
               	sxtw	x2, w1
               	cmp	x2, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x1, #0xa                // =10
               	stur	x1, [x29, #-0x48]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1, x2, lsl #3]
               	lsr	x3, x1, #1
               	mov	x4, #0x6667             // =26215
               	movk	x4, #0x6666, lsl #16
               	movk	x4, #0x6666, lsl #32
               	movk	x4, #0x6666, lsl #48
               	umulh	x3, x3, x4
               	lsr	x3, x3, #1
               	ldur	x4, [x29, #-0x48]
               	udiv	x4, x1, x4
               	cmp	x3, x4
               	b.ne	<addr>
               	lsr	x3, x1, #1
               	mov	x4, #0x6667             // =26215
               	movk	x4, #0x6666, lsl #16
               	movk	x4, #0x6666, lsl #32
               	movk	x4, #0x6666, lsl #48
               	umulh	x3, x3, x4
               	lsr	x3, x3, #1
               	mov	x17, #0xa               // =10
               	mul	x3, x3, x17
               	sub	x3, x1, x3
               	ldur	x4, [x29, #-0x48]
               	udiv	x17, x1, x4
               	msub	x1, x17, x4, x1
               	cmp	x3, x1
               	b.ne	<addr>
               	add	x0, x2, #0x1
               	sxtw	x2, w0
               	cmp	x2, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x1, #0xe                // =14
               	stur	x1, [x29, #-0x40]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1, x2, lsl #3]
               	lsr	x3, x1, #1
               	mov	x4, #0x4925             // =18725
               	movk	x4, #0x2492, lsl #16
               	movk	x4, #0x9249, lsl #32
               	movk	x4, #0x4924, lsl #48
               	umulh	x3, x3, x4
               	lsr	x3, x3, #1
               	ldur	x4, [x29, #-0x40]
               	udiv	x4, x1, x4
               	cmp	x3, x4
               	b.ne	<addr>
               	lsr	x3, x1, #1
               	mov	x4, #0x4925             // =18725
               	movk	x4, #0x2492, lsl #16
               	movk	x4, #0x9249, lsl #32
               	movk	x4, #0x4924, lsl #48
               	umulh	x3, x3, x4
               	lsr	x3, x3, #1
               	mov	x17, #0xe               // =14
               	mul	x3, x3, x17
               	sub	x3, x1, x3
               	ldur	x4, [x29, #-0x40]
               	udiv	x17, x1, x4
               	msub	x1, x17, x4, x1
               	cmp	x3, x1
               	b.ne	<addr>
               	add	x0, x2, #0x1
               	sxtw	x2, w0
               	cmp	x2, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x1, #0xca07             // =51719
               	movk	x1, #0x3b9a, lsl #16
               	stur	x1, [x29, #-0x38]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1, x2, lsl #3]
               	mov	x3, #0x8fe5             // =36837
               	movk	x3, #0x12a2, lsl #16
               	movk	x3, #0x5f31, lsl #32
               	movk	x3, #0x8970, lsl #48
               	umulh	x3, x1, x3
               	lsr	x3, x3, #29
               	ldur	x4, [x29, #-0x38]
               	udiv	x4, x1, x4
               	cmp	x3, x4
               	b.ne	<addr>
               	mov	x3, #0x8fe5             // =36837
               	movk	x3, #0x12a2, lsl #16
               	movk	x3, #0x5f31, lsl #32
               	movk	x3, #0x8970, lsl #48
               	umulh	x3, x1, x3
               	lsr	x3, x3, #29
               	mov	x17, #0xca07            // =51719
               	movk	x17, #0x3b9a, lsl #16
               	mul	x3, x3, x17
               	sub	x3, x1, x3
               	ldur	x4, [x29, #-0x38]
               	udiv	x17, x1, x4
               	msub	x1, x17, x4, x1
               	cmp	x3, x1
               	b.ne	<addr>
               	add	x0, x2, #0x1
               	sxtw	x2, w0
               	cmp	x2, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x1                // =1
               	movk	x1, #0x8000, lsl #48
               	stur	x1, [x29, #-0x30]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1, x2, lsl #3]
               	mov	x17, #0x1               // =1
               	movk	x17, #0x8000, lsl #48
               	cmp	x1, x17
               	cset	x3, hs
               	ldur	x4, [x29, #-0x30]
               	udiv	x4, x1, x4
               	cmp	x3, x4
               	b.ne	<addr>
               	mov	x17, #0x1               // =1
               	movk	x17, #0x8000, lsl #48
               	cmp	x1, x17
               	cset	x3, hs
               	mov	x17, #0x1               // =1
               	movk	x17, #0x8000, lsl #48
               	mul	x3, x3, x17
               	sub	x3, x1, x3
               	ldur	x4, [x29, #-0x30]
               	udiv	x17, x1, x4
               	msub	x1, x17, x4, x1
               	cmp	x3, x1
               	b.ne	<addr>
               	add	x0, x2, #0x1
               	sxtw	x2, w0
               	cmp	x2, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x1, #0xfffb             // =65531
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	stur	x1, [x29, #-0x28]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1, x2, lsl #3]
               	mov	x17, #0xfffb            // =65531
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x1, x17
               	cset	x3, hs
               	ldur	x4, [x29, #-0x28]
               	udiv	x4, x1, x4
               	cmp	x3, x4
               	b.ne	<addr>
               	mov	x17, #0xfffb            // =65531
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x1, x17
               	cset	x3, hs
               	mov	x17, #0xfffb            // =65531
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x3, x3, x17
               	sub	x3, x1, x3
               	ldur	x4, [x29, #-0x28]
               	udiv	x17, x1, x4
               	msub	x1, x17, x4, x1
               	cmp	x3, x1
               	b.ne	<addr>
               	add	x0, x2, #0x1
               	sxtw	x2, w0
               	cmp	x2, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x2, #0x1                // =1
               	stur	x2, [x29, #-0x20]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2, x1, lsl #3]
               	ldur	x3, [x29, #-0x20]
               	udiv	x3, x2, x3
               	cmp	x2, x3
               	b.ne	<addr>
               	ldur	x3, [x29, #-0x20]
               	udiv	x17, x2, x3
               	msub	x2, x17, x3, x2
               	cbnz	x2, <addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x2, #0x400              // =1024
               	stur	x2, [x29, #-0x18]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2, x1, lsl #3]
               	lsr	x3, x2, #10
               	ldur	x4, [x29, #-0x18]
               	udiv	x4, x2, x4
               	cmp	x3, x4
               	b.ne	<addr>
               	mov	x17, #0x3ff             // =1023
               	and	x3, x2, x17
               	ldur	x4, [x29, #-0x18]
               	udiv	x17, x2, x4
               	msub	x2, x17, x4, x2
               	cmp	x3, x2
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x14
               	b.lt	<addr>
               	mov	x0, #0xcfc7             // =53191
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	stur	w0, [x29, #-0x10]
               	mov	x0, #0xfb35             // =64309
               	movk	x0, #0x8e04, lsl #16
               	movk	x0, #0xfee0, lsl #32
               	movk	x0, #0xffff, lsl #48
               	stur	x0, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x10]
               	mov	x1, #0x0                // =0
               	sub	x0, x1, x0
               	mov	x17, #0x3039            // =12345
               	cmp	x0, x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldursw	x0, [x29, #-0x10]
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x5a               // =90
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x8]
               	mov	x1, #0x0                // =0
               	sub	x0, x1, x0
               	mov	x17, #0x4cb             // =1227
               	movk	x17, #0x71fb, lsl #16
               	movk	x17, #0x11f, lsl #32
               	cmp	x0, x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldur	x0, [x29, #-0x8]
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x5b               // =91
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
