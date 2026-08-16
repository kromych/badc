
type_warning_return.aarch64:	file format elf64-littleaarch64

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

<ret_ptr_as_int>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	sxtw	x0, w0
               	ret

<ret_int_as_ptr>:
               	sxtw	x0, w0
               	ret

<ret_null>:
               	mov	x0, #0x0                // =0
               	ret

<ret_ok>:
               	sxtw	x0, w0
               	ret

<main>:
               	mov	x0, #0x0                // =0
               	ret
