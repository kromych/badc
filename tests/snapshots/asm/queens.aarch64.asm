
queens.aarch64:	file format elf64-littleaarch64

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

<solve>:
               	stp	x20, x21, [sp, #-0x30]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, x0
               	mov	x22, x1
               	sxtw	x22, w22
               	cmp	w22, #0x8
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x21, #0x0               // =0
               	mov	x23, x21
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x2, w0
               	sub	x3, x22, x2
               	ldrsw	x1, [x20, x2, lsl #2]
               	sub	x1, x21, x1
               	cmp	w1, #0x0
               	b.ge	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x1, x1, x17
               	sxtw	x1, w1
               	ldrsw	x2, [x20, x2, lsl #2]
               	cmp	w2, w21
               	b.eq	<addr>
               	cmp	w3, w1
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	cmp	w0, w22
               	b.lt	<addr>
               	str	w21, [x20, x22, lsl #2]
               	add	x1, x22, #0x1
               	mov	x0, x20
               	bl	<addr>
               	add	x0, x23, x0
               	sxtw	x23, w0
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	add	x0, x21, #0x1
               	sxtw	x21, w0
               	cmp	w21, #0x8
               	b.lt	<addr>
               	sxtw	x0, w23
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x0, x29, #0x20
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	cmp	w0, #0x5c
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
