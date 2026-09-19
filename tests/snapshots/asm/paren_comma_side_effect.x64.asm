
paren_comma_side_effect.x64:	file format elf64-x86-64

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

<__c5_lazy_stream>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rax
               	cmpq	$0x0, 0x10(%rax)
               	je	<addr>
               	movq	0x10(%rax), %rax
               	popq	%rbp
               	retq
               	xorl	%edi, %edi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rax), %rax
               	movq	%rax, 0x10(%rcx)
               	leaq	<rip>, %rax
               	movq	0x10(%rax), %rax
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	leaq	<rip>, %rax
               	movl	$0x0, (%rax)
               	movl	$0x7, %ecx
               	movl	%ecx, (%rax)
               	movslq	%ecx, %rbx
               	cmpl	$0x7, %ebx
               	je	<addr>
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movq	%rbx, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, (%rax)
               	movl	$0xb, (%rax)
               	movl	$0xd, %ecx
               	movl	%ecx, (%rax)
               	movslq	%ecx, %rbx
               	cmpl	$0xd, %ebx
               	je	<addr>
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	movq	%rbx, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
