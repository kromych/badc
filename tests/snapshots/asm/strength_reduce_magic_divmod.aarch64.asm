
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
               	mov	x2, #0x1                // =1
               	str	x2, [x1, #0x8]
               	mov	x2, #-0x1               // =-1
               	str	x2, [x1, #0x10]
               	mov	x2, #0x2                // =2
               	str	x2, [x1, #0x18]
               	mov	x2, #-0x2               // =-2
               	str	x2, [x1, #0x20]
               	mov	x2, #0x7fffffff         // =2147483647
               	str	x2, [x1, #0x28]
               	mov	x2, #-0x80000000        // =-2147483648
               	str	x2, [x1, #0x30]
               	mov	x2, #0x7fffffffffffffff // =9223372036854775807
               	str	x2, [x1, #0x38]
               	mov	x2, #-0x8000000000000000 // =-9223372036854775808
               	str	x2, [x1, #0x40]
               	mov	x2, #0xca07             // =51719
               	movk	x2, #0x3b9a, lsl #16
               	str	x2, [x1, #0x48]
               	mov	x2, #-0xca07            // =-51719
               	movk	x2, #0xc465, lsl #16
               	str	x2, [x1, #0x50]
               	mov	x2, #0xffffffff         // =4294967295
               	str	x2, [x1, #0x58]
               	mov	x2, #0xbc00             // =48128
               	movk	x2, #0xbf46, lsl #16
               	movk	x2, #0xee21, lsl #32
               	movk	x2, #0x2cea, lsl #48
               	str	x2, [x1, #0x60]
               	mov	x2, #0x8d4f             // =36175
               	movk	x2, #0x1a1a, lsl #16
               	movk	x2, #0x754d, lsl #32
               	movk	x2, #0xaa80, lsl #48
               	str	x2, [x1, #0x68]
               	mov	x2, #0x8932             // =35122
               	movk	x2, #0x6d27, lsl #16
               	movk	x2, #0x904a, lsl #32
               	movk	x2, #0xb3c4, lsl #48
               	str	x2, [x1, #0x70]
               	mov	x2, #0x6d19             // =27929
               	movk	x2, #0x7684, lsl #16
               	movk	x2, #0xcf42, lsl #32
               	movk	x2, #0xbc69, lsl #48
               	str	x2, [x1, #0x78]
               	mov	x2, #0x15b4             // =5556
               	movk	x2, #0x6a5b, lsl #16
               	movk	x2, #0x2fd5, lsl #32
               	movk	x2, #0x377b, lsl #48
               	str	x2, [x1, #0x80]
               	mov	x2, #0x9df3             // =40435
               	movk	x2, #0xeaf2, lsl #16
               	movk	x2, #0x15de, lsl #32
               	movk	x2, #0x64d8, lsl #48
               	str	x2, [x1, #0x88]
               	mov	x2, #0xd206             // =53766
               	movk	x2, #0xb2d7, lsl #16
               	movk	x2, #0x100d, lsl #32
               	movk	x2, #0xf66e, lsl #48
               	str	x2, [x1, #0x90]
               	mov	x2, #0x665d             // =26205
               	movk	x2, #0x7e06, lsl #16
               	movk	x2, #0xe6a5, lsl #32
               	movk	x2, #0x1069, lsl #48
               	str	x2, [x1, #0x98]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	lsl	x2, x0, #3
               	add	x6, x3, x2
               	add	x2, x1, x2
               	ldr	x2, [x2]
               	str	x2, [x6]
               	ldr	x2, [x1, x0, lsl #3]
               	str	w2, [x4, x0, lsl #2]
               	ldr	x2, [x1, x0, lsl #3]
               	str	w2, [x5, x0, lsl #2]
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
               	mov	x0, #0x0                // =0
               	mov	x3, #0x3                // =3
               	mov	x4, #0x5556             // =21846
               	movk	x4, #0x5555, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, #0x3                // =3
               	str	w1, [sp, #0x8]
               	ldrsw	x1, [x5, x0, lsl #2]
               	mul	x2, x1, x4
               	asr	x2, x2, #32
               	lsr	x6, x2, #63
               	add	x2, x2, x6
               	ldrsw	x6, [sp, #0x8]
               	sdiv	x6, x1, x6
               	cmp	x2, x6
               	b.ne	<addr>
               	mul	x2, x2, x3
               	sub	x2, x1, x2
               	ldrsw	x6, [sp, #0x8]
               	sdiv	x17, x1, x6
               	msub	x1, x17, x6, x1
               	cmp	x2, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	mov	x3, #0x5                // =5
               	mov	x4, #0x6667             // =26215
               	movk	x4, #0x6666, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, #0x5                // =5
               	str	w1, [sp, #0x10]
               	ldrsw	x1, [x5, x0, lsl #2]
               	mul	x2, x1, x4
               	asr	x2, x2, #33
               	lsr	x6, x2, #63
               	add	x2, x2, x6
               	ldrsw	x6, [sp, #0x10]
               	sdiv	x6, x1, x6
               	cmp	x2, x6
               	b.ne	<addr>
               	mul	x2, x2, x3
               	sub	x2, x1, x2
               	ldrsw	x6, [sp, #0x10]
               	sdiv	x17, x1, x6
               	msub	x1, x17, x6, x1
               	cmp	x2, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	mov	x3, #0x6                // =6
               	mov	x4, #0xaaab             // =43691
               	movk	x4, #0x2aaa, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, #0x6                // =6
               	str	w1, [sp, #0x18]
               	ldrsw	x1, [x5, x0, lsl #2]
               	mul	x2, x1, x4
               	asr	x2, x2, #32
               	lsr	x6, x2, #63
               	add	x2, x2, x6
               	ldrsw	x6, [sp, #0x18]
               	sdiv	x6, x1, x6
               	cmp	x2, x6
               	b.ne	<addr>
               	mul	x2, x2, x3
               	sub	x2, x1, x2
               	ldrsw	x6, [sp, #0x18]
               	sdiv	x17, x1, x6
               	msub	x1, x17, x6, x1
               	cmp	x2, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x14
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
               	str	w1, [sp, #0x20]
               	ldrsw	x1, [x5, x0, lsl #2]
               	mul	x2, x1, x4
               	asr	x2, x2, #34
               	lsr	x6, x2, #63
               	add	x2, x2, x6
               	ldrsw	x6, [sp, #0x20]
               	sdiv	x6, x1, x6
               	cmp	x2, x6
               	b.ne	<addr>
               	mul	x2, x2, x3
               	sub	x2, x1, x2
               	ldrsw	x6, [sp, #0x20]
               	sdiv	x17, x1, x6
               	msub	x1, x17, x6, x1
               	cmp	x2, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x14
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
               	str	w1, [sp, #0x28]
               	ldrsw	x1, [x5, x0, lsl #2]
               	mul	x2, x1, x4
               	asr	x2, x2, #34
               	lsr	x6, x2, #63
               	add	x2, x2, x6
               	ldrsw	x6, [sp, #0x28]
               	sdiv	x6, x1, x6
               	cmp	x2, x6
               	b.ne	<addr>
               	mul	x2, x2, x3
               	sub	x2, x1, x2
               	ldrsw	x6, [sp, #0x28]
               	sdiv	x17, x1, x6
               	msub	x1, x17, x6, x1
               	cmp	x2, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	mov	x3, #0x64               // =100
               	mov	x4, #0x851f             // =34079
               	movk	x4, #0x51eb, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, #0x64               // =100
               	str	w1, [sp, #0x30]
               	ldrsw	x1, [x5, x0, lsl #2]
               	mul	x2, x1, x4
               	asr	x2, x2, #37
               	lsr	x6, x2, #63
               	add	x2, x2, x6
               	ldrsw	x6, [sp, #0x30]
               	sdiv	x6, x1, x6
               	cmp	x2, x6
               	b.ne	<addr>
               	mul	x2, x2, x3
               	sub	x2, x1, x2
               	ldrsw	x6, [sp, #0x30]
               	sdiv	x17, x1, x6
               	msub	x1, x17, x6, x1
               	cmp	x2, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	mov	x3, #0x3e8              // =1000
               	mov	x4, #0x4dd3             // =19923
               	movk	x4, #0x1062, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, #0x3e8              // =1000
               	str	w1, [sp, #0x38]
               	ldrsw	x1, [x5, x0, lsl #2]
               	mul	x2, x1, x4
               	asr	x2, x2, #38
               	lsr	x6, x2, #63
               	add	x2, x2, x6
               	ldrsw	x6, [sp, #0x38]
               	sdiv	x6, x1, x6
               	cmp	x2, x6
               	b.ne	<addr>
               	mul	x2, x2, x3
               	sub	x2, x1, x2
               	ldrsw	x6, [sp, #0x38]
               	sdiv	x17, x1, x6
               	msub	x1, x17, x6, x1
               	cmp	x2, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	mov	x3, #0xffff             // =65535
               	mov	x4, #0x8001             // =32769
               	movk	x4, #0x8000, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, #0xffff             // =65535
               	str	w1, [sp, #0x40]
               	ldrsw	x1, [x5, x0, lsl #2]
               	mul	x2, x1, x4
               	asr	x2, x2, #47
               	lsr	x6, x2, #63
               	add	x2, x2, x6
               	ldrsw	x6, [sp, #0x40]
               	sdiv	x6, x1, x6
               	cmp	x2, x6
               	b.ne	<addr>
               	mul	x2, x2, x3
               	sub	x2, x1, x2
               	ldrsw	x6, [sp, #0x40]
               	sdiv	x17, x1, x6
               	msub	x1, x17, x6, x1
               	cmp	x2, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	mov	x2, #0x1                // =1
               	movk	x2, #0x1, lsl #16
               	mov	x4, #0x8001             // =32769
               	movk	x4, #0x7fff, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	str	w2, [sp, #0x48]
               	ldrsw	x1, [x5, x0, lsl #2]
               	mul	x3, x1, x4
               	asr	x3, x3, #47
               	lsr	x6, x3, #63
               	add	x3, x3, x6
               	ldrsw	x6, [sp, #0x48]
               	sdiv	x6, x1, x6
               	cmp	x3, x6
               	b.ne	<addr>
               	mul	x3, x3, x2
               	sub	x3, x1, x3
               	ldrsw	x6, [sp, #0x48]
               	sdiv	x17, x1, x6
               	msub	x1, x17, x6, x1
               	cmp	x3, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x14
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
               	str	w1, [sp, #0x50]
               	ldrsw	x1, [x5, x0, lsl #2]
               	mul	x2, x1, x3
               	asr	x2, x2, #61
               	lsr	x6, x2, #63
               	add	x2, x2, x6
               	ldrsw	x6, [sp, #0x50]
               	sdiv	x6, x1, x6
               	cmp	x2, x6
               	b.ne	<addr>
               	mul	x2, x2, x4
               	sub	x2, x1, x2
               	ldrsw	x6, [sp, #0x50]
               	sdiv	x17, x1, x6
               	msub	x1, x17, x6, x1
               	cmp	x2, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x2, #0x0                // =0
               	mov	x4, #-0x3               // =-3
               	mov	x5, #0x5556             // =21846
               	movk	x5, #0x5555, lsl #16
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x2
               	mov	x1, #-0x3               // =-3
               	str	w1, [sp, #0x58]
               	ldrsw	x1, [x6, x0, lsl #2]
               	mul	x3, x1, x5
               	asr	x3, x3, #32
               	lsr	x7, x3, #63
               	add	x3, x3, x7
               	sub	x3, x2, x3
               	ldrsw	x7, [sp, #0x58]
               	sdiv	x7, x1, x7
               	cmp	x3, x7
               	b.ne	<addr>
               	mul	x3, x3, x4
               	sub	x3, x1, x3
               	ldrsw	x7, [sp, #0x58]
               	sdiv	x17, x1, x7
               	msub	x1, x17, x7, x1
               	cmp	x3, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x14
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
               	str	w1, [sp, #0x60]
               	ldrsw	x1, [x6, x0, lsl #2]
               	mul	x3, x1, x5
               	asr	x3, x3, #34
               	lsr	x7, x3, #63
               	add	x3, x3, x7
               	sub	x3, x2, x3
               	ldrsw	x7, [sp, #0x60]
               	sdiv	x7, x1, x7
               	cmp	x3, x7
               	b.ne	<addr>
               	mul	x3, x3, x4
               	sub	x3, x1, x3
               	ldrsw	x7, [sp, #0x60]
               	sdiv	x17, x1, x7
               	msub	x1, x17, x7, x1
               	cmp	x3, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x2, #0x0                // =0
               	mov	x4, #-0x64              // =-100
               	mov	x5, #0x851f             // =34079
               	movk	x5, #0x51eb, lsl #16
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x2
               	mov	x1, #-0x64              // =-100
               	str	w1, [sp, #0x68]
               	ldrsw	x1, [x6, x0, lsl #2]
               	mul	x3, x1, x5
               	asr	x3, x3, #37
               	lsr	x7, x3, #63
               	add	x3, x3, x7
               	sub	x3, x2, x3
               	ldrsw	x7, [sp, #0x68]
               	sdiv	x7, x1, x7
               	cmp	x3, x7
               	b.ne	<addr>
               	mul	x3, x3, x4
               	sub	x3, x1, x3
               	ldrsw	x7, [sp, #0x68]
               	sdiv	x17, x1, x7
               	msub	x1, x17, x7, x1
               	cmp	x3, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x14
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
               	str	w1, [sp, #0x70]
               	ldrsw	x1, [x5, x0, lsl #2]
               	lsr	x3, x1, #33
               	add	x4, x1, x3
               	asr	x6, x4, #31
               	sub	x6, x2, x6
               	ldrsw	x7, [sp, #0x70]
               	sdiv	x7, x1, x7
               	cmp	x6, x7
               	b.ne	<addr>
               	and	x4, x4, #0x7fffffff
               	sub	x3, x4, x3
               	ldrsw	x4, [sp, #0x70]
               	sdiv	x17, x1, x4
               	msub	x1, x17, x4, x1
               	cmp	x3, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x14
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
               	str	w1, [sp, #0x78]
               	ldrsw	x1, [x2, x0, lsl #2]
               	ldrsw	x3, [sp, #0x78]
               	sdiv	x3, x1, x3
               	cmp	x1, x3
               	b.ne	<addr>
               	ldrsw	x3, [sp, #0x78]
               	sdiv	x17, x1, x3
               	msub	x1, x17, x3, x1
               	cbnz	x1, <addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x14
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
               	str	w1, [sp, #0x80]
               	ldrsw	x1, [x4, x0, lsl #2]
               	lsr	x2, x1, #61
               	add	x3, x1, x2
               	asr	x5, x3, #3
               	ldrsw	x6, [sp, #0x80]
               	sdiv	x6, x1, x6
               	cmp	x5, x6
               	b.ne	<addr>
               	and	x3, x3, #0x7
               	sub	x2, x3, x2
               	ldrsw	x3, [sp, #0x80]
               	sdiv	x17, x1, x3
               	msub	x1, x17, x3, x1
               	cmp	x2, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x14
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
               	mov	x1, #-0x8               // =-8
               	str	w1, [sp, #0x88]
               	ldrsw	x1, [x5, x0, lsl #2]
               	lsr	x3, x1, #61
               	add	x4, x1, x3
               	asr	x6, x4, #3
               	sub	x6, x2, x6
               	ldrsw	x7, [sp, #0x88]
               	sdiv	x7, x1, x7
               	cmp	x6, x7
               	b.ne	<addr>
               	and	x4, x4, #0x7
               	sub	x3, x4, x3
               	ldrsw	x4, [sp, #0x88]
               	sdiv	x17, x1, x4
               	msub	x1, x17, x4, x1
               	cmp	x3, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x1, #0x40000000         // =1073741824
               	str	w1, [sp, #0x90]
               	ldrsw	x1, [x4, x0, lsl #2]
               	lsr	x2, x1, #34
               	add	x3, x1, x2
               	asr	x5, x3, #30
               	ldrsw	x6, [sp, #0x90]
               	sdiv	x6, x1, x6
               	cmp	x5, x6
               	b.ne	<addr>
               	and	x3, x3, #0x3fffffff
               	sub	x2, x3, x2
               	ldrsw	x3, [sp, #0x90]
               	sdiv	x17, x1, x3
               	msub	x1, x17, x3, x1
               	cmp	x2, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x14
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
               	str	w1, [sp, #0x98]
               	ldr	w1, [x5, x0, lsl #2]
               	mul	x2, x1, x4
               	lsr	x2, x2, #33
               	ldr	w6, [sp, #0x98]
               	udiv	x6, x1, x6
               	cmp	w2, w6
               	b.ne	<addr>
               	mul	x2, x2, x3
               	sub	x2, x1, x2
               	ldr	w6, [sp, #0x98]
               	udiv	x17, x1, x6
               	msub	x1, x17, x6, x1
               	cmp	x2, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x14
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
               	str	w1, [sp, #0xa0]
               	ldr	w1, [x5, x0, lsl #2]
               	mul	x2, x1, x4
               	lsr	x2, x2, #32
               	sub	x6, x1, x2
               	lsr	x6, x6, #1
               	add	x2, x6, x2
               	lsr	x2, x2, #2
               	ldr	w6, [sp, #0xa0]
               	udiv	x6, x1, x6
               	cmp	w2, w6
               	b.ne	<addr>
               	mul	x2, x2, x3
               	sub	x2, x1, x2
               	ldr	w6, [sp, #0xa0]
               	udiv	x17, x1, x6
               	msub	x1, x17, x6, x1
               	cmp	x2, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x14
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
               	str	w1, [sp, #0xa8]
               	ldr	w1, [x5, x0, lsl #2]
               	lsr	x2, x1, #1
               	mul	x2, x2, x4
               	lsr	x2, x2, #33
               	ldr	w6, [sp, #0xa8]
               	udiv	x6, x1, x6
               	cmp	w2, w6
               	b.ne	<addr>
               	mul	x2, x2, x3
               	sub	x2, x1, x2
               	ldr	w6, [sp, #0xa8]
               	udiv	x17, x1, x6
               	msub	x1, x17, x6, x1
               	cmp	x2, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	mov	x3, #0xe                // =14
               	mov	x4, #0x2493             // =9363
               	movk	x4, #0x9249, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, #0xe                // =14
               	stur	w1, [x29, #-0x100]
               	ldr	w1, [x5, x0, lsl #2]
               	lsr	x2, x1, #1
               	mul	x2, x2, x4
               	lsr	x2, x2, #34
               	ldur	w6, [x29, #-0x100]
               	udiv	x6, x1, x6
               	cmp	w2, w6
               	b.ne	<addr>
               	mul	x2, x2, x3
               	sub	x2, x1, x2
               	ldur	w6, [x29, #-0x100]
               	udiv	x17, x1, x6
               	msub	x1, x17, x6, x1
               	cmp	x2, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	mov	x3, #0x64               // =100
               	mov	x4, #0x70a4             // =28836
               	movk	x4, #0xa3d, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, #0x64               // =100
               	stur	w1, [x29, #-0xf8]
               	ldr	w1, [x5, x0, lsl #2]
               	lsr	x2, x1, #2
               	mul	x2, x2, x4
               	lsr	x2, x2, #32
               	ldur	w6, [x29, #-0xf8]
               	udiv	x6, x1, x6
               	cmp	w2, w6
               	b.ne	<addr>
               	mul	x2, x2, x3
               	sub	x2, x1, x2
               	ldur	w6, [x29, #-0xf8]
               	udiv	x17, x1, x6
               	msub	x1, x17, x6, x1
               	cmp	x2, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	mov	x3, #0x3e8              // =1000
               	mov	x4, #0x4dd3             // =19923
               	movk	x4, #0x1062, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, #0x3e8              // =1000
               	stur	w1, [x29, #-0xf0]
               	ldr	w1, [x5, x0, lsl #2]
               	lsr	x2, x1, #3
               	mul	x2, x2, x4
               	lsr	x2, x2, #35
               	ldur	w6, [x29, #-0xf0]
               	udiv	x6, x1, x6
               	cmp	w2, w6
               	b.ne	<addr>
               	mul	x2, x2, x3
               	sub	x2, x1, x2
               	ldur	w6, [x29, #-0xf0]
               	udiv	x17, x1, x6
               	msub	x1, x17, x6, x1
               	cmp	x2, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	mov	x3, #0x3                // =3
               	mov	x4, #0x7fffffff         // =2147483647
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, #0x7fffffff         // =2147483647
               	stur	w1, [x29, #-0xe8]
               	ldr	w1, [x5, x0, lsl #2]
               	mul	x2, x1, x3
               	lsr	x2, x2, #32
               	sub	x6, x1, x2
               	lsr	x6, x6, #1
               	add	x2, x6, x2
               	lsr	x2, x2, #30
               	ldur	w6, [x29, #-0xe8]
               	udiv	x6, x1, x6
               	cmp	w2, w6
               	b.ne	<addr>
               	mul	x2, x2, x4
               	sub	x2, x1, x2
               	ldur	w6, [x29, #-0xe8]
               	udiv	x17, x1, x6
               	msub	x1, x17, x6, x1
               	cmp	x2, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x14
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
               	stur	w2, [x29, #-0xe0]
               	ldr	w1, [x4, x0, lsl #2]
               	cmp	w1, w2
               	cset	x3, hs
               	ldur	w5, [x29, #-0xe0]
               	udiv	x5, x1, x5
               	cmp	w3, w5
               	b.ne	<addr>
               	mul	x3, x3, x2
               	sub	x3, x1, x3
               	ldur	w5, [x29, #-0xe0]
               	udiv	x17, x1, x5
               	msub	x1, x17, x5, x1
               	cmp	x3, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	mov	x2, #0xfffb             // =65531
               	movk	x2, #0xffff, lsl #16
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	stur	w2, [x29, #-0xd8]
               	ldr	w1, [x4, x0, lsl #2]
               	cmp	w1, w2
               	cset	x3, hs
               	ldur	w5, [x29, #-0xd8]
               	udiv	x5, x1, x5
               	cmp	w3, w5
               	b.ne	<addr>
               	mul	x3, x3, x2
               	sub	x3, x1, x3
               	ldur	w5, [x29, #-0xd8]
               	udiv	x17, x1, x5
               	msub	x1, x17, x5, x1
               	cmp	x3, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x14
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
               	stur	w1, [x29, #-0xd0]
               	ldr	w1, [x2, x0, lsl #2]
               	ldur	w3, [x29, #-0xd0]
               	udiv	x3, x1, x3
               	cmp	w1, w3
               	b.ne	<addr>
               	ldur	w3, [x29, #-0xd0]
               	udiv	x17, x1, x3
               	msub	x1, x17, x3, x1
               	cbnz	x1, <addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x14
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
               	stur	w1, [x29, #-0xc8]
               	ldr	w1, [x2, x0, lsl #2]
               	lsr	x3, x1, #4
               	ldur	w4, [x29, #-0xc8]
               	udiv	x4, x1, x4
               	cmp	w3, w4
               	b.ne	<addr>
               	and	x3, x1, #0xf
               	ldur	w4, [x29, #-0xc8]
               	udiv	x17, x1, x4
               	msub	x1, x17, x4, x1
               	cmp	x3, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x14
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
               	movk	x4, #0x5555, lsl #32
               	movk	x4, #0x5555, lsl #48
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, #0x3                // =3
               	stur	x1, [x29, #-0xc0]
               	ldr	x1, [x5, x0, lsl #3]
               	smulh	x2, x1, x4
               	lsr	x6, x2, #63
               	add	x2, x2, x6
               	ldur	x6, [x29, #-0xc0]
               	sdiv	x6, x1, x6
               	cmp	x2, x6
               	b.ne	<addr>
               	mul	x2, x2, x3
               	sub	x2, x1, x2
               	ldur	x6, [x29, #-0xc0]
               	sdiv	x17, x1, x6
               	msub	x1, x17, x6, x1
               	cmp	x2, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x14
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
               	movk	x4, #0x9249, lsl #32
               	movk	x4, #0x4924, lsl #48
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, #0x7                // =7
               	stur	x1, [x29, #-0xb8]
               	ldr	x1, [x5, x0, lsl #3]
               	smulh	x2, x1, x4
               	asr	x2, x2, #1
               	lsr	x6, x2, #63
               	add	x2, x2, x6
               	ldur	x6, [x29, #-0xb8]
               	sdiv	x6, x1, x6
               	cmp	x2, x6
               	b.ne	<addr>
               	mul	x2, x2, x3
               	sub	x2, x1, x2
               	ldur	x6, [x29, #-0xb8]
               	sdiv	x17, x1, x6
               	msub	x1, x17, x6, x1
               	cmp	x2, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x14
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
               	movk	x4, #0x6666, lsl #32
               	movk	x4, #0x6666, lsl #48
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, #0xa                // =10
               	stur	x1, [x29, #-0xb0]
               	ldr	x1, [x5, x0, lsl #3]
               	smulh	x2, x1, x4
               	asr	x2, x2, #2
               	lsr	x6, x2, #63
               	add	x2, x2, x6
               	ldur	x6, [x29, #-0xb0]
               	sdiv	x6, x1, x6
               	cmp	x2, x6
               	b.ne	<addr>
               	mul	x2, x2, x3
               	sub	x2, x1, x2
               	ldur	x6, [x29, #-0xb0]
               	sdiv	x17, x1, x6
               	msub	x1, x17, x6, x1
               	cmp	x2, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	mov	x3, #0x3e8              // =1000
               	mov	x4, #0xf7cf             // =63439
               	movk	x4, #0xe353, lsl #16
               	movk	x4, #0x9ba5, lsl #32
               	movk	x4, #0x20c4, lsl #48
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, #0x3e8              // =1000
               	stur	x1, [x29, #-0xa8]
               	ldr	x1, [x5, x0, lsl #3]
               	smulh	x2, x1, x4
               	asr	x2, x2, #7
               	lsr	x6, x2, #63
               	add	x2, x2, x6
               	ldur	x6, [x29, #-0xa8]
               	sdiv	x6, x1, x6
               	cmp	x2, x6
               	b.ne	<addr>
               	mul	x2, x2, x3
               	sub	x2, x1, x2
               	ldur	x6, [x29, #-0xa8]
               	sdiv	x17, x1, x6
               	msub	x1, x17, x6, x1
               	cmp	x2, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	mov	x4, #0x8fe5             // =36837
               	movk	x4, #0x12a2, lsl #16
               	movk	x4, #0x5f31, lsl #32
               	movk	x4, #0x8970, lsl #48
               	mov	x2, #0xca07             // =51719
               	movk	x2, #0x3b9a, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	stur	x2, [x29, #-0xa0]
               	ldr	x1, [x5, x0, lsl #3]
               	smulh	x3, x1, x4
               	add	x3, x3, x1
               	asr	x3, x3, #29
               	lsr	x6, x3, #63
               	add	x3, x3, x6
               	ldur	x6, [x29, #-0xa0]
               	sdiv	x6, x1, x6
               	cmp	x3, x6
               	b.ne	<addr>
               	mul	x3, x3, x2
               	sub	x3, x1, x3
               	ldur	x6, [x29, #-0xa0]
               	sdiv	x17, x1, x6
               	msub	x1, x17, x6, x1
               	cmp	x3, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	mov	x3, #0x1                // =1
               	movk	x3, #0x4000, lsl #48
               	mov	x4, #0x7fffffffffffffff // =9223372036854775807
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, #0x7fffffffffffffff // =9223372036854775807
               	stur	x1, [x29, #-0x98]
               	ldr	x1, [x5, x0, lsl #3]
               	smulh	x2, x1, x3
               	asr	x2, x2, #61
               	lsr	x6, x2, #63
               	add	x2, x2, x6
               	ldur	x6, [x29, #-0x98]
               	sdiv	x6, x1, x6
               	cmp	x2, x6
               	b.ne	<addr>
               	mul	x2, x2, x4
               	sub	x2, x1, x2
               	ldur	x6, [x29, #-0x98]
               	sdiv	x17, x1, x6
               	msub	x1, x17, x6, x1
               	cmp	x2, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x2, #0x0                // =0
               	mov	x4, #-0x3               // =-3
               	mov	x5, #0x5556             // =21846
               	movk	x5, #0x5555, lsl #16
               	movk	x5, #0x5555, lsl #32
               	movk	x5, #0x5555, lsl #48
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x2
               	mov	x1, #-0x3               // =-3
               	stur	x1, [x29, #-0x90]
               	ldr	x1, [x6, x0, lsl #3]
               	smulh	x3, x1, x5
               	lsr	x7, x3, #63
               	add	x3, x3, x7
               	sub	x3, x2, x3
               	ldur	x7, [x29, #-0x90]
               	sdiv	x7, x1, x7
               	cmp	x3, x7
               	b.ne	<addr>
               	mul	x3, x3, x4
               	sub	x3, x1, x3
               	ldur	x7, [x29, #-0x90]
               	sdiv	x17, x1, x7
               	msub	x1, x17, x7, x1
               	cmp	x3, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x14
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
               	stur	x1, [x29, #-0x88]
               	ldr	x1, [x6, x0, lsl #3]
               	smulh	x3, x1, x5
               	asr	x3, x3, #1
               	lsr	x7, x3, #63
               	add	x3, x3, x7
               	sub	x3, x2, x3
               	ldur	x7, [x29, #-0x88]
               	sdiv	x7, x1, x7
               	cmp	x3, x7
               	b.ne	<addr>
               	mul	x3, x3, x4
               	sub	x3, x1, x3
               	ldur	x7, [x29, #-0x88]
               	sdiv	x17, x1, x7
               	msub	x1, x17, x7, x1
               	cmp	x3, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x2, #0x0                // =0
               	mov	x5, #0x8fe5             // =36837
               	movk	x5, #0x12a2, lsl #16
               	movk	x5, #0x5f31, lsl #32
               	movk	x5, #0x8970, lsl #48
               	mov	x3, #-0xca07            // =-51719
               	movk	x3, #0xc465, lsl #16
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x1, x2
               	stur	x3, [x29, #-0x80]
               	ldr	x0, [x6, x1, lsl #3]
               	smulh	x4, x0, x5
               	add	x4, x4, x0
               	asr	x4, x4, #29
               	lsr	x7, x4, #63
               	add	x4, x4, x7
               	sub	x4, x2, x4
               	ldur	x7, [x29, #-0x80]
               	sdiv	x7, x0, x7
               	cmp	x4, x7
               	b.ne	<addr>
               	mul	x4, x4, x3
               	sub	x4, x0, x4
               	ldur	x7, [x29, #-0x80]
               	sdiv	x17, x0, x7
               	msub	x0, x17, x7, x0
               	cmp	x4, x0
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x14
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
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	stur	x1, [x29, #-0x78]
               	ldr	x1, [x5, x0, lsl #3]
               	asr	x3, x1, #63
               	lsr	x3, x3, #1
               	add	x4, x1, x3
               	asr	x6, x4, #63
               	sub	x6, x2, x6
               	ldur	x7, [x29, #-0x78]
               	sdiv	x7, x1, x7
               	cmp	x6, x7
               	b.ne	<addr>
               	and	x4, x4, #0x7fffffffffffffff
               	sub	x3, x4, x3
               	ldur	x4, [x29, #-0x78]
               	sdiv	x17, x1, x4
               	msub	x1, x17, x4, x1
               	cmp	x3, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x14
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
               	stur	x1, [x29, #-0x70]
               	ldr	x1, [x2, x0, lsl #3]
               	ldur	x3, [x29, #-0x70]
               	sdiv	x3, x1, x3
               	cmp	x1, x3
               	b.ne	<addr>
               	ldur	x3, [x29, #-0x70]
               	sdiv	x17, x1, x3
               	msub	x1, x17, x3, x1
               	cbnz	x1, <addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x1, #0x400              // =1024
               	stur	x1, [x29, #-0x68]
               	ldr	x1, [x4, x0, lsl #3]
               	asr	x2, x1, #63
               	lsr	x2, x2, #54
               	add	x3, x1, x2
               	asr	x5, x3, #10
               	ldur	x6, [x29, #-0x68]
               	sdiv	x6, x1, x6
               	cmp	x5, x6
               	b.ne	<addr>
               	and	x3, x3, #0x3ff
               	sub	x2, x3, x2
               	ldur	x3, [x29, #-0x68]
               	sdiv	x17, x1, x3
               	msub	x1, x17, x3, x1
               	cmp	x2, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x14
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
               	mov	x1, #-0x400             // =-1024
               	stur	x1, [x29, #-0x60]
               	ldr	x1, [x5, x0, lsl #3]
               	asr	x3, x1, #63
               	lsr	x3, x3, #54
               	add	x4, x1, x3
               	asr	x6, x4, #10
               	sub	x6, x2, x6
               	ldur	x7, [x29, #-0x60]
               	sdiv	x7, x1, x7
               	cmp	x6, x7
               	b.ne	<addr>
               	and	x4, x4, #0x3ff
               	sub	x3, x4, x3
               	ldur	x4, [x29, #-0x60]
               	sdiv	x17, x1, x4
               	msub	x1, x17, x4, x1
               	cmp	x3, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	mov	x3, #0xaaab             // =43691
               	movk	x3, #0xaaaa, lsl #16
               	movk	x3, #0xaaaa, lsl #32
               	movk	x3, #0xaaaa, lsl #48
               	mov	x4, #0x3                // =3
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, #0x3                // =3
               	stur	x1, [x29, #-0x58]
               	ldr	x1, [x5, x0, lsl #3]
               	umulh	x2, x1, x3
               	lsr	x2, x2, #1
               	ldur	x6, [x29, #-0x58]
               	udiv	x6, x1, x6
               	cmp	x2, x6
               	b.ne	<addr>
               	mul	x2, x2, x4
               	sub	x2, x1, x2
               	ldur	x6, [x29, #-0x58]
               	udiv	x17, x1, x6
               	msub	x1, x17, x6, x1
               	cmp	x2, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x14
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
               	stur	x1, [x29, #-0x50]
               	ldr	x1, [x5, x0, lsl #3]
               	umulh	x2, x1, x4
               	sub	x6, x1, x2
               	lsr	x6, x6, #1
               	add	x2, x6, x2
               	lsr	x2, x2, #2
               	ldur	x6, [x29, #-0x50]
               	udiv	x6, x1, x6
               	cmp	x2, x6
               	b.ne	<addr>
               	mul	x2, x2, x3
               	sub	x2, x1, x2
               	ldur	x6, [x29, #-0x50]
               	udiv	x17, x1, x6
               	msub	x1, x17, x6, x1
               	cmp	x2, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x14
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
               	movk	x4, #0x6666, lsl #32
               	movk	x4, #0x6666, lsl #48
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, #0xa                // =10
               	stur	x1, [x29, #-0x48]
               	ldr	x1, [x5, x0, lsl #3]
               	lsr	x2, x1, #1
               	umulh	x2, x2, x4
               	lsr	x2, x2, #1
               	ldur	x6, [x29, #-0x48]
               	udiv	x6, x1, x6
               	cmp	x2, x6
               	b.ne	<addr>
               	mul	x2, x2, x3
               	sub	x2, x1, x2
               	ldur	x6, [x29, #-0x48]
               	udiv	x17, x1, x6
               	msub	x1, x17, x6, x1
               	cmp	x2, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	mov	x3, #0xe                // =14
               	mov	x4, #0x4925             // =18725
               	movk	x4, #0x2492, lsl #16
               	movk	x4, #0x9249, lsl #32
               	movk	x4, #0x4924, lsl #48
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x1, #0xe                // =14
               	stur	x1, [x29, #-0x40]
               	ldr	x1, [x5, x0, lsl #3]
               	lsr	x2, x1, #1
               	umulh	x2, x2, x4
               	lsr	x2, x2, #1
               	ldur	x6, [x29, #-0x40]
               	udiv	x6, x1, x6
               	cmp	x2, x6
               	b.ne	<addr>
               	mul	x2, x2, x3
               	sub	x2, x1, x2
               	ldur	x6, [x29, #-0x40]
               	udiv	x17, x1, x6
               	msub	x1, x17, x6, x1
               	cmp	x2, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	mov	x4, #0x8fe5             // =36837
               	movk	x4, #0x12a2, lsl #16
               	movk	x4, #0x5f31, lsl #32
               	movk	x4, #0x8970, lsl #48
               	mov	x2, #0xca07             // =51719
               	movk	x2, #0x3b9a, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	stur	x2, [x29, #-0x38]
               	ldr	x1, [x5, x0, lsl #3]
               	umulh	x3, x1, x4
               	lsr	x3, x3, #29
               	ldur	x6, [x29, #-0x38]
               	udiv	x6, x1, x6
               	cmp	x3, x6
               	b.ne	<addr>
               	mul	x3, x3, x2
               	sub	x3, x1, x3
               	ldur	x6, [x29, #-0x38]
               	udiv	x17, x1, x6
               	msub	x1, x17, x6, x1
               	cmp	x3, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	mov	x2, #-0x7fffffffffffffff // =-9223372036854775807
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x1, #-0x7fffffffffffffff // =-9223372036854775807
               	stur	x1, [x29, #-0x30]
               	ldr	x1, [x4, x0, lsl #3]
               	cmp	x1, x2
               	cset	x3, hs
               	ldur	x5, [x29, #-0x30]
               	udiv	x5, x1, x5
               	cmp	x3, x5
               	b.ne	<addr>
               	mul	x3, x3, x2
               	sub	x3, x1, x3
               	ldur	x5, [x29, #-0x30]
               	udiv	x17, x1, x5
               	msub	x1, x17, x5, x1
               	cmp	x3, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	mov	x2, #-0x5               // =-5
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x1, #-0x5               // =-5
               	stur	x1, [x29, #-0x28]
               	ldr	x1, [x4, x0, lsl #3]
               	cmp	x1, x2
               	cset	x3, hs
               	ldur	x5, [x29, #-0x28]
               	udiv	x5, x1, x5
               	cmp	x3, x5
               	b.ne	<addr>
               	mul	x3, x3, x2
               	sub	x3, x1, x3
               	ldur	x5, [x29, #-0x28]
               	udiv	x17, x1, x5
               	msub	x1, x17, x5, x1
               	cmp	x3, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x14
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
               	stur	x1, [x29, #-0x20]
               	ldr	x1, [x2, x0, lsl #3]
               	ldur	x3, [x29, #-0x20]
               	udiv	x3, x1, x3
               	cmp	x1, x3
               	b.ne	<addr>
               	ldur	x3, [x29, #-0x20]
               	udiv	x17, x1, x3
               	msub	x1, x17, x3, x1
               	cbnz	x1, <addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x1, #0x400              // =1024
               	stur	x1, [x29, #-0x18]
               	ldr	x1, [x2, x0, lsl #3]
               	lsr	x3, x1, #10
               	ldur	x4, [x29, #-0x18]
               	udiv	x4, x1, x4
               	cmp	x3, x4
               	b.ne	<addr>
               	and	x3, x1, #0x3ff
               	ldur	x4, [x29, #-0x18]
               	udiv	x17, x1, x4
               	msub	x1, x17, x4, x1
               	cmp	x3, x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x14
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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x64
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
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x1b0
               	ldp	x29, x30, [sp], #0x10
               	ret
