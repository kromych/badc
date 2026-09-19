
write_stdout.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0x4                // =4
               	bl	<addr>
               	mov	x1, x0
               	mov	x3, #0x0                // =0
               	mov	x0, #0x68               // =104
               	strb	w0, [x1]
               	mov	x0, #0x1                // =1
               	mov	x2, #0x69               // =105
               	strb	w2, [x1, #0x1]
               	mov	x2, #0xa                // =10
               	strb	w2, [x1, #0x2]
               	mov	x2, #0x3                // =3
               	strb	w3, [x1, #0x3]
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
