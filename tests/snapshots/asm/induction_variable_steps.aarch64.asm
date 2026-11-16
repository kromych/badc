
induction_variable_steps.aarch64:	file format elf64-littleaarch64

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

<scan>:
               	mov	x2, x0
               	mov	x0, #0x0                // =0
               	ldrsw	x3, [x2, x0, lsl #2]
               	cmp	w3, w1
               	b.ge	<addr>
               	add	x0, x0, #0x1
               	ldrsw	x3, [x2, x0, lsl #2]
               	cmp	w3, w1
               	b.lt	<addr>
               	ret

<scan_down>:
               	mov	x1, x0
               	mov	x0, #0x3f               // =63
               	ldrsw	x3, [x1, x0, lsl #2]
               	cmp	w3, w2
               	b.le	<addr>
               	sub	x0, x0, #0x1
               	ldrsw	x3, [x1, x0, lsl #2]
               	cmp	w3, w2
               	b.gt	<addr>
               	ret

<stride>:
               	mov	x3, x0
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	cmp	w0, w1
               	b.ge	<addr>
               	ldrsw	x4, [x3, x0, lsl #2]
               	add	x2, x2, x4
               	add	x0, x0, #0x3
               	cmp	w0, w1
               	b.lt	<addr>
               	mov	x0, x2
               	ret

<stride_var>:
               	mov	x4, x0
               	sxtw	x2, w2
               	mov	x0, #0x0                // =0
               	mov	x3, x0
               	cmp	w0, w1
               	b.ge	<addr>
               	ldrsw	x5, [x4, x0, lsl #2]
               	add	x3, x3, x5
               	add	x0, x0, x2
               	cmp	w0, w1
               	b.lt	<addr>
               	mov	x0, x3
               	ret

<triangle>:
               	mov	x3, x0
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	mov	x2, x0
               	ldrsw	x4, [x3, x0, lsl #2]
               	add	x2, x2, x4
               	add	x1, x1, #0x1
               	add	x0, x0, x1
               	cmp	w1, #0xb
               	b.lt	<addr>
               	mov	x0, x2
               	ret

<upto>:
               	mov	x2, x0
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	ldrsw	x3, [x2, x0, lsl #2]
               	add	x1, x1, x3
               	add	x0, x0, #0x1
               	cmp	w0, #0x3e
               	b.le	<addr>
               	mov	x0, x1
               	ret

<cross_zero>:
               	mov	x1, #-0x25              // =-37
               	mov	x0, #0x0                // =0
               	mov	x3, #0x5556             // =21846
               	movk	x3, #0x5555, lsl #16
               	mov	x4, #0x6667             // =26215
               	movk	x4, #0x6666, lsl #16
               	mul	x2, x1, x1
               	sub	x5, x2, x1, asr #1
               	mul	x2, x1, x3
               	asr	x2, x2, #32
               	add	x2, x2, x2, lsr #63
               	add	x5, x5, x2
               	mul	x2, x1, x4
               	asr	x2, x2, #33
               	add	x2, x2, x2, lsr #63
               	add	x2, x2, x2, lsl #2
               	sub	x2, x1, x2
               	add	x2, x5, x2
               	add	x0, x0, x2
               	add	x1, x1, #0x1
               	cmp	w1, #0x29
               	b.lt	<addr>
               	ret

<square_bound>:
               	mov	x3, x0
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	mul	x4, x0, x0
               	cmp	x4, x1
               	b.ge	<addr>
               	ldrsw	x4, [x3, x0, lsl #2]
               	add	x2, x2, x4
               	add	x0, x0, #0x1
               	mul	x4, x0, x0
               	cmp	x4, x1
               	b.lt	<addr>
               	mov	x0, x2
               	ret

<two_steps>:
               	mov	x3, x0
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	cmp	w0, w1
               	b.ge	<addr>
               	add	x4, x0, #0x1
               	ldrb	w0, [x3, x0]
               	add	x2, x2, x0
               	add	x0, x4, #0x1
               	ldrb	w4, [x3, x4]
               	sub	x2, x2, x4, lsl #1
               	cmp	w0, w1
               	b.lt	<addr>
               	mov	x0, x2
               	ret

<down3>:
               	mov	x2, x0
               	sxtw	x1, w1
               	mov	x0, #0x0                // =0
               	sub	x1, x1, #0x1
               	cmp	w1, #0x0
               	b.lt	<addr>
               	ldrsw	x3, [x2, x1, lsl #2]
               	add	x0, x0, x3
               	sub	x1, x1, #0x3
               	cmp	w1, #0x0
               	b.ge	<addr>
               	ret

<last_index>:
               	mov	x3, x0
               	mov	x0, #0x0                // =0
               	cmp	w0, w1
               	b.ge	<addr>
               	ldrsw	x4, [x3, x0, lsl #2]
               	cmp	w4, w2
               	b.eq	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, w1
               	b.lt	<addr>
               	ret

<partition>:
               	mov	x2, #0x0                // =0
               	ldrsw	x4, [x0, #0xfc]
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	add	x2, x2, #0x1
               	cmp	w2, #0x3f
               	b.ge	<addr>
               	ldrsw	x3, [x0, x2, lsl #2]
               	cmp	w3, w4
               	b.ge	<addr>
               	add	x1, x1, #0x1
               	ldrsw	x5, [x0, x1, lsl #2]
               	str	w3, [x0, x1, lsl #2]
               	str	w5, [x0, x2, lsl #2]
               	b	<addr>
               	add	x1, x1, #0x1
               	ldrsw	x2, [x0, w1, sxtw #2]
               	ldrsw	x3, [x0, #0xfc]
               	str	w3, [x0, w1, sxtw #2]
               	str	w2, [x0, #0xfc]
               	mov	x0, x1
               	ret

<zigzag>:
               	mov	x3, x0
               	mov	x0, #0x0                // =0
               	mov	x1, #0xa                // =10
               	mov	x2, x0
               	sub	x4, x1, #0x1
               	add	x1, x1, #0x2
               	ldrsw	x5, [x3, x0, lsl #2]
               	tst	x5, #0x1
               	csel	x1, x4, x1, ne
               	ldrsw	x4, [x3, x1, lsl #2]
               	add	x2, x2, x4
               	add	x0, x0, #0x1
               	cmp	w0, #0x28
               	b.lt	<addr>
               	mov	x0, x2
               	ret

<reset>:
               	mov	x4, x0
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	mov	x3, x0
               	cmp	w0, w1
               	b.ge	<addr>
               	asr	x5, x0, #1
               	add	x2, x2, #0x1
               	ldrsw	x6, [x4, x0, lsl #2]
               	cmp	w6, #0x64
               	csel	x2, x5, x2, gt
               	ldrsw	x5, [x4, w2, sxtw #2]
               	add	x3, x3, x5
               	add	x0, x0, #0x1
               	cmp	w0, w1
               	b.lt	<addr>
               	mov	x0, x3
               	ret

<hash>:
               	mov	x2, #0x7                // =7
               	mov	x1, #0x0                // =0
               	mov	x3, #0x1f               // =31
               	mul	x2, x2, x3
               	ldrb	w4, [x0, x1]
               	add	x2, x2, x4
               	add	x1, x1, #0x1
               	cmp	w1, #0x5
               	b.lt	<addr>
               	sxtw	x0, w2
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	mov	x0, #0x0                // =0
               	mov	x1, #0x7                // =7
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mul	x3, x0, x1
               	sub	x3, x3, #0x32
               	str	w3, [x2, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x40
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	mov	x1, #0xd                // =13
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mul	x3, x0, x1
               	add	x3, x3, #0x5
               	and	x3, x3, #0xff
               	strb	w3, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x28
               	b.lt	<addr>
               	mov	x0, #0x40               // =64
               	stur	w0, [x29, #-0x30]
               	mov	x0, #0x28               // =40
               	stur	w0, [x29, #-0x28]
               	mov	x0, #0x5                // =5
               	stur	w0, [x29, #-0x20]
               	mov	x0, #0xc8               // =200
               	stur	w0, [x29, #-0x18]
               	mov	x0, #-0x28              // =-40
               	stur	w0, [x29, #-0x10]
               	mov	x0, #0x3e8              // =1000
               	stur	x0, [x29, #-0x8]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldursw	x1, [x29, #-0x18]
               	bl	<addr>
               	cmp	w0, #0x24
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x3f               // =63
               	ldursw	x2, [x29, #-0x10]
               	bl	<addr>
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldursw	x1, [x29, #-0x30]
               	bl	<addr>
               	cmp	x0, #0xea7
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldursw	x1, [x29, #-0x30]
               	ldursw	x2, [x29, #-0x20]
               	bl	<addr>
               	cmp	x0, #0x820
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xb                // =11
               	bl	<addr>
               	cmp	x0, #0x3de
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x3e               // =62
               	bl	<addr>
               	mov	x17, #0x2919            // =10521
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #-0x25              // =-37
               	mov	x1, #0x29               // =41
               	bl	<addr>
               	mov	x17, #0x9b29            // =39721
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldur	x1, [x29, #-0x8]
               	bl	<addr>
               	cmp	x0, #0x750
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldursw	x1, [x29, #-0x28]
               	bl	<addr>
               	cmn	x0, #0x9b8
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldursw	x1, [x29, #-0x30]
               	bl	<addr>
               	cmp	x0, #0xea7
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldursw	x1, [x29, #-0x30]
               	mov	x2, #0x5a               // =90
               	bl	<addr>
               	cmp	x0, #0x14
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldursw	x1, [x29, #-0x30]
               	mov	x2, #0x5b               // =91
               	bl	<addr>
               	cmp	x0, #0x40
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x5                // =5
               	bl	<addr>
               	mov	x17, #0xa78             // =2680
               	movk	x17, #0xc41, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x3, #0x25               // =37
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mul	x1, x0, x3
               	sxtw	x1, w1
               	lsr	x2, x1, #58
               	add	x1, x1, x2
               	and	x1, x1, #0x3f
               	sub	x1, x1, x2
               	sub	x1, x1, #0x14
               	str	w1, [x4, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x40
               	b.lt	<addr>
               	mov	x1, #0x0                // =0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x2, #0x3f               // =63
               	str	x3, [sp, #0x8]
               	mov	x0, x3
               	bl	<addr>
               	ldr	x3, [sp, #0x8]
               	mov	x1, #0x0                // =0
               	mov	x2, #0x0                // =0
               	add	x2, x2, x2, lsl #1
               	ldrsw	x4, [x3, x1, lsl #2]
               	add	x2, x2, x4
               	add	x1, x1, #0x1
               	cmp	w1, #0x40
               	b.lt	<addr>
               	cmp	w0, #0x1b
               	b.ne	<addr>
               	mov	x17, #0x600c            // =24588
               	movk	x17, #0x6fd4, lsl #16
               	movk	x17, #0x16b2, lsl #32
               	movk	x17, #0x2c70, lsl #48
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x28               // =40
               	bl	<addr>
               	cmp	x0, #0xf28
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldursw	x1, [x29, #-0x30]
               	mov	x2, #0x64               // =100
               	bl	<addr>
               	mov	x17, #0x1289            // =4745
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
