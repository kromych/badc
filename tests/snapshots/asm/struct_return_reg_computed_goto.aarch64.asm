
struct_return_reg_computed_goto.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<simple>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x18]
               	adr	x0, <addr>
               	br	x0
               	mov	x0, #0x7                // =7
               	stur	w0, [x29, #-0x18]
               	sxtw	x0, w0
               	cmp	x0, #0x7
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x18]
               	b	<addr>
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0x18]
               	ldur	x0, [x29, #-0x18]
               	sxtw	x0, w0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<ternary>:
               	str	x0, [sp, #-0x10]!
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	stur	w0, [x29, #0x10]
               	mov	x1, #0x0                // =0
               	stur	w1, [x29, #-0x18]
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	adr	x0, <addr>
               	stur	x0, [x29, #-0x18]
               	b	<addr>
               	adr	x0, <addr>
               	stur	x0, [x29, #-0x18]
               	ldur	x0, [x29, #-0x18]
               	br	x0
               	mov	x0, #0x1                // =1
               	stur	w0, [x29, #-0x18]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret
               	mov	x0, #0x2                // =2
               	stur	w0, [x29, #-0x18]
               	sxtw	x0, w0
               	cmp	x0, #0x2
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x18]
               	b	<addr>
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0x18]
               	ldur	x0, [x29, #-0x18]
               	sxtw	x0, w0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
