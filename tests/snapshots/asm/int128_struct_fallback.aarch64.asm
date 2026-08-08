
int128_struct_fallback.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
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
               	str	x24, [sp, #0x20]
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	add	x0, x20, x0
               	cmp	x0, x20
               	cset	x1, lo
               	add	x1, x1, #0x0
               	sub	x2, x29, #0xa8
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x2]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x2, x29, #0xa8
               	str	x0, [x2]
               	sub	x0, x29, #0xa8
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0xa8
               	ldr	x21, [x0]
               	ldr	x22, [x0, #0x8]
               	cmp	x21, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	cmp	x22, #0x1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	mov	x20, x0
               	mov	x23, #0x1               // =1
               	mov	x0, x23
               	bl	<addr>
               	mov	x24, x0
               	mov	x0, x23
               	bl	<addr>
               	sub	x2, x20, x0
               	sub	x1, x24, #0x0
               	cmp	x20, x0
               	cset	x0, lo
               	sub	x1, x1, x0
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
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	mvn	x0, x0
               	add	x0, x0, #0x1
               	cmp	x0, #0x0
               	cset	x1, eq
               	sub	x1, x1, #0x1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x1, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	mov	x1, #0x0                // =0
               	lsr	x2, x0, #0
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
               	str	x1, [x0]
               	sub	x0, x29, #0xa0
               	str	x2, [x0, #0x8]
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
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	mov	x1, #0x0                // =0
               	lsl	x2, x0, #36
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
               	str	x1, [x0]
               	sub	x0, x29, #0xa0
               	str	x2, [x0, #0x8]
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
               	ldr	x24, [sp, #0x20]
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
               	lsr	x1, x20, #4
               	lsl	x2, x0, #60
               	orr	x1, x1, x2
               	asr	x2, x0, #4
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
               	str	x1, [x0]
               	sub	x0, x29, #0xb0
               	str	x2, [x0, #0x8]
               	sub	x0, x29, #0xb0
               	ldr	x0, [x0, #0x8]
               	mov	x17, #-0x800000000000000 // =-576460752303423488
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	mov	x23, x0
               	mov	x20, #0x1               // =1
               	mov	x0, x20
               	bl	<addr>
               	mov	x1, x0
               	cmp	x21, x23
               	cset	x2, eq
               	mov	x0, #0x0                // =0
               	cbz	x2, <addr>
               	cmp	x22, x1
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, eq
               	cbnz	x0, <addr>
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #0x9                // =9
               	bl	<addr>
               	cmp	x20, x0
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
               	mov	x20, x0
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	cmp	x20, x0
               	cset	x0, lo
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x20, ne
               	cbz	x20, <addr>
               	mov	x0, #0x7                // =7
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x24, [sp, #0x20]
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
