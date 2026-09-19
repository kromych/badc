
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
               	add	x3, x0, #0x1
               	sxtw	x1, w3
               	cbz	x0, <addr>
               	add	x2, x0, #0x64
               	cbnz	x2, <addr>
               	mov	x0, #-0x1               // =-1
               	ret
               	lsl	x0, x2, #1
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	add	x2, x0, #0x1
               	str	w2, [x4]
               	add	x0, x0, x3
               	add	x0, x0, x1
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
