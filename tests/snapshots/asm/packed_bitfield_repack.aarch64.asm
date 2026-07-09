
packed_bitfield_repack.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
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
               	sub	x0, x29, #0x8
               	mov	x1, #0x7                // =7
               	strb	w1, [x0, #0x1]
               	sub	x0, x29, #0x8
               	ldrb	w0, [x0]
               	sxtb	x0, w0
               	cmp	x0, #0x55
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x8
               	ldrb	w0, [x0, #0x1]
               	mov	x17, #0x7               // =7
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	w1, [x0]
               	mov	x17, #0xfffe0000        // =4294836224
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x17, #0xfde8            // =65000
               	orr	x1, x1, x17
               	str	w1, [x0]
               	sub	x0, x29, #0x10
               	ldrh	w1, [x0, #0x2]
               	mov	x17, #0xf801            // =63489
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x17, #0x3e8             // =1000
               	orr	x1, x1, x17
               	strh	w1, [x0, #0x2]
               	sub	x0, x29, #0x10
               	mov	x1, #0x9                // =9
               	strb	w1, [x0, #0x4]
               	sub	x0, x29, #0x10
               	ldr	w0, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x1, lsl #16
               	and	x0, x0, x17
               	lsl	x0, x0, #47
               	asr	x0, x0, #47
               	mov	x17, #0xfde8            // =65000
               	cmp	x0, x17
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x10
               	ldrh	w0, [x0, #0x2]
               	asr	x0, x0, #1
               	mov	x17, #0x3ff             // =1023
               	and	x0, x0, x17
               	lsl	x0, x0, #54
               	asr	x0, x0, #54
               	cmp	x0, #0x1f4
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x10
               	ldrb	w0, [x0, #0x4]
               	mov	x17, #0x9               // =9
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	ldrb	w1, [x0]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x17, #0x3               // =3
               	orr	x1, x1, x17
               	strb	w1, [x0]
               	sub	x0, x29, #0x18
               	ldrh	w1, [x0]
               	mov	x17, #0xfc07            // =64519
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x17, #0x1e0             // =480
               	orr	x1, x1, x17
               	strh	w1, [x0]
               	sub	x0, x29, #0x18
               	mov	x1, #0x4                // =4
               	strb	w1, [x0, #0x2]
               	sub	x0, x29, #0x18
               	ldrb	w0, [x0]
               	mov	x17, #0x7               // =7
               	and	x0, x0, x17
               	cmp	x0, #0x3
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x18
               	ldrh	w0, [x0]
               	asr	x0, x0, #3
               	mov	x17, #0x7f              // =127
               	and	x0, x0, x17
               	cmp	x0, #0x3c
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x18
               	ldrb	w0, [x0, #0x2]
               	mov	x17, #0x4               // =4
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	mov	x1, #0xb                // =11
               	strb	w1, [x0]
               	sub	x0, x29, #0x20
               	add	x0, x0, #0x1
               	ldrh	w1, [x0]
               	mov	x17, #0xffff0000        // =4294901760
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x17, #0x7530            // =30000
               	orr	x1, x1, x17
               	strh	w1, [x0]
               	sub	x0, x29, #0x20
               	ldrb	w0, [x0]
               	mov	x17, #0xb               // =11
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x20
               	add	x0, x0, #0x1
               	ldrh	w0, [x0]
               	sxth	x0, w0
               	mov	x17, #0x7530            // =30000
               	cmp	x0, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0]
               	sxtb	x0, w0
               	cmp	x0, #0x55
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0, #0x1]
               	mov	x17, #0x7               // =7
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
