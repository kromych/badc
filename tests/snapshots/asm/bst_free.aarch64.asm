
bst_free.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xe0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	mov	x20, x0
               	cmp	x20, #0x0
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x20, #0x8
               	ldr	x0, [x0]
               	bl	<addr>
               	add	x0, x20, #0x10
               	ldr	x0, [x0]
               	bl	<addr>
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	mov	x20, x0
               	mov	x21, x1
               	cmp	x20, #0x0
               	b.ne	<addr>
               	mov	x0, #0x18               // =24
               	bl	<addr>
               	mov	x1, #0x0                // =0
               	str	x21, [x0]
               	add	x2, x0, #0x8
               	str	x1, [x2]
               	add	x2, x0, #0x10
               	str	x1, [x2]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [x20]
               	cmp	x21, x0
               	b.ge	<addr>
               	add	x22, x20, #0x8
               	ldr	x0, [x22]
               	mov	x1, x21
               	bl	<addr>
               	str	x0, [x22]
               	b	<addr>
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x22, x20, #0x10
               	ldr	x0, [x22]
               	mov	x1, x21
               	bl	<addr>
               	str	x0, [x22]
               	b	<addr>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	mov	x20, #0x0               // =0
               	mov	x1, #0x32               // =50
               	mov	x0, x20
               	bl	<addr>
               	mov	x21, x0
               	mov	x1, #0x1e               // =30
               	mov	x0, x21
               	bl	<addr>
               	mov	x1, #0x46               // =70
               	mov	x0, x21
               	bl	<addr>
               	mov	x0, x21
               	bl	<addr>
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
