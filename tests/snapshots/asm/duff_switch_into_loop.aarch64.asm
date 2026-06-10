
duff_switch_into_loop.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x4, x0
               	mov	x5, x1
               	sxtw	x2, w2
               	add	x0, x2, #0x7
               	sxtw	x0, w0
               	mov	x1, #0x8                // =8
               	sdiv	x3, x0, x1
               	sdiv	x17, x2, x1
               	msub	x0, x17, x1, x2
               	cmp	x0, #0x4
               	b.lt	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x1, x4
               	mov	x2, x5
               	b	<addr>
               	add	x1, x4, #0x1
               	add	x2, x5, #0x1
               	ldrb	w0, [x5]
               	strb	w0, [x4]
               	add	x4, x1, #0x1
               	add	x5, x2, #0x1
               	ldrb	w0, [x2]
               	strb	w0, [x1]
               	add	x1, x4, #0x1
               	add	x2, x5, #0x1
               	ldrb	w0, [x5]
               	strb	w0, [x4]
               	add	x4, x1, #0x1
               	add	x5, x2, #0x1
               	ldrb	w0, [x2]
               	strb	w0, [x1]
               	add	x1, x4, #0x1
               	add	x2, x5, #0x1
               	ldrb	w0, [x5]
               	strb	w0, [x4]
               	add	x4, x1, #0x1
               	add	x5, x2, #0x1
               	ldrb	w0, [x2]
               	strb	w0, [x1]
               	add	x1, x4, #0x1
               	add	x2, x5, #0x1
               	ldrb	w0, [x5]
               	strb	w0, [x4]
               	b	<addr>
               	cmp	x0, #0x2
               	b.lt	<addr>
               	b	<addr>
               	cmp	x0, #0x6
               	b.lt	<addr>
               	b	<addr>
               	cmp	x0, #0x1
               	b.lt	<addr>
               	b	<addr>
               	cmp	x0, #0x3
               	b.lt	<addr>
               	b	<addr>
               	cmp	x0, #0x0
               	b.eq	<addr>
               	b	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	b	<addr>
               	cmp	x0, #0x2
               	b.eq	<addr>
               	b	<addr>
               	cmp	x0, #0x3
               	b.eq	<addr>
               	b	<addr>
               	cmp	x0, #0x5
               	b.lt	<addr>
               	b	<addr>
               	cmp	x0, #0x7
               	b.lt	<addr>
               	b	<addr>
               	cmp	x0, #0x4
               	b.eq	<addr>
               	b	<addr>
               	cmp	x0, #0x5
               	b.eq	<addr>
               	b	<addr>
               	cmp	x0, #0x6
               	b.eq	<addr>
               	b	<addr>
               	cmp	x0, #0x7
               	b.eq	<addr>
               	b	<addr>
               	b	<addr>
               	add	x4, x1, #0x1
               	add	x5, x2, #0x1
               	ldrb	w0, [x2]
               	strb	w0, [x1]
               	b	<addr>
               	sxtw	x0, w3
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x3, x0, x17
               	sxtw	x0, w3
               	cmp	x0, #0x0
               	b.gt	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x1, x4
               	mov	x2, x5
               	b	<addr>
               	b	<addr>
               	mov	x1, x4
               	mov	x2, x5
               	b	<addr>
               	b	<addr>
               	mov	x1, x4
               	mov	x2, x5
               	b	<addr>
               	b	<addr>
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	mov	x1, #0x0                // =0
               	sxtw	x0, w1
               	cmp	x0, #0x27
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w1
               	add	x1, x0, #0x1
               	b	<addr>
               	sub	x0, x29, #0x28
               	sxtw	x2, w1
               	add	x0, x0, x2
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	strb	w2, [x0]
               	sub	x0, x29, #0x50
               	sxtw	x2, w1
               	add	x0, x0, x2
               	mov	x2, #0x0                // =0
               	strb	w2, [x0]
               	b	<addr>
               	sub	x0, x29, #0x50
               	sub	x1, x29, #0x28
               	mov	x2, #0x27               // =39
               	bl	<addr>
               	mov	x1, #0x0                // =0
               	sxtw	x0, w1
               	cmp	x0, #0x27
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w1
               	add	x1, x0, #0x1
               	b	<addr>
               	sub	x0, x29, #0x50
               	sxtw	x2, w1
               	add	x0, x0, x2
               	ldrb	w0, [x0]
               	sub	x2, x29, #0x28
               	sxtw	x3, w1
               	add	x2, x2, x3
               	ldrb	w2, [x2]
               	cmp	x0, x2
               	b.eq	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
