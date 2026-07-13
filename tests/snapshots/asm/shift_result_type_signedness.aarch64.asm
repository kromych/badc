
shift_result_type_signedness.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sxtw	x1, w1
               	mov	w0, w0
               	lsl	x0, x0, x1
               	mov	w0, w0
               	sxtw	x0, w0
               	asr	x0, x0, x1
               	sxtw	x0, w0
               	ret

<main>:
               	mov	x0, #0x0                // =0
               	ret
