
stdatomic_c11.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x50
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	mov	x1, #0x5                // =5
               	str	w1, [x0]
               	sub	x0, x29, #0x8
               	ldrsw	x0, [x0]
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	mov	x1, #0xa                // =10
               	ldrsw	x2, [x0]
               	add	x1, x2, x1
               	str	w1, [x0]
               	cmp	x2, #0x5
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x8]
               	cmp	x0, #0xf
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xf                // =15
               	stur	w0, [x29, #-0x10]
               	sub	x0, x29, #0x8
               	sub	x1, x29, #0x10
               	mov	x2, #0x63               // =99
               	ldrsw	x3, [x0]
               	ldrsw	x4, [x1]
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
               	b.ne	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x8]
               	cmp	x0, #0x63
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x1]
               	strb	w10, [x0]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x18
               	mov	x1, #0x1                // =1
               	ldrb	w2, [x0]
               	strb	w1, [x0]
               	cmp	x2, #0x0
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	mov	x1, #0x0                // =0
               	strb	w1, [x0]
               	stur	w1, [x29, #-0x20]
               	sub	x0, x29, #0x20
               	mov	x1, #0x2a               // =42
               	str	w1, [x0]
               	sub	x0, x29, #0x20
               	ldrsw	x0, [x0]
               	cmp	x0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x30
               	mov	x1, #0x64               // =100
               	str	x1, [x0]
               	sub	x0, x29, #0x30
               	mov	x1, #0x1                // =1
               	ldr	x2, [x0]
               	add	x1, x2, x1
               	str	x1, [x0]
               	sub	x0, x29, #0x30
               	ldr	x0, [x0]
               	cmp	x0, #0x65
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x30
               	mov	x1, #0x1                // =1
               	str	w1, [x0, #0x8]
               	sub	x0, x29, #0x30
               	ldrsw	x0, [x0, #0x8]
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7fff             // =32767
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	mov	x3, #0x0                // =0
               	mov	x17, #0x7fff            // =32767
               	cmp	x0, x17
               	cset	x3, ne
               	cbz	x3, <addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
