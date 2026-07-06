
struct_basic.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	x19, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x0, #0x8                // =8
               	bl	<addr>
               	mov	x1, #0x3                // =3
               	str	w1, [x0]
               	mov	x2, #0x4                // =4
               	str	w2, [x0, #0x4]
               	sxtw	x3, w1
               	sxtw	x1, w1
               	mul	x1, x3, x1
               	sxtw	x0, w2
               	sxtw	x2, w2
               	mul	x0, x0, x2
               	add	x0, x1, x0
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
