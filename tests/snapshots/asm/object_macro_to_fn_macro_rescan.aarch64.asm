
object_macro_to_fn_macro_rescan.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xd0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x19, [sp]
               	sxtw	x2, w2
               	adrp	x3, <page>
               	add	x3, x3, #0xe0
               	mov	x16, x3
               	mov	x3, x2
               	mov	x2, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	str	x20, [sp]
               	mov	x20, #0x7               // =7
               	cmp	x20, #0x7
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x108
               	adrp	x1, <page>
               	add	x1, x1, #0x10f
               	mov	x2, #0x13               // =19
               	bl	<addr>
               	mov	x1, x0
               	b	<addr>
               	add	x0, x20, #0x1
               	sxtw	x0, w0
               	cmp	x0, #0x8
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x15e
               	adrp	x1, <page>
               	add	x1, x1, #0x169
               	mov	x2, #0x14               // =20
               	bl	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
