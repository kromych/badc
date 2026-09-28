
overaligned_region_storage.aarch64:	file format elf64-littleaarch64

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

<fill>:
               	mov	x3, #0x0                // =0
               	mov	x4, #0x3                // =3
               	cmp	w3, w1
               	b.ge	<addr>
               	mul	x5, x3, x4
               	add	x5, x2, x5
               	and	x5, x5, #0xff
               	strb	w5, [x0, x3]
               	add	x3, x3, #0x1
               	cmp	w3, w1
               	b.lt	<addr>
               	ret

<check>:
               	sub	x3, x3, #0x1
               	and	x3, x0, x3
               	cbz	x3, <addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x3, #0x0                // =0
               	mov	x4, #0x3                // =3
               	cmp	w3, w1
               	b.ge	<addr>
               	ldrb	w5, [x0, x3]
               	mul	x6, x3, x4
               	add	x6, x2, x6
               	and	x6, x6, #0xff
               	cmp	w5, w6
               	b.ne	<addr>
               	add	x3, x3, #0x1
               	cmp	w3, w1
               	b.lt	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret

<one>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x220
               	str	x20, [sp]
               	mov	x20, x0
               	sub	x0, x29, #0x210
               	mov	x1, #0x210              // =528
               	mov	x2, x20
               	bl	<addr>
               	sub	x0, x29, #0x210
               	mov	x1, #0x210              // =528
               	mov	x3, #0x10               // =16
               	mov	x2, x20
               	bl	<addr>
               	ldr	x20, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret

<branches>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x220
               	str	x20, [sp]
               	sxtw	x0, w0
               	mov	x20, x1
               	cbz	x0, <addr>
               	sub	x0, x29, #0x210
               	mov	x1, #0x210              // =528
               	mov	x2, x20
               	bl	<addr>
               	sub	x0, x29, #0x210
               	mov	x1, #0x210              // =528
               	mov	x3, #0x10               // =16
               	mov	x2, x20
               	bl	<addr>
               	ldr	x20, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x210
               	mov	x1, #0x210              // =528
               	add	x2, x20, #0x1
               	bl	<addr>
               	sub	x0, x29, #0x210
               	mov	x1, #0x210              // =528
               	add	x2, x20, #0x1
               	mov	x3, #0x10               // =16
               	bl	<addr>
               	ldr	x20, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret

<joined>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x220
               	str	x20, [sp]
               	sxtw	x0, w0
               	mov	x20, x1
               	cbz	x0, <addr>
               	sub	x0, x29, #0x210
               	mov	x1, #0x210              // =528
               	add	x2, x20, #0x2
               	bl	<addr>
               	sub	x0, x29, #0x210
               	mov	x1, #0x210              // =528
               	add	x2, x20, #0x2
               	mov	x3, #0x10               // =16
               	bl	<addr>
               	ldr	x20, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x210
               	mov	x1, #0x210              // =528
               	add	x2, x20, #0x3
               	bl	<addr>
               	sub	x0, x29, #0x210
               	mov	x1, #0x210              // =528
               	add	x2, x20, #0x3
               	mov	x3, #0x10               // =16
               	bl	<addr>
               	b	<addr>

<sequence>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x220
               	stp	x20, x21, [sp]
               	mov	x20, x0
               	sub	x0, x29, #0x210
               	mov	x1, #0x210              // =528
               	mov	x2, x20
               	bl	<addr>
               	sub	x0, x29, #0x210
               	mov	x1, #0x210              // =528
               	mov	x3, #0x10               // =16
               	mov	x2, x20
               	bl	<addr>
               	and	x21, x0, #0x1
               	sub	x0, x29, #0x210
               	mov	x1, #0x210              // =528
               	add	x2, x20, #0x9
               	bl	<addr>
               	sub	x0, x29, #0x210
               	mov	x1, #0x210              // =528
               	add	x2, x20, #0x9
               	mov	x3, #0x10               // =16
               	bl	<addr>
               	and	x0, x21, x0
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret

