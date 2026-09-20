
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
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cbz	x0, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x4, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x5, [x1]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	w6, [x2]
               	mov	x17, #-0x1              // =-1
               	cmp	x4, x17
               	b.ne	<addr>
               	cbnz	x3, <addr>
               	cbnz	x5, <addr>
               	cbnz	w6, <addr>
               	ldr	x3, [x0]
               	ldr	x4, [x1]
               	ldr	w4, [x2]
               	mov	x17, #-0x1              // =-1
               	cmp	x3, x17
               	cmp	x3, #0x64
               	b.ls	<addr>
               	ldr	x3, [x1]
               	ldr	w3, [x2]
               	ldr	x3, [x0]
               	ldr	w2, [x2]
               	mov	x17, #-0x1              // =-1
               	cmp	x3, x17
               	cmp	x3, #0x64
               	b.ls	<addr>
               	ldr	x0, [x0]
               	ldr	x1, [x1]
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.ne	<addr>
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
               	cmp	x4, #0x64
               	mov	x0, #0x1                // =1
               	ret
               	mov	x3, #0x0                // =0
               	b	<addr>
