
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
               	stur	w1, [x29, #-0x8]
               	ldur	w1, [x29, #-0x8]
               	and	x0, x0, x1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<ref_or32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	w1, [x29, #-0x8]
               	ldur	w1, [x29, #-0x8]
               	orr	x0, x0, x1
               	mov	w0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<ref_xor32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	w1, [x29, #-0x8]
               	ldur	w1, [x29, #-0x8]
               	eor	x0, x0, x1
               	mov	w0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<and_e64>:
               	and	x0, x0, #0xff
               	ret

<or_e8>:
               	orr	x0, x0, #0xf0f0f0f0f0f0f0f0
               	ret

<xor_top>:
               	eor	x0, x0, #0x8000000000000000
               	ret

<and_align>:
               	and	x0, x0, #0xfffffffffffffff0
               	ret

<or_wrap>:
               	orr	x0, x0, #0xff000000000000ff
               	ret

<xor_e2>:
               	eor	x0, x0, #0x5555555555555555
               	ret

<and_e4>:
               	and	x0, x0, #0x7777777777777777
               	ret

<and_e16>:
               	and	x0, x0, #0xff00ff00ff00ff
               	ret

<or_e32>:
               	orr	x0, x0, #0xffff0000ffff
               	ret

<xor_run>:
               	eor	x0, x0, #0xffffff00000
               	ret

<and32_e8>:
               	and	w0, w0, #0xf0f0f0f
               	ret

<or32_top>:
               	orr	x0, x0, #0x80000000
               	mov	w0, w0
               	ret

<xor32_e16>:
               	eor	w0, w0, #0xff00ff
               	mov	w0, w0
               	ret

<and32_neg>:
               	and	x0, x0, #0xffffffffffffff00
               	sxtw	x0, w0
               	ret

<xor32_e2>:
               	eor	w0, w0, #0x55555555
               	sxtw	x0, w0
               	ret

<or32_e4>:
               	orr	w0, w0, #0x33333333
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
               	mov	x4, x0
               	mov	x0, #0x1                // =1
               	mov	x2, #0x0                // =0
               	mov	x5, #0x1234             // =4660
               	cmp	w2, w1
               	b.ge	<addr>
               	ror	x0, x0, #0x39
               	ldr	x3, [x4, x2, lsl #3]
               	and	x6, x3, #0xff00ff00ff00ff00
               	eor	x0, x0, x6
               	orr	x0, x0, #0x10
               	and	x3, x3, x5
               	eor	x0, x0, x3
               	add	x2, x2, #0x1
               	cmp	w2, w1
               	b.lt	<addr>
               	ret

<classify>:
               	mov	x1, x0
               	mov	x0, #0x0                // =0
               	tbz	w1, #0x6, <addr>
               	mov	x0, #0x1                // =1
               	and	x2, x1, #0xf0
               	cmp	w2, #0x30
               	b.ne	<addr>
               	orr	x0, x0, #0x2
               	tbnz	x1, #0x3f, <addr>
               	orr	x0, x0, #0x4
               	and	w1, w1, #0xf0f0f0f
               	cbz	x1, <addr>
               	orr	x0, x0, #0x8
               	ret

<update>:
               	and	x2, x1, #0x1f
               	ldr	w3, [x0]
               	and	x3, x3, #0xffffffffffffff07
               	lsl	x2, x2, #3
               	orr	x2, x3, x2
               	str	w2, [x0]
               	ldr	w2, [x0]
               	asr	x2, x2, #16
               	eor	x1, x2, x1
               	and	x1, x1, #0xffff
               	ldr	w2, [x0]
               	and	x2, x2, #0xffffffff0000ffff
               	lsl	x1, x1, #16
               	orr	x1, x2, x1
               	str	w1, [x0]
               	ldr	w1, [x0]
               	and	x1, x1, #0x7
               	ldr	w2, [x0]
               	asr	x2, x2, #3
               	and	x2, x2, #0x1f
               	add	x1, x1, x2
               	ldr	w2, [x0]
               	asr	x2, x2, #8
               	and	x2, x2, #0xff
               	add	x1, x1, x2
               	ldr	w0, [x0]
               	asr	x0, x0, #16
               	add	x0, x1, x0
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x60]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	mov	x21, #0x0               // =0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x20, [x0, x21, lsl #3]
               	mov	x0, x20
               	bl	<addr>
               	mov	x22, x0
               	mov	x1, #0xff               // =255
               	mov	x0, x20
               	bl	<addr>
               	cmp	x22, x0
               	b.ne	<addr>
               	mov	x0, x20
               	bl	<addr>
               	mov	x22, x0
               	mov	x1, #-0xf0f0f0f0f0f0f10 // =-1085102592571150096
               	mov	x0, x20
               	bl	<addr>
               	cmp	x22, x0
               	b.ne	<addr>
               	mov	x0, x20
               	bl	<addr>
               	mov	x22, x0
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	mov	x0, x20
               	bl	<addr>
               	cmp	x22, x0
               	b.ne	<addr>
               	mov	x0, x20
               	bl	<addr>
               	mov	x22, x0
               	mov	x1, #-0x10              // =-16
               	mov	x0, x20
               	bl	<addr>
               	cmp	x22, x0
               	b.ne	<addr>
               	mov	x0, x20
               	bl	<addr>
               	mov	x22, x0
               	mov	x1, #-0xffffffffffff01  // =-72057594037927681
               	mov	x0, x20
               	bl	<addr>
               	cmp	x22, x0
               	b.ne	<addr>
               	mov	x0, x20
               	bl	<addr>
               	mov	x22, x0
               	mov	x1, #0x5555555555555555 // =6148914691236517205
               	mov	x0, x20
               	bl	<addr>
               	cmp	x22, x0
               	b.ne	<addr>
               	mov	x0, x20
               	bl	<addr>
               	mov	x22, x0
               	mov	x1, #0x7777777777777777 // =8608480567731124087
               	mov	x0, x20
               	bl	<addr>
               	cmp	x22, x0
               	b.ne	<addr>
               	mov	x0, x20
               	bl	<addr>
               	mov	x22, x0
               	mov	x1, #0xff00ff00ff00ff   // =71777214294589695
               	mov	x0, x20
               	bl	<addr>
               	cmp	x22, x0
               	b.ne	<addr>
               	mov	x0, x20
               	bl	<addr>
               	mov	x22, x0
               	mov	x1, #0xffff0000ffff     // =281470681808895
               	mov	x0, x20
               	bl	<addr>
               	cmp	x22, x0
               	b.ne	<addr>
               	mov	x0, x20
               	bl	<addr>
               	mov	x22, x0
               	mov	x1, #0xffffff00000      // =17592184995840
               	mov	x0, x20
               	bl	<addr>
               	cmp	x22, x0
               	b.ne	<addr>
               	mov	w22, w20
               	mov	x0, x22
               	bl	<addr>
               	mov	x23, x0
               	mov	x1, #0xf0f              // =3855
               	movk	x1, #0xf0f, lsl #16
               	mov	x0, x22
               	bl	<addr>
               	cmp	x23, x0
               	b.ne	<addr>
               	mov	x0, x22
               	bl	<addr>
               	mov	x23, x0
               	mov	x1, #0x80000000         // =2147483648
               	mov	x0, x22
               	bl	<addr>
               	cmp	x23, x0
               	b.ne	<addr>
               	mov	x0, x22
               	bl	<addr>
               	mov	x23, x0
               	mov	w22, w20
               	mov	x1, #0xff               // =255
               	movk	x1, #0xff, lsl #16
               	mov	x0, x22
               	bl	<addr>
               	cmp	x23, x0
               	b.ne	<addr>
               	mov	x0, x20
               	bl	<addr>
               	mov	x23, x0
               	mov	x1, #0xffffff00         // =4294967040
               	mov	x0, x22
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x23, x0
               	b.ne	<addr>
               	mov	x0, x20
               	bl	<addr>
               	mov	x23, x0
               	mov	x1, #0x5555             // =21845
               	movk	x1, #0x5555, lsl #16
               	mov	x0, x22
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x23, x0
               	b.ne	<addr>
               	mov	x0, x20
               	bl	<addr>
               	mov	x23, x0
               	mov	x1, #0x3333             // =13107
               	movk	x1, #0x3333, lsl #16
               	mov	x0, x22
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x23, x0
               	b.ne	<addr>
               	mov	x0, x20
               	bl	<addr>
               	mov	x22, x0
               	mov	x1, #0x1234             // =4660
               	mov	x0, x20
               	bl	<addr>
               	cmp	x22, x0
               	b.ne	<addr>
               	mov	x0, x20
               	bl	<addr>
               	mov	x22, x0
               	mov	x1, #0x5678             // =22136
               	movk	x1, #0x1234, lsl #16
               	mov	x0, x20
               	bl	<addr>
               	cmp	x22, x0
               	b.ne	<addr>
               	mov	x0, x20
               	bl	<addr>
               	mov	x22, x0
               	mov	x1, #0x5                // =5
               	mov	x0, x20
               	bl	<addr>
               	cmp	x22, x0
               	b.ne	<addr>
               	mov	x0, x20
               	bl	<addr>
               	mov	x1, #0x40               // =64
               	stur	x1, [x29, #-0x28]
               	mov	x1, #0xf0               // =240
               	stur	x1, [x29, #-0x20]
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	stur	x1, [x29, #-0x18]
               	mov	x1, #0xf0f              // =3855
               	movk	x1, #0xf0f, lsl #16
               	stur	w1, [x29, #-0x10]
               	mov	x1, #0x0                // =0
               	ldur	x2, [x29, #-0x28]
               	and	x2, x20, x2
               	cbz	x2, <addr>
               	mov	x1, #0x1                // =1
               	ldur	x2, [x29, #-0x20]
               	and	x2, x20, x2
               	cmp	x2, #0x30
               	b.ne	<addr>
               	orr	x1, x1, #0x2
               	ldur	x2, [x29, #-0x18]
               	and	x2, x20, x2
               	cbnz	x2, <addr>
               	orr	x1, x1, #0x4
               	mov	w2, w20
               	ldur	w3, [x29, #-0x10]
               	and	x2, x2, x3
               	cbz	x2, <addr>
               	orr	x1, x1, #0x8
               	cmp	x0, x1
               	b.ne	<addr>
               	add	x21, x21, #0x1
               	cmp	w21, #0x8
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x8                // =8
               	bl	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x1, #-0xff00ff00ff0100  // =-71777214294589696
               	stur	x1, [x29, #-0x28]
               	mov	x1, #0x10               // =16
               	stur	x1, [x29, #-0x20]
               	mov	x1, #0x1234             // =4660
               	stur	x1, [x29, #-0x18]
               	mov	x2, #0x1                // =1
               	mov	x1, #0x0                // =0
               	ror	x4, x2, #0x39
               	ldr	x2, [x3, x1, lsl #3]
               	ldur	x5, [x29, #-0x28]
               	and	x5, x2, x5
               	eor	x4, x4, x5
               	ldur	x5, [x29, #-0x20]
               	orr	x4, x4, x5
               	ldur	x5, [x29, #-0x18]
               	and	x2, x2, x5
               	eor	x2, x4, x2
               	add	x1, x1, #0x1
               	cmp	w1, #0x8
               	b.lt	<addr>
               	cmp	x0, x2
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
               	sub	x1, x29, #0x8
               	ldr	w2, [x1]
               	and	x2, x2, #0x7
               	cmp	w2, #0x5
               	b.ne	<addr>
               	ldr	w2, [x1]
               	asr	x2, x2, #3
               	and	x2, x2, #0x1f
               	cmp	w2, #0x5
               	b.ne	<addr>
               	ldr	w2, [x1]
               	asr	x2, x2, #8
               	and	x2, x2, #0xff
               	cmp	w2, #0xc8
               	b.ne	<addr>
               	ldr	w2, [x1]
               	asr	x2, x2, #16
               	mov	x17, #0x9daa            // =40362
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, #0x1a               // =26
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	ldr	w2, [x1]
               	and	x3, x2, #0x7
               	asr	x4, x2, #3
               	and	x4, x4, #0x1f
               	add	x3, x3, x4
               	asr	x2, x2, #8
               	and	x2, x2, #0xff
               	add	x2, x3, x2
               	ldr	w1, [x1]
               	asr	x1, x1, #16
               	add	x1, x2, x1
               	eor	x0, x0, x1
               	cbz	w0, <addr>
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
