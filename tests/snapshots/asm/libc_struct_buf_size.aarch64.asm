
libc_struct_buf_size.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x80
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x80
               	bl	<addr>
               	cbz	w0, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sxtw	x1, w0
               	mov	x0, x2
               	bl	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
