
inline_forward_ref_value.aarch64:	file format elf64-littleaarch64

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

<compute>:
               	add	x1, x0, #0x1
               	sxtw	x2, w1
               	cbz	x0, <addr>
               	add	x0, x0, #0x64
               	cbnz	x0, <addr>
               	mov	x0, #-0x1               // =-1
               	ret
               	lsl	x0, x0, #1
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	add	x4, x0, #0x1
               	str	w4, [x3]
               	add	x0, x0, x1
               	add	x0, x0, x2
               	ret
               	mov	x0, #-0x2               // =-2
               	ret

<main>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xd3               // =211
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	ret
