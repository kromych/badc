
for_loop_call_body_and_step.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	ret

<advance>:
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	ret

<driver>:
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	b	<addr>
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	add	x1, x1, #0x1
               	sxtw	x1, w1
               	sxtw	x2, w1
               	cmp	x2, #0x7
               	b.lt	<addr>
               	mov	x17, #0x6               // =6
               	mul	x0, x0, x17
               	sxtw	x0, w0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
