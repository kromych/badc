
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
               	ldr	x2, [x0]
               	rev	x3, x2
               	ldr	x2, [x1]
               	rev	x4, x2
               	ldr	w2, [x1]
               	add	x2, x4, x2
               	eor	x2, x3, x2
               	rev	x2, x2
               	str	x2, [x0]
               	ldr	x2, [x0, #0x8]
               	rev	x3, x2
               	ldr	x2, [x1, #0x8]
               	rev	x4, x2
               	ldr	w2, [x1, #0x4]
               	add	x2, x4, x2
               	eor	x2, x3, x2
               	rev	x2, x2
               	str	x2, [x0, #0x8]
               	ldr	x2, [x0, #0x10]
               	rev	x3, x2
               	ldr	x2, [x1, #0x10]
               	rev	x4, x2
               	ldr	w2, [x1, #0x8]
               	add	x2, x4, x2
               	eor	x2, x3, x2
               	rev	x2, x2
               	str	x2, [x0, #0x10]
               	ldr	x2, [x0, #0x18]
               	rev	x3, x2
               	ldr	x2, [x1, #0x18]
               	rev	x4, x2
               	ldr	w2, [x1, #0xc]
               	add	x2, x4, x2
               	eor	x2, x3, x2
               	rev	x2, x2
               	str	x2, [x0, #0x18]
               	ldr	x2, [x0, #0x20]
               	rev	x3, x2
               	ldr	x2, [x1, #0x20]
               	rev	x4, x2
               	ldr	w2, [x1, #0x10]
               	add	x2, x4, x2
               	eor	x2, x3, x2
               	rev	x2, x2
               	str	x2, [x0, #0x20]
               	ldr	x2, [x0, #0x28]
               	rev	x3, x2
               	ldr	x2, [x1, #0x28]
               	rev	x4, x2
               	ldr	w2, [x1, #0x14]
               	add	x2, x4, x2
               	eor	x2, x3, x2
               	rev	x2, x2
               	str	x2, [x0, #0x28]
               	ldr	x2, [x0, #0x30]
               	rev	x3, x2
               	ldr	x2, [x1, #0x30]
               	rev	x4, x2
               	ldr	w2, [x1, #0x18]
               	add	x2, x4, x2
               	eor	x2, x3, x2
               	rev	x2, x2
               	str	x2, [x0, #0x30]
               	ldr	x2, [x0, #0x38]
               	rev	x2, x2
               	ldr	x3, [x1, #0x38]
               	rev	x3, x3
               	ldr	w1, [x1, #0x1c]
               	add	x1, x3, x1
               	eor	x1, x2, x1
               	rev	x1, x1
               	str	x1, [x0, #0x38]
               	ret

<main>:
               	str	x20, [sp, #-0xa0]!
               	stp	x29, x30, [sp, #0x90]
               	add	x29, sp, #0x90
               	mov	x0, #0x0                // =0
               	mov	x3, #0x7                // =7
               	mov	x4, #0xd                // =13
               	cmp	w0, #0x40
               	b.hs	<addr>
               	sub	x1, x29, #0x80
               	mul	x2, x0, x3
               	add	x2, x2, #0x1
               	and	x2, x2, #0xff
               	strb	w2, [x1, x0]
               	sub	x1, x29, #0x40
               	mul	x2, x0, x4
               	add	x2, x2, #0x5
               	and	x2, x2, #0xff
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x40
               	b.lo	<addr>
               	sub	x20, x29, #0x40
               	ldr	x0, [x20]
               	rev	x0, x0
               	mov	x17, #0x5360            // =21344
               	movk	x17, #0x3946, lsl #16
               	movk	x17, #0x1f2c, lsl #32
               	movk	x17, #0x512, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x20, [sp], #0xa0
               	ret
               	ldr	w0, [x20]
               	mov	x17, #0x1205            // =4613
               	movk	x17, #0x2c1f, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x20, [sp], #0xa0
               	ret
               	sub	x0, x29, #0x80
               	mov	x1, #0x201              // =513
               	movk	x1, #0x403, lsl #16
               	movk	x1, #0x605, lsl #32
               	movk	x1, #0x807, lsl #48
               	str	x1, [x0]
               	rev	x1, x1
               	mov	x17, #0x708             // =1800
               	movk	x17, #0x506, lsl #16
               	movk	x17, #0x304, lsl #32
               	movk	x17, #0x102, lsl #48
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x20, [sp], #0xa0
               	ret
               	ldrb	w1, [x0]
               	eor	x1, x1, #0x1
               	cbnz	w1, <addr>
               	ldrb	w1, [x0, #0x7]
               	eor	x1, x1, #0x8
               	cbz	w1, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x20, [sp], #0xa0
               	ret
               	mov	x1, x20
               	bl	<addr>
               	sub	x4, x29, #0x80
               	ldr	x0, [x4]
               	rev	x0, x0
               	mov	x17, #0x626d            // =25197
               	movk	x17, #0x6063, lsl #16
               	movk	x17, #0x1c28, lsl #32
               	movk	x17, #0x410, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x20, [sp], #0xa0
               	ret
               	mov	x0, #0x1                // =1
               	mov	x2, #0x7                // =7
               	cmp	w0, #0x8
               	b.hs	<addr>
               	lsl	x1, x0, #3
               	mul	x3, x1, x2
               	add	x3, x3, #0x1
               	and	x3, x3, #0xff
               	lsl	x5, x3, #8
               	add	x3, x1, #0x1
               	mul	x3, x3, x2
               	add	x3, x3, #0x1
               	and	x3, x3, #0xff
               	orr	x3, x5, x3
               	lsl	x5, x3, #8
               	add	x3, x1, #0x2
               	mul	x3, x3, x2
               	add	x3, x3, #0x1
               	and	x3, x3, #0xff
               	orr	x3, x5, x3
               	lsl	x5, x3, #8
               	add	x3, x1, #0x3
               	mul	x3, x3, x2
               	add	x3, x3, #0x1
               	and	x3, x3, #0xff
               	orr	x3, x5, x3
               	lsl	x5, x3, #8
               	add	x3, x1, #0x4
               	mul	x3, x3, x2
               	add	x3, x3, #0x1
               	and	x3, x3, #0xff
               	orr	x3, x5, x3
               	lsl	x5, x3, #8
               	add	x3, x1, #0x5
               	mul	x3, x3, x2
               	add	x3, x3, #0x1
               	and	x3, x3, #0xff
               	orr	x3, x5, x3
               	lsl	x5, x3, #8
               	add	x3, x1, #0x6
               	mul	x3, x3, x2
               	add	x3, x3, #0x1
               	and	x3, x3, #0xff
               	orr	x3, x5, x3
               	lsl	x5, x3, #8
               	add	x3, x1, #0x7
               	mul	x3, x3, x2
               	add	x3, x3, #0x1
               	and	x3, x3, #0xff
               	orr	x5, x5, x3
               	add	x3, x20, x1
               	ldr	x3, [x3]
               	rev	x6, x3
               	lsl	x3, x0, #2
               	add	x3, x20, x3
               	ldr	w3, [x3]
               	add	x1, x4, x1
               	ldr	x1, [x1]
               	rev	x1, x1
               	add	x3, x6, x3
               	eor	x3, x5, x3
               	cmp	x1, x3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lo	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x20, [sp], #0xa0
               	ret
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x20, [sp], #0xa0
               	ret
