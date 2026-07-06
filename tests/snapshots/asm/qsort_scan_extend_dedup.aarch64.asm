
qsort_scan_extend_dedup.aarch64:	file format elf64-littleaarch64

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
               	mov	x21, x0
               	mov	x22, x2
               	mov	x5, x1
               	sxtw	x5, w5
               	sxtw	x22, w22
               	cmp	x5, x22
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
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
               	add	x20, x3, #0x1
               	sxtw	x3, w20
               	ldrsw	x1, [x21, x3, lsl #2]
               	cmp	x1, x0
               	b.lt	<addr>
               	b	<addr>
               	sub	x2, x1, #0x1
               	sxtw	x1, w2
               	ldrsw	x4, [x21, x1, lsl #2]
               	cmp	x4, x0
               	b.gt	<addr>
               	cmp	x3, x1
               	b.gt	<addr>
               	ldrsw	x4, [x21, x3, lsl #2]
               	ldrsw	x6, [x21, x1, lsl #2]
               	str	w6, [x21, x3, lsl #2]
               	str	w4, [x21, x1, lsl #2]
               	add	x20, x20, #0x1
               	sub	x2, x1, #0x1
               	b	<addr>
               	sxtw	x1, w20
               	sxtw	x3, w2
               	cmp	x1, x3
               	b.le	<addr>
               	mov	x0, x21
               	mov	x1, x5
               	bl	<addr>
               	mov	x0, x21
               	mov	x2, x22
               	mov	x1, x20
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x130
               	mov	x1, #0x3039             // =12345
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	w1, w1
               	mov	x17, #0x4e6d            // =20077
               	movk	x17, #0x41c6, lsl #16
               	mul	x1, x1, x17
               	mov	w1, w1
               	mov	x17, #0x3039            // =12345
               	add	x1, x1, x17
               	mov	w1, w1
               	sub	x4, x29, #0x100
               	mov	w3, w1
               	lsr	x3, x3, #16
               	mov	x17, #0x4000            // =16384
               	sub	x3, x3, x17
               	str	w3, [x4, x2, lsl #2]
               	add	x0, x2, #0x1
               	sxtw	x2, w0
               	cmp	x2, #0x40
               	b.lt	<addr>
               	sub	x0, x29, #0x100
               	mov	x1, #0x0                // =0
               	mov	x2, #0x3f               // =63
               	bl	<addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	sub	x2, x29, #0x100
               	ldrsw	x4, [x2, x1, lsl #2]
               	sub	x2, x29, #0x100
               	sub	x3, x0, #0x1
               	sxtw	x3, w3
               	ldrsw	x2, [x2, x3, lsl #2]
               	cmp	x4, x2
               	b.lt	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x40
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
