
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
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x4, [x2]
               	mov	x3, #0x0                // =0
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	ldr	x0, [x7]
               	orr	x1, x3, x0
               	orr	x0, x4, x3
               	ldr	x5, [x2]
               	ldr	x2, [x7]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	x6, [x4]
               	add	x2, x2, x6
               	orr	x6, x3, x2
               	orr	x2, x5, x3
               	ldr	x8, [x4]
               	cmp	x8, #0x0
               	cset	x5, hi
               	sub	x8, x3, x8
               	mov	x3, #0x0                // =0
               	sub	x3, x3, x5
               	ldr	x9, [x4]
               	lsl	x5, x9, #63
               	ldr	x9, [x4]
               	eor	x10, x1, x1
               	eor	x11, x0, x0
               	orr	x10, x10, x11
               	cmp	x10, #0x0
               	cset	x10, eq
               	cmp	x10, #0x0
               	cset	x10, eq
               	cbnz	x10, <addr>
               	eor	x10, x1, x1
               	eor	x11, x0, x0
               	orr	x10, x10, x11
               	cmp	x10, #0x0
               	cset	x10, ne
               	cbz	x10, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	eor	x10, x1, x6
               	eor	x11, x0, x2
               	orr	x10, x10, x11
               	cmp	x10, #0x0
               	cset	x10, eq
               	cbnz	x10, <addr>
               	mov	x10, #0x0               // =0
               	cbz	x10, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldr	x11, [x4]
               	lsl	x11, x11, #63
               	mov	x17, #0x0               // =0
               	eor	x12, x1, x17
               	eor	x11, x0, x11
               	eor	x10, x1, x12
               	eor	x11, x0, x11
               	orr	x10, x10, x11
               	cmp	x10, #0x0
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	cmp	x0, x2
               	cset	x10, lo
               	cmp	x0, x2
               	cset	x11, eq
               	cmp	x1, x6
               	cset	x12, lo
               	and	x11, x11, x12
               	orr	x10, x10, x11
               	cmp	x10, #0x0
               	cset	x11, eq
               	mov	x10, #0x1               // =1
               	cbnz	x11, <addr>
               	cmp	x2, x0
               	cset	x10, lo
               	cmp	x2, x0
               	cset	x11, eq
               	cmp	x6, x1
               	cset	x12, lo
               	and	x11, x11, x12
               	orr	x10, x10, x11
               	cmp	x10, #0x0
               	cset	x10, ne
               	mov	x11, #0x1               // =1
               	cbnz	x10, <addr>
               	cmp	x2, x0
               	cset	x10, lo
               	cmp	x2, x0
               	cset	x11, eq
               	cmp	x6, x1
               	cset	x12, lo
               	and	x11, x11, x12
               	orr	x10, x10, x11
               	mov	x17, #0x1               // =1
               	eor	x10, x10, x17
               	cmp	x10, #0x0
               	cset	x10, eq
               	cmp	x10, #0x0
               	cset	x11, ne
               	mov	x12, #0x1               // =1
               	cbnz	x11, <addr>
               	cmp	x2, x0
               	cset	x10, lo
               	cmp	x2, x0
               	cset	x11, eq
               	cmp	x6, x1
               	cset	x12, lo
               	and	x11, x11, x12
               	orr	x10, x10, x11
               	mov	x17, #0x1               // =1
               	eor	x10, x10, x17
               	cmp	x10, #0x0
               	cset	x10, eq
               	cmp	x10, #0x0
               	cset	x12, ne
               	mov	x10, #0x1               // =1
               	cbnz	x12, <addr>
               	cmp	x0, x2
               	cset	x10, lo
               	cmp	x0, x2
               	cset	x11, eq
               	cmp	x1, x6
               	cset	x12, lo
               	and	x11, x11, x12
               	orr	x10, x10, x11
               	mov	x17, #0x1               // =1
               	eor	x10, x10, x17
               	cmp	x10, #0x0
               	cset	x10, ne
               	cbnz	x10, <addr>
               	cmp	x0, x2
               	cset	x10, lo
               	cmp	x0, x2
               	cset	x2, eq
               	cmp	x1, x6
               	cset	x6, lo
               	and	x2, x2, x6
               	orr	x2, x10, x2
               	mov	x17, #0x1               // =1
               	eor	x10, x2, x17
               	cbz	x10, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	cmp	x0, x3
               	cset	x2, lo
               	cmp	x0, x3
               	cset	x6, eq
               	cmp	x1, x8
               	cset	x10, lo
               	and	x6, x6, x10
               	orr	x2, x2, x6
               	cmp	x2, #0x0
               	cset	x2, eq
               	cbnz	x2, <addr>
               	ldr	x6, [x4]
               	cmp	x6, x0
               	cset	x2, lo
               	cmp	x6, x0
               	cset	x6, eq
               	cmp	x1, #0x0
               	cset	x10, hi
               	and	x6, x6, x10
               	orr	x2, x2, x6
               	cmp	x2, #0x0
               	cset	x2, eq
               	cbz	x2, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	ldr	x10, [x7]
               	ldr	x6, [x4]
               	cmp	x6, #0x0
               	cset	x2, hi
               	cmp	x6, #0x0
               	cset	x6, eq
               	cmp	x10, #0x0
               	cset	x10, lo
               	and	x6, x6, x10
               	orr	x2, x2, x6
               	cmp	x2, #0x0
               	b.ne	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	cmp	x3, #0x0
               	cset	x2, lt
               	cmp	x3, #0x0
               	cset	x6, eq
               	cmp	x8, x9
               	cset	x10, lo
               	and	x6, x6, x10
               	orr	x2, x2, x6
               	cmp	x2, #0x0
               	cset	x2, eq
               	mov	x6, #0x1                // =1
               	cbnz	x2, <addr>
               	cmp	x3, #0x0
               	cset	x2, eq
               	cmp	x9, x8
               	cset	x6, lo
               	and	x2, x2, x6
               	mov	x17, #0x0               // =0
               	orr	x2, x2, x17
               	cmp	x2, #0x0
               	cset	x6, ne
               	mov	x2, #0x1                // =1
               	cbnz	x6, <addr>
               	cmp	x5, x3
               	cset	x2, lt
               	cmp	x5, x3
               	cset	x6, eq
               	cmp	x8, #0x0
               	cset	x10, hi
               	and	x6, x6, x10
               	orr	x2, x2, x6
               	cmp	x2, #0x0
               	cset	x2, eq
               	cmp	x2, #0x0
               	cset	x2, ne
               	cbnz	x2, <addr>
               	cmp	x5, #0x0
               	cset	x2, lt
               	cmp	x5, #0x0
               	cset	x6, eq
               	cmp	x9, #0x0
               	cset	x10, hi
               	and	x6, x6, x10
               	orr	x2, x2, x6
               	cmp	x2, #0x0
               	cset	x2, eq
               	cbz	x2, <addr>
               	mov	x0, #0x7                // =7
               	ret
               	cmp	x3, x5
               	cset	x2, lt
               	cmp	x3, x5
               	cset	x6, eq
               	cmp	x8, #0x0
               	cset	x10, lo
               	and	x6, x6, x10
               	orr	x2, x2, x6
               	mov	x17, #0x1               // =1
               	eor	x2, x2, x17
               	cmp	x2, #0x0
               	cset	x2, eq
               	mov	x6, #0x1                // =1
               	cbnz	x2, <addr>
               	cmp	x5, #0x0
               	cset	x2, lt
               	cmp	x5, #0x0
               	cset	x6, eq
               	cmp	x9, #0x0
               	cset	x10, hi
               	and	x6, x6, x10
               	orr	x2, x2, x6
               	cmp	x2, #0x0
               	cset	x2, eq
               	cmp	x2, #0x0
               	cset	x6, ne
               	mov	x2, #0x1                // =1
               	cbnz	x6, <addr>
               	mov	x2, #0x0                // =0
               	cbnz	x2, <addr>
               	mov	x2, #0x0                // =0
               	cbz	x2, <addr>
               	mov	x0, #0x8                // =8
               	ret
               	cmp	x3, #0x0
               	cset	x2, hi
               	cmp	x3, #0x0
               	cset	x3, eq
               	cmp	x9, x8
               	cset	x6, lo
               	and	x3, x3, x6
               	orr	x2, x2, x3
               	cmp	x2, #0x0
               	cset	x2, eq
               	cbnz	x2, <addr>
               	cmp	x5, #0x0
               	cset	x2, hi
               	cmp	x5, #0x0
               	cset	x3, eq
               	cmp	x9, #0x0
               	cset	x5, lo
               	and	x3, x3, x5
               	orr	x2, x2, x3
               	cmp	x2, #0x0
               	cset	x2, eq
               	cbz	x2, <addr>
               	mov	x0, #0x9                // =9
               	ret
               	ldr	x3, [x4]
               	mov	x5, #0x0                // =0
               	orr	x2, x3, x5
               	ldr	x6, [x4]
               	orr	x3, x6, x5
               	cmp	x2, x3
               	cset	x5, lt
               	cmp	x2, x3
               	cset	x6, eq
               	mov	x17, #0x1               // =1
               	and	x6, x6, x17
               	orr	x5, x5, x6
               	cmp	x5, #0x0
               	cset	x5, eq
               	cbnz	x5, <addr>
               	mov	x5, #0x0                // =0
               	cbz	x5, <addr>
               	mov	x0, #0xa                // =10
               	ret
               	cmp	x2, x3
               	cset	x5, lo
               	cmp	x2, x3
               	cset	x2, eq
               	mov	x17, #0x1               // =1
               	and	x2, x2, x17
               	orr	x2, x5, x2
               	cmp	x2, #0x0
               	b.ne	<addr>
               	mov	x0, #0xb                // =11
               	ret
               	ldr	x2, [x7]
               	cmp	x0, #0x0
               	cset	x3, lo
               	cmp	x0, #0x0
               	cset	x5, eq
               	cmp	x1, x2
               	cset	x2, lo
               	and	x2, x5, x2
               	orr	x3, x3, x2
               	mov	x2, #0x1                // =1
               	cbnz	x3, <addr>
               	ldr	x2, [x4]
               	cmp	x0, #0x0
               	cset	x3, hi
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x2, x1
               	cset	x1, lo
               	and	x0, x0, x1
               	orr	x0, x3, x0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x2, ne
               	cbnz	x2, <addr>
               	ldr	x1, [x7]
               	ldr	x0, [x7]
               	eor	x0, x1, x0
               	mov	x17, #0x0               // =0
               	orr	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0xc                // =12
               	ret
               	mov	x0, #0x0                // =0
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
