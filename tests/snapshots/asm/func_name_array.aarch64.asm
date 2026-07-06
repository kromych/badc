
func_name_array.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	b	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x2, #0x0                // =0
               	sxtw	x1, w2
               	cmp	x1, #0x5
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x1, w2
               	add	x2, x1, #0x1
               	b	<addr>
               	sxtw	x1, w2
               	add	x3, x0, x1
               	ldrb	w3, [x3]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	add	x1, x4, x1
               	ldrsb	x1, [x1]
               	eor	x1, x3, x1
               	mov	w1, w1
               	cmp	x1, #0x0
               	b.eq	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x2                // =2
               	ret
               	b	<addr>
