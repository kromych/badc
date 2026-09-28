
struct_arg_value_form.aarch64:	file format elf64-littleaarch64

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

<take_kuid>:
               	ret

<take_pair>:
               	lsr	x1, x0, #32
               	lsl	x1, x1, #32
               	mov	w0, w0
               	orr	x0, x1, x0
               	ret

<take_kuid_proto>:
               	ret

<main>:
               	mov	x0, #0x0                // =0
               	ret
