
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
               	sub	x1, x29, #0x8
               	ldrb	w0, [x1]
               	and	x0, x0, #0xffffffffffffff00
               	mov	x17, #0x55              // =85
               	orr	x0, x0, x17
               	strb	w0, [x1]
               	and	x0, x0, #0xff
               	sxtb	x0, w0
               	cmp	w0, #0x55
               	b.ne	<addr>
               	ldr	w0, [x1]
               	and	x0, x0, #0xfffffffffffe0000
               	mov	x17, #0xfde8            // =65000
               	orr	x0, x0, x17
               	str	w0, [x1]
               	ldrh	w0, [x1, #0x2]
               	and	x0, x0, #0xfffffffffffff801
               	mov	x17, #0x3e8             // =1000
               	orr	x2, x0, x17
               	strh	w2, [x1, #0x2]
               	mov	x0, #0x9                // =9
               	strb	w0, [x1, #0x4]
               	ldr	w3, [x1]
               	and	x3, x3, #0x1ffff
               	lsl	x3, x3, #47
               	asr	x3, x3, #47
               	mov	x17, #0xfde8            // =65000
               	cmp	w3, w17
               	b.ne	<addr>
               	and	x2, x2, #0xffff
               	asr	x2, x2, #1
               	and	x2, x2, #0x3ff
               	lsl	x2, x2, #54
               	asr	x2, x2, #54
               	cmp	w2, #0x1f4
               	b.ne	<addr>
               	ldrb	w2, [x1]
               	and	x2, x2, #0xfffffffffffffff8
               	orr	x2, x2, #0x3
               	strb	w2, [x1]
               	ldrh	w2, [x1]
               	and	x2, x2, #0xfffffffffffffc07
               	orr	x2, x2, #0x1e0
               	strh	w2, [x1]
               	mov	x3, #0x4                // =4
               	strb	w3, [x1, #0x2]
               	ldrb	w3, [x1]
               	and	x3, x3, #0x7
               	cmp	w3, #0x3
               	b.ne	<addr>
               	and	x2, x2, #0xffff
               	asr	x2, x2, #3
               	and	x2, x2, #0x7f
               	cmp	w2, #0x3c
               	b.ne	<addr>
               	ldurh	w2, [x1, #0x1]
               	and	x2, x2, #0xffffffffffff0000
               	mov	x17, #0x7530            // =30000
               	orr	x2, x2, x17
               	sturh	w2, [x1, #0x1]
               	and	x2, x2, #0xffff
               	sxth	x2, w2
               	mov	x17, #0x7530            // =30000
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrb	w3, [x2]
               	sxtb	x3, w3
               	cmp	w3, #0x55
               	b.ne	<addr>
               	ldrb	w2, [x2, #0x1]
               	eor	x2, x2, #0x7
               	cbz	w2, <addr>
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x6                // =6
               	strb	w0, [x1]
               	ldr	w0, [x1]
               	and	x0, x0, #0xffffffff000000ff
               	mov	x17, #0xef00            // =61184
               	movk	x17, #0xabcd, lsl #16
               	orr	x0, x0, x17
               	str	w0, [x1]
               	ldrb	w1, [x1]
               	eor	x1, x1, #0x6
               	cbnz	w1, <addr>
               	mov	w0, w0
               	asr	x0, x0, #8
               	mov	x17, #0xcdef            // =52719
               	movk	x17, #0xab, lsl #16
               	eor	x0, x0, x17
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
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
