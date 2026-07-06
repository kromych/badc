
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
               	asr	x1, x0, #63
               	lsr	x1, x1, #61
               	add	x0, x0, x1
               	asr	x3, x0, #3
               	asr	x0, x2, #63
               	lsr	x0, x0, #61
               	add	x1, x2, x0
               	mov	x17, #0x7               // =7
               	and	x1, x1, x17
               	sub	x0, x1, x0
               	cmp	x0, #0x8
               	b.hs	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x1, x4
               	mov	x2, x5
               	b	<addr>
               	add	x0, x4, #0x1
               	add	x1, x5, #0x1
               	ldrb	w2, [x5]
               	strb	w2, [x4]
               	mov	x4, x0
               	mov	x5, x1
               	add	x0, x4, #0x1
               	add	x1, x5, #0x1
               	ldrb	w2, [x5]
               	strb	w2, [x4]
               	mov	x4, x0
               	mov	x5, x1
               	add	x0, x4, #0x1
               	add	x1, x5, #0x1
               	ldrb	w2, [x5]
               	strb	w2, [x4]
               	mov	x4, x0
               	mov	x5, x1
               	add	x0, x4, #0x1
               	add	x1, x5, #0x1
               	ldrb	w2, [x5]
               	strb	w2, [x4]
               	mov	x4, x0
               	mov	x5, x1
               	add	x0, x4, #0x1
               	add	x1, x5, #0x1
               	ldrb	w2, [x5]
               	strb	w2, [x4]
               	mov	x4, x0
               	mov	x5, x1
               	add	x0, x4, #0x1
               	add	x1, x5, #0x1
               	ldrb	w2, [x5]
               	strb	w2, [x4]
               	mov	x4, x0
               	mov	x5, x1
               	add	x1, x4, #0x1
               	add	x2, x5, #0x1
               	ldrb	w0, [x5]
               	strb	w0, [x4]
               	b	<addr>
               	adr	x17, <addr>
               	ldrsw	x16, [x17, x0, lsl #2]
               	add	x17, x17, x16
               	br	x17
               	<unknown>
               	udf	#0x4c
               	udf	#0x50
               	udf	#0x54
               	udf	#0x58
               	udf	#0x5c
               	udf	#0x60
               	udf	#0x64
               	b	<addr>
               	add	x4, x1, #0x1
               	add	x5, x2, #0x1
               	ldrb	w0, [x2]
               	strb	w0, [x1]
               	b	<addr>
               	sub	x3, x3, #0x1
               	sxtw	x0, w3
               	cmp	x0, #0x0
               	b.gt	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
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
