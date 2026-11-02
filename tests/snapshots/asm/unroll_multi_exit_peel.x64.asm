
unroll_multi_exit_peel.x64:	file format elf64-x86-64

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

<walk_peeled>:
               	xorl	%ecx, %ecx
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rdx # <addr>
               	imulq	%rdx, %rax
               	imulq	%rdi, %rax
               	movq	<rip>, %rdx # <addr>
               	testq	%rdx, %rdx
               	jge	<addr>
               	shlq	$0x3, %rax
               	addq	%rcx, %rax
               	retq
               	movl	$0x1, %ecx
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rsi # <addr>
               	imulq	%rsi, %rdx
               	imulq	%rdi, %rdx
               	addq	%rdx, %rax
               	movq	<rip>, %rdx # <addr>
               	testq	%rdx, %rdx
               	jl	<addr>
               	movl	$0x2, %ecx
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rsi # <addr>
               	imulq	%rsi, %rdx
               	imulq	%rdi, %rdx
               	addq	%rdx, %rax
               	movq	<rip>, %rdx # <addr>
               	testq	%rdx, %rdx
               	jl	<addr>
               	movl	$0x3, %ecx
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rsi # <addr>
               	imulq	%rsi, %rdx
               	imulq	%rdi, %rdx
               	addq	%rdx, %rax
               	movq	<rip>, %rdx # <addr>
               	testq	%rdx, %rdx
               	jl	<addr>
               	movl	$0x4, %ecx
               	jmp	<addr>

