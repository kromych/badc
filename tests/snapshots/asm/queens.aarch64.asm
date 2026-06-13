
queens.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sxtw	x1, w1
               	sxtw	x2, w2
               	mov	x4, #0x0                // =0
               	sxtw	x3, w4
               	cmp	x3, x1
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x3, w4
               	add	x3, x3, #0x1
               	sxtw	x4, w3
               	b	<addr>
               	sxtw	x3, w4
               	sub	x5, x1, x3
               	sxtw	x5, w5
               	ldrsw	x3, [x0, x3, lsl #2]
               	sub	x3, x2, x3
               	sxtw	x6, w3
               	sxtw	x3, w6
               	cmp	x3, #0x0
               	b.ge	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	sxtw	x3, w6
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x6, x3, x17
               	sxtw	x3, w4
               	ldrsw	x3, [x0, x3, lsl #2]
               	cmp	x3, x2
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	sxtw	x3, w5
               	sxtw	x5, w6
               	cmp	x3, x5
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	b	<addr>
               	b	<addr>

<solve>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	mov	x20, x0
               	mov	x21, x1
               	sxtw	x21, w21
               	cmp	x21, #0x8
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x22, #0x0               // =0
               	mov	x23, x22
               	sxtw	x0, w22
               	cmp	x0, #0x8
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w22
               	add	x0, x0, #0x1
               	sxtw	x22, w0
               	b	<addr>
               	sxtw	x2, w22
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	cbz	x0, <addr>
               	b	<addr>
               	sxtw	x0, w23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	sxtw	x0, w22
               	str	w0, [x20, x21, lsl #2]
               	sxtw	x23, w23
               	add	x0, x21, #0x1
               	sxtw	x1, w0
               	mov	x0, x20
               	bl	<addr>
               	add	x0, x23, x0
               	sxtw	x23, w0
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	x0, x29, #0x20
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x5c
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
