
indirect_call_through_global_fn_ptr.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	sxtw	x1, w1
               	sxtw	x2, w2
               	add	x1, x1, x2
               	sxtw	x1, w1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	adrp	x0, <page>
               	add	x0, x0, #0xd8
               	mov	x1, #0x7                // =7
               	str	w1, [x0]
               	adrp	x1, <page>
               	add	x1, x1, #0xe0
               	mov	x2, #0x23               // =35
               	str	w2, [x1]
               	adrp	x20, <page>
               	add	x20, x20, #0xd0
               	ldrsw	x0, [x0]
               	ldrsw	x2, [x1]
               	adrp	x1, <page>
               	add	x1, x1, #0xe8
               	ldr	x1, [x1]
               	mov	x9, x1
               	str	x2, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	str	x20, [sp, #-0x10]!
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x10]
               	ldr	x2, [sp, #0x20]
               	blr	x9
               	add	sp, sp, #0x30
               	ldrsw	x0, [x20]
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
