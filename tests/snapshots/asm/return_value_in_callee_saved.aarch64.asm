
return_value_in_callee_saved.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sxtw	x0, w0
               	cmp	x0, #0x2
               	b.ge	<addr>
               	sxtw	x0, w0
               	ret
               	sxtw	x0, w0
               	ret

<hop>:
               	add	x0, x0, #0x1
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ret

<main>:
               	mov	x0, #0x7                // =7
               	mov	x0, #0x7                // =7
               	ret
