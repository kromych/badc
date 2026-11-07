
inline_byte_access_leaf.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x80
               	mov	x0, #0x0                // =0
               	mov	x1, #0x7                // =7
               	mov	x2, #0xd                // =13
               	sub	x3, x29, #0x80
               	mul	x4, x0, x1
               	add	x4, x4, #0x1
               	and	x4, x4, #0xff
               	strb	w4, [x3, x0]
               	sub	x3, x29, #0x40
               	mul	x4, x0, x2
               	add	x4, x4, #0x5
               	and	x4, x4, #0xff
               	strb	w4, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x40
               	b.lo	<addr>
               	sub	x3, x29, #0x40
               	ldr	x0, [x3]
               	rev	x0, x0
               	mov	x17, #0x5360            // =21344
               	movk	x17, #0x3946, lsl #16
               	movk	x17, #0x1f2c, lsl #32
               	movk	x17, #0x512, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	w0, [x3]
               	mov	x17, #0x1205            // =4613
               	movk	x17, #0x2c1f, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x4, x29, #0x80
               	mov	x0, #0x201              // =513
               	movk	x0, #0x403, lsl #16
               	movk	x0, #0x605, lsl #32
               	movk	x0, #0x807, lsl #48
               	str	x0, [x4]
               	ldurb	w0, [x29, #-0x80]
               	cmp	w0, #0x1
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x79]
               	cmp	w0, #0x8
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [x4]
               	rev	x0, x0
               	ldr	x1, [x3]
               	rev	x1, x1
               	ldr	w2, [x3]
               	add	x1, x1, x2
               	eor	x0, x0, x1
               	rev	x0, x0
               	str	x0, [x4]
               	ldr	x0, [x4, #0x8]
               	rev	x0, x0
               	ldr	x1, [x3, #0x8]
               	rev	x1, x1
               	ldr	w2, [x3, #0x4]
               	add	x1, x1, x2
               	eor	x0, x0, x1
               	rev	x0, x0
               	str	x0, [x4, #0x8]
               	ldr	x0, [x4, #0x10]
               	rev	x0, x0
               	ldr	x1, [x3, #0x10]
               	rev	x1, x1
               	ldr	w2, [x3, #0x8]
               	add	x1, x1, x2
               	eor	x0, x0, x1
               	rev	x0, x0
               	str	x0, [x4, #0x10]
               	ldr	x0, [x4, #0x18]
               	rev	x0, x0
               	ldr	x1, [x3, #0x18]
               	rev	x1, x1
               	ldr	w2, [x3, #0xc]
               	add	x1, x1, x2
               	eor	x0, x0, x1
               	rev	x0, x0
               	str	x0, [x4, #0x18]
               	ldr	x0, [x4, #0x20]
               	rev	x0, x0
               	ldr	x1, [x3, #0x20]
               	rev	x1, x1
               	ldr	w2, [x3, #0x10]
               	add	x1, x1, x2
               	eor	x0, x0, x1
               	rev	x0, x0
               	str	x0, [x4, #0x20]
               	ldr	x0, [x4, #0x28]
               	rev	x0, x0
               	ldr	x1, [x3, #0x28]
               	rev	x1, x1
               	ldr	w2, [x3, #0x14]
               	add	x1, x1, x2
               	eor	x0, x0, x1
               	rev	x0, x0
               	str	x0, [x4, #0x28]
               	ldr	x0, [x4, #0x30]
               	rev	x0, x0
               	ldr	x1, [x3, #0x30]
               	rev	x1, x1
               	ldr	w2, [x3, #0x18]
               	add	x1, x1, x2
               	eor	x0, x0, x1
               	rev	x0, x0
               	str	x0, [x4, #0x30]
               	ldr	x0, [x4, #0x38]
               	rev	x0, x0
               	ldr	x1, [x3, #0x38]
               	rev	x1, x1
               	ldr	w2, [x3, #0x1c]
               	add	x1, x1, x2
               	eor	x0, x0, x1
               	rev	x0, x0
               	str	x0, [x4, #0x38]
               	ldr	x0, [x4]
               	rev	x0, x0
               	mov	x17, #0x626d            // =25197
               	movk	x17, #0x6063, lsl #16
               	movk	x17, #0x1c28, lsl #32
               	movk	x17, #0x410, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x1                // =1
               	mov	x1, #0x7                // =7
               	lsl	x0, x2, #3
               	mul	x5, x0, x1
               	add	x5, x5, #0x1
               	and	x5, x5, #0xff
               	add	x6, x0, #0x1
               	mul	x6, x6, x1
               	add	x6, x6, #0x1
               	and	x6, x6, #0xff
               	orr	x5, x6, x5, lsl #8
               	add	x6, x0, #0x2
               	mul	x6, x6, x1
               	add	x6, x6, #0x1
               	and	x6, x6, #0xff
               	orr	x5, x6, x5, lsl #8
               	add	x6, x0, #0x3
               	mul	x6, x6, x1
               	add	x6, x6, #0x1
               	and	x6, x6, #0xff
               	orr	x5, x6, x5, lsl #8
               	add	x6, x0, #0x4
               	mul	x6, x6, x1
               	add	x6, x6, #0x1
               	and	x6, x6, #0xff
               	orr	x5, x6, x5, lsl #8
               	add	x6, x0, #0x5
               	mul	x6, x6, x1
               	add	x6, x6, #0x1
               	and	x6, x6, #0xff
               	orr	x5, x6, x5, lsl #8
               	add	x6, x0, #0x6
               	mul	x6, x6, x1
               	add	x6, x6, #0x1
               	and	x6, x6, #0xff
               	orr	x5, x6, x5, lsl #8
               	add	x6, x0, #0x7
               	mul	x6, x6, x1
               	add	x6, x6, #0x1
               	and	x6, x6, #0xff
               	orr	x5, x6, x5, lsl #8
               	add	x6, x3, x0
               	ldr	x6, [x6]
               	rev	x6, x6
               	add	x7, x3, x2, lsl #2
               	ldr	w7, [x7]
               	add	x0, x4, x0
               	ldr	x0, [x0]
               	rev	x0, x0
               	add	x6, x6, x7
               	eor	x5, x5, x6
               	cmp	x0, x5
               	b.ne	<addr>
               	add	x2, x2, #0x1
               	cmp	w2, #0x8
               	b.lo	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
