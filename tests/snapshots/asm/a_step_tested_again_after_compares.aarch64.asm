
a_step_tested_again_after_compares.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<report>:
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x20]
               	ret

<classify>:
               	cbz	x0, <addr>
               	stp	x20, x21, [sp, #-0x30]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, x0
               	mov	x21, #0x0               // =0
               	adds	x22, x20, #0x9
               	b.ne	<addr>
               	bl	<addr>
               	ldrb	w0, [x22]
               	and	x0, x0, #0x38
               	cmp	w0, #0x0
               	cset	x23, eq
               	cbnz	x22, <addr>
               	bl	<addr>
               	ldrb	w0, [x22]
               	and	x0, x0, #0x7
               	cmp	w0, #0x6
               	cset	x0, eq
               	eor	x0, x23, x0
               	add	x1, x21, #0x64
               	cmp	x0, #0x0
               	csel	x0, x1, x21, ne
               	add	x21, x0, #0x1
               	ldr	x20, [x20]
               	cbnz	x20, <addr>
               	mov	x0, x21
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	x4, x29, #0x40
               	stp	xzr, xzr, [x4]
               	stp	xzr, xzr, [x4, #0x10]
               	stp	xzr, xzr, [x4, #0x20]
               	stp	xzr, xzr, [x4, #0x30]
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	b	<addr>
               	str	x3, [x2]
               	add	x3, x0, x0, lsl #3
               	strb	w3, [x2, #0x9]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.ge	<addr>
               	add	x2, x4, x0, lsl #4
               	cmp	w0, #0x3
               	b.ge	<addr>
               	add	x3, x0, #0x1
               	add	x3, x4, x3, lsl #4
               	b	<addr>
               	mov	x3, x1
               	b	<addr>
               	sub	x0, x29, #0x40
               	bl	<addr>
               	cmp	w0, #0x68
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x20]
               	cbz	w0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
