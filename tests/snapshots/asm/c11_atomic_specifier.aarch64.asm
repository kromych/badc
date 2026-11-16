
c11_atomic_specifier.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x40
               	mov	x0, #0xc8               // =200
               	sturb	w0, [x29, #-0x38]
               	mov	x0, #0x9c40             // =40000
               	sturh	w0, [x29, #-0x28]
               	mov	x0, #0x3344             // =13124
               	movk	x0, #0x1122, lsl #16
               	stur	w0, [x29, #-0x20]
               	mov	x0, #0x7788             // =30600
               	movk	x0, #0x5566, lsl #16
               	movk	x0, #0x3344, lsl #32
               	movk	x0, #0x1122, lsl #48
               	stur	x0, [x29, #-0x18]
               	sub	x0, x29, #0x38
               	ldarb	w1, [x0]
               	cmp	w1, #0xc8
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x28
               	ldarh	w1, [x1]
               	mov	x17, #0x9c40            // =40000
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x20
               	ldar	w1, [x1]
               	mov	x17, #0x3344            // =13124
               	movk	x17, #0x1122, lsl #16
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x18
               	ldar	x1, [x1]
               	mov	x17, #0x7788            // =30600
               	movk	x17, #0x5566, lsl #16
               	movk	x17, #0x3344, lsl #32
               	movk	x17, #0x1122, lsl #48
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldarb	w1, [x0]
               	cmp	w1, #0xc8
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0xfa               // =250
               	stlrb	w1, [x0]
               	ldarb	w0, [x0]
               	cmp	w0, #0xfa
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #-0x7               // =-7
               	stur	w0, [x29, #-0x30]
               	mov	x0, #0x63               // =99
               	stur	x0, [x29, #-0x10]
               	mov	x0, #0xd                // =13
               	sturh	w0, [x29, #-0x8]
               	sub	x0, x29, #0x30
               	ldar	w1, [x0]
               	cmn	w1, #0x7
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x10
               	ldar	x1, [x1]
               	cmp	x1, #0x63
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x8
               	ldarh	w1, [x1]
               	sxth	x1, w1
               	cmp	w1, #0xd
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x15               // =21
               	stlr	w1, [x0]
               	ldar	w0, [x0]
               	cmp	w0, #0x15
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
