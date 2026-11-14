
sigsetjmp_restores_the_signal_mask.x64:	file format elf64-x86-64

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
               	subq	$0x90, %rsp
               	leaq	-0x80(%rbp), %rdi
               	callq	<addr>
               	leaq	-0x80(%rbp), %rdi
               	movl	$0xa, %esi
               	callq	<addr>
               	movl	$0x1, %edi
               	leaq	-0x80(%rbp), %rsi
               	xorl	%edx, %edx
               	callq	<addr>
               	leaq	-0x80(%rbp), %rdi
               	callq	<addr>
               	leaq	-0x80(%rbp), %rdi
               	movl	$0xc, %esi
               	callq	<addr>
               	movl	$0x1, %edi
               	leaq	-0x80(%rbp), %rsi
               	xorl	%edx, %edx
               	callq	<addr>
               	xorl	%edi, %edi
               	leaq	-0x80(%rbp), %rdx
               	movq	%rdi, %rsi
               	callq	<addr>
               	leaq	-0x80(%rbp), %rdi
               	movl	$0xa, %esi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	xorl	%edi, %edi
               	leaq	-0x80(%rbp), %rdx
               	movq	%rdi, %rsi
               	callq	<addr>
               	leaq	-0x80(%rbp), %rdi
               	movl	$0xc, %esi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x1, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x80(%rbp), %rdi
               	callq	<addr>
               	leaq	-0x80(%rbp), %rdi
               	movl	$0xa, %esi
               	callq	<addr>
               	xorl	%edi, %edi
               	leaq	-0x80(%rbp), %rsi
               	movq	%rdi, %rdx
               	callq	<addr>
               	xorl	%edi, %edi
               	leaq	-0x80(%rbp), %rdx
               	movq	%rdi, %rsi
               	callq	<addr>
               	leaq	-0x80(%rbp), %rdi
               	movl	$0xa, %esi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	xorl	%edi, %edi
               	leaq	-0x80(%rbp), %rdx
               	movq	%rdi, %rsi
               	callq	<addr>
               	leaq	-0x80(%rbp), %rdi
               	movl	$0xa, %esi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	xorl	%esi, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorl	%edi, %edi
               	leaq	-0x80(%rbp), %rdx
               	movq	%rdi, %rsi
               	callq	<addr>
               	leaq	-0x80(%rbp), %rdi
               	movl	$0xc, %esi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x8(%rsp)
               	leaq	-0x80(%rbp), %rdi
               	callq	<addr>
               	leaq	-0x80(%rbp), %rdi
               	movl	$0xc, %esi
               	callq	<addr>
               	movl	$0x1, %edi
               	leaq	-0x80(%rbp), %rsi
               	xorl	%edx, %edx
               	callq	<addr>
               	xorl	%eax, %eax
               	movl	$0x4, %ecx
               	movq	0x8(%rsp), %r10
               	testl	%r10d, %r10d
               	cmoveq	%rcx, %rax
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x1, %esi
               	callq	<addr>
               	ud2
               	leaq	-0x80(%rbp), %rdi
               	callq	<addr>
               	leaq	-0x80(%rbp), %rdi
               	movl	$0xc, %esi
               	callq	<addr>
               	xorl	%edi, %edi
               	leaq	-0x80(%rbp), %rsi
               	movq	%rdi, %rdx
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x1, %esi
               	callq	<addr>
               	ud2
