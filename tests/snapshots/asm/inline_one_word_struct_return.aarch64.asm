
inline_one_word_struct_return.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	b	<addr>
               	add	x3, x0, #0x1
               	sxtw	x3, w3
               	mov	x17, #0xa               // =10
               	mul	x3, x3, x17
               	add	x1, x1, x3
               	add	x0, x2, #0x1
               	sxtw	x2, w0
               	cmp	x2, #0x5
               	b.lt	<addr>
               	cmp	x1, #0x96
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
