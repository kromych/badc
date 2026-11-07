
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
               	ldr	x1, [x2, #0x20]
               	mov	x0, #0x0                // =0
               	adrp	x5, <page>
               	ldr	x3, [x5, #0x18]
               	orr	x4, x0, x3
               	ldr	x7, [x2, #0x20]
               	ldr	x3, [x5, #0x18]
               	adrp	x2, <page>
               	ldr	x6, [x2, #0x28]
               	add	x3, x3, x6
               	orr	x9, x0, x3
               	ldr	x3, [x2, #0x28]
               	cmp	x3, #0x0
               	cset	x6, hi
               	neg	x8, x3
               	neg	x3, x6
               	ldr	x6, [x2, #0x28]
               	lsl	x6, x6, #63
               	ldr	x10, [x2, #0x28]
               	eor	x11, x4, x9
               	eor	x12, x1, x7
               	orr	x11, x11, x12
               	cbz	x11, <addr>
               	ldr	x11, [x2, #0x28]
               	eor	x11, x1, x11, lsl #63
               	eor	x11, x1, x11
               	cbnz	x11, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	cmp	x1, x7
               	cset	x12, lo
               	cmp	x1, x7
               	cset	x11, eq
               	cmp	x4, x9
               	cset	x13, lo
               	and	x13, x11, x13
               	orr	x12, x12, x13
               	cbz	w12, <addr>
               	cmp	x7, x1
               	cset	x7, lo
               	cmp	x9, x4
               	cset	x9, lo
               	and	x9, x11, x9
               	orr	x7, x7, x9
               	cbnz	w7, <addr>
               	cmp	x1, x3
               	cset	x7, lo
               	cmp	x1, x3
               	cset	x9, eq
               	cmp	x4, x8
               	cset	x11, lo
               	and	x9, x9, x11
               	orr	x7, x7, x9
               	cbz	w7, <addr>
               	ldr	x7, [x2, #0x28]
               	cmp	x7, x1
               	cset	x9, lo
               	cmp	x7, x1
               	cset	x7, eq
               	cmp	x4, #0x0
               	cset	x11, hi
               	and	x7, x7, x11
               	orr	x7, x9, x7
               	cbnz	w7, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	ldr	x7, [x5, #0x18]
               	ldr	x7, [x2, #0x28]
               	cmp	x7, #0x0
               	b.hi	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	cmp	w3, #0x0
               	cset	x9, lt
               	cmp	w3, #0x0
               	cset	x7, eq
               	cmp	x8, x10
               	cset	x11, lo
               	and	x11, x7, x11
               	orr	x9, x9, x11
               	cbz	w9, <addr>
               	cmp	x10, x8
               	cset	x9, lo
               	and	x7, x7, x9
               	cbnz	w7, <addr>
               	cmp	x6, x3
               	cset	x7, lt
               	cmp	x6, x3
               	cset	x9, eq
               	cmp	x8, #0x0
               	cset	x8, hi
               	and	x8, x9, x8
               	orr	x7, x7, x8
               	cbz	w7, <addr>
               	cmp	x6, #0x0
               	cset	x7, lt
               	cmp	x6, #0x0
               	cset	x8, eq
               	cmp	x10, #0x0
               	cset	x9, hi
               	and	x8, x8, x9
               	orr	x7, x7, x8
               	cbnz	w7, <addr>
               	mov	x0, #0x7                // =7
               	ret
               	cmp	x3, x6
               	cset	x7, lt
               	cmp	w7, #0x1
               	b.eq	<addr>
               	cmp	x3, #0x0
               	b.ls	<addr>
               	cmp	x6, #0x0
               	b.hi	<addr>
               	mov	x0, #0x9                // =9
               	ret
               	ldr	x3, [x2, #0x28]
               	ldr	x6, [x2, #0x28]
               	cmp	x3, x6
               	cset	x8, lt
               	cmp	x3, x6
               	cset	x7, eq
               	orr	x8, x8, x7
               	cbz	w8, <addr>
               	cmp	x3, x6
               	cset	x3, lo
               	orr	x3, x3, x7
               	cbnz	w3, <addr>
               	mov	x0, #0xb                // =11
               	ret
               	ldr	x6, [x5, #0x18]
               	cmp	x1, #0x0
               	cset	x3, eq
               	cmp	x4, x6
               	cset	x6, lo
               	and	x6, x3, x6
               	cbnz	x6, <addr>
               	ldr	x2, [x2, #0x28]
               	cmp	x1, #0x0
               	cset	x1, hi
               	cmp	x2, x4
               	cset	x2, lo
               	and	x2, x3, x2
               	orr	x1, x1, x2
               	cbz	w1, <addr>
               	ldr	x1, [x5, #0x18]
               	ldr	x2, [x5, #0x18]
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
