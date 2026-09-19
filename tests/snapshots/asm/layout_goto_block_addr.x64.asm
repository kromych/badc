
layout_goto_block_addr.x64:	file format elf64-x86-64

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

<dispatch>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx        # <addr>
               	movq	%rcx, (%rdx)
               	leaq	<rip>, %rcx        # <addr>
               	movq	%rcx, 0x8(%rdx)
               	movq	%rax, %rcx
               	cmpl	%edi, %eax
               	jge	<addr>
               	movq	%rax, %rsi
               	andq	$0x1, %rsi
               	movq	(%rdx,%rsi,8), %rsi
               	jmpq	*%rsi
               	addq	$0x2, %rcx
               	incq	%rax
               	jmp	<addr>
               	incq	%rcx
               	incq	%rax
               	cmpl	%edi, %eax
               	jl	<addr>
               	movslq	%ecx, %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	xorl	%edi, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x1, %edi
               	callq	<addr>
               	addq	%rax, %rbx
               	movl	$0x2, %edi
               	callq	<addr>
               	addq	%rax, %rbx
               	movl	$0x3, %edi
               	callq	<addr>
               	addq	%rax, %rbx
               	movl	$0x4, %edi
               	callq	<addr>
               	addq	%rbx, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	leave
               	retq
