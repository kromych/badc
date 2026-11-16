
short_types.aarch64:	file format elf64-littleaarch64

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

<rt>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	w0, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	str	x20, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x0, #0x4d2              // =1234
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #-0x2a              // =-42
               	bl	<addr>
               	sxth	x1, w20
               	cmp	w1, #0x4d2
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	sxth	x0, w0
               	cmn	w0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	add	x0, x0, x0, lsl #1
               	sxth	x0, w0
               	cmn	w0, #0x7e
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x17, #0x2493            // =9363
               	movk	x17, #0x9249, lsl #16
               	mul	x0, x1, x17
               	asr	x0, x0, #34
               	add	x0, x0, x0, lsr #63
               	mov	x17, #0x7               // =7
               	mul	x0, x0, x17
               	sub	x0, x1, x0
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	sxth	x0, w0
               	lsl	x1, x0, #14
               	sxth	x1, w1
               	mov	x17, #0x4000            // =16384
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	lsl	x1, x0, #16
               	and	x1, x1, #0xffff
               	sub	x2, x1, #0x10, lsl #12  // =0x10000
               	tst	x1, #0x8000
               	csel	x1, x2, x1, ne
               	sxth	x1, w1
               	cbz	w1, <addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	lsl	x0, x0, #15
               	and	x0, x0, #0xffff
               	sub	x1, x0, #0x10, lsl #12  // =0x10000
               	tst	x0, #0x8000
               	csel	x0, x1, x0, ne
               	sxth	x0, w0
               	mov	x17, #-0x8000           // =-32768
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #-0x8               // =-8
               	bl	<addr>
               	sxth	x0, w0
               	asr	x0, x0, #1
               	cmn	w0, #0x4
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0xfffe             // =65534
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	str	x0, [sp, #0x18]
               	and	x0, x20, #0xffff
               	ldr	x16, [sp, #0x18]
               	and	x1, x16, #0xffff
               	add	x0, x0, x1
               	and	x1, x0, #0xffff
               	eor	x1, x1, #0xffff
               	cbz	w1, <addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	add	x0, x0, #0x1
               	and	x0, x0, #0xffff
               	cbz	w0, <addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #-0x1               // =-1
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	and	x0, x0, #0xffff
               	sxth	x1, w20
               	add	x2, x0, x1
               	cbz	w2, <addr>
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	and	x1, x1, #0xffff
               	mov	x17, #0xffff            // =65535
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	cmp	w1, w0
               	b.hi	<addr>
               	mov	x0, #0x10               // =16
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	ldr	x16, [sp, #0x18]
               	and	x0, x16, #0xffff
               	lsl	x0, x0, #15
               	and	x0, x0, #0xffff
               	eor	x0, x0, #0x8000
               	cbz	w0, <addr>
               	mov	x0, #0x11               // =17
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x8000             // =32768
               	bl	<addr>
               	and	x0, x0, #0xffff
               	asr	x0, x0, #1
               	mov	x17, #0x4000            // =16384
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x64               // =100
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #0xc8               // =200
               	bl	<addr>
               	str	x0, [sp, #0x18]
               	mov	x0, #-0x12c             // =-300
               	bl	<addr>
               	sxth	x0, w0
               	sxth	x1, w20
               	ldr	x16, [sp, #0x18]
               	sxth	x2, w16
               	add	x1, x1, x2
               	add	x0, x1, x0
               	and	x0, x0, #0xffff
               	sub	x1, x0, #0x10, lsl #12  // =0x10000
               	tst	x0, #0x8000
               	csel	x0, x1, x0, ne
               	sxth	x0, w0
               	cbz	w0, <addr>
               	mov	x0, #0x13               // =19
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x7                // =7
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #-0x7               // =-7
               	bl	<addr>
               	str	x0, [sp, #0x18]
               	mov	x0, #0xc0de             // =49374
               	bl	<addr>
               	sxth	x1, w20
               	ldr	x16, [sp, #0x18]
               	sxth	x2, w16
               	add	x1, x1, x2
               	cbz	w1, <addr>
               	mov	x0, #0x14               // =20
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	and	x0, x0, #0xffff
               	mov	x17, #0xc0de            // =49374
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x2a               // =42
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
