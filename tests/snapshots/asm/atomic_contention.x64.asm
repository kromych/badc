
atomic_contention.x64:	file format elf64-x86-64

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

<worker>:
               	movl	$0x1, %eax
               	movl	%edi, %ecx
               	shlxq	%rcx, %rax, %r9
               	xorl	%r8d, %r8d
               	leaq	<rip>, %rdi # <addr>
               	movq	(%rdi), %rcx
               	leaq	<rip>, %rax # <addr>
               	movl	$0x1, %edx
               	lock
               	addq	%rdx, (%rax)
               	leaq	<rip>, %rax # <addr>
               	lock
               	subq	%rdx, (%rax)
               	leaq	<rip>, %rax # <addr>
               	lock
               	addw	%dx, (%rax)
               	leaq	<rip>, %rsi # <addr>
               	lock
               	xorl	%r9d, (%rsi)
               	lock
               	xorl	%r9d, (%rsi)
               	leaq	0x1(%rcx), %rsi
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%rsi, (%rdi)
               	cmpq	%rcx, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	cmoveq	%rax, %rcx
               	testl	%esi, %esi
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rdx, %rcx
               	xchgl	%ecx, (%rax)
               	testl	%ecx, %ecx
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	incq	%rax
               	movq	%rax, <rip> # <addr>
               	leaq	<rip>, %rax # <addr>
               	xorl	%ecx, %ecx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rax # <addr>
               	movq	%rdx, %rcx
               	xchgb	%cl, (%rax)
               	testb	$-0x1, %cl
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	incq	%rax
               	movq	%rax, <rip> # <addr>
               	leaq	<rip>, %rax # <addr>
               	xorl	%ecx, %ecx
               	movb	%cl, (%rax)
               	incq	%r8
               	cmpl	$0x2710, %r8d           # imm = 0x2710
               	jl	<addr>
               	xorl	%eax, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	pushq	%r12
               	pushq	%rbx
               	xorl	%edi, %edi
               	movl	$0x2, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %rsi
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %rsi
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r12
               	testq	%rbx, %rbx
               	je	<addr>
               	testq	%r12, %r12
               	jne	<addr>
               	movl	$0x66, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%esi, %esi
               	leaq	-0x20(%rbp), %rdi
               	leaq	-<rip>, %rdx # <addr>
               	movq	%rsi, %rcx
               	callq	*%rbx
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, %ecx
               	leaq	-0x20(%rbp), %rax
               	leaq	0x8(%rax), %rdi
               	xorl	%esi, %esi
               	leaq	-<rip>, %rdx # <addr>
               	callq	*%rbx
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x2, %ecx
               	leaq	-0x20(%rbp), %rax
               	leaq	0x10(%rax), %rdi
               	xorl	%esi, %esi
               	leaq	-<rip>, %rdx # <addr>
               	callq	*%rbx
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x3, %ecx
               	leaq	-0x20(%rbp), %rax
               	leaq	0x18(%rax), %rdi
               	xorl	%esi, %esi
               	leaq	-<rip>, %rdx # <addr>
               	callq	*%rbx
               	testl	%eax, %eax
               	jne	<addr>
               	movq	-0x20(%rbp), %rdi
               	xorl	%esi, %esi
               	callq	*%r12
               	movq	-0x18(%rbp), %rdi
               	xorl	%esi, %esi
               	callq	*%r12
               	movq	-0x10(%rbp), %rdi
               	xorl	%esi, %esi
               	callq	*%r12
               	movq	-0x8(%rbp), %rdi
               	xorl	%esi, %esi
               	callq	*%r12
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9c40, %rax           # imm = 0x9C40
               	je	<addr>
               	movl	$0x67, %eax
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9c40, %rax           # imm = 0x9C40
               	je	<addr>
               	movl	$0x68, %eax
               	jmp	<addr>
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x69, %eax
               	jmp	<addr>
               	movswq	<rip>, %rax # <addr>
               	cmpl	$0xffff9c40, %eax       # imm = 0xFFFF9C40
               	je	<addr>
               	movl	$0x6a, %eax
               	jmp	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x6b, %eax
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9c40, %rax           # imm = 0x9C40
               	je	<addr>
               	movl	$0x6c, %eax
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9c40, %rax           # imm = 0x9C40
               	je	<addr>
               	movl	$0x6d, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
