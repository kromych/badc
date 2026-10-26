
member_qualifiers_stay_with_their_members.aarch64:	file format elf64-littleaarch64

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

<first>:
               	ldrb	w0, [x0]
               	ret

<main>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x1, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x1, [x2, #0x8]
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	str	x1, [x2]
               	ldr	x1, [x0]
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	blr	x1
               	sub	x20, x0, #0x61
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0, #0x8]
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	blr	x1
               	add	x0, x20, x0
               	sub	x0, x0, #0x62
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	ldrsw	x1, [x1]
               	add	x0, x0, x1
               	sub	x0, x0, #0x2
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