<nested>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x430
               	stp	x20, x21, [sp]
               	mov	x20, x0
               	sub	x0, x29, #0x420
               	mov	x1, #0x210              // =528
               	mov	x2, x20
               	bl	<addr>
               	sub	x0, x29, #0x210
               	mov	x1, #0x210              // =528
               	add	x2, x20, #0x14
               	bl	<addr>
               	sub	x0, x29, #0x210
               	mov	x1, #0x210              // =528
               	add	x2, x20, #0x14
               	mov	x3, #0x10               // =16
               	bl	<addr>
               	and	x21, x0, #0x1
               	sub	x0, x29, #0x420
               	mov	x1, #0x210              // =528
               	mov	x3, #0x10               // =16
               	mov	x2, x20
               	bl	<addr>
               	and	x21, x21, x0
               	sub	x0, x29, #0x210
               	mov	x1, #0x210              // =528
               	add	x2, x20, #0x14
               	add	x2, x2, #0x1
               	bl	<addr>
               	sub	x0, x29, #0x210
               	mov	x1, #0x210              // =528
               	add	x2, x20, #0x14
               	add	x2, x2, #0x1
               	mov	x3, #0x10               // =16
               	bl	<addr>
               	and	x21, x21, x0
               	sub	x0, x29, #0x420
               	mov	x1, #0x210              // =528
               	mov	x3, #0x10               // =16
               	mov	x2, x20
               	bl	<addr>
               	and	x1, x21, x0
               	mov	x0, #0x0                // =0
               	cbz	x1, <addr>
               	sub	x0, x29, #0x420
               	mov	x1, #0x210              // =528
               	mov	x3, #0x10               // =16
               	mov	x2, x20
               	bl	<addr>
               	cmp	w0, #0x0
               	cset	x0, ne
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x430
               	ldp	x29, x30, [sp], #0x10
               	ret

<wide>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	x20, [sp]
               	sub	sp, sp, #0x140
               	mov	x16, sp
               	and	sp, x16, #0xffffffffffffffc0
               	mov	x20, x0
               	mov	x0, sp
               	mov	x1, #0x100              // =256
               	mov	x2, x20
               	bl	<addr>
               	add	x0, sp, #0x100
               	mov	x1, #0x30               // =48
               	add	x2, x20, #0x1
               	bl	<addr>
               	sub	x0, x29, #0x20
               	mov	x1, #0x20               // =32
               	add	x2, x20, #0x2
               	bl	<addr>
               	mov	x0, sp
               	mov	x1, #0x100              // =256
               	mov	x3, #0x40               // =64
               	mov	x2, x20
               	bl	<addr>
               	mov	x1, #0x0                // =0
               	cbz	w0, <addr>
               	add	x0, sp, #0x100
               	mov	x1, #0x30               // =48
               	add	x2, x20, #0x1
               	mov	x3, #0x10               // =16
               	bl	<addr>
               	cmp	w0, #0x0
               	cset	x1, ne
               	mov	x0, #0x0                // =0
               	cbz	x1, <addr>
               	sub	x0, x29, #0x20
               	mov	x1, #0x20               // =32
               	add	x2, x20, #0x2
               	mov	x3, #0x8                // =8
               	bl	<addr>
               	cmp	w0, #0x0
               	cset	x0, ne
               	sub	sp, x29, #0x30
               	ldr	x20, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<sum_pair>:
               	and	x1, x0, #0xf
               	cbnz	w1, <addr>
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	add	x0, x1, x0
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>

<by_value>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	x0, [x29, #-0x10]
               	sub	x0, x29, #0x10
               	str	x1, [x0, #0x8]
               	bl	<addr>
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	str	x20, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w20, [x0]
               	mov	x0, x20
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w0, [x0, #0x4]
               	cmp	w0, #0x0
               	cset	x0, hi
               	mov	x1, x20
               	bl	<addr>
               	cbz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w0, [x0, #0x4]
               	cmp	w0, #0x0
               	cset	x0, eq
               	mov	x1, x20
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w0, [x0, #0x4]
               	cmp	w0, #0x0
               	cset	x0, hi
               	mov	x1, x20
               	bl	<addr>
               	cbz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w0, [x0, #0x4]
               	cmp	w0, #0x0
               	cset	x0, eq
               	mov	x1, x20
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, x20
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, x20
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, x20
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	sub	x0, x29, #0x10
               	stp	xzr, xzr, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	w2, [x1, #0x4]
               	str	x2, [x0]
               	ldr	w1, [x1, #0x8]
               	str	x1, [x0, #0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cmp	x0, #0xc
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
