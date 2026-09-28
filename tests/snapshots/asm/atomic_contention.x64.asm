
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
               	movq	%rax, %r9
               	shlq	%cl, %r9
               	xorl	%r8d, %r8d
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rcx
               	leaq	<rip>, %rax
               	movl	$0x1, %edx
               	movq	%rdx, %r10
               	lock
               	xaddq	%r10, (%rax)
               	leaq	<rip>, %rax
               	movq	%rdx, %r10
               	negq	%r10
               	lock
               	xaddq	%r10, (%rax)
               	leaq	<rip>, %rax
               	movq	%rdx, %r10
               	lock
               	xaddw	%r10w, (%rax)
               	leaq	<rip>, %rsi
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
               	je	<addr>
               	testl	%esi, %esi
               	jne	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	testl	%esi, %esi
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	%rdx, %rcx
               	xchgl	%ecx, (%rax)
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	xorl	%ecx, %ecx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rax
               	movq	%rdx, %rcx
               	xchgb	%cl, (%rax)
               	testb	$-0x1, %cl
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	xorl	%ecx, %ecx
               	movb	%cl, (%rax)
               	incq	%r8
               	cmpl	$0x2710, %r8d           # imm = 0x2710
               	jl	<addr>
               	xorl	%eax, %eax
               	retq

<run_threads>:
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
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%esi, %esi
               	leaq	-0x20(%rbp), %rdi
               	leaq	-<rip>, %rdx      # <addr>
               	movq	%rsi, %rcx
               	callq	*%rbx
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x1, %ecx
               	leaq	-0x20(%rbp), %rax
               	leaq	0x8(%rax), %rdi
               	xorl	%esi, %esi
               	leaq	-<rip>, %rdx      # <addr>
               	callq	*%rbx
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x2, %ecx
               	leaq	-0x20(%rbp), %rax
               	leaq	0x10(%rax), %rdi
               	xorl	%esi, %esi
               	leaq	-<rip>, %rdx      # <addr>
               	callq	*%rbx
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x3, %ecx
               	leaq	-0x20(%rbp), %rax
               	leaq	0x18(%rax), %rdi
               	xorl	%esi, %esi
               	leaq	-<rip>, %rdx      # <addr>
               	callq	*%rbx
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rdi
               	xorl	%esi, %esi
               	callq	*%r12
               	leaq	-0x20(%rbp), %rax
               	movq	0x8(%rax), %rdi
               	xorl	%esi, %esi
               	callq	*%r12
               	leaq	-0x20(%rbp), %rax
               	movq	0x10(%rax), %rdi
               	xorl	%esi, %esi
               	callq	*%r12
               	leaq	-0x20(%rbp), %rax
               	movq	0x18(%rax), %rdi
               	xorl	%esi, %esi
               	callq	*%r12
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq

<contended>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x66, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x9c40, %rax           # imm = 0x9C40
               	je	<addr>
               	movl	$0x67, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x9c40, %rax           # imm = 0x9C40
               	je	<addr>
               	movl	$0x68, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	cmpq	$0x0, (%rax)
               	je	<addr>
               	movl	$0x69, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movswq	(%rax), %rax
               	cmpl	$0xffff9c40, %eax       # imm = 0xFFFF9C40
               	je	<addr>
               	movl	$0x6a, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	cmpl	$0x0, (%rax)
               	je	<addr>
               	movl	$0x6b, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x9c40, %rax           # imm = 0x9C40
               	je	<addr>
               	movl	$0x6c, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x9c40, %rax           # imm = 0x9C40
               	je	<addr>
               	movl	$0x6d, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	popq	%rbp
               	retq
