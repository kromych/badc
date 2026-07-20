
int128_cmp.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x2a0
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	x3, [x4]
               	sub	x1, x29, #0x80
               	str	x3, [x1]
               	mov	x0, #0x0                // =0
               	str	x0, [x1, #0x8]
               	sub	x1, x29, #0x90
               	str	x0, [x1]
               	str	x3, [x1, #0x8]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x1, [x2]
               	orr	x5, x0, x1
               	orr	x3, x3, x0
               	sub	x1, x29, #0xa0
               	str	x5, [x1]
               	str	x3, [x1, #0x8]
               	sub	x3, x29, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x3]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x3
               	ldr	x3, [x4]
               	sub	x1, x29, #0xb0
               	str	x3, [x1]
               	str	x0, [x1, #0x8]
               	sub	x1, x29, #0xc0
               	str	x0, [x1]
               	str	x3, [x1, #0x8]
               	ldr	x4, [x2]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x5, [x1]
               	add	x4, x4, x5
               	orr	x4, x0, x4
               	orr	x5, x3, x0
               	sub	x3, x29, #0xd0
               	str	x4, [x3]
               	str	x5, [x3, #0x8]
               	sub	x4, x29, #0x20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x4]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x3, x4
               	ldr	x4, [x1]
               	sub	x3, x29, #0xe0
               	str	x4, [x3]
               	str	x0, [x3, #0x8]
               	cmp	x4, #0x0
               	cset	x3, hi
               	sub	x4, x0, x4
               	sub	x5, x0, x0
               	sub	x5, x5, x3
               	sub	x3, x29, #0xf0
               	str	x4, [x3]
               	str	x5, [x3, #0x8]
               	sub	x4, x29, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x4]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x3, x4
               	ldr	x4, [x1]
               	sub	x3, x29, #0x100
               	str	x4, [x3]
               	str	x0, [x3, #0x8]
               	lsl	x4, x4, #63
               	sub	x3, x29, #0x110
               	str	x0, [x3]
               	str	x4, [x3, #0x8]
               	sub	x4, x29, #0x40
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x4]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x3, x4
               	ldr	x4, [x1]
               	sub	x3, x29, #0x120
               	str	x4, [x3]
               	str	x0, [x3, #0x8]
               	sub	x0, x29, #0x50
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x0]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x10
               	ldr	x3, [x0]
               	ldr	x4, [x0, #0x8]
               	sub	x0, x29, #0x10
               	ldr	x5, [x0]
               	ldr	x0, [x0, #0x8]
               	eor	x3, x3, x5
               	eor	x0, x4, x0
               	orr	x0, x3, x0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, eq
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x10
               	ldr	x3, [x0]
               	ldr	x4, [x0, #0x8]
               	sub	x0, x29, #0x10
               	ldr	x5, [x0]
               	ldr	x0, [x0, #0x8]
               	eor	x3, x3, x5
               	eor	x0, x4, x0
               	orr	x0, x3, x0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x2a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	x3, [x0]
               	ldr	x4, [x0, #0x8]
               	sub	x0, x29, #0x20
               	ldr	x5, [x0]
               	ldr	x0, [x0, #0x8]
               	eor	x3, x3, x5
               	eor	x0, x4, x0
               	orr	x0, x3, x0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x10
               	ldr	x3, [x0]
               	ldr	x4, [x0, #0x8]
               	sub	x0, x29, #0x20
               	ldr	x5, [x0]
               	ldr	x0, [x0, #0x8]
               	eor	x3, x3, x5
               	eor	x0, x4, x0
               	orr	x0, x3, x0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x2a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	x5, [x0]
               	ldr	x6, [x0, #0x8]
               	sub	x0, x29, #0x10
               	ldr	x7, [x0]
               	ldr	x8, [x0, #0x8]
               	ldr	x4, [x1]
               	sub	x0, x29, #0x140
               	str	x4, [x0]
               	mov	x3, #0x0                // =0
               	str	x3, [x0, #0x8]
               	lsl	x4, x4, #63
               	sub	x0, x29, #0x150
               	str	x3, [x0]
               	str	x4, [x0, #0x8]
               	eor	x3, x7, x3
               	eor	x4, x8, x4
               	sub	x0, x29, #0x160
               	str	x3, [x0]
               	str	x4, [x0, #0x8]
               	eor	x0, x5, x3
               	eor	x3, x6, x4
               	orr	x0, x0, x3
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x2a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	x4, [x0]
               	ldr	x3, [x0, #0x8]
               	sub	x0, x29, #0x20
               	ldr	x5, [x0]
               	ldr	x0, [x0, #0x8]
               	cmp	x3, x0
               	cset	x6, lo
               	cmp	x3, x0
               	cset	x0, eq
               	cmp	x4, x5
               	cset	x3, lo
               	and	x0, x0, x3
               	orr	x0, x6, x0
               	cmp	x0, #0x0
               	cset	x3, eq
               	mov	x0, #0x1                // =1
               	cbnz	x3, <addr>
               	sub	x0, x29, #0x10
               	ldr	x4, [x0]
               	ldr	x3, [x0, #0x8]
               	sub	x0, x29, #0x20
               	ldr	x5, [x0]
               	ldr	x0, [x0, #0x8]
               	cmp	x0, x3
               	cset	x6, lo
               	cmp	x0, x3
               	cset	x0, eq
               	cmp	x5, x4
               	cset	x3, lo
               	and	x0, x0, x3
               	orr	x0, x6, x0
               	cmp	x0, #0x0
               	cset	x0, ne
               	mov	x3, #0x1                // =1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x10
               	ldr	x4, [x0]
               	ldr	x3, [x0, #0x8]
               	sub	x0, x29, #0x20
               	ldr	x5, [x0]
               	ldr	x0, [x0, #0x8]
               	cmp	x0, x3
               	cset	x6, lo
               	cmp	x0, x3
               	cset	x0, eq
               	cmp	x5, x4
               	cset	x3, lo
               	and	x0, x0, x3
               	orr	x0, x6, x0
               	mov	x17, #0x1               // =1
               	eor	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x3, ne
               	mov	x4, #0x1                // =1
               	cbnz	x3, <addr>
               	sub	x0, x29, #0x20
               	ldr	x4, [x0]
               	ldr	x3, [x0, #0x8]
               	sub	x0, x29, #0x10
               	ldr	x5, [x0]
               	ldr	x0, [x0, #0x8]
               	cmp	x3, x0
               	cset	x6, lo
               	cmp	x3, x0
               	cset	x0, eq
               	cmp	x4, x5
               	cset	x3, lo
               	and	x0, x0, x3
               	orr	x0, x6, x0
               	mov	x17, #0x1               // =1
               	eor	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x4, ne
               	mov	x0, #0x1                // =1
               	cbnz	x4, <addr>
               	sub	x0, x29, #0x20
               	ldr	x4, [x0]
               	ldr	x3, [x0, #0x8]
               	sub	x0, x29, #0x10
               	ldr	x5, [x0]
               	ldr	x0, [x0, #0x8]
               	cmp	x0, x3
               	cset	x6, lo
               	cmp	x0, x3
               	cset	x0, eq
               	cmp	x5, x4
               	cset	x3, lo
               	and	x0, x0, x3
               	orr	x0, x6, x0
               	mov	x17, #0x1               // =1
               	eor	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x10
               	ldr	x4, [x0]
               	ldr	x3, [x0, #0x8]
               	sub	x0, x29, #0x20
               	ldr	x5, [x0]
               	ldr	x0, [x0, #0x8]
               	cmp	x3, x0
               	cset	x6, lo
               	cmp	x3, x0
               	cset	x0, eq
               	cmp	x4, x5
               	cset	x3, lo
               	and	x0, x0, x3
               	orr	x0, x6, x0
               	mov	x17, #0x1               // =1
               	eor	x0, x0, x17
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x2a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	x4, [x0]
               	ldr	x3, [x0, #0x8]
               	sub	x0, x29, #0x30
               	ldr	x5, [x0]
               	ldr	x0, [x0, #0x8]
               	cmp	x3, x0
               	cset	x6, lo
               	cmp	x3, x0
               	cset	x0, eq
               	cmp	x4, x5
               	cset	x3, lo
               	and	x0, x0, x3
               	orr	x0, x6, x0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cbnz	x0, <addr>
               	ldr	x3, [x1]
               	sub	x0, x29, #0x1a0
               	str	x3, [x0]
               	mov	x4, #0x0                // =0
               	str	x4, [x0, #0x8]
               	sub	x0, x29, #0x1b0
               	str	x4, [x0]
               	str	x3, [x0, #0x8]
               	sub	x0, x29, #0x10
               	ldr	x5, [x0]
               	ldr	x0, [x0, #0x8]
               	cmp	x3, x0
               	cset	x6, lo
               	cmp	x3, x0
               	cset	x0, eq
               	cmp	x4, x5
               	cset	x3, lo
               	and	x0, x0, x3
               	orr	x0, x6, x0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x2a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x5, [x2]
               	sub	x3, x29, #0x1c0
               	str	x5, [x3]
               	mov	x0, #0x0                // =0
               	str	x0, [x3, #0x8]
               	ldr	x4, [x1]
               	sub	x3, x29, #0x1d0
               	str	x4, [x3]
               	str	x0, [x3, #0x8]
               	sub	x3, x29, #0x1e0
               	str	x0, [x3]
               	str	x4, [x3, #0x8]
               	cmp	x0, x4
               	cset	x3, lo
               	cmp	x0, x4
               	cset	x4, eq
               	cmp	x5, x0
               	cset	x0, lo
               	and	x0, x4, x0
               	orr	x0, x3, x0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x2a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x30
               	ldr	x4, [x0]
               	ldr	x3, [x0, #0x8]
               	sub	x0, x29, #0x50
               	ldr	x5, [x0]
               	ldr	x0, [x0, #0x8]
               	cmp	x3, x0
               	cset	x6, lt
               	cmp	x3, x0
               	cset	x0, eq
               	cmp	x4, x5
               	cset	x3, lo
               	and	x0, x0, x3
               	orr	x0, x6, x0
               	cmp	x0, #0x0
               	cset	x0, eq
               	mov	x3, #0x1                // =1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x30
               	ldr	x4, [x0]
               	ldr	x3, [x0, #0x8]
               	sub	x0, x29, #0x50
               	ldr	x5, [x0]
               	ldr	x0, [x0, #0x8]
               	cmp	x0, x3
               	cset	x6, lt
               	cmp	x0, x3
               	cset	x0, eq
               	cmp	x5, x4
               	cset	x3, lo
               	and	x0, x0, x3
               	orr	x0, x6, x0
               	cmp	x0, #0x0
               	cset	x3, ne
               	mov	x0, #0x1                // =1
               	cbnz	x3, <addr>
               	sub	x0, x29, #0x40
               	ldr	x4, [x0]
               	ldr	x3, [x0, #0x8]
               	sub	x0, x29, #0x30
               	ldr	x5, [x0]
               	ldr	x0, [x0, #0x8]
               	cmp	x3, x0
               	cset	x6, lt
               	cmp	x3, x0
               	cset	x0, eq
               	cmp	x4, x5
               	cset	x3, lo
               	and	x0, x0, x3
               	orr	x0, x6, x0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x40
               	ldr	x4, [x0]
               	ldr	x3, [x0, #0x8]
               	sub	x0, x29, #0x50
               	ldr	x5, [x0]
               	ldr	x0, [x0, #0x8]
               	cmp	x3, x0
               	cset	x6, lt
               	cmp	x3, x0
               	cset	x0, eq
               	cmp	x4, x5
               	cset	x3, lo
               	and	x0, x0, x3
               	orr	x0, x6, x0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x2a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x30
               	ldr	x4, [x0]
               	ldr	x3, [x0, #0x8]
               	sub	x0, x29, #0x40
               	ldr	x5, [x0]
               	ldr	x0, [x0, #0x8]
               	cmp	x3, x0
               	cset	x6, lt
               	cmp	x3, x0
               	cset	x0, eq
               	cmp	x4, x5
               	cset	x3, lo
               	and	x0, x0, x3
               	orr	x0, x6, x0
               	mov	x17, #0x1               // =1
               	eor	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	mov	x3, #0x1                // =1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x50
               	ldr	x4, [x0]
               	ldr	x3, [x0, #0x8]
               	sub	x0, x29, #0x40
               	ldr	x5, [x0]
               	ldr	x0, [x0, #0x8]
               	cmp	x0, x3
               	cset	x6, lt
               	cmp	x0, x3
               	cset	x0, eq
               	cmp	x5, x4
               	cset	x3, lo
               	and	x0, x0, x3
               	orr	x0, x6, x0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x3, ne
               	mov	x0, #0x1                // =1
               	cbnz	x3, <addr>
               	sub	x0, x29, #0x40
               	ldr	x4, [x0]
               	ldr	x3, [x0, #0x8]
               	sub	x0, x29, #0x40
               	ldr	x5, [x0]
               	ldr	x0, [x0, #0x8]
               	cmp	x0, x3
               	cset	x6, lt
               	cmp	x0, x3
               	cset	x0, eq
               	cmp	x5, x4
               	cset	x3, lo
               	and	x0, x0, x3
               	orr	x0, x6, x0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x40
               	ldr	x4, [x0]
               	ldr	x3, [x0, #0x8]
               	sub	x0, x29, #0x40
               	ldr	x5, [x0]
               	ldr	x0, [x0, #0x8]
               	cmp	x0, x3
               	cset	x6, lt
               	cmp	x0, x3
               	cset	x0, eq
               	cmp	x5, x4
               	cset	x3, lo
               	and	x0, x0, x3
               	orr	x0, x6, x0
               	mov	x17, #0x1               // =1
               	eor	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x2a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x30
               	ldr	x4, [x0]
               	ldr	x3, [x0, #0x8]
               	sub	x0, x29, #0x50
               	ldr	x5, [x0]
               	ldr	x0, [x0, #0x8]
               	cmp	x0, x3
               	cset	x6, lo
               	cmp	x0, x3
               	cset	x0, eq
               	cmp	x5, x4
               	cset	x3, lo
               	and	x0, x0, x3
               	orr	x0, x6, x0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x40
               	ldr	x4, [x0]
               	ldr	x3, [x0, #0x8]
               	sub	x0, x29, #0x50
               	ldr	x5, [x0]
               	ldr	x0, [x0, #0x8]
               	cmp	x0, x3
               	cset	x6, lo
               	cmp	x0, x3
               	cset	x0, eq
               	cmp	x5, x4
               	cset	x3, lo
               	and	x0, x0, x3
               	orr	x0, x6, x0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x2a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x4, [x1]
               	sub	x3, x29, #0x228
               	str	x4, [x3]
               	mov	x0, #0x0                // =0
               	str	x0, [x3, #0x8]
               	sub	x3, x29, #0x238
               	str	x0, [x3]
               	str	x4, [x3, #0x8]
               	mov	x17, #0x5               // =5
               	orr	x5, x0, x17
               	orr	x4, x4, x0
               	sub	x3, x29, #0x248
               	str	x5, [x3]
               	str	x4, [x3, #0x8]
               	sub	x4, x29, #0x60
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x4]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x3, x4
               	ldr	x4, [x1]
               	sub	x3, x29, #0x258
               	str	x4, [x3]
               	str	x0, [x3, #0x8]
               	sub	x3, x29, #0x268
               	str	x0, [x3]
               	str	x4, [x3, #0x8]
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	orr	x3, x0, x17
               	orr	x4, x4, x0
               	sub	x0, x29, #0x278
               	str	x3, [x0]
               	str	x4, [x0, #0x8]
               	sub	x3, x29, #0x70
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	sub	x0, x29, #0x60
               	ldr	x4, [x0]
               	ldr	x3, [x0, #0x8]
               	sub	x0, x29, #0x70
               	ldr	x5, [x0]
               	ldr	x0, [x0, #0x8]
               	cmp	x3, x0
               	cset	x6, lt
               	cmp	x3, x0
               	cset	x0, eq
               	cmp	x4, x5
               	cset	x3, lo
               	and	x0, x0, x3
               	orr	x0, x6, x0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x60
               	ldr	x4, [x0]
               	ldr	x3, [x0, #0x8]
               	sub	x0, x29, #0x70
               	ldr	x5, [x0]
               	ldr	x0, [x0, #0x8]
               	cmp	x3, x0
               	cset	x6, lt
               	cmp	x3, x0
               	cset	x0, eq
               	cmp	x4, x5
               	cset	x3, lo
               	and	x0, x0, x3
               	orr	x0, x6, x0
               	mov	x17, #0x1               // =1
               	eor	x0, x0, x17
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x2a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x60
               	ldr	x4, [x0]
               	ldr	x3, [x0, #0x8]
               	sub	x0, x29, #0x70
               	ldr	x5, [x0]
               	ldr	x0, [x0, #0x8]
               	cmp	x3, x0
               	cset	x6, lo
               	cmp	x3, x0
               	cset	x0, eq
               	cmp	x4, x5
               	cset	x3, lo
               	and	x0, x0, x3
               	orr	x0, x6, x0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x2a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	x3, [x0]
               	ldr	x0, [x0, #0x8]
               	ldr	x4, [x2]
               	cmp	x0, #0x0
               	cset	x5, lo
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x3, x4
               	cset	x3, lo
               	and	x0, x0, x3
               	orr	x3, x5, x0
               	mov	x0, #0x1                // =1
               	cbnz	x3, <addr>
               	sub	x0, x29, #0x10
               	ldr	x3, [x0]
               	ldr	x0, [x0, #0x8]
               	ldr	x1, [x1]
               	cmp	x0, #0x0
               	cset	x4, hi
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x1, x3
               	cset	x1, lo
               	and	x0, x0, x1
               	orr	x0, x4, x0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldr	x3, [x2]
               	sub	x0, x29, #0x2a0
               	str	x3, [x0]
               	mov	x1, #0x0                // =0
               	str	x1, [x0, #0x8]
               	ldr	x0, [x2]
               	eor	x0, x3, x0
               	eor	x1, x1, x1
               	orr	x0, x0, x1
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x2a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
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
