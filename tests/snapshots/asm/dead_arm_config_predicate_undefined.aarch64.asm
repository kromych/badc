
dead_arm_config_predicate_undefined.aarch64:	file format elf64-littleaarch64

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

<dispatch>:
               	ldr	x0, [x0]
               	and	x1, x0, #0x1
               	add	x1, x1, #0xa
               	tst	x0, #0x8
               	mov	x2, #0x1                // =1
               	mov	x3, #0x0                // =0
               	csel	x0, x2, x3, ne
               	add	x0, x1, x0
               	ret

<main>:
               	mov	x0, #0x0                // =0
               	ret
