
cross_block_cse.aarch64:	file format elf64-littleaarch64

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
               	sub	x3, x29, #0x28
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x28]
               	mov	x1, #0x1                // =1
               	stur	w1, [x29, #-0x24]
               	mov	x1, #0x4                // =4
               	stur	w1, [x29, #-0x20]
               	mov	x1, #0x9                // =9
               	stur	w1, [x29, #-0x1c]
               	mov	x1, #0x10               // =16
               	stur	w1, [x29, #-0x18]
               	mov	x1, #0x19               // =25
               	stur	w1, [x29, #-0x14]
               	mov	x1, #0x24               // =36
               	stur	w1, [x29, #-0x10]
               	mov	x1, #0x31               // =49
               	stur	w1, [x29, #-0xc]
               	mov	x1, #0x40               // =64
               	stur	w1, [x29, #-0x8]
               	mov	x1, #0x51               // =81
               	stur	w1, [x29, #-0x4]
               	ldursw	x1, [x29, #-0xc]
               	cmp	w1, #0xc8
               	b.le	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	w1, #0x31
               	b.ne	<addr>
               	mov	x1, #0x99               // =153
               	mov	x4, #0xa                // =10
               	mov	x5, #0x999a             // =39322
               	movk	x5, #0x1999, lsl #16
               	mul	x2, x1, x5
               	lsr	x2, x2, #32
               	mul	x6, x2, x4
               	sub	x1, x1, x6
               	ldrsw	x1, [x3, x1, lsl #2]
               	add	x0, x0, x1
               	cmp	w0, #0xc8
               	b.gt	<addr>
               	mov	x1, x2
               	cmp	w1, #0x0
               	b.gt	<addr>
               	cmp	w0, #0x23
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x28
               	mov	x1, #0x423f             // =16959
               	movk	x1, #0xf, lsl #16
               	mov	x4, #0xa                // =10
               	mov	x5, #0x999a             // =39322
               	movk	x5, #0x1999, lsl #16
               	mov	x0, #0x0                // =0
               	mul	x2, x1, x5
               	lsr	x2, x2, #32
               	mul	x6, x2, x4
               	sub	x1, x1, x6
               	ldrsw	x1, [x3, x1, lsl #2]
               	add	x0, x0, x1
               	cmp	w0, #0xc8
               	b.gt	<addr>
               	mov	x1, x2
               	cmp	w1, #0x0
               	b.gt	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x30]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x30]
               	mov	x0, x1
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x4, x29, #0x30
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x4]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x4, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x4, #0x20]
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	add	x2, x0, x0, lsl #1
               	add	x2, x2, #0x1
               	ldr	x3, [x4, x0, lsl #3]
               	madd	x5, x3, x2, x1
               	sub	x1, x1, x2
               	cmp	x3, #0x0
               	csel	x1, x5, x1, gt
               	add	x0, x0, #0x1
               	cmp	w0, #0x6
               	b.lt	<addr>
               	cmp	x1, #0x42
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
