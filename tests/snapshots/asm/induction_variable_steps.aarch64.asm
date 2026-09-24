
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
               	mov	x3, #0x5                // =5
               	mov	x4, #0x5556             // =21846
               	movk	x4, #0x5555, lsl #16
               	mov	x5, #0x6667             // =26215
               	movk	x5, #0x6666, lsl #16
               	mul	x2, x1, x1
               	asr	x6, x1, #1
               	sub	x6, x2, x6
               	mul	x2, x1, x4
               	asr	x2, x2, #32
               	lsr	x7, x2, #63
               	add	x2, x2, x7
               	add	x6, x6, x2
               	mul	x2, x1, x5
               	asr	x2, x2, #33
               	lsr	x7, x2, #63
               	add	x2, x2, x7
               	mul	x2, x2, x3
               	sub	x2, x1, x2
               	add	x2, x6, x2
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
               	lsl	x4, x4, #1
               	sub	x2, x2, x4
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
               	sub	sp, sp, #0x30
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
               	add	sp, sp, #0x30
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
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldursw	x1, [x29, #-0x30]
               	bl	<addr>
               	cmp	x0, #0xea7
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x30
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
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xb                // =11
               	bl	<addr>
               	cmp	x0, #0x3de
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x30
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
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #-0x25              // =-37
               	mov	x1, #0x29               // =41
               	bl	<addr>
               	mov	x17, #0x9b29            // =39721
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldur	x1, [x29, #-0x8]
               	bl	<addr>
               	cmp	x0, #0x750
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldursw	x1, [x29, #-0x28]
               	bl	<addr>
               	mov	x17, #-0x9b8            // =-2488
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldursw	x1, [x29, #-0x30]
               	bl	<addr>
               	cmp	x0, #0xea7
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x30
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
               	add	sp, sp, #0x30
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
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
