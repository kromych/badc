
constfold_post_inline.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	add	x0, x0, x1
               	ret

<mul_u>:
               	mul	x0, x0, x1
               	ret

<sub_i>:
               	sub	x0, x0, x1
               	ret

<shl_u>:
               	sxtw	x1, w1
               	lsl	x0, x0, x1
               	ret

<shr_u>:
               	sxtw	x1, w1
               	lsr	x0, x0, x1
               	ret

<shr_i>:
               	sxtw	x1, w1
               	asr	x0, x0, x1
               	ret

<div_u>:
               	udiv	x0, x0, x1
               	ret

<mod_u>:
               	udiv	x17, x0, x1
               	msub	x0, x17, x1, x0
               	ret

<div_i>:
               	sdiv	x0, x0, x1
               	ret

<mod_i>:
               	sdiv	x17, x0, x1
               	msub	x0, x17, x1, x0
               	ret

<ror_u>:
               	sxtw	x1, w1
               	ror	x0, x0, x1
               	ret

<lt_i>:
               	cmp	x0, x1
               	cset	x0, lt
               	ret

<gt_i>:
               	cmp	x0, x1
               	cset	x0, gt
               	ret

<le_i>:
               	cmp	x0, x1
               	cset	x0, le
               	ret

<ge_i>:
               	cmp	x0, x1
               	cset	x0, ge
               	ret

<lt_u>:
               	cmp	x0, x1
               	cset	x0, lo
               	ret

<gt_u>:
               	cmp	x0, x1
               	cset	x0, hi
               	ret

<le_u>:
               	cmp	x0, x1
               	cset	x0, ls
               	ret

<ge_u>:
               	cmp	x0, x1
               	cset	x0, hs
               	ret

<eq_i>:
               	cmp	x0, x1
               	cset	x0, eq
               	ret

<ne_i>:
               	cmp	x0, x1
               	cset	x0, ne
               	ret

<sext8>:
               	sxtb	x0, w0
               	ret

<sext16>:
               	sxth	x0, w0
               	ret

<sext32>:
               	sxtw	x0, w0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x18               // =24
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x19               // =25
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x1a               // =26
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x1b               // =27
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x1c               // =28
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x1d               // =29
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xcdef             // =52719
               	movk	x0, #0x89ab, lsl #16
               	movk	x0, #0x4567, lsl #32
               	movk	x0, #0x123, lsl #48
               	stur	x0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	add	x1, x0, #0x5
               	mov	x17, #0xcdf4            // =52724
               	movk	x17, #0x89ab, lsl #16
               	movk	x17, #0x4567, lsl #32
               	movk	x17, #0x123, lsl #48
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x24               // =36
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x1, x0, #0x5
               	mov	x17, #0xcdf4            // =52724
               	movk	x17, #0x89ab, lsl #16
               	movk	x17, #0x4567, lsl #32
               	movk	x17, #0x123, lsl #48
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x25               // =37
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	x0, #0x64
               	cset	x1, hi
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x26               // =38
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	x0, #0x64
               	b.hs	<addr>
               	mov	x0, #0x27               // =39
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x1, ls
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x28               // =40
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ror	x1, x0, #0x7
               	mov	x17, #0x579b            // =22427
               	movk	x17, #0xcf13, lsl #16
               	movk	x17, #0x468a, lsl #32
               	movk	x17, #0xde02, lsl #48
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x29               // =41
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0x41              // =65
               	lsl	x0, x0, x17
               	mov	x17, #0x9bde            // =39902
               	movk	x17, #0x1357, lsl #16
               	movk	x17, #0x8acf, lsl #32
               	movk	x17, #0x246, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xfff8             // =65528
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	stur	x0, [x29, #-0x18]
               	ldur	x0, [x29, #-0x18]
               	asr	x0, x0, #1
               	mov	x17, #0xfffc            // =65532
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2b               // =43
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
