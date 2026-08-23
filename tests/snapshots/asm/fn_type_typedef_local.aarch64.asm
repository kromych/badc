
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
               	mov	x2, #0x0                // =0
               	str	x2, [x0]
               	str	x2, [x0, #0x8]
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
               	stp	x20, x21, [sp, #-0x70]!
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	stp	x29, x30, [sp, #0x60]
               	add	x29, sp, #0x60
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x21, #0x0               // =0
               	mov	x1, x21
               	stur	x0, [x29, #-0x28]
               	mov	x22, #0x4               // =4
               	mov	x0, x22
               	bl	<addr>
               	sub	x16, x29, #0x20
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x20, x29, #0x20
               	ldr	x0, [x20, #0x8]
               	cmp	x0, #0x8
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	sub	x0, x29, #0x28
               	ldr	x0, [x0]
               	mov	x1, #0x5                // =5
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	sub	x16, x29, #0x20
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	ldr	x0, [x20]
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, x22
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, x21
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
