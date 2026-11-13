
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
               	str	x20, [sp, #-0x60]!
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
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
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
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
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
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
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x0, #-0x1               // =-1
               	str	x0, [x20]
               	str	x0, [x20, #0x8]
               	str	x0, [x20, #0x10]
               	str	x0, [x20, #0x18]
               	str	x0, [x20, #0x20]
               	str	x0, [x20, #0x28]
               	str	x0, [x20, #0x30]
               	str	x0, [x20, #0x38]
               	mov	x1, #0x0                // =0
               	mov	x2, #0x28               // =40
               	mov	x0, x20
               	bl	<addr>
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	ldrsw	x2, [x20, x0, lsl #2]
               	mov	x3, #-0x1               // =-1
               	cmp	w0, #0xa
               	csel	x3, x1, x3, lt
               	cmp	w2, w3
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
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, x20
               	bl	<addr>
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	ldrb	w2, [x20, x0]
               	add	x3, x0, #0x1
               	cmp	w0, #0x28
               	csel	x3, x3, x1, lt
               	cmp	w2, w3
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
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
