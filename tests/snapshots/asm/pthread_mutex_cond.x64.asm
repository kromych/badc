
pthread_mutex_cond.x64:	file format elf64-x86-64

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

<try_lock>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	testl	%ebx, %ebx
               	jne	<addr>
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%ebx, %rax
               	popq	%rbx
               	leave
               	retq

<unlock>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq

<from_thread>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, %rdx
               	leaq	-0x10(%rbp), %rdi
               	xorl	%esi, %esi
               	movq	%rsi, %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x10(%rbp), %rdi
               	leaq	-0x8(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	$-0x1, %rax
               	leave
               	retq
               	movq	-0x8(%rbp), %rax
               	leave
               	retq

<consume>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	xorl	%ebx, %ebx
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi      # <addr>
               	leaq	<rip>, %rsi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax      # <addr>
               	cmpl	$0x0, (%rax)
               	je	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %ecx
               	leaq	<rip>, %rdx      # <addr>
               	movl	(%rdx), %edx
               	addq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rax      # <addr>
               	movl	$0x0, (%rax)
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	incq	%rbx
               	cmpl	$0x3e8, %ebx            # imm = 0x3E8
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq

<wait_go>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	leaq	<rip>, %rbx      # <addr>
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi      # <addr>
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax      # <addr>
               	cmpl	$0x0, (%rax)
               	je	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %ecx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq

<ms_since>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	movq	%rsi, %rbx
               	leaq	-0x10(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	-0x10(%rbp), %rax
               	movq	(%rbx), %rcx
               	subq	%rcx, %rax
               	imulq	$0x3e8, %rax, %rcx      # imm = 0x3E8
               	movq	-0x8(%rbp), %rax
               	movq	0x8(%rbx), %rdx
               	subq	%rdx, %rax
               	movabsq	$0x431bde82d7b634db, %rsi # imm = 0x431BDE82D7B634DB
               	imulq	%rsi
               	movq	%rdx, %rax
               	sarq	$0x12, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	popq	%rbx
               	leave
               	retq

<times_out>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r12
               	movq	%rsi, %rbx
               	leaq	-0x20(%rbp), %rsi
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x20(%rbp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	-0x8(%rbp), %rax
               	addq	$0x2faf080, %rax        # imm = 0x2FAF080
               	movq	%rax, -0x8(%rbp)
               	cmpq	$0x3b9aca00, %rax       # imm = 0x3B9ACA00
               	jl	<addr>
               	movq	-0x8(%rbp), %rax
               	subq	$0x3b9aca00, %rax       # imm = 0x3B9ACA00
               	movq	%rax, -0x8(%rbp)
               	movq	-0x10(%rbp), %rax
               	incq	%rax
               	movq	%rax, -0x10(%rbp)
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rsi      # <addr>
               	leaq	-0x10(%rbp), %rdx
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpl	$0x6e, %r12d
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	-0x20(%rbp), %rsi
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	$0x32, %rax
               	setge	%al
               	movzbq	%al, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x78, %rsp
               	pushq	%rbx
               	leaq	-0x60(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x70(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x61, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x70(%rbp), %rdi
               	movl	$0x1, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x62, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi      # <addr>
               	leaq	-0x70(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x63, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x64, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x65, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x66, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-<rip>, %rdi      # <addr>
               	callq	<addr>
               	cmpl	$0x10, %eax
               	je	<addr>
               	movl	$0x67, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-<rip>, %rdi      # <addr>
               	callq	<addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x68, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x69, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6a, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-<rip>, %rdi      # <addr>
               	callq	<addr>
               	cmpl	$0x10, %eax
               	je	<addr>
               	movl	$0x6b, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6c, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-<rip>, %rdi      # <addr>
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x6d, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x6e, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x70, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi      # <addr>
               	leaq	<rip>, %rsi      # <addr>
               	leaq	-0x60(%rbp), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x6e, %rax
               	je	<addr>
               	movl	$0x71, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x72, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x73, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x70(%rbp), %rdi
               	movl	$0x2, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x75, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi      # <addr>
               	leaq	-0x70(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x76, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x77, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x23, %rax
               	je	<addr>
               	movl	$0x78, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x10, %rax
               	je	<addr>
               	movl	$0x79, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-<rip>, %rdi      # <addr>
               	callq	<addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x7a, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7b, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x7c, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7d, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x70(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7e, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x80, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x81, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-<rip>, %rdi      # <addr>
               	callq	<addr>
               	cmpl	$0x10, %eax
               	je	<addr>
               	movl	$0x82, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x83, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-<rip>, %rdi      # <addr>
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x84, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x85, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x50(%rbp), %rdi
               	xorl	%esi, %esi
               	leaq	-<rip>, %rdx      # <addr>
               	movq	%rsi, %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x88, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %ebx
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi      # <addr>
               	leaq	<rip>, %rsi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax      # <addr>
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movl	%ebx, (%rax)
               	leaq	<rip>, %rax      # <addr>
               	movl	$0x1, (%rax)
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	incq	%rbx
               	cmpl	$0x3e8, %ebx            # imm = 0x3E8
               	jle	<addr>
               	xorl	%esi, %esi
               	movq	-0x50(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x92, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x7a314, %eax          # imm = 0x7A314
               	je	<addr>
               	movl	$0x93, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%ebx, %ebx
               	leaq	-0x50(%rbp), %rax
               	movq	%rbx, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rax,%rcx), %rdi
               	xorl	%esi, %esi
               	leaq	-<rip>, %rdx      # <addr>
               	movq	%rsi, %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	incq	%rbx
               	cmpl	$0x4, %ebx
               	jl	<addr>
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movl	$0x1, (%rax)
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%ebx, %ebx
               	leaq	-0x50(%rbp), %rax
               	movq	(%rax,%rbx,8), %rdi
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	incq	%rbx
               	cmpl	$0x4, %ebx
               	jl	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x9d, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi      # <addr>
               	leaq	<rip>, %rsi      # <addr>
               	leaq	-0x60(%rbp), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x6e, %rax
               	je	<addr>
               	movl	$0xa0, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x60(%rbp), %rdx
               	movq	$0x3b9aca00, -0x58(%rbp) # imm = 0x3B9ACA00
               	leaq	<rip>, %rdi      # <addr>
               	leaq	<rip>, %rsi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x16, %rax
               	je	<addr>
               	movl	$0xa2, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%esi, %esi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0xa4, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x68(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa9, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x68(%rbp), %rdi
               	movl	$0x1, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xaa, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x30(%rbp), %rdi
               	leaq	-0x68(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xab, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x68(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xac, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x30(%rbp), %rdi
               	movl	$0x1, %esi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0xad, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x30(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xae, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x9c, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x96, %eax
               	popq	%rbx
               	leave
               	retq
