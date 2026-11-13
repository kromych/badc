
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
               	mov	x1, #0x1                // =1
               	mov	x2, #0x200              // =512
               	stur	x1, [x29, #-0x10]
               	stur	x2, [x29, #-0x8]
               	ldur	w1, [x29, #-0x8]
               	and	x1, x1, #0xfffffffffffffff8
               	mov	x17, #0x5               // =5
               	orr	x1, x1, x17
               	stur	w1, [x29, #-0x8]
               	sbfx	x1, x1, #0, #3
               	cmn	w1, #0x3
               	b.ne	<addr>
               	ldurb	w1, [x29, #-0x7]
               	cmp	w1, #0x2
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sturb	wzr, [x29, #-0x8]
               	mov	x1, #0x3                // =3
               	mov	x2, #0x400              // =1024
               	sturb	wzr, [x29, #-0x3]
               	stur	w1, [x29, #-0x8]
               	sturh	w2, [x29, #-0x4]
               	ldur	w0, [x29, #-0x7]
               	and	x0, x0, #0xffffffffc0000000
               	mov	x17, #0x32eb            // =13035
               	movk	x17, #0x38a4, lsl #16
               	orr	x0, x0, x17
               	stur	w0, [x29, #-0x7]
               	sbfx	x1, x0, #0, #30
               	mov	x17, #-0xcd15           // =-52501
               	movk	x17, #0xf8a4, lsl #16
               	cmp	w1, w17
               	b.ne	<addr>
               	and	x0, x0, #0xffffffffc0000000
               	orr	x0, x0, #0x1fffffff
               	stur	w0, [x29, #-0x7]
               	sbfx	x0, x0, #0, #30
               	mov	x17, #0x1fffffff        // =536870911
               	cmp	w0, w17
               	b.ne	<addr>
               	mov	x0, #0x5                // =5
               	movk	x0, #0x6, lsl #48
               	stur	x0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	and	x0, x0, #0xffff0000000000ff
               	mov	x17, #0x7700            // =30464
               	movk	x17, #0xba98, lsl #16
               	movk	x17, #0xfedc, lsl #32
               	orr	x0, x0, x17
               	stur	x0, [x29, #-0x8]
               	ldurb	w1, [x29, #-0x8]
               	cmp	w1, #0x5
               	b.ne	<addr>
               	sbfx	x0, x0, #8, #40
               	mov	x17, #-0x6789           // =-26505
               	movk	x17, #0xdcba, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x0, x17
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x2]
               	cmp	w0, #0x6
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x9                // =9
               	mov	x1, #0xa00              // =2560
               	stur	x0, [x29, #-0x10]
               	stur	x1, [x29, #-0x8]
               	ldurh	w0, [x29, #-0x8]
               	and	x0, x0, #0xfffffffffffffff0
               	orr	x0, x0, #0x8
               	sturh	w0, [x29, #-0x8]
               	sbfx	x0, x0, #0, #4
               	cmn	w0, #0x8
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x7]
               	cmp	w0, #0xa
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	sturb	w0, [x29, #-0xb]
               	sturb	w0, [x29, #-0xa]
               	stur	wzr, [x29, #-0x8]
               	mov	x1, #0xc0000000000      // =13194139533312
               	movk	x1, #0xd, lsl #48
               	stur	x1, [x29, #-0x10]
               	ldur	w1, [x29, #-0xf]
               	and	x1, x1, #0xffffffffc0000000
               	orr	x1, x1, #0x3fffffff
               	stur	w1, [x29, #-0xf]
               	sbfx	x1, x1, #0, #30
               	cmn	w1, #0x1
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
