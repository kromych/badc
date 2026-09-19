
zero_sign_extension_32bit.aarch64:	file format elf64-littleaarch64

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

<__c5_lazy_stream>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0, #0x10]
               	cbz	x1, <addr>
               	ldr	x0, [x0, #0x10]
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	cbz	x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x0, [x0]
               	str	x0, [x1, #0x10]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x10]
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x20, x0
               	mov	x17, #-0x7fffffff       // =-2147483647
               	cmp	w20, w17
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x28               // =40
               	str	w1, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x5d               // =93
               	mov	x3, #0x28               // =40
               	bl	<addr>
               	mov	x17, #-0x7fffffff       // =-2147483647
               	cmp	w20, w17
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x29               // =41
               	str	w1, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x5e               // =94
               	mov	x3, #0x29               // =41
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	cbnz	w1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	ldrsw	x0, [x0]
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
