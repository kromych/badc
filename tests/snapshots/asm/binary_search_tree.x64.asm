
binary_search_tree.x64:	file format elf64-x86-64

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

<insert>:
               	subq	$0x18, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	testq	%rbx, %rbx
               	jne	<addr>
               	movl	$0x18, %edi
               	callq	<addr>
               	movq	%r12, (%rax)
               	movq	$0x0, 0x8(%rax)
               	movq	$0x0, 0x10(%rax)
               	popq	%rbx
               	popq	%r12
               	addq	$0x18, %rsp
               	retq
               	movq	(%rbx), %rax
               	cmpq	%rax, %r12
               	jge	<addr>
               	movq	0x8(%rbx), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x18, %edi
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r12, (%rcx)
               	movq	$0x0, 0x8(%rcx)
               	movq	$0x0, 0x10(%rcx)
               	movq	%rcx, 0x8(%rbx)
               	movq	%rbx, %rax
               	popq	%rbx
               	popq	%r12
               	addq	$0x18, %rsp
               	retq
               	movq	(%rcx), %rax
               	cmpq	%rax, %r12
               	jge	<addr>
               	movq	0x8(%rcx), %rdi
               	movq	%rcx, 0x18(%rsp)
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	0x18(%rsp), %rcx
               	movq	%rax, 0x8(%rcx)
               	jmp	<addr>
               	movq	0x10(%rcx), %rdi
               	movq	%rcx, 0x18(%rsp)
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	0x18(%rsp), %rcx
               	movq	%rax, 0x10(%rcx)
               	jmp	<addr>
               	movq	0x10(%rbx), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x18, %edi
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r12, (%rcx)
               	movq	$0x0, 0x8(%rcx)
               	movq	$0x0, 0x10(%rcx)
               	movq	%rcx, 0x10(%rbx)
               	jmp	<addr>
               	movq	(%rcx), %rax
               	cmpq	%rax, %r12
               	jge	<addr>
               	movq	0x8(%rcx), %rdi
               	movq	%rcx, 0x18(%rsp)
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	0x18(%rsp), %rcx
               	movq	%rax, 0x8(%rcx)
               	jmp	<addr>
               	movq	0x10(%rcx), %rdi
               	movq	%rcx, 0x18(%rsp)
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	0x18(%rsp), %rcx
               	movq	%rax, 0x10(%rcx)
               	jmp	<addr>

<search>:
               	testq	%rdi, %rdi
               	je	<addr>
               	pushq	%rax
               	movq	(%rdi), %rax
               	cmpq	%rsi, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	popq	%r11
               	retq
               	cmpq	%rax, %rsi
               	jge	<addr>
               	movq	0x8(%rdi), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%r11
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
               	popq	%r11
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
               	subq	$0x10, %rsp
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
               	addq	$0x10, %rsp
               	retq
               	movl	$0x28, %esi
               	movq	%rbx, %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	addq	$0x10, %rsp
               	retq
               	movl	$0x63, %esi
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	addq	$0x10, %rsp
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	addq	$0x10, %rsp
               	retq
