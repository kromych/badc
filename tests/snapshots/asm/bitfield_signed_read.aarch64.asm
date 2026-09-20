
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
               	and	x0, x0, #0xffff
               	and	x1, x0, #0x3
               	lsl	x1, x1, #62
               	asr	x1, x1, #62
               	mov	x17, #-0x1              // =-1
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	asr	x1, x0, #2
               	and	x1, x1, #0x3
               	lsl	x1, x1, #62
               	asr	x1, x1, #62
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	asr	x0, x0, #4
               	lsl	x0, x0, #52
               	asr	x0, x0, #52
               	mov	x17, #-0x800            // =-2048
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w0, [x29, #-0x8]
               	and	x0, x0, #0xfffffffffffffff8
               	orr	x0, x0, #0x4
               	stur	w0, [x29, #-0x8]
               	and	x0, x0, #0xfffffffffffff807
               	orr	x0, x0, #0x400
               	stur	w0, [x29, #-0x8]
               	and	x0, x0, #0xffffffff000007ff
               	orr	x0, x0, #0xfffff800
               	stur	w0, [x29, #-0x8]
               	and	x1, x0, #0x7
               	lsl	x1, x1, #61
               	asr	x1, x1, #61
               	mov	x17, #-0x4              // =-4
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	w0, w0
               	asr	x1, x0, #3
               	and	x1, x1, #0xff
               	sxtb	x1, w1
               	mov	x17, #-0x80             // =-128
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	asr	x0, x0, #11
               	lsl	x0, x0, #43
               	asr	x0, x0, #43
               	mov	x17, #-0x1              // =-1
               	cmp	w0, w17
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
               	asr	x1, x0, #12
               	and	x1, x1, #0x3
               	lsl	x1, x1, #62
               	asr	x1, x1, #62
               	mov	x17, #-0x1              // =-1
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0x20               // =32
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	asr	x0, x0, #14
               	lsl	x0, x0, #62
               	asr	x0, x0, #62
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x21               // =33
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
