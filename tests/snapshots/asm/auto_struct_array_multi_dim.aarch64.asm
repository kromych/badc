
auto_struct_array_multi_dim.aarch64:	file format elf64-littleaarch64

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

<runtime3d>:
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	mov	x0, x1
               	mov	x0, x1
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	mov	x0, #0x2                // =2
               	mov	x1, #0x1000             // =4096
               	mov	x2, #0x9000             // =36864
               	bl	<addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret
