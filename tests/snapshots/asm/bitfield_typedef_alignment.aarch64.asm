
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
               	sub	sp, sp, #0x10
               	stur	xzr, [x29, #-0x10]
               	stur	xzr, [x29, #-0x8]
               	mov	x1, #0x1                // =1
               	sturb	w1, [x29, #-0x10]
               	mov	x1, #0x2                // =2
               	sturb	w1, [x29, #-0x7]
               	ldur	w1, [x29, #-0x8]
               	and	x1, x1, #0xfffffffffffffff8
               	mov	x17, #0x5               // =5
               	orr	x1, x1, x17
               	stur	w1, [x29, #-0x8]
               	sbfx	x1, x1, #0, #3
               	mov	x17, #-0x3              // =-3
               	cmp	w1, w17
               	b.ne	<addr>
               	ldurb	w1, [x29, #-0x7]
               	cmp	w1, #0x2
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x8
               	sturb	wzr, [x29, #-0x8]
               	sturb	wzr, [x29, #-0x7]
               	sturb	wzr, [x29, #-0x6]
               	sturb	wzr, [x29, #-0x5]
               	sturb	wzr, [x29, #-0x4]
               	sturb	wzr, [x29, #-0x3]
               	mov	x2, #0x3                // =3
               	sturb	w2, [x29, #-0x8]
               	mov	x2, #0x4                // =4
               	sturb	w2, [x29, #-0x3]
               	ldur	w2, [x1, #0x1]
               	and	x2, x2, #0xffffffffc0000000
               	mov	x17, #0x32eb            // =13035
               	movk	x17, #0x38a4, lsl #16
               	orr	x2, x2, x17
               	stur	w2, [x1, #0x1]
               	sbfx	x3, x2, #0, #30
               	mov	x17, #-0xcd15           // =-52501
               	movk	x17, #0xf8a4, lsl #16
               	cmp	w3, w17
               	b.ne	<addr>
               	and	x2, x2, #0xffffffffc0000000
               	orr	x2, x2, #0x1fffffff
               	stur	w2, [x1, #0x1]
               	sbfx	x2, x2, #0, #30
               	mov	x17, #0x1fffffff        // =536870911
               	cmp	w2, w17
               	b.ne	<addr>
               	stur	wzr, [x29, #-0x8]
               	stur	wzr, [x29, #-0x4]
               	mov	x2, #0x5                // =5
               	sturb	w2, [x29, #-0x8]
               	mov	x2, #0x6                // =6
               	sturb	w2, [x29, #-0x2]
               	ldr	x2, [x1]
               	and	x2, x2, #0xffff0000000000ff
               	mov	x17, #0x7700            // =30464
               	movk	x17, #0xba98, lsl #16
               	movk	x17, #0xfedc, lsl #32
               	orr	x2, x2, x17
               	str	x2, [x1]
               	ldurb	w1, [x29, #-0x8]
               	cmp	w1, #0x5
               	b.ne	<addr>
               	sbfx	x1, x2, #8, #40
               	mov	x17, #-0x6789           // =-26505
               	movk	x17, #0xdcba, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x1, x17
               	b.ne	<addr>
               	ldurb	w1, [x29, #-0x2]
               	cmp	w1, #0x6
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	xzr, [x29, #-0x10]
               	stur	xzr, [x29, #-0x8]
               	mov	x0, #0x9                // =9
               	sturb	w0, [x29, #-0x10]
               	mov	x0, #0xa                // =10
               	sturb	w0, [x29, #-0x7]
               	ldurh	w0, [x29, #-0x8]
               	and	x0, x0, #0xfffffffffffffff0
               	orr	x0, x0, #0x8
               	sturh	w0, [x29, #-0x8]
               	sbfx	x0, x0, #0, #4
               	mov	x17, #-0x8              // =-8
               	cmp	w0, w17
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x7]
               	cmp	w0, #0xa
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	sturb	w0, [x29, #-0x10]
               	sturb	w0, [x29, #-0xf]
               	sturb	w0, [x29, #-0xe]
               	sturb	w0, [x29, #-0xd]
               	sturb	w0, [x29, #-0xc]
               	sturb	w0, [x29, #-0xb]
               	sturb	w0, [x29, #-0xa]
               	sturb	w0, [x29, #-0x9]
               	sturb	w0, [x29, #-0x8]
               	sturb	w0, [x29, #-0x7]
               	sturb	w0, [x29, #-0x6]
               	sturb	w0, [x29, #-0x5]
               	sub	x1, x29, #0x10
               	mov	x2, #0xc                // =12
               	sturb	w2, [x29, #-0xb]
               	mov	x2, #0xd                // =13
               	sturb	w2, [x29, #-0xa]
               	ldur	w2, [x1, #0x1]
               	and	x2, x2, #0xffffffffc0000000
               	orr	x2, x2, #0x3fffffff
               	stur	w2, [x1, #0x1]
               	sbfx	x1, x2, #0, #30
               	mov	x17, #-0x1              // =-1
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
