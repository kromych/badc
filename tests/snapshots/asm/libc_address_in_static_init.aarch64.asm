
libc_address_in_static_init.aarch64:	file format elf64-littleaarch64

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
               	ldr	x1, [x0]
               	cbnz	x1, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldr	x0, [x0, #0x8]
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x0                // =0
               	ret
