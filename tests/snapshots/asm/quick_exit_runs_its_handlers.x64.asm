
quick_exit_runs_its_handlers.x64:	file format elf64-x86-64

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

<first>:
               	movl	<rip>, %eax # <addr>
               	imulq	$0xa, %rax, %rax
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	retq

<second>:
               	movl	<rip>, %eax # <addr>
               	imulq	$0xa, %rax, %rax
               	addq	$0x2, %rax
               	movl	%eax, <rip> # <addr>
               	retq

<by_atexit>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x63, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2

<last>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x5, %eax
               	movl	$0x6, %ecx
               	movl	<rip>, %edx # <addr>
               	cmpl	$0x15, %edx
               	movq	%rcx, %rdi
               	cmoveq	%rax, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	-<rip>, %rdi # <addr>
               	xorl	%esi, %esi
               	movq	%rsi, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-<rip>, %rdi # <addr>
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-<rip>, %rdi # <addr>
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-<rip>, %rdi # <addr>
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x3, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
