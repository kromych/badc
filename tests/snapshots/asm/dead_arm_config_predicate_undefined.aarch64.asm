
dead_arm_config_predicate_undefined.aarch64:	file format elf64-littleaarch64

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

<dispatch>:
               	mov	x1, x0
               	ldr	x0, [x1]
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	add	x0, x0, #0xa
               	sxtw	x0, w0
               	ldr	x1, [x1]
               	mov	x17, #0x8               // =8
               	and	x1, x1, x17
               	cmp	w1, #0x0
               	cset	x1, ne
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	mov	x1, #0x1                // =1
               	add	x0, x0, x1
               	sxtw	x0, w0
               	ret
               	mov	x1, #0x0                // =0
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x2, #0x0                // =0
               	sub	x0, x29, #0x8
               	str	x2, [x0]
               	ldr	x1, [x0]
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	add	x1, x1, #0xa
               	sxtw	x1, w1
               	ldr	x3, [x0]
               	mov	x17, #0x8               // =8
               	and	x3, x3, x17
               	cmp	w3, #0x0
               	cset	x3, ne
               	sxtw	x3, w3
               	cbz	x3, <addr>
               	mov	x2, #0x1                // =1
               	add	x1, x1, x2
               	sxtw	x1, w1
               	add	x3, x1, #0x0
               	mov	x2, #0x1                // =1
               	str	x2, [x0]
               	ldr	x1, [x0]
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	add	x1, x1, #0xa
               	sxtw	x1, w1
               	ldr	x0, [x0]
               	mov	x17, #0x8               // =8
               	and	x0, x0, x17
               	cmp	w0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	add	x0, x1, x2
               	sxtw	x0, w0
               	add	x3, x3, x0
               	mov	x1, #0x2                // =2
               	sub	x0, x29, #0x8
               	str	x1, [x0]
               	ldr	x1, [x0]
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	add	x1, x1, #0xa
               	sxtw	x1, w1
               	ldr	x2, [x0]
               	mov	x17, #0x8               // =8
               	and	x2, x2, x17
               	cmp	w2, #0x0
               	cset	x2, ne
               	sxtw	x2, w2
               	cbz	x2, <addr>
               	mov	x2, #0x1                // =1
               	add	x1, x1, x2
               	sxtw	x1, w1
               	add	x2, x3, x1
               	mov	x1, #0x3                // =3
               	str	x1, [x0]
               	ldr	x1, [x0]
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	add	x1, x1, #0xa
               	sxtw	x1, w1
               	ldr	x0, [x0]
               	mov	x17, #0x8               // =8
               	and	x0, x0, x17
               	cmp	w0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	x0, x1, x0
               	sxtw	x0, w0
               	add	x3, x2, x0
               	mov	x1, #0x4                // =4
               	sub	x0, x29, #0x8
               	str	x1, [x0]
               	ldr	x1, [x0]
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	add	x1, x1, #0xa
               	sxtw	x1, w1
               	ldr	x2, [x0]
               	mov	x17, #0x8               // =8
               	and	x2, x2, x17
               	cmp	w2, #0x0
               	cset	x2, ne
               	sxtw	x2, w2
               	cbz	x2, <addr>
               	mov	x2, #0x1                // =1
               	add	x1, x1, x2
               	sxtw	x1, w1
               	add	x2, x3, x1
               	mov	x1, #0x5                // =5
               	str	x1, [x0]
               	ldr	x1, [x0]
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	add	x1, x1, #0xa
               	sxtw	x1, w1
               	ldr	x0, [x0]
               	mov	x17, #0x8               // =8
               	and	x0, x0, x17
               	cmp	w0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	x0, x1, x0
               	sxtw	x0, w0
               	add	x3, x2, x0
               	mov	x1, #0x6                // =6
               	sub	x0, x29, #0x8
               	str	x1, [x0]
               	ldr	x1, [x0]
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	add	x1, x1, #0xa
               	sxtw	x1, w1
               	ldr	x2, [x0]
               	mov	x17, #0x8               // =8
               	and	x2, x2, x17
               	cmp	w2, #0x0
               	cset	x2, ne
               	sxtw	x2, w2
               	cbz	x2, <addr>
               	mov	x2, #0x1                // =1
               	add	x1, x1, x2
               	sxtw	x1, w1
               	add	x2, x3, x1
               	mov	x1, #0x7                // =7
               	str	x1, [x0]
               	ldr	x1, [x0]
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	add	x1, x1, #0xa
               	sxtw	x1, w1
               	ldr	x0, [x0]
               	mov	x17, #0x8               // =8
               	and	x0, x0, x17
               	cmp	w0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	x0, x1, x0
               	sxtw	x0, w0
               	add	x3, x2, x0
               	mov	x1, #0x8                // =8
               	sub	x0, x29, #0x8
               	str	x1, [x0]
               	ldr	x1, [x0]
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	add	x1, x1, #0xa
               	sxtw	x1, w1
               	ldr	x2, [x0]
               	mov	x17, #0x8               // =8
               	and	x2, x2, x17
               	cmp	w2, #0x0
               	cset	x2, ne
               	sxtw	x2, w2
               	cbz	x2, <addr>
               	mov	x2, #0x1                // =1
               	add	x1, x1, x2
               	sxtw	x1, w1
               	add	x2, x3, x1
               	mov	x1, #0x9                // =9
               	str	x1, [x0]
               	ldr	x1, [x0]
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	add	x1, x1, #0xa
               	sxtw	x1, w1
               	ldr	x0, [x0]
               	mov	x17, #0x8               // =8
               	and	x0, x0, x17
               	cmp	w0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	x0, x1, x0
               	sxtw	x0, w0
               	add	x3, x2, x0
               	mov	x1, #0xa                // =10
               	sub	x0, x29, #0x8
               	str	x1, [x0]
               	ldr	x1, [x0]
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	add	x1, x1, #0xa
               	sxtw	x1, w1
               	ldr	x2, [x0]
               	mov	x17, #0x8               // =8
               	and	x2, x2, x17
               	cmp	w2, #0x0
               	cset	x2, ne
               	sxtw	x2, w2
               	cbz	x2, <addr>
               	mov	x2, #0x1                // =1
               	add	x1, x1, x2
               	sxtw	x1, w1
               	add	x2, x3, x1
               	mov	x1, #0xb                // =11
               	str	x1, [x0]
               	ldr	x1, [x0]
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	add	x1, x1, #0xa
               	sxtw	x1, w1
               	ldr	x0, [x0]
               	mov	x17, #0x8               // =8
               	and	x0, x0, x17
               	cmp	w0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	x0, x1, x0
               	sxtw	x0, w0
               	add	x3, x2, x0
               	mov	x1, #0xc                // =12
               	sub	x0, x29, #0x8
               	str	x1, [x0]
               	ldr	x1, [x0]
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	add	x1, x1, #0xa
               	sxtw	x1, w1
               	ldr	x2, [x0]
               	mov	x17, #0x8               // =8
               	and	x2, x2, x17
               	cmp	w2, #0x0
               	cset	x2, ne
               	sxtw	x2, w2
               	cbz	x2, <addr>
               	mov	x2, #0x1                // =1
               	add	x1, x1, x2
               	sxtw	x1, w1
               	add	x2, x3, x1
               	mov	x1, #0xd                // =13
               	str	x1, [x0]
               	ldr	x1, [x0]
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	add	x1, x1, #0xa
               	sxtw	x1, w1
               	ldr	x0, [x0]
               	mov	x17, #0x8               // =8
               	and	x0, x0, x17
               	cmp	w0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	x0, x1, x0
               	sxtw	x0, w0
               	add	x3, x2, x0
               	mov	x1, #0xe                // =14
               	sub	x0, x29, #0x8
               	str	x1, [x0]
               	ldr	x1, [x0]
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	add	x1, x1, #0xa
               	sxtw	x1, w1
               	ldr	x2, [x0]
               	mov	x17, #0x8               // =8
               	and	x2, x2, x17
               	cmp	w2, #0x0
               	cset	x2, ne
               	sxtw	x2, w2
               	cbz	x2, <addr>
               	mov	x2, #0x1                // =1
               	add	x1, x1, x2
               	sxtw	x1, w1
               	add	x2, x3, x1
               	mov	x1, #0xf                // =15
               	str	x1, [x0]
               	ldr	x1, [x0]
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	add	x1, x1, #0xa
               	sxtw	x1, w1
               	ldr	x0, [x0]
               	mov	x17, #0x8               // =8
               	and	x0, x0, x17
               	cmp	w0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	x0, x1, x0
               	sxtw	x0, w0
               	add	x0, x2, x0
               	cmp	x0, #0xb0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x10
               	mov	x1, #0x0                // =0
               	str	x1, [x2]
               	sub	x3, x29, #0x8
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	ldr	x0, [x2]
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	add	x0, x0, #0xa
               	sxtw	x0, w0
               	ldr	x2, [x2]
               	mov	x17, #0x8               // =8
               	and	x2, x2, x17
               	cmp	w2, #0x0
               	cset	x2, ne
               	sxtw	x2, w2
               	cbz	x2, <addr>
               	mov	x1, #0x1                // =1
               	add	x0, x0, x1
               	sxtw	x0, w0
               	cmp	w0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [x3]
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	add	x0, x0, #0xa
               	sxtw	x0, w0
               	ldr	x1, [x3]
               	mov	x17, #0x8               // =8
               	and	x1, x1, x17
               	cmp	w1, #0x0
               	cset	x1, ne
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	mov	x1, #0x1                // =1
               	add	x0, x0, x1
               	sxtw	x0, w0
               	cmp	w0, #0xc
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	b	<addr>
