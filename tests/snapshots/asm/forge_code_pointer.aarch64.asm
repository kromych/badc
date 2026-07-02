
forge_code_pointer.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x19, [sp]
               	mov	x0, #0x2a               // =42
               	mov	x1, #0x0                // =0
               	str	x1, [sp, #-0x10]!
               	mov	x9, x0
               	ldr	x0, [sp]
               	blr	x9
               	add	sp, sp, #0x10
               	sxtw	x0, w0
               	ldr	x19, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
