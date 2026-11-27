
branch_fuse_short_circuit.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
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
               	ldrsw	x0, [x0, #0x3c]
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x2, <page>
               	ldr	x4, [x2, #0x10]
               	adrp	x3, <page>
               	ldr	x5, [x3, #0x30]
               	adrp	x1, <page>
               	ldr	w6, [x1, #0x38]
               	cmn	x4, #0x1
               	b.ne	<addr>
               	cbnz	x0, <addr>
               	cbnz	x5, <addr>
               	cbnz	w6, <addr>
               	ldr	x0, [x2, #0x10]
               	ldr	x4, [x3, #0x30]
               	ldr	w4, [x1, #0x38]
               	cmp	x0, #0x64
               	b.ls	<addr>
               	ldr	x0, [x3, #0x30]
               	ldr	w0, [x1, #0x38]
               	ldr	x0, [x2, #0x10]
               	ldr	w1, [x1, #0x38]
               	cmp	x0, #0x64
               	b.ls	<addr>
               	ldr	x0, [x2, #0x10]
               	ldr	x1, [x3, #0x30]
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
               	mov	x0, #0x0                // =0
               	b	<addr>
