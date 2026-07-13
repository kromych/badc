
bool_bitfield_zero_extends.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x10
               	sub	x0, x29, #0x8
               	ldr	w1, [x0]
               	mov	x17, #0xff00            // =65280
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x17, #0x10              // =16
               	orr	x1, x1, x17
               	str	w1, [x0]
               	sub	x0, x29, #0x8
               	ldrb	w1, [x0, #0x1]
               	mov	x17, #0xfffe            // =65534
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x17, #0x1               // =1
               	orr	x1, x1, x17
               	strb	w1, [x0, #0x1]
               	sub	x0, x29, #0x8
               	ldrb	w1, [x0, #0x1]
               	mov	x17, #0xfffd            // =65533
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x17, #0x0               // =0
               	orr	x1, x1, x17
               	strb	w1, [x0, #0x1]
               	sub	x0, x29, #0x8
               	ldr	w1, [x0]
               	mov	x17, #0xfbff            // =64511
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x17, #0x400             // =1024
               	orr	x1, x1, x17
               	str	w1, [x0]
               	sub	x0, x29, #0x8
               	ldr	w1, [x0]
               	mov	x17, #0xf7ff            // =63487
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x17, #0x800             // =2048
               	orr	x1, x1, x17
               	str	w1, [x0]
               	sub	x0, x29, #0x8
               	ldrb	w0, [x0, #0x1]
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	ldrb	w0, [x0, #0x1]
               	asr	x0, x0, #1
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x40               // =64
               	sub	x0, x29, #0x8
               	ldrb	w0, [x0, #0x1]
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	lsl	x0, x0, #3
               	sub	x0, x1, x0
               	sxtw	x0, w0
               	cmp	x0, #0x38
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	ldrb	w0, [x0, #0x1]
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	cbz	x0, <addr>
               	sub	x0, x29, #0x8
               	ldrb	w0, [x0, #0x1]
               	asr	x0, x0, #1
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	sub	x0, x29, #0x8
               	ldr	w0, [x0]
               	asr	x0, x0, #11
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	ldr	w0, [x0]
               	asr	x0, x0, #10
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	lsl	x0, x0, #63
               	asr	x0, x0, #63
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
