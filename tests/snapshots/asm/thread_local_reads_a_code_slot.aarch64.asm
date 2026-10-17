
thread_local_reads_a_code_slot.aarch64:	file format elf64-littleaarch64

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

<fb>:
               	mov	x0, #0x2                // =2
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x10
               	ldr	x1, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	cmp	x1, x2
               	b.ne	<addr>
               	ldr	x0, [x0]
               	blr	x0
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0x18
               	ldr	x1, [x1]
               	sub	x0, x0, x1
               	mov	x17, #0x86a0            // =34464
               	movk	x17, #0x1, lsl #16
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	b	<addr>
