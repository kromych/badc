
queens.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x20, x21, [sp, #-0x30]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, x0
               	mov	x23, x1
               	sxtw	x23, w23
               	cmp	x23, #0x8
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x21, #0x0               // =0
               	mov	x22, x21
               	b	<addr>
               	sxtw	x0, w21
               	sxtw	x2, w23
               	sxtw	x3, w0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x1, w0
               	sub	x4, x2, x1
               	sxtw	x5, w4
               	ldrsw	x1, [x20, x1, lsl #2]
               	sub	x1, x3, x1
               	sxtw	x1, w1
               	cmp	x1, #0x0
               	b.ge	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x1, x1, x17
               	sxtw	x1, w1
               	sxtw	x4, w0
               	ldrsw	x4, [x20, x4, lsl #2]
               	cmp	x4, x3
               	b.eq	<addr>
               	sxtw	x1, w1
               	cmp	x5, x1
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	sxtw	x1, w0
               	cmp	x1, x2
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	b	<addr>
               	str	w21, [x20, x23, lsl #2]
               	add	x1, x23, #0x1
               	mov	x0, x20
               	bl	<addr>
               	add	x0, x22, x0
               	sxtw	x22, w0
               	b	<addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	add	x0, x21, #0x1
               	sxtw	x21, w0
               	sxtw	x0, w21
               	cmp	x0, #0x8
               	b.lt	<addr>
               	sxtw	x0, w22
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
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
