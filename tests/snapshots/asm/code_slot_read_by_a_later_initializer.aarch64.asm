
code_slot_read_by_a_later_initializer.aarch64:	file format elf64-littleaarch64

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

<fe>:
               	mov	x0, #0x5                // =5
               	ret

<fb>:
               	mov	x0, #0x2                // =2
               	ret

<fc>:
               	mov	x0, #0x3                // =3
               	ret

<fd>:
               	mov	x0, #0x4                // =4
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	cmp	x0, x1
               	b.ne	<addr>
               	blr	x0
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	cmp	x0, x1
               	b.ne	<addr>
               	blr	x0
               	cmp	x0, #0x2
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x20]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x1, x0
               	cmp	x1, #0x8
               	b.ne	<addr>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	sub	x0, x1, x0
               	cmp	x0, #0x8
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x28]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x1, x0
               	cmp	x1, #0xc
               	b.ne	<addr>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	cmp	x1, x0
               	b.ne	<addr>
               	blr	x1
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x38]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x1, x0
               	cmp	x1, #0x2
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1, #0x8]
               	sub	x0, x1, x0
               	cmp	x0, #0x2
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x40]
               	cmp	w0, #0x1
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x60]
               	cbnz	w0, <addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
