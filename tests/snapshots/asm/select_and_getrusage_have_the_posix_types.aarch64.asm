
select_and_getrusage_have_the_posix_types.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x1c0
               	sub	x0, x29, #0x1b0
               	stp	xzr, xzr, [x0]
               	sub	x0, x29, #0x1a0
               	stp	xzr, xzr, [x0]
               	sub	x0, x29, #0x1b8
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldrsw	x0, [sp, #0xc]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x1                // =1
               	bl	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x110
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	strb	w1, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x80
               	b.lt	<addr>
               	sub	x1, x29, #0x110
               	ldrsw	x0, [sp, #0x8]
               	add	x2, x0, x0, lsr #61
               	asr	x2, x2, #3
               	add	x0, x0, x0, lsr #61
               	asr	x0, x0, #3
               	ldrb	w0, [x1, x0]
               	mov	x3, #0x1                // =1
               	ldrsw	x4, [sp, #0x8]
               	and	x4, x4, #0x7
               	lsl	x3, x3, x4
               	orr	x0, x0, x3
               	strb	w0, [x1, x2]
               	mov	x2, #0x0                // =0
               	ldrsw	x0, [sp, #0x8]
               	add	x0, x0, #0x1
               	sub	x4, x29, #0x1b0
               	adrp	x5, <page>
               	ldr	x5, [x5, <lo12>]
               	mov	x3, x2
               	blr	x5
               	cmp	w0, #0x1
               	b.ne	<addr>
               	sub	x1, x29, #0x110
               	ldrsw	x0, [sp, #0x8]
               	add	x2, x0, x0, lsr #61
               	asr	x2, x2, #3
               	ldrb	w1, [x1, x2]
               	mov	x2, #0x1                // =1
               	and	x0, x0, #0x7
               	lsl	x0, x2, x0
               	and	x0, x1, x0
               	cbnz	w0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x190
               	bl	<addr>
               	sub	x2, x29, #0x110
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	strb	w1, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x80
               	b.lt	<addr>
               	sub	x1, x29, #0x110
               	ldrsw	x0, [sp, #0x8]
               	add	x2, x0, x0, lsr #61
               	asr	x2, x2, #3
               	add	x0, x0, x0, lsr #61
               	asr	x0, x0, #3
               	ldrb	w0, [x1, x0]
               	mov	x3, #0x1                // =1
               	ldrsw	x4, [sp, #0x8]
               	and	x4, x4, #0x7
               	lsl	x3, x3, x4
               	orr	x0, x0, x3
               	strb	w0, [x1, x2]
               	mov	x2, #0x0                // =0
               	ldrsw	x0, [sp, #0x8]
               	add	x0, x0, #0x1
               	sub	x4, x29, #0x1a0
               	sub	x5, x29, #0x190
               	adrp	x6, <page>
               	ldr	x6, [x6, <lo12>]
               	mov	x3, x2
               	blr	x6
               	cmp	w0, #0x1
               	b.ne	<addr>
               	sub	x1, x29, #0x110
               	ldrsw	x0, [sp, #0x8]
               	add	x2, x0, x0, lsr #61
               	asr	x2, x2, #3
               	ldrb	w1, [x1, x2]
               	mov	x2, #0x1                // =1
               	and	x0, x0, #0x7
               	lsl	x0, x2, x0
               	and	x0, x1, x0
               	cbnz	w0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x90
               	adrp	x2, <page>
               	ldr	x2, [x2, <lo12>]
               	blr	x2
               	cbnz	w0, <addr>
               	ldur	x0, [x29, #-0x70]
               	cmp	x0, #0x0
               	b.le	<addr>
               	ldur	x0, [x29, #-0x88]
               	cmp	x0, #0x0
               	b.ge	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [sp, #0x8]
               	bl	<addr>
               	ldrsw	x0, [sp, #0xc]
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	b	<addr>
