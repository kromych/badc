
inline_naked_not_inlined.aarch64:	file format elf64-littleaarch64

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

<identity_asm>:
               	ret

<use_identity>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	add	x0, x0, #0x1
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x29               // =41
               	bl	<addr>
               	add	x0, x0, #0x1
               	mov	x1, #0x0                // =0
               	mov	x2, #0x1                // =1
               	cmp	x0, #0x2a
               	csel	x0, x1, x2, eq
               	ldp	x29, x30, [sp], #0x10
               	ret
