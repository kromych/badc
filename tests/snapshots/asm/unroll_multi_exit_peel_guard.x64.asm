
unroll_multi_exit_peel_guard.x64:	file format elf64-x86-64

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

<tier_idx>:
               	movl	$0x3, %eax
               	retq

<tier_span>:
               	xorl	%eax, %eax
               	leaq	<rip>, %rdx # <addr>
               	movq	%rax, %rcx
               	movq	(%rdx,%rax,8), %rsi
               	addq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x3, %eax
               	jle	<addr>
               	movq	%rcx, %rax
               	imulq	%rdi, %rax
               	retq

<walk>:
               	xorl	%ecx, %ecx
               	movq	<rip>, %rax # <addr>
               	imulq	%rdi, %rax
               	movq	<rip>, %rdx # <addr>
               	testq	%rdx, %rdx
               	jge	<addr>
               	addq	%rcx, %rax
               	retq
               	movl	$0x1, %ecx
               	movq	<rip>, %rdx # <addr>
               	imulq	$0xa, %rdx, %rdx
               	imulq	%rdi, %rdx
               	addq	%rdx, %rax
               	movq	<rip>, %rdx # <addr>
               	testq	%rdx, %rdx
               	jl	<addr>
               	movl	$0x2, %ecx
               	movq	<rip>, %rdx # <addr>
               	imulq	$0x64, %rdx, %rdx
               	imulq	%rdi, %rdx
               	addq	%rdx, %rax
               	movq	<rip>, %rdx # <addr>
               	testq	%rdx, %rdx
               	jl	<addr>
               	movl	$0x3, %ecx
               	movq	<rip>, %rdx # <addr>
               	imulq	$0x3e8, %rdx, %rdx      # imm = 0x3E8
               	imulq	%rdi, %rdx
               	addq	%rdx, %rax
               	movq	<rip>, %rdx # <addr>
               	testq	%rdx, %rdx
               	jl	<addr>
               	movl	$0x4, %ecx
               	jmp	<addr>

