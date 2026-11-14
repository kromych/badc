
builtin_mem_transfer_inline.aarch64:	file format elf64-littleaarch64

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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x420
               	mov	x0, #0xcdef             // =52719
               	movk	x0, #0x89ab, lsl #16
               	movk	x0, #0x4567, lsl #32
               	movk	x0, #0x123, lsl #48
               	mov	x1, #0x3210             // =12816
               	movk	x1, #0x7654, lsl #16
               	movk	x1, #0xba98, lsl #32
               	movk	x1, #0xfedc, lsl #48
               	str	x0, [sp, #0x8]
               	str	x1, [sp, #0x10]
               	mov	x0, #0xbeef             // =48879
               	movk	x0, #0xdead, lsl #16
               	movk	x0, #0x5a, lsl #32
               	str	x0, [sp, #0x18]
               	ldr	w0, [sp, #0x18]
               	mov	x17, #0xbeef            // =48879
               	movk	x17, #0xdead, lsl #16
               	cmp	w0, w17
               	b.ne	<addr>
               	ldrb	w0, [sp, #0x1c]
               	cmp	w0, #0x5a
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x420
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x1, x0, #0x1
               	mov	x2, #0x3344             // =13124
               	movk	x2, #0x1122, lsl #16
               	stur	w2, [x29, #-0x8]
               	sub	x3, x29, #0x8
               	str	w2, [x1]
               	add	x2, x0, #0x8
               	mov	x4, #0x3345             // =13125
               	movk	x4, #0x1122, lsl #16
               	stur	w4, [x29, #-0x8]
               	str	w4, [x2]
               	add	x5, x0, #0xf
               	mov	x4, #0x3346             // =13126
               	movk	x4, #0x1122, lsl #16
               	stur	w4, [x29, #-0x8]
               	str	w4, [x5]
               	add	x5, x0, #0x16
               	mov	x4, #0x3347             // =13127
               	movk	x4, #0x1122, lsl #16
               	stur	w4, [x29, #-0x8]
               	str	w4, [x5]
               	add	x4, x0, #0x1d
               	mov	x0, #0x3348             // =13128
               	movk	x0, #0x1122, lsl #16
               	stur	w0, [x29, #-0x8]
               	str	w0, [x4]
               	ldr	w16, [x1]
               	str	w16, [x3]
               	ldur	w0, [x29, #-0x8]
               	mov	x17, #0x3344            // =13124
               	movk	x17, #0x1122, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x420
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	w16, [x2]
               	str	w16, [x3]
               	ldur	w0, [x29, #-0x8]
               	mov	x17, #0x3345            // =13125
               	movk	x17, #0x1122, lsl #16
               	cmp	w0, w17
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x2, x0, #0xf
               	sub	x1, x29, #0x8
               	ldr	w16, [x2]
               	str	w16, [x1]
               	ldur	w2, [x29, #-0x8]
               	mov	x17, #0x3346            // =13126
               	movk	x17, #0x1122, lsl #16
               	cmp	w2, w17
               	b.ne	<addr>
               	add	x2, x0, #0x16
               	ldr	w16, [x2]
               	str	w16, [x1]
               	ldur	w2, [x29, #-0x8]
               	mov	x17, #0x3347            // =13127
               	movk	x17, #0x1122, lsl #16
               	cmp	w2, w17
               	b.ne	<addr>
               	add	x2, x0, #0x1d
               	ldr	w16, [x2]
               	str	w16, [x1]
               	ldur	w1, [x29, #-0x8]
               	mov	x17, #0x3348            // =13128
               	movk	x17, #0x1122, lsl #16
               	cmp	w1, w17
               	b.ne	<addr>
               	ldrb	w1, [sp, #0x1c]
               	strb	w1, [x0]
               	strb	w1, [x0, #0x1]
               	strb	w1, [x0, #0x2]
               	strb	w1, [x0, #0x3]
               	strb	w1, [x0, #0x4]
               	strb	w1, [x0, #0x5]
               	strb	w1, [x0, #0x6]
               	strb	w1, [x0, #0x7]
               	strb	w1, [x0, #0x8]
               	strb	w1, [x0, #0x9]
               	strb	w1, [x0, #0xa]
               	strb	w1, [x0, #0xb]
               	strb	w1, [x0, #0xc]
               	strb	w1, [x0, #0xd]
               	strb	w1, [x0, #0xe]
               	strb	w1, [x0, #0xf]
               	ldrb	w1, [x0]
               	cmp	w1, #0x5a
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x420
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w1, [x0, #0x1]
               	cmp	w1, #0x5a
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x2]
               	cmp	w1, #0x5a
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x3]
               	cmp	w1, #0x5a
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x4]
               	cmp	w1, #0x5a
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x5]
               	cmp	w1, #0x5a
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x6]
               	cmp	w1, #0x5a
               	b.ne	<addr>
               	ldrb	w0, [x0, #0x7]
               	cmp	w0, #0x5a
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w0, [x1, #0x8]
               	cmp	w0, #0x5a
               	b.ne	<addr>
               	ldrb	w0, [x1, #0x9]
               	cmp	w0, #0x5a
               	b.ne	<addr>
               	ldrb	w0, [x1, #0xa]
               	cmp	w0, #0x5a
               	b.ne	<addr>
               	ldrb	w0, [x1, #0xb]
               	cmp	w0, #0x5a
               	b.ne	<addr>
               	ldrb	w0, [x1, #0xc]
               	cmp	w0, #0x5a
               	b.ne	<addr>
               	ldrb	w0, [x1, #0xd]
               	cmp	w0, #0x5a
               	b.ne	<addr>
               	ldrb	w0, [x1, #0xe]
               	cmp	w0, #0x5a
               	b.ne	<addr>
               	ldrb	w0, [x1, #0xf]
               	cmp	w0, #0x5a
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	strb	w0, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x0, x1, #0x4
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w1, [x0, #0x4]
               	cbz	w1, <addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x420
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w1, [x0, #0x5]
               	cmp	w1, #0x1
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x6]
               	cmp	w1, #0x2
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x7]
               	cmp	w1, #0x3
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x8]
               	cmp	w1, #0x4
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x9]
               	cmp	w1, #0x5
               	b.ne	<addr>
               	ldrb	w1, [x0, #0xa]
               	cmp	w1, #0x6
               	b.ne	<addr>
               	ldrb	w1, [x0, #0xb]
               	cmp	w1, #0x7
               	b.ne	<addr>
               	ldrb	w1, [x0, #0xc]
               	cmp	w1, #0x8
               	b.ne	<addr>
               	ldrb	w1, [x0, #0xd]
               	cmp	w1, #0x9
               	b.ne	<addr>
               	ldrb	w1, [x0, #0xe]
               	cmp	w1, #0xa
               	b.ne	<addr>
               	ldrb	w1, [x0, #0xf]
               	cmp	w1, #0xb
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x10]
               	cmp	w1, #0xc
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x11]
               	cmp	w1, #0xd
               	b.ne	<addr>
               	ldrb	w0, [x0, #0x12]
               	cmp	w0, #0xe
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w0, [x1, #0x13]
               	cmp	w0, #0xf
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	strb	w0, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x1, x0, #0x4
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w1, [x0]
               	cmp	w1, #0x4
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x420
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w1, [x0, #0x1]
               	cmp	w1, #0x5
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x2]
               	cmp	w1, #0x6
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x3]
               	cmp	w1, #0x7
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x4]
               	cmp	w1, #0x8
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x5]
               	cmp	w1, #0x9
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x6]
               	cmp	w1, #0xa
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x7]
               	cmp	w1, #0xb
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x8]
               	cmp	w1, #0xc
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x9]
               	cmp	w1, #0xd
               	b.ne	<addr>
               	ldrb	w1, [x0, #0xa]
               	cmp	w1, #0xe
               	b.ne	<addr>
               	ldrb	w1, [x0, #0xb]
               	cmp	w1, #0xf
               	b.ne	<addr>
               	ldrb	w1, [x0, #0xc]
               	cmp	w1, #0x10
               	b.ne	<addr>
               	ldrb	w1, [x0, #0xd]
               	cmp	w1, #0x11
               	b.ne	<addr>
               	ldrb	w0, [x0, #0xe]
               	cmp	w0, #0x12
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0, #0xf]
               	cmp	w0, #0x13
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x400
               	add	x2, x0, x0, lsl #1
               	and	x2, x2, #0xff
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x200
               	b.lt	<addr>
               	sub	x0, x29, #0x200
               	sub	x1, x29, #0x400
               	mov	x2, #0x200              // =512
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x200
               	ldrb	w1, [x1, x0]
               	add	x2, x0, x0, lsl #1
               	and	x2, x2, #0xff
               	cmp	w1, w2
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x200
               	b.lt	<addr>
               	mov	x2, #0x18               // =24
               	sub	x0, x29, #0x200
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x200
               	ldrb	w1, [x1, x0]
               	cbnz	w1, <addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lo	<addr>
               	ldrb	w0, [sp, #0x238]
               	cmp	w0, #0x48
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x420
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0xcdef             // =52719
               	movk	x1, #0x89ab, lsl #16
               	movk	x1, #0x4567, lsl #32
               	movk	x1, #0x123, lsl #48
               	str	x1, [sp, #0x8]
               	mov	x2, #0x3210             // =12816
               	movk	x2, #0x7654, lsl #16
               	movk	x2, #0xba98, lsl #32
               	movk	x2, #0xfedc, lsl #48
               	str	x2, [sp, #0x10]
               	mov	x0, #0xbeef             // =48879
               	movk	x0, #0xdead, lsl #16
               	movk	x0, #0x5a, lsl #32
               	str	x0, [sp, #0x18]
               	mov	x0, #0x0                // =0
               	str	x0, [sp, #0x8]
               	str	x0, [sp, #0x10]
               	str	x0, [sp, #0x18]
               	str	x1, [sp, #0x8]
               	str	x2, [sp, #0x10]
               	add	sp, sp, #0x420
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x420
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x420
               	ldp	x29, x30, [sp], #0x10
               	ret
