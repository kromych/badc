
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
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x0, [x1]
               	mov	x3, #0x0                // =0
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldr	x2, [x5]
               	orr	x2, x3, x2
               	ldr	x6, [x1]
               	ldr	x4, [x5]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x7, [x1]
               	add	x4, x4, x7
               	orr	x8, x3, x4
               	ldr	x3, [x1]
               	cmp	x3, #0x0
               	cset	x4, hi
               	neg	x7, x3
               	neg	x3, x4
               	ldr	x4, [x1]
               	lsl	x4, x4, #63
               	ldr	x9, [x1]
               	eor	x10, x2, x2
               	eor	x11, x0, x0
               	orr	x11, x10, x11
               	cbnz	x11, <addr>
               	cbz	x11, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	eor	x11, x2, x8
               	eor	x12, x0, x6
               	orr	x11, x11, x12
               	cbz	x11, <addr>
               	ldr	x11, [x1]
               	lsl	x11, x11, #63
               	eor	x11, x0, x11
               	eor	x11, x0, x11
               	orr	x10, x10, x11
               	cbnz	x10, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	cmp	x0, x6
               	cset	x11, lo
               	cmp	x0, x6
               	cset	x10, eq
               	cmp	x2, x8
               	cset	x12, lo
               	and	x12, x10, x12
               	orr	x11, x11, x12
               	cbz	w11, <addr>
               	cmp	x6, x0
               	cset	x6, lo
               	cmp	x8, x2
               	cset	x8, lo
               	and	x8, x10, x8
               	orr	x6, x6, x8
               	cbnz	w6, <addr>
               	cmp	x0, x3
               	cset	x6, lo
               	cmp	x0, x3
               	cset	x8, eq
               	cmp	x2, x7
               	cset	x10, lo
               	and	x8, x8, x10
               	orr	x6, x6, x8
               	cbz	w6, <addr>
               	ldr	x6, [x1]
               	cmp	x6, x0
               	cset	x8, lo
               	cmp	x6, x0
               	cset	x6, eq
               	cmp	x2, #0x0
               	cset	x10, hi
               	and	x6, x6, x10
               	orr	x6, x8, x6
               	cbnz	w6, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	ldr	x6, [x5]
               	ldr	x6, [x1]
               	cmp	x6, #0x0
               	b.hi	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	cmp	w3, #0x0
               	cset	x8, lt
               	cmp	w3, #0x0
               	cset	x6, eq
               	cmp	x7, x9
               	cset	x10, lo
               	and	x10, x6, x10
               	orr	x8, x8, x10
               	cbz	w8, <addr>
               	cmp	x9, x7
               	cset	x8, lo
               	and	x6, x6, x8
               	cbnz	w6, <addr>
               	cmp	x4, x3
               	cset	x6, lt
               	cmp	x4, x3
               	cset	x8, eq
               	cmp	x7, #0x0
               	cset	x7, hi
               	and	x7, x8, x7
               	orr	x6, x6, x7
               	cbz	w6, <addr>
               	cmp	x4, #0x0
               	cset	x6, lt
               	cmp	x4, #0x0
               	cset	x7, eq
               	cmp	x9, #0x0
               	cset	x8, hi
               	and	x7, x7, x8
               	orr	x6, x6, x7
               	cbnz	w6, <addr>
               	mov	x0, #0x7                // =7
               	ret
               	cmp	x3, x4
               	cset	x6, lt
               	eor	x6, x6, #0x1
               	cbz	w6, <addr>
               	cmp	x3, #0x0
               	b.ls	<addr>
               	cmp	x4, #0x0
               	b.hi	<addr>
               	mov	x0, #0x9                // =9
               	ret
               	ldr	x3, [x1]
               	ldr	x4, [x1]
               	cmp	x3, x4
               	cset	x7, lt
               	cmp	x3, x4
               	cset	x6, eq
               	orr	x7, x7, x6
               	cbz	w7, <addr>
               	cmp	x3, x4
               	cset	x3, lo
               	orr	x3, x3, x6
               	cbnz	w3, <addr>
               	mov	x0, #0xb                // =11
               	ret
               	ldr	x4, [x5]
               	cmp	x0, #0x0
               	cset	x3, eq
               	cmp	x2, x4
               	cset	x4, lo
               	and	x4, x3, x4
               	cbnz	x4, <addr>
               	ldr	x1, [x1]
               	cmp	x0, #0x0
               	cset	x0, hi
               	cmp	x1, x2
               	cset	x1, lo
               	and	x1, x3, x1
               	orr	x0, x0, x1
               	cbz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	ldr	x0, [x0]
               	eor	x0, x1, x0
               	cbz	x0, <addr>
               	mov	x0, #0xc                // =12
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0xa                // =10
               	ret
               	mov	x0, #0x8                // =8
               	ret
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x2                // =2
               	ret
