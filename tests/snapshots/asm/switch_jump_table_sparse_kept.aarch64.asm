
switch_jump_table_sparse_kept.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0x1                // =1
               	mov	x0, #0x2                // =2
               	mov	x0, #0x3                // =3
               	mov	x0, #0x4                // =4
               	mov	x0, #0x5                // =5
               	mov	x0, #0x6                // =6
               	mov	x0, #0x7                // =7
               	mov	x0, #0x8                // =8
               	mov	x0, #0x9                // =9
               	mov	x0, #0xa                // =10
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x1, x0
               	mov	x1, x0
               	mov	x0, #0x0                // =0
               	ret
