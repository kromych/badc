
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
               	sub	sp, sp, #0x10
               	mov	x16, #0x1e              // =30
               	str	x16, [sp]
               	mov	x16, #0xa               // =10
               	str	x16, [sp, #0x8]
               	ldr	x9, [sp]
               	ldr	x12, [sp, #0x8]
               	add	x0, x9, x12
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<narrow_pinned>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x16, #0x1               // =1
               	str	x16, [sp]
               	ldr	x9, [sp]
               	add	w0, w9, w9
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x16, #0x1e              // =30
               	str	x16, [sp]
               	mov	x16, #0xa               // =10
               	str	x16, [sp, #0x8]
               	ldr	x9, [sp]
               	ldr	x12, [sp, #0x8]
               	add	x0, x9, x12
               	cmp	w0, #0x28
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x1               // =1
               	str	x16, [sp]
               	ldr	x9, [sp]
               	add	w0, w9, w9
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
