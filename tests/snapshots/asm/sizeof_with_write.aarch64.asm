
sizeof_with_write.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x3b0              // =944
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	mov	x20, #0x10              // =16
               	mov	x0, x20
               	bl	<addr>
               	mov	x1, x0
               	mov	x0, #0x1                // =1
               	str	w0, [x1]
               	mov	x2, #0x2                // =2
               	str	w2, [x1, #0x4]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x2, [x1, #0x8]
               	mov	x2, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
