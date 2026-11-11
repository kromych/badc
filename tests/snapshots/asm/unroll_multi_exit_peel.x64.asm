
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
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
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
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	movq	$-0x2, %rdi
               	callq	<addr>
               	cmpq	$0x870c, %rax           # imm = 0x870C
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
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
               	movq	%rax, %r13
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r8 # <addr>
               	leaq	<rip>, %r9 # <addr>
               	movl	<rip>, %eax # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	cmpl	%eax, %ecx
               	jge	<addr>
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	leaq	(%rdi,%rdx), %rbx
               	movq	(%rbx), %rbx
               	leaq	(%r9,%rdx), %r12
               	movq	(%r12), %r12
               	imulq	%r12, %rbx
               	addq	%rbx, %rsi
               	addq	%r8, %rdx
               	movq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	incq	%rcx
               	cmpl	%eax, %ecx
               	jl	<addr>
               	shlq	$0x3, %rsi
               	leaq	(%rsi,%rcx), %rax
               	cmpq	%rax, %r13
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
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
               	movq	%rax, %r13
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r8 # <addr>
               	leaq	<rip>, %r9 # <addr>
               	movl	<rip>, %eax # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	cmpl	%eax, %ecx
               	jge	<addr>
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	leaq	(%rdi,%rdx), %rbx
               	movq	(%rbx), %rbx
               	leaq	(%r9,%rdx), %r12
               	movq	(%r12), %r12
               	imulq	%r12, %rbx
               	addq	%rbx, %rsi
               	addq	%r8, %rdx
               	movq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	incq	%rcx
               	cmpl	%eax, %ecx
               	jl	<addr>
               	shlq	$0x3, %rsi
               	leaq	(%rsi,%rcx), %rax
               	cmpq	%rax, %r13
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
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
               	movq	%rax, %r13
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r8 # <addr>
               	leaq	<rip>, %r9 # <addr>
               	movl	<rip>, %eax # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	cmpl	%eax, %ecx
               	jge	<addr>
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	leaq	(%rdi,%rdx), %rbx
               	movq	(%rbx), %rbx
               	leaq	(%r9,%rdx), %r12
               	movq	(%r12), %r12
               	imulq	%r12, %rbx
               	addq	%rbx, %rsi
               	addq	%r8, %rdx
               	movq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	incq	%rcx
               	cmpl	%eax, %ecx
               	jl	<addr>
               	shlq	$0x3, %rsi
               	leaq	(%rsi,%rcx), %rax
               	cmpq	%rax, %r13
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
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
               	movq	%rax, %r13
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r8 # <addr>
               	leaq	<rip>, %r9 # <addr>
               	movl	<rip>, %eax # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	cmpl	%eax, %ecx
               	jge	<addr>
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	leaq	(%rdi,%rdx), %rbx
               	movq	(%rbx), %rbx
               	leaq	(%r9,%rdx), %r12
               	movq	(%r12), %r12
               	imulq	%r12, %rbx
               	shlq	%rbx
               	addq	%rbx, %rsi
               	addq	%r8, %rdx
               	movq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	incq	%rcx
               	cmpl	%eax, %ecx
               	jl	<addr>
               	shlq	$0x3, %rsi
               	leaq	(%rsi,%rcx), %rax
               	cmpq	%rax, %r13
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
               	movq	%rax, %r13
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r8 # <addr>
               	leaq	<rip>, %r9 # <addr>
               	movl	<rip>, %eax # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	cmpl	%eax, %ecx
               	jge	<addr>
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	leaq	(%rdi,%rdx), %rbx
               	movq	(%rbx), %rbx
               	leaq	(%r9,%rdx), %r12
               	movq	(%r12), %r12
               	imulq	%r12, %rbx
               	shlq	%rbx
               	addq	%rbx, %rsi
               	addq	%r8, %rdx
               	movq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	incq	%rcx
               	cmpl	%eax, %ecx
               	jl	<addr>
               	shlq	$0x3, %rsi
               	leaq	(%rsi,%rcx), %rax
               	cmpq	%rax, %r13
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
               	movq	%rax, %r13
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r8 # <addr>
               	leaq	<rip>, %r9 # <addr>
               	movl	<rip>, %eax # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	cmpl	%eax, %ecx
               	jge	<addr>
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	leaq	(%rdi,%rdx), %rbx
               	movq	(%rbx), %rbx
               	leaq	(%r9,%rdx), %r12
               	movq	(%r12), %r12
               	imulq	%r12, %rbx
               	shlq	%rbx
               	addq	%rbx, %rsi
               	addq	%r8, %rdx
               	movq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	incq	%rcx
               	cmpl	%eax, %ecx
               	jl	<addr>
               	shlq	$0x3, %rsi
               	leaq	(%rsi,%rcx), %rax
               	cmpq	%rax, %r13
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
               	movq	%rax, %r14
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r8 # <addr>
               	leaq	<rip>, %r9 # <addr>
               	movl	<rip>, %eax # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	cmpl	%eax, %ecx
               	jge	<addr>
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	leaq	(%rdi,%rdx), %r12
               	movq	(%r12), %r12
               	leaq	(%r9,%rdx), %r13
               	movq	(%r13), %r13
               	imulq	%r13, %r12
               	imulq	%rbx, %r12
               	addq	%r12, %rsi
               	addq	%r8, %rdx
               	movq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	incq	%rcx
               	cmpl	%eax, %ecx
               	jl	<addr>
               	shlq	$0x3, %rsi
               	leaq	(%rsi,%rcx), %rax
               	cmpq	%rax, %r14
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
               	movq	%rax, %r14
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r8 # <addr>
               	leaq	<rip>, %r9 # <addr>
               	movl	<rip>, %eax # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	cmpl	%eax, %ecx
               	jge	<addr>
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	leaq	(%rdi,%rdx), %r12
               	movq	(%r12), %r12
               	leaq	(%r9,%rdx), %r13
               	movq	(%r13), %r13
               	imulq	%r13, %r12
               	imulq	%rbx, %r12
               	addq	%r12, %rsi
               	addq	%r8, %rdx
               	movq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	incq	%rcx
               	cmpl	%eax, %ecx
               	jl	<addr>
               	shlq	$0x3, %rsi
               	leaq	(%rsi,%rcx), %rax
               	cmpq	%rax, %r14
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
               	movq	%rax, %r14
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r8 # <addr>
               	leaq	<rip>, %r9 # <addr>
               	movl	<rip>, %eax # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	cmpl	%eax, %ecx
               	jge	<addr>
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	leaq	(%rdi,%rdx), %r12
               	movq	(%r12), %r12
               	leaq	(%r9,%rdx), %r13
               	movq	(%r13), %r13
               	imulq	%r13, %r12
               	imulq	%rbx, %r12
               	addq	%r12, %rsi
               	addq	%r8, %rdx
               	movq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	incq	%rcx
               	cmpl	%eax, %ecx
               	jl	<addr>
               	shlq	$0x3, %rsi
               	leaq	(%rsi,%rcx), %rax
               	cmpq	%rax, %r14
               	jne	<addr>
               	movq	$-0x2, %r12
               	leaq	<rip>, %rbx # <addr>
               	leaq	<rip>, %r13 # <addr>
               	leaq	<rip>, %r14 # <addr>
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
               	movq	%r12, %rdi
               	callq	<addr>
               	movl	<rip>, %edi # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	cmpl	%edi, %ecx
               	jge	<addr>
               	movq	(%rbx,%rcx,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	leaq	(%r14,%rdx), %r8
               	movq	(%r8), %r8
               	leaq	(%rbx,%rdx), %r9
               	movq	(%r9), %r9
               	imulq	%r9, %r8
               	addq	%r8, %rsi
               	addq	%r13, %rdx
               	movq	(%rdx), %rdx
               	cmpq	%r12, %rdx
               	jl	<addr>
               	incq	%rcx
               	cmpl	%edi, %ecx
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
               	movq	%r12, %rdi
               	callq	<addr>
               	movl	<rip>, %edi # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	cmpl	%edi, %ecx
               	jge	<addr>
               	movq	(%rbx,%rcx,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	leaq	(%r14,%rdx), %r8
               	movq	(%r8), %r8
               	leaq	(%rbx,%rdx), %r9
               	movq	(%r9), %r9
               	imulq	%r9, %r8
               	addq	%r8, %rsi
               	addq	%r13, %rdx
               	movq	(%rdx), %rdx
               	cmpq	%r12, %rdx
               	jl	<addr>
               	incq	%rcx
               	cmpl	%edi, %ecx
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
               	movq	%r12, %rdi
               	callq	<addr>
               	movl	<rip>, %edi # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	cmpl	%edi, %ecx
               	jge	<addr>
               	movq	(%rbx,%rcx,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	leaq	(%r14,%rdx), %r8
               	movq	(%r8), %r8
               	leaq	(%rbx,%rdx), %r9
               	movq	(%r9), %r9
               	imulq	%r9, %r8
               	addq	%r8, %rsi
               	addq	%r13, %rdx
               	movq	(%rdx), %rdx
               	cmpq	%r12, %rdx
               	jl	<addr>
               	incq	%rcx
               	cmpl	%edi, %ecx
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
               	movq	%r12, %rdi
               	callq	<addr>
               	movl	<rip>, %edi # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	cmpl	%edi, %ecx
               	jge	<addr>
               	movq	(%rbx,%rcx,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	leaq	(%r14,%rdx), %r8
               	movq	(%r8), %r8
               	leaq	(%rbx,%rdx), %r9
               	movq	(%r9), %r9
               	imulq	%r9, %r8
               	addq	%r8, %rsi
               	addq	%r13, %rdx
               	movq	(%rdx), %rdx
               	cmpq	%r12, %rdx
               	jl	<addr>
               	incq	%rcx
               	cmpl	%edi, %ecx
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
               	incq	%r12
               	cmpl	$0x2, %r12d
               	jle	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	movl	$0x9, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
