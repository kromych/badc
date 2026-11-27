
over_aligned_local_in_an_inlined_function.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
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
               	sub	sp, sp, #0x40
               	mov	x16, sp
               	and	sp, x16, #0xffffffffffffffc0
               	add	x0, sp, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	mov	x0, sp
               	mov	x1, #0x100000000        // =4294967296
               	str	x1, [sp]
               	mov	x1, #0x2                // =2
               	mov	x2, #0x2                // =2
               	movk	x2, #0x3, lsl #32
               	str	x2, [sp, #0x8]
               	mov	x2, #0x4                // =4
               	movk	x2, #0x5, lsl #32
               	str	x2, [sp, #0x10]
               	mov	x2, #0x6                // =6
               	movk	x2, #0x7, lsl #32
               	str	x2, [sp, #0x18]
               	tst	x0, #0x1f
               	mov	x16, #0x3e8             // =1000
               	csel	x0, x16, xzr, ne
               	ldrsw	x2, [sp, #0x4]
               	add	x0, x0, x2
               	ldrsw	x2, [sp, #0x8]
               	add	x0, x0, x2
               	ldrsw	x2, [sp, #0xc]
               	add	x0, x0, x2
               	ldrsw	x2, [sp, #0x10]
               	add	x0, x0, x2
               	ldrsw	x2, [sp, #0x14]
               	add	x0, x0, x2
               	ldrsw	x2, [sp, #0x18]
               	add	x0, x0, x2
               	ldrsw	x2, [sp, #0x1c]
               	add	x0, x0, x2
               	mov	x2, sp
               	mov	x3, #0x100              // =256
               	strh	w3, [sp]
               	strb	w1, [sp, #0x2]
               	tst	x2, #0x3f
               	mov	x16, #0x3e8             // =1000
               	csel	x1, x16, xzr, ne
               	ldrb	w2, [sp, #0x1]
               	add	x1, x1, x2
               	ldrb	w2, [sp, #0x2]
               	add	x1, x1, x2
               	add	x0, x0, x1
               	mov	x1, sp
               	mov	x2, #0x1                // =1
               	movk	x2, #0x2, lsl #32
               	mov	x3, #0x2                // =2
               	str	x2, [sp]
               	mov	x2, #0x3                // =3
               	movk	x2, #0x4, lsl #32
               	str	x2, [sp, #0x8]
               	mov	x2, #0x5                // =5
               	movk	x2, #0x6, lsl #32
               	str	x2, [sp, #0x10]
               	mov	x2, #0x7                // =7
               	movk	x2, #0x8, lsl #32
               	str	x2, [sp, #0x18]
               	tst	x1, #0x1f
               	mov	x16, #0x3e8             // =1000
               	csel	x1, x16, xzr, ne
               	ldrsw	x2, [sp]
               	add	x1, x1, x2
               	ldrsw	x2, [sp, #0x4]
               	add	x1, x1, x2
               	ldrsw	x2, [sp, #0x8]
               	add	x1, x1, x2
               	ldrsw	x2, [sp, #0xc]
               	add	x1, x1, x2
               	ldrsw	x2, [sp, #0x10]
               	add	x1, x1, x2
               	ldrsw	x2, [sp, #0x14]
               	add	x1, x1, x2
               	ldrsw	x2, [sp, #0x18]
               	add	x1, x1, x2
               	ldrsw	x2, [sp, #0x1c]
               	add	x1, x1, x2
               	mov	x2, sp
               	mov	x4, #0x101              // =257
               	strh	w4, [sp]
               	strb	w3, [sp, #0x2]
               	tst	x2, #0x3f
               	mov	x16, #0x3e8             // =1000
               	csel	x2, x16, xzr, ne
               	ldrb	w3, [sp]
               	add	x2, x2, x3
               	ldrb	w3, [sp, #0x1]
               	add	x2, x2, x3
               	ldrb	w3, [sp, #0x2]
               	add	x2, x2, x3
               	add	x1, x1, x2
               	add	x0, x0, x1
               	mov	x1, sp
               	mov	x2, #0x2                // =2
               	movk	x2, #0x3, lsl #32
               	str	x2, [sp]
               	mov	x2, #0x4                // =4
               	movk	x2, #0x5, lsl #32
               	str	x2, [sp, #0x8]
               	mov	x2, #0x6                // =6
               	movk	x2, #0x7, lsl #32
               	str	x2, [sp, #0x10]
               	mov	x2, #0x8                // =8
               	movk	x2, #0x9, lsl #32
               	str	x2, [sp, #0x18]
               	tst	x1, #0x1f
               	mov	x16, #0x3e8             // =1000
               	csel	x1, x16, xzr, ne
               	ldrsw	x2, [sp]
               	add	x1, x1, x2
               	ldrsw	x2, [sp, #0x4]
               	add	x1, x1, x2
               	ldrsw	x2, [sp, #0x8]
               	add	x1, x1, x2
               	ldrsw	x2, [sp, #0xc]
               	add	x1, x1, x2
               	ldrsw	x2, [sp, #0x10]
               	add	x1, x1, x2
               	ldrsw	x2, [sp, #0x14]
               	add	x1, x1, x2
               	ldrsw	x2, [sp, #0x18]
               	add	x1, x1, x2
               	ldrsw	x2, [sp, #0x1c]
               	add	x1, x1, x2
               	mov	x2, sp
               	mov	x3, #0x2                // =2
               	mov	x4, #0x102              // =258
               	strh	w4, [sp]
               	strb	w3, [sp, #0x2]
               	tst	x2, #0x3f
               	mov	x16, #0x3e8             // =1000
               	csel	x2, x16, xzr, ne
               	ldrb	w3, [sp]
               	add	x2, x2, x3
               	ldrb	w3, [sp, #0x1]
               	add	x2, x2, x3
               	ldrb	w3, [sp, #0x2]
               	add	x2, x2, x3
               	add	x1, x1, x2
               	add	x0, x0, x1
               	cmp	w0, #0x78
               	b.ne	<addr>
               	add	x0, sp, #0x20
               	and	x0, x0, #0xf
               	cbnz	w0, <addr>
               	mov	x0, #0x0                // =0
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
