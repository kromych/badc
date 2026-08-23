
sizeof_pointer_to_array_subscript.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx
               	leaq	<rip>, %r8
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdi
               	leaq	0x8(%rax), %r9
               	movq	%rax, %r10
               	movq	%r9, %rax
               	subq	%r10, %rax
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0x10(%rcx), %rax
               	subq	%rcx, %rax
               	cmpq	$0x10, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0x20(%rdx), %rax
               	subq	%rdx, %rax
               	cmpq	$0x20, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0x40(%r8), %rax
               	subq	%r8, %rax
               	cmpq	$0x40, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0x3c(%rsi), %rax
               	subq	%rsi, %rax
               	cmpq	$0x3c, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0x14(%rsi), %rax
               	subq	%rsi, %rax
               	cmpq	$0x14, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0x18(%rdi), %rax
               	subq	%rdi, %rax
               	cmpq	$0x18, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0xc(%rdi), %rax
               	subq	%rdi, %rax
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0x4(%rdi), %rax
               	subq	%rdi, %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x13, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	(%rcx), %rax
               	movl	$0x3e8, %edx            # imm = 0x3E8
               	movw	%dx, (%rax)
               	movl	$0x3e9, %eax            # imm = 0x3E9
               	movw	%ax, 0x2(%rcx)
               	movl	$0x3ea, %eax            # imm = 0x3EA
               	movw	%ax, 0x4(%rcx)
               	movl	$0x3eb, %eax            # imm = 0x3EB
               	movw	%ax, 0x6(%rcx)
               	movl	$0x3ec, %eax            # imm = 0x3EC
               	movw	%ax, 0x8(%rcx)
               	movl	$0x3ed, %eax            # imm = 0x3ED
               	movw	%ax, 0xa(%rcx)
               	movl	$0x3ee, %eax            # imm = 0x3EE
               	movw	%ax, 0xc(%rcx)
               	movl	$0x3ef, %eax            # imm = 0x3EF
               	movw	%ax, 0xe(%rcx)
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rdx
               	movswq	(%rcx,%rdx,2), %r9
               	leaq	0x3e8(%rdx), %r8
               	movslq	%r8d, %rbx
               	movswq	%bx, %r8
               	cmpl	%r8d, %r9d
               	jne	<addr>
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rdx
               	movswq	(%rcx,%rdx,2), %r9
               	leaq	0x3e8(%rdx), %r8
               	movslq	%r8d, %rbx
               	movswq	%bx, %r8
               	cmpl	%r8d, %r9d
               	jne	<addr>
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	imulq	$0x14, %rax, %r8
               	leaq	(%rsi,%r8), %r9
               	leaq	(%r9), %r12
               	imulq	$0x64, %rax, %rdx
               	leaq	(%rdx), %rbx
               	movl	%ebx, (%r12)
               	leaq	0x1(%rdx), %rbx
               	movl	%ebx, 0x4(%r9)
               	addq	%rsi, %r8
               	addq	$0x2, %rdx
               	movl	%edx, 0x8(%r8)
               	imulq	$0x14, %rax, %rbx
               	leaq	(%rsi,%rbx), %r8
               	imulq	$0x64, %rax, %rdx
               	leaq	0x3(%rdx), %r9
               	movl	%r9d, 0xc(%r8)
               	addq	$0x4, %rdx
               	movl	%edx, 0x10(%r8)
               	leaq	0x1(%rax), %rcx
               	cmpl	$0x3, %ecx
               	jl	<addr>
               	xorq	%r9, %r9
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%r9d, %rdx
               	imulq	$0x14, %rdx, %rcx
               	leaq	(%rsi,%rcx), %r8
               	movslq	%eax, %rcx
               	movslq	(%r8,%rcx,4), %r8
               	imulq	$0x64, %rdx, %rdx
               	addq	%rcx, %rdx
               	cmpl	%edx, %r8d
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x5, %eax
               	jl	<addr>
               	movslq	%r9d, %rax
               	leaq	0x1(%rax), %r9
               	cmpl	$0x3, %r9d
               	jl	<addr>
               	xorq	%r9, %r9
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%r9d, %rdx
               	imulq	$0x14, %rdx, %rcx
               	leaq	(%rsi,%rcx), %r8
               	movslq	%eax, %rcx
               	movslq	(%r8,%rcx,4), %r8
               	imulq	$0x64, %rdx, %rdx
               	addq	%rcx, %rdx
               	cmpl	%edx, %r8d
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x5, %eax
               	jl	<addr>
               	movslq	%r9d, %rax
               	leaq	0x1(%rax), %r9
               	cmpl	$0x3, %r9d
               	jl	<addr>
               	xorq	%r8, %r8
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	%r8d, %r9
               	imulq	$0xc, %r9, %rax
               	leaq	(%rdi,%rax), %rbx
               	movslq	%ecx, %rsi
               	movq	%rsi, %rdx
               	shlq	$0x2, %rdx
               	leaq	(%rbx,%rdx), %r12
               	leaq	(%r12), %r13
               	addq	%rax, %rdx
               	addq	$0x0, %rdx
               	movslq	%edx, %r12
               	movb	%r12b, (%r13)
               	movq	%rsi, %rdx
               	shlq	$0x2, %rdx
               	leaq	(%rbx,%rdx), %r12
               	leaq	(%rax,%rdx), %rbx
               	incq	%rbx
               	movslq	%ebx, %r13
               	movb	%r13b, 0x1(%r12)
               	leaq	(%rdi,%rax), %rbx
               	addq	%rdx, %rbx
               	addq	%rdx, %rax
               	addq	$0x2, %rax
               	movslq	%eax, %rdx
               	movb	%dl, 0x2(%rbx)
               	imulq	$0xc, %r9, %rax
               	leaq	(%rdi,%rax), %r9
               	movq	%rsi, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %r9
               	addq	%rdx, %rax
               	addq	$0x3, %rax
               	movslq	%eax, %rdx
               	movb	%dl, 0x3(%r9)
               	leaq	0x1(%rsi), %rcx
               	cmpl	$0x3, %ecx
               	jl	<addr>
               	movslq	%r8d, %rax
               	leaq	0x1(%rax), %r8
               	cmpl	$0x2, %r8d
               	jl	<addr>
               	xorq	%r9, %r9
               	jmp	<addr>
               	xorq	%r8, %r8
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%r9d, %rcx
               	imulq	$0xc, %rcx, %rcx
               	leaq	(%rdi,%rcx), %rsi
               	movslq	%r8d, %rdx
               	shlq	$0x2, %rdx
               	leaq	(%rsi,%rdx), %rbx
               	movslq	%eax, %rsi
               	addq	%rsi, %rbx
               	movsbq	(%rbx), %rbx
               	addq	%rdx, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rdx
               	movsbq	%dl, %rcx
               	cmpl	%ecx, %ebx
               	jne	<addr>
               	leaq	0x1(%rsi), %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movslq	%r8d, %rax
               	leaq	0x1(%rax), %r8
               	cmpl	$0x3, %r8d
               	jl	<addr>
               	movslq	%r9d, %rax
               	leaq	0x1(%rax), %r9
               	cmpl	$0x2, %r9d
               	jl	<addr>
               	xorq	%r9, %r9
               	jmp	<addr>
               	xorq	%r8, %r8
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%r9d, %rcx
               	imulq	$0xc, %rcx, %rcx
               	leaq	(%rdi,%rcx), %rsi
               	movslq	%r8d, %rdx
               	shlq	$0x2, %rdx
               	leaq	(%rsi,%rdx), %rbx
               	movslq	%eax, %rsi
               	addq	%rsi, %rbx
               	movsbq	(%rbx), %rbx
               	addq	%rdx, %rcx
               	addq	%rsi, %rcx
               	movslq	%ecx, %rdx
               	movsbq	%dl, %rcx
               	cmpl	%ecx, %ebx
               	jne	<addr>
               	leaq	0x1(%rsi), %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movslq	%r8d, %rax
               	leaq	0x1(%rax), %r8
               	cmpl	$0x3, %r8d
               	jl	<addr>
               	movslq	%r9d, %rax
               	leaq	0x1(%rax), %r9
               	cmpl	$0x2, %r9d
               	jl	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	imulq	$0xc, %r9, %rcx
               	addq	$0x6e, %rcx
               	movq	%r8, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	imulq	$0xc, %r9, %rcx
               	addq	$0x50, %rcx
               	movq	%r8, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	(%r9,%r9,4), %rcx
               	addq	$0x3c, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	(%r9,%r9,4), %rcx
               	addq	$0x28, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addq	$0x1c, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addq	$0x14, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
