
strength_reduce_pow2_divmod.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0xa0
               	mov	x0, #0xfff9             // =65529
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	stur	w0, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x8]
               	asr	x1, x0, #63
               	lsr	x1, x1, #63
               	add	x0, x0, x1
               	asr	x0, x0, #1
               	mov	x17, #0xfffd            // =65533
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldursw	x0, [x29, #-0x8]
               	asr	x1, x0, #63
               	lsr	x1, x1, #63
               	add	x0, x0, x1
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	sub	x0, x0, x1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xfff0             // =65520
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	stur	w0, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x8]
               	asr	x1, x0, #63
               	lsr	x1, x1, #60
               	add	x0, x0, x1
               	asr	x0, x0, #4
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldursw	x0, [x29, #-0x8]
               	asr	x1, x0, #63
               	lsr	x1, x1, #60
               	add	x0, x0, x1
               	mov	x17, #0xf               // =15
               	and	x0, x0, x17
               	sub	x0, x0, x1
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xffef             // =65519
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	stur	w0, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x8]
               	asr	x1, x0, #63
               	lsr	x1, x1, #60
               	add	x0, x0, x1
               	asr	x0, x0, #4
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldursw	x0, [x29, #-0x8]
               	asr	x1, x0, #63
               	lsr	x1, x1, #60
               	add	x0, x0, x1
               	mov	x17, #0xf               // =15
               	and	x0, x0, x17
               	sub	x0, x0, x1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x64               // =100
               	stur	w0, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x8]
               	asr	x1, x0, #63
               	lsr	x1, x1, #61
               	add	x0, x0, x1
               	asr	x0, x0, #3
               	cmp	x0, #0xc
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldursw	x0, [x29, #-0x8]
               	asr	x1, x0, #63
               	lsr	x1, x1, #61
               	add	x0, x0, x1
               	mov	x17, #0x7               // =7
               	and	x0, x0, x17
               	sub	x0, x0, x1
               	cmp	x0, #0x4
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x80000000         // =2147483648
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	stur	w0, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x8]
               	asr	x1, x0, #63
               	lsr	x1, x1, #63
               	add	x0, x0, x1
               	asr	x0, x0, #1
               	mov	x17, #0xc0000000        // =3221225472
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldursw	x0, [x29, #-0x8]
               	asr	x1, x0, #63
               	lsr	x1, x1, #63
               	add	x0, x0, x1
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	sub	x0, x0, x1
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	stur	w0, [x29, #-0x10]
               	ldur	w0, [x29, #-0x10]
               	lsr	x0, x0, #1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x7fff, lsl #16
               	cmp	x0, x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldur	w0, [x29, #-0x10]
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	cmp	x0, #0x1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x80000000         // =2147483648
               	stur	w0, [x29, #-0x10]
               	ldur	w0, [x29, #-0x10]
               	lsr	x0, x0, #4
               	mov	x17, #0x8000000         // =134217728
               	cmp	x0, x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldur	w0, [x29, #-0x10]
               	mov	x17, #0xf               // =15
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2979             // =10617
               	movk	x0, #0xffed, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	stur	x0, [x29, #-0x38]
               	ldur	x0, [x29, #-0x38]
               	asr	x1, x0, #63
               	lsr	x1, x1, #54
               	add	x0, x0, x1
               	asr	x0, x0, #10
               	mov	x17, #0xfb4b            // =64331
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldur	x0, [x29, #-0x38]
               	asr	x1, x0, #63
               	lsr	x1, x1, #54
               	add	x0, x0, x1
               	mov	x17, #0x3ff             // =1023
               	and	x0, x0, x17
               	sub	x0, x0, x1
               	mov	x17, #0xfd79            // =64889
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #-0x8000000000000000 // =-9223372036854775808
               	stur	x0, [x29, #-0x38]
               	ldur	x0, [x29, #-0x38]
               	asr	x1, x0, #63
               	lsr	x1, x1, #63
               	add	x0, x0, x1
               	asr	x0, x0, #1
               	mov	x17, #-0x4000000000000000 // =-4611686018427387904
               	cmp	x0, x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldur	x0, [x29, #-0x38]
               	asr	x1, x0, #63
               	lsr	x1, x1, #63
               	add	x0, x0, x1
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	sub	x0, x0, x1
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	stur	x0, [x29, #-0x40]
               	ldur	x0, [x29, #-0x40]
               	lsr	x0, x0, #1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0x7fff, lsl #48
               	cmp	x0, x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldur	x0, [x29, #-0x40]
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	cmp	x0, #0xff
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xfffb             // =65531
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	stur	w0, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x8]
               	mov	x17, #0xfffb            // =65531
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldursw	x0, [x29, #-0x8]
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
