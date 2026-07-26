
bitfield_incdec.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x1]
               	strb	w10, [x0]
               	ldrb	w10, [x1, #0x1]
               	strb	w10, [x0, #0x1]
               	ldrb	w10, [x1, #0x2]
               	strb	w10, [x0, #0x2]
               	ldrb	w10, [x1, #0x3]
               	strb	w10, [x0, #0x3]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0x10
               	ldr	w0, [x1]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x7fff, lsl #16
               	and	x2, x0, x17
               	add	x3, x2, #0x1
               	mov	x17, #0x80000000        // =2147483648
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x7fff, lsl #16
               	and	x3, x3, x17
               	orr	x0, x0, x3
               	str	w0, [x1]
               	sxtw	x1, w2
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	mov	w1, w0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x7fff, lsl #16
               	and	x1, x1, x17
               	cmp	x1, #0x1
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x10
               	mov	w2, w0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x7fff, lsl #16
               	and	x2, x2, x17
               	add	x2, x2, #0x1
               	mov	w0, w0
               	mov	x17, #0x80000000        // =2147483648
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x7fff, lsl #16
               	and	x2, x2, x17
               	orr	x0, x0, x2
               	str	w0, [x1]
               	sub	x1, x29, #0x10
               	mov	w2, w0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x7fff, lsl #16
               	and	x2, x2, x17
               	add	x2, x2, #0x1
               	mov	w0, w0
               	mov	x17, #0x80000000        // =2147483648
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x7fff, lsl #16
               	and	x2, x2, x17
               	orr	x0, x0, x2
               	str	w0, [x1]
               	mov	w1, w0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x7fff, lsl #16
               	and	x1, x1, x17
               	cmp	x1, #0x3
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x10
               	mov	w2, w0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x7fff, lsl #16
               	and	x2, x2, x17
               	sub	x2, x2, #0x1
               	mov	w0, w0
               	mov	x17, #0x80000000        // =2147483648
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x7fff, lsl #16
               	and	x2, x2, x17
               	orr	x0, x0, x2
               	str	w0, [x1]
               	mov	w1, w0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x7fff, lsl #16
               	and	x1, x1, x17
               	cmp	x1, #0x2
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	w1, w0
               	asr	x1, x1, #31
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	cmp	x1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x10
               	mov	w2, w0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x7fff, lsl #16
               	and	x2, x2, x17
               	add	x2, x2, #0x1
               	mov	w0, w0
               	mov	x17, #0x80000000        // =2147483648
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x7fff, lsl #16
               	and	x2, x2, x17
               	orr	x0, x0, x2
               	str	w0, [x1]
               	mov	w1, w0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x7fff, lsl #16
               	and	x1, x1, x17
               	sxtw	x1, w1
               	cmp	x1, #0x3
               	cset	x1, ne
               	cbnz	x1, <addr>
               	mov	w1, w0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x7fff, lsl #16
               	and	x1, x1, x17
               	cmp	x1, #0x3
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x10
               	mov	w2, w0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x7fff, lsl #16
               	and	x2, x2, x17
               	sub	x2, x2, #0x1
               	mov	w0, w0
               	mov	x17, #0x80000000        // =2147483648
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x7fff, lsl #16
               	and	x2, x2, x17
               	orr	x0, x0, x2
               	str	w0, [x1]
               	mov	w1, w0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x7fff, lsl #16
               	and	x1, x1, x17
               	cmp	x1, #0x2
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	w0, w0
               	asr	x0, x0, #31
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x1]
               	strb	w10, [x0]
               	ldrb	w10, [x1, #0x1]
               	strb	w10, [x0, #0x1]
               	ldrb	w10, [x1, #0x2]
               	strb	w10, [x0, #0x2]
               	ldrb	w10, [x1, #0x3]
               	strb	w10, [x0, #0x3]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0x8
               	ldr	w0, [x1]
               	asr	x2, x0, #4
               	mov	x17, #0x1f              // =31
               	and	x2, x2, x17
               	lsl	x2, x2, #59
               	asr	x2, x2, #59
               	add	x2, x2, #0x1
               	mov	x17, #0xfe0f            // =65039
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x17, #0x1f              // =31
               	and	x2, x2, x17
               	lsl	x2, x2, #4
               	orr	x0, x0, x2
               	str	w0, [x1]
               	mov	w1, w0
               	asr	x1, x1, #4
               	mov	x17, #0x1f              // =31
               	and	x1, x1, x17
               	lsl	x1, x1, #59
               	asr	x1, x1, #59
               	cmp	x1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x8
               	mov	w1, w0
               	asr	x1, x1, #9
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xf, lsl #16
               	and	x2, x1, x17
               	add	x1, x2, #0x1
               	mov	w0, w0
               	mov	x17, #0x1ff             // =511
               	movk	x17, #0xe000, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xf, lsl #16
               	and	x1, x1, x17
               	lsl	x1, x1, #9
               	orr	x1, x0, x1
               	str	w1, [x3]
               	sxtw	x0, w2
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	w0, w1
               	asr	x0, x0, #9
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xf, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x8
               	mov	w0, w1
               	mov	x17, #0xfff0            // =65520
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x17, #0xf               // =15
               	orr	x0, x0, x17
               	str	w0, [x2]
               	sub	x1, x29, #0x8
               	mov	w2, w0
               	mov	x17, #0xf               // =15
               	and	x2, x2, x17
               	add	x2, x2, #0x1
               	mov	w0, w0
               	mov	x17, #0xfff0            // =65520
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	mov	x17, #0xf               // =15
               	and	x2, x2, x17
               	orr	x0, x0, x2
               	str	w0, [x1]
               	mov	w1, w0
               	mov	x17, #0xf               // =15
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	w1, w0
               	asr	x1, x1, #4
               	mov	x17, #0x1f              // =31
               	and	x1, x1, x17
               	lsl	x1, x1, #59
               	asr	x1, x1, #59
               	cmp	x1, #0x1
               	cset	x1, ne
               	cbnz	x1, <addr>
               	mov	w0, w0
               	asr	x0, x0, #9
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xf, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x1
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
