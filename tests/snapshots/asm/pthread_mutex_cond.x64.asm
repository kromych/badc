
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
               	subq	$0x10, %rsp
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movq	%rcx, 0x8(%rsp)
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	0x8(%rsp), %rcx
               	movslq	%ecx, %rax
               	leave
               	retq

<unlock>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq

<consume>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	xorl	%ebx, %ebx
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	<rip>, %ecx # <addr>
               	addq	%rcx, %rax
               	movl	%eax, <rip> # <addr>
               	movl	$0x0, <rip> # <addr>
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
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
               	leaq	<rip>, %rbx # <addr>
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xc0, %rsp
               	leaq	-0x90(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0xa0(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x61, %eax
               	leave
               	retq
               	leaq	-0xa0(%rbp), %rdi
               	movl	$0x1, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x62, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	leaq	-0xa0(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x63, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x64, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x65, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x66, %eax
               	leave
               	retq
               	leaq	-<rip>, %rdx # <addr>
               	leaq	-0x78(%rbp), %rdi
               	xorl	%esi, %esi
               	movq	%rsi, %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x78(%rbp), %rdi
               	leaq	-0x80(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x67, %eax
               	leave
               	retq
               	movq	-0x80(%rbp), %rax
               	cmpl	$0x10, %eax
               	jne	<addr>
               	leaq	-<rip>, %rdx # <addr>
               	leaq	-0x78(%rbp), %rdi
               	xorl	%esi, %esi
               	movq	%rsi, %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x78(%rbp), %rdi
               	leaq	-0x80(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x68, %eax
               	leave
               	retq
               	movq	-0x80(%rbp), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x69, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6a, %eax
               	leave
               	retq
               	leaq	-<rip>, %rdx # <addr>
               	leaq	-0x78(%rbp), %rdi
               	xorl	%esi, %esi
               	movq	%rsi, %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x78(%rbp), %rdi
               	leaq	-0x80(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6b, %eax
               	leave
               	retq
               	movq	-0x80(%rbp), %rax
               	cmpl	$0x10, %eax
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6c, %eax
               	leave
               	retq
               	leaq	-<rip>, %rdx # <addr>
               	leaq	-0x78(%rbp), %rdi
               	xorl	%esi, %esi
               	movq	%rsi, %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x78(%rbp), %rdi
               	leaq	-0x80(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6d, %eax
               	leave
               	retq
               	movq	-0x80(%rbp), %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x6e, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x70, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi # <addr>
               	leaq	-0x90(%rbp), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x6e, %rax
               	je	<addr>
               	movl	$0x71, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x72, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x73, %eax
               	leave
               	retq
               	leaq	-0xa0(%rbp), %rdi
               	movl	$0x2, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x75, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	leaq	-0xa0(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x76, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x77, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x23, %rax
               	je	<addr>
               	movl	$0x78, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x10, %rax
               	je	<addr>
               	movl	$0x79, %eax
               	leave
               	retq
               	leaq	-<rip>, %rdx # <addr>
               	leaq	-0x78(%rbp), %rdi
               	xorl	%esi, %esi
               	movq	%rsi, %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x78(%rbp), %rdi
               	leaq	-0x80(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7a, %eax
               	leave
               	retq
               	movq	-0x80(%rbp), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7b, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x7c, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7d, %eax
               	leave
               	retq
               	leaq	-0xa0(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7e, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x80, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x81, %eax
               	leave
               	retq
               	leaq	-<rip>, %rdx # <addr>
               	leaq	-0x78(%rbp), %rdi
               	xorl	%esi, %esi
               	movq	%rsi, %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x78(%rbp), %rdi
               	leaq	-0x80(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x82, %eax
               	leave
               	retq
               	movq	-0x80(%rbp), %rax
               	cmpl	$0x10, %eax
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x83, %eax
               	leave
               	retq
               	leaq	-<rip>, %rdx # <addr>
               	leaq	-0x78(%rbp), %rdi
               	xorl	%esi, %esi
               	movq	%rsi, %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x78(%rbp), %rdi
               	leaq	-0x80(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x84, %eax
               	leave
               	retq
               	movq	-0x80(%rbp), %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x85, %eax
               	leave
               	retq
               	leaq	-0x50(%rbp), %rdi
               	xorl	%esi, %esi
               	leaq	-<rip>, %rdx # <addr>
               	movq	%rsi, %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x88, %eax
               	leave
               	retq
               	movl	$0x1, %r10d
               	movq	%r10, 0x18(%rsp)
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movq	0x18(%rsp), %r11
               	movl	%r11d, <rip> # <addr>
               	movl	$0x1, <rip> # <addr>
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	0x18(%rsp), %r10
               	incq	%r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x18(%rsp), %rax
               	cmpl	$0x3e8, %eax            # imm = 0x3E8
               	jle	<addr>
               	xorl	%esi, %esi
               	movq	-0x50(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x92, %eax
               	leave
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x7a314, %eax          # imm = 0x7A314
               	je	<addr>
               	movl	$0x93, %eax
               	leave
               	retq
               	xorl	%ecx, %ecx
               	leaq	-0x50(%rbp), %rax
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	leaq	(%rax,%rdx), %rdi
               	xorl	%esi, %esi
               	leaq	-<rip>, %rdx # <addr>
               	movq	%rcx, 0x10(%rsp)
               	movq	%rsi, %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	0x10(%rsp), %rcx
               	testq	%rax, %rax
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x1, <rip> # <addr>
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%ecx, %ecx
               	leaq	-0x50(%rbp), %rax
               	movq	(%rax,%rcx,8), %rdi
               	xorl	%esi, %esi
               	movq	%rcx, 0x8(%rsp)
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	0x8(%rsp), %rcx
               	testq	%rax, %rax
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x9d, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi # <addr>
               	leaq	-0x90(%rbp), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x6e, %rax
               	je	<addr>
               	movl	$0xa0, %eax
               	leave
               	retq
               	leaq	-0x90(%rbp), %rdx
               	movq	$0x3b9aca00, -0x88(%rbp) # imm = 0x3B9ACA00
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x16, %rax
               	je	<addr>
               	movl	$0xa2, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%edi, %edi
               	leaq	-0x70(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x60(%rbp), %rax
               	leaq	-0x70(%rbp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	-0x68(%rbp), %rax
               	addq	$0x2faf080, %rax        # imm = 0x2FAF080
               	movq	%rax, -0x58(%rbp)
               	cmpq	$0x3b9aca00, %rax       # imm = 0x3B9ACA00
               	jl	<addr>
               	movq	-0x58(%rbp), %rax
               	subq	$0x3b9aca00, %rax       # imm = 0x3B9ACA00
               	movq	%rax, -0x58(%rbp)
               	movq	-0x60(%rbp), %rax
               	incq	%rax
               	movq	%rax, -0x60(%rbp)
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rsi # <addr>
               	leaq	-0x60(%rbp), %rdx
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	0x18(%rsp), %rax
               	cmpl	$0x6e, %eax
               	jne	<addr>
               	xorl	%edi, %edi
               	leaq	-0x80(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	-0x80(%rbp), %rax
               	movq	-0x70(%rbp), %rcx
               	subq	%rcx, %rax
               	imulq	$0x3e8, %rax, %rcx      # imm = 0x3E8
               	movq	-0x78(%rbp), %rax
               	movq	-0x68(%rbp), %rdx
               	subq	%rdx, %rax
               	movabsq	$0x431bde82d7b634db, %rsi # imm = 0x431BDE82D7B634DB
               	imulq	%rsi
               	sarq	$0x12, %rdx
               	movq	%rdx, %rax
               	shrq	$0x3f, %rax
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	cmpq	$0x32, %rax
               	jge	<addr>
               	movl	$0xa4, %eax
               	leave
               	retq
               	leaq	-0x98(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa9, %eax
               	leave
               	retq
               	leaq	-0x98(%rbp), %rdi
               	movl	$0x1, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xaa, %eax
               	leave
               	retq
               	leaq	-0x30(%rbp), %rdi
               	leaq	-0x98(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xab, %eax
               	leave
               	retq
               	leaq	-0x98(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xac, %eax
               	leave
               	retq
               	movl	$0x1, %edi
               	leaq	-0x70(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x60(%rbp), %rax
               	leaq	-0x70(%rbp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	-0x68(%rbp), %rax
               	addq	$0x2faf080, %rax        # imm = 0x2FAF080
               	movq	%rax, -0x58(%rbp)
               	cmpq	$0x3b9aca00, %rax       # imm = 0x3B9ACA00
               	jl	<addr>
               	movq	-0x58(%rbp), %rax
               	subq	$0x3b9aca00, %rax       # imm = 0x3B9ACA00
               	movq	%rax, -0x58(%rbp)
               	movq	-0x60(%rbp), %rax
               	incq	%rax
               	movq	%rax, -0x60(%rbp)
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rsi # <addr>
               	leaq	-0x60(%rbp), %rdx
               	leaq	-0x30(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	0x18(%rsp), %rax
               	cmpl	$0x6e, %eax
               	jne	<addr>
               	movl	$0x1, %edi
               	leaq	-0x80(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	-0x80(%rbp), %rax
               	movq	-0x70(%rbp), %rcx
               	subq	%rcx, %rax
               	imulq	$0x3e8, %rax, %rcx      # imm = 0x3E8
               	movq	-0x78(%rbp), %rax
               	movq	-0x68(%rbp), %rdx
               	subq	%rdx, %rax
               	movabsq	$0x431bde82d7b634db, %rsi # imm = 0x431BDE82D7B634DB
               	imulq	%rsi
               	sarq	$0x12, %rdx
               	movq	%rdx, %rax
               	shrq	$0x3f, %rax
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	cmpq	$0x32, %rax
               	jge	<addr>
               	movl	$0xad, %eax
               	leave
               	retq
               	leaq	-0x30(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xae, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x9c, %eax
               	leave
               	retq
               	movl	$0x96, %eax
               	leave
               	retq
