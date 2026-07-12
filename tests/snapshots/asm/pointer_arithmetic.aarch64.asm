
pointer_arithmetic.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2c0              // =704
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	x19, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x0, #0x8                // =8
               	bl	<addr>
               	mov	x1, #0x1                // =1
               	str	w1, [x0]
               	mov	x2, #0x2                // =2
               	str	w2, [x0, #0x4]
               	sxtw	x1, w1
               	sxtw	x0, w2
               	add	x0, x1, x0
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
