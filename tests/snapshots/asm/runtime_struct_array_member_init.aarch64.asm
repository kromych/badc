
runtime_struct_array_member_init.aarch64:	file format elf64-littleaarch64

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
               	add	x0, x1, #0x8
               	ldrsw	x1, [x1]
               	cmp	w1, #0xa
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	cmp	x0, x0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	ldrsw	x0, [x0]
               	cmp	w0, #0x1e
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	mov	x0, #0x0                // =0
               	ret
