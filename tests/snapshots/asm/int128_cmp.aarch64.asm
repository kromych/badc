
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
               	mov	x6, #0x0                // =0
               	adrp	x8, <page>
               	add	x8, x8, <lo12>
               	ldr	x1, [x8]
               	orr	x1, x6, x1
               	orr	x0, x0, x6
               	ldr	x2, [x2]
               	ldr	x3, [x8]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	x5, [x4]
               	add	x3, x3, x5
               	orr	x7, x6, x3
               	orr	x2, x2, x6
               	ldr	x3, [x4]
               	cmp	x3, #0x0
               	cset	x5, hi
               	sub	x9, x6, x3
               	sub	x3, x6, x5
               	ldr	x5, [x4]
               	lsl	x5, x5, #63
               	ldr	x10, [x4]
               	eor	x12, x1, x1
               	eor	x13, x0, x0
               	orr	x11, x12, x13
               	cbnz	x11, <addr>
               	cbz	x11, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	eor	x11, x1, x7
               	eor	x12, x0, x2
               	orr	x11, x11, x12
               	cbz	x11, <addr>
               	ldr	x11, [x4]
               	lsl	x11, x11, #63
               	mov	x17, #0x0               // =0
               	eor	x12, x1, x17
               	eor	x11, x0, x11
               	eor	x12, x1, x12
               	eor	x11, x0, x11
               	orr	x11, x12, x11
               	cbnz	x11, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	cmp	x0, x2
               	cset	x12, lo
               	cmp	x0, x2
               	cset	x11, eq
               	cmp	x1, x7
               	cset	x13, lo
               	and	x13, x11, x13
               	orr	x12, x12, x13
               	cbz	x12, <addr>
               	cmp	x2, x0
               	cset	x12, lo
               	cmp	x7, x1
               	cset	x13, lo
               	and	x11, x11, x13
               	orr	x11, x12, x11
               	cbnz	x11, <addr>
               	cmp	x0, x3
               	cset	x2, lo
               	cmp	x0, x3
               	cset	x7, eq
               	cmp	x1, x9
               	cset	x11, lo
               	and	x7, x7, x11
               	orr	x2, x2, x7
               	cbz	x2, <addr>
               	ldr	x2, [x4]
               	cmp	x2, x0
               	cset	x7, lo
               	cmp	x2, x0
               	cset	x2, eq
               	cmp	x1, #0x0
               	cset	x11, hi
               	and	x2, x2, x11
               	orr	x2, x7, x2
               	cbnz	x2, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	ldr	x7, [x8]
               	ldr	x2, [x4]
               	cmp	x2, #0x0
               	cset	x11, hi
               	cmp	x2, #0x0
               	cset	x2, eq
               	cmp	x7, #0x0
               	cset	x7, lo
               	and	x2, x2, x7
               	orr	x2, x11, x2
               	cbnz	x2, <addr>
               	mov	x0, #0x6                // =6
               	ret
               	cmp	x3, #0x0
               	cset	x7, lt
               	cmp	x3, #0x0
               	cset	x2, eq
               	cmp	x9, x10
               	cset	x11, lo
               	and	x11, x2, x11
               	orr	x7, x7, x11
               	cbz	x7, <addr>
               	cmp	x10, x9
               	cset	x7, lo
               	and	x11, x2, x7
               	mov	x17, #0x0               // =0
               	orr	x12, x11, x17
               	cbnz	x12, <addr>
               	cmp	x5, x3
               	cset	x13, lt
               	cmp	x5, x3
               	cset	x12, eq
               	cmp	x9, #0x0
               	cset	x14, hi
               	and	x14, x12, x14
               	orr	x13, x13, x14
               	cbz	x13, <addr>
               	cmp	x5, #0x0
               	cset	x14, lt
               	cmp	x5, #0x0
               	cset	x13, eq
               	cmp	x10, #0x0
               	cset	x15, hi
               	and	x15, x13, x15
               	orr	x14, x14, x15
               	cbnz	x14, <addr>
               	mov	x0, #0x7                // =7
               	ret
               	cmp	x3, x5
               	cset	x14, lt
               	cmp	x9, #0x0
               	cset	x15, lo
               	and	x12, x12, x15
               	orr	x12, x14, x12
               	eor	x12, x12, #0x1
               	cbz	x12, <addr>
               	cmp	x3, #0x0
               	cset	x12, hi
               	orr	x2, x12, x11
               	cbz	x2, <addr>
               	cmp	x5, #0x0
               	cset	x2, hi
               	cmp	x10, #0x0
               	cset	x3, lo
               	and	x3, x13, x3
               	orr	x2, x2, x3
               	cbnz	x2, <addr>
               	mov	x0, #0x9                // =9
               	ret
               	ldr	x2, [x4]
               	orr	x2, x2, x6
               	ldr	x3, [x4]
               	orr	x3, x3, x6
               	cmp	x2, x3
               	cset	x7, lt
               	cmp	x2, x3
               	cset	x5, eq
               	orr	x7, x7, x5
               	cbz	x7, <addr>
               	cmp	x2, x3
               	cset	x7, lo
               	orr	x2, x7, x5
               	cbnz	x2, <addr>
               	mov	x0, #0xb                // =11
               	ret
               	ldr	x3, [x8]
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
               	cbz	x0, <addr>
               	ldr	x0, [x8]
               	ldr	x1, [x8]
               	eor	x0, x0, x1
               	mov	x17, #0x0               // =0
               	orr	x0, x0, x17
               	cbz	x0, <addr>
               	mov	x0, #0xc                // =12
               	ret
               	mov	x0, x6
               	ret
               	mov	x0, #0xa                // =10
               	ret
               	mov	x0, #0x8                // =8
               	ret
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x2                // =2
               	ret
