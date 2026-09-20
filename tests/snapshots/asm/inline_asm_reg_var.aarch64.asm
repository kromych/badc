
inline_asm_reg_var.aarch64:	file format elf64-littleaarch64

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

<add_pinned>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x16, x29, #0x8
               	str	x16, [sp]
               	mov	x16, #0x1e              // =30
               	str	x16, [sp, #0x8]
               	mov	x16, #0xa               // =10
               	str	x16, [sp, #0x10]
               	ldr	x9, [sp, #0x8]
               	ldr	x12, [sp, #0x10]
               	add	x0, x9, x12
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldur	x0, [x29, #-0x8]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<narrow_pinned>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x16, x29, #0x8
               	str	x16, [sp]
               	mov	x16, #0x1               // =1
               	str	x16, [sp, #0x8]
               	ldr	x9, [sp, #0x8]
               	add	w0, w9, w9
               	ldr	x16, [sp]
               	str	w0, [x16]
               	ldursw	x0, [x29, #-0x8]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	x16, x29, #0x18
               	str	x16, [sp]
               	mov	x16, #0x1e              // =30
               	str	x16, [sp, #0x8]
               	mov	x16, #0xa               // =10
               	str	x16, [sp, #0x10]
               	ldr	x9, [sp, #0x8]
               	ldr	x12, [sp, #0x10]
               	add	x0, x9, x12
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldur	x0, [x29, #-0x18]
               	cmp	w0, #0x28
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x10
               	str	x16, [sp]
               	mov	x16, #0x1               // =1
               	str	x16, [sp, #0x8]
               	ldr	x9, [sp, #0x8]
               	add	w0, w9, w9
               	ldr	x16, [sp]
               	str	w0, [x16]
               	ldursw	x0, [x29, #-0x10]
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
