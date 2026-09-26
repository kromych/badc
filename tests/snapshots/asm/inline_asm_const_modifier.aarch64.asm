
inline_asm_const_modifier.aarch64:	file format elf64-littleaarch64

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

<read_directive_const>:
               	b	<addr>
               	udf	#0x2a
               	adr	x16, <addr>
               	ldr	w0, [x16]
               	ret

<address_modifier>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	ret

<call_modifier>:
               	mov	x0, #0x7                // =7
               	ret

<main>:
               	b	<addr>
               	udf	#0x2a
               	adr	x16, <addr>
               	ldr	w0, [x16]
               	cmp	w0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x21
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x2a               // =42
               	ret
