
anon_member_brace_nesting.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rcx      # <addr>
               	leaq	<rip>, %rax      # <addr>
               	movsbq	(%rcx), %rdx
               	movsbq	(%rax), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	movsbq	0x4(%rcx), %rdx
               	movsbq	0x4(%rax), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	movsbq	0x8(%rcx), %rdx
               	movsbq	0x8(%rax), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	movl	0xc(%rcx), %edx
               	movl	0xc(%rax), %esi
               	cmpl	%esi, %edx
               	jne	<addr>
               	movsbq	0x10(%rcx), %rdx
               	movsbq	0x10(%rax), %rsi
               	cmpl	%esi, %edx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rdx      # <addr>
               	movsbq	(%rdx), %rsi
               	movsbq	(%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	movsbq	0x4(%rdx), %rsi
               	movsbq	0x4(%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	movsbq	0x8(%rdx), %rsi
               	movsbq	0x8(%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	movl	0xc(%rdx), %esi
               	movl	0xc(%rax), %edi
               	cmpl	%edi, %esi
               	jne	<addr>
               	movsbq	0x10(%rdx), %rdx
               	movsbq	0x10(%rax), %rsi
               	cmpl	%esi, %edx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rdx      # <addr>
               	movsbq	(%rdx), %rsi
               	movsbq	(%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	movsbq	0x4(%rdx), %rsi
               	movsbq	0x4(%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	movsbq	0x8(%rdx), %rsi
               	movsbq	0x8(%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	movl	0xc(%rdx), %esi
               	movl	0xc(%rax), %edi
               	cmpl	%edi, %esi
               	jne	<addr>
               	movsbq	0x10(%rdx), %rdx
               	movsbq	0x10(%rax), %rax
               	cmpl	%eax, %edx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movl	0xc(%rcx), %eax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movsbq	0x10(%rcx), %rax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %ecx
               	cmpl	$0x11111111, %ecx       # imm = 0x11111111
               	jne	<addr>
               	movl	0x4(%rax), %ecx
               	cmpl	$0x22222222, %ecx       # imm = 0x22222222
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movzbq	0x8(%rax), %rcx
               	xorq	$0x7, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	0x9(%rax), %rax
               	xorq	$0x8, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %ecx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movl	0x8(%rax), %ecx
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	movl	0xc(%rax), %ecx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movl	0x10(%rax), %eax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %ecx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	cmpq	$0x0, 0x8(%rax)
               	jne	<addr>
               	movl	0x10(%rax), %eax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %ecx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movl	0x8(%rax), %ecx
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	movl	0xc(%rax), %eax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	xorl	%eax, %eax
               	retq
