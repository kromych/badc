
for_loop_call_body_and_step.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<driver>:
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	b	<addr>
               	add	x1, x1, #0x1
               	sxtw	x1, w1
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	sxtw	x2, w0
               	cmp	x2, #0x7
               	b.lt	<addr>
               	mov	x17, #0x6               // =6
               	mul	x0, x1, x17
               	sxtw	x0, w0
               	ret

<main>:
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	b	<addr>
               	add	x1, x1, #0x1
               	sxtw	x1, w1
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	sxtw	x2, w0
               	cmp	x2, #0x7
               	b.lt	<addr>
               	mov	x17, #0x6               // =6
               	mul	x0, x1, x17
               	sxtw	x0, w0
               	ret
