
int128_struct_fallback.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	sub	x16, x29, #0x30
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	mov	x1, x2
               	sxtw	x1, w1
               	cmp	x1, #0x40
               	b.lt	<addr>
               	mov	x2, #0x0                // =0
               	sub	x0, x29, #0x30
               	ldr	x3, [x0]
               	sub	x0, x1, #0x40
               	sxtw	x0, w0
               	lsl	x1, x3, x0
               	sub	x0, x29, #0x20
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x0]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x20
               	str	x2, [x0]
               	sub	x0, x29, #0x20
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x20
               	mov	x16, x0
               	ldr	x1, [x16, #0x8]
               	ldr	x0, [x16]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	sub	x0, x29, #0x30
               	ldr	x0, [x0]
               	lsl	x2, x0, x1
               	sub	x0, x29, #0x30
               	ldr	x0, [x0, #0x8]
               	lsl	x3, x0, x1
               	cbz	x1, <addr>
               	sub	x0, x29, #0x30
               	ldr	x4, [x0]
               	mov	x0, #0x40               // =64
               	sub	x0, x0, x1
               	sxtw	x0, w0
               	lsr	x0, x4, x0
               	orr	x1, x3, x0
               	sub	x0, x29, #0x10
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x0]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x10
               	str	x2, [x0]
               	sub	x0, x29, #0x10
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x10
               	mov	x16, x0
               	ldr	x1, [x16, #0x8]
               	ldr	x0, [x16]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>

<rshift>:
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	sub	x16, x29, #0x30
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	mov	x1, x2
               	sxtw	x1, w1
               	cmp	x1, #0x40
               	b.lt	<addr>
               	sub	x0, x29, #0x30
               	ldr	x2, [x0, #0x8]
               	sub	x0, x1, #0x40
               	sxtw	x0, w0
               	asr	x1, x2, x0
               	sub	x0, x29, #0x30
               	ldr	x0, [x0, #0x8]
               	asr	x2, x0, #63
               	sub	x0, x29, #0x10
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x0]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x10
               	str	x1, [x0]
               	sub	x0, x29, #0x10
               	str	x2, [x0, #0x8]
               	sub	x0, x29, #0x10
               	mov	x16, x0
               	ldr	x1, [x16, #0x8]
               	ldr	x0, [x16]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	sub	x0, x29, #0x30
               	ldr	x0, [x0]
               	lsr	x2, x0, x1
               	sub	x0, x29, #0x30
               	ldr	x3, [x0, #0x8]
               	mov	x0, #0x40               // =64
               	sub	x0, x0, x1
               	sxtw	x0, w0
               	lsl	x0, x3, x0
               	orr	x2, x2, x0
               	sub	x0, x29, #0x30
               	ldr	x0, [x0, #0x8]
               	asr	x1, x0, x1
               	sub	x0, x29, #0x20
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x0]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x20
               	str	x2, [x0]
               	sub	x0, x29, #0x20
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x20
               	mov	x16, x0
               	ldr	x1, [x16, #0x8]
               	ldr	x0, [x16]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret

<eq>:
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x16, x29, #0x10
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x16, x29, #0x20
               	str	x2, [x16]
               	str	x3, [x16, #0x8]
               	sub	x0, x29, #0x10
               	ldr	x0, [x0]
               	sub	x1, x29, #0x20
               	ldr	x1, [x1]
               	cmp	x0, x1
               	cset	x1, eq
               	mov	x0, #0x0                // =0
               	cbz	x1, <addr>
               	sub	x0, x29, #0x10
               	ldr	x1, [x0, #0x8]
               	sub	x0, x29, #0x20
               	ldr	x0, [x0, #0x8]
               	cmp	x1, x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	b	<addr>

<lt>:
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x16, x29, #0x10
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x16, x29, #0x20
               	str	x2, [x16]
               	str	x3, [x16, #0x8]
               	sub	x0, x29, #0x10
               	ldr	x1, [x0, #0x8]
               	sub	x0, x29, #0x20
               	ldr	x0, [x0, #0x8]
               	cmp	x1, x0
               	cset	x1, lt
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x10
               	ldr	x1, [x0, #0x8]
               	sub	x0, x29, #0x20
               	ldr	x0, [x0, #0x8]
               	cmp	x1, x0
               	cset	x1, eq
               	mov	x0, #0x0                // =0
               	cbz	x1, <addr>
               	sub	x0, x29, #0x10
               	ldr	x0, [x0]
               	sub	x1, x29, #0x20
               	ldr	x1, [x1]
               	cmp	x0, x1
               	cset	x0, lo
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	b	<addr>
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x220
               	stp	x20, x21, [sp]
               	str	x22, [sp, #0x10]
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	sub	x1, x29, #0x110
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x20]
               	str	x10, [x1]
               	ldr	x10, [x20, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0x110
               	str	x0, [x1]
               	mov	x1, #0x0                // =0
               	sub	x0, x29, #0x110
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x110
               	mov	x1, #0x1                // =1
               	sub	x2, x29, #0x120
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x2]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x2, x29, #0x120
               	str	x1, [x2]
               	mov	x2, #0x0                // =0
               	sub	x1, x29, #0x120
               	str	x2, [x1, #0x8]
               	sub	x1, x29, #0x120
               	ldr	x2, [x0]
               	ldr	x3, [x1]
               	add	x3, x2, x3
               	ldr	x4, [x0, #0x8]
               	ldr	x1, [x1, #0x8]
               	add	x1, x4, x1
               	cmp	x3, x2
               	cset	x0, lo
               	add	x1, x1, x0
               	sub	x0, x29, #0x130
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x22]
               	str	x10, [x0]
               	ldr	x10, [x22, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x130
               	str	x3, [x0]
               	sub	x0, x29, #0x130
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x130
               	sub	x1, x29, #0x140
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x140
               	ldr	x0, [x0]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x140
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x1, #0x1                // =1
               	sub	x2, x29, #0xe0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x22]
               	str	x10, [x2]
               	ldr	x10, [x22, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x2, x29, #0xe0
               	str	x0, [x2]
               	sub	x0, x29, #0xe0
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0xe0
               	sub	x2, x29, #0xf0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x20]
               	str	x10, [x2]
               	ldr	x10, [x20, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x2, x29, #0xf0
               	str	x1, [x2]
               	mov	x2, #0x0                // =0
               	sub	x1, x29, #0xf0
               	str	x2, [x1, #0x8]
               	sub	x1, x29, #0xf0
               	ldr	x2, [x0]
               	ldr	x3, [x1]
               	sub	x4, x2, x3
               	ldr	x5, [x0, #0x8]
               	ldr	x6, [x1, #0x8]
               	sub	x5, x5, x6
               	cmp	x2, x3
               	cset	x0, lo
               	sub	x1, x5, x0
               	sub	x0, x29, #0x100
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x22]
               	str	x10, [x0]
               	ldr	x10, [x22, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x100
               	str	x4, [x0]
               	sub	x0, x29, #0x100
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x100
               	sub	x1, x29, #0x160
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x160
               	ldr	x0, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x160
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	sub	x1, x29, #0xc0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x20]
               	str	x10, [x1]
               	ldr	x10, [x20, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0xc0
               	str	x0, [x1]
               	mov	x1, #0x0                // =0
               	sub	x0, x29, #0xc0
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0xc0
               	ldr	x1, [x0]
               	mvn	x1, x1
               	add	x1, x1, #0x1
               	ldr	x0, [x0, #0x8]
               	mvn	x0, x0
               	cmp	x1, #0x0
               	cset	x2, eq
               	add	x2, x0, x2
               	sub	x0, x29, #0xd0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x22]
               	str	x10, [x0]
               	ldr	x10, [x22, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0xd0
               	str	x1, [x0]
               	sub	x0, x29, #0xd0
               	str	x2, [x0, #0x8]
               	sub	x0, x29, #0xd0
               	sub	x1, x29, #0x180
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x180
               	ldr	x0, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x180
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	sub	x1, x29, #0xa0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x20]
               	str	x10, [x1]
               	ldr	x10, [x20, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0xa0
               	str	x0, [x1]
               	mov	x1, #0x0                // =0
               	sub	x0, x29, #0xa0
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0xa0
               	mov	x1, #0x40               // =64
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0xb0
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0xb0
               	sub	x1, x29, #0x1a0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x1a0
               	ldr	x0, [x0]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x1a0
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	sub	x1, x29, #0x80
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x20]
               	str	x10, [x1]
               	ldr	x10, [x20, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0x80
               	str	x0, [x1]
               	mov	x1, #0x0                // =0
               	sub	x0, x29, #0x80
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x80
               	mov	x1, #0x64               // =100
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x90
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x90
               	sub	x1, x29, #0x1c0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x1c0
               	ldr	x0, [x0]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x1c0
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0x1000000000      // =68719476736
               	cmp	x0, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	sub	x2, x29, #0x60
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x22]
               	str	x10, [x2]
               	ldr	x10, [x22, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x2, x29, #0x60
               	str	x0, [x2]
               	sub	x0, x29, #0x60
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x60
               	mov	x1, #0x4                // =4
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x70
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x70
               	sub	x1, x29, #0x1e0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x1e0
               	ldr	x0, [x0, #0x8]
               	mov	x17, #-0x800000000000000 // =-576460752303423488
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x140
               	mov	x0, #0x0                // =0
               	mov	x21, #0x1               // =1
               	sub	x2, x29, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x22]
               	str	x10, [x2]
               	ldr	x10, [x22, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x2, x29, #0x10
               	str	x0, [x2]
               	sub	x0, x29, #0x10
               	str	x21, [x0, #0x8]
               	sub	x0, x29, #0x10
               	mov	x2, x0
               	mov	x0, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	cmp	x0, #0x0
               	cset	x0, eq
               	cbnz	x0, <addr>
               	mov	x0, #0x5                // =5
               	sub	x1, x29, #0x20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x20]
               	str	x10, [x1]
               	ldr	x10, [x20, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0x20
               	str	x0, [x1]
               	mov	x1, #0x0                // =0
               	sub	x0, x29, #0x20
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x20
               	mov	x0, #0x9                // =9
               	sub	x2, x29, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x20]
               	str	x10, [x2]
               	ldr	x10, [x20, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x2, x29, #0x30
               	str	x0, [x2]
               	mov	x2, #0x0                // =0
               	sub	x0, x29, #0x30
               	str	x2, [x0, #0x8]
               	sub	x0, x29, #0x30
               	mov	x2, x0
               	mov	x0, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x21, ne
               	cbnz	x21, <addr>
               	mov	x0, #0x9                // =9
               	sub	x1, x29, #0x40
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x20]
               	str	x10, [x1]
               	ldr	x10, [x20, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0x40
               	str	x0, [x1]
               	mov	x1, #0x0                // =0
               	sub	x0, x29, #0x40
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x40
               	mov	x0, #0x5                // =5
               	sub	x2, x29, #0x50
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x20]
               	str	x10, [x2]
               	ldr	x10, [x20, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x2, x29, #0x50
               	str	x0, [x2]
               	mov	x2, #0x0                // =0
               	sub	x0, x29, #0x50
               	str	x2, [x0, #0x8]
               	sub	x0, x29, #0x50
               	mov	x2, x0
               	mov	x0, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	mov	x21, x0
               	cbz	x21, <addr>
               	mov	x0, #0x7                // =7
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
