
ssa_variadic_fp_arg.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rdi # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movb	$0x1, %al
               	callq	<addr>
               	movabsq	$0x407f900000000000, %rax # imm = 0x407F900000000000
               	leaq	<rip>, %rdi # <addr>
               	movq	%rax, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	<rip>, %xmm1 # <addr>
               	movb	$0x2, %al
               	callq	<addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movabsq	$0x407f900000000000, %rax # imm = 0x407F900000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
