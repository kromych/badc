
utf16_utf32_string_literals.aarch64:	file format elf64-littleaarch64

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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, x0
               	mov	x2, x0
               	mov	x1, x0
               	sub	x1, x29, #0x10
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x1]
               	ldrb	w10, [x2, #0x8]
               	strb	w10, [x1, #0x8]
               	ldrb	w10, [x2, #0x9]
               	strb	w10, [x1, #0x9]
               	ldrb	w10, [x2, #0xa]
               	strb	w10, [x1, #0xa]
               	ldrb	w10, [x2, #0xb]
               	strb	w10, [x1, #0xb]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	mov	x1, x0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
