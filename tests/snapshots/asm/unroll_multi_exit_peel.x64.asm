
unroll_multi_exit_peel.x64:	file format elf64-x86-64

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

<scan_peeled>:
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	testq	%rcx, %rcx
               	jge	<addr>
               	movq	%rax, %rcx
               	negq	%rcx
               	subq	%rax, %rcx
               	leaq	-0x1(%rcx), %rax
               	retq
               	movq	<rip>, %rdx # <addr>
               	imulq	%rdx, %rcx
               	movq	<rip>, %rdx # <addr>
               	cmpq	%rdi, %rdx
               	jge	<addr>
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	retq
               	movl	$0x1, %eax
               	movq	<rip>, %rdx # <addr>
               	testq	%rdx, %rdx
               	jl	<addr>
               	movq	<rip>, %rsi # <addr>
               	imulq	%rsi, %rdx
               	addq	%rdx, %rcx
               	movq	<rip>, %rdx # <addr>
               	cmpq	%rdi, %rdx
               	jl	<addr>
               	movl	$0x2, %eax
               	movq	<rip>, %rdx # <addr>
               	testq	%rdx, %rdx
               	jl	<addr>
               	movq	<rip>, %rsi # <addr>
               	imulq	%rsi, %rdx
               	addq	%rdx, %rcx
               	movq	<rip>, %rdx # <addr>
               	cmpq	%rdi, %rdx
               	jl	<addr>
               	movl	$0x3, %eax
               	movq	<rip>, %rdx # <addr>
               	testq	%rdx, %rdx
               	jl	<addr>
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rsi # <addr>
               	imulq	%rsi, %rdx
               	addq	%rdx, %rcx
               	movq	<rip>, %rdx # <addr>
               	cmpq	%rdi, %rdx
               	jl	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>

