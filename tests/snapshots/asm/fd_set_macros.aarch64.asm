
fd_set_macros.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x100
               	str	x19, [sp]
               	sub	x2, x29, #0x80
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x1, x2, x1
               	mov	x3, #0x0                // =0
               	strb	w3, [x1]
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	sxtw	x1, w0
               	cmp	x1, #0x80
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x80
               	add	x1, x2, x1
               	ldrb	w1, [x1]
               	cmp	x1, #0x0
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	sxtw	x1, w0
               	cmp	x1, #0x80
               	b.lt	<addr>
               	sub	x0, x29, #0x80
               	add	x0, x0, #0x0
               	ldrb	w1, [x0]
               	mov	x17, #0x1               // =1
               	orr	x1, x1, x17
               	strb	w1, [x0]
               	sub	x0, x29, #0x80
               	add	x0, x0, #0x0
               	ldrb	w1, [x0]
               	mov	x17, #0x80              // =128
               	orr	x1, x1, x17
               	strb	w1, [x0]
               	sub	x0, x29, #0x80
               	ldrb	w1, [x0, #0x1]
               	mov	x17, #0x1               // =1
               	orr	x1, x1, x17
               	strb	w1, [x0, #0x1]
               	sub	x0, x29, #0x80
               	ldrb	w1, [x0, #0xc]
               	mov	x17, #0x10              // =16
               	orr	x1, x1, x17
               	strb	w1, [x0, #0xc]
               	sub	x0, x29, #0x80
               	add	x0, x0, #0x0
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
               	add	x0, x0, #0x0
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
               	ldrb	w0, [x0, #0x1]
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
               	ldrb	w0, [x0, #0xc]
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
               	add	x0, x0, #0x0
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
               	ldrb	w0, [x0, #0x6]
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
               	mov	w1, w1
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldr	x19, [sp]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w1, [x0, #0x1]
               	mov	x17, #0x1               // =1
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldr	x19, [sp]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w0, [x0, #0xc]
               	mov	x17, #0x10              // =16
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ldr	x19, [sp]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x80
               	add	x0, x0, #0x0
               	ldrb	w1, [x0]
               	mov	x17, #0xff7f            // =65407
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x2, x1, x17
               	strb	w2, [x0]
               	sub	x0, x29, #0x80
               	add	x0, x0, #0x0
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
               	add	x0, x0, #0x0
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
               	ldrb	w0, [x0, #0x1]
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x17               // =23
               	ldr	x19, [sp]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x80
               	add	x0, x0, #0x0
               	ldrb	w1, [x0]
               	mov	x17, #0x1               // =1
               	orr	x1, x1, x17
               	strb	w1, [x0]
               	sub	x0, x29, #0x80
               	add	x0, x0, #0x0
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
               	sub	x2, x29, #0x80
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x1, x2, x1
               	mov	x3, #0x0                // =0
               	strb	w3, [x1]
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	sxtw	x1, w0
               	cmp	x1, #0x80
               	b.lt	<addr>
               	sub	x0, x29, #0x80
               	add	x0, x0, #0x0
               	ldrb	w0, [x0]
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	cbz	x0, <addr>
               	mov	x0, #0x19               // =25
               	ldr	x19, [sp]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x80
               	ldrb	w0, [x0, #0xc]
               	mov	x17, #0x10              // =16
               	and	x0, x0, x17
               	cbz	x0, <addr>
               	mov	x0, #0x1a               // =26
               	ldr	x19, [sp]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldr	x19, [sp]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
