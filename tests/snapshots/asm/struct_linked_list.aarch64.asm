
struct_linked_list.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xd8]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	mov	x20, #0x0               // =0
               	mov	x21, x20
               	b	<addr>
               	sxtw	x0, w20
               	cmp	x0, #0x5
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w20
               	add	x20, x0, #0x1
               	mov	x21, x1
               	b	<addr>
               	mov	x0, #0x10               // =16
               	bl	<addr>
               	mov	x1, x0
               	sxtw	x0, w20
               	str	w0, [x1]
               	str	x21, [x1, #0x8]
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	cmp	x21, #0x0
               	b.eq	<addr>
               	sxtw	x0, w1
               	ldrsw	x1, [x21]
               	add	x0, x0, x1
               	sxtw	x1, w0
               	ldr	x21, [x21, #0x8]
               	b	<addr>
               	sxtw	x0, w1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
