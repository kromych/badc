
branch_fuse_short_circuit.aarch64:	file format elf64-littleaarch64

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
               	ldrsw	x0, [x0, #0x40]
               	cbz	x0, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x0, <page>
               	ldr	x4, [x0, #0x10]
               	adrp	x1, <page>
               	ldr	x5, [x1, #0x30]
               	adrp	x2, <page>
               	ldr	w6, [x2, #0x38]
               	cmn	x4, #0x1
               	b.ne	<addr>
               	cbnz	x3, <addr>
               	cbnz	x5, <addr>
               	cbnz	w6, <addr>
               	ldr	x3, [x0, #0x10]
               	ldr	x4, [x1, #0x30]
               	ldr	w4, [x2, #0x38]
               	cmp	x3, #0x64
               	b.ls	<addr>
               	ldr	x3, [x1, #0x30]
               	ldr	w3, [x2, #0x38]
               	ldr	x3, [x0, #0x10]
               	ldr	w2, [x2, #0x38]
               	cmp	x3, #0x64
               	b.ls	<addr>
               	ldr	x0, [x0, #0x10]
               	ldr	x1, [x1, #0x30]
               	cmp	x0, #0x64
               	b.ls	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x1                // =1
               	ret
               	mov	x3, #0x0                // =0
               	b	<addr>
