
epoll_event_array_readback.x64:	file format elf64-x86-64

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
               	subq	$0x68, %rsp
               	pushq	%rbx
               	leaq	-0x38(%rbp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x30(%rbp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x80000, %edi          # imm = 0x80000
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x18(%rsp)
               	movq	%r10, %rax
               	testl	%eax, %eax
               	jge	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	movabsq	$0x1122334455667788, %r10 # imm = 0x1122334455667788
               	movq	%r10, 0x28(%rsp)
               	movabsq	$-0x778899aabbccddef, %r10 # imm = 0x8877665544332211
               	movq	%r10, 0x20(%rsp)
               	leaq	-0x28(%rbp), %rcx
               	movl	$0x1, %esi
               	movl	%esi, -0x28(%rbp)
               	movq	0x28(%rsp), %r10
               	movq	%r10, -0x24(%rbp)
               	movl	-0x38(%rbp), %edx
               	movq	0x18(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	leaq	-0x28(%rbp), %rcx
               	movq	0x20(%rsp), %r10
               	movq	%r10, -0x24(%rbp)
               	movl	$0x1, %esi
               	movl	-0x30(%rbp), %edx
               	movq	0x18(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	movl	-0x34(%rbp), %edi
               	leaq	<rip>, %rsi
               	movl	$0x1, %edx
               	callq	<addr>
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movl	-0x2c(%rbp), %edi
               	leaq	<rip>, %rsi
               	movl	$0x1, %edx
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rsi
               	movl	$0x2, %edx
               	movl	$0x3e8, %ecx            # imm = 0x3E8
               	movq	0x18(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	movq	%rax, %rbx
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x2, %eax
               	jge	<addr>
               	leaq	-0x18(%rbp), %rdx
               	imulq	$0xc, %rax, %rcx
               	addq	%rcx, %rdx
               	movl	(%rdx), %esi
               	cmpl	$0x1, %esi
               	jne	<addr>
               	movq	0x4(%rdx), %rdx
               	cmpq	0x28(%rsp), %rdx
               	jne	<addr>
               	orq	$0x1, %rbx
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rdx
               	addq	%rdx, %rcx
               	movq	0x4(%rcx), %rcx
               	cmpq	0x20(%rsp), %rcx
               	jne	<addr>
               	orq	$0x2, %rbx
               	jmp	<addr>
               	movl	$0x8, %eax
               	jmp	<addr>
               	movl	$0x7, %eax
               	jmp	<addr>
               	movq	0x18(%rsp), %rdi
               	callq	<addr>
               	movl	-0x38(%rbp), %edi
               	callq	<addr>
               	movl	-0x34(%rbp), %edi
               	callq	<addr>
               	movl	-0x30(%rbp), %edi
               	callq	<addr>
               	movl	-0x2c(%rbp), %edi
               	callq	<addr>
               	xorl	%eax, %eax
               	movl	$0x9, %ecx
               	cmpl	$0x3, %ebx
               	cmovneq	%rcx, %rax
               	jmp	<addr>
