
fn_ptr_multi_deref.aarch64:	file format elf64-littleaarch64

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

<add>:
               	add	x0, x0, x1
               	sxtw	x0, w0
               	ret

<main>:
               	mov	x0, #0x0                // =0
               	ret
