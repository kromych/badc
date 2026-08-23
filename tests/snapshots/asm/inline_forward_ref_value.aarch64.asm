
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
               	add	x2, x0, #0x1
               	sxtw	x3, w2
               	cbz	x0, <addr>
               	add	x1, x0, #0x64
               	cbnz	x1, <addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ret
               	lsl	x0, x1, #1
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	add	x1, x0, #0x1
               	str	w1, [x5]
               	add	x0, x0, x2
               	add	x0, x0, x3
               	ret
               	mov	x0, #0xfffe             // =65534
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ret

<main>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xd3               // =211
               	str	w1, [x0]
               	mov	x0, #0xde               // =222
               	mov	x0, #0x0                // =0
               	ret
