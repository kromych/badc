
anon_struct_designated_init.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0x1                // =1
               	mov	x0, #0x1                // =1
               	mov	x0, #0x1                // =1
               	mov	x0, #0x1                // =1
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x8]
               	mov	x0, #0x1                // =1
               	mov	x0, #0x1                // =1
               	mov	x0, #0x1                // =1
               	mov	x0, #0x1                // =1
               	mov	x0, #0x1                // =1
               	mov	x0, #0x1                // =1
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
