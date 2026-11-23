
ternary_middle_comma.x64:	file format elf64-x86-64

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

<rt>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	%edi, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	movl	$0x2a, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	cmpl	$0x80, %ebx
               	jae	<addr>
               	movq	%rbx, %rdx
               	andq	$0xff, %rdx
               	movl	$0x1, %esi
               	cmpl	$0x2a, %edx
               	je	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%edi, %edi
               	callq	<addr>
               	movq	%rax, 0x18(%rsp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movq	%rax, 0x10(%rsp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movq	%rax, %r8
               	testl	%ebx, %ebx
               	jle	<addr>
               	movl	$0xc8, %edi
               	callq	<addr>
               	cmpl	$0x80, %eax
               	jae	<addr>
               	movq	%rax, %rdx
               	andq	$0xff, %rdx
               	leaq	<rip>, %rdi
               	movl	$0x1, %esi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movq	$-0x1, %rsi
               	movq	0x18(%rsp), %rdx
               	movq	0x10(%rsp), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x63, %esi
               	xorl	%edx, %edx
               	jmp	<addr>
