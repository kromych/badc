
post_inline_import_survives_repack.aarch64:	file format elf64-littleaarch64

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

<main>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	mov	x9, x1
               	blr	x9
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	mov	x9, x1
               	blr	x9
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	mov	x9, x1
               	blr	x9
               	mov	x1, x0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, x20
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
