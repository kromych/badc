
indirect_call_through_global_fn_ptr.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	mov	x15, x0
               	sxtw	x14, w1
               	sxtw	x13, w2
               	add	x14, x14, x13
               	sxtw	x14, w14
               	str	w14, [x15]
               	mov	x0, #0x0                // =0
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x19, [sp, #0x20]
               	adrp	x19, <page>
               	add	x19, x19, #0xd8
               	mov	x15, x19
               	mov	x14, #0x7               // =7
               	str	w14, [x15]
               	adrp	x19, <page>
               	add	x19, x19, #0xe0
               	mov	x13, x19
               	mov	x14, #0x23              // =35
               	str	w14, [x13]
               	adrp	x19, <page>
               	add	x19, x19, #0xd0
               	mov	x20, x19
               	ldrsw	x21, [x15]
               	ldrsw	x22, [x13]
               	adrp	x19, <page>
               	add	x19, x19, #0xe8
               	mov	x13, x19
               	ldr	x23, [x13]
               	mov	x9, x23
               	str	x22, [sp, #-0x10]!
               	str	x21, [sp, #-0x10]!
               	str	x20, [sp, #-0x10]!
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x10]
               	ldr	x2, [sp, #0x20]
               	blr	x9
               	add	sp, sp, #0x30
               	ldrsw	x0, [x20]
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
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
