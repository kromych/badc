
fn_ptr_decay_inside_block.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	sxtw	x0, w0
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x90
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x8]
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, #0x238
               	b	<addr>
               	adrp	x20, <page>
               	add	x20, x20, #0x238
               	sub	x21, x29, #0x8
               	ldrsw	x22, [x21]
               	mov	x0, #0x1                // =1
               	mov	x9, x20
               	str	x0, [sp, #-0x10]!
               	ldr	x0, [sp]
               	blr	x9
               	add	sp, sp, #0x10
               	add	x0, x22, x0
               	str	w0, [x21]
               	sub	x21, x29, #0x8
               	ldrsw	x22, [x21]
               	mov	x0, #0x2                // =2
               	mov	x9, x20
               	str	x0, [sp, #-0x10]!
               	ldr	x0, [sp]
               	blr	x9
               	add	sp, sp, #0x10
               	add	x0, x22, x0
               	str	w0, [x21]
               	b	<addr>
               	cmp	x1, #0x0
               	b.eq	<addr>
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	sub	x20, x29, #0x8
               	ldrsw	x21, [x20]
               	mov	x0, #0x3                // =3
               	mov	x9, x1
               	str	x0, [sp, #-0x10]!
               	ldr	x0, [sp]
               	blr	x9
               	add	sp, sp, #0x10
               	add	x0, x21, x0
               	str	w0, [x20]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x238
               	stur	x0, [x29, #-0x48]
               	sub	x20, x29, #0x8
               	ldrsw	x21, [x20]
               	sub	x0, x29, #0x48
               	ldr	x0, [x0]
               	mov	x1, #0x4                // =4
               	mov	x9, x0
               	str	x1, [sp, #-0x10]!
               	ldr	x0, [sp]
               	blr	x9
               	add	sp, sp, #0x10
               	add	x0, x21, x0
               	str	w0, [x20]
               	ldursw	x0, [x29, #-0x8]
               	cmp	x0, #0x19a
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x2                // =2
               	b	<addr>
               	mov	x0, x1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
