
recursion_factorial.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x1, x0
               	sxtw	x1, w1
               	mov	x0, #0x1                // =1
               	b	<addr>
               	sub	x2, x1, #0x1
               	sxtw	x2, w2
               	mul	x0, x0, x1
               	mov	x1, x2
               	cmp	x1, #0x2
               	b.ge	<addr>
               	lsr	x0, x0, #0
               	sxtw	x0, w0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