<main>:
               	subq	$0x38, %rsp
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
               	addq	$0x38, %rsp
               	retq
               	movq	$-0x2, %rdi
               	callq	<addr>
               	cmpq	$0x870c, %rax           # imm = 0x870C
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x38, %rsp
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
               	leaq	(%rcx,%rax), %r12
               	leaq	<rip>, %rdx # <addr>
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdi # <addr>
               	movl	<rip>, %r8d # <addr>
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	cmpl	%r8d, %eax
               	jge	<addr>
               	movq	(%rdx,%rax,8), %r9
               	movq	(%rdi,%rax,8), %rbx
               	imulq	%rbx, %r9
               	addq	%r9, %rcx
               	movq	(%rsi,%rax,8), %r9
               	nopl	(%rax,%rax)
               	testq	%r9, %r9
               	jl	<addr>
               	incq	%rax
               	cmpl	%r8d, %eax
               	jl	<addr>
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	cmpq	%rax, %r12
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x38, %rsp
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
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdx # <addr>
               	imulq	%rdx, %rcx
               	addq	%rcx, %rax
               	movl	$0x2, %ecx
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rsi # <addr>
               	imulq	%rsi, %rdx
               	addq	%rdx, %rax
               	movq	<rip>, %rdx # <addr>
               	testq	%rdx, %rdx
               	jge	<addr>
               	shlq	$0x3, %rax
               	leaq	(%rax,%rcx), %r12
               	leaq	<rip>, %rdx # <addr>
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdi # <addr>
               	movl	<rip>, %r8d # <addr>
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	cmpl	%r8d, %eax
               	jge	<addr>
               	movq	(%rdx,%rax,8), %r9
               	movq	(%rdi,%rax,8), %rbx
               	imulq	%rbx, %r9
               	addq	%r9, %rcx
               	movq	(%rsi,%rax,8), %r9
               	nopl	(%rax)
               	testq	%r9, %r9
               	jl	<addr>
               	incq	%rax
               	cmpl	%r8d, %eax
               	jl	<addr>
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	cmpq	%rax, %r12
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x38, %rsp
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
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdx # <addr>
               	imulq	%rdx, %rcx
               	addq	%rcx, %rax
               	movl	$0x2, %ecx
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rsi # <addr>
               	imulq	%rsi, %rdx
               	addq	%rdx, %rax
               	movq	<rip>, %rdx # <addr>
               	testq	%rdx, %rdx
               	jge	<addr>
               	shlq	$0x3, %rax
               	leaq	(%rax,%rcx), %r12
               	leaq	<rip>, %rdx # <addr>
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdi # <addr>
               	movl	<rip>, %r8d # <addr>
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	cmpl	%r8d, %eax
               	jge	<addr>
               	movq	(%rdx,%rax,8), %r9
               	movq	(%rdi,%rax,8), %rbx
               	imulq	%rbx, %r9
               	addq	%r9, %rcx
               	movq	(%rsi,%rax,8), %r9
               	nopl	(%rax)
               	testq	%r9, %r9
               	jl	<addr>
               	incq	%rax
               	cmpl	%r8d, %eax
               	jl	<addr>
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	cmpq	%rax, %r12
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x38, %rsp
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
               	leaq	(%rcx,%rax), %r12
               	leaq	<rip>, %rdx # <addr>
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdi # <addr>
               	movl	<rip>, %r8d # <addr>
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	cmpl	%r8d, %eax
               	jge	<addr>
               	movq	(%rdx,%rax,8), %r9
               	movq	(%rdi,%rax,8), %rbx
               	imulq	%rbx, %r9
               	shlq	%r9
               	addq	%r9, %rcx
               	movq	(%rsi,%rax,8), %r9
               	nopl	(%rax,%rax)
               	testq	%r9, %r9
               	jl	<addr>
               	incq	%rax
               	cmpl	%r8d, %eax
               	jl	<addr>
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	cmpq	%rax, %r12
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
               	leaq	(%rax,%rcx), %r12
               	leaq	<rip>, %rdx # <addr>
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdi # <addr>
               	movl	<rip>, %r8d # <addr>
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	cmpl	%r8d, %eax
               	jge	<addr>
               	movq	(%rdx,%rax,8), %r9
               	movq	(%rdi,%rax,8), %rbx
               	imulq	%rbx, %r9
               	shlq	%r9
               	addq	%r9, %rcx
               	movq	(%rsi,%rax,8), %r9
               	testq	%r9, %r9
               	jl	<addr>
               	incq	%rax
               	cmpl	%r8d, %eax
               	jl	<addr>
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	cmpq	%rax, %r12
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
               	leaq	(%rax,%rcx), %r12
               	leaq	<rip>, %rdx # <addr>
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdi # <addr>
               	movl	<rip>, %r8d # <addr>
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	cmpl	%r8d, %eax
               	jge	<addr>
               	movq	(%rdx,%rax,8), %r9
               	movq	(%rdi,%rax,8), %rbx
               	imulq	%rbx, %r9
               	shlq	%r9
               	addq	%r9, %rcx
               	movq	(%rsi,%rax,8), %r9
               	testq	%r9, %r9
               	jl	<addr>
               	incq	%rax
               	cmpl	%r8d, %eax
               	jl	<addr>
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	cmpq	%rax, %r12
               	jne	<addr>
               	movl	$0x3, %eax
               	movq	$0x1, <rip> # <addr>
               	movq	$0x2, <rip> # <addr>
               	movq	%rax, <rip> # <addr>
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
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdx # <addr>
               	imulq	%rdx, %rcx
               	imulq	%rax, %rcx
               	movl	$0x1, %edx
               	movq	<rip>, %rsi # <addr>
               	movq	<rip>, %rdi # <addr>
               	imulq	%rdi, %rsi
               	imulq	%rax, %rsi
               	addq	%rsi, %rcx
               	movq	<rip>, %rsi # <addr>
               	testq	%rsi, %rsi
               	jge	<addr>
               	shlq	$0x3, %rcx
               	leaq	(%rcx,%rdx), %r10
               	movq	%r10, 0x38(%rsp)
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r8 # <addr>
               	movl	<rip>, %r9d # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	cmpl	%r9d, %ecx
               	jge	<addr>
               	movq	(%rsi,%rcx,8), %rbx
               	movq	(%r8,%rcx,8), %r12
               	imulq	%r12, %rbx
               	imulq	%rax, %rbx
               	addq	%rbx, %rdx
               	movq	(%rdi,%rcx,8), %rbx
               	nop
               	testq	%rbx, %rbx
               	jl	<addr>
               	incq	%rcx
               	cmpl	%r9d, %ecx
               	jl	<addr>
               	shlq	$0x3, %rdx
               	addq	%rdx, %rcx
               	movq	%rcx, %r10
               	movq	0x38(%rsp), %rcx
               	cmpq	%r10, %rcx
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
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdx # <addr>
               	imulq	%rdx, %rcx
               	imulq	%rax, %rcx
               	movl	$0x1, %edx
               	movq	<rip>, %rsi # <addr>
               	movq	<rip>, %rdi # <addr>
               	imulq	%rdi, %rsi
               	imulq	%rax, %rsi
               	addq	%rsi, %rcx
               	movq	<rip>, %rsi # <addr>
               	testq	%rsi, %rsi
               	jge	<addr>
               	shlq	$0x3, %rcx
               	leaq	(%rcx,%rdx), %r10
               	movq	%r10, 0x38(%rsp)
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r8 # <addr>
               	movl	<rip>, %r9d # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	cmpl	%r9d, %ecx
               	jge	<addr>
               	movq	(%rsi,%rcx,8), %rbx
               	movq	(%r8,%rcx,8), %r12
               	imulq	%r12, %rbx
               	imulq	%rax, %rbx
               	addq	%rbx, %rdx
               	movq	(%rdi,%rcx,8), %rbx
               	nopw	(%rax,%rax)
               	testq	%rbx, %rbx
               	jl	<addr>
               	incq	%rcx
               	cmpl	%r9d, %ecx
               	jl	<addr>
               	shlq	$0x3, %rdx
               	addq	%rdx, %rcx
               	movq	%rcx, %r10
               	movq	0x38(%rsp), %rcx
               	cmpq	%r10, %rcx
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
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdx # <addr>
               	imulq	%rdx, %rcx
               	imulq	%rax, %rcx
               	movl	$0x1, %edx
               	movq	<rip>, %rsi # <addr>
               	movq	<rip>, %rdi # <addr>
               	imulq	%rdi, %rsi
               	imulq	%rax, %rsi
               	addq	%rsi, %rcx
               	movq	<rip>, %rsi # <addr>
               	testq	%rsi, %rsi
               	jge	<addr>
               	shlq	$0x3, %rcx
               	leaq	(%rcx,%rdx), %r10
               	movq	%r10, 0x38(%rsp)
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r8 # <addr>
               	movl	<rip>, %r9d # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	cmpl	%r9d, %ecx
               	jge	<addr>
               	movq	(%rsi,%rcx,8), %rbx
               	movq	(%r8,%rcx,8), %r12
               	imulq	%r12, %rbx
               	imulq	%rax, %rbx
               	addq	%rbx, %rdx
               	movq	(%rdi,%rcx,8), %rbx
               	nopw	(%rax,%rax)
               	testq	%rbx, %rbx
               	jl	<addr>
               	incq	%rcx
               	cmpl	%r9d, %ecx
               	jl	<addr>
               	shlq	$0x3, %rdx
               	leaq	(%rdx,%rcx), %rax
               	movq	%rax, %r10
               	movq	0x38(%rsp), %rax
               	cmpq	%r10, %rax
               	jne	<addr>
               	movq	$-0x2, %rdx
               	leaq	<rip>, %rbx # <addr>
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdi # <addr>
               	movq	%rsi, 0x28(%rsp)
               	movq	%rdi, 0x20(%rsp)
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
               	movq	%rdx, 0x18(%rsp)
               	movq	%rdx, %rdi
               	callq	<addr>
               	movq	%rax, 0x38(%rsp)
               	movq	0x28(%rsp), %rsi
               	movq	0x20(%rsp), %rdi
               	movq	0x18(%rsp), %rdx
               	movl	<rip>, %eax # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %r8
               	nopl	(%rax)
               	cmpl	%eax, %ecx
               	jge	<addr>
               	movq	(%rbx,%rcx,8), %r9
               	testq	%r9, %r9
               	jl	<addr>
               	movq	(%rdi,%rcx,8), %r12
               	imulq	%r12, %r9
               	addq	%r9, %r8
               	movq	(%rsi,%rcx,8), %r9
               	cmpq	%rdx, %r9
               	jl	<addr>
               	incq	%rcx
               	cmpl	%eax, %ecx
               	jl	<addr>
               	shlq	$0x3, %r8
               	addq	%r8, %rcx
               	nopw	%cs:(%rax,%rax)
               	nop
               	movq	0x38(%rsp), %rax
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
               	movq	%rdx, 0x18(%rsp)
               	movq	%rdx, %rdi
               	callq	<addr>
               	movq	%rax, 0x38(%rsp)
               	movq	0x28(%rsp), %rsi
               	movq	0x20(%rsp), %rdi
               	movq	0x18(%rsp), %rdx
               	movl	<rip>, %eax # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %r8
               	nop
               	cmpl	%eax, %ecx
               	jge	<addr>
               	movq	(%rbx,%rcx,8), %r9
               	testq	%r9, %r9
               	jl	<addr>
               	movq	(%rdi,%rcx,8), %r12
               	imulq	%r12, %r9
               	addq	%r9, %r8
               	movq	(%rsi,%rcx,8), %r9
               	cmpq	%rdx, %r9
               	jl	<addr>
               	incq	%rcx
               	cmpl	%eax, %ecx
               	jl	<addr>
               	shlq	$0x3, %r8
               	addq	%r8, %rcx
               	nopw	%cs:(%rax,%rax)
               	nop
               	movq	0x38(%rsp), %rax
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
               	movq	%rdx, 0x18(%rsp)
               	movq	%rdx, %rdi
               	callq	<addr>
               	movq	%rax, 0x38(%rsp)
               	movq	0x28(%rsp), %rsi
               	movq	0x20(%rsp), %rdi
               	movq	0x18(%rsp), %rdx
               	movl	<rip>, %eax # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %r8
               	nop
               	cmpl	%eax, %ecx
               	jge	<addr>
               	movq	(%rbx,%rcx,8), %r9
               	testq	%r9, %r9
               	jl	<addr>
               	movq	(%rdi,%rcx,8), %r12
               	imulq	%r12, %r9
               	addq	%r9, %r8
               	movq	(%rsi,%rcx,8), %r9
               	cmpq	%rdx, %r9
               	jl	<addr>
               	incq	%rcx
               	cmpl	%eax, %ecx
               	jl	<addr>
               	shlq	$0x3, %r8
               	addq	%r8, %rcx
               	nopw	%cs:(%rax,%rax)
               	nop
               	movq	0x38(%rsp), %rax
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
               	movq	%rdx, 0x18(%rsp)
               	movq	%rdx, %rdi
               	callq	<addr>
               	movq	%rax, 0x38(%rsp)
               	movq	0x28(%rsp), %rsi
               	movq	0x20(%rsp), %rdi
               	movq	0x18(%rsp), %rdx
               	movl	<rip>, %eax # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %r8
               	nop
               	cmpl	%eax, %ecx
               	jge	<addr>
               	movq	(%rbx,%rcx,8), %r9
               	testq	%r9, %r9
               	jl	<addr>
               	movq	(%rdi,%rcx,8), %r12
               	imulq	%r12, %r9
               	addq	%r9, %r8
               	movq	(%rsi,%rcx,8), %r9
               	nopl	(%rax)
               	cmpq	%rdx, %r9
               	jl	<addr>
               	incq	%rcx
               	cmpl	%eax, %ecx
               	jl	<addr>
               	shlq	$0x3, %r8
               	addq	%r8, %rcx
               	nopw	%cs:(%rax,%rax)
               	nop
               	movq	0x38(%rsp), %rax
               	cmpq	%rcx, %rax
               	je	<addr>
               	jmp	<addr>
               	movq	%r8, %rax
               	negq	%rax
               	subq	%rcx, %rax
               	leaq	-0x1(%rax), %rcx
               	nopl	(%rax)
               	jmp	<addr>
               	movq	%r8, %rax
               	negq	%rax
               	subq	%rcx, %rax
               	leaq	-0x1(%rax), %rcx
               	jmp	<addr>
               	movq	%r8, %rax
               	negq	%rax
               	subq	%rcx, %rax
               	leaq	-0x1(%rax), %rcx
               	jmp	<addr>
               	movq	%r8, %rax
               	negq	%rax
               	subq	%rcx, %rax
               	leaq	-0x1(%rax), %rcx
               	jmp	<addr>
               	incq	%rdx
               	nopl	(%rax,%rax)
               	cmpl	$0x2, %edx
               	jle	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x38, %rsp
               	retq
               	movl	$0x9, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x38, %rsp
               	retq
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x38, %rsp
               	retq
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x38, %rsp
               	retq
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x38, %rsp
               	retq
               	movl	$0x2, %edx
               	movq	<rip>, %rsi # <addr>
               	movq	<rip>, %rdi # <addr>
               	imulq	%rdi, %rsi
               	imulq	%rax, %rsi
               	addq	%rsi, %rcx
               	movq	<rip>, %rsi # <addr>
               	testq	%rsi, %rsi
               	jl	<addr>
               	movl	$0x3, %edx
               	movq	<rip>, %rsi # <addr>
               	movq	<rip>, %rdi # <addr>
               	imulq	%rdi, %rsi
               	imulq	%rax, %rsi
               	addq	%rsi, %rcx
               	movq	<rip>, %rsi # <addr>
               	testq	%rsi, %rsi
               	jl	<addr>
               	movl	$0x4, %edx
               	jmp	<addr>
               	movl	$0x2, %edx
               	movq	<rip>, %rsi # <addr>
               	movq	<rip>, %rdi # <addr>
               	imulq	%rdi, %rsi
               	imulq	%rax, %rsi
               	addq	%rsi, %rcx
               	movq	<rip>, %rsi # <addr>
               	testq	%rsi, %rsi
               	jl	<addr>
               	movl	$0x3, %edx
               	movq	<rip>, %rsi # <addr>
               	movq	<rip>, %rdi # <addr>
               	imulq	%rdi, %rsi
               	imulq	%rax, %rsi
               	addq	%rsi, %rcx
               	movq	<rip>, %rsi # <addr>
               	testq	%rsi, %rsi
               	jl	<addr>
               	movl	$0x4, %edx
               	jmp	<addr>
               	movl	$0x2, %edx
               	movq	<rip>, %rsi # <addr>
               	movq	<rip>, %rdi # <addr>
               	imulq	%rdi, %rsi
               	imulq	%rax, %rsi
               	addq	%rsi, %rcx
               	movq	<rip>, %rsi # <addr>
               	testq	%rsi, %rsi
               	jl	<addr>
               	movl	$0x3, %edx
               	movq	<rip>, %rsi # <addr>
               	movq	<rip>, %rdi # <addr>
               	imulq	%rdi, %rsi
               	imulq	%rax, %rsi
               	addq	%rsi, %rcx
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
