
sizeof_function_call_truncation.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sxtw	x0, w0
               	mov	x17, #0xff              // =255
               	and	x1, x0, x17
               	asr	x0, x0, #8
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	add	x0, x1, x0
               	lsl	x0, x0, #1
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ret

<main>:
               	mov	x0, #0x0                // =0
               	ret
