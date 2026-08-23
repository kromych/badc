
int_compare_narrow_width.aarch64:	file format elf64-littleaarch64

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
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x0, [x3]
               	sxtw	x5, w0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	sxtw	x4, w1
               	ldr	x1, [x3]
               	mov	w1, w1
               	ldr	x0, [x0]
               	mov	w7, w0
               	cmp	w5, #0x0
               	b.lt	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	cmp	w5, w4
               	b.lt	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	cmp	w4, w5
               	b.gt	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x17, #0x1               // =1
               	movk	x17, #0x8000, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	w5, w17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	cmp	w5, w4
               	b.ne	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	cmp	w4, #0xc
               	cset	x2, le
               	cmp	w2, #0x0
               	cset	x0, eq
               	cbz	x2, <addr>
               	cmp	w4, #0xc
               	cset	x0, ge
               	cmp	w0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ret
               	mov	w0, w1
               	mov	w2, w7
               	cmp	w0, w2
               	b.hi	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	cmp	w0, w2
               	b.lt	<addr>
               	mov	x0, #0x8                // =8
               	ret
               	mov	x17, #0x80000000        // =2147483648
               	cmp	w0, w17
               	b.hi	<addr>
               	mov	x0, #0x9                // =9
               	ret
               	mov	w2, w4
               	cmp	w2, w0
               	b.ls	<addr>
               	mov	x0, #0xb                // =11
               	ret
               	mov	x17, #0x1               // =1
               	movk	x17, #0x8000, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ret
               	ldr	x0, [x3]
               	mov	x17, #0x100000000       // =4294967296
               	cmp	x0, x17
               	b.gt	<addr>
               	mov	x0, #0x10               // =16
               	ret
               	mul	x0, x4, x4
               	cmp	w0, #0x90
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	ret
               	lsl	x0, x4, #4
               	cmp	w0, #0xc0
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	ret
               	asr	x0, x4, #2
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x18               // =24
               	ret
               	mov	x17, #0x2493            // =9363
               	movk	x17, #0x9249, lsl #16
               	mul	x0, x5, x17
               	asr	x0, x0, #34
               	lsr	x1, x0, #63
               	add	x0, x0, x1
               	mov	x17, #0xdb6e            // =56174
               	movk	x17, #0xedb6, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x19               // =25
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x0, [x1]
               	sxtb	x0, w0
               	ldr	x2, [x1]
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	ldr	x1, [x1]
               	sxth	x8, w1
               	cmp	w0, #0x0
               	cset	x3, lt
               	cmp	w3, #0x0
               	cset	x1, eq
               	cbz	x3, <addr>
               	mov	x17, #0xff92            // =65426
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	w0, w17
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x1d               // =29
               	ret
               	mov	x17, #0xff              // =255
               	and	x1, x2, x17
               	cmp	w1, #0x0
               	cset	x6, gt
               	cmp	w6, #0x0
               	cset	x3, eq
               	cbz	x6, <addr>
               	mov	x17, #0x92              // =146
               	eor	x3, x1, x17
               	mov	w3, w3
               	cmp	w3, #0x0
               	cset	x3, ne
               	cbz	x3, <addr>
               	mov	x0, #0x1e               // =30
               	ret
               	cmp	w0, w8
               	b.eq	<addr>
               	mov	x0, #0x1f               // =31
               	ret
               	cmp	w0, w1
               	b.lt	<addr>
               	mov	x0, #0x20               // =32
               	ret
               	mov	x0, #0x0                // =0
               	mov	x6, #0x3                // =3
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	sxtw	x1, w0
               	mul	x2, x1, x6
               	str	w2, [x3, x1, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x14
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, x4, lsl #2]
               	cmp	w0, #0x24
               	b.eq	<addr>
               	mov	x0, #0x21               // =33
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	w1, w7
               	sxtw	x1, w1
               	ldrsw	x0, [x0, x1, lsl #2]
               	cmp	w0, #0x24
               	b.eq	<addr>
               	mov	x0, #0x22               // =34
               	ret
               	sub	x0, x4, #0x5
               	sxtw	x1, w0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0, x1, lsl #2]
               	add	x2, x2, x5
               	str	w2, [x0, x1, lsl #2]
               	ldrsw	x0, [x0, #0x1c]
               	mov	x17, #0x16              // =22
               	movk	x17, #0x8000, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x23               // =35
               	ret
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	mov	x2, x1
               	mov	x17, #0xfffb            // =65531
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	w4, w17
               	b.ge	<addr>
               	mov	x0, x1
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x26               // =38
               	ret
               	mov	x0, #0x4925             // =18725
               	movk	x0, #0x2492, lsl #16
               	movk	x0, #0x9249, lsl #32
               	movk	x0, #0x4924, lsl #48
               	smulh	x0, x5, x0
               	asr	x0, x0, #1
               	lsr	x1, x0, #63
               	add	x0, x0, x1
               	mov	x17, #0xdb6e            // =56174
               	movk	x17, #0xedb6, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2a               // =42
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	cmp	w4, #0x5
               	b.le	<addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
