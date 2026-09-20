
struct_by_value_param.aarch64:	file format elf64-littleaarch64

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

<sum_pair>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	x0, [x29, #-0x8]
               	sub	x1, x29, #0x8
               	ldrsw	x0, [x1]
               	ldrsw	x2, [x1, #0x4]
               	add	x0, x0, x2
               	mov	x2, #-0x1               // =-1
               	str	w2, [x1]
               	str	w2, [x1, #0x4]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	mov	x0, #0x0                // =0
               	ret
