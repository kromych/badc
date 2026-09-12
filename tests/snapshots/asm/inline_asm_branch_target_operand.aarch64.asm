
inline_asm_branch_target_operand.aarch64:	file format elf64-littleaarch64

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

<helper_1>:
               	mov	x0, #0x1                // =1
               	ret

<helper_2>:
               	mov	x0, #0x2                // =2
               	ret

<helper_4>:
               	mov	x0, #0x4                // =4
               	ret

<helper_8>:
               	mov	x0, #0x8                // =8
               	ret

<main>:
               	str	x20, [sp, #-0x50]!
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	str	x18, [sp, #0x18]
               	str	x30, [sp, #0x20]
               	sub	x16, x29, #0x10
               	str	x16, [sp, #0x10]
               	bl	<addr>
               	ldr	x16, [sp, #0x10]
               	str	w0, [x16]
               	ldr	x18, [sp, #0x18]
               	ldr	x30, [sp, #0x20]
               	ldursw	x0, [x29, #-0x10]
               	add	x20, x0, #0x0
               	str	x18, [sp, #0x18]
               	str	x30, [sp, #0x20]
               	sub	x16, x29, #0x10
               	str	x16, [sp, #0x10]
               	bl	<addr>
               	ldr	x16, [sp, #0x10]
               	str	w0, [x16]
               	ldr	x18, [sp, #0x18]
               	ldr	x30, [sp, #0x20]
               	ldursw	x0, [x29, #-0x10]
               	add	x20, x20, x0
               	str	x18, [sp, #0x18]
               	str	x30, [sp, #0x20]
               	sub	x16, x29, #0x10
               	str	x16, [sp, #0x10]
               	bl	<addr>
               	ldr	x16, [sp, #0x10]
               	str	w0, [x16]
               	ldr	x18, [sp, #0x18]
               	ldr	x30, [sp, #0x20]
               	ldursw	x0, [x29, #-0x10]
               	add	x20, x20, x0
               	str	x18, [sp, #0x18]
               	str	x30, [sp, #0x20]
               	sub	x16, x29, #0x10
               	str	x16, [sp, #0x10]
               	bl	<addr>
               	ldr	x16, [sp, #0x10]
               	str	w0, [x16]
               	ldr	x18, [sp, #0x18]
               	ldr	x30, [sp, #0x20]
               	ldursw	x0, [x29, #-0x10]
               	add	x0, x20, x0
               	sxtw	x0, w0
               	cmp	w0, #0xf
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x20, [sp], #0x50
               	ret
               	mov	x0, #0x2a               // =42
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x20, [sp], #0x50
               	ret
