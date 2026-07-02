
inline_multi_block_result_forward.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<helper_one>:
               	leaq	(%rdi,%rdi), %rax
               	movslq	%eax, %rax
               	retq

<helper_two>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %rdi
               	movq	%rdi, %rax
               	shlq	$0x1, %rax
               	movslq	%eax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<test>:
               	movslq	%edi, %rdi
               	jmp	<addr>
               	leaq	(%rdi,%rdi), %rdx
               	cmpq	$0x3, %rdi
               	jle	<addr>
               	movslq	%ecx, %rax
               	retq
               	leaq	(%rcx,%rdx), %rax
               	movslq	%eax, %rax
               	retq
               	movslq	%edi, %rax
               	shlq	$0x1, %rax
               	movslq	%eax, %rcx
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x5, %edi
               	popq	%rbp
               	jmp	<addr>
               	addb	%al, (%rax)
