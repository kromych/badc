
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
               	sxtw	x4, w23
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x4, x1
               	sxtw	x5, w2
               	ldrsw	x2, [x20, x1, lsl #2]
               	sub	x2, x3, x2
               	sxtw	x2, w2
               	cmp	x2, #0x0
               	b.ge	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x2, x2, x17
               	sxtw	x2, w2
               	ldrsw	x1, [x20, x1, lsl #2]
               	cmp	x1, x3
               	b.eq	<addr>
               	sxtw	x1, w2
               	cmp	x5, x1
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	sxtw	x1, w0
               	cmp	x1, x4
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
               	sxtw	x3, w21
               	cmp	x3, #0x8
               	b.lt	<addr>
               	sxtw	x0, w22
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret

<main>:
               	str	x20, [sp, #-0x40]!
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	sub	x0, x29, #0x20
               	mov	x20, #0x0               // =0
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x5c
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
