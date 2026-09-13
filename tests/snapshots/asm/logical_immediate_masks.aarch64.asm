
logical_immediate_masks.aarch64:	file format elf64-littleaarch64

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

<ref_and>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	x1, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	and	x0, x0, x1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<ref_or>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	x1, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	orr	x0, x0, x1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<ref_xor>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	x1, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	eor	x0, x0, x1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<ref_and32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	w1, w1
               	stur	w1, [x29, #-0x8]
               	mov	w0, w0
               	ldur	w1, [x29, #-0x8]
               	and	x0, x0, x1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<ref_or32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	w1, w1
               	stur	w1, [x29, #-0x8]
               	mov	w0, w0
               	ldur	w1, [x29, #-0x8]
               	orr	x0, x0, x1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<ref_xor32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	w1, w1
               	stur	w1, [x29, #-0x8]
               	mov	w0, w0
               	ldur	w1, [x29, #-0x8]
               	eor	x0, x0, x1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<and_e64>:
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	ret

<or_e8>:
               	mov	x17, #0xf0f0            // =61680
               	movk	x17, #0xf0f0, lsl #16
               	movk	x17, #0xf0f0, lsl #32
               	movk	x17, #0xf0f0, lsl #48
               	orr	x0, x0, x17
               	ret

<xor_top>:
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	eor	x0, x0, x17
               	ret

<and_align>:
               	mov	x17, #0xfff0            // =65520
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	ret

<or_wrap>:
               	mov	x17, #0xff              // =255
               	movk	x17, #0xff00, lsl #48
               	orr	x0, x0, x17
               	ret

<xor_e2>:
               	mov	x17, #0x5555            // =21845
               	movk	x17, #0x5555, lsl #16
               	movk	x17, #0x5555, lsl #32
               	movk	x17, #0x5555, lsl #48
               	eor	x0, x0, x17
               	ret

<and_e4>:
               	mov	x17, #0x7777            // =30583
               	movk	x17, #0x7777, lsl #16
               	movk	x17, #0x7777, lsl #32
               	movk	x17, #0x7777, lsl #48
               	and	x0, x0, x17
               	ret

<and_e16>:
               	mov	x17, #0xff              // =255
               	movk	x17, #0xff, lsl #16
               	movk	x17, #0xff, lsl #32
               	movk	x17, #0xff, lsl #48
               	and	x0, x0, x17
               	ret

<or_e32>:
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #32
               	orr	x0, x0, x17
               	ret

<xor_run>:
               	mov	x17, #0xfff00000        // =4293918720
               	movk	x17, #0xfff, lsl #32
               	eor	x0, x0, x17
               	ret

<and32_e8>:
               	mov	w0, w0
               	mov	x17, #0xf0f             // =3855
               	movk	x17, #0xf0f, lsl #16
               	and	x0, x0, x17
               	ret

<or32_top>:
               	mov	w0, w0
               	mov	x17, #0x80000000        // =2147483648
               	orr	x0, x0, x17
               	ret

<xor32_e16>:
               	mov	w0, w0
               	mov	x17, #0xff              // =255
               	movk	x17, #0xff, lsl #16
               	eor	x0, x0, x17
               	ret

<and32_neg>:
               	mov	x17, #0xff00            // =65280
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	sxtw	x0, w0
               	ret

<xor32_e2>:
               	mov	x17, #0x5555            // =21845
               	movk	x17, #0x5555, lsl #16
               	eor	x0, x0, x17
               	sxtw	x0, w0
               	ret

<or32_e4>:
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	orr	x0, x0, x17
               	sxtw	x0, w0
               	ret

<and_plain>:
               	mov	x17, #0x1234            // =4660
               	and	x0, x0, x17
               	ret

<or_plain>:
               	mov	x17, #0x5678            // =22136
               	movk	x17, #0x1234, lsl #16
               	orr	x0, x0, x17
               	ret

<xor_plain>:
               	mov	x17, #0x5               // =5
               	eor	x0, x0, x17
               	ret

<mix_loop>:
               	mov	x3, x0
               	mov	x4, x1
               	mov	x1, #0x1                // =1
               	mov	x0, #0x0                // =0
               	mov	x5, #0xff00             // =65280
               	movk	x5, #0xff00, lsl #16
               	movk	x5, #0xff00, lsl #32
               	movk	x5, #0xff00, lsl #48
               	mov	x6, #0x10               // =16
               	mov	x7, #0x1234             // =4660
               	b	<addr>
               	ror	x1, x1, #0x39
               	sxtw	x2, w0
               	ldr	x8, [x3, x2, lsl #3]
               	and	x8, x8, x5
               	eor	x1, x1, x8
               	orr	x1, x1, x6
               	ldr	x8, [x3, x2, lsl #3]
               	and	x8, x8, x7
               	eor	x1, x1, x8
               	add	x0, x2, #0x1
               	cmp	w0, w4
               	b.lt	<addr>
               	mov	x0, x1
               	ret

<classify>:
               	mov	x1, x0
               	mov	x0, #0x0                // =0
               	mov	x17, #0x40              // =64
               	and	x2, x1, x17
               	cbz	x2, <addr>
               	mov	x0, #0x1                // =1
               	mov	x17, #0xf0              // =240
               	and	x2, x1, x17
               	cmp	w2, #0x30
               	b.ne	<addr>
               	mov	x17, #0x2               // =2
               	orr	x0, x0, x17
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	and	x2, x1, x17
               	cbnz	x2, <addr>
               	mov	x17, #0x4               // =4
               	orr	x0, x0, x17
               	mov	x17, #0xf0f             // =3855
               	movk	x17, #0xf0f, lsl #16
               	and	x1, x1, x17
               	cbz	x1, <addr>
               	mov	x17, #0x8               // =8
               	orr	x0, x0, x17
               	sxtw	x0, w0
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>

<update>:
               	mov	w2, w1
               	mov	x17, #0x1f              // =31
               	and	x3, x2, x17
               	ldr	w4, [x0]
               	mov	x17, #0xff07            // =65287
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x4, x4, x17
               	lsl	x3, x3, #3
               	orr	x3, x4, x3
               	str	w3, [x0]
               	ldr	w3, [x0]
               	asr	x3, x3, #16
               	eor	x1, x3, x2
               	mov	x17, #0xffff            // =65535
               	and	x1, x1, x17
               	ldr	w2, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x2, x2, x17
               	lsl	x1, x1, #16
               	orr	x1, x2, x1
               	str	w1, [x0]
               	ldr	w1, [x0]
               	mov	x17, #0x7               // =7
               	and	x1, x1, x17
               	ldr	w2, [x0]
               	asr	x2, x2, #3
               	mov	x17, #0x1f              // =31
               	and	x2, x2, x17
               	add	x1, x1, x2
               	ldr	w2, [x0]
               	asr	x2, x2, #8
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	add	x1, x1, x2
               	ldr	w0, [x0]
               	asr	x0, x0, #16
               	add	x0, x1, x0
               	sxtw	x0, w0
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x60]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	mov	x22, #0x0               // =0
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sxtw	x1, w22
               	ldr	x20, [x0, x1, lsl #3]
               	mov	w21, w20
               	mov	x0, x20
               	bl	<addr>
               	mov	x23, x0
               	mov	x1, #0xff               // =255
               	mov	x0, x20
               	bl	<addr>
               	cmp	x23, x0
               	b.ne	<addr>
               	mov	x0, x20
               	bl	<addr>
               	mov	x23, x0
               	mov	x1, #0xf0f0             // =61680
               	movk	x1, #0xf0f0, lsl #16
               	movk	x1, #0xf0f0, lsl #32
               	movk	x1, #0xf0f0, lsl #48
               	mov	x0, x20
               	bl	<addr>
               	cmp	x23, x0
               	b.ne	<addr>
               	mov	x0, x20
               	bl	<addr>
               	mov	x23, x0
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	mov	x0, x20
               	bl	<addr>
               	cmp	x23, x0
               	b.ne	<addr>
               	mov	x0, x20
               	bl	<addr>
               	mov	x23, x0
               	mov	x1, #0xfff0             // =65520
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	mov	x0, x20
               	bl	<addr>
               	cmp	x23, x0
               	b.ne	<addr>
               	mov	x0, x20
               	bl	<addr>
               	mov	x23, x0
               	mov	x1, #0xff               // =255
               	movk	x1, #0xff00, lsl #48
               	mov	x0, x20
               	bl	<addr>
               	cmp	x23, x0
               	b.ne	<addr>
               	mov	x0, x20
               	bl	<addr>
               	mov	x23, x0
               	mov	x1, #0x5555             // =21845
               	movk	x1, #0x5555, lsl #16
               	movk	x1, #0x5555, lsl #32
               	movk	x1, #0x5555, lsl #48
               	mov	x0, x20
               	bl	<addr>
               	cmp	x23, x0
               	b.ne	<addr>
               	mov	x0, x20
               	bl	<addr>
               	mov	x23, x0
               	mov	x1, #0x7777             // =30583
               	movk	x1, #0x7777, lsl #16
               	movk	x1, #0x7777, lsl #32
               	movk	x1, #0x7777, lsl #48
               	mov	x0, x20
               	bl	<addr>
               	cmp	x23, x0
               	b.ne	<addr>
               	mov	x0, x20
               	bl	<addr>
               	mov	x23, x0
               	mov	x1, #0xff               // =255
               	movk	x1, #0xff, lsl #16
               	movk	x1, #0xff, lsl #32
               	movk	x1, #0xff, lsl #48
               	mov	x0, x20
               	bl	<addr>
               	cmp	x23, x0
               	b.ne	<addr>
               	mov	x0, x20
               	bl	<addr>
               	mov	x23, x0
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #32
               	mov	x0, x20
               	bl	<addr>
               	cmp	x23, x0
               	b.ne	<addr>
               	mov	x0, x20
               	bl	<addr>
               	mov	x23, x0
               	mov	x1, #0xfff00000         // =4293918720
               	movk	x1, #0xfff, lsl #32
               	mov	x0, x20
               	bl	<addr>
               	cmp	x23, x0
               	b.ne	<addr>
               	mov	x0, x21
               	bl	<addr>
               	mov	x23, x0
               	mov	x1, #0xf0f              // =3855
               	movk	x1, #0xf0f, lsl #16
               	mov	x0, x21
               	bl	<addr>
               	cmp	x23, x0
               	b.ne	<addr>
               	mov	x0, x21
               	bl	<addr>
               	mov	x23, x0
               	mov	x1, #0x80000000         // =2147483648
               	mov	x0, x21
               	bl	<addr>
               	cmp	x23, x0
               	b.ne	<addr>
               	mov	x0, x21
               	bl	<addr>
               	mov	x23, x0
               	mov	x1, #0xff               // =255
               	movk	x1, #0xff, lsl #16
               	mov	x0, x21
               	bl	<addr>
               	cmp	x23, x0
               	b.ne	<addr>
               	mov	x0, x21
               	bl	<addr>
               	mov	x23, x0
               	mov	x1, #0xff00             // =65280
               	movk	x1, #0xffff, lsl #16
               	mov	x0, x21
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x23, x0
               	b.ne	<addr>
               	mov	x0, x21
               	bl	<addr>
               	mov	x23, x0
               	mov	x1, #0x5555             // =21845
               	movk	x1, #0x5555, lsl #16
               	mov	x0, x21
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x23, x0
               	b.ne	<addr>
               	mov	x0, x21
               	bl	<addr>
               	mov	x23, x0
               	mov	x1, #0x3333             // =13107
               	movk	x1, #0x3333, lsl #16
               	mov	x0, x21
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x23, x0
               	b.ne	<addr>
               	mov	x0, x20
               	bl	<addr>
               	mov	x21, x0
               	mov	x1, #0x1234             // =4660
               	mov	x0, x20
               	bl	<addr>
               	cmp	x21, x0
               	b.ne	<addr>
               	mov	x0, x20
               	bl	<addr>
               	mov	x21, x0
               	mov	x1, #0x5678             // =22136
               	movk	x1, #0x1234, lsl #16
               	mov	x0, x20
               	bl	<addr>
               	cmp	x21, x0
               	b.ne	<addr>
               	mov	x0, x20
               	bl	<addr>
               	mov	x21, x0
               	mov	x1, #0x5                // =5
               	mov	x0, x20
               	bl	<addr>
               	cmp	x21, x0
               	b.ne	<addr>
               	mov	x0, x20
               	bl	<addr>
               	mov	x2, x0
               	mov	x0, #0x40               // =64
               	stur	x0, [x29, #-0x28]
               	mov	x0, #0xf0               // =240
               	stur	x0, [x29, #-0x20]
               	mov	x0, #-0x8000000000000000 // =-9223372036854775808
               	stur	x0, [x29, #-0x18]
               	mov	x0, #0xf0f              // =3855
               	movk	x0, #0xf0f, lsl #16
               	stur	w0, [x29, #-0x10]
               	mov	x0, #0x0                // =0
               	ldur	x1, [x29, #-0x28]
               	and	x1, x20, x1
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	ldur	x1, [x29, #-0x20]
               	and	x1, x20, x1
               	cmp	x1, #0x30
               	b.ne	<addr>
               	mov	x17, #0x2               // =2
               	orr	x0, x0, x17
               	ldur	x1, [x29, #-0x18]
               	and	x1, x20, x1
               	cbnz	x1, <addr>
               	mov	x17, #0x4               // =4
               	orr	x0, x0, x17
               	mov	w1, w20
               	ldur	w3, [x29, #-0x10]
               	and	x1, x1, x3
               	cbz	x1, <addr>
               	mov	x17, #0x8               // =8
               	orr	x0, x0, x17
               	sxtw	x0, w0
               	cmp	x2, x0
               	b.eq	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	sxtw	x0, w22
               	add	x22, x0, #0x1
               	cmp	w22, #0x8
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x8                // =8
               	mov	x0, x20
               	bl	<addr>
               	mov	x5, x0
               	mov	x0, #0xff00             // =65280
               	movk	x0, #0xff00, lsl #16
               	movk	x0, #0xff00, lsl #32
               	movk	x0, #0xff00, lsl #48
               	stur	x0, [x29, #-0x28]
               	mov	x0, #0x10               // =16
               	stur	x0, [x29, #-0x20]
               	mov	x0, #0x1234             // =4660
               	stur	x0, [x29, #-0x18]
               	mov	x1, #0x1                // =1
               	mov	x0, #0x0                // =0
               	b	<addr>
               	ror	x1, x1, #0x39
               	sxtw	x2, w0
               	ldr	x3, [x20, x2, lsl #3]
               	ldur	x4, [x29, #-0x28]
               	and	x3, x3, x4
               	eor	x1, x1, x3
               	ldur	x3, [x29, #-0x20]
               	orr	x1, x1, x3
               	ldr	x3, [x20, x2, lsl #3]
               	ldur	x4, [x29, #-0x18]
               	and	x3, x3, x4
               	eor	x1, x1, x3
               	add	x0, x2, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	cmp	x5, x1
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0xcdef             // =52719
               	movk	x0, #0x89ab, lsl #16
               	movk	x0, #0x4567, lsl #32
               	movk	x0, #0x123, lsl #48
               	bl	<addr>
               	cmp	x0, #0xef
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0xcdef             // =52719
               	movk	x0, #0x89ab, lsl #16
               	movk	x0, #0x4567, lsl #32
               	movk	x0, #0x123, lsl #48
               	bl	<addr>
               	mov	x17, #0xfdff            // =65023
               	movk	x17, #0xf9fb, lsl #16
               	movk	x17, #0xf5f7, lsl #32
               	movk	x17, #0xf1f3, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0xcdef             // =52719
               	movk	x0, #0x89ab, lsl #16
               	movk	x0, #0x4567, lsl #32
               	movk	x0, #0x123, lsl #48
               	bl	<addr>
               	mov	x17, #0xcdef            // =52719
               	movk	x17, #0x89ab, lsl #16
               	movk	x17, #0x4567, lsl #32
               	movk	x17, #0x8123, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x18               // =24
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0xcdef             // =52719
               	movk	x0, #0x89ab, lsl #16
               	bl	<addr>
               	mov	x17, #0xd0f             // =3343
               	movk	x17, #0x90b, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x19               // =25
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
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
               	mov	x1, #0x2345             // =9029
               	movk	x1, #0x1, lsl #16
               	stur	w1, [x29, #-0x30]
               	ldur	w1, [x29, #-0x30]
               	bl	<addr>
               	mov	x2, x0
               	sub	x0, x29, #0x8
               	ldr	w1, [x0]
               	mov	x17, #0x7               // =7
               	and	x1, x1, x17
               	cmp	w1, #0x5
               	b.ne	<addr>
               	ldr	w1, [x0]
               	asr	x1, x1, #3
               	mov	x17, #0x1f              // =31
               	and	x1, x1, x17
               	cmp	w1, #0x5
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldr	w1, [x0]
               	asr	x1, x1, #8
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	cmp	w1, #0xc8
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldr	w1, [x0]
               	asr	x1, x1, #16
               	mov	x17, #0x9daa            // =40362
               	cmp	w1, w17
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x1a               // =26
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	w3, w2
               	ldr	w1, [x0]
               	mov	x17, #0x7               // =7
               	and	x2, x1, x17
               	asr	x4, x1, #3
               	mov	x17, #0x1f              // =31
               	and	x4, x4, x17
               	add	x2, x2, x4
               	asr	x1, x1, #8
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	add	x1, x2, x1
               	ldr	w0, [x0]
               	asr	x0, x0, #16
               	add	x0, x1, x0
               	eor	x0, x3, x0
               	cbz	x0, <addr>
               	mov	x0, #0x1b               // =27
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x2a               // =42
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x14               // =20
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x13               // =19
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x12               // =18
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x11               // =17
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x10               // =16
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0xf                // =15
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
