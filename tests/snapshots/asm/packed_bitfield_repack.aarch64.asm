
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
               	sub	x0, x29, #0x8
               	ldrb	w1, [x0]
               	mov	x17, #0xff00            // =65280
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x17, #0x55              // =85
               	orr	x1, x1, x17
               	strb	w1, [x0]
               	mov	x3, #0x7                // =7
               	strb	w3, [x0, #0x1]
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	sxtb	x1, w1
               	cmp	x1, #0x55
               	cset	x1, ne
               	cbnz	x1, <addr>
               	mov	x1, #0x0                // =0
               	cbz	x1, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	w1, [x0]
               	mov	x17, #0xfffe0000        // =4294836224
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x17, #0xfde8            // =65000
               	orr	x1, x1, x17
               	str	w1, [x0]
               	ldrh	w1, [x0, #0x2]
               	mov	x17, #0xf801            // =63489
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x17, #0x3e8             // =1000
               	orr	x2, x1, x17
               	strh	w2, [x0, #0x2]
               	mov	x4, #0x9                // =9
               	strb	w4, [x0, #0x4]
               	ldr	w1, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x1, lsl #16
               	and	x1, x1, x17
               	lsl	x1, x1, #47
               	asr	x1, x1, #47
               	mov	x17, #0xfde8            // =65000
               	cmp	x1, x17
               	mov	x1, #0x1                // =1
               	b.ne	<addr>
               	mov	x17, #0xffff            // =65535
               	and	x2, x2, x17
               	asr	x2, x2, #1
               	mov	x17, #0x3ff             // =1023
               	and	x2, x2, x17
               	lsl	x2, x2, #54
               	asr	x2, x2, #54
               	cmp	x2, #0x1f4
               	cset	x2, ne
               	cbnz	x2, <addr>
               	mov	x2, #0x0                // =0
               	cbz	x2, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w2, [x0]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x2, x2, x17
               	mov	x17, #0x3               // =3
               	orr	x2, x2, x17
               	strb	w2, [x0]
               	ldrh	w2, [x0]
               	mov	x17, #0xfc07            // =64519
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x2, x2, x17
               	mov	x17, #0x1e0             // =480
               	orr	x2, x2, x17
               	strh	w2, [x0]
               	mov	x5, #0x4                // =4
               	strb	w5, [x0, #0x2]
               	ldrb	w5, [x0]
               	mov	x17, #0x7               // =7
               	and	x5, x5, x17
               	cmp	x5, #0x3
               	b.ne	<addr>
               	mov	x17, #0xffff            // =65535
               	and	x1, x2, x17
               	asr	x1, x1, #3
               	mov	x17, #0x7f              // =127
               	and	x1, x1, x17
               	cmp	x1, #0x3c
               	cset	x1, ne
               	cbnz	x1, <addr>
               	mov	x1, #0x0                // =0
               	cbz	x1, <addr>
               	mov	x0, x3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0xb                // =11
               	strb	w1, [x0]
               	add	x1, x0, #0x1
               	ldrh	w2, [x1]
               	mov	x17, #0xffff0000        // =4294901760
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x2, x2, x17
               	mov	x17, #0x7530            // =30000
               	orr	x2, x2, x17
               	strh	w2, [x1]
               	mov	x17, #0xffff            // =65535
               	and	x1, x2, x17
               	sxth	x1, w1
               	mov	x17, #0x7530            // =30000
               	cmp	x1, x17
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w1, [x1]
               	sxtb	x1, w1
               	cmp	x1, #0x55
               	cset	x1, ne
               	cbnz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w1, [x1, #0x1]
               	mov	x17, #0x7               // =7
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, x4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x6                // =6
               	strb	w1, [x0]
               	ldr	w1, [x0]
               	mov	x17, #0xff              // =255
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x17, #0xef00            // =61184
               	movk	x17, #0xabcd, lsl #16
               	orr	x1, x1, x17
               	str	w1, [x0]
               	ldrb	w0, [x0]
               	mov	x17, #0x6               // =6
               	eor	x0, x0, x17
               	mov	w2, w0
               	cmp	x2, #0x0
               	cset	x0, ne
               	cbnz	x2, <addr>
               	mov	w0, w1
               	asr	x0, x0, #8
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xff, lsl #16
               	and	x0, x0, x17
               	mov	x17, #0xcdef            // =52719
               	movk	x17, #0xab, lsl #16
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	b	<addr>
