
gcc_atomics.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x1c0
               	str	x19, [sp]
               	mov	x0, #0xa                // =10
               	stur	w0, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	ldrsw	x0, [x0]
               	cmp	x0, #0xa
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	b	<addr>
               	sub	x0, x29, #0x8
               	mov	x1, #0x14               // =20
               	str	w1, [x0]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	str	w1, [x0]
               	b	<addr>
               	ldursw	x0, [x29, #-0x8]
               	cmp	x0, #0x14
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x2                // =2
               	str	w1, [x0]
               	b	<addr>
               	sub	x0, x29, #0x8
               	mov	x1, #0x1e               // =30
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x0
               	mov	x10, x1
               	ldaxr	w16, [x9]
               	stlxr	w12, w10, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	sxtw	x0, w0
               	cmp	x0, #0x14
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x3                // =3
               	str	w1, [x0]
               	b	<addr>
               	ldursw	x0, [x29, #-0x8]
               	cmp	x0, #0x1e
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	b	<addr>
               	mov	x0, #0x64               // =100
               	stur	w0, [x29, #-0x8]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x4                // =4
               	str	w1, [x0]
               	b	<addr>
               	sub	x0, x29, #0x8
               	mov	x1, #0x5                // =5
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x0
               	mov	x10, x1
               	ldaxr	w16, [x9]
               	add	x11, x16, x10
               	stlxr	w12, w11, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	sxtw	x0, w0
               	cmp	x0, #0x64
               	cset	x0, eq
               	mov	x2, #0x0                // =0
               	cbz	x0, <addr>
               	b	<addr>
               	b	<addr>
               	ldursw	x0, [x29, #-0x8]
               	cmp	x0, #0x69
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x2, ne
               	cmp	x2, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x5                // =5
               	str	w1, [x0]
               	b	<addr>
               	sub	x0, x29, #0x8
               	mov	x1, #0x5                // =5
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x0
               	mov	x10, x1
               	ldaxr	w16, [x9]
               	sub	x11, x16, x10
               	stlxr	w12, w11, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	sxtw	x0, w0
               	cmp	x0, #0x69
               	cset	x0, eq
               	mov	x2, #0x0                // =0
               	cbz	x0, <addr>
               	b	<addr>
               	mov	x0, #0xf0               // =240
               	stur	w0, [x29, #-0x8]
               	b	<addr>
               	ldursw	x0, [x29, #-0x8]
               	cmp	x0, #0x64
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x2, ne
               	cmp	x2, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x6                // =6
               	str	w1, [x0]
               	b	<addr>
               	sub	x0, x29, #0x8
               	mov	x1, #0x3c               // =60
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x0
               	mov	x10, x1
               	ldaxr	w16, [x9]
               	and	x11, x16, x10
               	stlxr	w12, w11, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	sxtw	x0, w0
               	cmp	x0, #0xf0
               	cset	x0, eq
               	mov	x2, #0x0                // =0
               	cbz	x0, <addr>
               	b	<addr>
               	b	<addr>
               	ldursw	x0, [x29, #-0x8]
               	cmp	x0, #0x30
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x2, ne
               	cmp	x2, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x7                // =7
               	str	w1, [x0]
               	b	<addr>
               	sub	x0, x29, #0x8
               	mov	x1, #0xf                // =15
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x0
               	mov	x10, x1
               	ldaxr	w16, [x9]
               	orr	x11, x16, x10
               	stlxr	w12, w11, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	sxtw	x0, w0
               	cmp	x0, #0x30
               	cset	x0, eq
               	mov	x2, #0x0                // =0
               	cbz	x0, <addr>
               	b	<addr>
               	b	<addr>
               	ldursw	x0, [x29, #-0x8]
               	cmp	x0, #0x3f
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x2, ne
               	cmp	x2, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x8                // =8
               	str	w1, [x0]
               	b	<addr>
               	sub	x0, x29, #0x8
               	mov	x1, #0xff               // =255
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x0
               	mov	x10, x1
               	ldaxr	w16, [x9]
               	eor	x11, x16, x10
               	stlxr	w12, w11, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	sxtw	x0, w0
               	cmp	x0, #0x3f
               	cset	x0, eq
               	mov	x2, #0x0                // =0
               	cbz	x0, <addr>
               	b	<addr>
               	mov	x0, #0x7                // =7
               	stur	w0, [x29, #-0x8]
               	stur	w0, [x29, #-0x10]
               	b	<addr>
               	ldursw	x0, [x29, #-0x8]
               	cmp	x0, #0xc0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x2, ne
               	cmp	x2, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x9                // =9
               	str	w1, [x0]
               	b	<addr>
               	sub	x0, x29, #0x8
               	sub	x1, x29, #0x10
               	mov	x2, #0x8                // =8
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x0
               	mov	x10, x1
               	mov	x11, x2
               	ldr	w12, [x10]
               	ldaxr	w16, [x9]
               	cmp	x16, x12
               	b.ne	<addr>
               	stlxr	w17, w11, [x9]
               	cbnz	x17, <addr>
               	mov	x16, #0x1               // =1
               	b	<addr>
               	str	w16, [x10]
               	mov	x16, #0x0               // =0
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	cmp	x0, #0x1
               	cset	x0, eq
               	mov	x2, #0x0                // =0
               	cbz	x0, <addr>
               	b	<addr>
               	mov	x0, #0x7                // =7
               	stur	w0, [x29, #-0x10]
               	b	<addr>
               	ldursw	x0, [x29, #-0x8]
               	cmp	x0, #0x8
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x2, ne
               	cmp	x2, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xa                // =10
               	str	w1, [x0]
               	b	<addr>
               	sub	x0, x29, #0x8
               	sub	x1, x29, #0x10
               	mov	x2, #0x9                // =9
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x0
               	mov	x10, x1
               	mov	x11, x2
               	ldr	w12, [x10]
               	ldaxr	w16, [x9]
               	cmp	x16, x12
               	b.ne	<addr>
               	stlxr	w17, w11, [x9]
               	cbnz	x17, <addr>
               	mov	x16, #0x1               // =1
               	b	<addr>
               	str	w16, [x10]
               	mov	x16, #0x0               // =0
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	cmp	x0, #0x0
               	cset	x0, eq
               	mov	x2, #0x0                // =0
               	cbz	x0, <addr>
               	b	<addr>
               	mov	x0, #0x64               // =100
               	stur	w0, [x29, #-0x8]
               	b	<addr>
               	ldursw	x0, [x29, #-0x8]
               	cmp	x0, #0x8
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x2, ne
               	mov	x1, #0x0                // =0
               	cbz	x2, <addr>
               	ldursw	x0, [x29, #-0x10]
               	cmp	x0, #0x8
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xb                // =11
               	str	w1, [x0]
               	b	<addr>
               	sub	x0, x29, #0x8
               	mov	x1, #0x7                // =7
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x0
               	mov	x10, x1
               	ldaxr	w16, [x9]
               	add	x11, x16, x10
               	stlxr	w12, w11, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	sxtw	x0, w0
               	cmp	x0, #0x64
               	cset	x0, eq
               	mov	x2, #0x0                // =0
               	cbz	x0, <addr>
               	b	<addr>
               	b	<addr>
               	ldursw	x0, [x29, #-0x8]
               	cmp	x0, #0x6b
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x2, ne
               	cmp	x2, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xc                // =12
               	str	w1, [x0]
               	b	<addr>
               	sub	x0, x29, #0x8
               	mov	x1, #0x7                // =7
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x0
               	mov	x10, x1
               	ldaxr	w16, [x9]
               	sub	x11, x16, x10
               	stlxr	w12, w11, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	sub	x0, x0, #0x7
               	sxtw	x0, w0
               	cmp	x0, #0x64
               	cset	x0, eq
               	mov	x2, #0x0                // =0
               	cbz	x0, <addr>
               	b	<addr>
               	b	<addr>
               	ldursw	x0, [x29, #-0x8]
               	cmp	x0, #0x64
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x2, ne
               	cmp	x2, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xd                // =13
               	str	w1, [x0]
               	b	<addr>
               	sub	x0, x29, #0x8
               	mov	x1, #0x1                // =1
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x0
               	mov	x10, x1
               	ldaxr	w16, [x9]
               	add	x11, x16, x10
               	stlxr	w12, w11, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	cmp	x0, #0x65
               	cset	x0, eq
               	mov	x2, #0x0                // =0
               	cbz	x0, <addr>
               	b	<addr>
               	mov	x0, #0xcc               // =204
               	stur	w0, [x29, #-0x8]
               	b	<addr>
               	ldursw	x0, [x29, #-0x8]
               	cmp	x0, #0x65
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x2, ne
               	cmp	x2, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xe                // =14
               	str	w1, [x0]
               	b	<addr>
               	sub	x0, x29, #0x8
               	mov	x1, #0x33               // =51
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x0
               	mov	x10, x1
               	ldaxr	w16, [x9]
               	orr	x11, x16, x10
               	stlxr	w12, w11, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	sxtw	x0, w0
               	cmp	x0, #0xcc
               	cset	x0, eq
               	mov	x2, #0x0                // =0
               	cbz	x0, <addr>
               	b	<addr>
               	b	<addr>
               	ldursw	x0, [x29, #-0x8]
               	cmp	x0, #0xff
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x2, ne
               	cmp	x2, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xf                // =15
               	str	w1, [x0]
               	b	<addr>
               	sub	x0, x29, #0x8
               	mov	x1, #0xf                // =15
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x0
               	mov	x10, x1
               	ldaxr	w16, [x9]
               	and	x11, x16, x10
               	stlxr	w12, w11, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	and	x0, x0, x1
               	sxtw	x0, w0
               	cmp	x0, #0xf
               	cset	x0, eq
               	mov	x2, #0x0                // =0
               	cbz	x0, <addr>
               	b	<addr>
               	b	<addr>
               	ldursw	x0, [x29, #-0x8]
               	cmp	x0, #0xf
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x2, ne
               	cmp	x2, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x10               // =16
               	str	w1, [x0]
               	b	<addr>
               	sub	x0, x29, #0x8
               	mov	x1, #0xff               // =255
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x0
               	mov	x10, x1
               	ldaxr	w16, [x9]
               	eor	x11, x16, x10
               	stlxr	w12, w11, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	eor	x0, x0, x1
               	sxtw	x0, w0
               	cmp	x0, #0xf0
               	cset	x0, eq
               	mov	x2, #0x0                // =0
               	cbz	x0, <addr>
               	b	<addr>
               	mov	x0, #0x5                // =5
               	stur	w0, [x29, #-0x8]
               	b	<addr>
               	ldursw	x0, [x29, #-0x8]
               	cmp	x0, #0xf0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x2, ne
               	cmp	x2, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x11               // =17
               	str	w1, [x0]
               	b	<addr>
               	sub	x0, x29, #0x8
               	mov	x1, #0x5                // =5
               	mov	x2, #0x6                // =6
               	sub	x3, x29, #0x128
               	str	w1, [x3]
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x0
               	mov	x10, x3
               	mov	x11, x2
               	ldr	w12, [x10]
               	ldaxr	w16, [x9]
               	cmp	x16, x12
               	b.ne	<addr>
               	stlxr	w17, w11, [x9]
               	cbnz	x17, <addr>
               	mov	x16, #0x1               // =1
               	b	<addr>
               	str	w16, [x10]
               	mov	x16, #0x0               // =0
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	ldrsw	x0, [x3]
               	cmp	x0, #0x5
               	cset	x0, eq
               	mov	x2, #0x0                // =0
               	cbz	x0, <addr>
               	b	<addr>
               	b	<addr>
               	ldursw	x0, [x29, #-0x8]
               	cmp	x0, #0x6
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x2, ne
               	cmp	x2, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x12               // =18
               	str	w1, [x0]
               	b	<addr>
               	sub	x0, x29, #0x8
               	mov	x1, #0x5                // =5
               	mov	x2, #0x7                // =7
               	sub	x3, x29, #0x140
               	str	w1, [x3]
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x0
               	mov	x10, x3
               	mov	x11, x2
               	ldr	w12, [x10]
               	ldaxr	w16, [x9]
               	cmp	x16, x12
               	b.ne	<addr>
               	stlxr	w17, w11, [x9]
               	cbnz	x17, <addr>
               	mov	x16, #0x1               // =1
               	b	<addr>
               	str	w16, [x10]
               	mov	x16, #0x0               // =0
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	ldrsw	x0, [x3]
               	cmp	x0, #0x6
               	cset	x0, eq
               	mov	x2, #0x0                // =0
               	cbz	x0, <addr>
               	b	<addr>
               	b	<addr>
               	ldursw	x0, [x29, #-0x8]
               	cmp	x0, #0x6
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x2, ne
               	cmp	x2, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x13               // =19
               	str	w1, [x0]
               	b	<addr>
               	sub	x0, x29, #0x8
               	mov	x1, #0x6                // =6
               	mov	x2, #0x8                // =8
               	sub	x3, x29, #0x158
               	str	w1, [x3]
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x0
               	mov	x10, x3
               	mov	x11, x2
               	ldr	w12, [x10]
               	ldaxr	w16, [x9]
               	cmp	x16, x12
               	b.ne	<addr>
               	stlxr	w17, w11, [x9]
               	cbnz	x17, <addr>
               	mov	x16, #0x1               // =1
               	b	<addr>
               	str	w16, [x10]
               	mov	x16, #0x0               // =0
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	cmp	x0, #0x1
               	cset	x0, eq
               	mov	x2, #0x0                // =0
               	cbz	x0, <addr>
               	b	<addr>
               	b	<addr>
               	ldursw	x0, [x29, #-0x8]
               	cmp	x0, #0x8
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x2, ne
               	cmp	x2, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x14               // =20
               	str	w1, [x0]
               	b	<addr>
               	sub	x0, x29, #0x8
               	mov	x1, #0x6                // =6
               	mov	x2, #0x9                // =9
               	sub	x3, x29, #0x170
               	str	w1, [x3]
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x0
               	mov	x10, x3
               	mov	x11, x2
               	ldr	w12, [x10]
               	ldaxr	w16, [x9]
               	cmp	x16, x12
               	b.ne	<addr>
               	stlxr	w17, w11, [x9]
               	cbnz	x17, <addr>
               	mov	x16, #0x1               // =1
               	b	<addr>
               	str	w16, [x10]
               	mov	x16, #0x0               // =0
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	cmp	x0, #0x0
               	cset	x0, eq
               	mov	x2, #0x0                // =0
               	cbz	x0, <addr>
               	b	<addr>
               	mov	x0, #0x1                // =1
               	stur	w0, [x29, #-0x8]
               	b	<addr>
               	ldursw	x0, [x29, #-0x8]
               	cmp	x0, #0x8
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x2, ne
               	cmp	x2, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x15               // =21
               	str	w1, [x0]
               	b	<addr>
               	sub	x0, x29, #0x8
               	mov	x1, #0x2                // =2
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x0
               	mov	x10, x1
               	ldaxr	w16, [x9]
               	stlxr	w12, w10, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	sxtw	x0, w0
               	cmp	x0, #0x1
               	cset	x0, eq
               	mov	x2, #0x0                // =0
               	cbz	x0, <addr>
               	b	<addr>
               	sub	x0, x29, #0x8
               	mov	x1, #0x0                // =0
               	str	w1, [x0]
               	b	<addr>
               	ldursw	x0, [x29, #-0x8]
               	cmp	x0, #0x2
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x2, ne
               	cmp	x2, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x16               // =22
               	str	w1, [x0]
               	b	<addr>
               	ldursw	x0, [x29, #-0x8]
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	sturb	w0, [x29, #-0x18]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x17               // =23
               	str	w1, [x0]
               	b	<addr>
               	sub	x0, x29, #0x18
               	mov	x1, #0x1                // =1
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x0
               	mov	x10, x1
               	ldaxrb	w16, [x9]
               	stlxrb	w12, w10, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	mov	x2, #0x0                // =0
               	cbz	x0, <addr>
               	b	<addr>
               	b	<addr>
               	ldurb	w0, [x29, #-0x18]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x2, ne
               	cmp	x2, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x18               // =24
               	str	w1, [x0]
               	b	<addr>
               	sub	x0, x29, #0x18
               	mov	x1, #0x1                // =1
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x0
               	mov	x10, x1
               	ldaxrb	w16, [x9]
               	stlxrb	w12, w10, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	b	<addr>
               	sub	x0, x29, #0x18
               	mov	x1, #0x0                // =0
               	strb	w1, [x0]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x19               // =25
               	str	w1, [x0]
               	b	<addr>
               	ldurb	w0, [x29, #-0x18]
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	b	<addr>
               	dmb	ish
               	dmb	ish
               	dmb	ish
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1a               // =26
               	str	w1, [x0]
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	ldr	x19, [sp]
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1b               // =27
               	str	w1, [x0]
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
