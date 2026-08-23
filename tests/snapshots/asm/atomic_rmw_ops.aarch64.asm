
atomic_rmw_ops.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x30
               	mov	x0, #0xa                // =10
               	stur	x0, [x29, #-0x28]
               	sub	x0, x29, #0x28
               	mov	x2, #0x5                // =5
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x0
               	mov	x10, x2
               	ldaxr	x16, [x9]
               	add	x11, x16, x10
               	stlxr	w12, x11, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x1, x16
               	cmp	x1, #0xa
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldur	x1, [x29, #-0x28]
               	cmp	x1, #0xf
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0x3                // =3
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x0
               	mov	x10, x3
               	ldaxr	x16, [x9]
               	sub	x11, x16, x10
               	stlxr	w12, x11, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x1, x16
               	cmp	x1, #0xf
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldur	x1, [x29, #-0x28]
               	cmp	x1, #0xc
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0xf0               // =240
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x0
               	mov	x10, x1
               	ldaxr	x16, [x9]
               	and	x11, x16, x10
               	stlxr	w12, x11, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x1, x16
               	cmp	x1, #0xc
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldur	x1, [x29, #-0x28]
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, x3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x0
               	mov	x10, x2
               	ldaxr	x16, [x9]
               	orr	x11, x16, x10
               	stlxr	w12, x11, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x3, x16
               	cmp	x3, #0x0
               	cset	x1, ne
               	cbnz	x3, <addr>
               	ldur	x1, [x29, #-0x28]
               	cmp	x1, #0x5
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0x6                // =6
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x0
               	mov	x10, x3
               	ldaxr	x16, [x9]
               	eor	x11, x16, x10
               	stlxr	w12, x11, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x1, x16
               	cmp	x1, #0x5
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldur	x1, [x29, #-0x28]
               	cmp	x1, #0x3
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, x2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x63               // =99
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x0
               	mov	x10, x2
               	ldaxr	x16, [x9]
               	stlxr	w12, x10, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x1, x16
               	cmp	x1, #0x3
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldur	x1, [x29, #-0x28]
               	cmp	x1, #0x63
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, x3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	x2, [x29, #-0x20]
               	sub	x1, x29, #0x20
               	mov	x2, #0x7                // =7
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x0
               	mov	x10, x1
               	mov	x11, x2
               	ldr	x12, [x10]
               	ldaxr	x16, [x9]
               	cmp	x16, x12
               	b.ne	<addr>
               	stlxr	w17, x11, [x9]
               	cbnz	x17, <addr>
               	mov	x16, #0x1               // =1
               	b	<addr>
               	str	x16, [x10]
               	mov	x16, #0x0               // =0
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	cbnz	x0, <addr>
               	mov	x0, x2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x28]
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x64               // =100
               	stur	x0, [x29, #-0x20]
               	sub	x0, x29, #0x28
               	mov	x3, #0x0                // =0
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x0
               	mov	x10, x1
               	mov	x11, x3
               	ldr	x12, [x10]
               	ldaxr	x16, [x9]
               	cmp	x16, x12
               	b.ne	<addr>
               	stlxr	w17, x11, [x9]
               	cbnz	x17, <addr>
               	mov	x16, #0x1               // =1
               	b	<addr>
               	str	x16, [x10]
               	mov	x16, #0x0               // =0
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x28]
               	cmp	x0, #0x7
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldur	x0, [x29, #-0x20]
               	cmp	x0, #0x7
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	stur	w0, [x29, #-0x18]
               	sub	x1, x29, #0x18
               	mov	x0, #0x1                // =1
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x1
               	mov	x10, x0
               	ldaxr	w16, [x9]
               	add	x11, x16, x10
               	stlxr	w12, w11, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	cmp	w0, #0x4
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldursw	x0, [x29, #-0x18]
               	cmp	w0, #0x5
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x5                // =5
               	stur	w2, [x29, #-0x10]
               	sub	x0, x29, #0x10
               	mov	x4, #0xffff             // =65535
               	movk	x4, #0xffff, lsl #16
               	movk	x4, #0xffff, lsl #32
               	movk	x4, #0xffff, lsl #48
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x1
               	mov	x10, x0
               	mov	x11, x4
               	ldr	w12, [x10]
               	ldaxr	w16, [x9]
               	cmp	x16, x12
               	b.ne	<addr>
               	stlxr	w17, w11, [x9]
               	cbnz	x17, <addr>
               	mov	x16, #0x1               // =1
               	b	<addr>
               	str	w16, [x10]
               	mov	x16, #0x0               // =0
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	cbnz	x0, <addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x18]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xc                // =12
               	stur	w0, [x29, #-0x8]
               	sub	x1, x29, #0x8
               	mov	x0, #0xf0               // =240
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x1
               	mov	x10, x0
               	ldaxr	w16, [x9]
               	and	x11, x16, x10
               	stlxr	w12, w11, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	cmp	w0, #0xc
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldursw	x0, [x29, #-0x8]
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x1
               	mov	x10, x2
               	ldaxr	w16, [x9]
               	orr	x11, x16, x10
               	stlxr	w12, w11, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	cmp	w0, #0x0
               	cset	x2, ne
               	cbnz	x0, <addr>
               	ldursw	x0, [x29, #-0x8]
               	cmp	w0, #0x5
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x6                // =6
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x1
               	mov	x10, x0
               	ldaxr	w16, [x9]
               	eor	x11, x16, x10
               	stlxr	w12, w11, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	cmp	w0, #0x5
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldursw	x0, [x29, #-0x8]
               	cmp	w0, #0x3
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x3
               	add	sp, sp, #0x30
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
