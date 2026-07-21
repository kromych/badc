
register_var_asm_operand.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x1, x29, #0x10
               	sub	sp, sp, #0x20
               	str	x0, [sp, #0x10]
               	str	x12, [sp, #0x18]
               	str	x1, [sp]
               	str	x0, [sp, #0x8]
               	ldr	x12, [sp, #0x8]
               	mov	x12, x0
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	x12, [sp, #0x18]
               	add	sp, sp, #0x20
               	ldur	x0, [x29, #-0x10]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	mov	x0, #0x2a               // =42
               	sub	x1, x29, #0x18
               	sub	sp, sp, #0x20
               	str	x0, [sp, #0x10]
               	str	x12, [sp, #0x18]
               	str	x1, [sp]
               	str	x0, [sp, #0x8]
               	ldr	x12, [sp, #0x8]
               	mov	x12, x0
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	x12, [sp, #0x18]
               	add	sp, sp, #0x20
               	ldur	x0, [x29, #-0x18]
               	cmp	x0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xfff9             // =65529
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	sub	x1, x29, #0x28
               	sub	sp, sp, #0x20
               	str	x0, [sp, #0x10]
               	str	x12, [sp, #0x18]
               	str	x1, [sp]
               	str	x0, [sp, #0x8]
               	ldr	x12, [sp, #0x8]
               	mov	x12, x0
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	x12, [sp, #0x18]
               	add	sp, sp, #0x20
               	ldur	x0, [x29, #-0x28]
               	mov	x17, #0xfff9            // =65529
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
