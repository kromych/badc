
qsort_scan_extend_dedup.aarch64:	file format elf64-littleaarch64

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
               	cmp	w1, w2
               	b.ge	<addr>
               	stp	x20, x21, [sp, #-0x30]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x21, x0
               	mov	x22, x2
               	add	x0, x1, x22
               	sxtw	x0, w0
               	lsr	x2, x0, #63
               	add	x0, x0, x2
               	asr	x0, x0, #1
               	ldrsw	x0, [x21, x0, lsl #2]
               	mov	x2, x22
               	mov	x20, x1
               	b	<addr>
               	add	x20, x20, #0x1
               	ldrsw	x3, [x21, w20, sxtw #2]
               	cmp	w3, w0
               	b.lt	<addr>
               	ldrsw	x3, [x21, w2, sxtw #2]
               	cmp	w3, w0
               	b.le	<addr>
               	sub	x2, x2, #0x1
               	ldrsw	x3, [x21, w2, sxtw #2]
               	cmp	w3, w0
               	b.gt	<addr>
               	cmp	w20, w2
               	b.gt	<addr>
               	ldrsw	x3, [x21, w20, sxtw #2]
               	ldrsw	x4, [x21, w2, sxtw #2]
               	str	w4, [x21, w20, sxtw #2]
               	str	w3, [x21, w2, sxtw #2]
               	add	x20, x20, #0x1
               	sub	x2, x2, #0x1
               	cmp	w20, w2
               	b.le	<addr>
               	mov	x0, x21
               	bl	<addr>
               	mov	x1, x20
               	cmp	w1, w22
               	b.lt	<addr>
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x110
               	str	x20, [sp]
               	mov	x1, #0x3039             // =12345
               	mov	x0, #0x0                // =0
               	mov	x2, #0x3039             // =12345
               	mov	x3, #0x4e6d             // =20077
               	movk	x3, #0x41c6, lsl #16
               	mul	x1, x1, x3
               	add	x1, x1, x2
               	sub	x4, x29, #0x100
               	mov	w5, w1
               	lsr	x5, x5, #16
               	sub	x5, x5, #0x4, lsl #12   // =0x4000
               	str	w5, [x4, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x40
               	b.lt	<addr>
               	sub	x20, x29, #0x100
               	mov	x1, #0x0                // =0
               	mov	x2, #0x3f               // =63
               	mov	x0, x20
               	bl	<addr>
               	mov	x0, #0x1                // =1
               	ldrsw	x1, [x20, x0, lsl #2]
               	sub	x2, x0, #0x1
               	ldrsw	x2, [x20, x2, lsl #2]
               	cmp	w1, w2
               	b.lt	<addr>
               	add	x0, x0, #0x1
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
