
overaligned_automatic_beside_alloca.aarch64:	file format elf64-littleaarch64

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

<touch>:
               	and	x1, x1, #0xff
               	strb	w1, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	ldrb	w0, [x0]
               	add	x0, x2, x0
               	str	w0, [x1]
               	ret

<with_alloca>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	stp	x21, x22, [sp]
               	stp	x23, x24, [sp, #0x10]
               	stp	x25, x20, [sp, #0x20]
               	sub	sp, sp, #0x100
               	mov	x16, sp
               	and	sp, x16, #0xffffffffffffff00
               	mov	x20, sp
               	mov	x25, #0x5               // =5
               	add	x0, x20, #0x40
               	mov	x1, #0x1                // =1
               	mov	x2, #0x40               // =64
               	bl	<addr>
               	mov	x0, #0x5                // =5
               	str	x0, [x20]
               	mov	x0, #0x6                // =6
               	str	x0, [x20, #0x8]
               	mov	x0, #0x7                // =7
               	str	x0, [x20, #0x10]
               	mov	x0, #0x8                // =8
               	str	x0, [x20, #0x18]
               	mov	x22, #0x0               // =0
               	mov	x21, #0x1               // =1
               	mul	x24, x25, x21
               	sxtw	x2, w24
               	add	x17, x2, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x23, sp
               	sub	x23, x23, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x23
               	mov	x0, x23
               	mov	x1, x21
               	bl	<addr>
               	mov	x0, x23
               	mov	x1, x21
               	bl	<addr>
               	add	x0, x20, #0x40
               	and	x1, x0, #0x3f
               	mov	x0, #0x1                // =1
               	cbnz	w1, <addr>
               	add	x1, x20, #0x0
               	and	x1, x1, #0xff
               	cmp	w1, #0x0
               	cset	x1, ne
               	orr	x2, x22, x1
               	ldrb	w1, [x20, #0x51]
               	eor	x1, x1, #0x1
               	cbnz	w1, <addr>
               	ldr	x1, [x20, #0x18]
               	cmp	x1, #0x8
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x0, x24, #0x1
               	ldrb	w0, [x23, w0, sxtw]
               	eor	x0, x0, x21
               	cmp	w0, #0x0
               	cset	x0, ne
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	orr	x22, x2, x0
               	add	x21, x21, #0x1
               	cmp	w21, #0x3
               	b.le	<addr>
               	mov	x0, x22
               	sub	sp, x29, #0x40
               	ldp	x25, x20, [sp, #0x20]
               	ldp	x23, x24, [sp, #0x10]
               	ldp	x21, x22, [sp]
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret

<with_vla>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	stp	x21, x22, [sp]
               	stp	x23, x24, [sp, #0x10]
               	stp	x25, x26, [sp, #0x20]
               	str	x20, [sp, #0x30]
               	sub	sp, sp, #0x80
               	mov	x16, sp
               	and	sp, x16, #0xffffffffffffff80
               	mov	x20, sp
               	mov	x25, #0x7               // =7
               	mov	x22, #0x0               // =0
               	str	w22, [x20]
               	str	w25, [x20, #0x4]
               	mov	x0, #0xe                // =14
               	str	w0, [x20, #0x8]
               	mov	x0, #0x15               // =21
               	str	w0, [x20, #0xc]
               	mov	x0, #0x1c               // =28
               	str	w0, [x20, #0x10]
               	mov	x0, #0x23               // =35
               	str	w0, [x20, #0x14]
               	mov	x0, #0x2a               // =42
               	str	w0, [x20, #0x18]
               	mov	x0, #0x31               // =49
               	str	w0, [x20, #0x1c]
               	mov	x21, #0x1               // =1
               	mov	x26, sp
               	mul	x24, x25, x21
               	add	x0, x24, #0x1
               	sxtw	x2, w0
               	add	x17, x2, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x23, sp
               	sub	x23, x23, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x23
               	mov	x0, x23
               	mov	x1, x21
               	bl	<addr>
               	mov	x0, x23
               	mov	x1, x21
               	bl	<addr>
               	add	x0, x20, #0x0
               	and	x1, x0, #0x7f
               	mov	x0, #0x1                // =1
               	cbnz	w1, <addr>
               	ldrsw	x1, [x20, #0x1c]
               	cmp	w1, #0x31
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldrb	w0, [x23, w24, sxtw]
               	eor	x0, x0, x21
               	cmp	w0, #0x0
               	cset	x0, ne
               	b	<addr>
               	mov	x1, x0
               	orr	x22, x22, x0
               	mov	sp, x26
               	add	x21, x21, #0x1
               	cmp	w21, #0x3
               	b.le	<addr>
               	mov	x0, x22
               	sub	sp, x29, #0x50
               	ldr	x20, [sp, #0x30]
               	ldp	x25, x26, [sp, #0x20]
               	ldp	x23, x24, [sp, #0x10]
               	ldp	x21, x22, [sp]
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
