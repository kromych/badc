
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
               	mov	x0, sp
               	mov	x1, #0x4d2              // =1234
               	str	w1, [x0, #0x2328]
               	ldrb	w1, [x0]
               	add	x17, x0, #0x2, lsl #12  // =0x2000
               	ldrb	w2, [x17]
               	ldr	w0, [x0, #0x2328]
               	cbnz	w1, <addr>
               	cbz	w2, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x2, lsl #12   // =0x2000
               	add	sp, sp, #0x330
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	w0, #0x4d2
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
