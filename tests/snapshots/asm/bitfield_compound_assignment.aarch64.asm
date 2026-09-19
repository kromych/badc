
bitfield_compound_assignment.aarch64:	file format elf64-littleaarch64

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
               	ldurh	w1, [x29, #-0x8]
               	and	x1, x1, #0xfffffffffffffffe
               	sturh	w1, [x29, #-0x8]
               	and	x1, x1, #0xffff
               	and	x1, x1, #0xfffffffffffffff1
               	sturh	w1, [x29, #-0x8]
               	and	x1, x1, #0xffff
               	and	x1, x1, #0xffffffffffffff0f
               	sturh	w1, [x29, #-0x8]
               	and	x1, x1, #0xffff
               	and	x1, x1, #0xffffffffffff00ff
               	sturh	w1, [x29, #-0x8]
               	and	x0, x1, #0xffff
               	asr	x2, x0, #1
               	and	x2, x2, #0x7
               	mov	x17, #0x5               // =5
               	orr	x2, x2, x17
               	and	x0, x0, #0xfffffffffffffff1
               	lsl	x1, x2, #1
               	orr	x0, x0, x1
               	sturh	w0, [x29, #-0x8]
               	and	x1, x0, #0xffff
               	asr	x2, x1, #1
               	and	x2, x2, #0x7
               	cmp	w2, #0x5
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	and	x0, x1, #0xfffffffffffffff1
               	orr	x0, x0, #0xe
               	sturh	w0, [x29, #-0x8]
               	and	x1, x0, #0xffff
               	asr	x2, x1, #1
               	and	x3, x2, #0x7
               	cmp	w3, #0x7
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	and	x2, x2, #0x6
               	and	x0, x1, #0xfffffffffffffff1
               	lsl	x1, x2, #1
               	orr	x0, x0, x1
               	sturh	w0, [x29, #-0x8]
               	and	x1, x0, #0xffff
               	asr	x2, x1, #1
               	and	x2, x2, #0x7
               	cmp	w2, #0x6
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	and	x0, x1, #0xfffffffffffffff1
               	orr	x0, x0, #0x2
               	sturh	w0, [x29, #-0x8]
               	and	x1, x0, #0xffff
               	asr	x2, x1, #1
               	and	x2, x2, #0x7
               	cmp	w2, #0x1
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	and	x0, x1, #0xfffffffffffffffe
               	orr	x0, x0, #0x1
               	sturh	w0, [x29, #-0x8]
               	and	x0, x0, #0xffff
               	and	x0, x0, #0xffffffffffffff0f
               	orr	x0, x0, #0xc0
               	sturh	w0, [x29, #-0x8]
               	and	x0, x0, #0xffff
               	and	x0, x0, #0xffffffffffff00ff
               	mov	x17, #0xc800            // =51200
               	orr	x0, x0, x17
               	sturh	w0, [x29, #-0x8]
               	and	x1, x0, #0xffff
               	asr	x2, x1, #1
               	and	x2, x2, #0x7
               	eor	x2, x2, #0x7
               	and	x0, x1, #0xfffffffffffffff1
               	lsl	x1, x2, #1
               	orr	x0, x0, x1
               	sturh	w0, [x29, #-0x8]
               	and	x1, x0, #0xffff
               	and	x2, x1, #0x1
               	cmp	w2, #0x1
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	asr	x2, x1, #1
               	and	x2, x2, #0x7
               	cmp	w2, #0x6
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	asr	x2, x1, #4
               	and	x2, x2, #0xf
               	cmp	w2, #0xc
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	asr	x2, x1, #8
               	cmp	w2, #0xc8
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	and	x0, x1, #0xffffffffffffff0f
               	mov	x17, #0xd0              // =208
               	orr	x0, x0, x17
               	sturh	w0, [x29, #-0x8]
               	and	x1, x0, #0xffff
               	asr	x2, x1, #4
               	and	x2, x2, #0xf
               	cmp	w2, #0xd
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	and	x0, x1, #0xffffffffffffff0f
               	mov	x17, #0x90              // =144
               	orr	x0, x0, x17
               	sturh	w0, [x29, #-0x8]
               	and	x1, x0, #0xffff
               	asr	x2, x1, #4
               	and	x2, x2, #0xf
               	cmp	w2, #0x9
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	asr	x2, x1, #8
               	lsl	x2, x2, #1
               	and	x2, x2, #0xff
               	and	x0, x1, #0xffffffffffff00ff
               	lsl	x1, x2, #8
               	orr	x0, x0, x1
               	sturh	w0, [x29, #-0x8]
               	and	x1, x0, #0xffff
               	asr	x2, x1, #8
               	mov	x17, #0x90              // =144
               	eor	x2, x2, x17
               	cbz	w2, <addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	asr	x2, x1, #4
               	and	x2, x2, #0xf
               	asr	x2, x2, #2
               	and	x0, x1, #0xffffffffffffff0f
               	lsl	x1, x2, #4
               	orr	x0, x0, x1
               	sturh	w0, [x29, #-0x8]
               	and	x0, x0, #0xffff
               	asr	x0, x0, #4
               	and	x0, x0, #0xf
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
