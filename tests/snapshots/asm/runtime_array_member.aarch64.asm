
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
               	ldursw	x2, [x29, #-0x60]
               	ldursw	x0, [x29, #-0x60]
               	add	x0, x0, #0x1
               	ldursw	x1, [x29, #-0x60]
               	add	x1, x1, #0x2
               	ldursw	x3, [x29, #-0x60]
               	add	x3, x3, #0x3
               	ldursw	x4, [x29, #-0x60]
               	add	x4, x4, #0x64
               	cmp	w2, #0xa
               	mov	x2, #0x1                // =1
               	b.ne	<addr>
               	cmp	w0, #0xb
               	cset	x0, ne
               	cbnz	x0, <addr>
               	cmp	w1, #0xc
               	cset	x0, ne
               	cbnz	x0, <addr>
               	cmp	w3, #0xd
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, x2
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	w4, #0x6e
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x78
               	mov	x0, #0x0                // =0
               	str	x0, [x1]
               	str	x0, [x1, #0x8]
               	str	w0, [x1, #0x10]
               	ldursw	x4, [x29, #-0x60]
               	str	w4, [x1]
               	ldursw	x3, [x29, #-0x60]
               	add	x3, x3, #0x1
               	str	w3, [x1, #0x4]
               	ldursw	x5, [x29, #-0x60]
               	str	w5, [x1, #0x10]
               	cmp	w4, #0xa
               	cset	x1, ne
               	cbnz	x1, <addr>
               	cmp	w3, #0xb
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, x0
               	cmp	w5, #0xa
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x4, [x29, #-0x60]
               	ldursw	x1, [x29, #-0x60]
               	add	x1, x1, #0x2
               	ldursw	x3, [x29, #-0x60]
               	add	x3, x3, #0x4
               	cmp	w4, #0xa
               	b.ne	<addr>
               	mov	x2, x0
               	cbnz	x2, <addr>
               	cmp	w1, #0xc
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	w3, #0xe
               	cset	x1, ne
               	cbnz	x1, <addr>
               	mov	x1, x0
               	cbz	x1, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x80
               	str	x0, [x1]
               	str	x0, [x1, #0x8]
               	str	x0, [x1, #0x10]
               	str	w0, [x1, #0x18]
               	ldursw	x2, [x29, #-0x60]
               	str	w2, [x1]
               	ldursw	x3, [x29, #-0x60]
               	add	x3, x3, #0x1
               	str	w3, [x1, #0x18]
               	cmp	w2, #0xa
               	mov	x1, #0x1                // =1
               	b.ne	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x0                // =0
               	mov	x0, x2
               	mov	x0, x2
               	cmp	w3, #0xb
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x8, [x29, #-0x60]
               	ldursw	x0, [x29, #-0x60]
               	add	x0, x0, #0x1
               	ldursw	x3, [x29, #-0x60]
               	add	x3, x3, #0x2
               	ldursw	x4, [x29, #-0x60]
               	add	x4, x4, #0x3
               	ldursw	x5, [x29, #-0x60]
               	add	x5, x5, #0x4
               	ldursw	x6, [x29, #-0x60]
               	add	x6, x6, #0x5
               	ldursw	x7, [x29, #-0x60]
               	add	x7, x7, #0x6
               	cmp	w8, #0xa
               	b.ne	<addr>
               	cmp	w0, #0xb
               	cset	x0, ne
               	cbnz	x0, <addr>
               	cmp	w3, #0xc
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	w4, #0xd
               	b.ne	<addr>
               	cmp	w5, #0xe
               	cset	x1, ne
               	cbnz	x1, <addr>
               	cmp	w6, #0xf
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	w7, #0x10
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x78
               	str	x2, [x0]
               	str	x2, [x0, #0x8]
               	str	w2, [x0, #0x10]
               	ldursw	x1, [x29, #-0x60]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x10]
               	ldursw	x4, [x29, #-0x60]
               	str	w4, [x0]
               	ldursw	x3, [x29, #-0x60]
               	add	x3, x3, #0x2
               	str	w3, [x0, #0x4]
               	cmp	w4, #0xa
               	mov	x0, #0x1                // =1
               	b.ne	<addr>
               	cmp	w3, #0xc
               	cset	x3, ne
               	cbnz	x3, <addr>
               	mov	x0, x2
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	w1, #0xb
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	mov	x3, x0
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, x1
               	b	<addr>
               	b	<addr>
               	mov	x0, x1
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
