
variadic_cast_fnptr_dispatch.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x310              // =784
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	x19, [sp, #-0x90]!
               	stp	x29, x30, [sp, #0x80]
               	add	x29, sp, #0x80
               	sub	x0, x29, #0x20
               	mov	x1, #0x0                // =0
               	strb	w1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	sub	x1, x29, #0x20
               	mov	x2, #0x20               // =32
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x4, #0x4                // =4
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x6, #0x9                // =9
               	mov	x9, x0
               	mov	x0, x1
               	mov	x1, x2
               	mov	x2, x3
               	mov	x3, x4
               	mov	x4, x5
               	mov	x5, x6
               	blr	x9
               	sxtw	x0, w0
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp], #0x90
               	ret
               	sub	x0, x29, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp], #0x90
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp], #0x90
               	ret

<__c5_sys_snprintf>:
               	b	<addr>
