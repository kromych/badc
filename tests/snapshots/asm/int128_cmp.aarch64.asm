
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
               	stp	x20, x21, [sp, #-0x40]!
               	stp	x22, x23, [sp, #0x10]
               	str	x24, [sp, #0x20]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x0, [x2]
               	mov	x7, #0x0                // =0
               	adrp	x8, <page>
               	add	x8, x8, <lo12>
               	ldr	x1, [x8]
               	orr	x1, x7, x1
               	orr	x0, x0, x7
               	ldr	x2, [x2]
               	ldr	x3, [x8]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	x5, [x4]
               	add	x3, x3, x5
               	orr	x6, x7, x3
               	orr	x2, x2, x7
               	ldr	x3, [x4]
               	cmp	x3, #0x0
               	cset	x5, hi
               	sub	x9, x7, x3
               	sub	x3, x7, x5
               	ldr	x5, [x4]
               	lsl	x5, x5, #63
               	ldr	x10, [x4]
               	eor	x12, x1, x1
               	eor	x13, x0, x0
               	orr	x11, x12, x13
               	cbnz	x11, <addr>
               	cmp	x11, #0x0
               	cset	x11, ne
               	cbz	x11, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	eor	x11, x1, x6
               	eor	x12, x0, x2
               	orr	x11, x11, x12
               	cbz	x11, <addr>
               	ldr	x7, [x4]
               	lsl	x7, x7, #63
               	mov	x17, #0x0               // =0
               	eor	x11, x1, x17
               	eor	x7, x0, x7
               	eor	x11, x1, x11
               	eor	x7, x0, x7
               	orr	x7, x11, x7
               	cbnz	x7, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	cmp	x0, x2
               	cset	x7, lo
               	cmp	x0, x2
               	cset	x11, eq
               	cmp	x1, x6
               	cset	x12, lo
               	and	x12, x11, x12
               	orr	x7, x7, x12
               	cbz	x7, <addr>
               	cmp	x2, x0
               	cset	x12, lo
               	cmp	x6, x1
               	cset	x13, lo
               	and	x14, x11, x13
               	orr	x15, x12, x14
               	cmp	x15, #0x0
               	cset	x7, ne
               	cbnz	x7, <addr>
               	eor	x20, x15, #0x1
               	cmp	x20, #0x0
               	cset	x7, eq
               	mov	x21, x7
               	cbnz	x21, <addr>
               	cbnz	x7, <addr>
               	mov	x7, #0x0                // =0
               	mov	x11, x7
               	mov	x2, x7
               	cmp	x0, x3
               	cset	x2, lo
               	cmp	x0, x3
               	cset	x6, eq
               	cmp	x1, x9
               	cset	x11, lo
               	and	x6, x6, x11
               	orr	x2, x2, x6
               	cbz	x2, <addr>
               	ldr	x2, [x4]
               	cmp	x2, x0
               	cset	x6, lo
               	cmp	x2, x0
               	cset	x2, eq
               	cmp	x1, #0x0
               	cset	x11, hi
               	and	x2, x2, x11
               	orr	x2, x6, x2
               	cmp	x2, #0x0
               	cset	x2, eq
               	cbz	x2, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	ldr	x6, [x8]
               	ldr	x2, [x4]
               	cmp	x2, #0x0
               	cset	x11, hi
               	cmp	x2, #0x0
               	cset	x2, eq
               	cmp	x6, #0x0
               	cset	x6, lo
               	and	x2, x2, x6
               	orr	x2, x11, x2
               	cbnz	x2, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	cmp	x3, #0x0
               	cset	x2, lt
               	cmp	x3, #0x0
               	cset	x6, eq
               	cmp	x9, x10
               	cset	x11, lo
               	and	x11, x6, x11
               	orr	x2, x2, x11
               	cbz	x2, <addr>
               	cmp	x10, x9
               	cset	x11, lo
               	and	x12, x6, x11
               	mov	x17, #0x0               // =0
               	orr	x2, x12, x17
               	cmp	x2, #0x0
               	cset	x2, ne
               	cbnz	x2, <addr>
               	cmp	x5, x3
               	cset	x2, lt
               	cmp	x5, x3
               	cset	x13, eq
               	cmp	x9, #0x0
               	cset	x14, hi
               	and	x14, x13, x14
               	orr	x2, x2, x14
               	cmp	x2, #0x0
               	cset	x2, eq
               	cbnz	x2, <addr>
               	cmp	x5, #0x0
               	cset	x14, lt
               	cmp	x5, #0x0
               	cset	x15, eq
               	cmp	x10, #0x0
               	cset	x20, hi
               	and	x21, x15, x20
               	orr	x22, x14, x21
               	cmp	x22, #0x0
               	cset	x2, eq
               	mov	x23, x2
               	cbz	x23, <addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	cmp	x3, x5
               	cset	x23, lt
               	cmp	x9, #0x0
               	cset	x24, lo
               	and	x13, x13, x24
               	orr	x13, x23, x13
               	eor	x13, x13, #0x1
               	cbz	x13, <addr>
               	cbnz	x2, <addr>
               	mov	x2, x7
               	cmp	x3, #0x0
               	cset	x2, hi
               	orr	x2, x2, x12
               	cbz	x2, <addr>
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
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	ldr	x2, [x4]
               	mov	x5, #0x0                // =0
               	orr	x2, x2, x5
               	ldr	x3, [x4]
               	orr	x3, x3, x5
               	cmp	x2, x3
               	cset	x7, lt
               	cmp	x2, x3
               	cset	x6, eq
               	orr	x7, x7, x6
               	cbz	x7, <addr>
               	mov	x7, x5
               	cmp	x2, x3
               	cset	x7, lo
               	orr	x2, x7, x6
               	cbnz	x2, <addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	ldr	x3, [x8]
               	cmp	x0, #0x0
               	cset	x6, lo
               	cmp	x0, #0x0
               	cset	x2, eq
               	cmp	x1, x3
               	cset	x3, lo
               	and	x3, x2, x3
               	orr	x3, x6, x3
               	cbnz	x3, <addr>
               	ldr	x3, [x4]
               	cmp	x0, #0x0
               	cset	x4, hi
               	cmp	x3, x1
               	cset	x0, lo
               	and	x0, x2, x0
               	orr	x0, x4, x0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cbnz	x0, <addr>
               	ldr	x0, [x8]
               	ldr	x1, [x8]
               	eor	x0, x0, x1
               	mov	x17, #0x0               // =0
               	orr	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, x5
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
