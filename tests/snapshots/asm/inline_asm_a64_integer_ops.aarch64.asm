
inline_asm_a64_integer_ops.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x5, [x0]
               	ldr	x6, [x0, #0x8]
               	ldr	x8, [x0, #0x10]
               	ldr	x1, [x0, #0x18]
               	ldr	x9, [x0, #0x20]
               	ldr	x10, [x0, #0x28]
               	mov	w7, w5
               	add	x0, x5, x6, lsl #4
               	add	x2, x5, x6, lsl #4
               	cmp	x0, x2
               	mov	x17, #0x1               // =1
               	csel	x4, xzr, x17, eq
               	sub	x2, x5, x6, lsr #8
               	cbz	x4, <addr>
               	add	x0, x5, w9, sxtw #2
               	cbz	x4, <addr>
               	add	x0, x5, #0x123
               	cbz	x4, <addr>
               	sub	x0, x5, #0x1, lsl #12   // =0x1000
               	cbz	x4, <addr>
               	mov	w0, w6
               	add	w0, w7, w0
               	cbz	x4, <addr>
               	and	x0, x5, x6
               	cbz	x4, <addr>
               	orr	x0, x5, x6, ror #12
               	cbz	x4, <addr>
               	eor	x0, x5, x6, asr #3
               	cbz	x4, <addr>
               	bic	x0, x5, x6
               	cbz	x4, <addr>
               	orn	x0, x5, x6
               	cbz	x4, <addr>
               	eon	x0, x5, x6
               	cbz	x4, <addr>
               	and	x0, x5, #0xff00ff00ff00ff00
               	cbz	x4, <addr>
               	mvn	x0, x5
               	cbz	x4, <addr>
               	neg	x0, x5
               	cbz	x4, <addr>
               	lsl	x0, x5, #7
               	cbz	x4, <addr>
               	lsr	x0, x5, #9
               	cbz	x4, <addr>
               	asr	x0, x6, #5
               	cbz	x4, <addr>
               	ror	x0, x5, #0x10
               	cbz	x4, <addr>
               	lsl	x0, x5, x8
               	cbz	x4, <addr>
               	mov	w0, w6
               	asr	w0, w0, w1
               	cbz	x4, <addr>
               	mul	x0, x5, x6
               	cbz	x4, <addr>
               	str	x5, [sp]
               	str	x6, [sp, #0x8]
               	str	x8, [sp, #0x10]
               	ldr	x1, [sp]
               	ldr	x2, [sp, #0x8]
               	ldr	x3, [sp, #0x10]
               	madd	x0, x1, x2, x3
               	cbz	x4, <addr>
               	str	x5, [sp]
               	str	x6, [sp, #0x8]
               	str	x8, [sp, #0x10]
               	ldr	x1, [sp]
               	ldr	x2, [sp, #0x8]
               	ldr	x3, [sp, #0x10]
               	msub	x0, x1, x2, x3
               	cbz	x4, <addr>
               	smull	x0, w9, w10
               	cbz	x4, <addr>
               	umull	x0, w9, w10
               	cbz	x4, <addr>
               	umulh	x0, x5, x6
               	cbz	x4, <addr>
               	smulh	x0, x5, x6
               	cbz	x4, <addr>
               	udiv	x1, x5, x10
               	cbz	x4, <addr>
               	sdiv	x1, x6, x10
               	cbz	x4, <addr>
               	mov	x16, #0x0               // =0
               	udiv	x0, x5, x16
               	cbz	x4, <addr>
               	clz	x0, x8
               	cbz	x4, <addr>
               	clz	w0, w8
               	cbz	x4, <addr>
               	cls	x0, x6
               	cbz	x4, <addr>
               	rbit	x0, x8
               	cbz	x4, <addr>
               	rev	x0, x5
               	cbz	x4, <addr>
               	rev	w0, w7
               	cbz	x4, <addr>
               	rev16	x0, x5
               	cbz	x4, <addr>
               	rev32	x0, x5
               	cbz	x4, <addr>
               	ubfx	x0, x5, #8, #12
               	cbz	x4, <addr>
               	asr	x0, x6, #60
               	cbz	x4, <addr>
               	ubfiz	x0, x5, #4, #8
               	cbz	x4, <addr>
               	sbfiz	x0, x5, #4, #4
               	cbz	x4, <addr>
               	mov	x0, x5
               	bfi	x0, x8, #8, #8
               	cbz	x4, <addr>
               	mov	x0, x5
               	bfxil	x0, x6, #4, #8
               	cbz	x4, <addr>
               	sxtw	x0, w9
               	cbz	x4, <addr>
               	uxtb	w0, w7
               	cbz	x4, <addr>
               	mov	x16, #0x8001            // =32769
               	sxth	x0, w16
               	cbz	x4, <addr>
               	extr	x0, x5, x6, #0x10
               	cbz	x4, <addr>
               	mov	x0, #0x12340000         // =305397760
               	movk	x0, #0x5678
               	cbz	x4, <addr>
               	mov	x0, #-0x1               // =-1
               	cbz	x4, <addr>
               	mov	x0, #-0x2               // =-2
               	cbz	x4, <addr>
               	mov	w0, #-0x2               // =-2
               	cbz	x4, <addr>
               	mov	x0, x5
               	nop
               	dmb	ish
               	cbz	x4, <addr>
               	mvn	x0, x5
               	cbz	x4, <addr>
               	mvn	w0, w7
               	cbz	x4, <addr>
               	mvn	x0, x5, lsl #4
               	cbz	x4, <addr>
               	mvn	w0, w7, ror #3
               	cbz	x4, <addr>
               	mvn	x0, x6, asr #63
               	cbz	x4, <addr>
               	mvn	w0, w7, lsr #17
               	cbz	x4, <addr>
               	mov	x0, x4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	lsr	x1, x7, #17
               	mvn	x1, x1
               	cmp	w0, w1
               	mov	x17, #0x3c              // =60
               	csel	x4, xzr, x17, eq
               	b	<addr>
               	asr	x1, x6, #63
               	mvn	x1, x1
               	cmp	x0, x1
               	mov	x17, #0x3b              // =59
               	csel	x4, xzr, x17, eq
               	b	<addr>
               	ror	w1, w7, #0x3
               	mvn	x1, x1
               	cmp	w0, w1
               	mov	x17, #0x3a              // =58
               	csel	x4, xzr, x17, eq
               	b	<addr>
               	lsl	x1, x5, #4
               	mvn	x1, x1
               	cmp	x0, x1
               	mov	x17, #0x39              // =57
               	csel	x4, xzr, x17, eq
               	b	<addr>
               	mvn	x1, x7
               	cmp	w0, w1
               	mov	x17, #0x38              // =56
               	csel	x4, xzr, x17, eq
               	b	<addr>
               	mvn	x1, x5
               	cmp	x0, x1
               	mov	x17, #0x37              // =55
               	csel	x4, xzr, x17, eq
               	b	<addr>
               	cmp	x0, x5
               	mov	x17, #0x36              // =54
               	csel	x4, xzr, x17, eq
               	b	<addr>
               	mov	x17, #0xfffffffe        // =4294967294
               	cmp	x0, x17
               	mov	x17, #0x35              // =53
               	csel	x4, xzr, x17, eq
               	b	<addr>
               	cmn	x0, #0x2
               	mov	x17, #0x34              // =52
               	csel	x4, xzr, x17, eq
               	b	<addr>
               	cmn	x0, #0x1
               	mov	x17, #0x33              // =51
               	csel	x4, xzr, x17, eq
               	b	<addr>
               	mov	x17, #0x5678            // =22136
               	movk	x17, #0x1234, lsl #16
               	cmp	x0, x17
               	mov	x17, #0x32              // =50
               	csel	x4, xzr, x17, eq
               	b	<addr>
               	lsr	x1, x6, #16
               	orr	x1, x1, x5, lsl #48
               	cmp	x0, x1
               	mov	x17, #0x31              // =49
               	csel	x4, xzr, x17, eq
               	b	<addr>
               	mov	x17, #-0x7fff           // =-32767
               	cmp	x0, x17
               	mov	x17, #0x30              // =48
               	csel	x4, xzr, x17, eq
               	b	<addr>
               	and	x1, x7, #0xff
               	cmp	w0, w1
               	mov	x17, #0x2f              // =47
               	csel	x4, xzr, x17, eq
               	b	<addr>
               	mov	x17, #-0x80000000       // =-2147483648
               	cmp	x0, x17
               	mov	x17, #0x2e              // =46
               	csel	x4, xzr, x17, eq
               	b	<addr>
               	and	x1, x5, #0xffffffffffffff00
               	ubfx	x2, x6, #4, #8
               	orr	x1, x1, x2
               	cmp	x0, x1
               	mov	x17, #0x2d              // =45
               	csel	x4, xzr, x17, eq
               	b	<addr>
               	and	x1, x5, #0xffffffffffff00ff
               	mov	x17, #0x500             // =1280
               	orr	x1, x1, x17
               	cmp	x0, x1
               	mov	x17, #0x2c              // =44
               	csel	x4, xzr, x17, eq
               	b	<addr>
               	cmn	x0, #0x10
               	mov	x17, #0x2b              // =43
               	csel	x4, xzr, x17, eq
               	b	<addr>
               	and	x1, x5, #0xff
               	lsl	x1, x1, #4
               	cmp	x0, x1
               	mov	x17, #0x2a              // =42
               	csel	x4, xzr, x17, eq
               	b	<addr>
               	cmn	x0, #0x1
               	mov	x17, #0x29              // =41
               	csel	x4, xzr, x17, eq
               	b	<addr>
               	ubfx	x1, x5, #8, #12
               	cmp	x0, x1
               	mov	x17, #0x28              // =40
               	csel	x4, xzr, x17, eq
               	b	<addr>
               	mov	x17, #0xab89            // =43913
               	movk	x17, #0xefcd, lsl #16
               	movk	x17, #0x2301, lsl #32
               	movk	x17, #0x6745, lsl #48
               	cmp	x0, x17
               	mov	x17, #0x27              // =39
               	csel	x4, xzr, x17, eq
               	b	<addr>
               	mov	x17, #0xefcd            // =61389
               	movk	x17, #0xab89, lsl #16
               	movk	x17, #0x6745, lsl #32
               	movk	x17, #0x2301, lsl #48
               	cmp	x0, x17
               	mov	x17, #0x26              // =38
               	csel	x4, xzr, x17, eq
               	b	<addr>
               	mov	x17, #0xab89            // =43913
               	movk	x17, #0xefcd, lsl #16
               	cmp	w0, w17
               	mov	x17, #0x25              // =37
               	csel	x4, xzr, x17, eq
               	b	<addr>
               	mov	x17, #0x2301            // =8961
               	movk	x17, #0x6745, lsl #16
               	movk	x17, #0xab89, lsl #32
               	movk	x17, #0xefcd, lsl #48
               	cmp	x0, x17
               	mov	x17, #0x24              // =36
               	csel	x4, xzr, x17, eq
               	b	<addr>
               	mov	x17, #-0x6000000000000000 // =-6917529027641081856
               	cmp	x0, x17
               	mov	x17, #0x23              // =35
               	csel	x4, xzr, x17, eq
               	b	<addr>
               	cmp	x0, #0x6
               	mov	x17, #0x22              // =34
               	csel	x4, xzr, x17, eq
               	b	<addr>
               	cmp	w0, #0x1d
               	mov	x17, #0x21              // =33
               	csel	x4, xzr, x17, eq
               	b	<addr>
               	cmp	x0, #0x3d
               	mov	x17, #0x20              // =32
               	csel	x4, xzr, x17, eq
               	b	<addr>
               	cmp	x0, #0x0
               	mov	x16, #0x1f              // =31
               	csel	x4, x16, xzr, ne
               	b	<addr>
               	mov	x0, #0x4925             // =18725
               	movk	x0, #0x2492, lsl #16
               	movk	x0, #0x9249, lsl #32
               	movk	x0, #0x4924, lsl #48
               	smulh	x0, x6, x0
               	asr	x0, x0, #1
               	add	x0, x0, x0, lsr #63
               	cmp	x1, x0
               	mov	x17, #0x1e              // =30
               	csel	x4, xzr, x17, eq
               	b	<addr>
               	mov	x0, #0x2493             // =9363
               	movk	x0, #0x9249, lsl #16
               	movk	x0, #0x4924, lsl #32
               	movk	x0, #0x2492, lsl #48
               	umulh	x0, x5, x0
               	sub	x2, x5, x0
               	add	x0, x0, x2, lsr #1
               	lsr	x0, x0, #2
               	cmp	x1, x0
               	mov	x17, #0x1d              // =29
               	csel	x4, xzr, x17, eq
               	b	<addr>
               	asr	x1, x5, #63
               	asr	x2, x6, #63
               	umulh	x3, x5, x6
               	madd	x2, x5, x2, x3
               	madd	x1, x1, x6, x2
               	cmp	x0, x1
               	mov	x17, #0x1c              // =28
               	csel	x4, xzr, x17, eq
               	b	<addr>
               	umulh	x1, x5, x6
               	cmp	x0, x1
               	mov	x17, #0x1b              // =27
               	csel	x4, xzr, x17, eq
               	b	<addr>
               	mov	w1, w9
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	cmp	x0, x1
               	mov	x17, #0x1a              // =26
               	csel	x4, xzr, x17, eq
               	b	<addr>
               	sxtw	x1, w9
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	cmp	x0, x1
               	mov	x17, #0x19              // =25
               	csel	x4, xzr, x17, eq
               	b	<addr>
               	msub	x1, x5, x6, x8
               	cmp	x0, x1
               	mov	x17, #0x18              // =24
               	csel	x4, xzr, x17, eq
               	b	<addr>
               	madd	x1, x5, x6, x8
               	cmp	x0, x1
               	mov	x17, #0x17              // =23
               	csel	x4, xzr, x17, eq
               	b	<addr>
               	mul	x1, x5, x6
               	cmp	x0, x1
               	mov	x17, #0x16              // =22
               	csel	x4, xzr, x17, eq
               	b	<addr>
               	sxtw	x1, w6
               	asr	x1, x1, #3
               	cmp	w0, w1
               	mov	x17, #0x15              // =21
               	csel	x4, xzr, x17, eq
               	b	<addr>
               	lsl	x2, x5, #5
               	cmp	x0, x2
               	mov	x17, #0x14              // =20
               	csel	x4, xzr, x17, eq
               	b	<addr>
               	ror	x2, x5, #0x10
               	cmp	x0, x2
               	mov	x17, #0x13              // =19
               	csel	x4, xzr, x17, eq
               	b	<addr>
               	asr	x2, x6, #5
               	cmp	x0, x2
               	mov	x17, #0x12              // =18
               	csel	x4, xzr, x17, eq
               	b	<addr>
               	lsr	x2, x5, #9
               	cmp	x0, x2
               	mov	x17, #0x11              // =17
               	csel	x4, xzr, x17, eq
               	b	<addr>
               	lsl	x2, x5, #7
               	cmp	x0, x2
               	mov	x17, #0x10              // =16
               	csel	x4, xzr, x17, eq
               	b	<addr>
               	neg	x2, x5
               	cmp	x0, x2
               	mov	x17, #0xf               // =15
               	csel	x4, xzr, x17, eq
               	b	<addr>
               	mvn	x2, x5
               	cmp	x0, x2
               	mov	x17, #0xe               // =14
               	csel	x4, xzr, x17, eq
               	b	<addr>
               	and	x2, x5, #0xff00ff00ff00ff00
               	cmp	x0, x2
               	mov	x17, #0xd               // =13
               	csel	x4, xzr, x17, eq
               	b	<addr>
               	mvn	x2, x6
               	eor	x2, x5, x2
               	cmp	x0, x2
               	mov	x17, #0xc               // =12
               	csel	x4, xzr, x17, eq
               	b	<addr>
               	mvn	x2, x6
               	orr	x2, x5, x2
               	cmp	x0, x2
               	mov	x17, #0xb               // =11
               	csel	x4, xzr, x17, eq
               	b	<addr>
               	mvn	x2, x6
               	and	x2, x5, x2
               	cmp	x0, x2
               	mov	x17, #0xa               // =10
               	csel	x4, xzr, x17, eq
               	b	<addr>
               	eor	x2, x5, x6, asr #3
               	cmp	x0, x2
               	mov	x17, #0x9               // =9
               	csel	x4, xzr, x17, eq
               	b	<addr>
               	ror	x2, x6, #0xc
               	orr	x2, x5, x2
               	cmp	x0, x2
               	mov	x17, #0x8               // =8
               	csel	x4, xzr, x17, eq
               	b	<addr>
               	and	x2, x5, x6
               	cmp	x0, x2
               	mov	x17, #0x7               // =7
               	csel	x4, xzr, x17, eq
               	b	<addr>
               	add	x2, x7, x6
               	cmp	w0, w2
               	mov	x17, #0x6               // =6
               	csel	x4, xzr, x17, eq
               	b	<addr>
               	sub	x2, x5, #0x1, lsl #12   // =0x1000
               	cmp	x0, x2
               	mov	x17, #0x5               // =5
               	csel	x4, xzr, x17, eq
               	b	<addr>
               	add	x2, x5, #0x123
               	cmp	x0, x2
               	mov	x17, #0x4               // =4
               	csel	x4, xzr, x17, eq
               	b	<addr>
               	sxtw	x2, w9
               	add	x2, x5, x2, lsl #2
               	cmp	x0, x2
               	mov	x17, #0x3               // =3
               	csel	x4, xzr, x17, eq
               	b	<addr>
               	sub	x0, x5, x6, lsr #8
               	cmp	x2, x0
               	mov	x17, #0x2               // =2
               	csel	x4, xzr, x17, eq
               	b	<addr>
