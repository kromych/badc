
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
               	testq	%rdi, %rdi
               	jne	<addr>
               	movl	$0x18, %edi
               	movq	%rsi, (%rsp)
               	callq	<addr>
               	movq	(%rsp), %rsi
               	movq	%rsi, (%rax)
               	movq	$0x0, 0x8(%rax)
               	movq	$0x0, 0x10(%rax)
               	leave
               	retq
               	movq	(%rdi), %rax
               	cmpq	%rax, %rsi
               	jge	<addr>
               	movq	0x8(%rdi), %rax
               	movq	%rdi, 0x8(%rsp)
               	movq	%rax, %rdi
               	callq	<addr>
               	movq	0x8(%rsp), %rdi
               	movq	%rax, 0x8(%rdi)
               	movq	%rdi, %rax
               	leave
               	retq
               	movq	0x10(%rdi), %rax
               	movq	%rdi, 0x8(%rsp)
               	movq	%rax, %rdi
               	callq	<addr>
               	movq	0x8(%rsp), %rdi
               	movq	%rax, 0x10(%rdi)
               	jmp	<addr>

<search>:
               	testq	%rdi, %rdi
               	jne	<addr>
               	xorl	%eax, %eax
               	retq
               	movq	(%rdi), %rax
               	cmpq	%rsi, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	retq
               	cmpq	%rax, %rsi
               	jge	<addr>
               	movq	0x8(%rdi), %rdi
               	jmp	<addr>
               	movq	0x10(%rdi), %rdi
               	jmp	<addr>

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
