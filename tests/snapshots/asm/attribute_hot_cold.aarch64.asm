
attribute_hot_cold.aarch64:	file format elf64-littleaarch64

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

<error_path>:
               	mov	x0, #0x29               // =41
               	ret

<hot_decl>:
               	lsl	x0, x0, #1
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ret

<main>:
               	mov	x0, #0x0                // =0
               	ret
