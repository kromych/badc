
int128_struct_member.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x16, x29, #0x10
               	str	x1, [x16]
               	str	x2, [x16, #0x8]
               	add	x2, x0, #0x10
               	ldr	x3, [x2]
               	ldr	x5, [x0, #0x18]
               	sub	x1, x29, #0x10
               	ldr	x4, [x1]
               	ldr	x1, [x1, #0x8]
               	add	x4, x3, x4
               	cmp	x4, x3
               	cset	x3, lo
               	add	x1, x5, x1
               	add	x3, x1, x3
               	sub	x1, x29, #0x20
               	str	x4, [x1]
               	str	x3, [x1, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x2
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret

<read_wide>:
               	add	x0, x0, #0x10
               	mov	x16, x0
               	ldr	x1, [x16, #0x8]
               	ldr	x0, [x16]
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x290
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0]
               	sub	x0, x29, #0x100
               	str	x2, [x0]
               	mov	x1, #0x0                // =0
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x110
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	orr	x3, x1, x0
               	orr	x1, x2, x1
               	sub	x0, x29, #0x120
               	str	x3, [x0]
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	cmp	x1, #0x1
               	cset	x2, ne
               	mov	x1, #0x1                // =1
               	cbnz	x2, <addr>
               	ldrsw	x1, [x0, #0x20]
               	cmp	x1, #0x2
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldr	x1, [x0, #0x10]
               	ldr	x2, [x0, #0x18]
               	sub	x0, x29, #0x10
               	ldr	x3, [x0]
               	ldr	x0, [x0, #0x8]
               	eor	x1, x1, x3
               	eor	x0, x2, x0
               	orr	x0, x1, x0
               	cmp	x0, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	sub	x0, x29, #0x10
               	ldr	x3, [x0]
               	ldr	x0, [x0, #0x8]
               	eor	x1, x1, x3
               	eor	x0, x2, x0
               	orr	x0, x1, x0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x3, [x0]
               	ldr	x4, [x0, #0x8]
               	mov	x2, #0x1                // =1
               	sub	x0, x29, #0x148
               	str	x2, [x0]
               	mov	x1, #0x0                // =0
               	str	x1, [x0, #0x8]
               	lsl	x2, x2, #36
               	sub	x0, x29, #0x158
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	eor	x0, x3, x1
               	eor	x1, x4, x2
               	orr	x0, x0, x1
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0, #0x8]
               	mov	x2, #0x0                // =0
               	sub	x0, x29, #0x168
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	mov	x17, #0x1000000000      // =68719476736
               	cmp	x1, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x1, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [x1, #0x20]
               	str	x10, [x0, #0x20]
               	ldr	x10, [x1, #0x28]
               	str	x10, [x0, #0x28]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x70
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x1, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [x1, #0x20]
               	str	x10, [x0, #0x20]
               	ldr	x10, [x1, #0x28]
               	str	x10, [x0, #0x28]
               	ldr	x10, [sp], #0x10
               	mov	x0, #0x1                // =1
               	sub	x1, x29, #0x70
               	str	w0, [x1]
               	sub	x1, x29, #0x10
               	sub	x2, x29, #0x70
               	add	x2, x2, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x2
               	mov	x2, #0x2                // =2
               	sub	x1, x29, #0x70
               	str	w2, [x1, #0x20]
               	sub	x1, x29, #0x40
               	ldrsw	x1, [x1]
               	cmp	x1, #0x1
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x40
               	ldrsw	x0, [x0, #0x20]
               	cmp	x0, #0x2
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x40
               	ldr	x1, [x0, #0x10]
               	ldr	x2, [x0, #0x18]
               	sub	x0, x29, #0x10
               	ldr	x3, [x0]
               	ldr	x0, [x0, #0x8]
               	eor	x1, x1, x3
               	eor	x0, x2, x0
               	orr	x0, x1, x0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x70
               	ldrsw	x0, [x0]
               	cmp	x0, #0x1
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x70
               	ldrsw	x0, [x0, #0x20]
               	cmp	x0, #0x2
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x70
               	ldr	x1, [x0, #0x10]
               	ldr	x2, [x0, #0x18]
               	sub	x0, x29, #0x10
               	ldr	x3, [x0]
               	ldr	x0, [x0, #0x8]
               	eor	x1, x1, x3
               	eor	x0, x2, x0
               	orr	x0, x1, x0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x1, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [x1, #0x20]
               	str	x10, [x0, #0x20]
               	ldr	x10, [x1, #0x28]
               	str	x10, [x0, #0x28]
               	ldr	x10, [sp], #0x10
               	mov	x1, #0x1                // =1
               	sub	x0, x29, #0xa0
               	str	w1, [x0]
               	sub	x0, x29, #0x10
               	sub	x2, x29, #0xa0
               	add	x2, x2, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	mov	x2, #0x2                // =2
               	sub	x0, x29, #0xa0
               	str	w2, [x0, #0x20]
               	sub	x3, x29, #0xa0
               	sub	x0, x29, #0x198
               	str	x1, [x0]
               	mov	x2, #0x0                // =0
               	str	x2, [x0, #0x8]
               	sub	x0, x29, #0x1a8
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	mov	x17, #0x3               // =3
               	orr	x0, x2, x17
               	orr	x2, x1, x2
               	sub	x1, x29, #0x1b8
               	str	x0, [x1]
               	str	x2, [x1, #0x8]
               	mov	x0, x3
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	sub	x0, x29, #0xa0
               	ldrsw	x0, [x0]
               	cmp	x0, #0x2
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0xa0
               	ldrsw	x0, [x0, #0x20]
               	cmp	x0, #0x2
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa0
               	bl	<addr>
               	sub	x16, x29, #0x1d0
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x1d0
               	ldr	x4, [x0]
               	ldr	x5, [x0, #0x8]
               	mov	x2, #0xa                // =10
               	sub	x0, x29, #0x1e0
               	str	x2, [x0]
               	mov	x1, #0x0                // =0
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x1f0
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	mov	x17, #0x7               // =7
               	orr	x3, x1, x17
               	orr	x1, x2, x1
               	sub	x0, x29, #0x200
               	str	x3, [x0]
               	str	x1, [x0, #0x8]
               	eor	x0, x4, x3
               	eor	x1, x5, x1
               	orr	x0, x0, x1
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa0
               	add	x2, x0, #0x10
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x210
               	str	x0, [x1]
               	str	x0, [x1, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x2
               	sub	x1, x29, #0xa0
               	ldr	x2, [x1, #0x10]
               	ldr	x1, [x1, #0x18]
               	eor	x2, x2, x0
               	eor	x0, x1, x0
               	orr	x0, x2, x0
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	sub	x0, x29, #0xa0
               	ldrsw	x0, [x0]
               	cmp	x0, #0x2
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0xa0
               	ldrsw	x0, [x0, #0x20]
               	cmp	x0, #0x2
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa0
               	add	x0, x0, #0x10
               	sub	x1, x29, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0xa0
               	bl	<addr>
               	sub	x16, x29, #0x230
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x230
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	sub	x0, x29, #0x10
               	ldr	x3, [x0]
               	ldr	x0, [x0, #0x8]
               	eor	x1, x1, x3
               	eor	x0, x2, x0
               	orr	x0, x1, x0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xf0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x1, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [x1, #0x20]
               	str	x10, [x0, #0x20]
               	ldr	x10, [x1, #0x28]
               	str	x10, [x0, #0x28]
               	ldr	x10, [sp], #0x10
               	mov	x1, #0x1                // =1
               	sub	x0, x29, #0x240
               	str	x1, [x0]
               	mov	x2, #0x0                // =0
               	str	x2, [x0, #0x8]
               	sub	x3, x29, #0xf0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	sub	x0, x29, #0x10
               	sub	x3, x29, #0xf0
               	add	x3, x3, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	sub	x0, x29, #0x250
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	lsl	x3, x1, #63
               	sub	x0, x29, #0x260
               	str	x2, [x0]
               	str	x3, [x0, #0x8]
               	sub	x3, x29, #0xf0
               	add	x3, x3, #0x20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	sub	x0, x29, #0xf0
               	ldr	x3, [x0]
               	ldr	x0, [x0, #0x8]
               	eor	x1, x3, x1
               	eor	x0, x0, x2
               	orr	x0, x1, x0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0xf0
               	ldr	x1, [x0, #0x10]
               	ldr	x2, [x0, #0x18]
               	sub	x0, x29, #0x10
               	ldr	x3, [x0]
               	ldr	x0, [x0, #0x8]
               	eor	x1, x1, x3
               	eor	x0, x2, x0
               	orr	x0, x1, x0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xf0
               	ldr	x3, [x0, #0x20]
               	ldr	x4, [x0, #0x28]
               	mov	x2, #0x1                // =1
               	sub	x0, x29, #0x280
               	str	x2, [x0]
               	mov	x1, #0x0                // =0
               	str	x1, [x0, #0x8]
               	lsl	x2, x2, #63
               	sub	x0, x29, #0x290
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	eor	x0, x3, x1
               	eor	x1, x4, x2
               	orr	x0, x0, x1
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0xf0
               	ldr	x0, [x0, #0x20]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x290
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
               	b	<addr>
