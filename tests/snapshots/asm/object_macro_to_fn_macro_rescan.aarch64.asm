
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
               	mov	x15, x0
               	mov	x14, x1
               	sxtw	x13, w2
               	adrp	x0, <page>
               	add	x0, x0, #0xe0
               	mov	x1, x15
               	mov	x3, x13
               	mov	x2, x14
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x11, x0
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	mov	x20, #0x7               // =7
               	cmp	x20, #0x7
               	b.ne	<addr>
               	mov	x13, #0x0               // =0
               	stur	x13, [x29, #-0x28]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x108
               	adrp	x1, <page>
               	add	x1, x1, #0x10f
               	mov	x2, #0x13               // =19
               	bl	<addr>
               	mov	x11, x0
               	stur	x11, [x29, #-0x28]
               	b	<addr>
               	add	x20, x20, #0x1
               	sxtw	x20, w20
               	cmp	x20, #0x8
               	b.ne	<addr>
               	mov	x11, #0x0               // =0
               	stur	x11, [x29, #-0x30]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x15e
               	adrp	x1, <page>
               	add	x1, x1, #0x169
               	mov	x2, #0x14               // =20
               	bl	<addr>
               	mov	x20, x0
               	stur	x20, [x29, #-0x30]
               	b	<addr>
               	mov	x20, #0x0               // =0
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
