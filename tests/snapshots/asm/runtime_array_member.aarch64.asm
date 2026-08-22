
runtime_array_member.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x90
               	mov	x0, #0xa                // =10
               	stur	w0, [x29, #-0x60]
               	ldursw	x0, [x29, #-0x60]
               	ldursw	x1, [x29, #-0x60]
               	add	x1, x1, #0x1
               	sxtw	x1, w1
               	ldursw	x2, [x29, #-0x60]
               	add	x2, x2, #0x2
               	sxtw	x3, w2
               	ldursw	x2, [x29, #-0x60]
               	add	x2, x2, #0x3
               	sxtw	x4, w2
               	ldursw	x2, [x29, #-0x60]
               	add	x2, x2, #0x64
               	sxtw	x5, w2
               	cmp	x0, #0xa
               	mov	x2, #0x1                // =1
               	b.ne	<addr>
               	cmp	x1, #0xb
               	cset	x0, ne
               	cbnz	x0, <addr>
               	cmp	x3, #0xc
               	cset	x0, ne
               	cbnz	x0, <addr>
               	cmp	x4, #0xd
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, x2
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	x5, #0x6e
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x78
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	w1, [x0, #0x10]
               	ldursw	x3, [x29, #-0x60]
               	str	w3, [x0]
               	ldursw	x4, [x29, #-0x60]
               	add	x4, x4, #0x1
               	sxtw	x5, w4
               	str	w4, [x0, #0x4]
               	ldursw	x4, [x29, #-0x60]
               	str	w4, [x0, #0x10]
               	cmp	x3, #0xa
               	cset	x3, ne
               	cbnz	x3, <addr>
               	cmp	x5, #0xb
               	cset	x3, ne
               	cbz	x3, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x5, [x0, #0x8]
               	cmp	x5, #0x0
               	cset	x3, ne
               	cbnz	x5, <addr>
               	ldrsw	x0, [x0, #0xc]
               	cmp	x0, #0x0
               	cset	x3, ne
               	cbz	x3, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	x4, #0xa
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x60]
               	ldursw	x3, [x29, #-0x60]
               	add	x3, x3, #0x2
               	sxtw	x3, w3
               	ldursw	x4, [x29, #-0x60]
               	add	x4, x4, #0x4
               	sxtw	x4, w4
               	cmp	x0, #0xa
               	b.ne	<addr>
               	mov	x2, x1
               	cbnz	x2, <addr>
               	cmp	x3, #0xc
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	x4, #0xe
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, x1
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x80
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	x1, [x0, #0x10]
               	str	w1, [x0, #0x18]
               	ldursw	x1, [x29, #-0x60]
               	str	w1, [x0]
               	ldursw	x2, [x29, #-0x60]
               	add	x2, x2, #0x1
               	sxtw	x3, w2
               	str	w2, [x0, #0x18]
               	cmp	x1, #0xa
               	mov	x1, #0x1                // =1
               	b.ne	<addr>
               	ldrsw	x2, [x0, #0x4]
               	cmp	x2, #0x0
               	cset	x2, ne
               	cbnz	x2, <addr>
               	ldrsw	x2, [x0, #0x8]
               	cmp	x2, #0x0
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x2, [x0, #0xc]
               	cbnz	x2, <addr>
               	ldrsw	x2, [x0, #0x10]
               	cmp	x2, #0x0
               	cset	x2, ne
               	cbnz	x2, <addr>
               	ldrsw	x0, [x0, #0x14]
               	cmp	x0, #0x0
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	x3, #0xb
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x60]
               	ldursw	x2, [x29, #-0x60]
               	add	x2, x2, #0x1
               	sxtw	x2, w2
               	ldursw	x3, [x29, #-0x60]
               	add	x3, x3, #0x2
               	sxtw	x3, w3
               	ldursw	x4, [x29, #-0x60]
               	add	x4, x4, #0x3
               	sxtw	x4, w4
               	ldursw	x5, [x29, #-0x60]
               	add	x5, x5, #0x4
               	sxtw	x5, w5
               	ldursw	x6, [x29, #-0x60]
               	add	x6, x6, #0x5
               	sxtw	x6, w6
               	ldursw	x7, [x29, #-0x60]
               	add	x7, x7, #0x6
               	sxtw	x7, w7
               	cmp	x0, #0xa
               	b.ne	<addr>
               	cmp	x2, #0xb
               	cset	x0, ne
               	cbnz	x0, <addr>
               	cmp	x3, #0xc
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	x4, #0xd
               	b.ne	<addr>
               	cmp	x5, #0xe
               	cset	x1, ne
               	cbnz	x1, <addr>
               	cmp	x6, #0xf
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	x7, #0x10
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x78
               	mov	x2, #0x0                // =0
               	str	x2, [x0]
               	str	x2, [x0, #0x8]
               	str	w2, [x0, #0x10]
               	ldursw	x1, [x29, #-0x60]
               	add	x1, x1, #0x1
               	sxtw	x4, w1
               	str	w1, [x0, #0x10]
               	ldursw	x1, [x29, #-0x60]
               	str	w1, [x0]
               	ldursw	x3, [x29, #-0x60]
               	add	x3, x3, #0x2
               	sxtw	x5, w3
               	str	w3, [x0, #0x4]
               	cmp	x1, #0xa
               	mov	x1, #0x1                // =1
               	b.ne	<addr>
               	cmp	x5, #0xc
               	cset	x3, ne
               	cbnz	x3, <addr>
               	ldrsw	x1, [x0, #0x8]
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldrsw	x0, [x0, #0xc]
               	cmp	x0, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	x4, #0xb
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x2
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	mov	x3, x1
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, x1
               	b	<addr>
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, x2
               	b	<addr>
               	mov	x0, x2
               	b	<addr>
