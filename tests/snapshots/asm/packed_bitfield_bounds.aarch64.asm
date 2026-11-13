
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
               	sturb	w8, [x0, #-0xf]
               	mov	x10, #0xffff            // =65535
               	sturh	w10, [x0, #-0xe]
               	mov	x10, #0xffffffff        // =4294967295
               	stur	w10, [x0, #-0xc]
               	mov	x10, #-0x1              // =-1
               	stur	x10, [x0, #-0x8]
               	ldrh	w10, [x1]
               	ldrb	w11, [x1, #0x2]
               	orr	x10, x10, x11, lsl #16
               	and	x10, x10, #0xffffffffffc00000
               	mov	x17, #0xfffb            // =65531
               	movk	x17, #0x3f, lsl #16
               	orr	x10, x10, x17
               	strh	w10, [x1]
               	lsr	x10, x10, #16
               	strb	w10, [x1, #0x2]
               	ldrh	w10, [x1]
               	ldrb	w11, [x1, #0x2]
               	orr	x12, x10, x11, lsl #16
               	sbfx	x12, x12, #0, #22
               	add	x12, x12, #0x7
               	and	x12, x12, #0x3fffff
               	orr	x10, x10, x11, lsl #16
               	and	x10, x10, #0xffffffffffc00000
               	orr	x10, x10, x12
               	strh	w10, [x1]
               	lsr	x10, x10, #16
               	strb	w10, [x1, #0x2]
               	ldrh	w10, [x1]
               	ldrb	w11, [x1, #0x2]
               	orr	x10, x10, x11, lsl #16
               	sbfx	x10, x10, #0, #22
               	cmp	w10, #0x2
               	b.ne	<addr>
               	ldurb	w10, [x0, #-0x1]
               	cmp	w10, #0xc0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	strb	w8, [x9]
               	sturb	w8, [x0, #-0xf]
               	mov	x10, #0xffff            // =65535
               	sturh	w10, [x0, #-0xe]
               	mov	x10, #0xffffffff        // =4294967295
               	stur	w10, [x0, #-0xc]
               	mov	x10, #-0x1              // =-1
               	stur	x10, [x0, #-0x8]
               	ldr	w10, [x6]
               	ldrb	w11, [x6, #0x4]
               	orr	x10, x10, x11, lsl #32
               	and	x10, x10, #0xfffffff000000000
               	mov	x17, #0x9877            // =39031
               	movk	x17, #0xdcba, lsl #16
               	movk	x17, #0xe, lsl #32
               	orr	x10, x10, x17
               	str	w10, [x6]
               	lsr	x10, x10, #32
               	strb	w10, [x6, #0x4]
               	ldr	w10, [x6]
               	ldrb	w11, [x6, #0x4]
               	orr	x12, x10, x11, lsl #32
               	sbfx	x12, x12, #0, #36
               	mov	x17, #-0x6789           // =-26505
               	movk	x17, #0xdcba, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x12, x17
               	b.ne	<addr>
               	ldurb	w12, [x0, #-0x1]
               	cmp	w12, #0xfe
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	orr	x10, x10, x11, lsl #32
               	and	x10, x10, #0xfffffff000000000
               	mov	x17, #0x5               // =5
               	orr	x10, x10, x17
               	str	w10, [x6]
               	lsr	x10, x10, #32
               	strb	w10, [x6, #0x4]
               	ldr	w10, [x6]
               	ldrb	w6, [x6, #0x4]
               	orr	x6, x10, x6, lsl #32
               	sbfx	x6, x6, #0, #36
               	cmp	x6, #0x5
               	b.ne	<addr>
               	ldurb	w6, [x0, #-0x1]
               	cmp	w6, #0xf0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	strb	w8, [x9]
               	sturb	w8, [x0, #-0xf]
               	mov	x6, #0xffff             // =65535
               	sturh	w6, [x0, #-0xe]
               	mov	x6, #0xffffffff         // =4294967295
               	stur	w6, [x0, #-0xc]
               	mov	x6, #-0x1               // =-1
               	stur	x6, [x0, #-0x8]
               	ldr	w6, [x7]
               	ldrh	w10, [x7, #0x4]
               	orr	x6, x6, x10, lsl #32
               	and	x6, x6, #0xfffff00000000000
               	orr	x6, x6, #0x7ffffffffff
               	str	w6, [x7]
               	lsr	x6, x6, #32
               	strh	w6, [x7, #0x4]
               	ldr	w6, [x7]
               	ldrh	w10, [x7, #0x4]
               	orr	x11, x6, x10, lsl #32
               	sbfx	x11, x11, #0, #44
               	sub	x11, x11, #0x1
               	and	x11, x11, #0xfffffffffff
               	orr	x6, x6, x10, lsl #32
               	and	x6, x6, #0xfffff00000000000
               	orr	x6, x6, x11
               	str	w6, [x7]
               	lsr	x6, x6, #32
               	strh	w6, [x7, #0x4]
               	ldr	w6, [x7]
               	ldrh	w7, [x7, #0x4]
               	orr	x6, x6, x7, lsl #32
               	sbfx	x6, x6, #0, #44
               	mov	x17, #0x7fffffffffe     // =8796093022206
               	cmp	x6, x17
               	b.ne	<addr>
               	ldurb	w6, [x0, #-0x1]
               	cmp	w6, #0xf7
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	strb	w8, [x9]
               	sturb	w8, [x0, #-0xf]
               	mov	x6, #0xffff             // =65535
               	sturh	w6, [x0, #-0xe]
               	mov	x6, #0xffffffff         // =4294967295
               	stur	w6, [x0, #-0xc]
               	mov	x6, #-0x1               // =-1
               	stur	x6, [x0, #-0x8]
               	ldr	w6, [x2]
               	ldrh	w7, [x2, #0x4]
               	orr	x6, x6, x7, lsl #32
               	ldrb	w7, [x2, #0x6]
               	orr	x6, x6, x7, lsl #48
               	and	x6, x6, #0xfff0000000000000
               	orr	x6, x6, #0xfffffffffffff
               	str	w6, [x2]
               	lsr	x7, x6, #32
               	strh	w7, [x2, #0x4]
               	lsr	x6, x6, #48
               	strb	w6, [x2, #0x6]
               	ldr	w6, [x2]
               	ldrh	w7, [x2, #0x4]
               	orr	x11, x6, x7, lsl #32
               	ldrb	w10, [x2, #0x6]
               	orr	x11, x11, x10, lsl #48
               	sbfx	x11, x11, #0, #52
               	mov	x17, #0x5               // =5
               	eor	x11, x11, x17
               	and	x11, x11, #0xfffffffffffff
               	orr	x6, x6, x7, lsl #32
               	orr	x6, x6, x10, lsl #48
               	and	x6, x6, #0xfff0000000000000
               	orr	x6, x6, x11
               	str	w6, [x2]
               	lsr	x7, x6, #32
               	strh	w7, [x2, #0x4]
               	lsr	x6, x6, #48
               	strb	w6, [x2, #0x6]
               	ldr	w6, [x2]
               	ldrh	w7, [x2, #0x4]
               	orr	x11, x6, x7, lsl #32
               	ldrb	w10, [x2, #0x6]
               	orr	x11, x11, x10, lsl #48
               	sbfx	x11, x11, #0, #52
               	mov	x17, #-0x6              // =-6
               	cmp	x11, x17
               	b.ne	<addr>
               	ldurb	w11, [x0, #-0x1]
               	cmp	w11, #0xff
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	orr	x6, x6, x7, lsl #32
               	orr	x6, x6, x10, lsl #48
               	and	x6, x6, #0xfff0000000000000
               	str	w6, [x2]
               	lsr	x7, x6, #32
               	strh	w7, [x2, #0x4]
               	lsr	x6, x6, #48
               	strb	w6, [x2, #0x6]
               	ldr	w6, [x2]
               	ldrh	w7, [x2, #0x4]
               	orr	x6, x6, x7, lsl #32
               	ldrb	w7, [x2, #0x6]
               	orr	x6, x6, x7, lsl #48
               	sbfx	x6, x6, #0, #52
               	cbnz	x6, <addr>
               	ldurb	w6, [x0, #-0x1]
               	cmp	w6, #0xf0
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x6, #0x0                // =0
               	strb	w6, [x9]
               	sturb	w6, [x0, #-0xf]
               	sturh	wzr, [x0, #-0xe]
               	stur	wzr, [x0, #-0xc]
               	stur	xzr, [x0, #-0x8]
               	ldrb	w7, [x1]
               	and	x7, x7, #0xfffffffffffffff0
               	mov	x17, #0x9               // =9
               	orr	x7, x7, x17
               	strb	w7, [x1]
               	ldrh	w7, [x1]
               	ldrb	w10, [x1, #0x2]
               	orr	x7, x7, x10, lsl #16
               	and	x7, x7, #0xffffffffff00000f
               	mov	x17, #0xcbb0            // =52144
               	movk	x17, #0xed, lsl #16
               	orr	x7, x7, x17
               	strh	w7, [x1]
               	lsr	x7, x7, #16
               	strb	w7, [x1, #0x2]
               	ldrh	w7, [x1]
               	ldrb	w10, [x1, #0x2]
               	orr	x11, x7, x10, lsl #16
               	sbfx	x11, x11, #4, #20
               	mov	x17, #-0x2345           // =-9029
               	movk	x17, #0xfffe, lsl #16
               	cmp	w11, w17
               	b.ne	<addr>
               	ldrb	w11, [x1]
               	and	x11, x11, #0xf
               	cmp	w11, #0x9
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	orr	x7, x7, x10, lsl #16
               	sbfx	x7, x7, #4, #20
               	add	x7, x7, #0x1
               	and	x7, x7, #0xfffff
               	ldrh	w10, [x1]
               	ldrb	w11, [x1, #0x2]
               	orr	x10, x10, x11, lsl #16
               	and	x10, x10, #0xffffffffff00000f
               	orr	x7, x10, x7, lsl #4
               	strh	w7, [x1]
               	lsr	x7, x7, #16
               	strb	w7, [x1, #0x2]
               	ldrh	w7, [x1]
               	ldrb	w10, [x1, #0x2]
               	orr	x7, x7, x10, lsl #16
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
               	strb	w8, [x9]
               	sturb	w8, [x0, #-0xf]
               	mov	x7, #0xffff             // =65535
               	sturh	w7, [x0, #-0xe]
               	mov	x7, #0xffffffff         // =4294967295
               	stur	w7, [x0, #-0xc]
               	mov	x7, #-0x1               // =-1
               	stur	x7, [x0, #-0x8]
               	ldrh	w7, [x1]
               	ldrb	w8, [x1, #0x2]
               	orr	x7, x7, x8, lsl #16
               	and	x7, x7, #0xffffffffff800000
               	mov	x17, #0xaaaa            // =43690
               	movk	x17, #0x2a, lsl #16
               	orr	x7, x7, x17
               	strh	w7, [x1]
               	lsr	x7, x7, #16
               	strb	w7, [x1, #0x2]
               	ldrh	w7, [x1]
               	ldrb	w1, [x1, #0x2]
               	orr	x1, x7, x1, lsl #16
               	and	x1, x1, #0x7fffff
               	mov	x17, #0xaaaa            // =43690
               	movk	x17, #0x2a, lsl #16
               	cmp	w1, w17
               	b.ne	<addr>
               	ldurb	w1, [x0, #-0x1]
               	cmp	w1, #0xaa
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	strb	w6, [x9]
               	sturb	w6, [x0, #-0xf]
               	sturh	wzr, [x0, #-0xe]
               	stur	wzr, [x0, #-0xc]
               	stur	xzr, [x0, #-0x8]
               	mov	x1, #0x5a               // =90
               	strb	w1, [x2]
               	ldur	w1, [x2, #0x1]
               	ldurh	w7, [x2, #0x5]
               	orr	x1, x1, x7, lsl #32
               	and	x1, x1, #0xffff000000000000
               	mov	x17, #0x7654            // =30292
               	movk	x17, #0xba98, lsl #16
               	movk	x17, #0xfedc, lsl #32
               	orr	x1, x1, x17
               	stur	w1, [x2, #0x1]
               	lsr	x1, x1, #32
               	sturh	w1, [x2, #0x5]
               	ldur	w1, [x2, #0x1]
               	ldurh	w7, [x2, #0x5]
               	orr	x8, x1, x7, lsl #32
               	mov	x17, #0x7654            // =30292
               	movk	x17, #0xba98, lsl #16
               	movk	x17, #0xfedc, lsl #32
               	cmp	x8, x17
               	b.ne	<addr>
               	ldurb	w8, [x0, #-0x1]
               	cmp	w8, #0xfe
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	orr	x8, x1, x7, lsl #32
               	orr	x1, x1, x7, lsl #32
               	and	x1, x1, #0xffff000000000000
               	orr	x1, x1, x8, lsr #4
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
               	sturb	w1, [x0, #-0x1f]
               	mov	x1, #0xffff             // =65535
               	sturh	w1, [x0, #-0x1e]
               	mov	x1, #0xffffffff         // =4294967295
               	stur	w1, [x0, #-0x1c]
               	mov	x1, #-0x1               // =-1
               	stur	x1, [x0, #-0x18]
               	stur	x1, [x0, #-0x10]
               	stur	x1, [x0, #-0x8]
               	mov	x1, #0x3                // =3
               	strb	w1, [x4]
               	ldur	w1, [x4, #0x9]
               	ldrb	w7, [x4, #0xd]
               	orr	x1, x1, x7, lsl #32
               	and	x1, x1, #0xfffffff000000000
               	mov	x7, #0x3210             // =12816
               	movk	x7, #0x7654, lsl #16
               	movk	x7, #0xba98, lsl #32
               	movk	x7, #0xfedc, lsl #48
               	mov	x17, #0x6789            // =26505
               	movk	x17, #0x2345, lsl #16
               	movk	x17, #0x1, lsl #32
               	orr	x1, x1, x17
               	stur	x7, [x4, #0x1]
               	stur	w1, [x4, #0x9]
               	lsr	x1, x1, #32
               	strb	w1, [x4, #0xd]
               	ldur	w7, [x4, #0x9]
               	ldrb	w8, [x4, #0xd]
               	orr	x1, x7, x8, lsl #32
               	mov	x9, #0xcba9             // =52137
               	movk	x9, #0xfed, lsl #16
               	orr	x9, x9, x1, lsl #28
               	mov	x1, #0x3210             // =12816
               	movk	x1, #0x7654, lsl #16
               	movk	x1, #0x8, lsl #32
               	orr	x10, x1, x9, lsl #36
               	add	x1, x10, #0x1
               	cmp	x1, x10
               	cset	x10, lo
               	add	x9, x10, x9, asr #28
               	and	x9, x9, #0xfffffffff
               	orr	x7, x7, x8, lsl #32
               	and	x7, x7, #0xfffffff000000000
               	orr	x7, x7, x9
               	stur	x1, [x4, #0x1]
               	stur	w7, [x4, #0x9]
               	lsr	x7, x7, #32
               	strb	w7, [x4, #0xd]
               	ldur	w7, [x4, #0x9]
               	ldrb	w8, [x4, #0xd]
               	orr	x7, x7, x8, lsl #32
               	lsl	x7, x7, #28
               	orr	x7, x7, x1, lsr #36
               	mov	x8, #0x6789             // =26505
               	movk	x8, #0x2345, lsl #16
               	movk	x8, #0x1, lsl #32
               	ubfx	x1, x1, #0, #36
               	orr	x1, x1, x7, lsl #36
               	mov	x17, #0x3211            // =12817
               	movk	x17, #0x7654, lsl #16
               	movk	x17, #0xba98, lsl #32
               	movk	x17, #0xfedc, lsl #48
               	eor	x1, x1, x17
               	eor	x7, x8, x7, asr #28
               	orr	x1, x1, x7
               	cbnz	x1, <addr>
               	ldurb	w1, [x0, #-0x1]
               	cmp	w1, #0xf1
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x1, #-0x2               // =-2
               	ldur	w7, [x4, #0x9]
               	ldrb	w8, [x4, #0xd]
               	orr	x7, x7, x8, lsl #32
               	and	x7, x7, #0xfffffff000000000
               	orr	x7, x7, #0xfffffffff
               	stur	x1, [x4, #0x1]
               	stur	w7, [x4, #0x9]
               	lsr	x7, x7, #32
               	strb	w7, [x4, #0xd]
               	ldur	w7, [x4, #0x9]
               	ldrb	w4, [x4, #0xd]
               	orr	x4, x7, x4, lsl #32
               	lsl	x4, x4, #28
               	orr	x4, x4, #0xfffffff
               	asr	x7, x4, #28
               	lsl	x4, x4, #36
               	orr	x4, x4, #0xffffffffe
               	eor	x1, x4, x1
               	mvn	x4, x7
               	orr	x1, x1, x4
               	cbnz	x1, <addr>
               	ldurb	w1, [x0, #-0x1]
               	cmp	w1, #0xff
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	strb	w6, [x2]
               	sturb	w6, [x0, #-0x1f]
               	sturh	wzr, [x0, #-0x1e]
               	stur	wzr, [x0, #-0x1c]
               	stur	xzr, [x0, #-0x18]
               	stur	xzr, [x0, #-0x10]
               	stur	xzr, [x0, #-0x8]
               	ldrb	w1, [x5]
               	and	x1, x1, #0xfffffffffffffffe
               	orr	x1, x1, #0x1
               	strb	w1, [x5]
               	ldrb	w1, [x5, #0x8]
               	and	x1, x1, #0xffffffffffffff01
               	mov	x17, #0xaa              // =170
               	orr	x1, x1, x17
               	strb	w1, [x5, #0x8]
               	ldr	x1, [x5]
               	ldrb	w4, [x5, #0x8]
               	and	x1, x1, #0x1
               	and	x4, x4, #0xfffffffffffffffe
               	mov	x17, #0x9bde            // =39902
               	movk	x17, #0x1357, lsl #16
               	movk	x17, #0x8acf, lsl #32
               	movk	x17, #0x246, lsl #48
               	orr	x1, x1, x17
               	orr	x4, x4, #0x1
               	str	x1, [x5]
               	strb	w4, [x5, #0x8]
               	ldrb	w4, [x5, #0x8]
               	lsr	x1, x1, #1
               	orr	x1, x1, x4, lsl #63
               	mov	x17, #0xcdef            // =52719
               	movk	x17, #0x89ab, lsl #16
               	movk	x17, #0x4567, lsl #32
               	movk	x17, #0x8123, lsl #48
               	cmp	x1, x17
               	b.ne	<addr>
               	ldrb	w1, [x5]
               	and	x1, x1, #0x1
               	cmp	w1, #0x1
               	b.ne	<addr>
               	asr	x1, x4, #1
               	cmp	w1, #0x55
               	b.ne	<addr>
               	ldurb	w1, [x0, #-0x1]
               	cmp	w1, #0xab
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	ldr	x1, [x5]
               	ldrb	w4, [x5, #0x8]
               	lsr	x7, x1, #1
               	orr	x7, x7, x4, lsl #63
               	mov	x17, #-0x3              // =-3
               	cmp	x7, x17
               	cset	x7, hs
               	and	x1, x1, #0x1
               	and	x4, x4, #0xfffffffffffffffe
               	orr	x1, x1, x7, lsl #1
               	str	x1, [x5]
               	strb	w4, [x5, #0x8]
               	ldrb	w4, [x5, #0x8]
               	lsr	x1, x1, #1
               	orr	x1, x1, x4, lsl #63
               	cbnz	x1, <addr>
               	ldrb	w1, [x5]
               	and	x1, x1, #0x1
               	cmp	w1, #0x1
               	b.ne	<addr>
               	asr	x1, x4, #1
               	cmp	w1, #0x55
               	b.ne	<addr>
               	ldurb	w1, [x0, #-0x1]
               	cmp	w1, #0xaa
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	strb	w6, [x2]
               	sturb	w6, [x0, #-0x1f]
               	sturh	wzr, [x0, #-0x1e]
               	stur	wzr, [x0, #-0x1c]
               	stur	xzr, [x0, #-0x18]
               	stur	xzr, [x0, #-0x10]
               	stur	xzr, [x0, #-0x8]
               	ldrb	w1, [x3]
               	and	x1, x1, #0xfffffffffffffffe
               	orr	x1, x1, #0x1
               	strb	w1, [x3]
               	ldrb	w1, [x3, #0x10]
               	and	x1, x1, #0xffffffffffffff01
               	mov	x17, #0x54              // =84
               	orr	x1, x1, x17
               	strb	w1, [x3, #0x10]
               	ldr	x1, [x3]
               	ldrb	w2, [x3, #0x10]
               	and	x1, x1, #0x1
               	mov	x17, #0x6420            // =25632
               	movk	x17, #0xeca8, lsl #16
               	movk	x17, #0x7530, lsl #32
               	movk	x17, #0xfdb9, lsl #48
               	orr	x1, x1, x17
               	mov	x4, #0x9bdf             // =39903
               	movk	x4, #0x1357, lsl #16
               	movk	x4, #0x8acf, lsl #32
               	movk	x4, #0x246, lsl #48
               	str	x1, [x3]
               	str	x4, [x3, #0x8]
               	and	x2, x2, #0xfffffffffffffffe
               	strb	w2, [x3, #0x10]
               	ldrb	w2, [x3, #0x10]
               	lsr	x1, x1, #1
               	orr	x4, x1, #0x8000000000000000
               	mov	x1, #0xcdef             // =52719
               	movk	x1, #0x89ab, lsl #16
               	movk	x1, #0x4567, lsl #32
               	movk	x1, #0x123, lsl #48
               	orr	x5, x1, x2, lsl #63
               	add	x1, x4, #0x1
               	cmp	x1, x4
               	cset	x4, lo
               	add	x4, x5, x4
               	lsl	x5, x4, #1
               	orr	x7, x5, x1, lsr #63
               	ldr	x5, [x3]
               	and	x5, x5, #0x1
               	orr	x5, x5, x1, lsl #1
               	orr	x1, x6, x7
               	str	x5, [x3]
               	str	x1, [x3, #0x8]
               	and	x2, x2, #0xfffffffffffffffe
               	orr	x2, x2, x4, lsr #63
               	strb	w2, [x3, #0x10]
               	ldrb	w2, [x3, #0x10]
               	lsr	x4, x1, #1
               	lsr	x5, x5, #1
               	orr	x1, x5, x1, lsl #63
               	orr	x4, x4, x2, lsl #63
               	mov	x17, #0x3211            // =12817
               	movk	x17, #0x7654, lsl #16
               	movk	x17, #0xba98, lsl #32
               	movk	x17, #0xfedc, lsl #48
               	eor	x1, x1, x17
               	mov	x17, #0xcdef            // =52719
               	movk	x17, #0x89ab, lsl #16
               	movk	x17, #0x4567, lsl #32
               	movk	x17, #0x123, lsl #48
               	eor	x4, x4, x17
               	orr	x1, x1, x4
               	cbnz	x1, <addr>
               	ldrb	w1, [x3]
               	and	x1, x1, #0x1
               	cmp	w1, #0x1
               	b.ne	<addr>
               	asr	x1, x2, #1
               	cmp	w1, #0x2a
               	b.ne	<addr>
               	ldurb	w1, [x0, #-0x1]
               	cmp	w1, #0x54
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	ldr	x1, [x3]
               	ldrb	w2, [x3, #0x10]
               	and	x1, x1, #0x1
               	orr	x1, x1, #0xfffffffffffffffe
               	mov	x4, #-0x1               // =-1
               	str	x1, [x3]
               	str	x4, [x3, #0x8]
               	and	x2, x2, #0xfffffffffffffffe
               	orr	x2, x2, #0x1
               	strb	w2, [x3, #0x10]
               	ldrb	w2, [x3, #0x10]
               	lsr	x1, x1, #1
               	orr	x1, x1, #0x8000000000000000
               	lsl	x4, x2, #63
               	orr	x4, x4, #0x7fffffffffffffff
               	mvn	x1, x1
               	mvn	x4, x4
               	orr	x1, x1, x4
               	cbnz	x1, <addr>
               	ldrb	w1, [x3]
               	and	x1, x1, #0x1
               	cmp	w1, #0x1
               	b.ne	<addr>
               	asr	x1, x2, #1
               	cmp	w1, #0x2a
               	b.ne	<addr>
               	ldurb	w0, [x0, #-0x1]
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
