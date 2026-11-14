
binary_search_tree.x64:	file format elf64-x86-64

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

<insert>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r12
               	movq	%rsi, %rbx
               	testq	%r12, %r12
               	jne	<addr>
               	movl	$0x18, %edi
               	callq	<addr>
               	movq	%rbx, (%rax)
               	movq	$0x0, 0x8(%rax)
               	movq	$0x0, 0x10(%rax)
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	(%r12), %rax
               	cmpq	%rax, %rbx
               	jge	<addr>
               	movq	0x8(%r12), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x18, %edi
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%rbx, (%rcx)
               	movq	$0x0, 0x8(%rcx)
               	movq	$0x0, 0x10(%rcx)
               	movq	%rcx, 0x8(%r12)
               	movq	%r12, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	(%rcx), %rax
               	cmpq	%rax, %rbx
               	jge	<addr>
               	movq	0x8(%rcx), %rdi
               	movq	%rcx, 0x18(%rsp)
               	movq	%rbx, %rsi
               	callq	<addr>
               	movq	0x18(%rsp), %rcx
               	movq	%rax, 0x8(%rcx)
               	jmp	<addr>
               	movq	0x10(%rcx), %rdi
               	movq	%rcx, 0x18(%rsp)
               	movq	%rbx, %rsi
               	callq	<addr>
               	movq	0x18(%rsp), %rcx
               	movq	%rax, 0x10(%rcx)
               	jmp	<addr>
               	movq	0x10(%r12), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x18, %edi
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%rbx, (%rcx)
               	movq	$0x0, 0x8(%rcx)
               	movq	$0x0, 0x10(%rcx)
               	movq	%rcx, 0x10(%r12)
               	jmp	<addr>
               	movq	(%rcx), %rax
               	cmpq	%rax, %rbx
               	jge	<addr>
               	movq	0x8(%rcx), %rdi
               	movq	%rcx, 0x10(%rsp)
               	movq	%rbx, %rsi
               	callq	<addr>
               	movq	0x10(%rsp), %rcx
               	movq	%rax, 0x8(%rcx)
               	jmp	<addr>
               	movq	0x10(%rcx), %rdi
               	movq	%rcx, 0x10(%rsp)
               	movq	%rbx, %rsi
               	callq	<addr>
               	movq	0x10(%rsp), %rcx
               	movq	%rax, 0x10(%rcx)
               	jmp	<addr>

<search>:
               	testq	%rdi, %rdi
               	je	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	(%rdi), %rax
               	cmpq	%rsi, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	cmpq	%rax, %rsi
               	jge	<addr>
               	movq	0x8(%rdi), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
               	movq	(%rax), %rcx
               	cmpq	%rsi, %rcx
               	jne	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	cmpq	%rcx, %rsi
               	jge	<addr>
               	movq	0x8(%rax), %rdi
               	callq	<addr>
               	jmp	<addr>
               	movq	0x10(%rax), %rdi
               	callq	<addr>
               	jmp	<addr>
               	movq	0x10(%rdi), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
               	movq	(%rax), %rcx
               	cmpq	%rsi, %rcx
               	jne	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	cmpq	%rcx, %rsi
               	jge	<addr>
               	movq	0x8(%rax), %rdi
               	callq	<addr>
               	jmp	<addr>
               	movq	0x10(%rax), %rdi
               	callq	<addr>
               	jmp	<addr>
               	xorl	%eax, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	xorl	%edi, %edi
               	movl	$0x32, %esi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x1e, %esi
               	movq	%rbx, %rdi
               	callq	<addr>
               	movl	$0x46, %esi
               	movq	%rbx, %rdi
               	callq	<addr>
               	movl	$0x14, %esi
               	movq	%rbx, %rdi
               	callq	<addr>
               	movl	$0x28, %esi
               	movq	%rbx, %rdi
               	callq	<addr>
               	movl	$0x14, %esi
               	movq	%rbx, %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x28, %esi
               	movq	%rbx, %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x63, %esi
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
