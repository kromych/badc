
wide_string_struct_member.aarch64:	file format elf64-littleaarch64

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
               	ldrsw	x1, [x0]
               	cmp	w1, #0x5
               	b.ne	<addr>
               	ldr	w1, [x0, #0x4]
               	mov	x17, #0x68              // =104
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	ldr	w1, [x0, #0x8]
               	mov	x17, #0x69              // =105
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	ldr	w1, [x0, #0xc]
               	cbnz	w1, <addr>
               	ldr	w0, [x0, #0x10]
               	cbz	w0, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x0                // =0
               	ret
