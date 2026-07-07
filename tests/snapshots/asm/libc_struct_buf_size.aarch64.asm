
libc_struct_buf_size.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x3c0              // =960
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	x19, [sp, #-0xc0]!
               	stp	x29, x30, [sp, #0xb0]
               	add	x29, sp, #0xb0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x80
               	bl	<addr>
               	sxtw	x0, w0
               	sxtw	x1, w0
               	cmp	x1, #0x0
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sxtw	x0, w0
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0xb0]
               	ldr	x19, [sp], #0xc0
               	ret
               	mov	x0, #0x2a               // =42
               	ldp	x29, x30, [sp, #0xb0]
               	ldr	x19, [sp], #0xc0
               	ret
