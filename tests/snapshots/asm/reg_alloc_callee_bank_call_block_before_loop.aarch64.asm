
reg_alloc_callee_bank_call_block_before_loop.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x20, x21, [sp, #-0x30]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, x0
               	mov	x21, x2
               	sxtw	x1, w1
               	sxtw	x21, w21
               	cmp	x1, x21
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	add	x0, x1, x21
               	sxtw	x0, w0
               	asr	x2, x0, #63
               	lsr	x2, x2, #63
               	add	x0, x0, x2
               	asr	x0, x0, #1
               	ldrsw	x0, [x20, x0, lsl #2]
               	mov	x2, x21
               	mov	x22, x1
               	sxtw	x3, w22
               	sxtw	x4, w2
               	cmp	x3, x4
               	b.gt	<addr>
               	b	<addr>
               	sxtw	x2, w2
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x1, w22
               	mov	x0, x20
               	mov	x2, x21
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	sxtw	x3, w22
               	ldrsw	x3, [x20, x3, lsl #2]
               	cmp	x3, x0
               	b.ge	<addr>
               	sxtw	x3, w22
               	add	x22, x3, #0x1
               	b	<addr>
               	sxtw	x3, w2
               	ldrsw	x3, [x20, x3, lsl #2]
               	cmp	x3, x0
               	b.le	<addr>
               	sxtw	x2, w2
               	sub	x2, x2, #0x1
               	b	<addr>
               	sxtw	x3, w22
               	sxtw	x4, w2
               	cmp	x3, x4
               	b.gt	<addr>
               	sxtw	x3, w22
               	ldrsw	x4, [x20, x3, lsl #2]
               	sxtw	x5, w2
               	ldrsw	x5, [x20, x5, lsl #2]
               	str	w5, [x20, x3, lsl #2]
               	sxtw	x3, w2
               	str	w4, [x20, x3, lsl #2]
               	add	x22, x22, #0x1
               	sxtw	x2, w2
               	sub	x2, x2, #0x1
               	b	<addr>
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x130
               	mov	x2, #0x3039             // =12345
               	mov	x1, #0x0                // =0
               	sxtw	x0, w1
               	cmp	x0, #0x40
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w1
               	add	x1, x0, #0x1
               	b	<addr>
               	mov	w0, w2
               	mov	x17, #0x4e6d            // =20077
               	movk	x17, #0x41c6, lsl #16
               	mul	x0, x0, x17
               	mov	w0, w0
               	mov	x17, #0x3039            // =12345
               	add	x0, x0, x17
               	mov	w2, w0
               	sub	x0, x29, #0x100
               	sxtw	x3, w1
               	mov	w4, w2
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x7fff, lsl #16
               	and	x4, x4, x17
               	str	w4, [x0, x3, lsl #2]
               	b	<addr>
               	sub	x0, x29, #0x100
               	mov	x1, #0x0                // =0
               	mov	x2, #0x3f               // =63
               	bl	<addr>
               	mov	x1, #0x1                // =1
               	sxtw	x0, w1
               	cmp	x0, #0x40
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w1
               	add	x1, x0, #0x1
               	b	<addr>
               	sub	x0, x29, #0x100
               	sxtw	x2, w1
               	ldrsw	x0, [x0, x2, lsl #2]
               	sub	x2, x29, #0x100
               	sub	x3, x1, #0x1
               	sxtw	x3, w3
               	ldrsw	x2, [x2, x3, lsl #2]
               	cmp	x0, x2
               	b.ge	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
