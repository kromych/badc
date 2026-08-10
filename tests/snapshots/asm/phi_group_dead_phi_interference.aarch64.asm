
phi_group_dead_phi_interference.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<main>:
               	mov	x0, #0x0                // =0
               	mov	x2, #0x0                // =0
               	mov	x3, x2
               	mov	x1, x0
               	mov	x4, x0
               	b	<addr>
               	add	x1, x3, #0x1
               	mov	x3, x2
               	mov	x4, x0
               	sxtw	x3, w1
               	cmp	x3, #0x5
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	ret
