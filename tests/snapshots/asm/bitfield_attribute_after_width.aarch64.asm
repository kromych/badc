
bitfield_attribute_after_width.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x40
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x8]
               	mov	x1, #0x2                // =2
               	sturb	w1, [x29, #-0x7]
               	ldur	w1, [x29, #-0x8]
               	and	x1, x1, #0xfffffffffffffff0
               	mov	x17, #0xd               // =13
               	orr	x1, x1, x17
               	stur	w1, [x29, #-0x8]
               	and	x1, x1, #0xffffffffffffff0f
               	mov	x17, #0x50              // =80
               	orr	x1, x1, x17
               	stur	w1, [x29, #-0x8]
               	ldurb	w2, [x29, #-0x8]
               	cmp	w2, #0x5d
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sbfx	x2, x1, #0, #4
               	mov	x17, #-0x3              // =-3
               	cmp	w2, w17
               	b.ne	<addr>
               	mov	w1, w1
               	sbfx	x1, x1, #4, #4
               	cmp	w1, #0x5
               	b.ne	<addr>
               	ldurb	w1, [x29, #-0x7]
               	cmp	w1, #0x2
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	x0, [x29, #-0x8]
               	mov	x1, #0x4                // =4
               	sturb	w1, [x29, #-0x7]
               	ldur	w1, [x29, #-0x8]
               	and	x1, x1, #0xfffffffffffffff0
               	orr	x1, x1, #0x8
               	stur	w1, [x29, #-0x8]
               	sbfx	x1, x1, #0, #4
               	mov	x17, #-0x8              // =-8
               	cmp	w1, w17
               	b.ne	<addr>
               	ldurb	w1, [x29, #-0x7]
               	cmp	w1, #0x4
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sturb	w0, [x29, #-0x8]
               	sturb	w0, [x29, #-0x7]
               	sturb	w0, [x29, #-0x6]
               	sturb	w0, [x29, #-0x5]
               	sturb	w0, [x29, #-0x4]
               	sturb	w0, [x29, #-0x3]
               	mov	x1, #0x5                // =5
               	sturb	w1, [x29, #-0x8]
               	mov	x1, #0x6                // =6
               	sturb	w1, [x29, #-0x3]
               	ldur	w1, [x29, #-0x7]
               	and	x1, x1, #0xffffffffc0000000
               	mov	x17, #0x32eb            // =13035
               	movk	x17, #0x38a4, lsl #16
               	orr	x1, x1, x17
               	stur	w1, [x29, #-0x7]
               	sbfx	x2, x1, #0, #30
               	mov	x17, #-0xcd15           // =-52501
               	movk	x17, #0xf8a4, lsl #16
               	cmp	w2, w17
               	b.ne	<addr>
               	and	x1, x1, #0xffffffffc0000000
               	orr	x1, x1, #0x1fffffff
               	stur	w1, [x29, #-0x7]
               	sbfx	x1, x1, #0, #30
               	mov	x17, #0x1fffffff        // =536870911
               	cmp	w1, w17
               	b.ne	<addr>
               	stur	x0, [x29, #-0x30]
               	mov	x1, #0x8                // =8
               	sturb	w1, [x29, #-0x2b]
               	ldur	x1, [x29, #-0x30]
               	and	x1, x1, #0xffffff0000000000
               	mov	x17, #0x9877            // =39031
               	movk	x17, #0xdcba, lsl #16
               	movk	x17, #0xfe, lsl #32
               	orr	x1, x1, x17
               	stur	x1, [x29, #-0x30]
               	sbfx	x1, x1, #0, #40
               	mov	x17, #-0x6789           // =-26505
               	movk	x17, #0xdcba, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x1, x17
               	b.ne	<addr>
               	ldurb	w1, [x29, #-0x2b]
               	cmp	w1, #0x8
               	b.eq	<addr>
               	mov	x0, #0x19               // =25
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurb	w1, [x29, #-0x30]
               	cmp	w1, #0x77
               	b.eq	<addr>
               	mov	x0, #0x1a               // =26
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sturb	w0, [x29, #-0x8]
               	sturb	w0, [x29, #-0x7]
               	sturb	w0, [x29, #-0x6]
               	mov	x1, #0xb                // =11
               	sturb	w1, [x29, #-0x6]
               	ldurh	w1, [x29, #-0x8]
               	and	x1, x1, #0xfffffffffffff000
               	orr	x1, x1, #0x7ff
               	sturh	w1, [x29, #-0x8]
               	sbfx	x1, x1, #0, #12
               	cmp	w1, #0x7ff
               	b.ne	<addr>
               	mov	x1, #0x12               // =18
               	sturb	w1, [x29, #-0x8]
               	ldurh	w1, [x29, #-0x8]
               	sbfx	x2, x1, #0, #12
               	cmp	w2, #0x712
               	b.ne	<addr>
               	and	x1, x1, #0xfffffffffffff000
               	orr	x1, x1, #0x800
               	sturh	w1, [x29, #-0x8]
               	sbfx	x1, x1, #0, #12
               	mov	x17, #-0x800            // =-2048
               	cmp	w1, w17
               	b.ne	<addr>
               	ldurb	w1, [x29, #-0x8]
               	cbnz	w1, <addr>
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1e               // =30
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1d               // =29
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1c               // =28
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x18               // =24
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