<scan_peeled>:
               	xorl	%ecx, %ecx
               	movq	<rip>, %rax # <addr>
               	testq	%rax, %rax
               	jge	<addr>
               	movq	%rcx, %rax
               	negq	%rax
               	subq	%rcx, %rax
               	decq	%rax
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rdx # <addr>
               	imulq	%rdx, %rax
               	movq	<rip>, %rdx # <addr>
               	cmpq	%rdi, %rdx
               	jge	<addr>
               	shlq	$0x3, %rax
               	addq	%rcx, %rax
               	retq
               	movl	$0x1, %ecx
               	movq	<rip>, %rdx # <addr>
               	testq	%rdx, %rdx
               	jl	<addr>
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rsi # <addr>
               	imulq	%rsi, %rdx
               	addq	%rdx, %rax
               	movq	<rip>, %rdx # <addr>
               	cmpq	%rdi, %rdx
               	jl	<addr>
               	movl	$0x2, %ecx
               	movq	<rip>, %rdx # <addr>
               	testq	%rdx, %rdx
               	jl	<addr>
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rsi # <addr>
               	imulq	%rsi, %rdx
               	addq	%rdx, %rax
               	movq	<rip>, %rdx # <addr>
               	cmpq	%rdi, %rdx
               	jl	<addr>
               	movl	$0x3, %ecx
               	movq	<rip>, %rdx # <addr>
               	testq	%rdx, %rdx
               	jl	<addr>
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rsi # <addr>
               	imulq	%rsi, %rdx
               	addq	%rdx, %rax
               	movq	<rip>, %rdx # <addr>
               	cmpq	%rdi, %rdx
               	jl	<addr>
               	movl	$0x4, %ecx
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movl	$0x2, %edi
               	movq	$0x1, <rip> # <addr>
               	movq	%rdi, <rip> # <addr>
               	movq	$0x3, <rip> # <addr>
               	movq	$0x4, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0xa, <rip> # <addr>
               	movq	$0x64, <rip> # <addr>
               	movq	$0x3e8, <rip> # imm = 0x3E8
                                                # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	callq	<addr>
               	cmpq	$0x10e14, %rax          # imm = 0x10E14
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	$-0x2, %rdi
               	callq	<addr>
               	cmpq	$0x870c, %rax           # imm = 0x870C
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %edi
               	movq	%rdi, <rip> # <addr>
               	movq	$0x2, <rip> # <addr>
               	movq	$0x3, <rip> # <addr>
               	movq	$0x4, <rip> # <addr>
               	movq	%rdi, <rip> # <addr>
               	movq	$0xa, <rip> # <addr>
               	movq	$0x64, <rip> # <addr>
               	movq	$0x3e8, <rip> # imm = 0x3E8
                                                # <addr>
               	movq	%rdi, <rip> # <addr>
               	movq	%rdi, <rip> # <addr>
               	movq	%rdi, <rip> # <addr>
               	movq	%rdi, <rip> # <addr>
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	movl	<rip>, %edx # <addr>
               	cmpl	%edx, %ecx
               	jge	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	leaq	<rip>, %r8 # <addr>
               	addq	%rdx, %r8
               	movq	(%r8), %r8
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
               	shlq	$0x3, %rsi
               	addq	%rsi, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	$0x1, <rip> # <addr>
               	movq	$0x2, <rip> # <addr>
               	movq	$0x3, <rip> # <addr>
               	movq	$0x4, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0xa, <rip> # <addr>
               	movq	$0x64, <rip> # <addr>
               	movq	$0x3e8, <rip> # imm = 0x3E8
                                                # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$-0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	movl	<rip>, %edx # <addr>
               	cmpl	%edx, %ecx
               	jge	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	leaq	<rip>, %r8 # <addr>
               	addq	%rdx, %r8
               	movq	(%r8), %r8
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
               	shlq	$0x3, %rsi
               	addq	%rsi, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	$-0x1, <rip> # <addr>
               	movq	$0x2, <rip> # <addr>
               	movq	$0x3, <rip> # <addr>
               	movq	$0x4, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0xa, <rip> # <addr>
               	movq	$0x64, <rip> # <addr>
               	movq	$0x3e8, <rip> # imm = 0x3E8
                                                # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	movl	<rip>, %edx # <addr>
               	cmpl	%edx, %ecx
               	jge	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	leaq	<rip>, %r8 # <addr>
               	addq	%rdx, %r8
               	movq	(%r8), %r8
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
               	shlq	$0x3, %rsi
               	addq	%rsi, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2, %edi
               	movq	$0x1, <rip> # <addr>
               	movq	%rdi, <rip> # <addr>
               	movq	$0x3, <rip> # <addr>
               	movq	$0x4, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0xa, <rip> # <addr>
               	movq	$0x64, <rip> # <addr>
               	movq	$0x3e8, <rip> # imm = 0x3E8
                                                # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	movl	<rip>, %edx # <addr>
               	cmpl	%edx, %ecx
               	jge	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	leaq	<rip>, %r8 # <addr>
               	addq	%rdx, %r8
               	movq	(%r8), %r8
               	imulq	%r8, %rdi
               	shlq	%rdi
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
               	shlq	$0x3, %rsi
               	addq	%rsi, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x2, <rip> # <addr>
               	movq	$0x3, <rip> # <addr>
               	movq	$0x4, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0xa, <rip> # <addr>
               	movq	$0x64, <rip> # <addr>
               	movq	$0x3e8, <rip> # imm = 0x3E8
                                                # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$-0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movl	$0x2, %edi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	movl	<rip>, %edx # <addr>
               	cmpl	%edx, %ecx
               	jge	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	leaq	<rip>, %r8 # <addr>
               	addq	%rdx, %r8
               	movq	(%r8), %r8
               	imulq	%r8, %rdi
               	shlq	%rdi
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
               	shlq	$0x3, %rsi
               	addq	%rsi, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	$-0x1, <rip> # <addr>
               	movq	$0x2, <rip> # <addr>
               	movq	$0x3, <rip> # <addr>
               	movq	$0x4, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0xa, <rip> # <addr>
               	movq	$0x64, <rip> # <addr>
               	movq	$0x3e8, <rip> # imm = 0x3E8
                                                # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movl	$0x2, %edi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	movl	<rip>, %edx # <addr>
               	cmpl	%edx, %ecx
               	jge	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	leaq	<rip>, %r8 # <addr>
               	addq	%rdx, %r8
               	movq	(%r8), %r8
               	imulq	%r8, %rdi
               	shlq	%rdi
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
               	shlq	$0x3, %rsi
               	addq	%rsi, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movl	$0x3, %ebx
               	movq	$0x1, <rip> # <addr>
               	movq	$0x2, <rip> # <addr>
               	movq	%rbx, <rip> # <addr>
               	movq	$0x4, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0xa, <rip> # <addr>
               	movq	$0x64, <rip> # <addr>
               	movq	$0x3e8, <rip> # imm = 0x3E8
                                                # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	movl	<rip>, %edx # <addr>
               	cmpl	%edx, %ecx
               	jge	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	leaq	<rip>, %r8 # <addr>
               	addq	%rdx, %r8
               	movq	(%r8), %r8
               	imulq	%r8, %rdi
               	imulq	%rbx, %rdi
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
               	shlq	$0x3, %rsi
               	addq	%rsi, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x2, <rip> # <addr>
               	movq	$0x3, <rip> # <addr>
               	movq	$0x4, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0xa, <rip> # <addr>
               	movq	$0x64, <rip> # <addr>
               	movq	$0x3e8, <rip> # imm = 0x3E8
                                                # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$-0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	movl	<rip>, %edx # <addr>
               	cmpl	%edx, %ecx
               	jge	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	leaq	<rip>, %r8 # <addr>
               	addq	%rdx, %r8
               	movq	(%r8), %r8
               	imulq	%r8, %rdi
               	imulq	%rbx, %rdi
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
               	shlq	$0x3, %rsi
               	addq	%rsi, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	$-0x1, <rip> # <addr>
               	movq	$0x2, <rip> # <addr>
               	movq	$0x3, <rip> # <addr>
               	movq	$0x4, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0xa, <rip> # <addr>
               	movq	$0x64, <rip> # <addr>
               	movq	$0x3e8, <rip> # imm = 0x3E8
                                                # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	movl	<rip>, %edx # <addr>
               	cmpl	%edx, %ecx
               	jge	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	leaq	<rip>, %r8 # <addr>
               	addq	%rdx, %r8
               	movq	(%r8), %r8
               	imulq	%r8, %rdi
               	imulq	%rbx, %rdi
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
               	shlq	$0x3, %rsi
               	addq	%rsi, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	$-0x2, %rbx
               	movq	$0x1, <rip> # <addr>
               	movq	$0x2, <rip> # <addr>
               	movq	$0x3, <rip> # <addr>
               	movq	$0x4, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0xa, <rip> # <addr>
               	movq	$0x64, <rip> # <addr>
               	movq	$0x3e8, <rip> # imm = 0x3E8
                                                # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
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
               	shlq	$0x3, %rsi
               	addq	%rsi, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x2, <rip> # <addr>
               	movq	$0x3, <rip> # <addr>
               	movq	$0x4, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0xa, <rip> # <addr>
               	movq	$0x64, <rip> # <addr>
               	movq	$0x3e8, <rip> # imm = 0x3E8
                                                # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$-0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
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
               	shlq	$0x3, %rsi
               	addq	%rsi, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$-0x2, <rip> # <addr>
               	movq	$0x3, <rip> # <addr>
               	movq	$0x4, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0xa, <rip> # <addr>
               	movq	$0x64, <rip> # <addr>
               	movq	$0x3e8, <rip> # imm = 0x3E8
                                                # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
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
               	shlq	$0x3, %rsi
               	addq	%rsi, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	$-0x1, <rip> # <addr>
               	movq	$0x2, <rip> # <addr>
               	movq	$0x3, <rip> # <addr>
               	movq	$0x4, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0xa, <rip> # <addr>
               	movq	$0x64, <rip> # <addr>
               	movq	$0x3e8, <rip> # imm = 0x3E8
                                                # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$-0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
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
               	shlq	$0x3, %rsi
               	addq	%rsi, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	jmp	<addr>
               	movq	%rsi, %rdx
               	negq	%rdx
               	subq	%rcx, %rdx
               	leaq	-0x1(%rdx), %rcx
               	jmp	<addr>
               	movq	%rsi, %rdx
               	negq	%rdx
               	subq	%rcx, %rdx
               	leaq	-0x1(%rdx), %rcx
               	jmp	<addr>
               	movq	%rsi, %rdx
               	negq	%rdx
               	subq	%rcx, %rdx
               	leaq	-0x1(%rdx), %rcx
               	jmp	<addr>
               	movq	%rsi, %rdx
               	negq	%rdx
               	subq	%rcx, %rdx
               	leaq	-0x1(%rdx), %rcx
               	jmp	<addr>
               	incq	%rbx
               	cmpl	$0x2, %ebx
               	jle	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x9, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x8, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
