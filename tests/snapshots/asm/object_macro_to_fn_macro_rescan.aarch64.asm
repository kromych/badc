
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
               	sub	sp, sp, #0x30
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x19, [sp, #0x20]
               	mov	x20, x0
               	mov	x21, x1
               	sxtw	x22, w2
               	adrp	x19, <page>
               	add	x19, x19, #0xe0
               	mov	x23, x19
               	mov	x0, x23
               	mov	x3, x22
               	mov	x2, x21
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x19, [sp, #0x30]
               	mov	x20, #0x7               // =7
               	cmp	x20, #0x7
               	b.ne	<addr>
               	mov	x13, #0x0               // =0
               	stur	x13, [x29, #-0x28]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x108
               	mov	x21, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x10f
               	mov	x22, x19
               	mov	x23, #0x13              // =19
               	mov	x0, x21
               	mov	x2, x23
               	mov	x1, x22
               	bl	<addr>
               	stur	x0, [x29, #-0x28]
               	b	<addr>
               	add	x20, x20, #0x1
               	sxtw	x20, w20
               	cmp	x20, #0x8
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x30]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x15e
               	mov	x24, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x169
               	mov	x25, x19
               	mov	x20, #0x14              // =20
               	mov	x0, x24
               	mov	x2, x20
               	mov	x1, x25
               	bl	<addr>
               	stur	x0, [x29, #-0x30]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
