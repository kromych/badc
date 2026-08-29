
inline_into_computed_goto.aarch64:	file format elf64-littleaarch64

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

<interp>:
               	str	x1, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	stur	x0, [x29, #0x10]
               	stur	x1, [x29, #0x20]
               	sub	x0, x29, #0x18
               	mov	x1, #0x0                // =0
               	adr	x2, <addr>
               	str	x2, [x0]
               	adr	x2, <addr>
               	str	x2, [x0, #0x8]
               	adr	x2, <addr>
               	str	x2, [x0, #0x10]
               	stur	x1, [x29, #-0x28]
               	stur	w1, [x29, #-0x20]
               	ldur	x1, [x29, #0x10]
               	mov	x2, #0x1                // =1
               	stur	w2, [x29, #-0x20]
               	add	x1, x1, #0x0
               	ldrsw	x1, [x1]
               	ldr	x1, [x0, x1, lsl #3]
               	br	x1
               	ldur	x4, [x29, #-0x28]
               	ldur	x2, [x29, #0x20]
               	ldur	x3, [x29, #0x10]
               	ldursw	x1, [x29, #-0x20]
               	add	x5, x1, #0x1
               	stur	w5, [x29, #-0x20]
               	ldrsw	x1, [x3, x1, lsl #2]
               	b	<addr>
               	add	x1, x4, x1
               	stur	x1, [x29, #-0x28]
               	ldur	x2, [x29, #0x10]
               	ldursw	x1, [x29, #-0x20]
               	add	x3, x1, #0x1
               	stur	w3, [x29, #-0x20]
               	ldrsw	x1, [x2, x1, lsl #2]
               	ldr	x1, [x0, x1, lsl #3]
               	br	x1
               	ldur	x1, [x29, #-0x28]
               	add	x1, x1, x1
               	stur	x1, [x29, #-0x28]
               	ldur	x2, [x29, #0x10]
               	ldursw	x1, [x29, #-0x20]
               	add	x3, x1, #0x1
               	stur	w3, [x29, #-0x20]
               	ldrsw	x1, [x2, x1, lsl #2]
               	ldr	x1, [x0, x1, lsl #3]
               	br	x1
               	ldur	x0, [x29, #-0x28]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	ldr	x1, [x2, x1, lsl #3]
               	mov	x17, #0xfffc            // =65532
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	x1, x29, #0x38
               	mov	x0, #0x67               // =103
               	str	x0, [x1]
               	mov	x0, #0xc9               // =201
               	str	x0, [x1, #0x8]
               	mov	x0, #0x12c              // =300
               	str	x0, [x1, #0x10]
               	sub	x0, x29, #0x20
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x0]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x2, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x2, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [sp], #0x10
               	mov	x2, x0
               	bl	<addr>
               	cmp	x0, #0x384
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
