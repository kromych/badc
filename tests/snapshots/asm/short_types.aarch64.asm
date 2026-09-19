
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
               	stp	x20, x21, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x0, #0x4d2              // =1234
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #-0x2a              // =-42
               	bl	<addr>
               	sxth	x1, w20
               	cmp	w1, #0x4d2
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	sxth	x2, w0
               	mov	x17, #-0x2a             // =-42
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x17, #0x3               // =3
               	mul	x0, x2, x17
               	sxth	x0, w0
               	mov	x17, #-0x7e             // =-126
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x17, #0x2493            // =9363
               	movk	x17, #0x9249, lsl #16
               	mul	x2, x1, x17
               	asr	x0, x2, #34
               	lsr	x3, x0, #63
               	add	x4, x0, x3
               	sxth	x5, w4
               	cmp	w5, #0xb0
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x17, #0x7               // =7
               	mul	x0, x4, x17
               	sub	x0, x1, x0
               	sxth	x0, w0
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	mov	x1, x0
               	sxth	x2, w1
               	lsl	x0, x2, #14
               	sxth	x0, w0
               	mov	x17, #0x4000            // =16384
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	lsl	x0, x2, #16
               	and	x0, x0, #0xffff
               	and	x3, x0, #0x8000
               	cbz	x3, <addr>
               	sub	x0, x0, #0x10, lsl #12  // =0x10000
               	sxth	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	lsl	x0, x2, #15
               	and	x0, x0, #0xffff
               	and	x1, x0, #0x8000
               	cbz	x1, <addr>
               	sub	x0, x0, #0x10, lsl #12  // =0x10000
               	sxth	x0, w0
               	mov	x17, #-0x8000           // =-32768
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #-0x8               // =-8
               	bl	<addr>
               	sxth	x0, w0
               	asr	x0, x0, #1
               	mov	x17, #-0x4              // =-4
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0xfffe             // =65534
               	bl	<addr>
               	mov	x21, x0
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	mov	x20, x0
               	and	x2, x21, #0xffff
               	and	x3, x20, #0xffff
               	add	x0, x2, x3
               	and	x1, x0, #0xffff
               	eor	x1, x1, #0xffff
               	cbz	x1, <addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	add	x0, x0, #0x1
               	and	x0, x0, #0xffff
               	cbz	x0, <addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #-0x1               // =-1
               	bl	<addr>
               	mov	x21, x0
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	mov	x1, x0
               	and	x2, x1, #0xffff
               	sxth	x3, w21
               	add	x0, x2, x3
               	cbz	x0, <addr>
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	and	x0, x3, #0xffff
               	mov	x17, #0xffff            // =65535
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	cmp	w0, w2
               	b.hi	<addr>
               	mov	x0, #0x10               // =16
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	and	x0, x20, #0xffff
               	lsl	x0, x0, #15
               	and	x0, x0, #0xffff
               	eor	x0, x0, #0x8000
               	cbz	x0, <addr>
               	mov	x0, #0x11               // =17
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x8000             // =32768
               	bl	<addr>
               	and	x0, x0, #0xffff
               	sxtw	x0, w0
               	asr	x0, x0, #1
               	mov	x17, #0x4000            // =16384
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x64               // =100
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #0xc8               // =200
               	bl	<addr>
               	mov	x21, x0
               	mov	x0, #-0x12c             // =-300
               	bl	<addr>
               	sxth	x2, w0
               	sxth	x1, w20
               	sxth	x3, w21
               	add	x1, x1, x3
               	add	x0, x1, x2
               	and	x0, x0, #0xffff
               	and	x1, x0, #0x8000
               	cbz	x1, <addr>
               	sub	x0, x0, #0x10, lsl #12  // =0x10000
               	sxth	x1, w0
               	cbz	x1, <addr>
               	mov	x0, #0x13               // =19
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x7                // =7
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #-0x7               // =-7
               	bl	<addr>
               	mov	x21, x0
               	mov	x0, #0xc0de             // =49374
               	bl	<addr>
               	mov	x1, x0
               	sxth	x0, w20
               	sxth	x2, w21
               	add	x0, x0, x2
               	cbz	x0, <addr>
               	mov	x0, #0x14               // =20
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	and	x0, x1, #0xffff
               	mov	x17, #0xc0de            // =49374
               	eor	x0, x0, x17
               	cbz	x0, <addr>
               	mov	x0, #0x15               // =21
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x2a               // =42
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
