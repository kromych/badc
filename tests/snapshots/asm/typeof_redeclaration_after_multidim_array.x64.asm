
typeof_redeclaration_after_multidim_array.x64:	file format elf64-x86-64

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
               	movq	$0x7, <rip> # <addr>
               	movq	$0x9, <rip> # <addr>
               	movl	$0x5, %eax
               	movl	%eax, <rip> # <addr>
               	movl	$0x6, %ecx
               	movl	%ecx, <rip> # <addr>
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x8, <rip> # <addr>
               	movq	<rip>, %rdx # <addr>
               	cmpq	$0x7, %rdx
               	jne	<addr>
               	movq	<rip>, %rdx # <addr>
               	cmpq	$0x9, %rdx
               	jne	<addr>
               	movl	<rip>, %edx # <addr>
               	cmpl	$0x5, %edx
               	je	<addr>
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x6, %eax
               	jne	<addr>
               	leaq	0x10(%rsi), %rax
               	subq	%rsi, %rax
               	movq	%rax, %rdx
               	sarq	$0x3f, %rdx
               	shrq	$0x3e, %rdx
               	addq	%rdx, %rax
               	sarq	$0x2, %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movq	%rcx, %rax
               	retq
               	xorl	%eax, %eax
               	retq
