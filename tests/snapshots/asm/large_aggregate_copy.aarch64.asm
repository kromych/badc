
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
               	mov	x1, #0x2328             // =9000
               	mov	x2, sp
               	and	x3, x0, #0x7f
               	strb	w3, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, w1
               	b.lt	<addr>
               	mov	x0, #0x4d2              // =1234
               	stur	w0, [x29, #-0x8]
               	ldrb	w0, [sp]
               	sub	x16, x29, #0x330
               	ldrb	w1, [x16]
               	ldur	w2, [x29, #-0x8]
               	cbnz	w0, <addr>
               	cbz	w1, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x2, lsl #12   // =0x2000
               	add	sp, sp, #0x330
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	w2, #0x4d2
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x2, lsl #12   // =0x2000
               	add	sp, sp, #0x330
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x2, lsl #12   // =0x2000
               	add	sp, sp, #0x330
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
