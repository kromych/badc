
nested_array_designators.aarch64:	file format elf64-littleaarch64

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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0, #0x28]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	cmp	x1, x2
               	b.ne	<addr>
               	ldr	x0, [x0, #0x30]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w1, [x0, #0x2]
               	mov	x17, #0x28              // =40
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	ldrb	w1, [x0, #0x3]
               	mov	x17, #0x29              // =41
               	eor	x1, x1, x17
               	cbz	w1, <addr>
               	mov	x0, #0xb                // =11
               	ret
               	ldrb	w1, [x0, #0xb]
               	mov	x17, #0x2a              // =42
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	ldrb	w0, [x0, #0xa]
               	cbz	x0, <addr>
               	mov	x0, #0xc                // =12
               	ret
               	mov	x0, #0x0                // =0
               	ret
