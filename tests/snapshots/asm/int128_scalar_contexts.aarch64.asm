
int128_scalar_contexts.aarch64:	file format elf64-littleaarch64

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

<pointers>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x2, [x1]
               	ldrsw	x2, [x0, x2, lsl #2]
               	cmp	w2, #0x1e
               	b.ne	<addr>
               	ldr	x2, [x1]
               	ldrsw	x2, [x0, x2, lsl #2]
               	cmp	w2, #0x1e
               	b.ne	<addr>
               	ldr	x2, [x1]
               	ldrsw	x2, [x0, x2, lsl #2]
               	cmp	w2, #0x1e
               	b.ne	<addr>
               	ldr	x2, [x1]
               	ldrsw	x2, [x0, x2, lsl #2]
               	cmp	w2, #0x1e
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldr	x2, [x1]
               	lsl	x2, x2, #2
               	add	x2, x0, x2
               	sub	x2, x2, x0
               	asr	x3, x2, #63
               	lsr	x3, x3, #62
               	add	x2, x2, x3
               	asr	x2, x2, #2
               	cmp	x2, #0x3
               	b.ne	<addr>
               	ldr	x2, [x1]
               	lsl	x2, x2, #2
               	add	x2, x0, x2
               	sub	x2, x2, x0
               	asr	x3, x2, #63
               	lsr	x3, x3, #62
               	add	x2, x2, x3
               	asr	x2, x2, #2
               	cmp	x2, #0x3
               	b.ne	<addr>
               	add	x2, x0, #0x1c
               	ldr	x3, [x1]
               	lsl	x3, x3, #2
               	sub	x2, x2, x3
               	ldrsw	x2, [x2]
               	cmp	w2, #0x28
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldr	x2, [x1]
               	lsl	x2, x2, #2
               	add	x2, x0, x2
               	ldrsw	x3, [x2]
               	cmp	w3, #0x1e
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldr	x3, [x1]
               	sub	x3, x3, #0x1
               	lsl	x3, x3, #2
               	sub	x2, x2, x3
               	ldrsw	x2, [x2]
               	cmp	w2, #0xa
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	mov	x3, #0x21               // =33
               	str	w3, [x0, x2, lsl #2]
               	ldrsw	x2, [x0, #0xc]
               	cmp	w2, #0x21
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	add	x2, x0, #0xc
               	mov	x3, #0x1e               // =30
               	str	w3, [x2]
               	ldr	x1, [x1]
               	lsl	x1, x1, #2
               	add	x0, x0, x1
               	cmp	x0, x2
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	mov	x0, #0x0                // =0
               	ret

<scalars>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0x1                // =1
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x1, [x2]
               	lsl	x1, x0, x1
               	cmp	w1, #0x8
               	b.ne	<addr>
               	mov	x1, #0x40               // =64
               	ldr	x3, [x2]
               	asr	x1, x1, x3
               	cmp	x1, #0x8
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	sub	sp, x29, #0x10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x1, [x2]
               	lsl	x0, x0, x1
               	cmp	w0, #0x8
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	sub	sp, x29, #0x10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [x2]
               	add	x0, x0, #0x5
               	sxtw	x0, w0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x1, [x3]
               	eor	x0, x0, x1
               	cmp	w0, #0x8
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	sub	sp, x29, #0x10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x10
               	str	wzr, [x1]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x4, [x0]
               	ldr	x5, [x0, #0x8]
               	orr	x4, x4, x5
               	cmp	x4, #0x0
               	cset	x4, ne
               	strb	w4, [x1]
               	strb	wzr, [x1, #0x1]
               	ldr	w4, [x1]
               	and	x4, x4, #0xffffffffffff01ff
               	str	w4, [x1]
               	ldr	x4, [x0]
               	ldr	x5, [x0, #0x8]
               	orr	x4, x4, x5
               	cmp	x4, #0x0
               	cset	x4, ne
               	ldrb	w5, [x1, #0x1]
               	and	x5, x5, #0xfffffffffffffffe
               	orr	x4, x5, x4
               	strb	w4, [x1, #0x1]
               	ldr	w4, [x1]
               	and	x4, x4, #0xffffffffffff01ff
               	orr	x4, x4, #0x200
               	str	w4, [x1]
               	mov	w5, w4
               	asr	x5, x5, #9
               	and	x5, x5, #0x7f
               	lsl	x5, x5, #57
               	asr	x5, x5, #57
               	ldr	x2, [x2]
               	lsl	x2, x5, x2
               	and	x2, x2, #0x7f
               	and	x4, x4, #0xffffffffffff01ff
               	lsl	x2, x2, #9
               	orr	x2, x4, x2
               	str	w2, [x1]
               	ldrb	w4, [x1]
               	cbz	w4, <addr>
               	ldrb	w1, [x1, #0x1]
               	tbz	w1, #0x0, <addr>
               	mov	w1, w2
               	asr	x1, x1, #9
               	and	x1, x1, #0x7f
               	lsl	x1, x1, #57
               	asr	x1, x1, #57
               	cmp	w1, #0x8
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	sub	sp, x29, #0x10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	orr	x1, x1, x2
               	cbz	x1, <addr>
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	orr	x1, x1, x2
               	cbz	x1, <addr>
               	ldr	x1, [x3]
               	ldr	x2, [x3, #0x8]
               	orr	x1, x1, x2
               	cbnz	x1, <addr>
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	orr	x1, x1, x2
               	cbz	x1, <addr>
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	orr	x1, x1, x2
               	cbz	x1, <addr>
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	cmp	x1, x1
               	cset	x3, lo
               	sub	x1, x1, x1
               	sub	x2, x2, x2
               	sub	x2, x2, x3
               	orr	x1, x1, x2
               	cbz	x1, <addr>
               	mov	x0, #0xb                // =11
               	sub	sp, x29, #0x10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	orr	x2, x1, x0
               	asr	x3, x0, #1
               	lsr	x1, x1, #1
               	lsl	x0, x0, #63
               	orr	x0, x1, x0
               	orr	x0, x0, x3
               	cbz	x2, <addr>
               	cbnz	x0, <addr>
               	mov	x0, #0xc                // =12
               	sub	sp, x29, #0x10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, sp
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	lsl	x0, x0, #2
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x2, sp
               	sub	x2, x2, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x2
               	cmp	x0, #0xc
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	sub	sp, x29, #0x10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	sp, x1
               	mov	x0, #0x0                // =0
               	sub	sp, x29, #0x10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<switches>:
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x0, [x1]
               	ldr	x1, [x1, #0x8]
               	mov	x17, #-0x1              // =-1
               	cmp	x1, x17
               	b.eq	<addr>
               	cbz	x1, <addr>
               	cmp	x1, #0x1
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ret
               	b	<addr>
               	mov	x17, #0x7fffffffffffffff // =9223372036854775807
               	cmp	x0, x17
               	b.lo	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.lo	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b	<addr>
               	mov	x17, #0x7fffffffffffffff // =9223372036854775807
               	cmp	x0, x17
               	b	<addr>
               	cmp	x0, #0x3
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x0, [x1]
               	ldr	x1, [x1, #0x8]
               	mov	x17, #-0x1              // =-1
               	cmp	x1, x17
               	b.eq	<addr>
               	cbz	x1, <addr>
               	cmp	x1, #0x1
               	b.ne	<addr>
               	b	<addr>
               	mov	x17, #0x7fffffffffffffff // =9223372036854775807
               	cmp	x0, x17
               	b.lo	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.lo	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b	<addr>
               	mov	x17, #0x7fffffffffffffff // =9223372036854775807
               	cmp	x0, x17
               	b	<addr>
               	cmp	x0, #0x3
               	b	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.lo	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b	<addr>
               	mov	x17, #-0x2              // =-2
               	cmp	x0, x17
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x0, [x1]
               	ldr	x2, [x1, #0x8]
               	mov	x17, #-0x1              // =-1
               	cmp	x2, x17
               	b.eq	<addr>
               	cbz	x2, <addr>
               	cmp	x2, #0x1
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ret
               	cbnz	x0, <addr>
               	ldr	x2, [x1]
               	ldr	x3, [x1, #0x8]
               	add	x0, x2, #0x3
               	cmp	x0, x2
               	cset	x2, lo
               	add	x2, x3, x2
               	mov	x17, #-0x1              // =-1
               	cmp	x2, x17
               	b.eq	<addr>
               	cbz	x2, <addr>
               	cmp	x2, #0x1
               	b.eq	<addr>
               	ldr	x0, [x1]
               	ldr	x1, [x1, #0x8]
               	cmp	x0, #0x0
               	cset	x2, hi
               	neg	x0, x0
               	neg	x1, x1
               	sub	x1, x1, x2
               	mov	x17, #-0x1              // =-1
               	cmp	x1, x17
               	b.eq	<addr>
               	cbz	x1, <addr>
               	cmp	x1, #0x1
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x0
               	cset	x2, lt
               	eor	x2, x2, #0x1
               	cbnz	x2, <addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.eq	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x11               // =17
               	ret
               	cmp	x1, #0x3
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x0
               	cset	x3, lt
               	cmp	x0, #0x0
               	cset	x2, eq
               	cmp	x1, #0x1
               	cset	x4, lo
               	and	x4, x2, x4
               	orr	x3, x3, x4
               	eor	x3, x3, #0x1
               	cbnz	x3, <addr>
               	mov	x2, #-0x1               // =-1
               	cmp	x0, x2
               	cset	x4, lt
               	cmp	x0, x2
               	cset	x3, eq
               	mov	x17, #-0x9              // =-9
               	cmp	x1, x17
               	cset	x5, lo
               	and	x5, x3, x5
               	orr	x4, x4, x5
               	eor	x4, x4, #0x1
               	cbnz	x4, <addr>
               	mov	x0, #0x13               // =19
               	ret
               	cmp	x2, x0
               	cset	x0, lt
               	mov	x17, #-0x3              // =-3
               	cmp	x1, x17
               	cset	x1, hi
               	and	x1, x3, x1
               	orr	x0, x0, x1
               	eor	x0, x0, #0x1
               	b	<addr>
               	cmp	x0, #0x0
               	cset	x3, gt
               	cmp	x1, #0x5
               	cset	x4, hi
               	and	x2, x2, x4
               	orr	x2, x3, x2
               	eor	x2, x2, #0x1
               	cbz	x2, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	add	x3, x1, #0x3
               	cmp	x3, x1
               	cset	x1, lo
               	add	x1, x2, x1
               	cmp	x1, #0x0
               	cset	x4, lt
               	cmp	x1, #0x0
               	cset	x2, eq
               	cmp	x3, #0x1
               	cset	x5, lo
               	and	x5, x2, x5
               	orr	x4, x4, x5
               	eor	x4, x4, #0x1
               	cbnz	x4, <addr>
               	mov	x2, #-0x1               // =-1
               	cmp	x1, x2
               	cset	x5, lt
               	cmp	x1, x2
               	cset	x4, eq
               	mov	x17, #-0x9              // =-9
               	cmp	x3, x17
               	cset	x6, lo
               	and	x6, x4, x6
               	orr	x5, x5, x6
               	eor	x5, x5, #0x1
               	cbnz	x5, <addr>
               	ldr	x1, [x0]
               	ldr	x3, [x0, #0x8]
               	cmp	x1, #0x0
               	cset	x4, hi
               	neg	x1, x1
               	neg	x3, x3
               	sub	x4, x3, x4
               	cmp	x1, #0x5
               	cset	x5, lo
               	sub	x3, x1, #0x5
               	sub	x1, x4, x5
               	cmp	x1, #0x0
               	cset	x5, lt
               	cmp	x1, #0x0
               	cset	x4, eq
               	cmp	x3, #0x1
               	cset	x6, lo
               	and	x6, x4, x6
               	orr	x5, x5, x6
               	eor	x5, x5, #0x1
               	cbnz	x5, <addr>
               	cmp	x1, x2
               	cset	x5, lt
               	cmp	x1, x2
               	cset	x4, eq
               	mov	x17, #-0x9              // =-9
               	cmp	x3, x17
               	cset	x6, lo
               	and	x6, x4, x6
               	orr	x5, x5, x6
               	eor	x5, x5, #0x1
               	cbnz	x5, <addr>
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	cbz	x2, <addr>
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	add	x0, x1, #0x5
               	cmp	x0, x1
               	cset	x1, lo
               	add	x1, x2, x1
               	cbz	x1, <addr>
               	mov	x0, #0x0                // =0
               	ret
               	cmp	x0, #0xa
               	b.hs	<addr>
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x0, lsl #3]
               	br	x17
               	mov	x0, #0x15               // =21
               	ret
               	cmp	x1, #0xa
               	b.hs	<addr>
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x1, lsl #3]
               	br	x17
               	cmp	x2, x1
               	cset	x1, lt
               	mov	x17, #-0x3              // =-3
               	cmp	x3, x17
               	cset	x2, hi
               	and	x2, x4, x2
               	orr	x1, x1, x2
               	eor	x1, x1, #0x1
               	cbnz	x1, <addr>
               	b	<addr>
               	cmp	x1, #0x0
               	cset	x5, gt
               	cmp	x3, #0x5
               	cset	x6, hi
               	and	x4, x4, x6
               	orr	x4, x5, x4
               	eor	x4, x4, #0x1
               	cbnz	x4, <addr>
               	b	<addr>
               	cmp	x2, x1
               	cset	x1, lt
               	mov	x17, #-0x3              // =-3
               	cmp	x3, x17
               	cset	x3, hi
               	and	x3, x4, x3
               	orr	x1, x1, x3
               	eor	x1, x1, #0x1
               	cbnz	x1, <addr>
               	b	<addr>
               	cmp	x1, #0x0
               	cset	x4, gt
               	cmp	x3, #0x5
               	cset	x5, hi
               	and	x2, x2, x5
               	orr	x2, x4, x2
               	eor	x2, x2, #0x1
               	cbnz	x2, <addr>
               	b	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x1, x17
               	b	<addr>
               	cmp	x0, #0x0
               	cset	x2, gt
               	cmp	x0, #0x0
               	cset	x3, eq
               	cmp	x1, #0x2
               	cset	x4, hi
               	and	x3, x3, x4
               	orr	x2, x2, x3
               	eor	x2, x2, #0x1
               	cbnz	x2, <addr>
               	b	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x10               // =16
               	ret
               	mov	x17, #0x7fffffffffffffff // =9223372036854775807
               	cmp	x0, x17
               	b.lo	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.lo	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.eq	<addr>
               	b	<addr>
               	mov	x17, #0x7fffffffffffffff // =9223372036854775807
               	cmp	x0, x17
               	b.eq	<addr>
               	b	<addr>
               	cmp	x0, #0x3
               	b.eq	<addr>
               	b	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.lo	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.eq	<addr>
               	b	<addr>
               	mov	x17, #-0x2              // =-2
               	cmp	x0, x17
               	b.eq	<addr>
               	b	<addr>
               	cbz	x0, <addr>
               	b	<addr>
               	mov	x17, #0x7fffffffffffffff // =9223372036854775807
               	cmp	x0, x17
               	b.lo	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.lo	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.eq	<addr>
               	b	<addr>
               	mov	x17, #0x7fffffffffffffff // =9223372036854775807
               	cmp	x0, x17
               	b.eq	<addr>
               	b	<addr>
               	cmp	x0, #0x3
               	b.eq	<addr>
               	b	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.lo	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.eq	<addr>
               	b	<addr>
               	mov	x17, #-0x2              // =-2
               	cmp	x0, x17
               	b.eq	<addr>
               	b	<addr>
               	mov	x17, #0x7fffffffffffffff // =9223372036854775807
               	cmp	x0, x17
               	b.lo	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.lo	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b	<addr>
               	mov	x17, #0x7fffffffffffffff // =9223372036854775807
               	cmp	x0, x17
               	b	<addr>
               	cmp	x0, #0x3
               	b	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.lo	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b	<addr>
               	mov	x17, #-0x2              // =-2
               	cmp	x0, x17
               	b	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.lo	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b	<addr>
               	mov	x17, #-0x2              // =-2
               	cmp	x0, x17
               	b	<addr>

<builtins>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x0, #0x5                // =5
               	stur	w0, [x29, #-0x18]
               	sub	x1, x29, #0x18
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0]
               	ldaddal	w2, w16, [x1]
               	ldursw	x1, [x29, #-0x18]
               	cmp	w1, #0x8
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	sub	sp, x29, #0x20
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	xzr, [x29, #-0x10]
               	sub	x1, x29, #0x10
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	add	x2, x2, #0x2
               	ldaddal	x2, x16, [x1]
               	ldur	x1, [x29, #-0x10]
               	cmp	x1, #0x2
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	sub	sp, x29, #0x20
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [x0]
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x0, sp
               	sub	x0, x0, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x0
               	mov	x1, #0x78               // =120
               	strb	w1, [x0, #0x2]
               	strb	w1, [x0, #0x1]
               	strb	w1, [x0]
               	mov	x0, #0x0                // =0
               	sub	sp, x29, #0x20
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
