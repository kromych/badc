
sizeof_with_write.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x10               // =16
               	bl	<addr>
               	mov	x1, x0
               	mov	x0, #0x1                // =1
               	str	w0, [x1]
               	mov	x2, #0x2                // =2
               	str	w2, [x1, #0x4]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x2, [x1, #0x8]
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	mov	x0, #0x10               // =16
               	ldp	x29, x30, [sp], #0x10
               	ret
