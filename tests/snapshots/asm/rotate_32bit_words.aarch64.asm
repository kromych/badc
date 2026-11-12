
rotate_32bit_words.aarch64:	file format elf64-littleaarch64

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

<ror2>:
               	ror	w0, w0, #0x2
               	ret

<ror7>:
               	ror	w0, w0, #0x7
               	ret

<rol13>:
               	ror	w0, w0, #0x13
               	ret

<rotr_var>:
               	mov	w1, w1
               	ror	w0, w0, w1
               	ret

<rotl_var>:
               	neg	x1, x1
               	ror	w0, w0, w1
               	ret

<widened>:
               	ror	w0, w0, #0x2
               	add	x0, x0, #0x1
               	ret

<not_rot>:
               	mov	w0, w0
               	lsr	x1, x0, #3
               	orr	x0, x1, x0, lsl #30
               	ret

<arith>:
               	sxtw	x0, w0
               	asr	x1, x0, #2
               	orr	x0, x1, x0, lsl #30
               	ret

<wide>:
               	lsr	x1, x0, #7
               	orr	x0, x1, x0, lsl #25
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x40]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x22, #0x0               // =0
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldr	w20, [x0, x22, lsl #2]
               	mov	x0, x20
               	bl	<addr>
               	mov	x1, #0x0                // =0
               	mov	x2, x1
               	lsr	x3, x20, x1
               	tbz	w3, #0x0, <addr>
               	mov	x3, #0x1                // =1
               	sub	x4, x1, #0x2
               	and	x4, x4, #0x1f
               	lsl	x3, x3, x4
               	orr	x2, x2, x3
               	add	x1, x1, #0x1
               	cmp	w1, #0x20
               	b.lt	<addr>
               	cmp	w0, w2
               	b.ne	<addr>
               	mov	x0, x20
               	bl	<addr>
               	mov	x1, #0x0                // =0
               	mov	x2, x1
               	lsr	x3, x20, x1
               	tbz	w3, #0x0, <addr>
               	mov	x3, #0x1                // =1
               	sub	x4, x1, #0x7
               	and	x4, x4, #0x1f
               	lsl	x3, x3, x4
               	orr	x2, x2, x3
               	add	x1, x1, #0x1
               	cmp	w1, #0x20
               	b.lt	<addr>
               	cmp	w0, w2
               	b.ne	<addr>
               	mov	x0, x20
               	bl	<addr>
               	mov	x1, #0x0                // =0
               	mov	x2, x1
               	lsr	x3, x20, x1
               	tbz	w3, #0x0, <addr>
               	mov	x3, #0x1                // =1
               	sub	x4, x1, #0x13
               	and	x4, x4, #0x1f
               	lsl	x3, x3, x4
               	orr	x2, x2, x3
               	add	x1, x1, #0x1
               	cmp	w1, #0x20
               	b.lt	<addr>
               	cmp	w0, w2
               	b.ne	<addr>
               	mov	x21, #0x1               // =1
               	stur	w21, [x29, #-0x10]
               	b	<addr>
               	ldur	w1, [x29, #-0x10]
               	mov	x0, x20
               	bl	<addr>
               	ldur	w3, [x29, #-0x10]
               	mov	x1, #0x0                // =0
               	mov	x2, x1
               	lsr	x4, x20, x1
               	tbz	w4, #0x0, <addr>
               	sub	x4, x1, x3
               	and	x4, x4, #0x1f
               	lsl	x4, x21, x4
               	orr	x2, x2, x4
               	add	x1, x1, #0x1
               	cmp	w1, #0x20
               	b.lt	<addr>
               	cmp	w0, w2
               	b.ne	<addr>
               	ldur	w1, [x29, #-0x10]
               	mov	x0, x20
               	bl	<addr>
               	mov	x1, #0x20               // =32
               	ldur	w2, [x29, #-0x10]
               	sub	x3, x1, x2
               	mov	x1, #0x0                // =0
               	mov	x2, x1
               	lsr	x4, x20, x1
               	tbz	w4, #0x0, <addr>
               	sub	x4, x1, x3
               	and	x4, x4, #0x1f
               	lsl	x4, x21, x4
               	orr	x2, x2, x4
               	add	x1, x1, #0x1
               	cmp	w1, #0x20
               	b.lt	<addr>
               	cmp	w0, w2
               	b.ne	<addr>
               	ldur	w0, [x29, #-0x10]
               	add	x0, x0, #0x1
               	stur	w0, [x29, #-0x10]
               	ldur	w0, [x29, #-0x10]
               	cmp	w0, #0x20
               	b.lo	<addr>
               	mov	x0, x20
               	bl	<addr>
               	mov	x1, #0x0                // =0
               	mov	x2, x1
               	lsr	x3, x20, x1
               	tbz	w3, #0x0, <addr>
               	mov	x3, #0x1                // =1
               	sub	x4, x1, #0x2
               	and	x4, x4, #0x1f
               	lsl	x3, x3, x4
               	orr	x2, x2, x3
               	add	x1, x1, #0x1
               	cmp	w1, #0x20
               	b.lt	<addr>
               	mov	w1, w2
               	add	x1, x1, #0x1
               	cmp	x0, x1
               	b.ne	<addr>
               	mov	x0, x20
               	bl	<addr>
               	lsl	x21, x20, #30
               	orr	x1, x21, x20, lsr #3
               	cmp	w0, w1
               	b.ne	<addr>
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x1, w20
               	orr	x1, x21, x1, asr #2
               	cmp	w0, w1
               	b.ne	<addr>
               	add	x22, x22, #0x1
               	cmp	w22, #0x7
               	b.lo	<addr>
               	mov	x0, #0xcdef             // =52719
               	movk	x0, #0x89ab, lsl #16
               	movk	x0, #0x4567, lsl #32
               	movk	x0, #0x123, lsl #48
               	stur	x0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	bl	<addr>
               	ldur	x1, [x29, #-0x8]
               	lsr	x1, x1, #7
               	ldur	x2, [x29, #-0x8]
               	orr	x1, x1, x2, lsl #25
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	ldur	x0, [x29, #-0x8]
               	bl	<addr>
               	ldur	x1, [x29, #-0x8]
               	mov	w3, w1
               	mov	x1, #0x0                // =0
               	mov	x2, x1
               	lsr	x4, x3, x1
               	tbz	w4, #0x0, <addr>
               	mov	x4, #0x1                // =1
               	sub	x5, x1, #0x7
               	and	x5, x5, #0x1f
               	lsl	x4, x4, x5
               	orr	x2, x2, x4
               	add	x1, x1, #0x1
               	cmp	w1, #0x20
               	b.lt	<addr>
               	mov	w1, w2
               	cmp	x0, x1
               	b.ne	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
