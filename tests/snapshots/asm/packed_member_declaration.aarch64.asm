
packed_member_declaration.aarch64:	file format elf64-littleaarch64

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
               	sub	x1, x29, #0x8
               	sturb	wzr, [x29, #-0x8]
               	sturb	wzr, [x29, #-0x7]
               	sturb	wzr, [x29, #-0x6]
               	sturb	wzr, [x29, #-0x5]
               	sturb	wzr, [x29, #-0x4]
               	sturb	wzr, [x29, #-0x3]
               	mov	x2, #0x1                // =1
               	sturb	w2, [x29, #-0x8]
               	mov	x2, #0x2                // =2
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
               	mov	x2, #0x3                // =3
               	sturb	w2, [x29, #-0x8]
               	ldur	w2, [x29, #-0x8]
               	and	x2, x2, #0xfffffffff00000ff
               	mov	x17, #0x100             // =256
               	movk	x17, #0x800, lsl #16
               	orr	x2, x2, x17
               	stur	w2, [x29, #-0x8]
               	ldur	w2, [x1, #0x3]
               	and	x2, x2, #0xffffffffff00000f
               	orr	x2, x2, #0x7ffff0
               	stur	w2, [x1, #0x3]
               	mov	x2, #0x4                // =4
               	sturb	w2, [x29, #-0x2]
               	ldurb	w2, [x29, #-0x8]
               	cmp	w2, #0x3
               	b.ne	<addr>
               	ldur	w2, [x29, #-0x8]
               	sbfx	x2, x2, #8, #20
               	mov	x17, #-0x7ffff          // =-524287
               	cmp	w2, w17
               	b.ne	<addr>
               	ldur	w2, [x1, #0x3]
               	sbfx	x2, x2, #4, #20
               	mov	x17, #0x7ffff           // =524287
               	cmp	w2, w17
               	b.ne	<addr>
               	ldur	w2, [x1, #0x3]
               	and	x2, x2, #0xffffffffff00000f
               	orr	x2, x2, #0xfffff0
               	stur	w2, [x1, #0x3]
               	ldur	w1, [x29, #-0x8]
               	sbfx	x1, x1, #8, #20
               	mov	x17, #-0x7ffff          // =-524287
               	cmp	w1, w17
               	b.ne	<addr>
               	mov	w1, w2
               	sbfx	x1, x1, #4, #20
               	mov	x17, #-0x1              // =-1
               	cmp	w1, w17
               	b.ne	<addr>
               	ldurb	w1, [x29, #-0x2]
               	cmp	w1, #0x4
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sturb	wzr, [x29, #-0x8]
               	sturb	wzr, [x29, #-0x7]
               	sturb	wzr, [x29, #-0x6]
               	sturb	wzr, [x29, #-0x5]
               	sturb	wzr, [x29, #-0x4]
               	sturb	wzr, [x29, #-0x3]
               	sturb	wzr, [x29, #-0x2]
               	mov	x0, #0x5                // =5
               	sturb	w0, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	mov	x1, #0x6                // =6
               	sturb	w1, [x29, #-0x2]
               	ldur	w1, [x0, #0x1]
               	and	x1, x1, #0xffffff0000000000
               	orr	x1, x1, #0x7fffffffff
               	stur	w1, [x0, #0x1]
               	lsr	x1, x1, #32
               	sturb	w1, [x29, #-0x3]
               	and	x1, x1, #0xff
               	lsl	x1, x1, #32
               	orr	x1, x1, #0xffffffff
               	sbfx	x2, x1, #0, #40
               	mov	x17, #0x7fffffffff      // =549755813887
               	cmp	x2, x17
               	b.ne	<addr>
               	and	x1, x1, #0xffffff0000000000
               	mov	x17, #0x9877            // =39031
               	movk	x17, #0xdcba, lsl #16
               	movk	x17, #0xfe, lsl #32
               	orr	x1, x1, x17
               	stur	w1, [x0, #0x1]
               	lsr	x0, x1, #32
               	sturb	w0, [x29, #-0x3]
               	mov	w1, w1
               	and	x0, x0, #0xff
               	orr	x0, x1, x0, lsl #32
               	sbfx	x0, x0, #0, #40
               	mov	x17, #-0x6789           // =-26505
               	movk	x17, #0xdcba, lsl #16
               	movk	x17, #0xfffe, lsl #32
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x19               // =25
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x18               // =24
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
