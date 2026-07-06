
inline_into_computed_goto.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x16, x29, #0x8
               	str	x0, [x16]
               	sub	x0, x29, #0x8
               	ldr	x0, [x0]
               	mov	x17, #0xfffc            // =65532
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x0, x0, x17
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<dbl>:
               	add	x0, x0, x0
               	ret

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
               	sub	x0, x29, #0x18
               	adr	x2, <addr>
               	str	x2, [x0, #0x8]
               	sub	x0, x29, #0x18
               	adr	x2, <addr>
               	str	x2, [x0, #0x10]
               	stur	x1, [x29, #-0x20]
               	stur	w1, [x29, #-0x28]
               	sub	x0, x29, #0x18
               	ldur	x2, [x29, #0x10]
               	sxtw	x1, w1
               	add	x3, x1, #0x1
               	stur	w3, [x29, #-0x28]
               	ldrsw	x1, [x2, x1, lsl #2]
               	ldr	x0, [x0, x1, lsl #3]
               	br	x0
               	ldur	x0, [x29, #-0x20]
               	ldur	x1, [x29, #0x20]
               	ldur	x2, [x29, #0x10]
               	ldursw	x3, [x29, #-0x28]
               	add	x4, x3, #0x1
               	stur	w4, [x29, #-0x28]
               	ldrsw	x3, [x2, x3, lsl #2]
               	ldr	x1, [x1, x3, lsl #3]
               	mov	x17, #0xfffc            // =65532
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	add	x0, x0, x1
               	stur	x0, [x29, #-0x20]
               	sub	x0, x29, #0x18
               	sxtw	x1, w4
               	add	x3, x1, #0x1
               	stur	w3, [x29, #-0x28]
               	ldrsw	x1, [x2, x1, lsl #2]
               	ldr	x0, [x0, x1, lsl #3]
               	br	x0
               	ldur	x0, [x29, #-0x20]
               	add	x0, x0, x0
               	stur	x0, [x29, #-0x20]
               	sub	x0, x29, #0x18
               	ldur	x1, [x29, #0x10]
               	ldursw	x2, [x29, #-0x28]
               	add	x3, x2, #0x1
               	stur	w3, [x29, #-0x28]
               	ldrsw	x1, [x1, x2, lsl #2]
               	ldr	x0, [x0, x1, lsl #3]
               	br	x0
               	ldur	x0, [x29, #-0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	sub	x0, x29, #0x18
               	mov	x1, #0x67               // =103
               	str	x1, [x0]
               	sub	x0, x29, #0x18
               	mov	x1, #0xc9               // =201
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x18
               	mov	x1, #0x12c              // =300
               	str	x1, [x0, #0x10]
               	sub	x0, x29, #0x38
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x1, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x38
               	sub	x1, x29, #0x18
               	bl	<addr>
               	cmp	x0, #0x384
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x1                // =1
               	mov	x0, x1
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
