
int128_struct_fallback.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<rt>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	x0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x290
               	stp	x20, x21, [sp]
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	mov	x21, x0
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	mov	x1, x0
               	add	x1, x21, x1
               	cmp	x1, x21
               	cset	x0, lo
               	add	x2, x0, #0x0
               	sub	x0, x29, #0xa8
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x0]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0xa8
               	str	x1, [x0]
               	sub	x0, x29, #0xa8
               	str	x2, [x0, #0x8]
               	sub	x0, x29, #0xa8
               	ldr	x22, [x0]
               	ldr	x23, [x0, #0x8]
               	cmp	x22, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	cmp	x23, #0x1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	mov	x21, x0
               	mov	x24, #0x1               // =1
               	mov	x0, x24
               	bl	<addr>
               	mov	x25, x0
               	mov	x0, x24
               	bl	<addr>
               	mov	x1, x0
               	sub	x2, x21, x1
               	sub	x3, x25, #0x0
               	cmp	x21, x1
               	cset	x0, lo
               	sub	x1, x3, x0
               	sub	x0, x29, #0xa0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x0]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0xa0
               	str	x2, [x0]
               	sub	x0, x29, #0xa0
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0xa0
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x1, x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	cmp	x2, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	mov	x1, x0
               	mvn	x1, x1
               	add	x1, x1, #0x1
               	cmp	x1, #0x0
               	cset	x0, eq
               	sub	x2, x0, #0x1
               	sub	x0, x29, #0x98
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x0]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x98
               	str	x1, [x0]
               	sub	x0, x29, #0x98
               	str	x2, [x0, #0x8]
               	sub	x0, x29, #0x98
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x1, x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x2, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	mov	x2, #0x0                // =0
               	lsr	x1, x0, #0
               	sub	x0, x29, #0xa0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x0]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0xa0
               	str	x2, [x0]
               	sub	x0, x29, #0xa0
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0xa0
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	cmp	x1, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	cmp	x2, #0x1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	mov	x2, #0x0                // =0
               	lsl	x1, x0, #36
               	sub	x0, x29, #0xa0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x0]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0xa0
               	str	x2, [x0]
               	sub	x0, x29, #0xa0
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0xa0
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	cmp	x1, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x17, #0x1000000000      // =68719476736
               	cmp	x2, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #-0x8000000000000000 // =-9223372036854775808
               	bl	<addr>
               	mov	x1, x0
               	lsr	x2, x20, #4
               	lsl	x3, x1, #60
               	orr	x2, x2, x3
               	asr	x1, x1, #4
               	sub	x0, x29, #0xb0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x0]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0xb0
               	str	x2, [x0]
               	sub	x0, x29, #0xb0
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0xb0
               	ldr	x1, [x0, #0x8]
               	mov	x17, #-0x800000000000000 // =-576460752303423488
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	mov	x24, x0
               	mov	x20, #0x1               // =1
               	mov	x0, x20
               	bl	<addr>
               	mov	x2, x0
               	cmp	x22, x24
               	cset	x3, eq
               	mov	x1, #0x0                // =0
               	cbz	x3, <addr>
               	cmp	x23, x2
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, eq
               	cbnz	x0, <addr>
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	mov	x21, x0
               	mov	x0, #0x9                // =9
               	bl	<addr>
               	mov	x1, x0
               	cmp	x21, x1
               	cset	x0, lo
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x20, ne
               	cbnz	x20, <addr>
               	mov	x0, #0x9                // =9
               	bl	<addr>
               	mov	x21, x0
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	mov	x1, x0
               	cmp	x21, x1
               	cset	x0, lo
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x20, ne
               	cbz	x20, <addr>
               	mov	x0, #0x7                // =7
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x290
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
