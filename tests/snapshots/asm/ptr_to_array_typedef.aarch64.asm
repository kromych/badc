
ptr_to_array_typedef.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x70
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x68]
               	sub	x1, x29, #0x68
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x2, #0x2                // =2
               	str	x2, [x0, #0x18]
               	str	x0, [x1]
               	ldur	x0, [x29, #-0x68]
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x68]
               	ldr	x0, [x0, #0x18]
               	cmp	x0, #0x2
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x68]
               	ldr	x0, [x0, #0x18]
               	cmp	x0, #0x2
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x68]
               	ldr	x0, [x0, #0x18]
               	add	x0, x0, #0x1e
               	add	x0, x0, #0x11
               	sub	x0, x0, #0x7
               	sxtw	x0, w0
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
