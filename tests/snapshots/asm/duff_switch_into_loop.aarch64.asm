
duff_switch_into_loop.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x3, x2
               	sxtw	x3, w3
               	add	x2, x3, #0x7
               	sxtw	x2, w2
               	asr	x4, x2, #63
               	lsr	x4, x4, #61
               	add	x2, x2, x4
               	asr	x2, x2, #3
               	asr	x4, x3, #63
               	lsr	x4, x4, #61
               	add	x3, x3, x4
               	mov	x17, #0x7               // =7
               	and	x3, x3, x17
               	sub	x3, x3, x4
               	cmp	x3, #0x8
               	b.hs	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x3, x0
               	mov	x4, x1
               	b	<addr>
               	add	x3, x0, #0x1
               	add	x4, x1, #0x1
               	ldrb	w1, [x1]
               	strb	w1, [x0]
               	mov	x0, x3
               	mov	x1, x4
               	add	x3, x0, #0x1
               	add	x4, x1, #0x1
               	ldrb	w1, [x1]
               	strb	w1, [x0]
               	mov	x0, x3
               	mov	x1, x4
               	add	x3, x0, #0x1
               	add	x4, x1, #0x1
               	ldrb	w1, [x1]
               	strb	w1, [x0]
               	mov	x0, x3
               	mov	x1, x4
               	add	x3, x0, #0x1
               	add	x4, x1, #0x1
               	ldrb	w1, [x1]
               	strb	w1, [x0]
               	mov	x0, x3
               	mov	x1, x4
               	add	x3, x0, #0x1
               	add	x4, x1, #0x1
               	ldrb	w1, [x1]
               	strb	w1, [x0]
               	mov	x0, x3
               	mov	x1, x4
               	add	x3, x0, #0x1
               	add	x4, x1, #0x1
               	ldrb	w1, [x1]
               	strb	w1, [x0]
               	mov	x0, x3
               	mov	x1, x4
               	add	x3, x0, #0x1
               	add	x4, x1, #0x1
               	ldrb	w1, [x1]
               	strb	w1, [x0]
               	b	<addr>
               	adr	x17, <addr>
               	ldrsw	x16, [x17, x3, lsl #2]
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
               	add	x0, x3, #0x1
               	add	x1, x4, #0x1
               	ldrb	w4, [x4]
               	strb	w4, [x3]
               	b	<addr>
               	sub	x2, x2, #0x1
               	sxtw	x0, w2
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
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x28
               	add	x2, x2, x1
               	mov	x17, #0xff              // =255
               	and	x3, x1, x17
               	strb	w3, [x2]
               	sub	x2, x29, #0x50
               	add	x2, x2, x1
               	mov	x3, #0x0                // =0
               	strb	w3, [x2]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x27
               	b.lt	<addr>
               	sub	x0, x29, #0x50
               	sub	x1, x29, #0x28
               	mov	x2, #0x27               // =39
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x50
               	add	x2, x2, x1
               	ldrb	w2, [x2]
               	sub	x3, x29, #0x28
               	add	x3, x3, x1
               	ldrb	w3, [x3]
               	cmp	x2, x3
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x27
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
