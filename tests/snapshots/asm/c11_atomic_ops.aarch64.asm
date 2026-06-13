
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
               	ldr	w2, [x0]
               	add	x1, x2, x1
               	str	w1, [x0]
               	mov	x17, #0xfa              // =250
               	eor	x0, x2, x17
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
               	ldr	w2, [x0]
               	sub	x1, x2, x1
               	str	w1, [x0]
               	mov	x17, #0xff              // =255
               	eor	x0, x2, x17
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
               	ldr	w2, [x0]
               	orr	x1, x2, x1
               	str	w1, [x0]
               	mov	x17, #0xcd              // =205
               	eor	x0, x2, x17
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
               	ldr	w2, [x0]
               	and	x1, x2, x1
               	str	w1, [x0]
               	mov	x17, #0xfcd             // =4045
               	eor	x0, x2, x17
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
               	ldr	w2, [x0]
               	eor	x1, x2, x1
               	str	w1, [x0]
               	mov	x17, #0xcd              // =205
               	eor	x0, x2, x17
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
               	ldr	w2, [x0]
               	str	w1, [x0]
               	cmp	x2, #0xc2
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
               	ldr	w3, [x0]
               	ldr	w4, [x1]
               	cmp	x3, x4
               	cset	x5, eq
               	mov	x6, #0x0                // =0
               	sub	x6, x6, x5
               	eor	x2, x3, x2
               	and	x2, x2, x6
               	eor	x2, x3, x2
               	str	w2, [x0]
               	eor	x0, x3, x4
               	and	x0, x0, x6
               	eor	x0, x3, x0
               	str	w0, [x1]
               	cmp	x5, #0x1
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
               	ldr	w3, [x0]
               	ldr	w4, [x1]
               	cmp	x3, x4
               	cset	x5, eq
               	mov	x6, #0x0                // =0
               	sub	x6, x6, x5
               	eor	x2, x3, x2
               	and	x2, x2, x6
               	eor	x2, x3, x2
               	str	w2, [x0]
               	eor	x0, x3, x4
               	and	x0, x0, x6
               	eor	x0, x3, x0
               	str	w0, [x1]
               	cmp	x5, #0x0
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
               	ldrb	w2, [x0]
               	add	x1, x2, x1
               	strb	w1, [x0]
               	mov	x17, #0xc8              // =200
               	eor	x0, x2, x17
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
               	ldrh	w2, [x0]
               	add	x1, x2, x1
               	strh	w1, [x0]
               	mov	x17, #0x9c40            // =40000
               	eor	x0, x2, x17
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
               	ldr	x2, [x0]
               	str	x1, [x0]
               	mov	x17, #0x7788            // =30600
               	movk	x17, #0x5566, lsl #16
               	movk	x17, #0x3344, lsl #32
               	movk	x17, #0x1122, lsl #48
               	cmp	x2, x17
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
