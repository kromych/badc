
ssa_variadic_fp_arg.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	pushq	%rax
               	leaq	<rip>, %rdi # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movb	$0x1, %al
               	callq	<addr>
               	movsd	<rip>, %xmm0 # <addr>
               	leaq	<rip>, %rdi # <addr>
               	movb	$0x1, %al
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	<rip>, %xmm1 # <addr>
               	movb	$0x2, %al
               	callq	<addr>
               	movsd	<rip>, %xmm0 # <addr>
               	ucomisd	<rip>, %xmm0 # <addr>
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%r11
               	retq
               	xorl	%eax, %eax
               	popq	%r11
               	retq
