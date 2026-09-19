
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
               	sxtw	x22, w1
               	cmp	w22, #0x8
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x21, #0x0               // =0
               	mov	x23, x21
               	mov	x0, #0x0                // =0
               	cmp	w0, w22
               	b.ge	<addr>
               	sub	x2, x22, x0
               	ldrsw	x1, [x20, x0, lsl #2]
               	sub	x1, x21, x1
               	cmp	w1, #0x0
               	b.ge	<addr>
               	mov	x17, #-0x1              // =-1
               	mul	x1, x1, x17
               	ldrsw	x3, [x20, x0, lsl #2]
               	cmp	w3, w21
               	b.eq	<addr>
               	cmp	w2, w1
               	b.eq	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, w22
               	b.lt	<addr>
               	str	w21, [x20, w22, sxtw #2]
               	add	x1, x22, #0x1
               	mov	x0, x20
               	bl	<addr>
               	add	x23, x23, x0
               	add	x21, x21, #0x1
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
