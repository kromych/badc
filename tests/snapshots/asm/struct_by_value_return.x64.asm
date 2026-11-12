
struct_by_value_return.x64:	file format elf64-x86-64

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

<rt>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	%edi, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	leave
               	retq

<make_pair>:
               	movl	%edi, %eax
               	shlq	$0x20, %rsi
               	orq	%rsi, %rax
               	retq

<clobber>:
               	leaq	0x121589(%rdi), %rax
               	retq

<sum_pair_pair>:
               	movq	%rdi, %rax
               	shrq	$0x20, %rax
               	movq	%rsi, %rcx
               	shrq	$0x20, %rcx
               	leaq	(%rdi,%rsi), %rdx
               	addq	%rcx, %rax
               	movl	%edx, %ecx
               	shlq	$0x20, %rax
               	orq	%rcx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	$0xb, %edi
               	callq	<addr>
               	movq	%rax, 0x18(%rsp)
               	movl	$0x16, %edi
               	callq	<addr>
               	movq	%rax, 0x10(%rsp)
               	movl	$0x7, %edi
               	callq	<addr>
               	addq	$0x121589, %rax         # imm = 0x121589
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x63, %eax
               	leave
               	retq
               	movq	0x18(%rsp), %rax
               	cmpl	$0xb, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	0x10(%rsp), %rax
               	cmpl	$0x16, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0x3, %edi
               	callq	<addr>
               	movq	%rax, 0x18(%rsp)
               	movl	$0x4, %edi
               	callq	<addr>
               	movq	0x18(%rsp), %rcx
               	cmpl	$0x3, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movl	$0x64, %edi
               	callq	<addr>
               	movq	%rax, 0x18(%rsp)
               	movl	$0xc8, %edi
               	callq	<addr>
               	movq	%rax, 0x10(%rsp)
               	movl	$0x12c, %edi            # imm = 0x12C
               	callq	<addr>
               	movq	%rax, 0x8(%rsp)
               	movl	$0x190, %edi            # imm = 0x190
               	callq	<addr>
               	movq	0x18(%rsp), %rcx
               	cmpl	$0x64, %ecx
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movq	0x10(%rsp), %rcx
               	cmpl	$0xc8, %ecx
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movq	0x8(%rsp), %rcx
               	cmpl	$0x12c, %ecx            # imm = 0x12C
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	cmpl	$0x190, %eax            # imm = 0x190
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	movq	%rax, 0x18(%rsp)
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, 0x10(%rsp)
               	movl	$0x3, %edi
               	callq	<addr>
               	movq	%rax, 0x8(%rsp)
               	movl	$0x4, %edi
               	callq	<addr>
               	movq	0x18(%rsp), %rcx
               	addq	0x8(%rsp), %rcx
               	movq	%rax, %r10
               	movq	0x10(%rsp), %rax
               	addq	%r10, %rax
               	cmpl	$0x4, %ecx
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
