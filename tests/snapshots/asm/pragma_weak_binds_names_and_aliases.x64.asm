
pragma_weak_binds_names_and_aliases.x64:	file format elf64-x86-64

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

<impl>:
               	movl	$0x3, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %eax
               	leaq	<rip>, %rcx      # <addr>
               	movl	(%rcx), %ecx
               	leaq	(%rax,%rcx), %rbx
               	callq	<addr>
               	addq	%rbx, %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %ecx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx      # <addr>
               	cmpq	%rcx, %rax
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %edx
               	cmpl	$0x5, %edx
               	jne	<addr>
               	cmpq	%rcx, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2, %eax
               	jmp	<addr>
