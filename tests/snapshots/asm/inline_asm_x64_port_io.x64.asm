
inline_asm_x64_port_io.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<port_out_bytes>:
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movq	%rsi, %rcx
               	movq	%rdi, %rsi
               	rep		outsb	(%rsi), %dx
               	retq

<port_out_words>:
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movq	%rsi, %rcx
               	movq	%rdi, %rsi
               	rep		outsw	(%rsi), %dx
               	retq

<port_out_dwords>:
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movq	%rsi, %rcx
               	movq	%rdi, %rsi
               	rep		outsl	(%rsi), %dx
               	retq

<port_in_bytes>:
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movq	%rsi, %rcx
               	rep		insb	%dx, %es:(%rdi)
               	retq

<port_in_words>:
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movq	%rsi, %rcx
               	rep		insw	%dx, %es:(%rdi)
               	retq

<port_in_dwords>:
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movq	%rsi, %rcx
               	rep		insl	%dx, %es:(%rdi)
               	retq

<port_out_one>:
               	movq	%rsi, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movq	%rdi, %rsi
               	outsb	(%rsi), %dx
               	retq

<port_in_one>:
               	movq	%rsi, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	insb	%dx, %es:(%rdi)
               	retq

<main>:
               	xorl	%eax, %eax
               	retq
