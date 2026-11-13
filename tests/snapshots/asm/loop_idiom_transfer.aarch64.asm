
loop_idiom_transfer.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x50
               	sub	x0, x29, #0x40
               	mov	x1, #0x7f               // =127
               	mov	x2, #0x40               // =64
               	bl	<addr>
               	sub	x0, x29, #0x40
               	mov	x2, #0x10               // =16
               	mov	x1, #0x2                // =2
               	bl	<addr>
               	sub	x1, x29, #0x40
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	cmp	w2, #0x2
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	ldurb	w0, [x29, #-0x30]
               	cmp	w0, #0x7f
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x40
               	mov	x1, #0x7f               // =127
               	mov	x2, #0x40               // =64
               	bl	<addr>
               	sub	x1, x29, #0x40
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	cmp	w2, #0x7f
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x40
               	b.lt	<addr>
               	sub	x0, x29, #0x40
               	mov	x1, #0x7f               // =127
               	mov	x2, #0x40               // =64
               	bl	<addr>
               	sub	x1, x29, #0x40
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	cmp	w2, #0x7f
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x40
               	b.lt	<addr>
               	sub	x0, x29, #0x40
               	mov	x1, #0x7f               // =127
               	mov	x2, #0x40               // =64
               	bl	<addr>
               	sub	x1, x29, #0x40
               	mov	x0, #0x303030303030303  // =217020518514230019
               	stur	x0, [x29, #-0x40]
               	mov	x0, #0x303              // =771
               	movk	x0, #0x303, lsl #16
               	stur	w0, [x29, #-0x38]
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	cmp	w2, #0x3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0xc
               	b.lt	<addr>
               	ldurb	w0, [x29, #-0x34]
               	cmp	w0, #0x7f
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x40
               	mov	x1, #0x7f               // =127
               	mov	x2, #0x40               // =64
               	bl	<addr>
               	sub	x0, x29, #0x40
               	mov	x1, #0x505              // =1285
               	movk	x1, #0x505, lsl #16
               	stur	w1, [x29, #-0x3c]
               	stur	w1, [x29, #-0x38]
               	ldurb	w1, [x29, #-0x3d]
               	cmp	w1, #0x7f
               	b.ne	<addr>
               	add	x1, x0, #0x4
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	cmp	w2, #0x5
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	ldurb	w0, [x29, #-0x34]
               	cmp	w0, #0x7f
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x0, #-0x1               // =-1
               	str	x0, [x3]
               	str	x0, [x3, #0x8]
               	str	x0, [x3, #0x10]
               	str	x0, [x3, #0x18]
               	str	x0, [x3, #0x20]
               	str	x0, [x3, #0x28]
               	str	x0, [x3, #0x30]
               	str	x0, [x3, #0x38]
               	mov	x1, #0x0                // =0
               	mov	x2, #0x28               // =40
               	str	x3, [sp, #0x8]
               	mov	x0, x3
               	bl	<addr>
               	ldr	x3, [sp, #0x8]
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	ldrsw	x2, [x3, x0, lsl #2]
               	mov	x4, #-0x1               // =-1
               	cmp	w0, #0xa
               	csel	x4, x1, x4, lt
               	cmp	w2, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x1, #0x0                // =0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x0, x1
               	add	x2, x0, #0x1
               	strb	w2, [x4, x0]
               	strb	w1, [x3, x0]
               	mov	x0, x2
               	cmp	w0, #0x40
               	b.lt	<addr>
               	mov	x2, #0x28               // =40
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x3, [sp]
               	mov	x0, x3
               	bl	<addr>
               	ldr	x3, [sp]
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	ldrb	w2, [x3, x0]
               	add	x4, x0, #0x1
               	cmp	w0, #0x28
               	csel	x4, x4, x1, lt
               	cmp	w2, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x40
               	b.lt	<addr>
               	sub	x0, x29, #0x40
               	mov	x1, #0x0                // =0
               	mov	x2, #0x40               // =64
               	bl	<addr>
               	sub	x0, x29, #0x40
               	mov	x2, #0x9                // =9
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	sub	x1, x29, #0x40
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	cmp	w2, #0x1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x9
               	b.lt	<addr>
               	ldurb	w0, [x29, #-0x37]
               	cbz	w0, <addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
