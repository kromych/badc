
fn_ptr_decay_inside_block.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	sxtw	x15, w0
               	add	x15, x15, #0x64
               	sxtw	x0, w15
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xa0
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x19, [sp, #0x30]
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x8]
               	mov	x14, #0x1               // =1
               	sxtw	x14, w14
               	cmp	x14, #0x0
               	b.ne	<addr>
               	mov	x15, #0x1               // =1
               	mov	x0, x15
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x238
               	mov	x25, x19
               	stur	x25, [x29, #-0x30]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x238
               	mov	x20, x19
               	sub	x21, x29, #0x8
               	ldrsw	x22, [x21]
               	mov	x23, #0x1               // =1
               	mov	x9, x20
               	str	x23, [sp, #-0x10]!
               	ldr	x0, [sp]
               	blr	x9
               	add	sp, sp, #0x10
               	add	x22, x22, x0
               	str	w22, [x21]
               	sub	x24, x29, #0x8
               	ldrsw	x25, [x24]
               	mov	x22, #0x2               // =2
               	mov	x9, x20
               	str	x22, [sp, #-0x10]!
               	ldr	x0, [sp]
               	blr	x9
               	add	sp, sp, #0x10
               	add	x25, x25, x0
               	str	w25, [x24]
               	b	<addr>
               	ldur	x25, [x29, #-0x30]
               	cmp	x25, #0x0
               	b.eq	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x30]
               	b	<addr>
               	sub	x23, x29, #0x8
               	ldrsw	x21, [x23]
               	mov	x25, #0x3               // =3
               	ldur	x24, [x29, #-0x30]
               	mov	x9, x24
               	str	x25, [sp, #-0x10]!
               	ldr	x0, [sp]
               	blr	x9
               	add	sp, sp, #0x10
               	add	x21, x21, x0
               	str	w21, [x23]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x238
               	mov	x21, x19
               	stur	x21, [x29, #-0x48]
               	sub	x20, x29, #0x8
               	ldrsw	x22, [x20]
               	sub	x23, x29, #0x48
               	ldr	x23, [x23]
               	mov	x21, #0x4               // =4
               	mov	x9, x23
               	str	x21, [sp, #-0x10]!
               	ldr	x0, [sp]
               	blr	x9
               	add	sp, sp, #0x10
               	add	x22, x22, x0
               	str	w22, [x20]
               	ldursw	x0, [x29, #-0x8]
               	cmp	x0, #0x19a
               	b.ne	<addr>
               	mov	x22, #0x0               // =0
               	stur	x22, [x29, #-0x60]
               	b	<addr>
               	mov	x22, #0x2               // =2
               	stur	x22, [x29, #-0x60]
               	b	<addr>
               	ldur	x22, [x29, #-0x60]
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
