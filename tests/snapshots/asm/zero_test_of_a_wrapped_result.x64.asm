
zero_test_of_a_wrapped_result.x64:	file format elf64-x86-64

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

<add_nz>:
               	leaq	(%rdi,%rsi), %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<sub_z>:
               	subq	%rsi, %rdi
               	testl	%edi, %edi
               	jne	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<mul_nz>:
               	imulq	%rsi, %rdi
               	testl	%edi, %edi
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
               	imulq	%rsi, %rdi
               	testl	%edi, %edi
               	jne	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<neg_nz>:
               	movq	%rdi, %rax
               	negq	%rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<main>:
               	subq	$0x38, %rsp
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, (%rsp)
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, 0x8(%rsp)
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, 0x10(%rsp)
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, 0x18(%rsp)
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, 0x20(%rsp)
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, 0x28(%rsp)
               	movq	$-0x80000000, %rdi      # imm = 0x80000000
               	movq	(%rsp), %rax
               	movq	%rdi, %rsi
               	callq	*%rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x38, %rsp
               	retq
               	movl	$0x7fffffff, %edi       # imm = 0x7FFFFFFF
               	movl	$0x1, %esi
               	movq	(%rsp), %rax
               	callq	*%rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	$0x3, %edi
               	movq	$-0x3, %rsi
               	movq	(%rsp), %rax
               	callq	*%rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	movq	(%rsp), %rax
               	callq	*%rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x38, %rsp
               	retq
               	movq	$-0x80000000, %rdi      # imm = 0x80000000
               	movq	0x8(%rsp), %rax
               	movq	%rdi, %rsi
               	callq	*%rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movq	$-0x80000000, %rdi      # imm = 0x80000000
               	movl	$0x7fffffff, %esi       # imm = 0x7FFFFFFF
               	movq	0x8(%rsp), %rax
               	callq	*%rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x38, %rsp
               	retq
               	xorl	%edi, %edi
               	movq	$-0x80000000, %rsi      # imm = 0x80000000
               	movq	0x8(%rsp), %rax
               	callq	*%rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x38, %rsp
               	retq
               	movl	$0x10000, %edi          # imm = 0x10000
               	movq	0x10(%rsp), %rax
               	movq	%rdi, %rsi
               	callq	*%rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x3, %edi
               	movl	$0x5, %esi
               	movq	0x10(%rsp), %rax
               	callq	*%rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	xorl	%edi, %edi
               	movl	$0x7, %esi
               	movq	0x10(%rsp), %rax
               	callq	*%rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x38, %rsp
               	retq
               	movl	$0x80000000, %edi       # imm = 0x80000000
               	movq	0x18(%rsp), %rax
               	movq	%rdi, %rsi
               	callq	*%rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, %edi
               	movl	$0xffffffff, %esi       # imm = 0xFFFFFFFF
               	movq	0x18(%rsp), %rax
               	callq	*%rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x38, %rsp
               	retq
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	movq	0x18(%rsp), %rax
               	callq	*%rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x38, %rsp
               	retq
               	movl	$0x10000, %edi          # imm = 0x10000
               	movq	0x20(%rsp), %rax
               	movq	%rdi, %rsi
               	callq	*%rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	$0x3, %edi
               	movl	$0x5, %esi
               	movq	0x20(%rsp), %rax
               	callq	*%rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x38, %rsp
               	retq
               	xorl	%edi, %edi
               	movq	0x28(%rsp), %rax
               	callq	*%rax
               	testl	%eax, %eax
               	jne	<addr>
               	movq	$-0x80000000, %rdi      # imm = 0x80000000
               	movq	0x28(%rsp), %rax
               	callq	*%rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	$0x5, %edi
               	movq	0x28(%rsp), %rax
               	callq	*%rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x38, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x38, %rsp
               	retq
