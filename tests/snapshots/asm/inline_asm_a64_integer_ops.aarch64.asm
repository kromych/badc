
inline_asm_a64_integer_ops.aarch64:	file format elf64-littleaarch64

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

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x5, [x0]
               	ldr	x6, [x0, #0x8]
               	ldr	x7, [x0, #0x10]
               	ldr	x1, [x0, #0x18]
               	ldr	x8, [x0, #0x20]
               	ldr	x9, [x0, #0x28]
               	add	x0, x5, x6, lsl #4
               	lsl	x2, x6, #4
               	add	x2, x5, x2
               	mov	x4, #0x1                // =1
               	cmp	x0, x2
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	sub	x2, x5, x6, lsr #8
               	cbz	x4, <addr>
               	add	x0, x5, w8, sxtw #2
               	cbz	x4, <addr>
               	add	x0, x5, #0x123
               	cbz	x4, <addr>
               	sub	x0, x5, #0x1, lsl #12   // =0x1000
               	cbz	x4, <addr>
               	mov	w0, w5
               	mov	w2, w6
               	add	w0, w0, w2
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
               	lsl	x0, x5, x7
               	cbz	x4, <addr>
               	mov	w0, w6
               	asr	w0, w0, w1
               	cbz	x4, <addr>
               	mul	x0, x5, x6
               	cbz	x4, <addr>
               	str	x5, [sp]
               	str	x6, [sp, #0x8]
               	str	x7, [sp, #0x10]
               	ldr	x1, [sp]
               	ldr	x2, [sp, #0x8]
               	ldr	x3, [sp, #0x10]
               	madd	x0, x1, x2, x3
               	cbz	x4, <addr>
               	str	x5, [sp]
               	str	x6, [sp, #0x8]
               	str	x7, [sp, #0x10]
               	ldr	x1, [sp]
               	ldr	x2, [sp, #0x8]
               	ldr	x3, [sp, #0x10]
               	msub	x0, x1, x2, x3
               	cbz	x4, <addr>
               	smull	x0, w8, w9
               	cbz	x4, <addr>
               	umull	x0, w8, w9
               	cbz	x4, <addr>
               	umulh	x1, x5, x6
               	cbz	x4, <addr>
               	smulh	x0, x5, x6
               	cbz	x4, <addr>
               	udiv	x1, x5, x9
               	cbz	x4, <addr>
               	sdiv	x1, x6, x9
               	cbz	x4, <addr>
               	mov	x16, #0x0               // =0
               	udiv	x0, x5, x16
               	cbz	x4, <addr>
               	clz	x0, x7
               	cbz	x4, <addr>
               	clz	w0, w7
               	cbz	x4, <addr>
               	cls	x0, x6
               	cbz	x4, <addr>
               	rbit	x0, x7
               	cbz	x4, <addr>
               	rev	x0, x5
               	cbz	x4, <addr>
               	mov	w0, w5
               	rev	w0, w0
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
               	str	x5, [sp]
               	str	x7, [sp, #0x8]
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x8]
               	bfi	x0, x1, #8, #8
               	cbz	x4, <addr>
               	str	x5, [sp]
               	str	x6, [sp, #0x8]
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x8]
               	bfxil	x0, x1, #4, #8
               	cbz	x4, <addr>
               	sxtw	x0, w8
               	cbz	x4, <addr>
               	mov	w0, w5
               	uxtb	w0, w0
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
               	mov	w0, w5
               	mvn	w0, w0
               	cbz	x4, <addr>
               	mvn	x0, x5, lsl #4
               	cbz	x4, <addr>
               	mov	w0, w5
               	mvn	w1, w0, ror #3
               	cbz	x4, <addr>
               	mvn	x0, x6, asr #63
               	cbz	x4, <addr>
               	mov	w0, w5
               	mvn	w0, w0, lsr #17
               	cbz	x4, <addr>
               	mov	x0, x4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	w1, w5
               	lsr	x1, x1, #17
               	mvn	x1, x1
               	mov	x4, #0x3c               // =60
               	cmp	w0, w1
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	asr	x1, x6, #63
               	mvn	x1, x1
               	mov	x4, #0x3b               // =59
               	cmp	x0, x1
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	mov	w0, w5
               	lsr	x2, x0, #3
               	lsl	x0, x0, #29
               	orr	x0, x2, x0
               	mvn	x0, x0
               	mov	x4, #0x3a               // =58
               	cmp	w1, w0
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	lsl	x1, x5, #4
               	mvn	x1, x1
               	mov	x4, #0x39               // =57
               	cmp	x0, x1
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	mvn	x1, x5
               	mov	x4, #0x38               // =56
               	cmp	w0, w1
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	mvn	x1, x5
               	mov	x4, #0x37               // =55
               	cmp	x0, x1
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	mov	x4, #0x36               // =54
               	cmp	x0, x5
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	mov	x4, #0x35               // =53
               	mov	x17, #0xfffffffe        // =4294967294
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	mov	x4, #0x34               // =52
               	mov	x17, #-0x2              // =-2
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	mov	x4, #0x33               // =51
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	mov	x4, #0x32               // =50
               	mov	x17, #0x5678            // =22136
               	movk	x17, #0x1234, lsl #16
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	lsr	x1, x6, #16
               	lsl	x2, x5, #48
               	orr	x1, x1, x2
               	mov	x4, #0x31               // =49
               	cmp	x0, x1
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	mov	x4, #0x30               // =48
               	mov	x17, #-0x7fff           // =-32767
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	and	x1, x5, #0xff
               	mov	x4, #0x2f               // =47
               	cmp	w0, w1
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	mov	x4, #0x2e               // =46
               	mov	x17, #-0x80000000       // =-2147483648
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	and	x1, x5, #0xffffffffffffff00
               	lsr	x2, x6, #4
               	and	x2, x2, #0xff
               	orr	x1, x1, x2
               	mov	x4, #0x2d               // =45
               	cmp	x0, x1
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	and	x1, x5, #0xffffffffffff00ff
               	mov	x17, #0x500             // =1280
               	orr	x1, x1, x17
               	mov	x4, #0x2c               // =44
               	cmp	x0, x1
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	mov	x4, #0x2b               // =43
               	mov	x17, #-0x10             // =-16
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	and	x1, x5, #0xff
               	lsl	x1, x1, #4
               	mov	x4, #0x2a               // =42
               	cmp	x0, x1
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	mov	x4, #0x29               // =41
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	lsr	x1, x5, #8
               	and	x1, x1, #0xfff
               	mov	x4, #0x28               // =40
               	cmp	x0, x1
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	mov	x4, #0x27               // =39
               	mov	x17, #0xab89            // =43913
               	movk	x17, #0xefcd, lsl #16
               	movk	x17, #0x2301, lsl #32
               	movk	x17, #0x6745, lsl #48
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	mov	x4, #0x26               // =38
               	mov	x17, #0xefcd            // =61389
               	movk	x17, #0xab89, lsl #16
               	movk	x17, #0x6745, lsl #32
               	movk	x17, #0x2301, lsl #48
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	mov	x4, #0x25               // =37
               	mov	x17, #0xab89            // =43913
               	movk	x17, #0xefcd, lsl #16
               	cmp	w0, w17
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	mov	x4, #0x24               // =36
               	mov	x17, #0x2301            // =8961
               	movk	x17, #0x6745, lsl #16
               	movk	x17, #0xab89, lsl #32
               	movk	x17, #0xefcd, lsl #48
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	mov	x4, #0x23               // =35
               	mov	x17, #-0x6000000000000000 // =-6917529027641081856
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	mov	x4, #0x22               // =34
               	cmp	x0, #0x6
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	mov	x4, #0x21               // =33
               	cmp	w0, #0x1d
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	mov	x4, #0x20               // =32
               	cmp	x0, #0x3d
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	mov	x4, #0x1f               // =31
               	cbnz	x0, <addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x4925             // =18725
               	movk	x0, #0x2492, lsl #16
               	movk	x0, #0x9249, lsl #32
               	movk	x0, #0x4924, lsl #48
               	smulh	x0, x6, x0
               	asr	x0, x0, #1
               	lsr	x2, x0, #63
               	add	x0, x0, x2
               	mov	x4, #0x1e               // =30
               	cmp	x1, x0
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x2493             // =9363
               	movk	x0, #0x9249, lsl #16
               	movk	x0, #0x4924, lsl #32
               	movk	x0, #0x2492, lsl #48
               	umulh	x0, x5, x0
               	sub	x2, x5, x0
               	lsr	x2, x2, #1
               	add	x0, x2, x0
               	lsr	x0, x0, #2
               	mov	x4, #0x1d               // =29
               	cmp	x1, x0
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	asr	x1, x5, #63
               	asr	x2, x6, #63
               	umulh	x3, x5, x6
               	madd	x2, x5, x2, x3
               	madd	x1, x1, x6, x2
               	mov	x4, #0x1c               // =28
               	cmp	x0, x1
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	mov	x4, #0x0                // =0
               	umulh	x0, x5, x6
               	madd	x0, x5, x4, x0
               	madd	x2, x4, x6, x0
               	mov	x0, #0x1b               // =27
               	cmp	x1, x2
               	b.eq	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	w1, w8
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	mov	x4, #0x1a               // =26
               	cmp	x0, x1
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	sxtw	x1, w8
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	mov	x4, #0x19               // =25
               	cmp	x0, x1
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	msub	x1, x5, x6, x7
               	mov	x4, #0x18               // =24
               	cmp	x0, x1
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	madd	x1, x5, x6, x7
               	mov	x4, #0x17               // =23
               	cmp	x0, x1
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	mul	x1, x5, x6
               	mov	x4, #0x16               // =22
               	cmp	x0, x1
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	sxtw	x1, w6
               	asr	x1, x1, #3
               	mov	x4, #0x15               // =21
               	cmp	w0, w1
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	lsl	x2, x5, #5
               	mov	x4, #0x14               // =20
               	cmp	x0, x2
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	ror	x2, x5, #0x10
               	mov	x4, #0x13               // =19
               	cmp	x0, x2
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	asr	x2, x6, #5
               	mov	x4, #0x12               // =18
               	cmp	x0, x2
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	lsr	x2, x5, #9
               	mov	x4, #0x11               // =17
               	cmp	x0, x2
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	lsl	x2, x5, #7
               	mov	x4, #0x10               // =16
               	cmp	x0, x2
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	neg	x2, x5
               	mov	x4, #0xf                // =15
               	cmp	x0, x2
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	mvn	x2, x5
               	mov	x4, #0xe                // =14
               	cmp	x0, x2
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	and	x2, x5, #0xff00ff00ff00ff00
               	mov	x4, #0xd                // =13
               	cmp	x0, x2
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	mvn	x2, x6
               	eor	x2, x5, x2
               	mov	x4, #0xc                // =12
               	cmp	x0, x2
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	mvn	x2, x6
               	orr	x2, x5, x2
               	mov	x4, #0xb                // =11
               	cmp	x0, x2
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	mvn	x2, x6
               	and	x2, x5, x2
               	mov	x4, #0xa                // =10
               	cmp	x0, x2
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	asr	x2, x6, #3
               	eor	x2, x5, x2
               	mov	x4, #0x9                // =9
               	cmp	x0, x2
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	ror	x2, x6, #0xc
               	orr	x2, x5, x2
               	mov	x4, #0x8                // =8
               	cmp	x0, x2
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	and	x2, x5, x6
               	mov	x4, #0x7                // =7
               	cmp	x0, x2
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	add	x2, x5, x6
               	mov	x4, #0x6                // =6
               	cmp	w0, w2
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	sub	x2, x5, #0x1, lsl #12   // =0x1000
               	mov	x4, #0x5                // =5
               	cmp	x0, x2
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	add	x2, x5, #0x123
               	mov	x4, #0x4                // =4
               	cmp	x0, x2
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	sxtw	x2, w8
               	lsl	x2, x2, #2
               	add	x2, x5, x2
               	mov	x4, #0x3                // =3
               	cmp	x0, x2
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
               	lsr	x0, x6, #8
               	sub	x0, x5, x0
               	mov	x4, #0x2                // =2
               	cmp	x2, x0
               	b.ne	<addr>
               	mov	x4, #0x0                // =0
               	b	<addr>
