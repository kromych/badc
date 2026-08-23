
reg_alloc_callee_bank_call_block_before_loop.aarch64:	file format elf64-littleaarch64

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

<qs>:
               	stp	x20, x21, [sp, #-0x30]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x21, x0
               	mov	x22, x2
               	mov	x5, x1
               	sxtw	x5, w5
               	sxtw	x22, w22
               	b	<addr>
               	add	x0, x5, x22
               	sxtw	x0, w0
               	asr	x1, x0, #63
               	lsr	x1, x1, #63
               	add	x0, x0, x1
               	asr	x0, x0, #1
               	ldrsw	x0, [x21, x0, lsl #2]
               	mov	x2, x22
               	mov	x20, x5
               	b	<addr>
               	b	<addr>
               	add	x20, x1, #0x1
               	sxtw	x1, w20
               	ldrsw	x3, [x21, x1, lsl #2]
               	cmp	w3, w0
               	b.lt	<addr>
               	b	<addr>
               	sub	x2, x1, #0x1
               	sxtw	x1, w2
               	ldrsw	x3, [x21, x1, lsl #2]
               	cmp	w3, w0
               	b.gt	<addr>
               	cmp	w20, w2
               	b.gt	<addr>
               	sxtw	x3, w20
               	ldrsw	x4, [x21, x3, lsl #2]
               	sxtw	x1, w2
               	ldrsw	x6, [x21, x1, lsl #2]
               	str	w6, [x21, x3, lsl #2]
               	str	w4, [x21, x1, lsl #2]
               	add	x20, x20, #0x1
               	sub	x2, x1, #0x1
               	b	<addr>
               	cmp	w20, w2
               	b.le	<addr>
               	mov	x0, x21
               	mov	x1, x5
               	bl	<addr>
               	sxtw	x5, w20
               	cmp	x5, x22
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x110
               	str	x20, [sp]
               	mov	x1, #0x3039             // =12345
               	mov	x0, #0x0                // =0
               	mov	x5, #0x3039             // =12345
               	mov	x6, #0x4e6d             // =20077
               	movk	x6, #0x41c6, lsl #16
               	mov	x7, #0xffff             // =65535
               	movk	x7, #0x7fff, lsl #16
               	b	<addr>
               	mov	w1, w1
               	mul	x1, x1, x6
               	mov	w1, w1
               	add	x1, x1, x5
               	mov	w1, w1
               	sub	x4, x29, #0x100
               	sxtw	x2, w0
               	mov	w3, w1
               	and	x3, x3, x7
               	str	w3, [x4, x2, lsl #2]
               	add	x0, x2, #0x1
               	cmp	w0, #0x40
               	b.lt	<addr>
               	sub	x20, x29, #0x100
               	mov	x1, #0x0                // =0
               	mov	x2, #0x3f               // =63
               	mov	x0, x20
               	bl	<addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	sxtw	x1, w0
               	ldrsw	x3, [x20, x1, lsl #2]
               	sub	x2, x0, #0x1
               	sxtw	x2, w2
               	ldrsw	x2, [x20, x2, lsl #2]
               	cmp	w3, w2
               	b.lt	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x40
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
