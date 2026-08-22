
unsigned_div_in_assign.aarch64:	file format elf64-littleaarch64

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

<outer>:
               	mov	x1, x0
               	ldr	x2, [x1]
               	mov	x0, #0x18               // =24
               	udiv	x0, x2, x0
               	mov	x1, #0x7                // =7
               	udiv	x17, x2, x1
               	msub	x1, x17, x1, x2
               	mov	x17, #0x64              // =100
               	mul	x0, x0, x17
               	add	x0, x0, x1
               	sxtw	x0, w0
               	ret

<main>:
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	ret
