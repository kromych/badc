
dead_arm_config_predicate_undefined.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<dispatch>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x1, x0
               	ldr	x0, [x1]
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	add	x0, x0, #0xa
               	sxtw	x2, w0
               	sxtw	x2, w2
               	sxtw	x2, w2
               	ldr	x0, [x1]
               	mov	x17, #0x8               // =8
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	x0, x2, x0
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x18
               	str	x0, [x1]
               	sub	x1, x29, #0x18
               	ldr	x0, [x1]
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	add	x0, x0, #0xa
               	sxtw	x2, w0
               	sxtw	x2, w2
               	sxtw	x2, w2
               	ldr	x0, [x1]
               	mov	x17, #0x8               // =8
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	x0, x2, x0
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	x3, x0, #0x0
               	mov	x0, #0x1                // =1
               	sub	x1, x29, #0x18
               	str	x0, [x1]
               	sub	x1, x29, #0x18
               	ldr	x0, [x1]
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	add	x0, x0, #0xa
               	sxtw	x2, w0
               	sxtw	x2, w2
               	sxtw	x2, w2
               	ldr	x0, [x1]
               	mov	x17, #0x8               // =8
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	x0, x2, x0
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	x3, x3, x0
               	mov	x0, #0x2                // =2
               	sub	x1, x29, #0x18
               	str	x0, [x1]
               	sub	x1, x29, #0x18
               	ldr	x0, [x1]
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	add	x0, x0, #0xa
               	sxtw	x2, w0
               	sxtw	x2, w2
               	sxtw	x2, w2
               	ldr	x0, [x1]
               	mov	x17, #0x8               // =8
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	x0, x2, x0
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	x3, x3, x0
               	mov	x0, #0x3                // =3
               	sub	x1, x29, #0x18
               	str	x0, [x1]
               	sub	x1, x29, #0x18
               	ldr	x0, [x1]
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	add	x0, x0, #0xa
               	sxtw	x2, w0
               	sxtw	x2, w2
               	sxtw	x2, w2
               	ldr	x0, [x1]
               	mov	x17, #0x8               // =8
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	x0, x2, x0
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	x3, x3, x0
               	mov	x0, #0x4                // =4
               	sub	x1, x29, #0x18
               	str	x0, [x1]
               	sub	x1, x29, #0x18
               	ldr	x0, [x1]
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	add	x0, x0, #0xa
               	sxtw	x2, w0
               	sxtw	x2, w2
               	sxtw	x2, w2
               	ldr	x0, [x1]
               	mov	x17, #0x8               // =8
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	x0, x2, x0
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	x3, x3, x0
               	mov	x0, #0x5                // =5
               	sub	x1, x29, #0x18
               	str	x0, [x1]
               	sub	x1, x29, #0x18
               	ldr	x0, [x1]
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	add	x0, x0, #0xa
               	sxtw	x2, w0
               	sxtw	x2, w2
               	sxtw	x2, w2
               	ldr	x0, [x1]
               	mov	x17, #0x8               // =8
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	x0, x2, x0
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	x3, x3, x0
               	mov	x0, #0x6                // =6
               	sub	x1, x29, #0x18
               	str	x0, [x1]
               	sub	x1, x29, #0x18
               	ldr	x0, [x1]
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	add	x0, x0, #0xa
               	sxtw	x2, w0
               	sxtw	x2, w2
               	sxtw	x2, w2
               	ldr	x0, [x1]
               	mov	x17, #0x8               // =8
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	x0, x2, x0
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	x3, x3, x0
               	mov	x0, #0x7                // =7
               	sub	x1, x29, #0x18
               	str	x0, [x1]
               	sub	x1, x29, #0x18
               	ldr	x0, [x1]
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	add	x0, x0, #0xa
               	sxtw	x2, w0
               	sxtw	x2, w2
               	sxtw	x2, w2
               	ldr	x0, [x1]
               	mov	x17, #0x8               // =8
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	x0, x2, x0
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	x3, x3, x0
               	mov	x0, #0x8                // =8
               	sub	x1, x29, #0x18
               	str	x0, [x1]
               	sub	x1, x29, #0x18
               	ldr	x0, [x1]
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	add	x0, x0, #0xa
               	sxtw	x2, w0
               	sxtw	x2, w2
               	sxtw	x2, w2
               	ldr	x0, [x1]
               	mov	x17, #0x8               // =8
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	x0, x2, x0
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	x3, x3, x0
               	mov	x0, #0x9                // =9
               	sub	x1, x29, #0x18
               	str	x0, [x1]
               	sub	x1, x29, #0x18
               	ldr	x0, [x1]
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	add	x0, x0, #0xa
               	sxtw	x2, w0
               	sxtw	x2, w2
               	sxtw	x2, w2
               	ldr	x0, [x1]
               	mov	x17, #0x8               // =8
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	x0, x2, x0
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	x3, x3, x0
               	mov	x0, #0xa                // =10
               	sub	x1, x29, #0x18
               	str	x0, [x1]
               	sub	x1, x29, #0x18
               	ldr	x0, [x1]
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	add	x0, x0, #0xa
               	sxtw	x2, w0
               	sxtw	x2, w2
               	sxtw	x2, w2
               	ldr	x0, [x1]
               	mov	x17, #0x8               // =8
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	x0, x2, x0
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	x3, x3, x0
               	mov	x0, #0xb                // =11
               	sub	x1, x29, #0x18
               	str	x0, [x1]
               	sub	x1, x29, #0x18
               	ldr	x0, [x1]
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	add	x0, x0, #0xa
               	sxtw	x2, w0
               	sxtw	x2, w2
               	sxtw	x2, w2
               	ldr	x0, [x1]
               	mov	x17, #0x8               // =8
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	x0, x2, x0
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	x3, x3, x0
               	mov	x0, #0xc                // =12
               	sub	x1, x29, #0x18
               	str	x0, [x1]
               	sub	x1, x29, #0x18
               	ldr	x0, [x1]
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	add	x0, x0, #0xa
               	sxtw	x2, w0
               	sxtw	x2, w2
               	sxtw	x2, w2
               	ldr	x0, [x1]
               	mov	x17, #0x8               // =8
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	x0, x2, x0
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	x3, x3, x0
               	mov	x0, #0xd                // =13
               	sub	x1, x29, #0x18
               	str	x0, [x1]
               	sub	x1, x29, #0x18
               	ldr	x0, [x1]
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	add	x0, x0, #0xa
               	sxtw	x2, w0
               	sxtw	x2, w2
               	sxtw	x2, w2
               	ldr	x0, [x1]
               	mov	x17, #0x8               // =8
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	x0, x2, x0
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	x3, x3, x0
               	mov	x0, #0xe                // =14
               	sub	x1, x29, #0x18
               	str	x0, [x1]
               	sub	x1, x29, #0x18
               	ldr	x0, [x1]
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	add	x0, x0, #0xa
               	sxtw	x2, w0
               	sxtw	x2, w2
               	sxtw	x2, w2
               	ldr	x0, [x1]
               	mov	x17, #0x8               // =8
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	x0, x2, x0
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	x3, x3, x0
               	mov	x0, #0xf                // =15
               	sub	x1, x29, #0x18
               	str	x0, [x1]
               	sub	x1, x29, #0x18
               	ldr	x0, [x1]
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	add	x0, x0, #0xa
               	sxtw	x2, w0
               	sxtw	x2, w2
               	sxtw	x2, w2
               	ldr	x0, [x1]
               	mov	x17, #0x8               // =8
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	x0, x2, x0
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	x0, x3, x0
               	cmp	x0, #0xb0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0x10
               	ldr	x0, [x1]
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	add	x0, x0, #0xa
               	sxtw	x2, w0
               	sxtw	x2, w2
               	sxtw	x2, w2
               	ldr	x0, [x1]
               	mov	x17, #0x8               // =8
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	x0, x2, x0
               	sxtw	x1, w0
               	sxtw	x0, w1
               	cmp	x0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x8
               	ldr	x0, [x1]
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	add	x0, x0, #0xa
               	sxtw	x2, w0
               	sxtw	x2, w2
               	sxtw	x2, w2
               	ldr	x0, [x1]
               	mov	x17, #0x8               // =8
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	x0, x2, x0
               	sxtw	x1, w0
               	sxtw	x0, w1
               	cmp	x0, #0xc
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
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
