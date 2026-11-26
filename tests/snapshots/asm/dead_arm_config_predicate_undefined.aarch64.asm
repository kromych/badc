
dead_arm_config_predicate_undefined.aarch64:	file format elf64-littleaarch64

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

<dispatch>:
               	ldr	x0, [x0]
               	and	x1, x0, #0x1
               	add	x1, x1, #0xa
               	tst	x0, #0x8
               	mov	x16, #0x1               // =1
               	csel	x0, x16, xzr, ne
               	add	x0, x1, x0
               	ret

<main>:
               	mov	x0, #0x0                // =0
               	ret
