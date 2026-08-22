
static_linked_list.aarch64:	file format elf64-littleaarch64

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
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x1                // =1
               	str	w0, [x1]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x0, [x1, #0x8]
               	mov	x1, #0x2                // =2
               	str	w1, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x2, [x0, #0x8]
               	mov	x0, #0x3                // =3
               	str	w0, [x2]
               	mov	x1, #0x0                // =0
               	str	x1, [x2, #0x8]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	b	<addr>
               	ldrsw	x2, [x0]
               	add	x1, x1, x2
               	ldr	x0, [x0, #0x8]
               	cbnz	x0, <addr>
               	sxtw	x0, w1
               	cmp	x0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret
