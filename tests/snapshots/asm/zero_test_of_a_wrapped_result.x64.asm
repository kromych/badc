
zero_test_of_a_wrapped_result.x64:	file format elf64-x86-64

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

<add_nz>:
               	leaq	(%rdi,%rsi), %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<sub_z>:
               	movq	%rdi, %rax
               	subq	%rsi, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<mul_nz>:
               	movq	%rdi, %rax
               	imulq	%rsi, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<uadd_nz>:
               	leaq	(%rdi,%rsi), %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<umul_z>:
               	movq	%rdi, %rax
               	imulq	%rsi, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<neg_nz>:
               	imulq	$-0x1, %rdi, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	-<rip>, %rax       # <addr>
               	movq	%rax, -0x30(%rbp)
               	leaq	-<rip>, %rax       # <addr>
               	movq	%rax, -0x28(%rbp)
               	leaq	-<rip>, %rax       # <addr>
               	movq	%rax, -0x20(%rbp)
               	leaq	-<rip>, %rax       # <addr>
               	movq	%rax, -0x18(%rbp)
               	leaq	-<rip>, %rax       # <addr>
               	movq	%rax, -0x10(%rbp)
               	leaq	-<rip>, %rax       # <addr>
               	movq	%rax, -0x8(%rbp)
               	movq	$-0x80000000, %rdi      # imm = 0x80000000
               	movq	-0x30(%rbp), %rax
               	movq	%rdi, %rsi
               	callq	*%rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0x7fffffff, %edi       # imm = 0x7FFFFFFF
               	movl	$0x1, %esi
               	movq	-0x30(%rbp), %rax
               	callq	*%rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	$0x3, %edi
               	movq	$-0x3, %rsi
               	movq	-0x30(%rbp), %rax
               	callq	*%rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	movq	-0x30(%rbp), %rax
               	callq	*%rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movq	$-0x80000000, %rdi      # imm = 0x80000000
               	movq	-0x28(%rbp), %rax
               	movq	%rdi, %rsi
               	callq	*%rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movq	$-0x80000000, %rdi      # imm = 0x80000000
               	movl	$0x7fffffff, %esi       # imm = 0x7FFFFFFF
               	movq	-0x28(%rbp), %rax
               	callq	*%rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	xorl	%edi, %edi
               	movq	$-0x80000000, %rsi      # imm = 0x80000000
               	movq	-0x28(%rbp), %rax
               	callq	*%rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movl	$0x10000, %edi          # imm = 0x10000
               	movq	-0x20(%rbp), %rax
               	movq	%rdi, %rsi
               	callq	*%rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x3, %edi
               	movl	$0x5, %esi
               	movq	-0x20(%rbp), %rax
               	callq	*%rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	xorl	%edi, %edi
               	movl	$0x7, %esi
               	movq	-0x20(%rbp), %rax
               	callq	*%rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movl	$0x80000000, %edi       # imm = 0x80000000
               	movq	-0x18(%rbp), %rax
               	movq	%rdi, %rsi
               	callq	*%rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, %edi
               	movl	$0xffffffff, %esi       # imm = 0xFFFFFFFF
               	movq	-0x18(%rbp), %rax
               	callq	*%rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	movq	-0x18(%rbp), %rax
               	callq	*%rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movl	$0x10000, %edi          # imm = 0x10000
               	movq	-0x10(%rbp), %rax
               	movq	%rdi, %rsi
               	callq	*%rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	$0x3, %edi
               	movl	$0x5, %esi
               	movq	-0x10(%rbp), %rax
               	callq	*%rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	xorl	%edi, %edi
               	movq	-0x8(%rbp), %rax
               	callq	*%rax
               	testl	%eax, %eax
               	jne	<addr>
               	movq	$-0x80000000, %rdi      # imm = 0x80000000
               	movq	-0x8(%rbp), %rax
               	callq	*%rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	$0x5, %edi
               	movq	-0x8(%rbp), %rax
               	callq	*%rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
