
ssa_callee_saved_x19.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xd8]
               	blr	x16
               	adrp	x15, <page>
               	add	x15, x15, #0xe8
               	ldrsw	x14, [x15]
               	cbz	x14, <addr>
               	mov	x13, #0x2               // =2
               	str	w13, [x15]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	adrp	x0, <page>
               	add	x0, x0, #0x298
               	mov	x20, #0x0               // =0
               	mov	x1, x20
               	mov	x2, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x13, x0
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
