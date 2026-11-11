
nested_block_decl_alignment.x64:	file format elf64-x86-64

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
               	subq	$0x40, %rsp
               	andq	$-0x40, %rsp
               	leaq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movl	$0x3, <rip> # <addr>
               	testb	$0x3f, %cl
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x3, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	leaq	<rip>, %rdx # <addr>
               	movb	$0x5, <rip> # <addr>
               	andq	$0x7f, %rdx
               	movl	$0x1, %esi
               	testl	%edx, %edx
               	movq	%rax, %rdx
               	cmoveq	%rsi, %rdx
               	addq	%rdx, %rcx
               	leaq	(%rsp), %rdx
               	movb	$0x7, (%rsp)
               	andq	$0x3f, %rdx
               	movl	$0x1, %esi
               	testl	%edx, %edx
               	movq	%rax, %rdx
               	cmoveq	%rsi, %rdx
               	addq	%rdx, %rcx
               	leaq	(%rsp), %rdx
               	movl	$0x9, (%rsp)
               	testb	$0x3f, %dl
               	jne	<addr>
               	movl	(%rsp), %eax
               	cmpl	$0x9, %eax
               	sete	%al
               	movzbq	%al, %rax
               	addq	%rcx, %rax
               	movl	$0x2a, %ecx
               	cmpl	$0x4, %eax
               	cmoveq	%rcx, %rax
               	leave
               	retq
               	movq	%rax, %rcx
               	jmp	<addr>
