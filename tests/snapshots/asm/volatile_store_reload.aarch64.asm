
volatile_store_reload.aarch64:	file format elf64-littleaarch64

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
               	mov	x1, #0x5                // =5
               	str	w1, [x0, #0x34]
               	ldrsw	x0, [x0, #0x34]
               	mov	x1, #0x0                // =0
               	mov	x2, #0x1                // =1
               	cmp	w0, #0x5
               	csel	x0, x1, x2, eq
               	ret
