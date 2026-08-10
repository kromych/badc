
inline_struct_return_escape.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<mkesc>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0x2a               // =42
               	str	x0, [x1]
               	sub	x1, x29, #0x8
               	mov	x2, #0x0                // =0
               	str	x2, [x1]
               	sub	x1, x29, #0x8
               	str	x0, [x1]
               	sub	x0, x29, #0x8
               	mov	x16, x0
               	ldr	x0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x18]
               	mov	x0, #0x2a               // =42
               	sub	x1, x29, #0x18
               	bl	<addr>
               	sub	x16, x29, #0x8
               	str	x0, [x16]
               	sub	x0, x29, #0x8
               	sub	x1, x29, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x10
               	ldr	x0, [x0]
               	cmp	x0, #0x2a
               	cset	x0, eq
               	cbz	x0, <addr>
               	ldur	x0, [x29, #-0x18]
               	cmp	x0, #0x2a
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
               	b	<addr>
