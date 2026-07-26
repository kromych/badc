
int128_struct_member.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<bump>:
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
               	sub	sp, sp, #0x2a0
               	stp	x20, x21, [sp]
               	sub	sp, sp, #0xd0
               	mov	x16, sp
               	and	sp, x16, #0xfffffffffffffff0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0]
               	mov	x1, #0x0                // =0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	orr	x20, x1, x0
               	orr	x21, x2, x1
               	sub	x0, x29, #0x120
               	str	x20, [x0]
               	str	x21, [x0, #0x8]
               	mov	x1, sp
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
               	eor	x0, x1, x20
               	eor	x1, x2, x21
               	orr	x0, x0, x1
               	cmp	x0, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x5                // =5
               	sub	sp, x29, #0x2a0
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x2a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	eor	x0, x1, x20
               	eor	x1, x2, x21
               	orr	x0, x0, x1
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	sub	sp, x29, #0x2a0
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x2a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	mov	x17, #0x0               // =0
               	eor	x0, x1, x17
               	mov	x17, #0x1000000000      // =68719476736
               	eor	x1, x2, x17
               	orr	x0, x0, x1
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0, #0x8]
               	mov	x17, #0x1000000000      // =68719476736
               	cmp	x1, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	sub	sp, x29, #0x2a0
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x2a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, sp, #0x10
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
               	add	x1, sp, #0x10
               	ldrsw	x1, [x1]
               	cmp	x1, #0x1
               	cset	x1, ne
               	cbnz	x1, <addr>
               	add	x0, sp, #0x10
               	ldrsw	x0, [x0, #0x20]
               	cmp	x0, #0x2
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	add	x0, sp, #0x10
               	ldr	x1, [x0, #0x10]
               	ldr	x2, [x0, #0x18]
               	eor	x0, x1, x20
               	eor	x1, x2, x21
               	orr	x0, x0, x1
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	sub	sp, x29, #0x2a0
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x2a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	eor	x0, x20, x20
               	eor	x1, x21, x21
               	orr	x0, x0, x1
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	sub	sp, x29, #0x2a0
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x2a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, sp, #0x70
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
               	add	x1, sp, #0x70
               	str	w0, [x1]
               	mov	x0, sp
               	add	x1, sp, #0x70
               	add	x1, x1, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x1, #0x2                // =2
               	add	x0, sp, #0x70
               	str	w1, [x0, #0x20]
               	add	x2, sp, #0x70
               	mov	x0, #0x3                // =3
               	mov	x3, #0x1                // =1
               	sub	x1, x29, #0x1b8
               	str	x0, [x1]
               	str	x3, [x1, #0x8]
               	mov	x0, x2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	add	x0, sp, #0x70
               	ldrsw	x0, [x0]
               	cmp	x0, #0x2
               	cset	x0, ne
               	cbnz	x0, <addr>
               	add	x0, sp, #0x70
               	ldrsw	x0, [x0, #0x20]
               	cmp	x0, #0x2
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	sub	sp, x29, #0x2a0
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x2a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, sp, #0x70
               	bl	<addr>
               	sub	x16, x29, #0x1d0
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x1d0
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	mov	x17, #0x7               // =7
               	eor	x0, x1, x17
               	mov	x17, #0xa               // =10
               	eor	x1, x2, x17
               	orr	x0, x0, x1
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	sub	sp, x29, #0x2a0
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x2a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, sp, #0x70
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
               	add	x1, sp, #0x70
               	ldr	x2, [x1, #0x10]
               	ldr	x1, [x1, #0x18]
               	eor	x2, x2, x0
               	eor	x0, x1, x0
               	orr	x0, x2, x0
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	add	x0, sp, #0x70
               	ldrsw	x0, [x0]
               	cmp	x0, #0x2
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	add	x0, sp, #0x70
               	ldrsw	x0, [x0, #0x20]
               	cmp	x0, #0x2
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xc                // =12
               	sub	sp, x29, #0x2a0
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x2a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, sp, #0x70
               	add	x0, x0, #0x10
               	mov	x1, sp
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	add	x0, sp, #0x70
               	bl	<addr>
               	sub	x16, x29, #0x230
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x230
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	eor	x0, x1, x20
               	eor	x1, x2, x21
               	orr	x0, x0, x1
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	sub	sp, x29, #0x2a0
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x2a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	eor	x0, x20, x20
               	eor	x1, x21, x21
               	orr	x0, x0, x1
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xf                // =15
               	sub	sp, x29, #0x2a0
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x2a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	sub	sp, x29, #0x2a0
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x2a0
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
