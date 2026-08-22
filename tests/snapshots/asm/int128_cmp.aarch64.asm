
int128_cmp.aarch64:	file format elf64-littleaarch64

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
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x3, [x2]
               	mov	x6, #0x0                // =0
               	adrp	x8, <page>
               	add	x8, x8, <lo12>
               	ldr	x0, [x8]
               	orr	x1, x6, x0
               	orr	x0, x3, x6
               	ldr	x3, [x2]
               	ldr	x2, [x8]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	x5, [x4]
               	add	x2, x2, x5
               	orr	x7, x6, x2
               	orr	x2, x3, x6
               	ldr	x5, [x4]
               	cmp	x5, #0x0
               	cset	x3, hi
               	sub	x9, x6, x5
               	sub	x3, x6, x3
               	ldr	x10, [x4]
               	lsl	x5, x10, #63
               	ldr	x10, [x4]
               	eor	x13, x1, x1
               	eor	x14, x0, x0
               	orr	x11, x13, x14
               	cmp	x11, #0x0
               	cset	x12, eq
               	cmp	x12, #0x0
               	cset	x12, eq
               	cbnz	x11, <addr>
               	cmp	x11, #0x0
               	cset	x12, ne
               	cbz	x12, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	eor	x11, x1, x7
               	eor	x12, x0, x2
               	orr	x11, x11, x12
               	cmp	x11, #0x0
               	cset	x12, eq
               	cbz	x11, <addr>
               	mov	x12, x6
               	cbz	x12, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	ldr	x11, [x4]
               	lsl	x11, x11, #63
               	mov	x17, #0x0               // =0
               	eor	x12, x1, x17
               	eor	x11, x0, x11
               	eor	x6, x1, x12
               	eor	x11, x0, x11
               	orr	x6, x6, x11
               	cbnz	x6, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	cmp	x0, x2
               	cset	x13, lo
               	cmp	x0, x2
               	cset	x11, eq
               	cmp	x1, x7
               	cset	x14, lo
               	and	x15, x11, x14
               	orr	x12, x13, x15
               	mov	x6, #0x1                // =1
               	cbz	x12, <addr>
               	cmp	x2, x0
               	cset	x12, lo
               	cmp	x7, x1
               	cset	x20, lo
               	and	x20, x11, x20
               	orr	x12, x12, x20
               	cmp	x12, #0x0
               	cset	x12, ne
               	cbnz	x12, <addr>
               	cmp	x2, x0
               	cset	x12, lo
               	cmp	x7, x1
               	cset	x20, lo
               	and	x20, x11, x20
               	orr	x12, x12, x20
               	mov	x17, #0x1               // =1
               	eor	x12, x12, x17
               	cmp	x12, #0x0
               	cset	x12, eq
               	cbnz	x12, <addr>
               	cmp	x2, x0
               	cset	x12, lo
               	cmp	x7, x1
               	cset	x20, lo
               	and	x20, x11, x20
               	orr	x12, x12, x20
               	mov	x17, #0x1               // =1
               	eor	x12, x12, x17
               	cmp	x12, #0x0
               	cset	x12, eq
               	cbnz	x12, <addr>
               	orr	x6, x13, x15
               	mov	x17, #0x1               // =1
               	eor	x6, x6, x17
               	cmp	x6, #0x0
               	cset	x6, ne
               	cbnz	x6, <addr>
               	cmp	x0, x2
               	cset	x6, lo
               	cmp	x0, x2
               	cset	x2, eq
               	cmp	x1, x7
               	cset	x7, lo
               	and	x2, x2, x7
               	orr	x2, x6, x2
               	mov	x17, #0x1               // =1
               	eor	x6, x2, x17
               	cbz	x6, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	cmp	x0, x3
               	cset	x2, lo
               	cmp	x0, x3
               	cset	x6, eq
               	cmp	x1, x9
               	cset	x7, lo
               	and	x6, x6, x7
               	orr	x6, x2, x6
               	cmp	x6, #0x0
               	cset	x2, eq
               	cbz	x6, <addr>
               	ldr	x6, [x4]
               	cmp	x6, x0
               	cset	x2, lo
               	cmp	x6, x0
               	cset	x6, eq
               	cmp	x1, #0x0
               	cset	x7, hi
               	and	x6, x6, x7
               	orr	x2, x2, x6
               	cmp	x2, #0x0
               	cset	x2, eq
               	cbz	x2, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	ldr	x7, [x8]
               	ldr	x6, [x4]
               	cmp	x6, #0x0
               	cset	x2, hi
               	cmp	x6, #0x0
               	cset	x6, eq
               	cmp	x7, #0x0
               	cset	x7, lo
               	and	x6, x6, x7
               	orr	x2, x2, x6
               	cbnz	x2, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	cmp	x3, #0x0
               	cset	x2, lt
               	cmp	x3, #0x0
               	cset	x7, eq
               	cmp	x9, x10
               	cset	x6, lo
               	and	x6, x7, x6
               	orr	x6, x2, x6
               	mov	x2, #0x1                // =1
               	cbz	x6, <addr>
               	cmp	x10, x9
               	cset	x6, lo
               	and	x6, x7, x6
               	mov	x17, #0x0               // =0
               	orr	x6, x6, x17
               	cmp	x6, #0x0
               	cset	x6, ne
               	cbnz	x6, <addr>
               	cmp	x5, x3
               	cset	x6, lt
               	cmp	x5, x3
               	cset	x11, eq
               	cmp	x9, #0x0
               	cset	x12, hi
               	and	x11, x11, x12
               	orr	x6, x6, x11
               	cmp	x6, #0x0
               	cset	x6, eq
               	cbnz	x6, <addr>
               	cmp	x5, #0x0
               	cset	x6, lt
               	cmp	x5, #0x0
               	cset	x11, eq
               	cmp	x10, #0x0
               	cset	x12, hi
               	and	x11, x11, x12
               	orr	x6, x6, x11
               	cmp	x6, #0x0
               	cset	x6, eq
               	cbz	x6, <addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	cmp	x3, x5
               	cset	x6, lt
               	cmp	x3, x5
               	cset	x11, eq
               	cmp	x9, #0x0
               	cset	x12, lo
               	and	x11, x11, x12
               	orr	x6, x6, x11
               	mov	x17, #0x1               // =1
               	eor	x6, x6, x17
               	cbz	x6, <addr>
               	cmp	x5, #0x0
               	cset	x6, lt
               	cmp	x5, #0x0
               	cset	x11, eq
               	cmp	x10, #0x0
               	cset	x12, hi
               	and	x11, x11, x12
               	orr	x6, x6, x11
               	cmp	x6, #0x0
               	cset	x6, eq
               	cbnz	x6, <addr>
               	mov	x2, #0x0                // =0
               	cbnz	x2, <addr>
               	mov	x2, #0x0                // =0
               	cbz	x2, <addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	cmp	x3, #0x0
               	cset	x2, hi
               	cmp	x10, x9
               	cset	x3, lo
               	and	x3, x7, x3
               	orr	x3, x2, x3
               	cmp	x3, #0x0
               	cset	x2, eq
               	cbz	x3, <addr>
               	cmp	x5, #0x0
               	cset	x2, hi
               	cmp	x5, #0x0
               	cset	x3, eq
               	cmp	x10, #0x0
               	cset	x5, lo
               	and	x3, x3, x5
               	orr	x2, x2, x3
               	cmp	x2, #0x0
               	cset	x2, eq
               	cbz	x2, <addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	ldr	x3, [x4]
               	mov	x5, #0x0                // =0
               	orr	x2, x3, x5
               	ldr	x6, [x4]
               	orr	x3, x6, x5
               	cmp	x2, x3
               	cset	x6, lt
               	cmp	x2, x3
               	cset	x7, eq
               	mov	x17, #0x1               // =1
               	and	x9, x7, x17
               	orr	x6, x6, x9
               	cmp	x6, #0x0
               	cset	x10, eq
               	cbz	x6, <addr>
               	mov	x10, x5
               	cbz	x10, <addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	cmp	x2, x3
               	cset	x6, lo
               	orr	x2, x6, x9
               	cbnz	x2, <addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	ldr	x2, [x8]
               	cmp	x0, #0x0
               	cset	x6, lo
               	cmp	x0, #0x0
               	cset	x3, eq
               	cmp	x1, x2
               	cset	x2, lo
               	and	x2, x3, x2
               	orr	x6, x6, x2
               	mov	x2, #0x1                // =1
               	cbnz	x6, <addr>
               	ldr	x2, [x4]
               	cmp	x0, #0x0
               	cset	x4, hi
               	cmp	x2, x1
               	cset	x0, lo
               	and	x0, x3, x0
               	orr	x0, x4, x0
               	cmp	x0, #0x0
               	cset	x2, eq
               	cbnz	x2, <addr>
               	ldr	x1, [x8]
               	ldr	x0, [x8]
               	eor	x0, x1, x0
               	mov	x17, #0x0               // =0
               	orr	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, x5
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x6, x2
               	b	<addr>
               	b	<addr>
               	mov	x6, x2
               	b	<addr>
               	mov	x6, x2
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x12, x6
               	b	<addr>
               	mov	x12, x6
               	b	<addr>
               	mov	x12, x6
               	b	<addr>
               	b	<addr>
               	b	<addr>
