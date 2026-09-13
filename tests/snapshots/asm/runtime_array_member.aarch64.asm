
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
               	sub	sp, sp, #0x10
               	mov	x0, #0xa                // =10
               	stur	w0, [x29, #-0x8]
               	ldursw	x4, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x8]
               	add	x0, x0, #0x1
               	ldursw	x1, [x29, #-0x8]
               	add	x1, x1, #0x2
               	ldursw	x2, [x29, #-0x8]
               	add	x2, x2, #0x3
               	ldursw	x3, [x29, #-0x8]
               	add	x3, x3, #0x64
               	cmp	w4, #0xa
               	b.ne	<addr>
               	cmp	w0, #0xb
               	cset	x0, ne
               	cbnz	x0, <addr>
               	cmp	w1, #0xc
               	cset	x0, ne
               	cbnz	x0, <addr>
               	cmp	w2, #0xd
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	w3, #0x6e
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x1, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x8]
               	add	x0, x0, #0x1
               	ldursw	x2, [x29, #-0x8]
               	cmp	w1, #0xa
               	b.ne	<addr>
               	cmp	w0, #0xb
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	cmp	w2, #0xa
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x3, [x29, #-0x8]
               	ldursw	x1, [x29, #-0x8]
               	add	x1, x1, #0x2
               	ldursw	x2, [x29, #-0x8]
               	add	x2, x2, #0x4
               	cmp	w3, #0xa
               	b.ne	<addr>
               	mov	x3, x0
               	cmp	w1, #0xc
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	w2, #0xe
               	cset	x1, ne
               	cbnz	x1, <addr>
               	mov	x1, x0
               	ldursw	x2, [x29, #-0x8]
               	ldursw	x1, [x29, #-0x8]
               	add	x1, x1, #0x1
               	cmp	w2, #0xa
               	b.ne	<addr>
               	mov	x2, x0
               	mov	x2, x0
               	mov	x2, x0
               	cmp	w1, #0xb
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x6, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x8]
               	add	x0, x0, #0x1
               	ldursw	x1, [x29, #-0x8]
               	add	x1, x1, #0x2
               	ldursw	x2, [x29, #-0x8]
               	add	x2, x2, #0x3
               	ldursw	x3, [x29, #-0x8]
               	add	x3, x3, #0x4
               	ldursw	x4, [x29, #-0x8]
               	add	x4, x4, #0x5
               	ldursw	x5, [x29, #-0x8]
               	add	x5, x5, #0x6
               	cmp	w6, #0xa
               	b.ne	<addr>
               	cmp	w0, #0xb
               	cset	x0, ne
               	cbnz	x0, <addr>
               	cmp	w1, #0xc
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	w2, #0xd
               	b.ne	<addr>
               	cmp	w3, #0xe
               	cset	x0, ne
               	cbnz	x0, <addr>
               	cmp	w4, #0xf
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	w5, #0x10
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x8]
               	add	x0, x0, #0x1
               	ldursw	x2, [x29, #-0x8]
               	ldursw	x1, [x29, #-0x8]
               	add	x1, x1, #0x2
               	cmp	w2, #0xa
               	b.ne	<addr>
               	cmp	w1, #0xc
               	cset	x1, ne
               	cbnz	x1, <addr>
               	mov	x1, #0x0                // =0
               	mov	x2, x1
               	mov	x2, x1
               	cmp	w0, #0xb
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
