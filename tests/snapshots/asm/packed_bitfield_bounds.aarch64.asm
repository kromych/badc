
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
               	cmn	x21, #0x1
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
               	mov	x4, #0xff               // =255
               	mov	x1, #-0x1               // =-1
               	stur	x1, [x0, #-0x10]
               	stur	x1, [x0, #-0x8]
               	ldurh	w1, [x0, #-0x3]
               	ldurb	w2, [x0, #-0x1]
               	orr	x1, x1, x2, lsl #16
               	and	x1, x1, #0xffffffffffc00000
               	mov	x17, #0xfffb            // =65531
               	movk	x17, #0x3f, lsl #16
               	orr	x1, x1, x17
               	sturh	w1, [x0, #-0x3]
               	lsr	x1, x1, #16
               	sturb	w1, [x0, #-0x1]
               	ldurh	w1, [x0, #-0x3]
               	ldurb	w2, [x0, #-0x1]
               	orr	x3, x1, x2, lsl #16
               	sbfx	x3, x3, #0, #22
               	add	x3, x3, #0x7
               	and	x3, x3, #0x3fffff
               	orr	x1, x1, x2, lsl #16
               	and	x1, x1, #0xffffffffffc00000
               	orr	x1, x1, x3
               	sturh	w1, [x0, #-0x3]
               	lsr	x1, x1, #16
               	sturb	w1, [x0, #-0x1]
               	ldurh	w2, [x0, #-0x3]
               	ldurb	w1, [x0, #-0x1]
               	orr	x2, x2, x1, lsl #16
               	sbfx	x2, x2, #0, #22
               	cmp	w2, #0x2
               	b.ne	<addr>
               	cmp	w1, #0xc0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x1, #-0x1               // =-1
               	stur	x1, [x0, #-0x10]
               	stur	x1, [x0, #-0x8]
               	ldur	w1, [x0, #-0x5]
               	ldurb	w2, [x0, #-0x1]
               	orr	x1, x1, x2, lsl #32
               	and	x1, x1, #0xfffffff000000000
               	mov	x17, #0x9877            // =39031
               	movk	x17, #0xdcba, lsl #16
               	movk	x17, #0xe, lsl #32
               	orr	x1, x1, x17
               	stur	w1, [x0, #-0x5]
               	lsr	x1, x1, #32
               	sturb	w1, [x0, #-0x1]
               	ldur	w2, [x0, #-0x5]
               	ldurb	w1, [x0, #-0x1]
               	orr	x3, x2, x1, lsl #32
               	sbfx	x3, x3, #0, #36
               	mov	x17, #-0x6789           // =-26505
               	movk	x17, #0xdcba, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x3, x17
               	b.ne	<addr>
               	cmp	w1, #0xfe
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	orr	x1, x2, x1, lsl #32
               	and	x1, x1, #0xfffffff000000000
               	mov	x17, #0x5               // =5
               	orr	x1, x1, x17
               	stur	w1, [x0, #-0x5]
               	lsr	x1, x1, #32
               	sturb	w1, [x0, #-0x1]
               	ldur	w2, [x0, #-0x5]
               	ldurb	w1, [x0, #-0x1]
               	orr	x2, x2, x1, lsl #32
               	sbfx	x2, x2, #0, #36
               	cmp	x2, #0x5
               	b.ne	<addr>
               	cmp	w1, #0xf0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x1, #-0x1               // =-1
               	stur	x1, [x0, #-0x10]
               	stur	x1, [x0, #-0x8]
               	ldur	w1, [x0, #-0x6]
               	ldurh	w2, [x0, #-0x2]
               	orr	x1, x1, x2, lsl #32
               	and	x1, x1, #0xfffff00000000000
               	orr	x1, x1, #0x7ffffffffff
               	stur	w1, [x0, #-0x6]
               	lsr	x1, x1, #32
               	sturh	w1, [x0, #-0x2]
               	ldur	w1, [x0, #-0x6]
               	ldurh	w2, [x0, #-0x2]
               	orr	x3, x1, x2, lsl #32
               	sbfx	x3, x3, #0, #44
               	sub	x3, x3, #0x1
               	and	x3, x3, #0xfffffffffff
               	orr	x1, x1, x2, lsl #32
               	and	x1, x1, #0xfffff00000000000
               	orr	x1, x1, x3
               	stur	w1, [x0, #-0x6]
               	lsr	x1, x1, #32
               	sturh	w1, [x0, #-0x2]
               	ldur	w1, [x0, #-0x6]
               	ldurh	w2, [x0, #-0x2]
               	orr	x1, x1, x2, lsl #32
               	sbfx	x1, x1, #0, #44
               	mov	x17, #0x7fffffffffe     // =8796093022206
               	cmp	x1, x17
               	b.ne	<addr>
               	ldurb	w1, [x0, #-0x1]
               	cmp	w1, #0xf7
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x1, #-0x1               // =-1
               	stur	x1, [x0, #-0x10]
               	stur	x1, [x0, #-0x8]
               	ldur	w1, [x0, #-0x7]
               	ldurh	w2, [x0, #-0x3]
               	orr	x1, x1, x2, lsl #32
               	ldurb	w2, [x0, #-0x1]
               	orr	x1, x1, x2, lsl #48
               	and	x1, x1, #0xfff0000000000000
               	orr	x1, x1, #0xfffffffffffff
               	stur	w1, [x0, #-0x7]
               	lsr	x2, x1, #32
               	sturh	w2, [x0, #-0x3]
               	lsr	x1, x1, #48
               	sturb	w1, [x0, #-0x1]
               	ldur	w1, [x0, #-0x7]
               	ldurh	w2, [x0, #-0x3]
               	orr	x5, x1, x2, lsl #32
               	ldurb	w3, [x0, #-0x1]
               	orr	x5, x5, x3, lsl #48
               	sbfx	x5, x5, #0, #52
               	mov	x17, #0x5               // =5
               	eor	x5, x5, x17
               	and	x5, x5, #0xfffffffffffff
               	orr	x1, x1, x2, lsl #32
               	orr	x1, x1, x3, lsl #48
               	and	x1, x1, #0xfff0000000000000
               	orr	x1, x1, x5
               	stur	w1, [x0, #-0x7]
               	lsr	x2, x1, #32
               	sturh	w2, [x0, #-0x3]
               	lsr	x1, x1, #48
               	sturb	w1, [x0, #-0x1]
               	ldur	w2, [x0, #-0x7]
               	ldurh	w3, [x0, #-0x3]
               	orr	x5, x2, x3, lsl #32
               	ldurb	w1, [x0, #-0x1]
               	orr	x5, x5, x1, lsl #48
               	sbfx	x5, x5, #0, #52
               	cmn	x5, #0x6
               	b.ne	<addr>
               	cmp	w1, #0xff
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	orr	x2, x2, x3, lsl #32
               	orr	x1, x2, x1, lsl #48
               	and	x1, x1, #0xfff0000000000000
               	stur	w1, [x0, #-0x7]
               	lsr	x2, x1, #32
               	sturh	w2, [x0, #-0x3]
               	lsr	x1, x1, #48
               	sturb	w1, [x0, #-0x1]
               	ldur	w1, [x0, #-0x7]
               	ldurh	w2, [x0, #-0x3]
               	orr	x2, x1, x2, lsl #32
               	ldurb	w1, [x0, #-0x1]
               	orr	x2, x2, x1, lsl #48
               	sbfx	x2, x2, #0, #52
               	cbnz	x2, <addr>
               	cmp	w1, #0xf0
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x3, #0x0                // =0
               	stur	xzr, [x0, #-0x10]
               	stur	xzr, [x0, #-0x8]
               	ldurb	w1, [x0, #-0x3]
               	and	x1, x1, #0xfffffffffffffff0
               	mov	x17, #0x9               // =9
               	orr	x1, x1, x17
               	sturb	w1, [x0, #-0x3]
               	ldurh	w1, [x0, #-0x3]
               	ldurb	w2, [x0, #-0x1]
               	orr	x1, x1, x2, lsl #16
               	and	x1, x1, #0xffffffffff00000f
               	mov	x17, #0xcbb0            // =52144
               	movk	x17, #0xed, lsl #16
               	orr	x1, x1, x17
               	sturh	w1, [x0, #-0x3]
               	lsr	x1, x1, #16
               	sturb	w1, [x0, #-0x1]
               	ldurh	w1, [x0, #-0x3]
               	ldurb	w2, [x0, #-0x1]
               	orr	x5, x1, x2, lsl #16
               	sbfx	x5, x5, #4, #20
               	mov	x17, #-0x2345           // =-9029
               	movk	x17, #0xfffe, lsl #16
               	cmp	w5, w17
               	b.ne	<addr>
               	ldurb	w5, [x0, #-0x3]
               	and	x5, x5, #0xf
               	cmp	w5, #0x9
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	orr	x1, x1, x2, lsl #16
               	sbfx	x1, x1, #4, #20
               	add	x1, x1, #0x1
               	and	x1, x1, #0xfffff
               	ldurh	w2, [x0, #-0x3]
               	ldurb	w5, [x0, #-0x1]
               	orr	x2, x2, x5, lsl #16
               	and	x2, x2, #0xffffffffff00000f
               	orr	x1, x2, x1, lsl #4
               	sturh	w1, [x0, #-0x3]
               	lsr	x1, x1, #16
               	sturb	w1, [x0, #-0x1]
               	ldurh	w1, [x0, #-0x3]
               	ldurb	w2, [x0, #-0x1]
               	orr	x1, x1, x2, lsl #16
               	sbfx	x1, x1, #4, #20
               	mov	x17, #-0x2344           // =-9028
               	movk	x17, #0xfffe, lsl #16
               	cmp	w1, w17
               	b.ne	<addr>
               	ldurb	w1, [x0, #-0x3]
               	and	x1, x1, #0xf
               	cmp	w1, #0x9
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x1, #-0x1               // =-1
               	stur	x1, [x0, #-0x10]
               	stur	x1, [x0, #-0x8]
               	ldurh	w1, [x0, #-0x3]
               	ldurb	w2, [x0, #-0x1]
               	orr	x1, x1, x2, lsl #16
               	and	x1, x1, #0xffffffffff800000
               	mov	x17, #0xaaaa            // =43690
               	movk	x17, #0x2a, lsl #16
               	orr	x1, x1, x17
               	sturh	w1, [x0, #-0x3]
               	lsr	x1, x1, #16
               	sturb	w1, [x0, #-0x1]
               	ldurh	w2, [x0, #-0x3]
               	ldurb	w1, [x0, #-0x1]
               	orr	x2, x2, x1, lsl #16
               	and	x2, x2, #0x7fffff
               	mov	x17, #0xaaaa            // =43690
               	movk	x17, #0x2a, lsl #16
               	cmp	w2, w17
               	b.ne	<addr>
               	cmp	w1, #0xaa
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	stur	xzr, [x0, #-0x10]
               	sturb	w3, [x0, #-0x7]
               	mov	x1, #0x5a00             // =23040
               	stur	x1, [x0, #-0x8]
               	ldur	w1, [x0, #-0x6]
               	ldurh	w2, [x0, #-0x2]
               	orr	x1, x1, x2, lsl #32
               	and	x1, x1, #0xffff000000000000
               	mov	x17, #0x7654            // =30292
               	movk	x17, #0xba98, lsl #16
               	movk	x17, #0xfedc, lsl #32
               	orr	x1, x1, x17
               	stur	w1, [x0, #-0x6]
               	lsr	x1, x1, #32
               	sturh	w1, [x0, #-0x2]
               	ldur	w1, [x0, #-0x6]
               	ldurh	w2, [x0, #-0x2]
               	orr	x5, x1, x2, lsl #32
               	mov	x17, #0x7654            // =30292
               	movk	x17, #0xba98, lsl #16
               	movk	x17, #0xfedc, lsl #32
               	cmp	x5, x17
               	b.ne	<addr>
               	ldurb	w5, [x0, #-0x1]
               	cmp	w5, #0xfe
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	orr	x5, x1, x2, lsl #32
               	orr	x1, x1, x2, lsl #32
               	and	x1, x1, #0xffff000000000000
               	orr	x1, x1, x5, lsr #4
               	stur	w1, [x0, #-0x6]
               	lsr	x1, x1, #32
               	sturh	w1, [x0, #-0x2]
               	ldur	w1, [x0, #-0x6]
               	ldurh	w2, [x0, #-0x2]
               	orr	x1, x1, x2, lsl #32
               	mov	x17, #0x8765            // =34661
               	movk	x17, #0xcba9, lsl #16
               	movk	x17, #0xfed, lsl #32
               	cmp	x1, x17
               	b.ne	<addr>
               	mov	x1, #-0x1               // =-1
               	stur	x1, [x0, #-0x20]
               	stur	x1, [x0, #-0x18]
               	mov	x1, #0xffff             // =65535
               	sturh	w1, [x0, #-0x10]
               	sturb	w4, [x0, #-0xe]
               	mov	x1, #0xff03             // =65283
               	mov	x2, #0xffffffff         // =4294967295
               	stur	w2, [x0, #-0xc]
               	mov	x2, #-0x1               // =-1
               	stur	x2, [x0, #-0x8]
               	sturh	w1, [x0, #-0xe]
               	ldur	w1, [x0, #-0x5]
               	ldurb	w2, [x0, #-0x1]
               	orr	x1, x1, x2, lsl #32
               	and	x1, x1, #0xfffffff000000000
               	mov	x2, #0x3210             // =12816
               	movk	x2, #0x7654, lsl #16
               	movk	x2, #0xba98, lsl #32
               	movk	x2, #0xfedc, lsl #48
               	mov	x17, #0x6789            // =26505
               	movk	x17, #0x2345, lsl #16
               	movk	x17, #0x1, lsl #32
               	orr	x1, x1, x17
               	stur	x2, [x0, #-0xd]
               	stur	w1, [x0, #-0x5]
               	lsr	x1, x1, #32
               	sturb	w1, [x0, #-0x1]
               	ldur	w2, [x0, #-0x5]
               	ldurb	w4, [x0, #-0x1]
               	orr	x1, x2, x4, lsl #32
               	mov	x5, #0xcba9             // =52137
               	movk	x5, #0xfed, lsl #16
               	orr	x5, x5, x1, lsl #28
               	mov	x1, #0x3210             // =12816
               	movk	x1, #0x7654, lsl #16
               	movk	x1, #0x8, lsl #32
               	orr	x6, x1, x5, lsl #36
               	add	x1, x6, #0x1
               	cmp	x1, x6
               	cset	x6, lo
               	add	x5, x6, x5, asr #28
               	and	x5, x5, #0xfffffffff
               	orr	x2, x2, x4, lsl #32
               	and	x2, x2, #0xfffffff000000000
               	orr	x2, x2, x5
               	stur	x1, [x0, #-0xd]
               	stur	w2, [x0, #-0x5]
               	lsr	x2, x2, #32
               	sturb	w2, [x0, #-0x1]
               	ldur	w4, [x0, #-0x5]
               	ldurb	w2, [x0, #-0x1]
               	orr	x4, x4, x2, lsl #32
               	lsl	x4, x4, #28
               	orr	x4, x4, x1, lsr #36
               	mov	x5, #0x6789             // =26505
               	movk	x5, #0x2345, lsl #16
               	movk	x5, #0x1, lsl #32
               	ubfx	x1, x1, #0, #36
               	orr	x1, x1, x4, lsl #36
               	mov	x17, #0x3211            // =12817
               	movk	x17, #0x7654, lsl #16
               	movk	x17, #0xba98, lsl #32
               	movk	x17, #0xfedc, lsl #48
               	eor	x1, x1, x17
               	eor	x4, x5, x4, asr #28
               	orr	x1, x1, x4
               	cbnz	x1, <addr>
               	cmp	w2, #0xf1
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x1, #-0x2               // =-2
               	ldur	w2, [x0, #-0x5]
               	ldurb	w4, [x0, #-0x1]
               	orr	x2, x2, x4, lsl #32
               	and	x2, x2, #0xfffffff000000000
               	orr	x2, x2, #0xfffffffff
               	stur	x1, [x0, #-0xd]
               	stur	w2, [x0, #-0x5]
               	lsr	x2, x2, #32
               	sturb	w2, [x0, #-0x1]
               	ldur	w4, [x0, #-0x5]
               	ldurb	w2, [x0, #-0x1]
               	orr	x4, x4, x2, lsl #32
               	lsl	x4, x4, #28
               	orr	x4, x4, #0xfffffff
               	asr	x5, x4, #28
               	lsl	x4, x4, #36
               	orr	x4, x4, #0xffffffffe
               	eor	x1, x4, x1
               	mvn	x4, x5
               	orr	x1, x1, x4
               	cbnz	x1, <addr>
               	cmp	w2, #0xff
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	stur	xzr, [x0, #-0x20]
               	stur	xzr, [x0, #-0x18]
               	stur	xzr, [x0, #-0x10]
               	stur	xzr, [x0, #-0x8]
               	ldurb	w1, [x0, #-0x9]
               	and	x1, x1, #0xfffffffffffffffe
               	orr	x1, x1, #0x1
               	sturb	w1, [x0, #-0x9]
               	ldurb	w1, [x0, #-0x1]
               	and	x1, x1, #0xffffffffffffff01
               	mov	x17, #0xaa              // =170
               	orr	x1, x1, x17
               	sturb	w1, [x0, #-0x1]
               	ldur	x1, [x0, #-0x9]
               	ldurb	w2, [x0, #-0x1]
               	and	x1, x1, #0x1
               	and	x4, x2, #0xfffffffffffffffe
               	mov	x17, #0x9bde            // =39902
               	movk	x17, #0x1357, lsl #16
               	movk	x17, #0x8acf, lsl #32
               	movk	x17, #0x246, lsl #48
               	orr	x2, x1, x17
               	orr	x1, x4, #0x1
               	stur	x2, [x0, #-0x9]
               	sturb	w1, [x0, #-0x1]
               	ldurb	w1, [x0, #-0x1]
               	lsr	x2, x2, #1
               	orr	x2, x2, x1, lsl #63
               	mov	x17, #0xcdef            // =52719
               	movk	x17, #0x89ab, lsl #16
               	movk	x17, #0x4567, lsl #32
               	movk	x17, #0x8123, lsl #48
               	cmp	x2, x17
               	b.ne	<addr>
               	ldurb	w2, [x0, #-0x9]
               	and	x2, x2, #0x1
               	cmp	w2, #0x1
               	b.ne	<addr>
               	asr	x2, x1, #1
               	cmp	w2, #0x55
               	b.ne	<addr>
               	cmp	w1, #0xab
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	ldur	x1, [x0, #-0x9]
               	ldurb	w2, [x0, #-0x1]
               	lsr	x4, x1, #1
               	orr	x4, x4, x2, lsl #63
               	cmn	x4, #0x3
               	cset	x4, hs
               	and	x1, x1, #0x1
               	and	x5, x2, #0xfffffffffffffffe
               	orr	x2, x1, x4, lsl #1
               	stur	x2, [x0, #-0x9]
               	sturb	w5, [x0, #-0x1]
               	ldurb	w1, [x0, #-0x1]
               	lsr	x2, x2, #1
               	orr	x2, x2, x1, lsl #63
               	cbnz	x2, <addr>
               	ldurb	w2, [x0, #-0x9]
               	and	x2, x2, #0x1
               	cmp	w2, #0x1
               	b.ne	<addr>
               	asr	x2, x1, #1
               	cmp	w2, #0x55
               	b.ne	<addr>
               	cmp	w1, #0xaa
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	stur	xzr, [x0, #-0x20]
               	stur	xzr, [x0, #-0x18]
               	stur	xzr, [x0, #-0x10]
               	stur	xzr, [x0, #-0x8]
               	ldurb	w1, [x0, #-0x11]
               	and	x1, x1, #0xfffffffffffffffe
               	orr	x1, x1, #0x1
               	sturb	w1, [x0, #-0x11]
               	ldurb	w1, [x0, #-0x1]
               	and	x1, x1, #0xffffffffffffff01
               	mov	x17, #0x54              // =84
               	orr	x1, x1, x17
               	sturb	w1, [x0, #-0x1]
               	ldur	x1, [x0, #-0x11]
               	ldurb	w2, [x0, #-0x1]
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
               	stur	x1, [x0, #-0x11]
               	stur	x4, [x0, #-0x9]
               	and	x2, x2, #0xfffffffffffffffe
               	sturb	w2, [x0, #-0x1]
               	ldurb	w2, [x0, #-0x1]
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
               	orr	x6, x5, x1, lsr #63
               	ldur	x5, [x0, #-0x11]
               	and	x5, x5, #0x1
               	orr	x5, x5, x1, lsl #1
               	orr	x1, x3, x6
               	stur	x5, [x0, #-0x11]
               	stur	x1, [x0, #-0x9]
               	and	x2, x2, #0xfffffffffffffffe
               	orr	x2, x2, x4, lsr #63
               	sturb	w2, [x0, #-0x1]
               	ldurb	w2, [x0, #-0x1]
               	lsr	x3, x1, #1
               	lsr	x4, x5, #1
               	orr	x1, x4, x1, lsl #63
               	orr	x3, x3, x2, lsl #63
               	mov	x17, #0x3211            // =12817
               	movk	x17, #0x7654, lsl #16
               	movk	x17, #0xba98, lsl #32
               	movk	x17, #0xfedc, lsl #48
               	eor	x1, x1, x17
               	mov	x17, #0xcdef            // =52719
               	movk	x17, #0x89ab, lsl #16
               	movk	x17, #0x4567, lsl #32
               	movk	x17, #0x123, lsl #48
               	eor	x3, x3, x17
               	orr	x1, x1, x3
               	cbnz	x1, <addr>
               	ldurb	w1, [x0, #-0x11]
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
               	ldur	x2, [x0, #-0x11]
               	and	x2, x2, #0x1
               	orr	x2, x2, #0xfffffffffffffffe
               	mov	x3, #-0x1               // =-1
               	stur	x2, [x0, #-0x11]
               	stur	x3, [x0, #-0x9]
               	and	x1, x1, #0xfffffffffffffffe
               	orr	x1, x1, #0x1
               	sturb	w1, [x0, #-0x1]
               	ldurb	w1, [x0, #-0x1]
               	lsr	x2, x2, #1
               	orr	x2, x2, #0x8000000000000000
               	lsl	x3, x1, #63
               	orr	x3, x3, #0x7fffffffffffffff
               	mvn	x2, x2
               	mvn	x3, x3
               	orr	x2, x2, x3
               	cbnz	x2, <addr>
               	ldurb	w0, [x0, #-0x11]
               	and	x0, x0, #0x1
               	cmp	w0, #0x1
               	b.ne	<addr>
               	asr	x0, x1, #1
               	cmp	w0, #0x2a
               	b.ne	<addr>
               	cmp	w1, #0x55
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
