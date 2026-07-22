
inline_forward_ref_value.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	add	x1, x0, #0x1
               	sxtw	x2, w1
               	sxtw	x2, w2
               	cbz	x0, <addr>
               	add	x1, x0, #0x64
               	add	x3, x0, #0x1
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ret
               	lsl	x1, x1, #1
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	add	x0, x1, #0x1
               	str	w0, [x4]
               	add	x0, x1, x3
               	sxtw	x1, w2
               	add	x0, x0, x1
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
