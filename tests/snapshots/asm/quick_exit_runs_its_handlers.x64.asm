
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
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %ecx
               	imulq	$0xa, %rcx, %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	retq

<second>:
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %ecx
               	imulq	$0xa, %rcx, %rcx
               	addq	$0x2, %rcx
               	movl	%ecx, (%rax)
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
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x15, %eax
               	jne	<addr>
               	movl	$0x5, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	movl	$0x6, %edi
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	-<rip>, %rdi       # <addr>
               	xorl	%esi, %esi
               	movq	%rsi, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-<rip>, %rdi       # <addr>
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-<rip>, %rdi       # <addr>
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-<rip>, %rdi       # <addr>
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x3, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
