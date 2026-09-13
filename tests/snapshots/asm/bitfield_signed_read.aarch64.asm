
bitfield_signed_read.aarch64:	file format elf64-littleaarch64

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
               	ldurh	w0, [x29, #-0x8]
               	and	x0, x0, #0xfffffffffffffffc
               	orr	x0, x0, #0x3
               	sturh	w0, [x29, #-0x8]
               	and	x0, x0, #0xffff
               	and	x0, x0, #0xfffffffffffffff3
               	orr	x0, x0, #0x4
               	sturh	w0, [x29, #-0x8]
               	and	x0, x0, #0xffff
               	and	x0, x0, #0xffffffffffff000f
               	orr	x0, x0, #0x8000
               	sturh	w0, [x29, #-0x8]
               	and	x1, x0, #0xffff
               	and	x2, x1, #0x3
               	lsl	x2, x2, #62
               	asr	x2, x2, #62
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	asr	x2, x1, #2
               	and	x2, x2, #0x3
               	lsl	x2, x2, #62
               	asr	x2, x2, #62
               	cmp	x2, #0x1
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	asr	x1, x1, #4
               	lsl	x1, x1, #52
               	asr	x1, x1, #52
               	mov	x17, #0xf800            // =63488
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w0, [x29, #-0x8]
               	and	x0, x0, #0xfffffffffffffff8
               	orr	x0, x0, #0x4
               	stur	w0, [x29, #-0x8]
               	mov	w0, w0
               	and	x0, x0, #0xfffffffffffff807
               	orr	x0, x0, #0x400
               	stur	w0, [x29, #-0x8]
               	mov	w0, w0
               	and	x0, x0, #0xffffffff000007ff
               	orr	x0, x0, #0xfffff800
               	stur	w0, [x29, #-0x8]
               	mov	w1, w0
               	and	x2, x1, #0x7
               	lsl	x2, x2, #61
               	asr	x2, x2, #61
               	mov	x17, #0xfffc            // =65532
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	asr	x2, x1, #3
               	and	x2, x2, #0xff
               	sxtb	x2, w2
               	mov	x17, #0xff80            // =65408
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	asr	x1, x1, #11
               	lsl	x1, x1, #43
               	asr	x1, x1, #43
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	ldr	w1, [x0]
               	and	x1, x1, #0xfffffffffffff000
               	orr	x1, x1, #0x7
               	str	w1, [x0]
               	ldrh	w1, [x0]
               	and	x1, x1, #0xffffffffffffcfff
               	orr	x1, x1, #0x3000
               	strh	w1, [x0]
               	and	x1, x1, #0xffff
               	and	x1, x1, #0xffffffffffff3fff
               	orr	x1, x1, #0x4000
               	strh	w1, [x0]
               	ldr	w0, [x0]
               	and	x0, x0, #0xfff
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1f               // =31
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	and	x0, x1, #0xffff
               	asr	x2, x0, #12
               	and	x2, x2, #0x3
               	lsl	x2, x2, #62
               	asr	x2, x2, #62
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x20               // =32
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	asr	x0, x0, #14
               	lsl	x0, x0, #62
               	asr	x0, x0, #62
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x21               // =33
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
