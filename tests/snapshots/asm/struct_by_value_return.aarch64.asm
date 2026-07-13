
struct_by_value_return.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x2, x29, #0x8
               	str	w0, [x2]
               	sub	x0, x29, #0x8
               	str	w1, [x0, #0x4]
               	sub	x0, x29, #0x8
               	mov	x16, x0
               	ldr	x0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<clobber>:
               	mov	x17, #0x1589            // =5513
               	movk	x17, #0x12, lsl #16
               	add	x0, x0, x17
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ret

<sum_pair_pair>:
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x16, x29, #0x8
               	str	x0, [x16]
               	sub	x16, x29, #0x10
               	str	x1, [x16]
               	sub	x1, x29, #0x18
               	sub	x0, x29, #0x8
               	ldrsw	x0, [x0]
               	sub	x2, x29, #0x10
               	ldrsw	x2, [x2]
               	add	x0, x0, x2
               	str	w0, [x1]
               	sub	x1, x29, #0x18
               	sub	x0, x29, #0x8
               	ldrsw	x2, [x0, #0x4]
               	sub	x0, x29, #0x10
               	ldrsw	x0, [x0, #0x4]
               	add	x0, x2, x0
               	str	w0, [x1, #0x4]
               	sub	x0, x29, #0x18
               	mov	x16, x0
               	ldr	x0, [x16]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xc0
               	sub	x1, x29, #0x8
               	mov	x0, #0xb                // =11
               	mov	x2, #0x16               // =22
               	sub	x3, x29, #0x90
               	str	w0, [x3]
               	sub	x0, x29, #0x90
               	str	w2, [x0, #0x4]
               	sub	x0, x29, #0x90
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x8
               	ldrsw	x0, [x0]
               	cmp	x0, #0xb
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x16
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x20
               	mov	x0, #0x3                // =3
               	mov	x2, #0x4                // =4
               	sub	x3, x29, #0x98
               	str	w0, [x3]
               	sub	x0, x29, #0x98
               	str	w2, [x0, #0x4]
               	sub	x0, x29, #0x98
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x20
               	ldrsw	x0, [x0]
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x30
               	mov	x0, #0x64               // =100
               	mov	x2, #0xc8               // =200
               	sub	x3, x29, #0xa0
               	str	w0, [x3]
               	sub	x0, x29, #0xa0
               	str	w2, [x0, #0x4]
               	sub	x0, x29, #0xa0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x1, x29, #0x38
               	mov	x0, #0x12c              // =300
               	mov	x2, #0x190              // =400
               	sub	x3, x29, #0xa8
               	str	w0, [x3]
               	sub	x0, x29, #0xa8
               	str	w2, [x0, #0x4]
               	sub	x0, x29, #0xa8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x30
               	ldrsw	x0, [x0]
               	cmp	x0, #0x64
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x30
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0xc8
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x38
               	ldrsw	x0, [x0]
               	cmp	x0, #0x12c
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x38
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x190
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x50
               	mov	x0, #0x1                // =1
               	mov	x1, #0x2                // =2
               	sub	x2, x29, #0xb0
               	str	w0, [x2]
               	sub	x0, x29, #0xb0
               	str	w1, [x0, #0x4]
               	sub	x0, x29, #0xb0
               	mov	x1, #0x3                // =3
               	mov	x2, #0x4                // =4
               	sub	x4, x29, #0xb8
               	str	w1, [x4]
               	sub	x1, x29, #0xb8
               	str	w2, [x1, #0x4]
               	sub	x1, x29, #0xb8
               	sub	x4, x29, #0xc0
               	ldrsw	x2, [x0]
               	ldrsw	x5, [x1]
               	add	x2, x2, x5
               	str	w2, [x4]
               	sub	x2, x29, #0xc0
               	ldrsw	x0, [x0, #0x4]
               	ldrsw	x1, [x1, #0x4]
               	add	x0, x0, x1
               	str	w0, [x2, #0x4]
               	sub	x0, x29, #0xc0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	sub	x0, x29, #0x50
               	ldrsw	x0, [x0]
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x50
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x6
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
