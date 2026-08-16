
inline_asm_alternative_replacement.x64:	file format elf64-x86-64

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

<cs_inner>:
               	leaq	0x5(%rdi), %rax
               	movslq	%eax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	<rip>, %rax
               	movq	%rax, -0x20(%rbp)
               	movq	%rdi, -0x18(%rbp)
               	movq	%rax, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	movq	-0x20(%rbp), %rax
               	movq	-0x18(%rbp), %rdi
               	movl	$0x25, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%dl, 0x52(%rcx)

<cs_wrapper>:
               	pushq	%rcx
               	pushq	%rdx
               	pushq	%rsi
               	callq	<addr>
               	popq	%rsi
               	popq	%rdx
               	popq	%rcx
               	retq
               	leaq	(%rax), %rdi
