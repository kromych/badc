
c11_atomic_ops.aarch64:	file format elf64-littleaarch64

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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	mov	x2, #0x64               // =100
               	stur	w2, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	ldr	w1, [x0]
               	mov	x17, #0x64              // =100
               	eor	x1, x1, x17
               	mov	w1, w1
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0xfa               // =250
               	str	w1, [x0]
               	ldr	w1, [x0]
               	mov	x17, #0xfa              // =250
               	eor	x1, x1, x17
               	mov	w1, w1
               	cbz	x1, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
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
               	mov	x3, x16
               	mov	w3, w3
               	mov	x17, #0xfa              // =250
               	eor	x3, x3, x17
               	mov	w3, w3
               	cbz	x3, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w3, [x29, #-0x8]
               	mov	x17, #0xff              // =255
               	eor	x3, x3, x17
               	mov	w3, w3
               	cbz	x3, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0x32               // =50
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x0
               	mov	x10, x3
               	ldaxr	w16, [x9]
               	sub	x11, x16, x10
               	stlxr	w12, w11, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x3, x16
               	mov	w3, w3
               	mov	x17, #0xff              // =255
               	eor	x3, x3, x17
               	mov	w3, w3
               	cbz	x3, <addr>
               	mov	x0, x1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w3, [x29, #-0x8]
               	mov	x17, #0xcd              // =205
               	eor	x3, x3, x17
               	mov	w3, w3
               	cbz	x3, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0xf00              // =3840
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x0
               	mov	x10, x3
               	ldaxr	w16, [x9]
               	orr	x11, x16, x10
               	stlxr	w12, w11, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x3, x16
               	mov	w3, w3
               	mov	x17, #0xcd              // =205
               	eor	x3, x3, x17
               	mov	w3, w3
               	cbz	x3, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w3, [x29, #-0x8]
               	mov	x17, #0xfcd             // =4045
               	eor	x3, x3, x17
               	mov	w3, w3
               	cbz	x3, <addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0xff               // =255
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x0
               	mov	x10, x3
               	ldaxr	w16, [x9]
               	and	x11, x16, x10
               	stlxr	w12, w11, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x3, x16
               	mov	w3, w3
               	mov	x17, #0xfcd             // =4045
               	eor	x3, x3, x17
               	mov	w3, w3
               	cbz	x3, <addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w3, [x29, #-0x8]
               	mov	x17, #0xcd              // =205
               	eor	x3, x3, x17
               	mov	w3, w3
               	cbz	x3, <addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0xf                // =15
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x0
               	mov	x10, x3
               	ldaxr	w16, [x9]
               	eor	x11, x16, x10
               	stlxr	w12, w11, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x4, x16
               	mov	w4, w4
               	mov	x17, #0xcd              // =205
               	eor	x4, x4, x17
               	mov	w4, w4
               	cbz	x4, <addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w4, [x29, #-0x8]
               	mov	x17, #0xc2              // =194
               	eor	x4, x4, x17
               	mov	w4, w4
               	cbz	x4, <addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x4, #0x7                // =7
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x0
               	mov	x10, x4
               	ldaxr	w16, [x9]
               	stlxr	w12, w10, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x5, x16
               	mov	w5, w5
               	cmp	w5, #0xc2
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w5, [x29, #-0x8]
               	mov	x17, #0x7               // =7
               	eor	x5, x5, x17
               	mov	w5, w5
               	cbz	x5, <addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	w4, [x29, #-0x10]
               	sub	x4, x29, #0x10
               	mov	x5, #0x63               // =99
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x0
               	mov	x10, x4
               	mov	x11, x5
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
               	cmp	x4, #0x1
               	b.eq	<addr>
               	mov	x0, x3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w3, [x29, #-0x8]
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	mov	w3, w3
               	cbz	x3, <addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	w1, [x29, #-0x18]
               	sub	x1, x29, #0x18
               	mov	x3, #0x4d2              // =1234
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x0
               	mov	x10, x1
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
               	cbz	x0, <addr>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w0, [x29, #-0x8]
               	mov	x17, #0x63              // =99
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x12               // =18
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w0, [x29, #-0x18]
               	mov	x17, #0x63              // =99
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x13               // =19
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xc8               // =200
               	sturb	w0, [x29, #-0x20]
               	sub	x0, x29, #0x20
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x0
               	mov	x10, x2
               	ldaxrb	w16, [x9]
               	add	x11, x16, x10
               	stlxrb	w12, w11, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	mov	x17, #0xc8              // =200
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurb	w0, [x29, #-0x20]
               	cmp	w0, #0x2c
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x9c40             // =40000
               	sturh	w0, [x29, #-0x28]
               	sub	x0, x29, #0x28
               	mov	x1, #0x7530             // =30000
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x0
               	mov	x10, x1
               	ldaxrh	w16, [x9]
               	add	x11, x16, x10
               	stlxrh	w12, w11, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	mov	x17, #0xffff            // =65535
               	and	x0, x0, x17
               	mov	x17, #0x9c40            // =40000
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurh	w0, [x29, #-0x28]
               	mov	x17, #0x1170            // =4464
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7788             // =30600
               	movk	x0, #0x5566, lsl #16
               	movk	x0, #0x3344, lsl #32
               	movk	x0, #0x1122, lsl #48
               	stur	x0, [x29, #-0x30]
               	sub	x0, x29, #0x30
               	mov	x1, #0x1                // =1
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x0
               	mov	x10, x1
               	ldaxr	x16, [x9]
               	stlxr	w12, x10, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	mov	x17, #0x7788            // =30600
               	movk	x17, #0x5566, lsl #16
               	movk	x17, #0x3344, lsl #32
               	movk	x17, #0x1122, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x18               // =24
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x30]
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x19               // =25
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
