
struct_return_reg_computed_goto.aarch64:	file format elf64-littleaarch64

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

<simple>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x18]
               	adr	x1, <addr>
               	br	x1
               	mov	x1, #0x7                // =7
               	stur	w1, [x29, #-0x18]
               	stur	x0, [x29, #-0x18]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<ternary>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	stur	x0, [x29, #-0x30]
               	mov	x1, x0
               	stur	w1, [x29, #-0x30]
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x18]
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	adr	x1, <addr>
               	stur	x1, [x29, #-0x18]
               	b	<addr>
               	adr	x1, <addr>
               	stur	x1, [x29, #-0x18]
               	ldur	x1, [x29, #-0x18]
               	br	x1
               	mov	x0, #0x1                // =1
               	stur	w0, [x29, #-0x18]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x2                // =2
               	stur	w1, [x29, #-0x18]
               	stur	x0, [x29, #-0x18]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
