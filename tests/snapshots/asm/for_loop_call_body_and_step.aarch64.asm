
for_loop_call_body_and_step.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	add	x0, x0, #0x1
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ret

<advance>:
               	add	x0, x0, #0x1
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ret

<driver>:
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	b	<addr>
               	add	x1, x1, #0x1
               	sxtw	x2, w1
               	sxtw	x1, w2
               	add	x0, x0, #0x1
               	sxtw	x2, w0
               	sxtw	x0, w2
               	sxtw	x2, w0
               	cmp	x2, #0x7
               	b.lt	<addr>
               	mov	x17, #0x6               // =6
               	mul	x0, x1, x17
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret
