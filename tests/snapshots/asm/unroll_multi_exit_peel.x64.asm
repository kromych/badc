
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
               	subq	$0x20, %rsp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movl	$0x1, %eax
               	movq	%rax, <rip> # <addr>
               	movq	$0x2, <rip> # <addr>
               	movq	$0x3, <rip> # <addr>
               	movq	$0x4, <rip> # <addr>
               	movq	%rax, <rip> # <addr>
               	movq	$0xa, <rip> # <addr>
               	movq	$0x64, <rip> # <addr>
               	movq	$0x3e8, <rip> # imm = 0x3E8
                                                # <addr>
               	movq	%rax, <rip> # <addr>
               	movq	%rax, <rip> # <addr>
               	movq	%rax, <rip> # <addr>
               	movq	%rax, <rip> # <addr>
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdx # <addr>
               	imulq	%rdx, %rcx
               	shlq	%rcx
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rsi # <addr>
               	imulq	%rsi, %rdx
               	shlq	%rdx
               	addq	%rdx, %rcx
               	movq	<rip>, %rdx # <addr>
               	testq	%rdx, %rdx
               	jge	<addr>
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	cmpq	$0x10e14, %rax          # imm = 0x10E14
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
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
               	leave
               	retq
               	movl	$0x1, %eax
               	movq	%rax, <rip> # <addr>
               	movq	$0x2, <rip> # <addr>
               	movq	$0x3, <rip> # <addr>
               	movq	$0x4, <rip> # <addr>
               	movq	%rax, <rip> # <addr>
               	movq	$0xa, <rip> # <addr>
               	movq	$0x64, <rip> # <addr>
               	movq	$0x3e8, <rip> # imm = 0x3E8
                                                # <addr>
               	movq	%rax, <rip> # <addr>
               	movq	%rax, <rip> # <addr>
               	movq	%rax, <rip> # <addr>
               	movq	%rax, <rip> # <addr>
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdx # <addr>
               	imulq	%rdx, %rcx
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rsi # <addr>
               	imulq	%rsi, %rdx
               	addq	%rdx, %rcx
               	movq	<rip>, %rdx # <addr>
               	testq	%rdx, %rdx
               	jge	<addr>
               	shlq	$0x3, %rcx
               	leaq	(%rcx,%rax), %r13
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r8 # <addr>
               	movl	<rip>, %r9d # <addr>
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	cmpl	%r9d, %eax
               	jge	<addr>
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rsi,%rcx), %rbx
               	movq	(%rbx), %rbx
               	leaq	(%r8,%rcx), %r12
               	movq	(%r12), %r12
               	imulq	%r12, %rbx
               	addq	%rbx, %rdx
               	addq	%rdi, %rcx
               	movq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	incq	%rax
               	cmpl	%r9d, %eax
               	jl	<addr>
               	shlq	$0x3, %rdx
               	addq	%rdx, %rax
               	cmpq	%rax, %r13
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
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
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	imulq	%rcx, %rax
               	movl	$0x1, %ecx
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rsi # <addr>
               	imulq	%rsi, %rdx
               	addq	%rdx, %rax
               	movq	<rip>, %rdx # <addr>
               	testq	%rdx, %rdx
               	jge	<addr>
               	shlq	$0x3, %rax
               	leaq	(%rax,%rcx), %r13
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r8 # <addr>
               	movl	<rip>, %r9d # <addr>
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	cmpl	%r9d, %eax
               	jge	<addr>
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rsi,%rcx), %rbx
               	movq	(%rbx), %rbx
               	leaq	(%r8,%rcx), %r12
               	movq	(%r12), %r12
               	imulq	%r12, %rbx
               	addq	%rbx, %rdx
               	addq	%rdi, %rcx
               	movq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	incq	%rax
               	cmpl	%r9d, %eax
               	jl	<addr>
               	shlq	$0x3, %rdx
               	addq	%rdx, %rax
               	cmpq	%rax, %r13
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
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
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	imulq	%rcx, %rax
               	movl	$0x1, %ecx
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rsi # <addr>
               	imulq	%rsi, %rdx
               	addq	%rdx, %rax
               	movq	<rip>, %rdx # <addr>
               	testq	%rdx, %rdx
               	jge	<addr>
               	shlq	$0x3, %rax
               	leaq	(%rax,%rcx), %r13
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r8 # <addr>
               	movl	<rip>, %r9d # <addr>
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	cmpl	%r9d, %eax
               	jge	<addr>
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rsi,%rcx), %rbx
               	movq	(%rbx), %rbx
               	leaq	(%r8,%rcx), %r12
               	movq	(%r12), %r12
               	imulq	%r12, %rbx
               	addq	%rbx, %rdx
               	addq	%rdi, %rcx
               	movq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	incq	%rax
               	cmpl	%r9d, %eax
               	jl	<addr>
               	shlq	$0x3, %rdx
               	addq	%rdx, %rax
               	cmpq	%rax, %r13
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x1, %eax
               	movq	%rax, <rip> # <addr>
               	movq	$0x2, <rip> # <addr>
               	movq	$0x3, <rip> # <addr>
               	movq	$0x4, <rip> # <addr>
               	movq	%rax, <rip> # <addr>
               	movq	$0xa, <rip> # <addr>
               	movq	$0x64, <rip> # <addr>
               	movq	$0x3e8, <rip> # imm = 0x3E8
                                                # <addr>
               	movq	%rax, <rip> # <addr>
               	movq	%rax, <rip> # <addr>
               	movq	%rax, <rip> # <addr>
               	movq	%rax, <rip> # <addr>
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdx # <addr>
               	imulq	%rdx, %rcx
               	shlq	%rcx
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rsi # <addr>
               	imulq	%rsi, %rdx
               	shlq	%rdx
               	addq	%rdx, %rcx
               	movq	<rip>, %rdx # <addr>
               	testq	%rdx, %rdx
               	jge	<addr>
               	shlq	$0x3, %rcx
               	leaq	(%rcx,%rax), %r13
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r8 # <addr>
               	movl	<rip>, %r9d # <addr>
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	cmpl	%r9d, %eax
               	jge	<addr>
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rsi,%rcx), %rbx
               	movq	(%rbx), %rbx
               	leaq	(%r8,%rcx), %r12
               	movq	(%r12), %r12
               	imulq	%r12, %rbx
               	shlq	%rbx
               	addq	%rbx, %rdx
               	addq	%rdi, %rcx
               	movq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	incq	%rax
               	cmpl	%r9d, %eax
               	jl	<addr>
               	shlq	$0x3, %rdx
               	addq	%rdx, %rax
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
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	imulq	%rcx, %rax
               	shlq	%rax
               	movl	$0x1, %ecx
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rsi # <addr>
               	imulq	%rsi, %rdx
               	shlq	%rdx
               	addq	%rdx, %rax
               	movq	<rip>, %rdx # <addr>
               	testq	%rdx, %rdx
               	jge	<addr>
               	shlq	$0x3, %rax
               	leaq	(%rax,%rcx), %r13
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r8 # <addr>
               	movl	<rip>, %r9d # <addr>
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	cmpl	%r9d, %eax
               	jge	<addr>
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rsi,%rcx), %rbx
               	movq	(%rbx), %rbx
               	leaq	(%r8,%rcx), %r12
               	movq	(%r12), %r12
               	imulq	%r12, %rbx
               	shlq	%rbx
               	addq	%rbx, %rdx
               	addq	%rdi, %rcx
               	movq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	incq	%rax
               	cmpl	%r9d, %eax
               	jl	<addr>
               	shlq	$0x3, %rdx
               	addq	%rdx, %rax
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
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	imulq	%rcx, %rax
               	shlq	%rax
               	movl	$0x1, %ecx
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rsi # <addr>
               	imulq	%rsi, %rdx
               	shlq	%rdx
               	addq	%rdx, %rax
               	movq	<rip>, %rdx # <addr>
               	testq	%rdx, %rdx
               	jge	<addr>
               	shlq	$0x3, %rax
               	leaq	(%rax,%rcx), %r13
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r8 # <addr>
               	movl	<rip>, %r9d # <addr>
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	cmpl	%r9d, %eax
               	jge	<addr>
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rsi,%rcx), %rbx
               	movq	(%rbx), %rbx
               	leaq	(%r8,%rcx), %r12
               	movq	(%r12), %r12
               	imulq	%r12, %rbx
               	shlq	%rbx
               	addq	%rbx, %rdx
               	addq	%rdi, %rcx
               	movq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	incq	%rax
               	cmpl	%r9d, %eax
               	jl	<addr>
               	shlq	$0x3, %rdx
               	addq	%rdx, %rax
               	cmpq	%rax, %r13
               	jne	<addr>
               	movl	$0x3, %ecx
               	movq	$0x1, <rip> # <addr>
               	movq	$0x2, <rip> # <addr>
               	movq	%rcx, <rip> # <addr>
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
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rdx # <addr>
               	imulq	%rdx, %rax
               	imulq	%rcx, %rax
               	movl	$0x1, %edx
               	movq	<rip>, %rsi # <addr>
               	movq	<rip>, %rdi # <addr>
               	imulq	%rdi, %rsi
               	imulq	%rcx, %rsi
               	addq	%rsi, %rax
               	movq	<rip>, %rsi # <addr>
               	testq	%rsi, %rsi
               	jge	<addr>
               	shlq	$0x3, %rax
               	leaq	(%rax,%rdx), %r14
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r8 # <addr>
               	leaq	<rip>, %r9 # <addr>
               	movl	<rip>, %ebx # <addr>
               	xorl	%eax, %eax
               	movq	%rax, %rsi
               	cmpl	%ebx, %eax
               	jge	<addr>
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	leaq	(%rdi,%rdx), %r12
               	movq	(%r12), %r12
               	leaq	(%r9,%rdx), %r13
               	movq	(%r13), %r13
               	imulq	%r13, %r12
               	imulq	%rcx, %r12
               	addq	%r12, %rsi
               	addq	%r8, %rdx
               	movq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	incq	%rax
               	cmpl	%ebx, %eax
               	jl	<addr>
               	shlq	$0x3, %rsi
               	addq	%rsi, %rax
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
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rdx # <addr>
               	imulq	%rdx, %rax
               	imulq	%rcx, %rax
               	movl	$0x1, %edx
               	movq	<rip>, %rsi # <addr>
               	movq	<rip>, %rdi # <addr>
               	imulq	%rdi, %rsi
               	imulq	%rcx, %rsi
               	addq	%rsi, %rax
               	movq	<rip>, %rsi # <addr>
               	testq	%rsi, %rsi
               	jge	<addr>
               	shlq	$0x3, %rax
               	leaq	(%rax,%rdx), %r14
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r8 # <addr>
               	leaq	<rip>, %r9 # <addr>
               	movl	<rip>, %ebx # <addr>
               	xorl	%eax, %eax
               	movq	%rax, %rsi
               	cmpl	%ebx, %eax
               	jge	<addr>
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	leaq	(%rdi,%rdx), %r12
               	movq	(%r12), %r12
               	leaq	(%r9,%rdx), %r13
               	movq	(%r13), %r13
               	imulq	%r13, %r12
               	imulq	%rcx, %r12
               	addq	%r12, %rsi
               	addq	%r8, %rdx
               	movq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	incq	%rax
               	cmpl	%ebx, %eax
               	jl	<addr>
               	shlq	$0x3, %rsi
               	addq	%rsi, %rax
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
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rdx # <addr>
               	imulq	%rdx, %rax
               	imulq	%rcx, %rax
               	movl	$0x1, %edx
               	movq	<rip>, %rsi # <addr>
               	movq	<rip>, %rdi # <addr>
               	imulq	%rdi, %rsi
               	imulq	%rcx, %rsi
               	addq	%rsi, %rax
               	movq	<rip>, %rsi # <addr>
               	testq	%rsi, %rsi
               	jge	<addr>
               	shlq	$0x3, %rax
               	leaq	(%rax,%rdx), %r14
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r8 # <addr>
               	leaq	<rip>, %r9 # <addr>
               	movl	<rip>, %ebx # <addr>
               	xorl	%eax, %eax
               	movq	%rax, %rsi
               	cmpl	%ebx, %eax
               	jge	<addr>
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	leaq	(%rdi,%rdx), %r12
               	movq	(%r12), %r12
               	leaq	(%r9,%rdx), %r13
               	movq	(%r13), %r13
               	imulq	%r13, %r12
               	imulq	%rcx, %r12
               	addq	%r12, %rsi
               	addq	%r8, %rdx
               	movq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	incq	%rax
               	cmpl	%ebx, %eax
               	jl	<addr>
               	shlq	$0x3, %rsi
               	addq	%rsi, %rax
               	cmpq	%rax, %r14
               	jne	<addr>
               	movq	$-0x2, %rsi
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r8 # <addr>
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
               	movq	%rcx, 0x38(%rsp)
               	movq	%rdi, 0x30(%rsp)
               	movq	%r8, 0x28(%rsp)
               	movq	%rsi, 0x20(%rsp)
               	movq	%rsi, %rdi
               	callq	<addr>
               	movq	%rax, %r14
               	movq	0x38(%rsp), %rcx
               	movq	0x30(%rsp), %rdi
               	movq	0x28(%rsp), %r8
               	movq	0x20(%rsp), %rsi
               	movl	<rip>, %ebx # <addr>
               	xorl	%edx, %edx
               	movq	%rdx, %rax
               	cmpl	%ebx, %edx
               	jge	<addr>
               	movq	(%rcx,%rdx,8), %r9
               	testq	%r9, %r9
               	jl	<addr>
               	movq	%rdx, %r9
               	shlq	$0x3, %r9
               	leaq	(%r8,%r9), %r12
               	movq	(%r12), %r12
               	leaq	(%rcx,%r9), %r13
               	movq	(%r13), %r13
               	imulq	%r13, %r12
               	addq	%r12, %rax
               	addq	%rdi, %r9
               	movq	(%r9), %r9
               	cmpq	%rsi, %r9
               	jl	<addr>
               	incq	%rdx
               	cmpl	%ebx, %edx
               	jl	<addr>
               	shlq	$0x3, %rax
               	addq	%rax, %rdx
               	cmpq	%rdx, %r14
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
               	movq	%rcx, 0x38(%rsp)
               	movq	%rdi, 0x30(%rsp)
               	movq	%r8, 0x28(%rsp)
               	movq	%rsi, 0x20(%rsp)
               	movq	%rsi, %rdi
               	callq	<addr>
               	movq	%rax, %r14
               	movq	0x38(%rsp), %rcx
               	movq	0x30(%rsp), %rdi
               	movq	0x28(%rsp), %r8
               	movq	0x20(%rsp), %rsi
               	movl	<rip>, %ebx # <addr>
               	xorl	%edx, %edx
               	movq	%rdx, %rax
               	cmpl	%ebx, %edx
               	jge	<addr>
               	movq	(%rcx,%rdx,8), %r9
               	testq	%r9, %r9
               	jl	<addr>
               	movq	%rdx, %r9
               	shlq	$0x3, %r9
               	leaq	(%r8,%r9), %r12
               	movq	(%r12), %r12
               	leaq	(%rcx,%r9), %r13
               	movq	(%r13), %r13
               	imulq	%r13, %r12
               	addq	%r12, %rax
               	addq	%rdi, %r9
               	movq	(%r9), %r9
               	cmpq	%rsi, %r9
               	jl	<addr>
               	incq	%rdx
               	cmpl	%ebx, %edx
               	jl	<addr>
               	shlq	$0x3, %rax
               	addq	%rax, %rdx
               	cmpq	%rdx, %r14
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
               	movq	%rcx, 0x38(%rsp)
               	movq	%rdi, 0x30(%rsp)
               	movq	%r8, 0x28(%rsp)
               	movq	%rsi, 0x20(%rsp)
               	movq	%rsi, %rdi
               	callq	<addr>
               	movq	%rax, %r14
               	movq	0x38(%rsp), %rcx
               	movq	0x30(%rsp), %rdi
               	movq	0x28(%rsp), %r8
               	movq	0x20(%rsp), %rsi
               	movl	<rip>, %ebx # <addr>
               	xorl	%edx, %edx
               	movq	%rdx, %rax
               	cmpl	%ebx, %edx
               	jge	<addr>
               	movq	(%rcx,%rdx,8), %r9
               	testq	%r9, %r9
               	jl	<addr>
               	movq	%rdx, %r9
               	shlq	$0x3, %r9
               	leaq	(%r8,%r9), %r12
               	movq	(%r12), %r12
               	leaq	(%rcx,%r9), %r13
               	movq	(%r13), %r13
               	imulq	%r13, %r12
               	addq	%r12, %rax
               	addq	%rdi, %r9
               	movq	(%r9), %r9
               	cmpq	%rsi, %r9
               	jl	<addr>
               	incq	%rdx
               	cmpl	%ebx, %edx
               	jl	<addr>
               	shlq	$0x3, %rax
               	addq	%rax, %rdx
               	cmpq	%rdx, %r14
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
               	movq	%rcx, 0x38(%rsp)
               	movq	%rdi, 0x30(%rsp)
               	movq	%r8, 0x28(%rsp)
               	movq	%rsi, 0x20(%rsp)
               	movq	%rsi, %rdi
               	callq	<addr>
               	movq	%rax, %r14
               	movq	0x38(%rsp), %rcx
               	movq	0x30(%rsp), %rdi
               	movq	0x28(%rsp), %r8
               	movq	0x20(%rsp), %rsi
               	movl	<rip>, %ebx # <addr>
               	xorl	%edx, %edx
               	movq	%rdx, %rax
               	cmpl	%ebx, %edx
               	jge	<addr>
               	movq	(%rcx,%rdx,8), %r9
               	testq	%r9, %r9
               	jl	<addr>
               	movq	%rdx, %r9
               	shlq	$0x3, %r9
               	leaq	(%r8,%r9), %r12
               	movq	(%r12), %r12
               	leaq	(%rcx,%r9), %r13
               	movq	(%r13), %r13
               	imulq	%r13, %r12
               	addq	%r12, %rax
               	addq	%rdi, %r9
               	movq	(%r9), %r9
               	cmpq	%rsi, %r9
               	jl	<addr>
               	incq	%rdx
               	cmpl	%ebx, %edx
               	jl	<addr>
               	shlq	$0x3, %rax
               	addq	%rax, %rdx
               	cmpq	%rdx, %r14
               	je	<addr>
               	jmp	<addr>
               	negq	%rax
               	subq	%rdx, %rax
               	leaq	-0x1(%rax), %rdx
               	jmp	<addr>
               	negq	%rax
               	subq	%rdx, %rax
               	leaq	-0x1(%rax), %rdx
               	jmp	<addr>
               	negq	%rax
               	subq	%rdx, %rax
               	leaq	-0x1(%rax), %rdx
               	jmp	<addr>
               	negq	%rax
               	subq	%rdx, %rax
               	leaq	-0x1(%rax), %rdx
               	jmp	<addr>
               	incq	%rsi
               	cmpl	$0x2, %esi
               	jle	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x9, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0x2, %edx
               	movq	<rip>, %rsi # <addr>
               	movq	<rip>, %rdi # <addr>
               	imulq	%rdi, %rsi
               	imulq	%rcx, %rsi
               	addq	%rsi, %rax
               	movq	<rip>, %rsi # <addr>
               	testq	%rsi, %rsi
               	jl	<addr>
               	movl	$0x3, %edx
               	movq	<rip>, %rsi # <addr>
               	movq	<rip>, %rdi # <addr>
               	imulq	%rdi, %rsi
               	imulq	%rcx, %rsi
               	addq	%rsi, %rax
               	movq	<rip>, %rsi # <addr>
               	testq	%rsi, %rsi
               	jl	<addr>
               	movl	$0x4, %edx
               	jmp	<addr>
               	movl	$0x2, %edx
               	movq	<rip>, %rsi # <addr>
               	movq	<rip>, %rdi # <addr>
               	imulq	%rdi, %rsi
               	imulq	%rcx, %rsi
               	addq	%rsi, %rax
               	movq	<rip>, %rsi # <addr>
               	testq	%rsi, %rsi
               	jl	<addr>
               	movl	$0x3, %edx
               	movq	<rip>, %rsi # <addr>
               	movq	<rip>, %rdi # <addr>
               	imulq	%rdi, %rsi
               	imulq	%rcx, %rsi
               	addq	%rsi, %rax
               	movq	<rip>, %rsi # <addr>
               	testq	%rsi, %rsi
               	jl	<addr>
               	movl	$0x4, %edx
               	jmp	<addr>
               	movl	$0x2, %edx
               	movq	<rip>, %rsi # <addr>
               	movq	<rip>, %rdi # <addr>
               	imulq	%rdi, %rsi
               	imulq	%rcx, %rsi
               	addq	%rsi, %rax
               	movq	<rip>, %rsi # <addr>
               	testq	%rsi, %rsi
               	jl	<addr>
               	movl	$0x3, %edx
               	movq	<rip>, %rsi # <addr>
               	movq	<rip>, %rdi # <addr>
               	imulq	%rdi, %rsi
               	imulq	%rcx, %rsi
               	addq	%rsi, %rax
               	movq	<rip>, %rsi # <addr>
               	testq	%rsi, %rsi
               	jl	<addr>
               	movl	$0x4, %edx
               	jmp	<addr>
               	movl	$0x2, %ecx
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rsi # <addr>
               	imulq	%rsi, %rdx
               	shlq	%rdx
               	addq	%rdx, %rax
               	movq	<rip>, %rdx # <addr>
               	testq	%rdx, %rdx
               	jl	<addr>
               	movl	$0x3, %ecx
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rsi # <addr>
               	imulq	%rsi, %rdx
               	shlq	%rdx
               	addq	%rdx, %rax
               	movq	<rip>, %rdx # <addr>
               	testq	%rdx, %rdx
               	jl	<addr>
               	movl	$0x4, %ecx
               	jmp	<addr>
               	movl	$0x2, %ecx
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rsi # <addr>
               	imulq	%rsi, %rdx
               	shlq	%rdx
               	addq	%rdx, %rax
               	movq	<rip>, %rdx # <addr>
               	testq	%rdx, %rdx
               	jl	<addr>
               	movl	$0x3, %ecx
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rsi # <addr>
               	imulq	%rsi, %rdx
               	shlq	%rdx
               	addq	%rdx, %rax
               	movq	<rip>, %rdx # <addr>
               	testq	%rdx, %rdx
               	jl	<addr>
               	movl	$0x4, %ecx
               	jmp	<addr>
               	movl	$0x2, %eax
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rsi # <addr>
               	imulq	%rsi, %rdx
               	shlq	%rdx
               	addq	%rdx, %rcx
               	movq	<rip>, %rdx # <addr>
               	testq	%rdx, %rdx
               	jl	<addr>
               	movl	$0x3, %eax
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rsi # <addr>
               	imulq	%rsi, %rdx
               	shlq	%rdx
               	addq	%rdx, %rcx
               	movq	<rip>, %rdx # <addr>
               	testq	%rdx, %rdx
               	jl	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	movl	$0x2, %ecx
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rsi # <addr>
               	imulq	%rsi, %rdx
               	addq	%rdx, %rax
               	movq	<rip>, %rdx # <addr>
               	testq	%rdx, %rdx
               	jl	<addr>
               	movl	$0x3, %ecx
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rsi # <addr>
               	imulq	%rsi, %rdx
               	addq	%rdx, %rax
               	movq	<rip>, %rdx # <addr>
               	testq	%rdx, %rdx
               	jl	<addr>
               	movl	$0x4, %ecx
               	jmp	<addr>
               	movl	$0x2, %ecx
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rsi # <addr>
               	imulq	%rsi, %rdx
               	addq	%rdx, %rax
               	movq	<rip>, %rdx # <addr>
               	testq	%rdx, %rdx
               	jl	<addr>
               	movl	$0x3, %ecx
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rsi # <addr>
               	imulq	%rsi, %rdx
               	addq	%rdx, %rax
               	movq	<rip>, %rdx # <addr>
               	testq	%rdx, %rdx
               	jl	<addr>
               	movl	$0x4, %ecx
               	jmp	<addr>
               	movl	$0x2, %eax
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rsi # <addr>
               	imulq	%rsi, %rdx
               	addq	%rdx, %rcx
               	movq	<rip>, %rdx # <addr>
               	testq	%rdx, %rdx
               	jl	<addr>
               	movl	$0x3, %eax
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rsi # <addr>
               	imulq	%rsi, %rdx
               	addq	%rdx, %rcx
               	movq	<rip>, %rdx # <addr>
               	testq	%rdx, %rdx
               	jl	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	movl	$0x2, %eax
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rsi # <addr>
               	imulq	%rsi, %rdx
               	shlq	%rdx
               	addq	%rdx, %rcx
               	movq	<rip>, %rdx # <addr>
               	testq	%rdx, %rdx
               	jl	<addr>
               	movl	$0x3, %eax
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rsi # <addr>
               	imulq	%rsi, %rdx
               	shlq	%rdx
               	addq	%rdx, %rcx
               	movq	<rip>, %rdx # <addr>
               	testq	%rdx, %rdx
               	jl	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
