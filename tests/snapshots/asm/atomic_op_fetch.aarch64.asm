
atomic_op_fetch.aarch64:	file format elf64-littleaarch64

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
               	mov	x2, #0xa                // =10
               	stur	w2, [x29, #-0x8]
               	sub	x1, x29, #0x8
               	mov	x3, #0x5                // =5
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x1
               	mov	x10, x3
               	ldaxr	w16, [x9]
               	add	x11, x16, x10
               	stlxr	w12, w11, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	add	x0, x0, #0x5
               	cmp	w0, #0xf
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x1
               	mov	x10, x0
               	ldaxr	w16, [x9]
               	sub	x11, x16, x10
               	stlxr	w12, w11, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x4, x16
               	sub	x4, x4, #0x3
               	cmp	w4, #0xc
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x4, #0xf                // =15
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x1
               	mov	x10, x4
               	ldaxr	w16, [x9]
               	and	x11, x16, x10
               	stlxr	w12, w11, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x5, x16
               	and	x4, x5, x4
               	cmp	w4, #0xc
               	b.eq	<addr>
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x4, #0x1                // =1
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x1
               	mov	x10, x4
               	ldaxr	w16, [x9]
               	orr	x11, x16, x10
               	stlxr	w12, w11, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x5, x16
               	orr	x4, x5, x4
               	cmp	w4, #0xd
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
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
               	mov	x1, x16
               	eor	x0, x1, x0
               	cmp	w0, #0xe
               	b.eq	<addr>
               	mov	x0, x3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x8]
               	cmp	w0, #0xe
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x64               // =100
               	stur	x0, [x29, #-0x10]
               	sub	x1, x29, #0x10
               	mov	x0, #0x7                // =7
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x1
               	mov	x10, x0
               	ldaxr	x16, [x9]
               	add	x11, x16, x10
               	stlxr	w12, x11, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x3, x16
               	add	x3, x3, #0x7
               	cmp	x3, #0x6b
               	b.eq	<addr>
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x1
               	mov	x10, x2
               	ldaxr	x16, [x9]
               	sub	x11, x16, x10
               	stlxr	w12, x11, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	sub	x0, x0, #0xa
               	cmp	x0, #0x61
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x10]
               	cmp	x0, #0x61
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