<scan>:
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	testq	%rcx, %rcx
               	jge	<addr>
               	xorq	$-0x1, %rax
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rdi, %rcx
               	jge	<addr>
               	retq
               	movq	<rip>, %rcx # <addr>
               	testq	%rcx, %rcx
               	jl	<addr>
               	movq	<rip>, %rcx # <addr>
               	imulq	$0xa, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rdi, %rcx
               	jl	<addr>
               	movq	<rip>, %rcx # <addr>
               	testq	%rcx, %rcx
               	jl	<addr>
               	movq	<rip>, %rcx # <addr>
               	imulq	$0x64, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rdi, %rcx
               	jl	<addr>
               	movq	<rip>, %rcx # <addr>
               	testq	%rcx, %rcx
               	jl	<addr>
               	movq	<rip>, %rcx # <addr>
               	imulq	$0x3e8, %rcx, %rcx      # imm = 0x3E8
               	addq	%rcx, %rax
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rdi, %rcx
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movl	$0x1, %edi
               	movq	%rdi, <rip> # <addr>
               	movq	$0x2, <rip> # <addr>
               	movq	$0x3, <rip> # <addr>
               	movq	$0x4, <rip> # <addr>
               	movq	%rdi, <rip> # <addr>
               	movq	%rdi, <rip> # <addr>
               	movq	%rdi, <rip> # <addr>
               	movq	%rdi, <rip> # <addr>
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	movl	<rip>, %esi # <addr>
               	cmpl	%esi, %ecx
               	jge	<addr>
               	leaq	<rip>, %rsi # <addr>
               	movq	(%rsi,%rcx,8), %rdi
               	leaq	<rip>, %r8 # <addr>
               	cmpl	$0x3, %ecx
               	jge	<addr>
               	movq	%rcx, %rsi
               	movq	(%r8,%rsi,8), %rsi
               	imulq	%rdi, %rsi
               	addq	%rsi, %rdx
               	leaq	<rip>, %rsi # <addr>
               	movq	(%rsi,%rcx,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	jmp	<addr>
               	movl	$0x3, %esi
               	jmp	<addr>
               	incq	%rcx
               	movl	<rip>, %esi # <addr>
               	cmpl	%esi, %ecx
               	jl	<addr>
               	addq	%rdx, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2, %edi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	movl	<rip>, %esi # <addr>
               	cmpl	%esi, %ecx
               	jge	<addr>
               	leaq	<rip>, %rsi # <addr>
               	movq	(%rsi,%rcx,8), %rdi
               	leaq	<rip>, %r8 # <addr>
               	cmpl	$0x3, %ecx
               	jge	<addr>
               	movq	%rcx, %rsi
               	movq	(%r8,%rsi,8), %rsi
               	imulq	%rdi, %rsi
               	shlq	%rsi
               	addq	%rsi, %rdx
               	leaq	<rip>, %rsi # <addr>
               	movq	(%rsi,%rcx,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	jmp	<addr>
               	movl	$0x3, %esi
               	jmp	<addr>
               	incq	%rcx
               	movl	<rip>, %esi # <addr>
               	cmpl	%esi, %ecx
               	jl	<addr>
               	addq	%rdx, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movl	$0x3, %ebx
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	movl	<rip>, %esi # <addr>
               	cmpl	%esi, %ecx
               	jge	<addr>
               	leaq	<rip>, %rsi # <addr>
               	movq	(%rsi,%rcx,8), %rdi
               	leaq	<rip>, %r8 # <addr>
               	cmpl	$0x3, %ecx
               	jge	<addr>
               	movq	%rcx, %rsi
               	movq	(%r8,%rsi,8), %rsi
               	imulq	%rdi, %rsi
               	imulq	%rbx, %rsi
               	addq	%rsi, %rdx
               	leaq	<rip>, %rsi # <addr>
               	movq	(%rsi,%rcx,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	jmp	<addr>
               	movl	$0x3, %esi
               	jmp	<addr>
               	incq	%rcx
               	movl	<rip>, %esi # <addr>
               	cmpl	%esi, %ecx
               	jl	<addr>
               	addq	%rdx, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	$-0x2, %rbx
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	movl	<rip>, %edx # <addr>
               	cmpl	%edx, %ecx
               	jge	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movq	(%rdi,%rcx,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	leaq	<rip>, %r8 # <addr>
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r8
               	movq	(%r8), %r8
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	imulq	%r8, %rdi
               	addq	%rdi, %rsi
               	leaq	<rip>, %rdi # <addr>
               	addq	%rdi, %rdx
               	movq	(%rdx), %rdx
               	cmpq	%rbx, %rdx
               	jl	<addr>
               	incq	%rcx
               	movl	<rip>, %edx # <addr>
               	cmpl	%edx, %ecx
               	jl	<addr>
               	cmpq	%rsi, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	$-0x1, %rbx
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	movl	<rip>, %edx # <addr>
               	cmpl	%edx, %ecx
               	jge	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movq	(%rdi,%rcx,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	leaq	<rip>, %r8 # <addr>
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r8
               	movq	(%r8), %r8
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	imulq	%r8, %rdi
               	addq	%rdi, %rsi
               	leaq	<rip>, %rdi # <addr>
               	addq	%rdi, %rdx
               	movq	(%rdx), %rdx
               	cmpq	%rbx, %rdx
               	jl	<addr>
               	incq	%rcx
               	movl	<rip>, %edx # <addr>
               	cmpl	%edx, %ecx
               	jl	<addr>
               	cmpq	%rsi, %rax
               	jne	<addr>
               	xorl	%edi, %edi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	movl	<rip>, %edx # <addr>
               	cmpl	%edx, %ecx
               	jge	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movq	(%rdi,%rcx,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	leaq	<rip>, %r8 # <addr>
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r8
               	movq	(%r8), %r8
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	imulq	%r8, %rdi
               	addq	%rdi, %rsi
               	leaq	<rip>, %rdi # <addr>
               	addq	%rdi, %rdx
               	movq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	incq	%rcx
               	movl	<rip>, %edx # <addr>
               	cmpl	%edx, %ecx
               	jl	<addr>
               	cmpq	%rsi, %rax
               	jne	<addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	movl	<rip>, %edx # <addr>
               	cmpl	%edx, %ecx
               	jge	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movq	(%rdi,%rcx,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	leaq	<rip>, %r8 # <addr>
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r8
               	movq	(%r8), %r8
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	imulq	%r8, %rdi
               	addq	%rdi, %rsi
               	leaq	<rip>, %rdi # <addr>
               	addq	%rdi, %rdx
               	movq	(%rdx), %rdx
               	cmpq	$0x1, %rdx
               	jl	<addr>
               	incq	%rcx
               	movl	<rip>, %edx # <addr>
               	cmpl	%edx, %ecx
               	jl	<addr>
               	cmpq	%rsi, %rax
               	jne	<addr>
               	movl	$0x2, %edi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	movl	<rip>, %edx # <addr>
               	cmpl	%edx, %ecx
               	jge	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movq	(%rdi,%rcx,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	leaq	<rip>, %r8 # <addr>
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r8
               	movq	(%r8), %r8
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	imulq	%r8, %rdi
               	addq	%rdi, %rsi
               	leaq	<rip>, %rdi # <addr>
               	addq	%rdi, %rdx
               	movq	(%rdx), %rdx
               	cmpq	$0x2, %rdx
               	jl	<addr>
               	incq	%rcx
               	movl	<rip>, %edx # <addr>
               	cmpl	%edx, %ecx
               	jl	<addr>
               	cmpq	%rsi, %rax
               	jne	<addr>
               	movl	$0x1, %edi
               	movq	%rdi, <rip> # <addr>
               	movq	$0x2, <rip> # <addr>
               	movq	$0x3, <rip> # <addr>
               	movq	$0x4, <rip> # <addr>
               	movq	%rdi, <rip> # <addr>
               	movq	%rdi, <rip> # <addr>
               	movq	$-0x1, <rip> # <addr>
               	movq	%rdi, <rip> # <addr>
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	movl	<rip>, %esi # <addr>
               	cmpl	%esi, %ecx
               	jge	<addr>
               	leaq	<rip>, %rsi # <addr>
               	movq	(%rsi,%rcx,8), %rdi
               	leaq	<rip>, %r8 # <addr>
               	cmpl	$0x3, %ecx
               	jge	<addr>
               	movq	%rcx, %rsi
               	movq	(%r8,%rsi,8), %rsi
               	imulq	%rdi, %rsi
               	addq	%rsi, %rdx
               	leaq	<rip>, %rsi # <addr>
               	movq	(%rsi,%rcx,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	jmp	<addr>
               	movl	$0x3, %esi
               	jmp	<addr>
               	incq	%rcx
               	movl	<rip>, %esi # <addr>
               	cmpl	%esi, %ecx
               	jl	<addr>
               	addq	%rdx, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2, %edi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	movl	<rip>, %esi # <addr>
               	cmpl	%esi, %ecx
               	jge	<addr>
               	leaq	<rip>, %rsi # <addr>
               	movq	(%rsi,%rcx,8), %rdi
               	leaq	<rip>, %r8 # <addr>
               	cmpl	$0x3, %ecx
               	jge	<addr>
               	movq	%rcx, %rsi
               	movq	(%r8,%rsi,8), %rsi
               	imulq	%rdi, %rsi
               	shlq	%rsi
               	addq	%rsi, %rdx
               	leaq	<rip>, %rsi # <addr>
               	movq	(%rsi,%rcx,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	jmp	<addr>
               	movl	$0x3, %esi
               	jmp	<addr>
               	incq	%rcx
               	movl	<rip>, %esi # <addr>
               	cmpl	%esi, %ecx
               	jl	<addr>
               	addq	%rdx, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movl	$0x3, %ebx
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	movl	<rip>, %esi # <addr>
               	cmpl	%esi, %ecx
               	jge	<addr>
               	leaq	<rip>, %rsi # <addr>
               	movq	(%rsi,%rcx,8), %rdi
               	leaq	<rip>, %r8 # <addr>
               	cmpl	$0x3, %ecx
               	jge	<addr>
               	movq	%rcx, %rsi
               	movq	(%r8,%rsi,8), %rsi
               	imulq	%rdi, %rsi
               	imulq	%rbx, %rsi
               	addq	%rsi, %rdx
               	leaq	<rip>, %rsi # <addr>
               	movq	(%rsi,%rcx,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	jmp	<addr>
               	movl	$0x3, %esi
               	jmp	<addr>
               	incq	%rcx
               	movl	<rip>, %esi # <addr>
               	cmpl	%esi, %ecx
               	jl	<addr>
               	addq	%rdx, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	$-0x2, %rbx
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	movl	<rip>, %edx # <addr>
               	cmpl	%edx, %ecx
               	jge	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movq	(%rdi,%rcx,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	leaq	<rip>, %r8 # <addr>
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r8
               	movq	(%r8), %r8
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	imulq	%r8, %rdi
               	addq	%rdi, %rsi
               	leaq	<rip>, %rdi # <addr>
               	addq	%rdi, %rdx
               	movq	(%rdx), %rdx
               	cmpq	%rbx, %rdx
               	jl	<addr>
               	incq	%rcx
               	movl	<rip>, %edx # <addr>
               	cmpl	%edx, %ecx
               	jl	<addr>
               	cmpq	%rsi, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	$-0x1, %rbx
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	movl	<rip>, %edx # <addr>
               	cmpl	%edx, %ecx
               	jge	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movq	(%rdi,%rcx,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	leaq	<rip>, %r8 # <addr>
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r8
               	movq	(%r8), %r8
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	imulq	%r8, %rdi
               	addq	%rdi, %rsi
               	leaq	<rip>, %rdi # <addr>
               	addq	%rdi, %rdx
               	movq	(%rdx), %rdx
               	cmpq	%rbx, %rdx
               	jl	<addr>
               	incq	%rcx
               	movl	<rip>, %edx # <addr>
               	cmpl	%edx, %ecx
               	jl	<addr>
               	cmpq	%rsi, %rax
               	jne	<addr>
               	xorl	%edi, %edi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	movl	<rip>, %edx # <addr>
               	cmpl	%edx, %ecx
               	jge	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movq	(%rdi,%rcx,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	leaq	<rip>, %r8 # <addr>
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r8
               	movq	(%r8), %r8
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	imulq	%r8, %rdi
               	addq	%rdi, %rsi
               	leaq	<rip>, %rdi # <addr>
               	addq	%rdi, %rdx
               	movq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	incq	%rcx
               	movl	<rip>, %edx # <addr>
               	cmpl	%edx, %ecx
               	jl	<addr>
               	cmpq	%rsi, %rax
               	jne	<addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	movl	<rip>, %edx # <addr>
               	cmpl	%edx, %ecx
               	jge	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movq	(%rdi,%rcx,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	leaq	<rip>, %r8 # <addr>
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r8
               	movq	(%r8), %r8
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	imulq	%r8, %rdi
               	addq	%rdi, %rsi
               	leaq	<rip>, %rdi # <addr>
               	addq	%rdi, %rdx
               	movq	(%rdx), %rdx
               	cmpq	$0x1, %rdx
               	jl	<addr>
               	incq	%rcx
               	movl	<rip>, %edx # <addr>
               	cmpl	%edx, %ecx
               	jl	<addr>
               	cmpq	%rsi, %rax
               	jne	<addr>
               	movl	$0x2, %edi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	movl	<rip>, %edx # <addr>
               	cmpl	%edx, %ecx
               	jge	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movq	(%rdi,%rcx,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	leaq	<rip>, %r8 # <addr>
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r8
               	movq	(%r8), %r8
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	imulq	%r8, %rdi
               	addq	%rdi, %rsi
               	leaq	<rip>, %rdi # <addr>
               	addq	%rdi, %rdx
               	movq	(%rdx), %rdx
               	cmpq	$0x2, %rdx
               	jl	<addr>
               	incq	%rcx
               	movl	<rip>, %edx # <addr>
               	cmpl	%edx, %ecx
               	jl	<addr>
               	cmpq	%rsi, %rax
               	jne	<addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$-0x2, <rip> # <addr>
               	movq	$0x3, <rip> # <addr>
               	movq	$0x4, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	xorl	%edi, %edi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	movl	<rip>, %edx # <addr>
               	cmpl	%edx, %ecx
               	jge	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movq	(%rdi,%rcx,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	leaq	<rip>, %r8 # <addr>
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r8
               	movq	(%r8), %r8
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	imulq	%r8, %rdi
               	addq	%rdi, %rsi
               	leaq	<rip>, %rdi # <addr>
               	addq	%rdi, %rdx
               	movq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	incq	%rcx
               	movl	<rip>, %edx # <addr>
               	cmpl	%edx, %ecx
               	jl	<addr>
               	cmpq	%rsi, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2, %edi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	movl	<rip>, %esi # <addr>
               	cmpl	%esi, %ecx
               	jge	<addr>
               	leaq	<rip>, %rsi # <addr>
               	movq	(%rsi,%rcx,8), %rdi
               	leaq	<rip>, %r8 # <addr>
               	cmpl	$0x3, %ecx
               	jge	<addr>
               	movq	%rcx, %rsi
               	movq	(%r8,%rsi,8), %rsi
               	imulq	%rdi, %rsi
               	shlq	%rsi
               	addq	%rsi, %rdx
               	leaq	<rip>, %rsi # <addr>
               	movq	(%rsi,%rcx,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	jmp	<addr>
               	movl	$0x3, %esi
               	jmp	<addr>
               	incq	%rcx
               	movl	<rip>, %esi # <addr>
               	cmpl	%esi, %ecx
               	jl	<addr>
               	addq	%rdx, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	$-0x1, <rip> # <addr>
               	movq	$0x2, <rip> # <addr>
               	movq	$0x3, <rip> # <addr>
               	movq	$0x4, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$-0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	xorl	%edi, %edi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	movl	<rip>, %edx # <addr>
               	cmpl	%edx, %ecx
               	jge	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movq	(%rdi,%rcx,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	leaq	<rip>, %r8 # <addr>
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r8
               	movq	(%r8), %r8
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	imulq	%r8, %rdi
               	addq	%rdi, %rsi
               	leaq	<rip>, %rdi # <addr>
               	addq	%rdi, %rdx
               	movq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	incq	%rcx
               	movl	<rip>, %edx # <addr>
               	cmpl	%edx, %ecx
               	jl	<addr>
               	cmpq	%rsi, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	movl	<rip>, %esi # <addr>
               	cmpl	%esi, %ecx
               	jge	<addr>
               	leaq	<rip>, %rsi # <addr>
               	movq	(%rsi,%rcx,8), %rdi
               	leaq	<rip>, %r8 # <addr>
               	cmpl	$0x3, %ecx
               	jge	<addr>
               	movq	%rcx, %rsi
               	movq	(%r8,%rsi,8), %rsi
               	imulq	%rdi, %rsi
               	addq	%rsi, %rdx
               	leaq	<rip>, %rsi # <addr>
               	movq	(%rsi,%rcx,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	jmp	<addr>
               	movl	$0x3, %esi
               	jmp	<addr>
               	incq	%rcx
               	movl	<rip>, %esi # <addr>
               	cmpl	%esi, %ecx
               	jl	<addr>
               	addq	%rdx, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2, %edi
               	movq	$0x1, <rip> # <addr>
               	movq	%rdi, <rip> # <addr>
               	movq	$0x3, <rip> # <addr>
               	movq	$0x4, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	callq	<addr>
               	cmpq	$0x21c6, %rax           # imm = 0x21C6
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	$-0x2, %rdi
               	callq	<addr>
               	cmpq	$0x10e1, %rax           # imm = 0x10E1
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	leave
               	retq
               	callq	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	leaq	<rip>, %rdx # <addr>
               	movq	(%rdx,%rax,8), %rdx
               	addq	%rdx, %rcx
               	incq	%rax
               	cmpl	$0x3, %eax
               	jle	<addr>
               	shlq	%rcx
               	cmpq	$0x8ae, %rcx            # imm = 0x8AE
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	xorq	$-0x1, %rsi
               	jmp	<addr>
               	xorq	$-0x1, %rsi
               	jmp	<addr>
               	xorq	$-0x1, %rsi
               	jmp	<addr>
               	xorq	$-0x1, %rsi
               	jmp	<addr>
               	xorq	$-0x1, %rsi
               	jmp	<addr>
               	xorq	$-0x1, %rsi
               	jmp	<addr>
               	xorq	$-0x1, %rsi
               	jmp	<addr>
               	xorq	$-0x1, %rsi
               	jmp	<addr>
               	xorq	$-0x1, %rsi
               	jmp	<addr>
               	xorq	$-0x1, %rsi
               	jmp	<addr>
               	xorq	$-0x1, %rsi
               	jmp	<addr>
               	xorq	$-0x1, %rsi
               	jmp	<addr>
