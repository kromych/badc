
asm_matching_constraint_is_its_whole_number.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
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
               	sub	sp, sp, #0x60
               	mov	x0, #0x0                // =0
               	mov	x1, #0x1                // =1
               	mov	x2, #0x2                // =2
               	mov	x3, #0x3                // =3
               	mov	x4, #0x4                // =4
               	mov	x5, #0x5                // =5
               	mov	x6, #0x6                // =6
               	mov	x7, #0x7                // =7
               	mov	x8, #0x8                // =8
               	mov	x9, #0x9                // =9
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	str	x2, [sp, #0x10]
               	str	x3, [sp, #0x18]
               	str	x4, [sp, #0x20]
               	str	x5, [sp, #0x28]
               	str	x6, [sp, #0x30]
               	str	x7, [sp, #0x38]
               	str	x8, [sp, #0x40]
               	str	x9, [sp, #0x48]
               	mov	x16, #0x2a              // =42
               	str	x16, [sp, #0x50]
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x8]
               	ldr	x2, [sp, #0x10]
               	ldr	x3, [sp, #0x18]
               	ldr	x4, [sp, #0x20]
               	ldr	x5, [sp, #0x28]
               	ldr	x6, [sp, #0x30]
               	ldr	x7, [sp, #0x38]
               	ldr	x8, [sp, #0x40]
               	ldr	x9, [sp, #0x48]
               	ldr	x10, [sp, #0x50]
               	cmp	x10, #0x2a
               	b.ne	<addr>
               	cmp	x1, #0x1
               	b.ne	<addr>
               	cmp	x9, #0x9
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
