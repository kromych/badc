
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
               	ldr	x0, [x2]
               	mov	x3, #0x0                // =0
               	adrp	x9, <page>
               	add	x9, x9, <lo12>
               	ldr	x1, [x9]
               	orr	x1, x3, x1
               	ldr	x2, [x2]
               	ldr	x5, [x9]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	x6, [x4]
               	add	x5, x5, x6
               	orr	x6, x3, x5
               	ldr	x5, [x4]
               	cmp	x5, #0x0
               	cset	x8, hi
               	sub	x7, x3, x5
               	sub	x3, x3, x8
               	ldr	x5, [x4]
               	lsl	x5, x5, #63
               	ldr	x8, [x4]
               	eor	x11, x1, x1
               	eor	x12, x0, x0
               	orr	x10, x11, x12
               	cbnz	x10, <addr>
               	cbz	x10, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	eor	x10, x1, x6
               	eor	x12, x0, x2
               	orr	x10, x10, x12
               	cbz	x10, <addr>
               	ldr	x10, [x4]
               	lsl	x10, x10, #63
               	eor	x10, x0, x10
               	eor	x10, x0, x10
               	orr	x10, x11, x10
               	cbnz	x10, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	cmp	x0, x2
               	cset	x11, lo
               	cmp	x0, x2
               	cset	x10, eq
               	cmp	x1, x6
               	cset	x12, lo
               	and	x12, x10, x12
               	orr	x11, x11, x12
               	cbz	w11, <addr>
               	cmp	x2, x0
               	cset	x11, lo
               	cmp	x6, x1
               	cset	x12, lo
               	and	x10, x10, x12
               	orr	x10, x11, x10
               	cbnz	w10, <addr>
               	cmp	x0, x3
               	cset	x2, lo
               	cmp	x0, x3
               	cset	x6, eq
               	cmp	x1, x7
               	cset	x10, lo
               	and	x6, x6, x10
               	orr	x2, x2, x6
               	cbz	w2, <addr>
               	ldr	x2, [x4]
               	cmp	x2, x0
               	cset	x6, lo
               	cmp	x2, x0
               	cset	x2, eq
               	cmp	x1, #0x0
               	cset	x10, hi
               	and	x2, x2, x10
               	orr	x2, x6, x2
               	cbnz	w2, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	ldr	x6, [x9]
               	ldr	x2, [x4]
               	cmp	x2, #0x0
               	cset	x10, hi
               	cmp	x2, #0x0
               	cset	x2, eq
               	cmp	x6, #0x0
               	cset	x6, lo
               	and	x2, x2, x6
               	orr	x2, x10, x2
               	cbnz	w2, <addr>
               	mov	x0, #0x6                // =6
               	ret
               	cmp	w3, #0x0
               	cset	x6, lt
               	cmp	w3, #0x0
               	cset	x2, eq
               	cmp	x7, x8
               	cset	x10, lo
               	and	x10, x2, x10
               	orr	x6, x6, x10
               	cbz	w6, <addr>
               	cmp	x8, x7
               	cset	x6, lo
               	and	x2, x2, x6
               	cbnz	w2, <addr>
               	cmp	x5, x3
               	cset	x6, lt
               	cmp	x5, x3
               	cset	x2, eq
               	cmp	x7, #0x0
               	cset	x10, hi
               	and	x10, x2, x10
               	orr	x6, x6, x10
               	cbz	w6, <addr>
               	cmp	x5, #0x0
               	cset	x10, lt
               	cmp	x5, #0x0
               	cset	x6, eq
               	cmp	x8, #0x0
               	cset	x11, hi
               	and	x11, x6, x11
               	orr	x10, x10, x11
               	cbnz	w10, <addr>
               	mov	x0, #0x7                // =7
               	ret
               	cmp	x3, x5
               	cset	x10, lt
               	cmp	x7, #0x0
               	cset	x11, lo
               	and	x2, x2, x11
               	orr	x2, x10, x2
               	eor	x2, x2, #0x1
               	cbz	w2, <addr>
               	cmp	x3, #0x0
               	b.ls	<addr>
               	cmp	x5, #0x0
               	cset	x2, hi
               	cmp	x8, #0x0
               	cset	x3, lo
               	and	x3, x6, x3
               	orr	x2, x2, x3
               	cbnz	w2, <addr>
               	mov	x0, #0x9                // =9
               	ret
               	ldr	x2, [x4]
               	ldr	x3, [x4]
               	cmp	x2, x3
               	cset	x6, lt
               	cmp	x2, x3
               	cset	x5, eq
               	orr	x6, x6, x5
               	cbz	w6, <addr>
               	cmp	x2, x3
               	cset	x6, lo
               	orr	x2, x6, x5
               	cbnz	w2, <addr>
               	mov	x0, #0xb                // =11
               	ret
               	ldr	x3, [x9]
               	cmp	x0, #0x0
               	cset	x5, lo
               	cmp	x0, #0x0
               	cset	x2, eq
               	cmp	x1, x3
               	cset	x3, lo
               	and	x3, x2, x3
               	orr	x3, x5, x3
               	cbnz	x3, <addr>
               	ldr	x3, [x4]
               	cmp	x0, #0x0
               	cset	x4, hi
               	cmp	x3, x1
               	cset	x0, lo
               	and	x0, x2, x0
               	orr	x0, x4, x0
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
