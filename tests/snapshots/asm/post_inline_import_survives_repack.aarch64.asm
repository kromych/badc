
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
               	stp	x20, x21, [sp, #-0x40]!
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	mov	x9, x0
               	mov	x0, x20
               	blr	x9
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x21, #0x0               // =0
               	mov	x0, x21
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	mov	x9, x0
               	mov	x0, x20
               	blr	x9
               	mov	x1, x0
               	mov	x0, x22
               	mov	x2, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, x21
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
