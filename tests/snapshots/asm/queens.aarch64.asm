
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
               	cmp	w1, #0x8
               	b.eq	<addr>
               	stp	x20, x21, [sp, #-0x40]!
               	stp	x22, x23, [sp, #0x10]
               	str	x24, [sp, #0x20]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x21, x0
               	mov	x22, x1
               	mov	x20, #0x0               // =0
               	add	x24, x22, #0x1
               	mov	x23, x20
               	mov	x2, #0x0                // =0
               	cmp	w2, w22
               	b.ge	<addr>
               	sub	x0, x22, x2
               	ldrsw	x1, [x21, x2, lsl #2]
               	sub	x3, x20, x1
               	neg	x1, x3
               	cmp	w3, #0x0
               	csel	x1, x1, x3, lt
               	ldrsw	x3, [x21, x2, lsl #2]
               	cmp	w3, w20
               	b.eq	<addr>
               	cmp	w0, w1
               	b.eq	<addr>
               	add	x2, x2, #0x1
               	cmp	w2, w22
               	b.lt	<addr>
               	str	w20, [x21, w22, sxtw #2]
               	mov	x0, x21
               	mov	x1, x24
               	bl	<addr>
               	add	x23, x23, x0
               	add	x20, x20, #0x1
               	cmp	w20, #0x8
               	b.lt	<addr>
               	mov	x0, x23
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x1                // =1
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
