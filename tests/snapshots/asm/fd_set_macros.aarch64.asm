
fd_set_macros.aarch64:	file format elf64-littleaarch64

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
               	sub	x1, x29, #0x80
               	mov	x2, #0x0                // =0
               	mov	x0, x2
               	cmp	w0, #0x80
               	b.ge	<addr>
               	sxtw	x3, w0
               	strb	w2, [x1, x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x80
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	cmp	w0, #0x80
               	b.ge	<addr>
               	sxtw	x2, w0
               	ldrb	w2, [x1, x2]
               	cbnz	x2, <addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x80
               	b.lt	<addr>
               	sub	x1, x29, #0x80
               	ldrb	w0, [x1]
               	orr	x0, x0, #0x1
               	strb	w0, [x1]
               	ldrb	w0, [x1]
               	orr	x0, x0, #0x80
               	strb	w0, [x1]
               	ldrb	w0, [x1, #0x1]
               	orr	x0, x0, #0x1
               	strb	w0, [x1, #0x1]
               	ldrb	w0, [x1, #0xc]
               	orr	x0, x0, #0x10
               	strb	w0, [x1, #0xc]
               	ldrb	w0, [x1]
               	and	x0, x0, #0x1
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w0, [x1]
               	and	x0, x0, #0x80
               	cbnz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w0, [x1, #0x1]
               	and	x0, x0, #0x1
               	cbnz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w0, [x1, #0xc]
               	and	x0, x0, #0x10
               	cbnz	x0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w0, [x1]
               	and	x0, x0, #0x2
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w0, [x1, #0x6]
               	and	x0, x0, #0x4
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w0, [x1]
               	mov	x17, #0x81              // =129
               	eor	x0, x0, x17
               	cmp	w0, #0x0
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w0, [x1, #0x1]
               	eor	x0, x0, #0x1
               	cmp	w0, #0x0
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w0, [x1, #0xc]
               	eor	x0, x0, #0x10
               	cmp	w0, #0x0
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w0, [x1]
               	and	x2, x0, #0xffffffffffffff7f
               	strb	w2, [x1]
               	ldrb	w0, [x1]
               	and	x0, x0, #0x80
               	cbz	x0, <addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w0, [x1]
               	and	x0, x0, #0x1
               	cbnz	x0, <addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w0, [x1, #0x1]
               	and	x0, x0, #0x1
               	cbnz	x0, <addr>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w0, [x1]
               	orr	x0, x0, #0x1
               	strb	w0, [x1]
               	ldrb	w0, [x1]
               	and	x0, x0, #0x1
               	cbnz	x0, <addr>
               	mov	x0, #0x18               // =24
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x0                // =0
               	mov	x0, x2
               	cmp	w0, #0x80
               	b.ge	<addr>
               	sxtw	x3, w0
               	strb	w2, [x1, x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x80
               	b.lt	<addr>
               	sub	x0, x29, #0x80
               	ldrb	w1, [x0]
               	and	x1, x1, #0x1
               	cbz	x1, <addr>
               	mov	x0, #0x19               // =25
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w0, [x0, #0xc]
               	and	x0, x0, #0x10
               	cbz	x0, <addr>
               	mov	x0, #0x1a               // =26
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
