
branch_protection_pac_ret_leaf.aarch64:	file format elf64-littleaarch64

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

<leaf>:
               	paciasp
               	add	x0, x1, x0, lsl #1
               	autiasp
               	ret

<main>:
               	paciasp
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x14               // =20
               	mov	x1, #0x2                // =2
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	autiasp
               	ret
