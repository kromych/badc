
switch_jumptable_dead_branch_prune.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0xa                // =10
               	mov	x0, #0x15               // =21
               	mov	x0, #0x20               // =32
               	mov	x0, #0x2b               // =43
               	mov	x0, #0x36               // =54
               	mov	x0, #0x41               // =65
               	mov	x0, #0x4c               // =76
               	mov	x0, #0x57               // =87
               	mov	x0, #0x62               // =98
               	mov	x0, #0x13               // =19
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	mov	x0, #0xc                // =12
               	ret
