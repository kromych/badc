
queens.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x3, x0
               	mov	x5, x2
               	mov	x4, x1
               	sxtw	x4, w4
               	sxtw	x5, w5
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x4, x1
               	sxtw	x6, w2
               	ldrsw	x2, [x3, x1, lsl #2]
               	sub	x2, x5, x2
               	sxtw	x2, w2
               	cmp	x2, #0x0
               	b.ge	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x2, x2, x17
               	sxtw	x2, w2
               	ldrsw	x1, [x3, x1, lsl #2]
               	cmp	x1, x5
               	b.eq	<addr>
               	sxtw	x1, w2
               	cmp	x6, x1
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	sxtw	x1, w0
               	cmp	x1, x4
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x1                // =1
               	ret
               	b	<addr>

<solve>:
               	stp	x20, x21, [sp, #-0x30]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x23, x0
               	mov	x22, x1
               	sxtw	x22, w22
               	cmp	x22, #0x8
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x20, #0x0               // =0
               	mov	x21, x20
               	b	<addr>
               	mov	x0, x23
               	mov	x2, x20
               	mov	x1, x22
               	bl	<addr>
               	cbz	x0, <addr>
               	b	<addr>
               	str	w20, [x23, x22, lsl #2]
               	add	x1, x22, #0x1
               	mov	x0, x23
               	bl	<addr>
               	add	x0, x21, x0
               	sxtw	x21, w0
               	add	x0, x20, #0x1
               	sxtw	x20, w0
               	sxtw	x0, w20
               	cmp	x0, #0x8
               	b.lt	<addr>
               	sxtw	x0, w21
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret

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
