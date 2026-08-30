
store_to_load_forward.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x20
               	mov	x1, #0x0                // =0
               	stur	x1, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	mov	x2, #0x15               // =21
               	str	x2, [x0]
               	mov	x2, #0x5                // =5
               	stur	x2, [x29, #-0x8]
               	mov	x2, #0x9                // =9
               	str	x2, [x0]
               	str	x2, [x0]
               	mov	x0, x1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
