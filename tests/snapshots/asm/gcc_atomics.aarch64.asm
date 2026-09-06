
gcc_atomics.aarch64:	file format elf64-littleaarch64

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
               	str	x19, [sp, #-0x60]!
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	mov	x0, #0xa                // =10
               	stur	w0, [x29, #-0x38]
               	sub	x0, x29, #0x38
               	ldrsw	x1, [x0]
               	cmp	w1, #0xa
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	w1, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x1                // =1
               	str	w2, [x1]
               	mov	x1, #0x14               // =20
               	str	w1, [x0]
               	ldursw	x1, [x29, #-0x38]
               	cmp	w1, #0x14
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	w1, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x2                // =2
               	str	w2, [x1]
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
               	cmp	w0, #0x14
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x3                // =3
               	str	w1, [x0]
               	ldursw	x0, [x29, #-0x38]
               	cmp	w0, #0x1e
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x4                // =4
               	str	w1, [x0]
               	mov	x0, #0x64               // =100
               	stur	w0, [x29, #-0x38]
               	sub	x1, x29, #0x38
               	mov	x2, #0x5                // =5
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x1
               	mov	x10, x2
               	ldaxr	w16, [x9]
               	add	x11, x16, x10
               	stlxr	w12, w11, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	cmp	w0, #0x64
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x38]
               	cmp	w0, #0x69
               	cset	x0, eq
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	w2, [x0]
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x1
               	mov	x10, x2
               	ldaxr	w16, [x9]
               	sub	x11, x16, x10
               	stlxr	w12, w11, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	cmp	w0, #0x69
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x38]
               	cmp	w0, #0x64
               	cset	x0, eq
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x2, #0x6                // =6
               	str	w2, [x0]
               	mov	x0, #0xf0               // =240
               	stur	w0, [x29, #-0x38]
               	mov	x0, #0x3c               // =60
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x1
               	mov	x10, x0
               	ldaxr	w16, [x9]
               	and	x11, x16, x10
               	stlxr	w12, w11, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	cmp	w0, #0xf0
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x38]
               	cmp	w0, #0x30
               	cset	x0, eq
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x7                // =7
               	str	w1, [x0]
               	sub	x1, x29, #0x38
               	mov	x0, #0xf                // =15
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x1
               	mov	x10, x0
               	ldaxr	w16, [x9]
               	orr	x11, x16, x10
               	stlxr	w12, w11, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	cmp	w0, #0x30
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x38]
               	cmp	w0, #0x3f
               	cset	x0, eq
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x2, #0x8                // =8
               	str	w2, [x0]
               	mov	x0, #0xff               // =255
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x1
               	mov	x10, x0
               	ldaxr	w16, [x9]
               	eor	x11, x16, x10
               	stlxr	w12, w11, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	cmp	w0, #0x3f
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x38]
               	cmp	w0, #0xc0
               	cset	x0, eq
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x2, #0x9                // =9
               	str	w2, [x0]
               	mov	x0, #0x7                // =7
               	stur	w0, [x29, #-0x38]
               	stur	w0, [x29, #-0x30]
               	sub	x3, x29, #0x30
               	mov	x2, #0x8                // =8
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x1
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
               	mov	x1, x16
               	cmp	x1, #0x1
               	b.ne	<addr>
               	ldursw	x1, [x29, #-0x38]
               	cmp	w1, #0x8
               	cset	x1, eq
               	cbnz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	w1, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0xa                // =10
               	str	w2, [x1]
               	stur	w0, [x29, #-0x30]
               	sub	x2, x29, #0x38
               	mov	x1, #0x9                // =9
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x2
               	mov	x10, x3
               	mov	x11, x1
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
               	mov	x1, x16
               	cbnz	x1, <addr>
               	ldursw	x1, [x29, #-0x38]
               	cmp	w1, #0x8
               	cset	x1, eq
               	cbz	x1, <addr>
               	ldursw	x1, [x29, #-0x30]
               	cmp	w1, #0x8
               	cset	x1, eq
               	cbnz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	w1, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x3, #0xb                // =11
               	str	w3, [x1]
               	mov	x1, #0x64               // =100
               	stur	w1, [x29, #-0x38]
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x2
               	mov	x10, x0
               	ldaxr	w16, [x9]
               	add	x11, x16, x10
               	stlxr	w12, w11, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	cmp	w0, #0x64
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x38]
               	cmp	w0, #0x6b
               	cset	x0, eq
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xc                // =12
               	str	w1, [x0]
               	mov	x0, #0x7                // =7
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x2
               	mov	x10, x0
               	ldaxr	w16, [x9]
               	sub	x11, x16, x10
               	stlxr	w12, w11, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	sub	x0, x0, #0x7
               	cmp	w0, #0x64
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x38]
               	cmp	w0, #0x64
               	cset	x0, eq
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xd                // =13
               	str	w1, [x0]
               	sub	x1, x29, #0x38
               	mov	x0, #0x1                // =1
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x1
               	mov	x10, x0
               	ldaxr	w16, [x9]
               	add	x11, x16, x10
               	stlxr	w12, w11, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	add	x0, x0, #0x1
               	cmp	w0, #0x65
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x38]
               	cmp	w0, #0x65
               	cset	x0, eq
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x2, #0xe                // =14
               	str	w2, [x0]
               	mov	x0, #0xcc               // =204
               	stur	w0, [x29, #-0x38]
               	mov	x0, #0x33               // =51
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x1
               	mov	x10, x0
               	ldaxr	w16, [x9]
               	orr	x11, x16, x10
               	stlxr	w12, w11, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	cmp	w0, #0xcc
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x38]
               	cmp	w0, #0xff
               	cset	x0, eq
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x2, #0xf                // =15
               	str	w2, [x0]
               	mov	x2, #0xf                // =15
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x1
               	mov	x10, x2
               	ldaxr	w16, [x9]
               	and	x11, x16, x10
               	stlxr	w12, w11, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	and	x0, x0, x2
               	cmp	w0, #0xf
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x38]
               	cmp	w0, #0xf
               	cset	x0, eq
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x10               // =16
               	str	w1, [x0]
               	sub	x1, x29, #0x38
               	mov	x2, #0xff               // =255
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x1
               	mov	x10, x2
               	ldaxr	w16, [x9]
               	eor	x11, x16, x10
               	stlxr	w12, w11, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	eor	x0, x0, x2
               	cmp	w0, #0xf0
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x38]
               	cmp	w0, #0xf0
               	cset	x0, eq
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x2, #0x11               // =17
               	str	w2, [x0]
               	mov	x2, #0x5                // =5
               	stur	w2, [x29, #-0x38]
               	mov	x3, #0x6                // =6
               	sub	x0, x29, #0x20
               	str	w2, [x0]
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x1
               	mov	x10, x0
               	mov	x11, x3
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
               	mov	x4, x16
               	ldrsw	x0, [x0]
               	cmp	w0, #0x5
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x38]
               	cmp	w0, #0x6
               	cset	x0, eq
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x4, #0x12               // =18
               	str	w4, [x0]
               	mov	x4, #0x7                // =7
               	sub	x0, x29, #0x18
               	str	w2, [x0]
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x1
               	mov	x10, x0
               	mov	x11, x4
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
               	mov	x1, x16
               	ldrsw	x0, [x0]
               	cmp	w0, #0x6
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x38]
               	cmp	w0, #0x6
               	cset	x0, eq
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x13               // =19
               	str	w1, [x0]
               	sub	x1, x29, #0x38
               	mov	x2, #0x8                // =8
               	sub	x0, x29, #0x10
               	str	w3, [x0]
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x1
               	mov	x10, x0
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
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x38]
               	cmp	w0, #0x8
               	cset	x0, eq
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x2, #0x14               // =20
               	str	w2, [x0]
               	mov	x2, #0x6                // =6
               	mov	x3, #0x9                // =9
               	sub	x0, x29, #0x8
               	str	w2, [x0]
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x1
               	mov	x10, x0
               	mov	x11, x3
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
               	cbnz	x0, <addr>
               	ldursw	x0, [x29, #-0x38]
               	cmp	w0, #0x8
               	cset	x0, eq
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x2, #0x15               // =21
               	str	w2, [x0]
               	mov	x2, #0x1                // =1
               	stur	w2, [x29, #-0x38]
               	mov	x0, #0x2                // =2
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x1
               	mov	x10, x0
               	ldaxr	w16, [x9]
               	stlxr	w12, w10, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	cmp	w0, #0x1
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x38]
               	cmp	w0, #0x2
               	cset	x0, eq
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x16               // =22
               	str	w1, [x0]
               	sub	x0, x29, #0x38
               	mov	x1, #0x0                // =0
               	str	w1, [x0]
               	sturb	w1, [x29, #-0x28]
               	sub	x3, x29, #0x28
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x3
               	mov	x10, x2
               	ldaxrb	w16, [x9]
               	stlxrb	w12, w10, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	cbnz	x0, <addr>
               	ldurb	w0, [x29, #-0x28]
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x4, #0x18               // =24
               	str	w4, [x0]
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x3
               	mov	x10, x2
               	ldaxrb	w16, [x9]
               	stlxrb	w12, w10, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x2, #0x19               // =25
               	str	w2, [x0]
               	strb	w1, [x3]
               	dmb	ish
               	dmb	ish
               	dmb	ish
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp], #0x60
               	ret
