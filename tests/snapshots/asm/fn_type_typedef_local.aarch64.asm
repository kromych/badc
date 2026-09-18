
fn_type_typedef_local.aarch64:	file format elf64-littleaarch64

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

<make>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x1, x0
               	sxtw	x1, w1
               	sub	x0, x29, #0x10
               	stp	xzr, xzr, [x0]
               	str	x1, [x0]
               	lsl	x1, x1, #1
               	sxtw	x1, w1
               	str	x1, [x0, #0x8]
               	mov	x16, x0
               	ldr	x1, [x16, #0x8]
               	ldr	x0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	stur	x0, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	ldr	x0, [x0]
               	mov	x1, #0x5                // =5
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	stur	x0, [x29, #-0x10]
               	stur	x1, [x29, #-0x8]
               	sub	x0, x29, #0x10
               	ldr	x0, [x0]
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
