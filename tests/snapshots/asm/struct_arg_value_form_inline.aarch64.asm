
struct_arg_value_form_inline.aarch64:	file format elf64-littleaarch64

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

<take_triple>:
               	lsr	x1, x0, #8
               	lsr	x2, x0, #16
               	and	x0, x0, #0xff
               	and	x1, x1, #0xff
               	orr	x0, x0, x1, lsl #8
               	and	x1, x2, #0xff
               	orr	x0, x0, x1, lsl #16
               	ret

<take_pair>:
               	lsr	x1, x0, #32
               	mov	w0, w0
               	orr	x0, x0, x1, lsl #32
               	ret

<take_wide>:
               	add	x0, x0, x1
               	ret

<main>:
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	str	w0, [x1]
               	ldr	w1, [x1]
               	cbz	w1, <addr>
               	mov	x0, #0x8                // =8
               	ret
               	ret
