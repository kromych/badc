
signed_cast_extends.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2b0              // =688
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	mov	x20, x0
               	sxtw	x20, w20
               	adrp	x21, <page>
               	add	x21, x21, #0xf0
               	ldr	x0, [x21, x20, lsl #3]
               	cbz	x0, <addr>
               	ldr	x0, [x21, x20, lsl #3]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	mov	x1, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, #0x108
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	adrp	x2, <page>
               	add	x2, x2, #0x10e
               	str	x2, [x0, #0x8]
               	sub	x0, x29, #0x18
               	adrp	x2, <page>
               	add	x2, x2, #0x115
               	str	x2, [x0, #0x10]
               	sub	x0, x29, #0x18
               	ldr	x0, [x0, x20, lsl #3]
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	cbz	x0, <addr>
               	ldr	x0, [x0]
               	str	x0, [x21, x20, lsl #3]
               	b	<addr>
               	ldr	x0, [x21, x20, lsl #3]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xe0
               	str	x19, [sp]
               	mov	x0, #0xff               // =255
               	sxtb	x0, w0
               	sxtw	x0, w0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x80               // =128
               	sxtb	x0, w0
               	sxtw	x0, w0
               	mov	x17, #0xff80            // =65408
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x19, [sp]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7f               // =127
               	sxtb	x0, w0
               	sxtw	x0, w0
               	cmp	x0, #0x7f
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldr	x19, [sp]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xff               // =255
               	sxtb	x0, w0
               	sxtw	x0, w0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldr	x19, [sp]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5678             // =22136
               	movk	x0, #0x1234, lsl #16
               	sxtb	x0, w0
               	sxtw	x0, w0
               	cmp	x0, #0x78
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldr	x19, [sp]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xabff             // =44031
               	movk	x0, #0x1234, lsl #16
               	sxtb	x0, w0
               	sxtw	x0, w0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldr	x19, [sp]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xffff             // =65535
               	sxth	x0, w0
               	sxtw	x0, w0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldr	x19, [sp]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x8000             // =32768
               	sxth	x0, w0
               	sxtw	x0, w0
               	mov	x17, #0x8000            // =32768
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldr	x19, [sp]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5678             // =22136
               	movk	x0, #0x1234, lsl #16
               	sxth	x0, w0
               	sxtw	x0, w0
               	mov	x17, #0x5678            // =22136
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldr	x19, [sp]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0x1234, lsl #16
               	sxth	x0, w0
               	sxtw	x0, w0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldr	x19, [sp]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xffd6             // =65494
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	sxtw	x0, w0
               	mov	x17, #0xffd6            // =65494
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldr	x19, [sp]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xb8
               	mov	x1, #0xff               // =255
               	strb	w1, [x0]
               	sub	x0, x29, #0xb8
               	mov	x1, #0x42               // =66
               	strb	w1, [x0, #0x1]
               	sub	x0, x29, #0xb8
               	mov	x1, #0x10               // =16
               	strb	w1, [x0, #0x2]
               	sub	x0, x29, #0xb8
               	ldrb	w0, [x0]
               	sxtb	x0, w0
               	sxtw	x0, w0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldr	x19, [sp]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xb8
               	ldrb	w0, [x0]
               	sxtb	x0, w0
               	lsl	x0, x0, #8
               	sxtw	x0, w0
               	sub	x1, x29, #0xb8
               	ldrb	w1, [x1, #0x1]
               	orr	x0, x0, x1
               	sxtw	x0, w0
               	mov	x17, #0xff42            // =65346
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ldr	x19, [sp]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x11c
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldr	x19, [sp]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
