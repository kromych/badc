
pragma_pack_bitfield_layout.aarch64:	file format elf64-littleaarch64

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

<image_is>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xa0
               	sub	x0, x29, #0x90
               	mov	x1, #0x0                // =0
               	mov	x2, #0x8                // =8
               	bl	<addr>
               	sub	x0, x29, #0x90
               	ldr	w1, [x0]
               	and	x1, x1, #0xffffffffc0000000
               	orr	x1, x1, #0x3fffffff
               	str	w1, [x0]
               	ldr	x1, [x0]
               	and	x1, x1, #0xf00000003fffffff
               	mov	x17, #0x80000000        // =2147483648
               	movk	x17, #0xaaaa, lsl #32
               	movk	x17, #0xaaa, lsl #48
               	orr	x1, x1, x17
               	str	x1, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x8                // =8
               	bl	<addr>
               	cbz	w0, <addr>
               	sub	x0, x29, #0x90
               	ldr	w1, [x0]
               	and	x1, x1, #0x3fffffff
               	lsl	x1, x1, #34
               	asr	x1, x1, #34
               	mov	x17, #-0x1              // =-1
               	cmp	w1, w17
               	b.ne	<addr>
               	ldr	x0, [x0]
               	asr	x0, x0, #30
               	and	x0, x0, #0x3fffffff
               	lsl	x0, x0, #34
               	asr	x0, x0, #34
               	mov	x17, #-0x5556           // =-21846
               	movk	x17, #0xeaaa, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x88
               	mov	x1, #0x0                // =0
               	mov	x2, #0x5                // =5
               	bl	<addr>
               	sub	x0, x29, #0x88
               	mov	x1, #0x1                // =1
               	strb	w1, [x0]
               	ldurh	w1, [x0, #0x1]
               	and	x1, x1, #0xffffffffffff8000
               	orr	x1, x1, #0x7ffe
               	sturh	w1, [x0, #0x1]
               	mov	x1, #0x1234             // =4660
               	sturh	w1, [x0, #0x3]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x5                // =5
               	bl	<addr>
               	cbz	w0, <addr>
               	sub	x0, x29, #0x88
               	ldrb	w1, [x0]
               	eor	x1, x1, #0x1
               	cbnz	w1, <addr>
               	ldurh	w1, [x0, #0x1]
               	and	x1, x1, #0x7fff
               	lsl	x1, x1, #49
               	asr	x1, x1, #49
               	mov	x17, #-0x2              // =-2
               	cmp	w1, w17
               	b.ne	<addr>
               	ldursh	x0, [x0, #0x3]
               	mov	x17, #0x1234            // =4660
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x80
               	mov	x1, #0x0                // =0
               	mov	x2, #0xa                // =10
               	bl	<addr>
               	sub	x0, x29, #0x80
               	mov	x1, #0x1                // =1
               	strb	w1, [x0]
               	ldur	x1, [x0, #0x1]
               	and	x1, x1, #0xf000000000000000
               	orr	x1, x1, #0xffffffffffffff
               	stur	x1, [x0, #0x1]
               	mov	x1, #0x2                // =2
               	strb	w1, [x0, #0x9]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0xa                // =10
               	bl	<addr>
               	cbz	w0, <addr>
               	sub	x0, x29, #0x80
               	ldur	x1, [x0, #0x1]
               	and	x1, x1, #0xfffffffffffffff
               	lsl	x1, x1, #4
               	asr	x1, x1, #4
               	mov	x17, #0xffffffffffffff  // =72057594037927935
               	cmp	x1, x17
               	b.ne	<addr>
               	ldrb	w0, [x0, #0x9]
               	eor	x0, x0, #0x2
               	cbz	w0, <addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0xf                // =15
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w1, [x0]
               	and	x1, x1, #0x3fffff
               	cmp	w1, #0x79a
               	b.ne	<addr>
               	ldur	w1, [x0, #0x2]
               	asr	x1, x1, #6
               	and	x1, x1, #0x7fffff
               	lsl	x1, x1, #41
               	asr	x1, x1, #41
               	mov	x17, #-0x771            // =-1905
               	cmp	w1, w17
               	b.ne	<addr>
               	ldur	w1, [x0, #0x5]
               	asr	x1, x1, #5
               	and	x1, x1, #0x3ffffff
               	mov	x17, #0x13de            // =5086
               	cmp	w1, w17
               	b.ne	<addr>
               	ldrh	w1, [x0, #0x8]
               	asr	x1, x1, #7
               	and	x1, x1, #0x1f
               	lsl	x1, x1, #59
               	asr	x1, x1, #59
               	cmp	w1, #0x4
               	b.ne	<addr>
               	ldur	w1, [x0, #0x9]
               	asr	x1, x1, #4
               	and	x1, x1, #0xfffff
               	lsl	x1, x1, #44
               	asr	x1, x1, #44
               	cmp	w1, #0x16a
               	b.ne	<addr>
               	ldur	w0, [x0, #0xb]
               	asr	x0, x0, #8
               	and	x0, x0, #0xfffff
               	cmp	w0, #0x141
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x70
               	mov	x1, #0x0                // =0
               	mov	x2, #0xf                // =15
               	bl	<addr>
               	sub	x0, x29, #0x70
               	ldr	w1, [x0]
               	and	x1, x1, #0xffffffffffc00000
               	mov	x17, #0x79a             // =1946
               	orr	x1, x1, x17
               	str	w1, [x0]
               	ldur	w1, [x0, #0x2]
               	and	x1, x1, #0xffffffffe000003f
               	mov	x17, #0x23c0            // =9152
               	movk	x17, #0x1ffe, lsl #16
               	orr	x1, x1, x17
               	stur	w1, [x0, #0x2]
               	ldur	w1, [x0, #0x5]
               	and	x1, x1, #0xffffffff8000001f
               	mov	x17, #0x7bc0            // =31680
               	movk	x17, #0x2, lsl #16
               	orr	x1, x1, x17
               	stur	w1, [x0, #0x5]
               	ldrh	w1, [x0, #0x8]
               	and	x1, x1, #0xfffffffffffff07f
               	orr	x1, x1, #0x200
               	strh	w1, [x0, #0x8]
               	ldur	w1, [x0, #0x9]
               	and	x1, x1, #0xffffffffff00000f
               	mov	x17, #0x16a0            // =5792
               	orr	x1, x1, x17
               	stur	w1, [x0, #0x9]
               	ldur	w1, [x0, #0xb]
               	and	x1, x1, #0xfffffffff00000ff
               	mov	x17, #0x4100            // =16640
               	movk	x17, #0x1, lsl #16
               	orr	x1, x1, x17
               	stur	w1, [x0, #0xb]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0xf                // =15
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x60
               	mov	x1, #0x0                // =0
               	mov	x2, #0xa                // =10
               	bl	<addr>
               	sub	x0, x29, #0x60
               	mov	x1, #0x1                // =1
               	strb	w1, [x0]
               	ldur	w1, [x0, #0x1]
               	and	x1, x1, #0xffffffffc0000000
               	orr	x1, x1, #0x3fffffff
               	stur	w1, [x0, #0x1]
               	ldur	x1, [x0, #0x2]
               	and	x1, x1, #0xfff00000003fffff
               	mov	x17, #0xaa800000        // =2860515328
               	movk	x17, #0xaaaa, lsl #32
               	movk	x17, #0xa, lsl #48
               	orr	x1, x1, x17
               	stur	x1, [x0, #0x2]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0xa                // =10
               	bl	<addr>
               	cbz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0xa                // =10
               	bl	<addr>
               	cbz	w0, <addr>
               	sub	x0, x29, #0x60
               	ldur	w0, [x0, #0x1]
               	and	x0, x0, #0x3fffffff
               	lsl	x0, x0, #34
               	asr	x0, x0, #34
               	mov	x17, #-0x1              // =-1
               	cmp	w0, w17
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldur	x0, [x0, #0x2]
               	asr	x0, x0, #22
               	and	x0, x0, #0x3fffffff
               	lsl	x0, x0, #34
               	asr	x0, x0, #34
               	mov	x17, #-0x5556           // =-21846
               	movk	x17, #0xeaaa, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x50
               	mov	x1, #0x0                // =0
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	sub	x0, x29, #0x50
               	mov	x1, #0x1                // =1
               	strb	w1, [x0]
               	ldurh	w1, [x0, #0x1]
               	and	x1, x1, #0xffffffffffff8000
               	orr	x1, x1, #0x7ffe
               	sturh	w1, [x0, #0x1]
               	mov	x1, #0x3                // =3
               	strb	w1, [x0, #0x3]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	cbz	w0, <addr>
               	sub	x0, x29, #0x50
               	ldurh	w1, [x0, #0x1]
               	and	x1, x1, #0x7fff
               	lsl	x1, x1, #49
               	asr	x1, x1, #49
               	mov	x17, #-0x2              // =-2
               	cmp	w1, w17
               	b.ne	<addr>
               	ldrb	w0, [x0, #0x3]
               	eor	x0, x0, #0x3
               	cbz	w0, <addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x48
               	mov	x1, #0x0                // =0
               	mov	x2, #0xc                // =12
               	bl	<addr>
               	sub	x0, x29, #0x48
               	mov	x1, #0x1                // =1
               	strb	w1, [x0]
               	ldur	x1, [x0, #0x1]
               	and	x1, x1, #0xf000000000000000
               	orr	x1, x1, #0xffffffffffffff
               	stur	x1, [x0, #0x1]
               	mov	x1, #0x2                // =2
               	strb	w1, [x0, #0x9]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0xc                // =12
               	bl	<addr>
               	cbz	w0, <addr>
               	sub	x0, x29, #0x48
               	ldur	x1, [x0, #0x1]
               	and	x1, x1, #0xfffffffffffffff
               	lsl	x1, x1, #4
               	asr	x1, x1, #4
               	mov	x17, #0xffffffffffffff  // =72057594037927935
               	cmp	x1, x17
               	b.ne	<addr>
               	ldrb	w0, [x0, #0x9]
               	eor	x0, x0, #0x2
               	cbz	w0, <addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x38
               	mov	x1, #0x0                // =0
               	mov	x2, #0xc                // =12
               	bl	<addr>
               	sub	x0, x29, #0x28
               	mov	x1, #0x0                // =0
               	mov	x2, #0xc                // =12
               	bl	<addr>
               	sub	x0, x29, #0x18
               	mov	x1, #0x0                // =0
               	mov	x2, #0xc                // =12
               	bl	<addr>
               	sub	x0, x29, #0x38
               	sub	x1, x29, #0x28
               	sub	x2, x29, #0x18
               	mov	x3, #0x1                // =1
               	strb	w3, [x2]
               	strb	w3, [x1]
               	strb	w3, [x0]
               	mov	x3, #0x3fffffff         // =1073741823
               	ldr	w4, [x2, #0x4]
               	and	x4, x4, #0xffffffffc0000000
               	orr	x4, x4, x3
               	str	w4, [x2, #0x4]
               	ldur	w4, [x1, #0x1]
               	and	x4, x4, #0xffffffffc0000000
               	orr	x4, x4, x3
               	stur	w4, [x1, #0x1]
               	ldur	w4, [x0, #0x1]
               	and	x4, x4, #0xffffffffc0000000
               	orr	x3, x4, x3
               	stur	w3, [x0, #0x1]
               	ldr	w3, [x2, #0x8]
               	and	x3, x3, #0xffffffffc0000000
               	mov	x17, #0xaaaa            // =43690
               	movk	x17, #0x2aaa, lsl #16
               	orr	x3, x3, x17
               	str	w3, [x2, #0x8]
               	ldur	x2, [x1, #0x4]
               	and	x3, x2, #0xfffffff00000003f
               	mov	x2, #0xaa80             // =43648
               	movk	x2, #0xaaaa, lsl #16
               	movk	x2, #0xa, lsl #32
               	orr	x3, x3, x2
               	stur	x3, [x1, #0x4]
               	ldur	x1, [x0, #0x4]
               	and	x1, x1, #0xfffffff00000003f
               	orr	x1, x1, x2
               	stur	x1, [x0, #0x4]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0xc                // =12
               	bl	<addr>
               	cbz	w0, <addr>
               	sub	x0, x29, #0x28
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0xc                // =12
               	bl	<addr>
               	cbz	w0, <addr>
               	sub	x0, x29, #0x18
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0xc                // =12
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x38
               	ldur	w0, [x0, #0x1]
               	and	x0, x0, #0x3fffffff
               	lsl	x0, x0, #34
               	asr	x0, x0, #34
               	mov	x17, #-0x1              // =-1
               	cmp	w0, w17
               	b.ne	<addr>
               	sub	x0, x29, #0x28
               	ldur	x0, [x0, #0x4]
               	asr	x0, x0, #6
               	and	x0, x0, #0x3fffffff
               	lsl	x0, x0, #34
               	asr	x0, x0, #34
               	mov	x17, #-0x5556           // =-21846
               	movk	x17, #0xeaaa, lsl #16
               	cmp	w0, w17
               	b.ne	<addr>
               	sub	x0, x29, #0x18
               	ldr	w1, [x0, #0x4]
               	and	x1, x1, #0x3fffffff
               	lsl	x1, x1, #34
               	asr	x1, x1, #34
               	mov	x17, #-0x1              // =-1
               	cmp	w1, w17
               	b.ne	<addr>
               	ldr	w0, [x0, #0x8]
               	and	x0, x0, #0x3fffffff
               	lsl	x0, x0, #34
               	asr	x0, x0, #34
               	mov	x17, #-0x5556           // =-21846
               	movk	x17, #0xeaaa, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrh	w0, [x0]
               	and	x0, x0, #0x7fff
               	lsl	x0, x0, #49
               	asr	x0, x0, #49
               	cmp	w0, #0x6a
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrh	w1, [x0]
               	and	x1, x1, #0x7fff
               	lsl	x1, x1, #49
               	asr	x1, x1, #49
               	mov	x17, #-0x1              // =-1
               	cmp	w1, w17
               	b.ne	<addr>
               	ldrh	w0, [x0, #0x2]
               	and	x0, x0, #0x7fff
               	lsl	x0, x0, #49
               	asr	x0, x0, #49
               	cmp	w0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w0, [x0]
               	and	x0, x0, #0x3fffff
               	lsl	x0, x0, #42
               	asr	x0, x0, #42
               	mov	x17, #-0x4240           // =-16960
               	movk	x17, #0xfff0, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x98
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrh	w16, [x1]
               	strh	w16, [x0]
               	ldrb	w16, [x1, #0x2]
               	strb	w16, [x0, #0x2]
               	ldr	w1, [x0]
               	and	x1, x1, #0x3fffff
               	lsl	x1, x1, #42
               	asr	x1, x1, #42
               	mov	x17, #-0x4240           // =-16960
               	movk	x17, #0xfff0, lsl #16
               	cmp	w1, w17
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrh	w1, [x1]
               	and	x1, x1, #0x7fff
               	lsl	x1, x1, #49
               	asr	x1, x1, #49
               	mov	x17, #-0x3              // =-3
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	w1, [x0]
               	and	x1, x1, #0xffffffffffc00000
               	mov	x17, #0x4240            // =16960
               	movk	x17, #0xf, lsl #16
               	orr	x1, x1, x17
               	str	w1, [x0]
               	and	x0, x1, #0x3fffff
               	lsl	x0, x0, #42
               	asr	x0, x0, #42
               	mov	x17, #0x4240            // =16960
               	movk	x17, #0xf, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x2                // =2
               	bl	<addr>
               	cbz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrh	w0, [x0]
               	and	x0, x0, #0x7fff
               	lsl	x0, x0, #49
               	asr	x0, x0, #49
               	mov	x17, #-0x3              // =-3
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	mov	x1, #0x0                // =0
               	mov	x2, #0x2                // =2
               	bl	<addr>
               	sub	x0, x29, #0x8
               	ldrh	w1, [x0]
               	and	x1, x1, #0xffffffffffff8000
               	mov	x17, #0x7ffd            // =32765
               	orr	x1, x1, x17
               	strh	w1, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x2                // =2
               	bl	<addr>
               	cbz	w0, <addr>
               	sub	x0, x29, #0x8
               	ldrh	w1, [x0]
               	and	x1, x1, #0x7fff
               	lsl	x1, x1, #49
               	asr	x1, x1, #49
               	mov	x17, #-0x3              // =-3
               	cmp	w1, w17
               	b.ne	<addr>
               	ldrb	w0, [x0]
               	cmp	w0, #0xfd
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
