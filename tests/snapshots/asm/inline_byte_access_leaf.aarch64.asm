
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

<mix>:
               	add	x2, x0, #0x0
               	ldr	x2, [x2]
               	rev	x4, x2
               	add	x2, x1, #0x0
               	ldr	x2, [x2]
               	rev	x5, x2
               	add	x2, x0, #0x0
               	add	x3, x1, #0x0
               	ldr	w3, [x3]
               	mov	w3, w3
               	add	x3, x5, x3
               	eor	x3, x4, x3
               	rev	x3, x3
               	str	x3, [x2]
               	ldr	x2, [x0, #0x8]
               	rev	x3, x2
               	ldr	x2, [x1, #0x8]
               	rev	x4, x2
               	ldr	w2, [x1, #0x4]
               	mov	w2, w2
               	add	x2, x4, x2
               	eor	x2, x3, x2
               	rev	x2, x2
               	str	x2, [x0, #0x8]
               	ldr	x2, [x0, #0x10]
               	rev	x3, x2
               	ldr	x2, [x1, #0x10]
               	rev	x4, x2
               	ldr	w2, [x1, #0x8]
               	mov	w2, w2
               	add	x2, x4, x2
               	eor	x2, x3, x2
               	rev	x2, x2
               	str	x2, [x0, #0x10]
               	ldr	x2, [x0, #0x18]
               	rev	x3, x2
               	ldr	x2, [x1, #0x18]
               	rev	x4, x2
               	ldr	w2, [x1, #0xc]
               	mov	w2, w2
               	add	x2, x4, x2
               	eor	x2, x3, x2
               	rev	x2, x2
               	str	x2, [x0, #0x18]
               	ldr	x2, [x0, #0x20]
               	rev	x3, x2
               	ldr	x2, [x1, #0x20]
               	rev	x4, x2
               	ldr	w2, [x1, #0x10]
               	mov	w2, w2
               	add	x2, x4, x2
               	eor	x2, x3, x2
               	rev	x2, x2
               	str	x2, [x0, #0x20]
               	ldr	x2, [x0, #0x28]
               	rev	x3, x2
               	ldr	x2, [x1, #0x28]
               	rev	x4, x2
               	ldr	w2, [x1, #0x14]
               	mov	w2, w2
               	add	x2, x4, x2
               	eor	x2, x3, x2
               	rev	x2, x2
               	str	x2, [x0, #0x28]
               	ldr	x2, [x0, #0x30]
               	rev	x3, x2
               	ldr	x2, [x1, #0x30]
               	rev	x4, x2
               	ldr	w2, [x1, #0x18]
               	mov	w2, w2
               	add	x2, x4, x2
               	eor	x2, x3, x2
               	rev	x2, x2
               	str	x2, [x0, #0x30]
               	ldr	x2, [x0, #0x38]
               	rev	x2, x2
               	ldr	x3, [x1, #0x38]
               	rev	x3, x3
               	ldr	w1, [x1, #0x1c]
               	mov	w1, w1
               	add	x1, x3, x1
               	eor	x1, x2, x1
               	rev	x1, x1
               	str	x1, [x0, #0x38]
               	mov	x0, #0x0                // =0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x90
               	mov	x0, #0x0                // =0
               	mov	x3, #0x7                // =7
               	mov	x4, #0xd                // =13
               	mov	x1, #0xff               // =255
               	b	<addr>
               	sub	x5, x29, #0x80
               	mov	w2, w0
               	add	x5, x5, x2
               	mul	x2, x2, x3
               	mov	w2, w2
               	add	x2, x2, #0x1
               	and	x2, x2, x1
               	strb	w2, [x5]
               	sub	x5, x29, #0x40
               	mov	w2, w0
               	add	x5, x5, x2
               	mul	x2, x2, x4
               	mov	w2, w2
               	add	x2, x2, #0x5
               	and	x2, x2, x1
               	strb	w2, [x5]
               	mov	w0, w0
               	add	x0, x0, #0x1
               	mov	w2, w0
               	cmp	x2, #0x40
               	b.lo	<addr>
               	sub	x0, x29, #0x40
               	ldr	x0, [x0]
               	rev	x0, x0
               	mov	x17, #0x5360            // =21344
               	movk	x17, #0x3946, lsl #16
               	movk	x17, #0x1f2c, lsl #32
               	movk	x17, #0x512, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x40
               	ldr	w0, [x0]
               	mov	w0, w0
               	mov	x17, #0x1205            // =4613
               	movk	x17, #0x2c1f, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x80
               	mov	x1, #0x201              // =513
               	movk	x1, #0x403, lsl #16
               	movk	x1, #0x605, lsl #32
               	movk	x1, #0x807, lsl #48
               	str	x1, [x0]
               	sub	x0, x29, #0x80
               	ldr	x0, [x0]
               	rev	x0, x0
               	mov	x17, #0x708             // =1800
               	movk	x17, #0x506, lsl #16
               	movk	x17, #0x304, lsl #32
               	movk	x17, #0x102, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x80
               	ldrb	w0, [x0]
               	mov	x17, #0x1               // =1
               	eor	x0, x0, x17
               	mov	w1, w0
               	cmp	x1, #0x0
               	cset	x0, ne
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x80
               	ldrb	w0, [x0, #0x7]
               	mov	x17, #0x8               // =8
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x80
               	sub	x1, x29, #0x40
               	bl	<addr>
               	sub	x0, x29, #0x80
               	ldr	x0, [x0]
               	rev	x0, x0
               	mov	x17, #0x626d            // =25197
               	movk	x17, #0x6063, lsl #16
               	movk	x17, #0x1c28, lsl #32
               	movk	x17, #0x410, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	mov	x1, #0x7                // =7
               	mov	x2, #0xff               // =255
               	b	<addr>
               	mov	w3, w0
               	lsl	x3, x3, #3
               	mov	w3, w3
               	mul	x3, x3, x1
               	mov	w3, w3
               	add	x3, x3, #0x1
               	and	x3, x3, x2
               	lsl	x4, x3, #8
               	mov	w3, w0
               	lsl	x3, x3, #3
               	mov	w3, w3
               	add	x3, x3, #0x1
               	mov	w3, w3
               	mul	x3, x3, x1
               	mov	w3, w3
               	add	x3, x3, #0x1
               	and	x3, x3, x2
               	orr	x3, x4, x3
               	lsl	x4, x3, #8
               	mov	w3, w0
               	lsl	x3, x3, #3
               	mov	w3, w3
               	add	x3, x3, #0x2
               	mov	w3, w3
               	mul	x3, x3, x1
               	mov	w3, w3
               	add	x3, x3, #0x1
               	and	x3, x3, x2
               	orr	x3, x4, x3
               	lsl	x4, x3, #8
               	mov	w3, w0
               	lsl	x3, x3, #3
               	mov	w3, w3
               	add	x3, x3, #0x3
               	mov	w3, w3
               	mul	x3, x3, x1
               	mov	w3, w3
               	add	x3, x3, #0x1
               	and	x3, x3, x2
               	orr	x3, x4, x3
               	lsl	x4, x3, #8
               	mov	w3, w0
               	lsl	x3, x3, #3
               	mov	w3, w3
               	add	x3, x3, #0x4
               	mov	w3, w3
               	mul	x3, x3, x1
               	mov	w3, w3
               	add	x3, x3, #0x1
               	and	x3, x3, x2
               	orr	x3, x4, x3
               	lsl	x4, x3, #8
               	mov	w3, w0
               	lsl	x3, x3, #3
               	mov	w3, w3
               	add	x3, x3, #0x5
               	mov	w3, w3
               	mul	x3, x3, x1
               	mov	w3, w3
               	add	x3, x3, #0x1
               	and	x3, x3, x2
               	orr	x3, x4, x3
               	lsl	x4, x3, #8
               	mov	w3, w0
               	lsl	x3, x3, #3
               	mov	w3, w3
               	add	x3, x3, #0x6
               	mov	w3, w3
               	mul	x3, x3, x1
               	mov	w3, w3
               	add	x3, x3, #0x1
               	and	x3, x3, x2
               	orr	x3, x4, x3
               	lsl	x4, x3, #8
               	mov	w3, w0
               	lsl	x3, x3, #3
               	mov	w3, w3
               	add	x3, x3, #0x7
               	mov	w3, w3
               	mul	x3, x3, x1
               	mov	w3, w3
               	add	x3, x3, #0x1
               	and	x3, x3, x2
               	orr	x3, x4, x3
               	sub	x4, x29, #0x40
               	mov	w5, w0
               	lsl	x5, x5, #3
               	mov	w5, w5
               	add	x4, x4, x5
               	ldr	x4, [x4]
               	rev	x7, x4
               	sub	x4, x29, #0x40
               	mov	w5, w0
               	lsl	x5, x5, #2
               	mov	w5, w5
               	add	x4, x4, x5
               	ldr	w4, [x4]
               	mov	w4, w4
               	sub	x5, x29, #0x80
               	mov	w6, w0
               	lsl	x6, x6, #3
               	mov	w6, w6
               	add	x5, x5, x6
               	ldr	x5, [x5]
               	rev	x5, x5
               	mov	w4, w4
               	add	x4, x7, x4
               	eor	x3, x3, x4
               	cmp	x5, x3
               	b.ne	<addr>
               	mov	w0, w0
               	add	x0, x0, #0x1
               	mov	w3, w0
               	cmp	x3, #0x8
               	b.lo	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
