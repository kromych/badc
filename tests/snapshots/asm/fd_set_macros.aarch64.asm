
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
               	str	x19, [sp, #-0xb0]!
               	stp	x29, x30, [sp, #0xa0]
               	add	x29, sp, #0xa0
               	sub	x1, x29, #0x80
               	mov	x2, #0x0                // =0
               	mov	x0, x2
               	b	<addr>
               	sxtw	x3, w0
               	add	x3, x1, x3
               	strb	w2, [x3]
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	cmp	w0, #0x80
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x2, w0
               	add	x2, x1, x2
               	ldrb	w2, [x2]
               	cbnz	x2, <addr>
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	cmp	w0, #0x80
               	b.lt	<addr>
               	sub	x0, x29, #0x80
               	add	x1, x0, #0x0
               	ldrb	w2, [x1]
               	mov	x17, #0x1               // =1
               	orr	x2, x2, x17
               	strb	w2, [x1]
               	ldrb	w2, [x1]
               	mov	x17, #0x80              // =128
               	orr	x2, x2, x17
               	strb	w2, [x1]
               	ldrb	w2, [x0, #0x1]
               	mov	x17, #0x1               // =1
               	orr	x2, x2, x17
               	strb	w2, [x0, #0x1]
               	ldrb	w2, [x0, #0xc]
               	mov	x17, #0x10              // =16
               	orr	x2, x2, x17
               	strb	w2, [x0, #0xc]
               	ldrb	w2, [x1]
               	mov	x17, #0x1               // =1
               	and	x2, x2, x17
               	cbnz	x2, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x19, [sp], #0xb0
               	ret
               	ldrb	w2, [x1]
               	mov	x17, #0x80              // =128
               	and	x2, x2, x17
               	cbnz	x2, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x19, [sp], #0xb0
               	ret
               	ldrb	w2, [x0, #0x1]
               	mov	x17, #0x1               // =1
               	and	x2, x2, x17
               	cbnz	x2, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x19, [sp], #0xb0
               	ret
               	ldrb	w2, [x0, #0xc]
               	mov	x17, #0x10              // =16
               	and	x2, x2, x17
               	cbnz	x2, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x19, [sp], #0xb0
               	ret
               	ldrb	w2, [x1]
               	mov	x17, #0x2               // =2
               	and	x2, x2, x17
               	cbz	x2, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x19, [sp], #0xb0
               	ret
               	ldrb	w2, [x0, #0x6]
               	mov	x17, #0x4               // =4
               	and	x2, x2, x17
               	cbz	x2, <addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x19, [sp], #0xb0
               	ret
               	ldrb	w2, [x0]
               	mov	x17, #0x81              // =129
               	eor	x2, x2, x17
               	mov	w2, w2
               	cbz	x2, <addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x19, [sp], #0xb0
               	ret
               	ldrb	w2, [x0, #0x1]
               	mov	x17, #0x1               // =1
               	eor	x2, x2, x17
               	mov	w2, w2
               	cbz	x2, <addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x19, [sp], #0xb0
               	ret
               	ldrb	w2, [x0, #0xc]
               	mov	x17, #0x10              // =16
               	eor	x2, x2, x17
               	mov	w2, w2
               	cbz	x2, <addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x19, [sp], #0xb0
               	ret
               	ldrb	w2, [x1]
               	mov	x17, #0xff7f            // =65407
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x3, x2, x17
               	strb	w3, [x1]
               	ldrb	w2, [x1]
               	mov	x17, #0x80              // =128
               	and	x2, x2, x17
               	cbz	x2, <addr>
               	mov	x0, #0x15               // =21
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x19, [sp], #0xb0
               	ret
               	ldrb	w0, [x1]
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	cbnz	x0, <addr>
               	mov	x0, #0x16               // =22
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x19, [sp], #0xb0
               	ret
               	sub	x2, x29, #0x80
               	ldrb	w0, [x2, #0x1]
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	cbnz	x0, <addr>
               	mov	x0, #0x17               // =23
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x19, [sp], #0xb0
               	ret
               	add	x0, x2, #0x0
               	ldrb	w1, [x0]
               	mov	x17, #0x1               // =1
               	orr	x1, x1, x17
               	strb	w1, [x0]
               	ldrb	w0, [x0]
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	cbnz	x0, <addr>
               	mov	x0, #0x18               // =24
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x19, [sp], #0xb0
               	ret
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	b	<addr>
               	sxtw	x3, w0
               	add	x3, x2, x3
               	strb	w1, [x3]
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	cmp	w0, #0x80
               	b.lt	<addr>
               	sub	x0, x29, #0x80
               	add	x1, x0, #0x0
               	ldrb	w1, [x1]
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	cbz	x1, <addr>
               	mov	x0, #0x19               // =25
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x19, [sp], #0xb0
               	ret
               	ldrb	w0, [x0, #0xc]
               	mov	x17, #0x10              // =16
               	and	x0, x0, x17
               	cbz	x0, <addr>
               	mov	x0, #0x1a               // =26
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x19, [sp], #0xb0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x19, [sp], #0xb0
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x19, [sp], #0xb0
               	ret
