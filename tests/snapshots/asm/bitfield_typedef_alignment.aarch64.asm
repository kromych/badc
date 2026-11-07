
bitfield_typedef_alignment.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x60
               	sub	x0, x29, #0x48
               	mov	x1, #0x0                // =0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	mov	x0, #0x1                // =1
               	sturb	w0, [x29, #-0x48]
               	mov	x0, #0x2                // =2
               	sturb	w0, [x29, #-0x3f]
               	ldur	w0, [x29, #-0x40]
               	and	x0, x0, #0xfffffffffffffff8
               	mov	x17, #0x5               // =5
               	orr	x0, x0, x17
               	stur	w0, [x29, #-0x40]
               	ldurb	w0, [x29, #-0x48]
               	cmp	w0, #0x1
               	b.ne	<addr>
               	ldur	w0, [x29, #-0x40]
               	sbfx	x0, x0, #0, #3
               	mov	x17, #-0x3              // =-3
               	cmp	w0, w17
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x3f]
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x60
               	mov	x1, #0x0                // =0
               	mov	x2, #0x6                // =6
               	bl	<addr>
               	sub	x0, x29, #0x60
               	mov	x1, #0x3                // =3
               	sturb	w1, [x29, #-0x60]
               	mov	x1, #0x4                // =4
               	sturb	w1, [x29, #-0x5b]
               	ldur	w1, [x0, #0x1]
               	and	x1, x1, #0xffffffffc0000000
               	mov	x17, #0x32eb            // =13035
               	movk	x17, #0x38a4, lsl #16
               	orr	x1, x1, x17
               	stur	w1, [x0, #0x1]
               	ldurb	w1, [x29, #-0x60]
               	cmp	w1, #0x3
               	b.ne	<addr>
               	ldur	w1, [x0, #0x1]
               	sbfx	x1, x1, #0, #30
               	mov	x17, #-0xcd15           // =-52501
               	movk	x17, #0xf8a4, lsl #16
               	cmp	w1, w17
               	b.ne	<addr>
               	ldurb	w1, [x29, #-0x5b]
               	cmp	w1, #0x4
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w1, [x0, #0x1]
               	and	x1, x1, #0xffffffffc0000000
               	orr	x1, x1, #0x1fffffff
               	stur	w1, [x0, #0x1]
               	ldurb	w1, [x29, #-0x60]
               	cmp	w1, #0x3
               	b.ne	<addr>
               	ldur	w0, [x0, #0x1]
               	sbfx	x0, x0, #0, #30
               	mov	x17, #0x1fffffff        // =536870911
               	cmp	w0, w17
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x5b]
               	cmp	w0, #0x4
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x58
               	mov	x1, #0x0                // =0
               	mov	x2, #0x8                // =8
               	bl	<addr>
               	sub	x0, x29, #0x58
               	mov	x1, #0x5                // =5
               	sturb	w1, [x29, #-0x58]
               	mov	x1, #0x6                // =6
               	sturb	w1, [x29, #-0x52]
               	ldr	x1, [x0]
               	and	x1, x1, #0xffff0000000000ff
               	mov	x17, #0x7700            // =30464
               	movk	x17, #0xba98, lsl #16
               	movk	x17, #0xfedc, lsl #32
               	orr	x1, x1, x17
               	str	x1, [x0]
               	ldurb	w1, [x29, #-0x58]
               	cmp	w1, #0x5
               	b.ne	<addr>
               	ldr	x0, [x0]
               	sbfx	x0, x0, #8, #40
               	mov	x17, #-0x6789           // =-26505
               	movk	x17, #0xdcba, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x0, x17
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x52]
               	cmp	w0, #0x6
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	mov	x1, #0x0                // =0
               	mov	x2, #0x18               // =24
               	bl	<addr>
               	mov	x0, #0x7                // =7
               	sturb	w0, [x29, #-0x18]
               	mov	x0, #0x8                // =8
               	sturb	w0, [x29, #-0x4]
               	ldur	w0, [x29, #-0x10]
               	and	x0, x0, #0xfffffffffffffff8
               	orr	x0, x0, #0x3
               	stur	w0, [x29, #-0x10]
               	ldur	w0, [x29, #-0x8]
               	and	x0, x0, #0xffffffffc0000000
               	mov	x17, #0xba99            // =47769
               	movk	x17, #0x3edc, lsl #16
               	orr	x0, x0, x17
               	stur	w0, [x29, #-0x8]
               	ldurb	w0, [x29, #-0x18]
               	cmp	w0, #0x7
               	b.ne	<addr>
               	ldur	w0, [x29, #-0x10]
               	sbfx	x0, x0, #0, #3
               	cmp	w0, #0x3
               	b.ne	<addr>
               	ldur	w0, [x29, #-0x8]
               	sbfx	x0, x0, #0, #30
               	mov	x17, #-0x4567           // =-17767
               	movk	x17, #0xfedc, lsl #16
               	cmp	w0, w17
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x4]
               	cmp	w0, #0x8
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x38
               	mov	x1, #0x0                // =0
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	mov	x0, #0x9                // =9
               	sturb	w0, [x29, #-0x38]
               	mov	x0, #0xa                // =10
               	sturb	w0, [x29, #-0x2f]
               	ldurh	w0, [x29, #-0x30]
               	and	x0, x0, #0xfffffffffffffff0
               	orr	x0, x0, #0x8
               	sturh	w0, [x29, #-0x30]
               	ldurb	w0, [x29, #-0x38]
               	cmp	w0, #0x9
               	b.ne	<addr>
               	ldurh	w0, [x29, #-0x30]
               	sbfx	x0, x0, #0, #4
               	mov	x17, #-0x8              // =-8
               	cmp	w0, w17
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x2f]
               	cmp	w0, #0xa
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x28
               	mov	x1, #0x0                // =0
               	mov	x2, #0xc                // =12
               	bl	<addr>
               	sub	x0, x29, #0x28
               	mov	x1, #0xc                // =12
               	sturb	w1, [x29, #-0x23]
               	mov	x1, #0xd                // =13
               	sturb	w1, [x29, #-0x22]
               	ldur	w1, [x0, #0x1]
               	and	x1, x1, #0xffffffffc0000000
               	orr	x1, x1, #0x3fffffff
               	stur	w1, [x0, #0x1]
               	ldurb	w1, [x29, #-0x23]
               	cmp	w1, #0xc
               	b.ne	<addr>
               	ldurb	w1, [x29, #-0x22]
               	cmp	w1, #0xd
               	b.ne	<addr>
               	ldur	w0, [x0, #0x1]
               	sbfx	x0, x0, #0, #30
               	mov	x17, #-0x1              // =-1
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x50
               	mov	x1, #0x0                // =0
               	mov	x2, #0x2                // =2
               	bl	<addr>
               	mov	x0, #0xb                // =11
               	sturb	w0, [x29, #-0x4f]
               	ldurb	w0, [x29, #-0x50]
               	and	x0, x0, #0xfffffffffffffff8
               	orr	x0, x0, #0x4
               	sturb	w0, [x29, #-0x50]
               	ldurb	w0, [x29, #-0x50]
               	sbfx	x0, x0, #0, #3
               	mov	x17, #-0x4              // =-4
               	cmp	w0, w17
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x4f]
               	cmp	w0, #0xb
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
