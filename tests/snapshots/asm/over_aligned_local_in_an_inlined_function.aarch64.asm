
over_aligned_local_in_an_inlined_function.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x40
               	mov	x16, sp
               	and	sp, x16, #0xffffffffffffffc0
               	add	x0, sp, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	mov	x8, sp
               	mov	x0, #0x0                // =0
               	str	w0, [sp]
               	mov	x1, #0x1                // =1
               	str	w1, [sp, #0x4]
               	mov	x2, #0x2                // =2
               	str	w2, [sp, #0x8]
               	mov	x3, #0x3                // =3
               	str	w3, [sp, #0xc]
               	mov	x4, #0x4                // =4
               	str	w4, [sp, #0x10]
               	mov	x5, #0x5                // =5
               	str	w5, [sp, #0x14]
               	mov	x6, #0x6                // =6
               	str	w6, [sp, #0x18]
               	mov	x7, #0x7                // =7
               	str	w7, [sp, #0x1c]
               	mov	x9, #0x3e8              // =1000
               	tst	x8, #0x1f
               	csel	x8, x9, x0, ne
               	ldrsw	x9, [sp, #0x4]
               	add	x8, x8, x9
               	ldrsw	x9, [sp, #0x8]
               	add	x8, x8, x9
               	ldrsw	x9, [sp, #0xc]
               	add	x8, x8, x9
               	ldrsw	x9, [sp, #0x10]
               	add	x8, x8, x9
               	ldrsw	x9, [sp, #0x14]
               	add	x8, x8, x9
               	ldrsw	x9, [sp, #0x18]
               	add	x8, x8, x9
               	ldrsw	x9, [sp, #0x1c]
               	add	x8, x8, x9
               	mov	x9, sp
               	strb	w0, [sp]
               	strb	w1, [sp, #0x1]
               	strb	w2, [sp, #0x2]
               	mov	x1, #0x3e8              // =1000
               	tst	x9, #0x3f
               	csel	x0, x1, x0, ne
               	ldrb	w1, [sp, #0x1]
               	add	x0, x0, x1
               	ldrb	w1, [sp, #0x2]
               	add	x0, x0, x1
               	add	x2, x8, x0
               	mov	x0, #0x1                // =1
               	str	w0, [sp]
               	mov	x0, sp
               	mov	x1, #0x2                // =2
               	str	w1, [sp, #0x4]
               	str	w3, [sp, #0x8]
               	str	w4, [sp, #0xc]
               	str	w5, [sp, #0x10]
               	str	w6, [sp, #0x14]
               	str	w7, [sp, #0x18]
               	mov	x1, #0x8                // =8
               	str	w1, [sp, #0x1c]
               	mov	x3, #0x3e8              // =1000
               	mov	x4, #0x0                // =0
               	tst	x0, #0x1f
               	csel	x0, x3, x4, ne
               	ldrsw	x3, [sp]
               	add	x0, x0, x3
               	ldrsw	x3, [sp, #0x4]
               	add	x0, x0, x3
               	ldrsw	x3, [sp, #0x8]
               	add	x0, x0, x3
               	ldrsw	x3, [sp, #0xc]
               	add	x0, x0, x3
               	ldrsw	x3, [sp, #0x10]
               	add	x0, x0, x3
               	ldrsw	x3, [sp, #0x14]
               	add	x0, x0, x3
               	mov	x3, sp
               	ldrsw	x4, [sp, #0x18]
               	add	x0, x0, x4
               	ldrsw	x4, [sp, #0x1c]
               	add	x4, x0, x4
               	mov	x5, sp
               	mov	x0, #0x1                // =1
               	strb	w0, [sp]
               	strb	w0, [sp, #0x1]
               	mov	x0, #0x2                // =2
               	strb	w0, [sp, #0x2]
               	mov	x6, #0x3e8              // =1000
               	mov	x7, #0x0                // =0
               	tst	x5, #0x3f
               	csel	x5, x6, x7, ne
               	ldrb	w6, [sp]
               	add	x5, x5, x6
               	ldrb	w6, [sp, #0x1]
               	add	x5, x5, x6
               	ldrb	w6, [sp, #0x2]
               	add	x5, x5, x6
               	add	x4, x4, x5
               	add	x2, x2, x4
               	str	w0, [sp]
               	mov	x4, #0x3                // =3
               	str	w4, [sp, #0x4]
               	mov	x4, #0x4                // =4
               	str	w4, [sp, #0x8]
               	mov	x4, #0x5                // =5
               	str	w4, [sp, #0xc]
               	mov	x4, #0x6                // =6
               	str	w4, [sp, #0x10]
               	mov	x4, #0x7                // =7
               	str	w4, [sp, #0x14]
               	str	w1, [sp, #0x18]
               	mov	x1, #0x9                // =9
               	str	w1, [sp, #0x1c]
               	mov	x1, #0x3e8              // =1000
               	mov	x4, #0x0                // =0
               	tst	x3, #0x1f
               	csel	x1, x1, x4, ne
               	ldrsw	x3, [sp]
               	add	x1, x1, x3
               	ldrsw	x3, [sp, #0x4]
               	add	x1, x1, x3
               	ldrsw	x3, [sp, #0x8]
               	add	x1, x1, x3
               	ldrsw	x3, [sp, #0xc]
               	add	x1, x1, x3
               	ldrsw	x3, [sp, #0x10]
               	add	x1, x1, x3
               	ldrsw	x3, [sp, #0x14]
               	add	x1, x1, x3
               	ldrsw	x3, [sp, #0x18]
               	add	x1, x1, x3
               	ldrsw	x3, [sp, #0x1c]
               	add	x1, x1, x3
               	mov	x3, sp
               	strb	w0, [sp]
               	mov	x4, #0x1                // =1
               	strb	w4, [sp, #0x1]
               	strb	w0, [sp, #0x2]
               	mov	x0, #0x3e8              // =1000
               	mov	x4, #0x0                // =0
               	tst	x3, #0x3f
               	csel	x0, x0, x4, ne
               	ldrb	w3, [sp]
               	add	x0, x0, x3
               	ldrb	w3, [sp, #0x1]
               	add	x0, x0, x3
               	ldrb	w3, [sp, #0x2]
               	add	x0, x0, x3
               	add	x0, x1, x0
               	add	x0, x2, x0
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
