
warn_dead_store.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x0, #0x1                // =1
               	ret

<self_referencing_rhs>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0x5                // =5
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<store_consumed_after_branch_is_silenced>:
               	sxtw	x0, w0
               	mov	x2, #0x1                // =1
               	cbz	x0, <addr>
               	mov	x2, #0x2                // =2
               	sxtw	x0, w2
               	ret
               	b	<addr>

<address_escapes_silences>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0x1                // =1
               	stur	w0, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x20, [sp]
               	mov	x0, #0x1                // =1
               	mov	x1, #0x5                // =5
               	add	x1, x1, #0x1
               	add	x20, x0, x1
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	add	x20, x20, x0
               	bl	<addr>
               	add	x0, x20, x0
               	sxtw	x0, w0
               	ldr	x20, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
