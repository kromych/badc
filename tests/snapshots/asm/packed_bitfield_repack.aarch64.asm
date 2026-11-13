
packed_bitfield_repack.aarch64:	file format elf64-littleaarch64

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
               	ldur	w0, [x29, #-0x8]
               	and	x0, x0, #0xfffffffffffe0000
               	mov	x17, #0xfde8            // =65000
               	orr	x0, x0, x17
               	stur	w0, [x29, #-0x8]
               	ldurh	w0, [x29, #-0x6]
               	and	x0, x0, #0xfffffffffffff801
               	mov	x17, #0x3e8             // =1000
               	orr	x1, x0, x17
               	sturh	w1, [x29, #-0x6]
               	mov	x0, #0x9                // =9
               	sturb	w0, [x29, #-0x4]
               	ldur	w2, [x29, #-0x8]
               	sbfx	x2, x2, #0, #17
               	mov	x17, #0xfde8            // =65000
               	cmp	w2, w17
               	b.ne	<addr>
               	sbfx	x1, x1, #1, #10
               	cmp	w1, #0x1f4
               	b.ne	<addr>
               	ldurb	w1, [x29, #-0x8]
               	and	x1, x1, #0xfffffffffffffff8
               	orr	x1, x1, #0x3
               	sturb	w1, [x29, #-0x8]
               	ldurh	w1, [x29, #-0x8]
               	and	x1, x1, #0xfffffffffffffc07
               	orr	x1, x1, #0x1e0
               	sturh	w1, [x29, #-0x8]
               	mov	x2, #0x4                // =4
               	sturb	w2, [x29, #-0x6]
               	ldurb	w2, [x29, #-0x8]
               	and	x2, x2, #0x7
               	cmp	w2, #0x3
               	b.ne	<addr>
               	ubfx	x1, x1, #3, #7
               	cmp	w1, #0x3c
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w2, [x1]
               	sxtb	x2, w2
               	cmp	w2, #0x55
               	b.ne	<addr>
               	ldrb	w1, [x1, #0x1]
               	cmp	w1, #0x7
               	b.eq	<addr>
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x6                // =6
               	sturb	w0, [x29, #-0x8]
               	ldur	w0, [x29, #-0x8]
               	and	x0, x0, #0xffffffff000000ff
               	mov	x17, #0xef00            // =61184
               	movk	x17, #0xabcd, lsl #16
               	orr	x0, x0, x17
               	stur	w0, [x29, #-0x8]
               	ldurb	w1, [x29, #-0x8]
               	cmp	w1, #0x6
               	b.ne	<addr>
               	mov	x1, #0xcdef             // =52719
               	movk	x1, #0xab, lsl #16
               	eor	x0, x1, x0, asr #8
               	cbz	w0, <addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
