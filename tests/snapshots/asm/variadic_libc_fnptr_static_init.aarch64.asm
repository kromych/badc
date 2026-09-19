
variadic_libc_fnptr_static_init.aarch64:	file format elf64-littleaarch64

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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	x0, x29, #0x40
               	mov	x1, #0x0                // =0
               	strb	w1, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x6, [x1, #0x8]
               	mov	x1, #0x40               // =64
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, #0x2a               // =42
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x5, #0x63               // =99
               	mov	x9, x6
               	blr	x9
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<__c5_sys_snprintf>:
               	b	<addr>
