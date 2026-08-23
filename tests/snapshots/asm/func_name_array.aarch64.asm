
func_name_array.aarch64:	file format elf64-littleaarch64

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

<main>:
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x0, #0x0                // =0
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	add	x2, x3, x1
               	ldrb	w2, [x2]
               	add	x5, x4, x1
               	ldrsb	x5, [x5]
               	eor	x2, x2, x5
               	mov	w2, w2
               	cbnz	x2, <addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x5
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x2                // =2
               	ret
