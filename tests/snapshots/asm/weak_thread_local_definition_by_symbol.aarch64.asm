
weak_thread_local_definition_by_symbol.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<addr_t>:
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
		R_AARCH64_TLSLE_ADD_TPREL_HI12	tw
               	add	x0, x0, #0x0
		R_AARCH64_TLSLE_ADD_TPREL_LO12_NC	tw
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
		R_AARCH64_TLSLE_ADD_TPREL_HI12	tw
               	add	x0, x0, #0x0
		R_AARCH64_TLSLE_ADD_TPREL_LO12_NC	tw
               	ldr	x1, [x0]
               	add	x1, x1, #0x4
               	str	x1, [x0]
               	cmp	x1, #0x7
               	b.ne	<addr>
               	bl	<addr>
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
		R_AARCH64_TLSLE_ADD_TPREL_HI12	tw
               	add	x1, x1, #0x0
		R_AARCH64_TLSLE_ADD_TPREL_LO12_NC	tw
               	cmp	x0, x1
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
