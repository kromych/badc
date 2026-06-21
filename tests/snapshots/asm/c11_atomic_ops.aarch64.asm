
c11_atomic_ops.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x30
               	mov	x0, #0x64               // =100
               	stur	w0, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	ldr	w0, [x0]
               	mov	x17, #0x64              // =100
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	mov	x1, #0xfa               // =250
               	str	w1, [x0]
               	sub	x0, x29, #0x8
               	ldr	w0, [x0]
               	mov	x17, #0xfa              // =250
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	mov	x1, #0x5                // =5
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x0]!
               	mov	x9, x0
               	mov	x10, x1
               	ldaxr	w16, [x9]
               	add	x11, x16, x10
               	stlxr	w12, w11, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp], #0x0
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	mov	w0, w0
               	mov	x17, #0xfa              // =250
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w0, [x29, #-0x8]
               	mov	x17, #0xff              // =255
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	mov	x1, #0x32               // =50
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x0]!
               	mov	x9, x0
               	mov	x10, x1
               	ldaxr	w16, [x9]
               	sub	x11, x16, x10
               	stlxr	w12, w11, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp], #0x0
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	mov	w0, w0
               	mov	x17, #0xff              // =255
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w0, [x29, #-0x8]
               	mov	x17, #0xcd              // =205
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	mov	x1, #0xf00              // =3840
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x0]!
               	mov	x9, x0
               	mov	x10, x1
               	ldaxr	w16, [x9]
               	orr	x11, x16, x10
               	stlxr	w12, w11, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp], #0x0
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	mov	w0, w0
               	mov	x17, #0xcd              // =205
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w0, [x29, #-0x8]
               	mov	x17, #0xfcd             // =4045
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	mov	x1, #0xff               // =255
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x0]!
               	mov	x9, x0
               	mov	x10, x1
               	ldaxr	w16, [x9]
               	and	x11, x16, x10
               	stlxr	w12, w11, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp], #0x0
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	mov	w0, w0
               	mov	x17, #0xfcd             // =4045
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w0, [x29, #-0x8]
               	mov	x17, #0xcd              // =205
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	mov	x1, #0xf                // =15
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x0]!
               	mov	x9, x0
               	mov	x10, x1
               	ldaxr	w16, [x9]
               	eor	x11, x16, x10
               	stlxr	w12, w11, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp], #0x0
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	mov	w0, w0
               	mov	x17, #0xcd              // =205
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w0, [x29, #-0x8]
               	mov	x17, #0xc2              // =194
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	mov	x1, #0x7                // =7
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x0]!
               	mov	x9, x0
               	mov	x10, x1
               	ldaxr	w16, [x9]
               	stlxr	w12, w10, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp], #0x0
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	mov	w0, w0
               	cmp	x0, #0xc2
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w0, [x29, #-0x8]
               	mov	x17, #0x7               // =7
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	stur	w0, [x29, #-0x10]
               	sub	x0, x29, #0x8
               	sub	x1, x29, #0x10
               	mov	x2, #0x63               // =99
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x0]!
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
               	ldp	x11, x12, [sp], #0x0
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w0, [x29, #-0x8]
               	mov	x17, #0x63              // =99
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	stur	w0, [x29, #-0x18]
               	sub	x0, x29, #0x8
               	sub	x1, x29, #0x18
               	mov	x2, #0x4d2              // =1234
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x0]!
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
               	ldp	x11, x12, [sp], #0x0
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w0, [x29, #-0x8]
               	mov	x17, #0x63              // =99
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w0, [x29, #-0x18]
               	mov	x17, #0x63              // =99
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xc8               // =200
               	sturb	w0, [x29, #-0x20]
               	sub	x0, x29, #0x20
               	mov	x1, #0x64               // =100
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x0]!
               	mov	x9, x0
               	mov	x10, x1
               	ldaxrb	w16, [x9]
               	add	x11, x16, x10
               	stlxrb	w12, w11, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp], #0x0
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	mov	x17, #0xc8              // =200
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurb	w0, [x29, #-0x20]
               	cmp	x0, #0x2c
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
               	stp	x11, x12, [sp, #0x0]!
               	mov	x9, x0
               	mov	x10, x1
               	ldaxrh	w16, [x9]
               	add	x11, x16, x10
               	stlxrh	w12, w11, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp], #0x0
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	mov	x17, #0xffff            // =65535
               	and	x0, x0, x17
               	mov	x17, #0x9c40            // =40000
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurh	w0, [x29, #-0x28]
               	mov	x17, #0x1170            // =4464
               	cmp	x0, x17
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
               	stp	x11, x12, [sp, #0x0]!
               	mov	x9, x0
               	mov	x10, x1
               	ldaxr	x16, [x9]
               	stlxr	w12, x10, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp], #0x0
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
