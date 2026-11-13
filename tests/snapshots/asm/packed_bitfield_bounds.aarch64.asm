
packed_bitfield_bounds.aarch64:	file format elf64-littleaarch64

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
               	stp	x20, x21, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x0, #0x1e               // =30
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #0x0                // =0
               	lsl	x1, x20, #1
               	mov	x2, #0x3                // =3
               	mov	x3, #0x22               // =34
               	mov	x4, #-0x1               // =-1
               	mov	x5, x0
               	bl	<addr>
               	mov	x21, x0
               	mov	x17, #-0x1              // =-1
               	cmp	x21, x17
               	b.eq	<addr>
               	add	x0, x21, x20
               	mov	x2, #0x0                // =0
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	add	x0, x21, x20
               	cbz	x0, <addr>
               	sub	x1, x0, #0x3
               	sub	x6, x0, #0x5
               	sub	x7, x0, #0x6
               	sub	x2, x0, #0x7
               	sub	x4, x0, #0xe
               	sub	x5, x0, #0x9
               	sub	x3, x0, #0x11
               	sub	x9, x0, #0x10
               	mov	x8, #0xff               // =255
               	strb	w8, [x9]
               	sub	x10, x0, #0xf
               	strb	w8, [x10]
               	sub	x11, x0, #0xe
               	mov	x12, #0xffff            // =65535
               	strh	w12, [x11]
               	sub	x12, x0, #0xc
               	mov	x13, #0xffffffff        // =4294967295
               	str	w13, [x12]
               	sub	x13, x0, #0x8
               	mov	x14, #-0x1              // =-1
               	sub	x20, x0, #0x1
               	str	x14, [x13]
               	ldrh	w14, [x1]
               	ldrb	w15, [x1, #0x2]
               	orr	x14, x14, x15, lsl #16
               	and	x14, x14, #0xffffffffffc00000
               	mov	x17, #0xfffb            // =65531
               	movk	x17, #0x3f, lsl #16
               	orr	x14, x14, x17
               	strh	w14, [x1]
               	lsr	x14, x14, #16
               	strb	w14, [x1, #0x2]
               	ldrh	w14, [x1]
               	ldrb	w15, [x1, #0x2]
               	orr	x21, x14, x15, lsl #16
               	sbfx	x21, x21, #0, #22
               	add	x21, x21, #0x7
               	and	x21, x21, #0x3fffff
               	orr	x14, x14, x15, lsl #16
               	and	x14, x14, #0xffffffffffc00000
               	orr	x14, x14, x21
               	strh	w14, [x1]
               	lsr	x14, x14, #16
               	strb	w14, [x1, #0x2]
               	ldrh	w14, [x1]
               	ldrb	w15, [x1, #0x2]
               	orr	x14, x14, x15, lsl #16
               	sbfx	x14, x14, #0, #22
               	cmp	w14, #0x2
               	b.ne	<addr>
               	ldrb	w14, [x20]
               	cmp	w14, #0xc0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	strb	w8, [x9]
               	strb	w8, [x10]
               	mov	x8, #0xffff             // =65535
               	strh	w8, [x11]
               	mov	x8, #0xffffffff         // =4294967295
               	str	w8, [x12]
               	mov	x9, #-0x1               // =-1
               	sub	x8, x0, #0x1
               	str	x9, [x13]
               	ldr	w9, [x6]
               	ldrb	w10, [x6, #0x4]
               	orr	x9, x9, x10, lsl #32
               	and	x9, x9, #0xfffffff000000000
               	mov	x17, #0x9877            // =39031
               	movk	x17, #0xdcba, lsl #16
               	movk	x17, #0xe, lsl #32
               	orr	x9, x9, x17
               	str	w9, [x6]
               	lsr	x9, x9, #32
               	strb	w9, [x6, #0x4]
               	ldr	w9, [x6]
               	ldrb	w10, [x6, #0x4]
               	orr	x11, x9, x10, lsl #32
               	sbfx	x11, x11, #0, #36
               	mov	x17, #-0x6789           // =-26505
               	movk	x17, #0xdcba, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x11, x17
               	b.ne	<addr>
               	ldrb	w11, [x8]
               	cmp	w11, #0xfe
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	orr	x9, x9, x10, lsl #32
               	and	x9, x9, #0xfffffff000000000
               	mov	x17, #0x5               // =5
               	orr	x9, x9, x17
               	str	w9, [x6]
               	lsr	x9, x9, #32
               	strb	w9, [x6, #0x4]
               	ldr	w9, [x6]
               	ldrb	w6, [x6, #0x4]
               	orr	x6, x9, x6, lsl #32
               	sbfx	x6, x6, #0, #36
               	cmp	x6, #0x5
               	b.ne	<addr>
               	ldrb	w6, [x8]
               	cmp	w6, #0xf0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	sub	x9, x0, #0x10
               	mov	x6, #0xff               // =255
               	strb	w6, [x9]
               	sub	x10, x0, #0xf
               	strb	w6, [x10]
               	sub	x11, x0, #0xe
               	mov	x12, #0xffff            // =65535
               	strh	w12, [x11]
               	sub	x12, x0, #0xc
               	mov	x13, #0xffffffff        // =4294967295
               	str	w13, [x12]
               	sub	x13, x0, #0x8
               	mov	x14, #-0x1              // =-1
               	str	x14, [x13]
               	ldr	w13, [x7]
               	ldrh	w14, [x7, #0x4]
               	orr	x13, x13, x14, lsl #32
               	and	x13, x13, #0xfffff00000000000
               	orr	x13, x13, #0x7ffffffffff
               	str	w13, [x7]
               	lsr	x13, x13, #32
               	strh	w13, [x7, #0x4]
               	ldr	w13, [x7]
               	ldrh	w14, [x7, #0x4]
               	orr	x15, x13, x14, lsl #32
               	sbfx	x15, x15, #0, #44
               	sub	x15, x15, #0x1
               	and	x15, x15, #0xfffffffffff
               	orr	x13, x13, x14, lsl #32
               	and	x13, x13, #0xfffff00000000000
               	orr	x13, x13, x15
               	str	w13, [x7]
               	lsr	x13, x13, #32
               	strh	w13, [x7, #0x4]
               	ldr	w13, [x7]
               	ldrh	w7, [x7, #0x4]
               	orr	x7, x13, x7, lsl #32
               	sbfx	x7, x7, #0, #44
               	mov	x17, #0x7fffffffffe     // =8796093022206
               	cmp	x7, x17
               	b.ne	<addr>
               	ldrb	w7, [x8]
               	cmp	w7, #0xf7
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	strb	w6, [x9]
               	strb	w6, [x10]
               	mov	x6, #0xffff             // =65535
               	strh	w6, [x11]
               	mov	x6, #0xffffffff         // =4294967295
               	str	w6, [x12]
               	sub	x7, x0, #0x8
               	mov	x6, #-0x1               // =-1
               	sub	x8, x0, #0x1
               	str	x6, [x7]
               	ldr	w6, [x2]
               	ldrh	w9, [x2, #0x4]
               	orr	x6, x6, x9, lsl #32
               	ldrb	w9, [x2, #0x6]
               	orr	x6, x6, x9, lsl #48
               	and	x6, x6, #0xfff0000000000000
               	orr	x6, x6, #0xfffffffffffff
               	str	w6, [x2]
               	lsr	x9, x6, #32
               	strh	w9, [x2, #0x4]
               	lsr	x6, x6, #48
               	strb	w6, [x2, #0x6]
               	ldr	w6, [x2]
               	ldrh	w9, [x2, #0x4]
               	orr	x11, x6, x9, lsl #32
               	ldrb	w10, [x2, #0x6]
               	orr	x11, x11, x10, lsl #48
               	sbfx	x11, x11, #0, #52
               	mov	x17, #0x5               // =5
               	eor	x11, x11, x17
               	and	x11, x11, #0xfffffffffffff
               	orr	x6, x6, x9, lsl #32
               	orr	x6, x6, x10, lsl #48
               	and	x6, x6, #0xfff0000000000000
               	orr	x6, x6, x11
               	str	w6, [x2]
               	lsr	x9, x6, #32
               	strh	w9, [x2, #0x4]
               	lsr	x6, x6, #48
               	strb	w6, [x2, #0x6]
               	ldr	w6, [x2]
               	ldrh	w9, [x2, #0x4]
               	orr	x11, x6, x9, lsl #32
               	ldrb	w10, [x2, #0x6]
               	orr	x11, x11, x10, lsl #48
               	sbfx	x11, x11, #0, #52
               	mov	x17, #-0x6              // =-6
               	cmp	x11, x17
               	b.ne	<addr>
               	ldrb	w11, [x8]
               	cmp	w11, #0xff
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	orr	x6, x6, x9, lsl #32
               	orr	x6, x6, x10, lsl #48
               	and	x6, x6, #0xfff0000000000000
               	str	w6, [x2]
               	lsr	x9, x6, #32
               	strh	w9, [x2, #0x4]
               	lsr	x6, x6, #48
               	strb	w6, [x2, #0x6]
               	ldr	w6, [x2]
               	ldrh	w9, [x2, #0x4]
               	orr	x6, x6, x9, lsl #32
               	ldrb	w9, [x2, #0x6]
               	orr	x6, x6, x9, lsl #48
               	sbfx	x6, x6, #0, #52
               	cbnz	x6, <addr>
               	ldrb	w6, [x8]
               	cmp	w6, #0xf0
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	sub	x6, x0, #0x10
               	strb	wzr, [x6]
               	sub	x9, x0, #0xf
               	strb	wzr, [x9]
               	sub	x8, x0, #0xe
               	strh	wzr, [x8]
               	sub	x10, x0, #0xc
               	str	wzr, [x10]
               	str	xzr, [x7]
               	ldrb	w7, [x1]
               	and	x7, x7, #0xfffffffffffffff0
               	mov	x17, #0x9               // =9
               	orr	x7, x7, x17
               	strb	w7, [x1]
               	ldrh	w7, [x1]
               	ldrb	w11, [x1, #0x2]
               	orr	x7, x7, x11, lsl #16
               	and	x7, x7, #0xffffffffff00000f
               	mov	x17, #0xcbb0            // =52144
               	movk	x17, #0xed, lsl #16
               	orr	x7, x7, x17
               	strh	w7, [x1]
               	lsr	x7, x7, #16
               	strb	w7, [x1, #0x2]
               	ldrh	w7, [x1]
               	ldrb	w11, [x1, #0x2]
               	orr	x12, x7, x11, lsl #16
               	sbfx	x12, x12, #4, #20
               	mov	x17, #-0x2345           // =-9029
               	movk	x17, #0xfffe, lsl #16
               	cmp	w12, w17
               	b.ne	<addr>
               	ldrb	w12, [x1]
               	and	x12, x12, #0xf
               	cmp	w12, #0x9
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	orr	x7, x7, x11, lsl #16
               	sbfx	x7, x7, #4, #20
               	add	x7, x7, #0x1
               	and	x7, x7, #0xfffff
               	ldrh	w11, [x1]
               	ldrb	w12, [x1, #0x2]
               	orr	x11, x11, x12, lsl #16
               	and	x11, x11, #0xffffffffff00000f
               	orr	x7, x11, x7, lsl #4
               	strh	w7, [x1]
               	lsr	x7, x7, #16
               	strb	w7, [x1, #0x2]
               	ldrh	w7, [x1]
               	ldrb	w11, [x1, #0x2]
               	orr	x7, x7, x11, lsl #16
               	sbfx	x7, x7, #4, #20
               	mov	x17, #-0x2344           // =-9028
               	movk	x17, #0xfffe, lsl #16
               	cmp	w7, w17
               	b.ne	<addr>
               	ldrb	w7, [x1]
               	and	x7, x7, #0xf
               	cmp	w7, #0x9
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x7, #0xff               // =255
               	strb	w7, [x6]
               	strb	w7, [x9]
               	mov	x6, #0xffff             // =65535
               	strh	w6, [x8]
               	mov	x6, #0xffffffff         // =4294967295
               	str	w6, [x10]
               	sub	x6, x0, #0x8
               	mov	x8, #-0x1               // =-1
               	sub	x7, x0, #0x1
               	str	x8, [x6]
               	ldrh	w8, [x1]
               	ldrb	w9, [x1, #0x2]
               	orr	x8, x8, x9, lsl #16
               	and	x8, x8, #0xffffffffff800000
               	mov	x17, #0xaaaa            // =43690
               	movk	x17, #0x2a, lsl #16
               	orr	x8, x8, x17
               	strh	w8, [x1]
               	lsr	x8, x8, #16
               	strb	w8, [x1, #0x2]
               	ldrh	w8, [x1]
               	ldrb	w1, [x1, #0x2]
               	orr	x1, x8, x1, lsl #16
               	and	x1, x1, #0x7fffff
               	mov	x17, #0xaaaa            // =43690
               	movk	x17, #0x2a, lsl #16
               	cmp	w1, w17
               	b.ne	<addr>
               	ldrb	w1, [x7]
               	cmp	w1, #0xaa
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	sub	x8, x0, #0x10
               	strb	wzr, [x8]
               	sub	x8, x0, #0xf
               	strb	wzr, [x8]
               	sub	x1, x0, #0xe
               	strh	wzr, [x1]
               	sub	x1, x0, #0xc
               	str	wzr, [x1]
               	str	xzr, [x6]
               	mov	x1, #0x5a               // =90
               	strb	w1, [x2]
               	ldur	w1, [x2, #0x1]
               	ldurh	w6, [x2, #0x5]
               	orr	x1, x1, x6, lsl #32
               	and	x1, x1, #0xffff000000000000
               	mov	x17, #0x7654            // =30292
               	movk	x17, #0xba98, lsl #16
               	movk	x17, #0xfedc, lsl #32
               	orr	x1, x1, x17
               	stur	w1, [x2, #0x1]
               	lsr	x1, x1, #32
               	sturh	w1, [x2, #0x5]
               	ldur	w1, [x2, #0x1]
               	ldurh	w6, [x2, #0x5]
               	orr	x8, x1, x6, lsl #32
               	mov	x17, #0x7654            // =30292
               	movk	x17, #0xba98, lsl #16
               	movk	x17, #0xfedc, lsl #32
               	cmp	x8, x17
               	b.ne	<addr>
               	ldrb	w7, [x7]
               	cmp	w7, #0xfe
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	orr	x7, x1, x6, lsl #32
               	orr	x1, x1, x6, lsl #32
               	and	x1, x1, #0xffff000000000000
               	orr	x1, x1, x7, lsr #4
               	stur	w1, [x2, #0x1]
               	lsr	x1, x1, #32
               	sturh	w1, [x2, #0x5]
               	ldur	w1, [x2, #0x1]
               	ldurh	w2, [x2, #0x5]
               	orr	x1, x1, x2, lsl #32
               	mov	x17, #0x8765            // =34661
               	movk	x17, #0xcba9, lsl #16
               	movk	x17, #0xfed, lsl #32
               	cmp	x1, x17
               	b.ne	<addr>
               	sub	x2, x0, #0x20
               	mov	x1, #0xff               // =255
               	strb	w1, [x2]
               	sub	x6, x0, #0x1f
               	strb	w1, [x6]
               	sub	x7, x0, #0x1e
               	mov	x1, #0xffff             // =65535
               	strh	w1, [x7]
               	sub	x8, x0, #0x1c
               	mov	x1, #0xffffffff         // =4294967295
               	str	w1, [x8]
               	sub	x9, x0, #0x18
               	mov	x1, #-0x1               // =-1
               	str	x1, [x9]
               	sub	x1, x0, #0x10
               	mov	x10, #-0x1              // =-1
               	str	x10, [x1]
               	sub	x1, x0, #0x8
               	mov	x11, #-0x1              // =-1
               	sub	x10, x0, #0x1
               	str	x11, [x1]
               	mov	x1, #0x3                // =3
               	strb	w1, [x4]
               	ldur	w1, [x4, #0x9]
               	ldrb	w11, [x4, #0xd]
               	orr	x1, x1, x11, lsl #32
               	and	x1, x1, #0xfffffff000000000
               	mov	x11, #0x3210            // =12816
               	movk	x11, #0x7654, lsl #16
               	movk	x11, #0xba98, lsl #32
               	movk	x11, #0xfedc, lsl #48
               	mov	x17, #0x6789            // =26505
               	movk	x17, #0x2345, lsl #16
               	movk	x17, #0x1, lsl #32
               	orr	x1, x1, x17
               	stur	x11, [x4, #0x1]
               	stur	w1, [x4, #0x9]
               	lsr	x1, x1, #32
               	strb	w1, [x4, #0xd]
               	ldur	w11, [x4, #0x9]
               	ldrb	w12, [x4, #0xd]
               	orr	x1, x11, x12, lsl #32
               	mov	x13, #0xcba9            // =52137
               	movk	x13, #0xfed, lsl #16
               	orr	x13, x13, x1, lsl #28
               	mov	x1, #0x3210             // =12816
               	movk	x1, #0x7654, lsl #16
               	movk	x1, #0x8, lsl #32
               	orr	x14, x1, x13, lsl #36
               	add	x1, x14, #0x1
               	cmp	x1, x14
               	cset	x14, lo
               	add	x13, x14, x13, asr #28
               	and	x13, x13, #0xfffffffff
               	orr	x11, x11, x12, lsl #32
               	and	x11, x11, #0xfffffff000000000
               	orr	x11, x11, x13
               	stur	x1, [x4, #0x1]
               	stur	w11, [x4, #0x9]
               	lsr	x11, x11, #32
               	strb	w11, [x4, #0xd]
               	ldur	w11, [x4, #0x9]
               	ldrb	w12, [x4, #0xd]
               	orr	x11, x11, x12, lsl #32
               	lsl	x11, x11, #28
               	orr	x11, x11, x1, lsr #36
               	mov	x12, #0x6789            // =26505
               	movk	x12, #0x2345, lsl #16
               	movk	x12, #0x1, lsl #32
               	ubfx	x1, x1, #0, #36
               	orr	x1, x1, x11, lsl #36
               	mov	x17, #0x3211            // =12817
               	movk	x17, #0x7654, lsl #16
               	movk	x17, #0xba98, lsl #32
               	movk	x17, #0xfedc, lsl #48
               	eor	x1, x1, x17
               	eor	x11, x12, x11, asr #28
               	orr	x1, x1, x11
               	cbnz	x1, <addr>
               	ldrb	w1, [x10]
               	cmp	w1, #0xf1
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x1, #-0x2               // =-2
               	ldur	w11, [x4, #0x9]
               	ldrb	w12, [x4, #0xd]
               	orr	x11, x11, x12, lsl #32
               	and	x11, x11, #0xfffffff000000000
               	orr	x11, x11, #0xfffffffff
               	stur	x1, [x4, #0x1]
               	stur	w11, [x4, #0x9]
               	lsr	x11, x11, #32
               	strb	w11, [x4, #0xd]
               	ldur	w11, [x4, #0x9]
               	ldrb	w4, [x4, #0xd]
               	orr	x4, x11, x4, lsl #32
               	lsl	x4, x4, #28
               	orr	x4, x4, #0xfffffff
               	asr	x11, x4, #28
               	lsl	x4, x4, #36
               	orr	x4, x4, #0xffffffffe
               	eor	x1, x4, x1
               	mvn	x4, x11
               	orr	x1, x1, x4
               	cbnz	x1, <addr>
               	ldrb	w1, [x10]
               	cmp	w1, #0xff
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x1, #0x0                // =0
               	strb	w1, [x2]
               	strb	w1, [x6]
               	strh	wzr, [x7]
               	str	wzr, [x8]
               	str	xzr, [x9]
               	sub	x2, x0, #0x10
               	str	xzr, [x2]
               	sub	x4, x0, #0x8
               	sub	x6, x0, #0x1
               	str	xzr, [x4]
               	ldrb	w7, [x5]
               	and	x7, x7, #0xfffffffffffffffe
               	orr	x7, x7, #0x1
               	strb	w7, [x5]
               	ldrb	w7, [x5, #0x8]
               	and	x7, x7, #0xffffffffffffff01
               	mov	x17, #0xaa              // =170
               	orr	x7, x7, x17
               	strb	w7, [x5, #0x8]
               	ldr	x7, [x5]
               	ldrb	w8, [x5, #0x8]
               	and	x7, x7, #0x1
               	and	x8, x8, #0xfffffffffffffffe
               	mov	x17, #0x9bde            // =39902
               	movk	x17, #0x1357, lsl #16
               	movk	x17, #0x8acf, lsl #32
               	movk	x17, #0x246, lsl #48
               	orr	x7, x7, x17
               	orr	x8, x8, #0x1
               	str	x7, [x5]
               	strb	w8, [x5, #0x8]
               	ldrb	w8, [x5, #0x8]
               	lsr	x7, x7, #1
               	orr	x7, x7, x8, lsl #63
               	mov	x17, #0xcdef            // =52719
               	movk	x17, #0x89ab, lsl #16
               	movk	x17, #0x4567, lsl #32
               	movk	x17, #0x8123, lsl #48
               	cmp	x7, x17
               	b.ne	<addr>
               	ldrb	w7, [x5]
               	and	x7, x7, #0x1
               	cmp	w7, #0x1
               	b.ne	<addr>
               	asr	x7, x8, #1
               	cmp	w7, #0x55
               	b.ne	<addr>
               	ldrb	w7, [x6]
               	cmp	w7, #0xab
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	ldr	x7, [x5]
               	ldrb	w8, [x5, #0x8]
               	lsr	x9, x7, #1
               	orr	x9, x9, x8, lsl #63
               	mov	x17, #-0x3              // =-3
               	cmp	x9, x17
               	cset	x9, hs
               	and	x7, x7, #0x1
               	and	x8, x8, #0xfffffffffffffffe
               	orr	x7, x7, x9, lsl #1
               	str	x7, [x5]
               	strb	w8, [x5, #0x8]
               	ldrb	w8, [x5, #0x8]
               	lsr	x7, x7, #1
               	orr	x7, x7, x8, lsl #63
               	cbnz	x7, <addr>
               	ldrb	w5, [x5]
               	and	x5, x5, #0x1
               	cmp	w5, #0x1
               	b.ne	<addr>
               	asr	x5, x8, #1
               	cmp	w5, #0x55
               	b.ne	<addr>
               	ldrb	w5, [x6]
               	cmp	w5, #0xaa
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	sub	x5, x0, #0x20
               	strb	w1, [x5]
               	sub	x5, x0, #0x1f
               	strb	w1, [x5]
               	sub	x5, x0, #0x1e
               	strh	wzr, [x5]
               	sub	x5, x0, #0x1c
               	str	wzr, [x5]
               	sub	x5, x0, #0x18
               	str	xzr, [x5]
               	str	xzr, [x2]
               	sub	x2, x0, #0x1
               	str	xzr, [x4]
               	ldrb	w0, [x3]
               	and	x0, x0, #0xfffffffffffffffe
               	orr	x0, x0, #0x1
               	strb	w0, [x3]
               	ldrb	w0, [x3, #0x10]
               	and	x0, x0, #0xffffffffffffff01
               	mov	x17, #0x54              // =84
               	orr	x0, x0, x17
               	strb	w0, [x3, #0x10]
               	ldr	x0, [x3]
               	ldrb	w4, [x3, #0x10]
               	and	x0, x0, #0x1
               	mov	x17, #0x6420            // =25632
               	movk	x17, #0xeca8, lsl #16
               	movk	x17, #0x7530, lsl #32
               	movk	x17, #0xfdb9, lsl #48
               	orr	x0, x0, x17
               	mov	x5, #0x9bdf             // =39903
               	movk	x5, #0x1357, lsl #16
               	movk	x5, #0x8acf, lsl #32
               	movk	x5, #0x246, lsl #48
               	str	x0, [x3]
               	str	x5, [x3, #0x8]
               	and	x4, x4, #0xfffffffffffffffe
               	strb	w4, [x3, #0x10]
               	ldrb	w4, [x3, #0x10]
               	lsr	x0, x0, #1
               	orr	x5, x0, #0x8000000000000000
               	mov	x0, #0xcdef             // =52719
               	movk	x0, #0x89ab, lsl #16
               	movk	x0, #0x4567, lsl #32
               	movk	x0, #0x123, lsl #48
               	orr	x6, x0, x4, lsl #63
               	add	x0, x5, #0x1
               	cmp	x0, x5
               	cset	x5, lo
               	add	x5, x6, x5
               	lsl	x6, x5, #1
               	orr	x7, x6, x0, lsr #63
               	ldr	x6, [x3]
               	and	x6, x6, #0x1
               	orr	x6, x6, x0, lsl #1
               	orr	x0, x1, x7
               	str	x6, [x3]
               	str	x0, [x3, #0x8]
               	and	x1, x4, #0xfffffffffffffffe
               	orr	x1, x1, x5, lsr #63
               	strb	w1, [x3, #0x10]
               	ldrb	w1, [x3, #0x10]
               	lsr	x4, x0, #1
               	lsr	x5, x6, #1
               	orr	x0, x5, x0, lsl #63
               	orr	x4, x4, x1, lsl #63
               	mov	x17, #0x3211            // =12817
               	movk	x17, #0x7654, lsl #16
               	movk	x17, #0xba98, lsl #32
               	movk	x17, #0xfedc, lsl #48
               	eor	x0, x0, x17
               	mov	x17, #0xcdef            // =52719
               	movk	x17, #0x89ab, lsl #16
               	movk	x17, #0x4567, lsl #32
               	movk	x17, #0x123, lsl #48
               	eor	x4, x4, x17
               	orr	x0, x0, x4
               	cbnz	x0, <addr>
               	ldrb	w0, [x3]
               	and	x0, x0, #0x1
               	cmp	w0, #0x1
               	b.ne	<addr>
               	asr	x0, x1, #1
               	cmp	w0, #0x2a
               	b.ne	<addr>
               	ldrb	w0, [x2]
               	cmp	w0, #0x54
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	ldr	x0, [x3]
               	ldrb	w1, [x3, #0x10]
               	and	x0, x0, #0x1
               	orr	x0, x0, #0xfffffffffffffffe
               	mov	x4, #-0x1               // =-1
               	str	x0, [x3]
               	str	x4, [x3, #0x8]
               	and	x1, x1, #0xfffffffffffffffe
               	orr	x1, x1, #0x1
               	strb	w1, [x3, #0x10]
               	ldrb	w1, [x3, #0x10]
               	lsr	x0, x0, #1
               	orr	x0, x0, #0x8000000000000000
               	lsl	x4, x1, #63
               	orr	x4, x4, #0x7fffffffffffffff
               	mvn	x0, x0
               	mvn	x4, x4
               	orr	x0, x0, x4
               	cbnz	x0, <addr>
               	ldrb	w0, [x3]
               	and	x0, x0, #0x1
               	cmp	w0, #0x1
               	b.ne	<addr>
               	asr	x0, x1, #1
               	cmp	w0, #0x2a
               	b.ne	<addr>
               	ldrb	w0, [x2]
               	cmp	w0, #0x55
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
