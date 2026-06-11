
c11_atomic_specifier.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0xc8               // =200
               	sturb	w0, [x29, #-0x8]
               	mov	x0, #0x9c40             // =40000
               	mov	x1, #0x3344             // =13124
               	movk	x1, #0x1122, lsl #16
               	mov	x2, #0x7788             // =30600
               	movk	x2, #0x5566, lsl #16
               	movk	x2, #0x3344, lsl #32
               	movk	x2, #0x1122, lsl #48
               	ldurb	w3, [x29, #-0x8]
               	mov	x17, #0xc8              // =200
               	eor	x3, x3, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x3, x3, x17
               	cmp	x3, #0x0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0x9c40            // =40000
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0x3344            // =13124
               	movk	x17, #0x1122, lsl #16
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0x7788            // =30600
               	movk	x17, #0x5566, lsl #16
               	movk	x17, #0x3344, lsl #32
               	movk	x17, #0x1122, lsl #48
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	ldrb	w1, [x0]
               	mov	x17, #0xc8              // =200
               	eor	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0xfa               // =250
               	strb	w1, [x0]
               	ldurb	w0, [x29, #-0x8]
               	mov	x17, #0xfa              // =250
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xfff9             // =65529
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	stur	w0, [x29, #-0x30]
               	mov	x0, #0x63               // =99
               	mov	x1, #0xd                // =13
               	ldursw	x2, [x29, #-0x30]
               	mov	x17, #0xfff9            // =65529
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	x0, #0x63
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	x1, #0xd
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x30
               	mov	x1, #0x15               // =21
               	str	w1, [x0]
               	ldursw	x0, [x29, #-0x30]
               	cmp	x0, #0x15
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
