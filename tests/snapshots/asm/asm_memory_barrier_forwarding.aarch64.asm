
asm_memory_barrier_forwarding.aarch64:	file format elf64-littleaarch64

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
               	adrp	x0, <page>
               	mov	x1, #0x7                // =7
               	str	w1, [x0, #0x18]
               	ldrsw	x1, [x0, #0x18]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x18]
               	ldrsw	x0, [x0, #0x18]
               	mov	x1, #0x0                // =0
               	mov	x2, #0x1                // =1
               	cmp	w0, #0x8
               	csel	x0, x1, x2, eq
               	ret
