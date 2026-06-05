
fd_set_macros.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xf0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	mov	x20, x0
               	sxtw	x20, w20
               	adrp	x21, <page>
               	add	x21, x21, #0x100
               	lsl	x0, x20, #3
               	add	x0, x21, x0
               	ldr	x0, [x0]
               	cbz	x0, <addr>
               	lsl	x0, x20, #3
               	add	x0, x21, x0
               	ldr	x0, [x0]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	mov	x1, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, #0x118
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x8
               	adrp	x2, <page>
               	add	x2, x2, #0x11e
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x10
               	adrp	x2, <page>
               	add	x2, x2, #0x125
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	lsl	x2, x20, #3
               	add	x0, x0, x2
               	ldr	x0, [x0]
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	cbz	x0, <addr>
               	lsl	x1, x20, #3
               	add	x1, x21, x1
               	ldr	x0, [x0]
               	str	x0, [x1]
               	b	<addr>
               	lsl	x0, x20, #3
               	add	x0, x21, x0
               	ldr	x0, [x0]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x100
               	str	x19, [sp]
               	b	<addr>
               	sub	x0, x29, #0x80
               	mov	x2, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	sxtw	x1, w2
               	cmp	x1, #0x80
               	b.ge	<addr>
               	sxtw	x1, w2
               	add	x1, x0, x1
               	mov	x3, #0x0                // =0
               	strb	w3, [x1]
               	sxtw	x1, w2
               	add	x1, x1, #0x1
               	sxtw	x2, w1
               	b	<addr>
               	b	<addr>
               	sxtw	x0, w1
               	cmp	x0, #0x80
               	b.ge	<addr>
               	sub	x0, x29, #0x80
               	sxtw	x2, w1
               	add	x0, x0, x2
               	ldrb	w0, [x0]
               	cmp	x0, #0x0
               	b.eq	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x0, w1
               	add	x0, x0, #0x1
               	sxtw	x1, w0
               	b	<addr>
               	sub	x0, x29, #0x80
               	mov	x1, #0x0                // =0
               	mov	x2, #0x8                // =8
               	sdiv	x1, x1, x2
               	add	x0, x0, x1
               	ldrb	w1, [x0]
               	mov	x17, #0x1               // =1
               	orr	x1, x1, x17
               	strb	w1, [x0]
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	sub	x0, x29, #0x80
               	mov	x1, #0x7                // =7
               	mov	x2, #0x8                // =8
               	sdiv	x1, x1, x2
               	add	x0, x0, x1
               	ldrb	w1, [x0]
               	mov	x17, #0x80              // =128
               	orr	x1, x1, x17
               	strb	w1, [x0]
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	sub	x0, x29, #0x80
               	mov	x1, #0x8                // =8
               	sdiv	x1, x1, x1
               	add	x0, x0, x1
               	ldrb	w1, [x0]
               	mov	x17, #0x1               // =1
               	orr	x1, x1, x17
               	strb	w1, [x0]
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	sub	x0, x29, #0x80
               	mov	x1, #0x64               // =100
               	mov	x2, #0x8                // =8
               	sdiv	x1, x1, x2
               	add	x0, x0, x1
               	ldrb	w1, [x0]
               	mov	x17, #0x10              // =16
               	orr	x1, x1, x17
               	strb	w1, [x0]
               	b	<addr>
               	b	<addr>
               	sub	x0, x29, #0x80
               	mov	x1, #0x0                // =0
               	mov	x2, #0x8                // =8
               	sdiv	x1, x1, x2
               	add	x0, x0, x1
               	ldrb	w0, [x0]
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x19, [sp]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x80
               	mov	x1, #0x7                // =7
               	mov	x2, #0x8                // =8
               	sdiv	x1, x1, x2
               	add	x0, x0, x1
               	ldrb	w0, [x0]
               	mov	x17, #0x80              // =128
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	ldr	x19, [sp]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x80
               	mov	x1, #0x8                // =8
               	sdiv	x1, x1, x1
               	add	x0, x0, x1
               	ldrb	w0, [x0]
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x4                // =4
               	ldr	x19, [sp]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x80
               	mov	x1, #0x64               // =100
               	mov	x2, #0x8                // =8
               	sdiv	x1, x1, x2
               	add	x0, x0, x1
               	ldrb	w0, [x0]
               	mov	x17, #0x10              // =16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x5                // =5
               	ldr	x19, [sp]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x80
               	mov	x1, #0x1                // =1
               	mov	x2, #0x8                // =8
               	sdiv	x1, x1, x2
               	add	x0, x0, x1
               	ldrb	w0, [x0]
               	mov	x17, #0x2               // =2
               	and	x0, x0, x17
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldr	x19, [sp]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x80
               	mov	x1, #0x32               // =50
               	mov	x2, #0x8                // =8
               	sdiv	x1, x1, x2
               	add	x0, x0, x1
               	ldrb	w0, [x0]
               	mov	x17, #0x4               // =4
               	and	x0, x0, x17
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ldr	x19, [sp]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x80
               	ldrb	w1, [x0]
               	mov	x17, #0x81              // =129
               	eor	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldr	x19, [sp]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x1, x0, #0x1
               	ldrb	w1, [x1]
               	mov	x17, #0x1               // =1
               	eor	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldr	x19, [sp]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x0, #0xc
               	ldrb	w0, [x0]
               	mov	x17, #0x10              // =16
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ldr	x19, [sp]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	sub	x0, x29, #0x80
               	mov	x1, #0x7                // =7
               	mov	x2, #0x8                // =8
               	sdiv	x1, x1, x2
               	add	x0, x0, x1
               	ldrb	w1, [x0]
               	mov	x17, #0xff7f            // =65407
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	strb	w1, [x0]
               	b	<addr>
               	b	<addr>
               	sub	x0, x29, #0x80
               	mov	x1, #0x7                // =7
               	mov	x2, #0x8                // =8
               	sdiv	x1, x1, x2
               	add	x0, x0, x1
               	ldrb	w0, [x0]
               	mov	x17, #0x80              // =128
               	and	x0, x0, x17
               	cbz	x0, <addr>
               	mov	x0, #0x15               // =21
               	ldr	x19, [sp]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x80
               	mov	x1, #0x0                // =0
               	mov	x2, #0x8                // =8
               	sdiv	x1, x1, x2
               	add	x0, x0, x1
               	ldrb	w0, [x0]
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x16               // =22
               	ldr	x19, [sp]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x80
               	mov	x1, #0x8                // =8
               	sdiv	x1, x1, x1
               	add	x0, x0, x1
               	ldrb	w0, [x0]
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x17               // =23
               	ldr	x19, [sp]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	sub	x0, x29, #0x80
               	mov	x1, #0x0                // =0
               	mov	x2, #0x8                // =8
               	sdiv	x1, x1, x2
               	add	x0, x0, x1
               	ldrb	w1, [x0]
               	mov	x17, #0x1               // =1
               	orr	x1, x1, x17
               	strb	w1, [x0]
               	b	<addr>
               	b	<addr>
               	sub	x0, x29, #0x80
               	mov	x1, #0x0                // =0
               	mov	x2, #0x8                // =8
               	sdiv	x1, x1, x2
               	add	x0, x0, x1
               	ldrb	w0, [x0]
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x18               // =24
               	ldr	x19, [sp]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	sub	x0, x29, #0x80
               	mov	x2, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	sub	x0, x29, #0x80
               	mov	x1, #0x0                // =0
               	mov	x2, #0x8                // =8
               	sdiv	x1, x1, x2
               	add	x0, x0, x1
               	ldrb	w0, [x0]
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	cbz	x0, <addr>
               	b	<addr>
               	sxtw	x1, w2
               	cmp	x1, #0x80
               	b.ge	<addr>
               	sxtw	x1, w2
               	add	x1, x0, x1
               	mov	x3, #0x0                // =0
               	strb	w3, [x1]
               	sxtw	x1, w2
               	add	x1, x1, #0x1
               	sxtw	x2, w1
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x19               // =25
               	ldr	x19, [sp]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x80
               	mov	x1, #0x64               // =100
               	mov	x2, #0x8                // =8
               	sdiv	x1, x1, x2
               	add	x0, x0, x1
               	ldrb	w0, [x0]
               	mov	x17, #0x10              // =16
               	and	x0, x0, x17
               	cbz	x0, <addr>
               	mov	x0, #0x1a               // =26
               	ldr	x19, [sp]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x150
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldr	x19, [sp]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
