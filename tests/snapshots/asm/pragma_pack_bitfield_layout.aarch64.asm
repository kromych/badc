
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

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x90
               	sub	x0, x29, #0x90
               	stur	xzr, [x29, #-0x90]
               	ldur	w1, [x29, #-0x90]
               	and	x1, x1, #0xffffffffc0000000
               	orr	x1, x1, #0x3fffffff
               	stur	w1, [x29, #-0x90]
               	ldur	x1, [x29, #-0x90]
               	and	x1, x1, #0xf00000003fffffff
               	mov	x17, #0x80000000        // =2147483648
               	movk	x17, #0xaaaa, lsl #32
               	movk	x17, #0xaaa, lsl #48
               	orr	x1, x1, x17
               	stur	x1, [x29, #-0x90]
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	mov	x2, #0x8                // =8
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldur	w0, [x29, #-0x90]
               	sbfx	x0, x0, #0, #30
               	cmn	w0, #0x1
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x90]
               	sbfx	x0, x0, #30, #30
               	mov	x17, #-0x5556           // =-21846
               	movk	x17, #0xeaaa, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x88
               	sturb	wzr, [x29, #-0x88]
               	mov	x2, #0x1                // =1
               	sturb	wzr, [x29, #-0x84]
               	stur	w2, [x29, #-0x88]
               	ldurh	w1, [x29, #-0x87]
               	and	x1, x1, #0xffffffffffff8000
               	orr	x1, x1, #0x7ffe
               	sturh	w1, [x29, #-0x87]
               	mov	x1, #0x1234             // =4660
               	sturh	w1, [x29, #-0x85]
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	mov	x2, #0x5                // =5
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldurb	w0, [x29, #-0x88]
               	cmp	w0, #0x1
               	b.ne	<addr>
               	ldurh	w0, [x29, #-0x87]
               	sbfx	x0, x0, #0, #15
               	cmn	w0, #0x2
               	b.ne	<addr>
               	ldursh	x0, [x29, #-0x85]
               	mov	x17, #0x1234            // =4660
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x70
               	sturb	wzr, [x29, #-0x70]
               	mov	x1, #0x1                // =1
               	sturh	wzr, [x29, #-0x68]
               	stur	x1, [x29, #-0x70]
               	ldur	x1, [x29, #-0x6f]
               	and	x1, x1, #0xf000000000000000
               	orr	x1, x1, #0xffffffffffffff
               	stur	x1, [x29, #-0x6f]
               	mov	x1, #0x2                // =2
               	sturb	w1, [x29, #-0x67]
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	mov	x2, #0xa                // =10
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldur	x0, [x29, #-0x6f]
               	sbfx	x0, x0, #0, #60
               	mov	x17, #0xffffffffffffff  // =72057594037927935
               	cmp	x0, x17
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x67]
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	mov	x2, #0xf                // =15
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w1, [x0]
               	and	x1, x1, #0x3fffff
               	cmp	w1, #0x79a
               	b.ne	<addr>
               	ldur	w1, [x0, #0x2]
               	sbfx	x1, x1, #6, #23
               	cmn	w1, #0x771
               	b.ne	<addr>
               	ldur	w1, [x0, #0x5]
               	ubfx	x1, x1, #5, #26
               	mov	x17, #0x13de            // =5086
               	cmp	w1, w17
               	b.ne	<addr>
               	ldrh	w1, [x0, #0x8]
               	sbfx	x1, x1, #7, #5
               	cmp	w1, #0x4
               	b.ne	<addr>
               	ldur	w1, [x0, #0x9]
               	sbfx	x1, x1, #4, #20
               	cmp	w1, #0x16a
               	b.ne	<addr>
               	ldur	w0, [x0, #0xb]
               	ubfx	x0, x0, #8, #20
               	cmp	w0, #0x141
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x60
               	stur	xzr, [x29, #-0x60]
               	stur	wzr, [x29, #-0x58]
               	sturh	wzr, [x29, #-0x54]
               	sturb	wzr, [x29, #-0x52]
               	ldur	w1, [x29, #-0x60]
               	and	x1, x1, #0xffffffffffc00000
               	mov	x17, #0x79a             // =1946
               	orr	x1, x1, x17
               	stur	w1, [x29, #-0x60]
               	ldur	w1, [x29, #-0x5e]
               	and	x1, x1, #0xffffffffe000003f
               	mov	x17, #0x23c0            // =9152
               	movk	x17, #0x1ffe, lsl #16
               	orr	x1, x1, x17
               	stur	w1, [x29, #-0x5e]
               	ldur	w1, [x29, #-0x5b]
               	and	x1, x1, #0xffffffff8000001f
               	mov	x17, #0x7bc0            // =31680
               	movk	x17, #0x2, lsl #16
               	orr	x1, x1, x17
               	stur	w1, [x29, #-0x5b]
               	ldurh	w1, [x29, #-0x58]
               	and	x1, x1, #0xfffffffffffff07f
               	orr	x1, x1, #0x200
               	sturh	w1, [x29, #-0x58]
               	ldur	w1, [x29, #-0x57]
               	and	x1, x1, #0xffffffffff00000f
               	mov	x17, #0x16a0            // =5792
               	orr	x1, x1, x17
               	stur	w1, [x29, #-0x57]
               	ldur	w1, [x29, #-0x55]
               	and	x1, x1, #0xfffffffff00000ff
               	mov	x17, #0x4100            // =16640
               	movk	x17, #0x1, lsl #16
               	orr	x1, x1, x17
               	stur	w1, [x29, #-0x55]
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	mov	x2, #0xf                // =15
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x50
               	mov	x2, #0x1                // =1
               	sturh	wzr, [x29, #-0x48]
               	stur	x2, [x29, #-0x50]
               	ldur	w1, [x29, #-0x4f]
               	and	x1, x1, #0xffffffffc0000000
               	orr	x1, x1, #0x3fffffff
               	stur	w1, [x29, #-0x4f]
               	ldur	x1, [x29, #-0x4e]
               	and	x1, x1, #0xfff00000003fffff
               	mov	x17, #0xaa800000        // =2860515328
               	movk	x17, #0xaaaa, lsl #32
               	movk	x17, #0xa, lsl #48
               	orr	x1, x1, x17
               	stur	x1, [x29, #-0x4e]
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	mov	x2, #0xa                // =10
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	mov	x2, #0xa                // =10
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldur	w0, [x29, #-0x4f]
               	sbfx	x0, x0, #0, #30
               	cmn	w0, #0x1
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldur	x0, [x0, #0x2]
               	sbfx	x0, x0, #22, #30
               	mov	x17, #-0x5556           // =-21846
               	movk	x17, #0xeaaa, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x80
               	mov	x1, #0x1                // =1
               	stur	w1, [x29, #-0x80]
               	ldurh	w1, [x29, #-0x7f]
               	and	x1, x1, #0xffffffffffff8000
               	orr	x1, x1, #0x7ffe
               	sturh	w1, [x29, #-0x7f]
               	mov	x1, #0x3                // =3
               	sturb	w1, [x29, #-0x7d]
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldurh	w0, [x29, #-0x7f]
               	sbfx	x0, x0, #0, #15
               	cmn	w0, #0x2
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x7d]
               	cmp	w0, #0x3
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x40
               	mov	x2, #0x1                // =1
               	stur	wzr, [x29, #-0x38]
               	stur	x2, [x29, #-0x40]
               	ldur	x1, [x29, #-0x3f]
               	and	x1, x1, #0xf000000000000000
               	orr	x1, x1, #0xffffffffffffff
               	stur	x1, [x29, #-0x3f]
               	mov	x1, #0x2                // =2
               	sturb	w1, [x29, #-0x37]
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	mov	x2, #0xc                // =12
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldur	x0, [x29, #-0x3f]
               	sbfx	x0, x0, #0, #60
               	mov	x17, #0xffffffffffffff  // =72057594037927935
               	cmp	x0, x17
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x37]
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x30
               	mov	x2, #0x1                // =1
               	stur	wzr, [x29, #-0x28]
               	mov	x3, #0x1                // =1
               	stur	wzr, [x29, #-0x18]
               	stur	wzr, [x29, #-0xc]
               	stur	wzr, [x29, #-0x8]
               	mov	x4, #0x1                // =1
               	movk	x4, #0xffff, lsl #32
               	movk	x4, #0x3fff, lsl #48
               	stur	x3, [x29, #-0x20]
               	stur	x2, [x29, #-0x30]
               	mov	x1, #0x3fffffff         // =1073741823
               	stur	x4, [x29, #-0x10]
               	ldur	w2, [x29, #-0x1f]
               	and	x2, x2, #0xffffffffc0000000
               	orr	x2, x2, x1
               	stur	w2, [x29, #-0x1f]
               	ldur	w2, [x29, #-0x2f]
               	and	x2, x2, #0xffffffffc0000000
               	orr	x1, x2, x1
               	stur	w1, [x29, #-0x2f]
               	mov	x1, #0xaaaa             // =43690
               	movk	x1, #0x2aaa, lsl #16
               	stur	w1, [x29, #-0x8]
               	ldur	x1, [x29, #-0x1c]
               	and	x2, x1, #0xfffffff00000003f
               	mov	x1, #0xaa80             // =43648
               	movk	x1, #0xaaaa, lsl #16
               	movk	x1, #0xa, lsl #32
               	orr	x2, x2, x1
               	stur	x2, [x29, #-0x1c]
               	ldur	x2, [x29, #-0x2c]
               	and	x2, x2, #0xfffffff00000003f
               	orr	x1, x2, x1
               	stur	x1, [x29, #-0x2c]
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	mov	x2, #0xc                // =12
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x20
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	mov	x2, #0xc                // =12
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x10
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	mov	x2, #0xc                // =12
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w0, [x29, #-0x2f]
               	sbfx	x0, x0, #0, #30
               	cmn	w0, #0x1
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x1c]
               	sbfx	x0, x0, #6, #30
               	mov	x17, #-0x5556           // =-21846
               	movk	x17, #0xeaaa, lsl #16
               	cmp	w0, w17
               	b.ne	<addr>
               	ldur	w0, [x29, #-0xc]
               	sbfx	x0, x0, #0, #30
               	cmn	w0, #0x1
               	b.ne	<addr>
               	ldur	w0, [x29, #-0x8]
               	sbfx	x0, x0, #0, #30
               	mov	x17, #-0x5556           // =-21846
               	movk	x17, #0xeaaa, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrh	w0, [x0]
               	sbfx	x0, x0, #0, #15
               	cmp	w0, #0x6a
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrh	w1, [x0]
               	sbfx	x1, x1, #0, #15
               	cmn	w1, #0x1
               	b.ne	<addr>
               	ldrh	w0, [x0, #0x2]
               	sbfx	x0, x0, #0, #15
               	cmp	w0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrh	w1, [x0]
               	ldrb	w0, [x0, #0x2]
               	orr	x0, x1, x0, lsl #16
               	sbfx	x0, x0, #0, #22
               	mov	x17, #-0x4240           // =-16960
               	movk	x17, #0xfff0, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrh	w0, [x0]
               	sbfx	x0, x0, #0, #15
               	cmn	w0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	mov	x2, #0x2                // =2
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrh	w0, [x0]
               	sbfx	x0, x0, #0, #15
               	cmn	w0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x78
               	sturh	wzr, [x29, #-0x78]
               	mov	x1, #0x7ffd             // =32765
               	sturh	w1, [x29, #-0x78]
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	mov	x2, #0x2                // =2
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldurh	w0, [x29, #-0x78]
               	sbfx	x0, x0, #0, #15
               	cmn	w0, #0x3
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x78]
               	cmp	w0, #0xfd
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
