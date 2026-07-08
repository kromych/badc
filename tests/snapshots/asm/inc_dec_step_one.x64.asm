
inc_dec_step_one.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<plus_one>:
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rax
               	retq

<minus_one>:
               	leaq	-0x1(%rdi), %rax
               	movslq	%eax, %rax
               	retq

<plus_one_l>:
               	leaq	0x1(%rdi), %rax
               	retq

<minus_neg_one>:
               	leaq	0x1(%rdi), %rax
               	retq

<count_up>:
               	movslq	%edi, %rdi
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	incq	%rcx
               	movslq	%ecx, %rcx
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	%rdi, %rdx
               	jl	<addr>
               	movslq	%ecx, %rax
               	retq

<wrap>:
               	movl	%edi, %eax
               	incq	%rax
               	movl	%eax, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x2a, %edi
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
