
int128_cmp.aarch64:	file format elf64-littleaarch64

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
               	adrp	x1, <page>
               	ldr	x2, [x1, #0x18]
               	mov	x0, #0x0                // =0
               	adrp	x3, <page>
               	ldr	x4, [x3, #0x10]
               	orr	x4, x0, x4
               	ldr	x5, [x1, #0x18]
               	ldr	x6, [x3, #0x10]
               	adrp	x1, <page>
               	ldr	x7, [x1, #0x20]
               	add	x6, x6, x7
               	orr	x7, x0, x6
               	ldr	x6, [x1, #0x20]
               	cmp	x6, #0x0
               	cset	x8, hi
               	neg	x11, x6
               	neg	x6, x8
               	ldr	x8, [x1, #0x20]
               	lsl	x8, x8, #63
               	ldr	x12, [x1, #0x20]
               	eor	x9, x4, x7
               	eor	x10, x2, x5
               	orr	x9, x9, x10
               	cbz	x9, <addr>
               	ldr	x9, [x1, #0x20]
               	eor	x9, x2, x9, lsl #63
               	eor	x9, x2, x9
               	cbnz	x9, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	cmp	x2, x5
               	cset	x10, lo
               	cmp	x2, x5
               	cset	x9, eq
               	cmp	x4, x7
               	cset	x13, lo
               	and	x13, x9, x13
               	orr	x10, x10, x13
               	cbz	w10, <addr>
               	cmp	x5, x2
               	cset	x5, lo
               	cmp	x7, x4
               	cset	x7, lo
               	and	x7, x9, x7
               	orr	x5, x5, x7
               	cbnz	w5, <addr>
               	cmp	x2, x6
               	cset	x5, lo
               	cmp	x2, x6
               	cset	x7, eq
               	cmp	x4, x11
               	cset	x9, lo
               	and	x7, x7, x9
               	orr	x5, x5, x7
               	cbz	w5, <addr>
               	ldr	x5, [x1, #0x20]
               	cmp	x5, x2
               	cset	x7, lo
               	cmp	x5, x2
               	cset	x5, eq
               	cmp	x4, #0x0
               	cset	x9, hi
               	and	x5, x5, x9
               	orr	x5, x7, x5
               	cbnz	w5, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	ldr	x5, [x3, #0x10]
               	ldr	x5, [x1, #0x20]
               	cmp	x5, #0x0
               	b.hi	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	cmp	w6, #0x0
               	cset	x7, lt
               	cmp	w6, #0x0
               	cset	x5, eq
               	cmp	x11, x12
               	cset	x9, lo
               	and	x9, x5, x9
               	orr	x7, x7, x9
               	cbz	w7, <addr>
               	cmp	x12, x11
               	cset	x7, lo
               	and	x5, x5, x7
               	cbnz	w5, <addr>
               	cmp	x8, x6
               	cset	x5, lt
               	cmp	x8, x6
               	cset	x7, eq
               	cmp	x11, #0x0
               	cset	x9, hi
               	and	x7, x7, x9
               	orr	x5, x5, x7
               	cbz	w5, <addr>
               	cmp	x8, #0x0
               	cset	x5, lt
               	cmp	x8, #0x0
               	cset	x7, eq
               	cmp	x12, #0x0
               	cset	x9, hi
               	and	x7, x7, x9
               	orr	x5, x5, x7
               	cbnz	w5, <addr>
               	mov	x0, #0x7                // =7
               	ret
               	cmp	x6, x8
               	cset	x5, lt
               	cmp	w5, #0x1
               	b.eq	<addr>
               	cmp	x6, #0x0
               	b.ls	<addr>
               	cmp	x8, #0x0
               	b.hi	<addr>
               	mov	x0, #0x9                // =9
               	ret
               	ldr	x5, [x1, #0x20]
               	ldr	x6, [x1, #0x20]
               	cmp	x5, x6
               	cset	x8, lt
               	cmp	x5, x6
               	cset	x7, eq
               	orr	x8, x8, x7
               	cbz	w8, <addr>
               	cmp	x5, x6
               	cset	x5, lo
               	orr	x5, x5, x7
               	cbnz	w5, <addr>
               	mov	x0, #0xb                // =11
               	ret
               	ldr	x6, [x3, #0x10]
               	cmp	x2, #0x0
               	cset	x5, eq
               	cmp	x4, x6
               	cset	x6, lo
               	and	x6, x5, x6
               	cbnz	x6, <addr>
               	ldr	x1, [x1, #0x20]
               	cmp	x2, #0x0
               	cset	x2, hi
               	cmp	x1, x4
               	cset	x1, lo
               	and	x1, x5, x1
               	orr	x1, x2, x1
               	cbz	w1, <addr>
               	ldr	x1, [x3, #0x10]
               	ldr	x2, [x3, #0x10]
               	eor	x1, x1, x2
               	cbz	x1, <addr>
               	mov	x0, #0xc                // =12
               	ret
               	ret
               	mov	x0, #0xa                // =10
               	ret
               	mov	x0, #0x8                // =8
               	ret
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x2                // =2
               	ret
