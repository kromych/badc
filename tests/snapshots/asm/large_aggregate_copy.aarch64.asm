
large_aggregate_copy.aarch64:	file format elf64-littleaarch64

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

<check>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	sub	sp, sp, #0x330
               	mov	x0, #0x0                // =0
               	mov	x2, #0x2328             // =9000
               	b	<addr>
               	sub	x3, x29, #0x2, lsl #12  // =0x2000
               	sub	x3, x3, #0x330
               	sxtw	x1, w0
               	add	x3, x3, x1
               	and	x4, x1, #0x7f
               	strb	w4, [x3]
               	add	x0, x1, #0x1
               	cmp	w0, w2
               	b.lt	<addr>
               	sub	x0, x29, #0x2, lsl #12  // =0x2000
               	sub	x0, x0, #0x330
               	mov	x1, #0x4d2              // =1234
               	str	w1, [x0, #0x2328]
               	ldrb	w1, [x0]
               	mov	x17, #0x2000            // =8192
               	add	x2, x0, x17
               	ldrb	w2, [x2]
               	ldr	w3, [x0, #0x2328]
               	mov	x0, #0x0                // =0
               	mov	x4, x0
               	mov	x4, x0
               	mov	x4, x0
               	mov	x4, x0
               	mov	x4, x0
               	cbnz	x1, <addr>
               	cmp	w2, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x2, lsl #12   // =0x2000
               	add	sp, sp, #0x330
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	w3, #0x4d2
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x2, lsl #12   // =0x2000
               	add	sp, sp, #0x330
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	sp, sp, #0x2, lsl #12   // =0x2000
               	add	sp, sp, #0x330
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret
