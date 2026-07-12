
dlopen_strlen.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x300              // =768
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	x19, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x0, #0x0                // =0
               	mov	x1, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
