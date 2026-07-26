
runtime_array_member.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xc0
               	mov	x0, #0xa                // =10
               	stur	w0, [x29, #-0xb0]
               	ldursw	x0, [x29, #-0xb0]
               	ldursw	x1, [x29, #-0xb0]
               	add	x1, x1, #0x1
               	sxtw	x2, w1
               	ldursw	x1, [x29, #-0xb0]
               	add	x1, x1, #0x2
               	sxtw	x3, w1
               	ldursw	x1, [x29, #-0xb0]
               	add	x1, x1, #0x3
               	sxtw	x4, w1
               	ldursw	x1, [x29, #-0xb0]
               	add	x1, x1, #0x64
               	sxtw	x5, w1
               	cmp	x0, #0xa
               	cset	x0, ne
               	mov	x1, #0x1                // =1
               	cbnz	x0, <addr>
               	sxtw	x0, w2
               	cmp	x0, #0xb
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	sxtw	x0, w3
               	cmp	x0, #0xc
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sxtw	x0, w4
               	cmp	x0, #0xd
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x0, w5
               	cmp	x0, #0x6e
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x30
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldrb	w10, [x1, #0x10]
               	strb	w10, [x0, #0x10]
               	ldrb	w10, [x1, #0x11]
               	strb	w10, [x0, #0x11]
               	ldrb	w10, [x1, #0x12]
               	strb	w10, [x0, #0x12]
               	ldrb	w10, [x1, #0x13]
               	strb	w10, [x0, #0x13]
               	ldr	x10, [sp], #0x10
               	ldursw	x0, [x29, #-0xb0]
               	sub	x1, x29, #0x30
               	str	w0, [x1]
               	ldursw	x1, [x29, #-0xb0]
               	add	x1, x1, #0x1
               	sxtw	x3, w1
               	sub	x2, x29, #0x30
               	str	w1, [x2, #0x4]
               	ldursw	x1, [x29, #-0xb0]
               	sub	x2, x29, #0x30
               	str	w1, [x2, #0x10]
               	cmp	x0, #0xa
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sxtw	x0, w3
               	cmp	x0, #0xb
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x30
               	ldrsw	x0, [x0, #0x8]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x30
               	ldrsw	x0, [x0, #0xc]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	x1, #0xa
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x1, [x29, #-0xb0]
               	mov	x0, #0x1                // =1
               	ldursw	x2, [x29, #-0xb0]
               	add	x2, x2, #0x2
               	sxtw	x3, w2
               	ldursw	x2, [x29, #-0xb0]
               	add	x2, x2, #0x4
               	sxtw	x2, w2
               	cmp	x1, #0xa
               	cset	x1, ne
               	cbnz	x1, <addr>
               	mov	x0, #0x0                // =0
               	cbnz	x0, <addr>
               	sxtw	x0, w3
               	cmp	x0, #0xc
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x0, w2
               	cmp	x0, #0xe
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x70
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldrb	w10, [x1, #0x18]
               	strb	w10, [x0, #0x18]
               	ldrb	w10, [x1, #0x19]
               	strb	w10, [x0, #0x19]
               	ldrb	w10, [x1, #0x1a]
               	strb	w10, [x0, #0x1a]
               	ldrb	w10, [x1, #0x1b]
               	strb	w10, [x0, #0x1b]
               	ldr	x10, [sp], #0x10
               	ldursw	x0, [x29, #-0xb0]
               	sub	x1, x29, #0x70
               	str	w0, [x1]
               	ldursw	x1, [x29, #-0xb0]
               	add	x1, x1, #0x1
               	sxtw	x3, w1
               	sub	x2, x29, #0x70
               	str	w1, [x2, #0x18]
               	cmp	x0, #0xa
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x70
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x70
               	ldrsw	x0, [x0, #0x8]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x70
               	ldrsw	x0, [x0, #0xc]
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x70
               	ldrsw	x0, [x0, #0x10]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x70
               	ldrsw	x0, [x0, #0x14]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x0, w3
               	cmp	x0, #0xb
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0xb0]
               	ldursw	x1, [x29, #-0xb0]
               	add	x1, x1, #0x1
               	sxtw	x2, w1
               	ldursw	x1, [x29, #-0xb0]
               	add	x1, x1, #0x2
               	sxtw	x3, w1
               	ldursw	x1, [x29, #-0xb0]
               	add	x1, x1, #0x3
               	sxtw	x4, w1
               	ldursw	x1, [x29, #-0xb0]
               	add	x1, x1, #0x4
               	sxtw	x5, w1
               	ldursw	x1, [x29, #-0xb0]
               	add	x1, x1, #0x5
               	sxtw	x6, w1
               	ldursw	x1, [x29, #-0xb0]
               	add	x1, x1, #0x6
               	sxtw	x1, w1
               	cmp	x0, #0xa
               	cset	x7, ne
               	mov	x0, #0x1                // =1
               	cbnz	x7, <addr>
               	sxtw	x0, w2
               	cmp	x0, #0xb
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sxtw	x0, w3
               	cmp	x0, #0xc
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x0, w4
               	cmp	x0, #0xd
               	cset	x2, ne
               	mov	x0, #0x1                // =1
               	cbnz	x2, <addr>
               	sxtw	x0, w5
               	cmp	x0, #0xe
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sxtw	x0, w6
               	cmp	x0, #0xf
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x0, w1
               	cmp	x0, #0x10
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldrb	w10, [x1, #0x10]
               	strb	w10, [x0, #0x10]
               	ldrb	w10, [x1, #0x11]
               	strb	w10, [x0, #0x11]
               	ldrb	w10, [x1, #0x12]
               	strb	w10, [x0, #0x12]
               	ldrb	w10, [x1, #0x13]
               	strb	w10, [x0, #0x13]
               	ldr	x10, [sp], #0x10
               	ldursw	x0, [x29, #-0xb0]
               	add	x0, x0, #0x1
               	sxtw	x3, w0
               	sub	x1, x29, #0xa8
               	str	w0, [x1, #0x10]
               	ldursw	x0, [x29, #-0xb0]
               	sub	x1, x29, #0xa8
               	str	w0, [x1]
               	ldursw	x1, [x29, #-0xb0]
               	add	x1, x1, #0x2
               	sxtw	x4, w1
               	sub	x2, x29, #0xa8
               	str	w1, [x2, #0x4]
               	cmp	x0, #0xa
               	cset	x0, ne
               	mov	x1, #0x1                // =1
               	cbnz	x0, <addr>
               	sxtw	x0, w4
               	cmp	x0, #0xc
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	sub	x0, x29, #0xa8
               	ldrsw	x0, [x0, #0x8]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0xa8
               	ldrsw	x0, [x0, #0xc]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x0, w3
               	cmp	x0, #0xb
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xc0
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
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
