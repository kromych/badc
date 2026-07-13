
macro_paste_empty_arg_placemarker.aarch64:	file format elf64-littleaarch64

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

<uint32_to_x>:
               	add	x0, x0, #0x2
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ret

<with_empty_sign>:
               	mov	x0, #0x2                // =2
               	ret

<with_u_sign>:
               	mov	x0, #0x3                // =3
               	ret

<main>:
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x9                // =9
               	str	w0, [x1]
               	sxtw	x0, w0
               	cmp	x0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x0                // =0
               	ret
