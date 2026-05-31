
ssa_callee_saved_x19.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x4002e8 <.text+0x68>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xd8]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x19, [sp]
               	adrp	x19, 0x410000
               	add	x19, x19, #0xe8
               	mov	x15, x19
               	ldrsw	x14, [x15]
               	cbz	x14, 0x4002d4 <.text+0x54>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xe8
               	mov	x15, x19
               	mov	x14, #0x2               // =2
               	str	w14, [x15]
               	b	0x4002d4 <.text+0x54>
               	mov	x0, #0x0                // =0
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	adrp	x19, 0x400000
               	add	x19, x19, #0x298
               	mov	x20, x19
               	mov	x21, #0x0               // =0
               	mov	x0, x20
               	mov	x2, x21
               	mov	x1, x21
               	bl	0x400488 <__cxa_atexit>
               	sxtw	x0, w0
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
