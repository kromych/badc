
write_stdout.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x3b0              // =944
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	x20, [sp, #-0x30]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x0, #0x4                // =4
               	bl	<addr>
               	mov	x1, x0
               	mov	x20, #0x0               // =0
               	mov	x0, #0x68               // =104
               	strb	w0, [x1]
               	mov	x0, #0x1                // =1
               	mov	x2, #0x69               // =105
               	strb	w2, [x1, #0x1]
               	mov	x2, #0xa                // =10
               	strb	w2, [x1, #0x2]
               	mov	x2, #0x3                // =3
               	strb	w20, [x1, #0x3]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
