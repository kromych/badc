
warn_dead_store.aarch64:	file format elf64-littleaarch64

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

<dead_initializer>:
               	mov	x0, #0x1                // =1
               	ret

<self_referencing_rhs>:
               	mov	x0, #0x6                // =6
               	ret

<store_consumed_after_branch_is_silenced>:
               	sxtw	x1, w0
               	mov	x0, #0x1                // =1
               	cbz	x1, <addr>
               	mov	x0, #0x2                // =2
               	ret

<address_escapes_silences>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0x1                // =1
               	stur	w0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0x1                // =1
               	stur	w0, [x29, #-0x8]
               	add	x0, x0, #0x9
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
