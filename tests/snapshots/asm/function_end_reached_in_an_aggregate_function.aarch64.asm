
function_end_reached_in_an_aggregate_function.aarch64:	file format elf64-littleaarch64

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

<memory>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	stur	x8, [x29, #-0x20]
               	cbz	w0, <addr>
               	sub	x0, x29, #0x18
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x0, #0x10]
               	mov	x16, x0
               	ldur	x17, [x29, #-0x20]
               	ldp	x0, x1, [x16]
               	stp	x0, x1, [x17]
               	ldr	x0, [x16, #0x10]
               	str	x0, [x17, #0x10]
               	mov	x0, x17
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<integer>:
               	cbz	w0, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	ret

<floating>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	cbz	w0, <addr>
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldur	d0, [x29, #-0x10]
               	ldur	d1, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x20]
               	sub	x8, x29, #0x18
               	bl	<addr>
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x20]
               	bl	<addr>
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x20]
               	bl	<addr>
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x20]
               	cmp	w0, #0x0
               	cset	x0, eq
               	sub	x8, x29, #0x18
               	bl	<addr>
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, #0x3
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x20]
               	cmp	w0, #0x0
               	cset	x0, eq
               	bl	<addr>
               	cmp	x0, #0x4
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x20]
               	cmp	w0, #0x0
               	cset	x0, eq
               	bl	<addr>
               	fmov	d0, #6.00000000
               	fcmp	d1, d0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
