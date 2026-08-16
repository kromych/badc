
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
               	movq	%r14, 0x18(%rsp)
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rax
               	leaq	<rip>, %rdx
               	leaq	<rip>, %r8
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdi
               	leaq	0x8(%rcx), %r9
               	movq	%rcx, %r10
               	movq	%r9, %rcx
               	subq	%r10, %rcx
               	cmpq	$0x8, %rcx
               	je	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0x10(%rax), %rcx
               	subq	%rax, %rcx
               	cmpq	$0x10, %rcx
               	je	<addr>
               	movl	$0xc, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0x20(%rdx), %rcx
               	subq	%rdx, %rcx
               	cmpq	$0x20, %rcx
               	je	<addr>
               	movl	$0xd, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0x40(%r8), %rcx
               	subq	%r8, %rcx
               	cmpq	$0x40, %rcx
               	je	<addr>
               	movl	$0xe, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0x3c(%rsi), %rcx
               	subq	%rsi, %rcx
               	cmpq	$0x3c, %rcx
               	je	<addr>
               	movl	$0xf, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0x14(%rsi), %rcx
               	subq	%rsi, %rcx
               	cmpq	$0x14, %rcx
               	je	<addr>
               	movl	$0x10, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0x18(%rdi), %rcx
               	subq	%rdi, %rcx
               	cmpq	$0x18, %rcx
               	je	<addr>
               	movl	$0x11, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0xc(%rdi), %rcx
               	subq	%rdi, %rcx
               	cmpq	$0xc, %rcx
               	je	<addr>
               	movl	$0x12, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0x4(%rdi), %rcx
               	subq	%rdi, %rcx
               	cmpq	$0x4, %rcx
               	je	<addr>
               	movl	$0x13, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	(%rax), %rcx
               	movl	$0x3e8, %edx            # imm = 0x3E8
               	movw	%dx, (%rcx)
               	movl	$0x3e9, %ecx            # imm = 0x3E9
               	movw	%cx, 0x2(%rax)
               	movl	$0x3ea, %ecx            # imm = 0x3EA
               	movw	%cx, 0x4(%rax)
               	movl	$0x3eb, %ecx            # imm = 0x3EB
               	movw	%cx, 0x6(%rax)
               	movl	$0x3ec, %ecx            # imm = 0x3EC
               	movw	%cx, 0x8(%rax)
               	movl	$0x3ed, %ecx            # imm = 0x3ED
               	movw	%cx, 0xa(%rax)
               	movl	$0x3ee, %ecx            # imm = 0x3EE
               	movw	%cx, 0xc(%rax)
               	movl	$0x3ef, %ecx            # imm = 0x3EF
               	movw	%cx, 0xe(%rax)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movswq	(%rax,%rdx,2), %r9
               	leaq	0x3e8(%rdx), %r8
               	movslq	%r8d, %rbx
               	movswq	%bx, %r8
               	cmpq	%r8, %r9
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	movslq	%ecx, %rdx
               	cmpq	$0x8, %rdx
               	jl	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movswq	(%rax,%rdx,2), %r9
               	leaq	0x3e8(%rdx), %r8
               	movslq	%r8d, %rbx
               	movswq	%bx, %r8
               	cmpq	%r8, %r9
               	jne	<addr>
               	leaq	0x1(%rdx), %rcx
               	movslq	%ecx, %rdx
               	cmpq	$0x8, %rdx
               	jl	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	imulq	$0x14, %rax, %rdx
               	addq	%rsi, %rdx
               	leaq	(%rdx), %r8
               	imulq	$0x64, %rax, %rdx
               	addq	$0x0, %rdx
               	movl	%edx, (%r8)
               	imulq	$0x14, %rax, %rdx
               	leaq	(%rsi,%rdx), %r8
               	imulq	$0x64, %rax, %rdx
               	incq	%rdx
               	movl	%edx, 0x4(%r8)
               	imulq	$0x14, %rax, %rdx
               	leaq	(%rsi,%rdx), %r8
               	imulq	$0x64, %rax, %rdx
               	addq	$0x2, %rdx
               	movl	%edx, 0x8(%r8)
               	imulq	$0x14, %rax, %rdx
               	leaq	(%rsi,%rdx), %r8
               	imulq	$0x64, %rax, %rdx
               	addq	$0x3, %rdx
               	movl	%edx, 0xc(%r8)
               	imulq	$0x14, %rax, %rdx
               	leaq	(%rsi,%rdx), %r8
               	imulq	$0x64, %rax, %rdx
               	addq	$0x4, %rdx
               	movl	%edx, 0x10(%r8)
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x3, %rax
               	jl	<addr>
               	xorq	%r9, %r9
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	imulq	$0x14, %r8, %rdx
               	addq	%rsi, %rdx
               	movslq	(%rdx,%rcx,4), %rbx
               	imulq	$0x64, %r8, %rdx
               	addq	%rcx, %rdx
               	movslq	%edx, %rdx
               	cmpq	%rdx, %rbx
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x5, %rcx
               	jl	<addr>
               	leaq	0x1(%r8), %r9
               	movslq	%r9d, %r8
               	cmpq	$0x3, %r8
               	jl	<addr>
               	xorq	%r9, %r9
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	imulq	$0x14, %r8, %rdx
               	addq	%rsi, %rdx
               	movslq	(%rdx,%rcx,4), %rbx
               	imulq	$0x64, %r8, %rdx
               	addq	%rcx, %rdx
               	movslq	%edx, %rdx
               	cmpq	%rdx, %rbx
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x5, %rcx
               	jl	<addr>
               	leaq	0x1(%r8), %r9
               	movslq	%r9d, %r8
               	cmpq	$0x3, %r8
               	jl	<addr>
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	imulq	$0xc, %rsi, %r8
               	leaq	(%rdi,%r8), %rbx
               	movq	%rcx, %r9
               	shlq	$0x2, %r9
               	addq	%r9, %rbx
               	addq	$0x0, %rbx
               	addq	%r9, %r8
               	addq	$0x0, %r8
               	movslq	%r8d, %r9
               	movb	%r9b, (%rbx)
               	imulq	$0xc, %rsi, %r8
               	leaq	(%rdi,%r8), %rbx
               	movq	%rcx, %r9
               	shlq	$0x2, %r9
               	addq	%r9, %rbx
               	addq	%r9, %r8
               	incq	%r8
               	movslq	%r8d, %r9
               	movb	%r9b, 0x1(%rbx)
               	imulq	$0xc, %rsi, %r8
               	leaq	(%rdi,%r8), %rbx
               	movq	%rcx, %r9
               	shlq	$0x2, %r9
               	addq	%r9, %rbx
               	addq	%r9, %r8
               	addq	$0x2, %r8
               	movslq	%r8d, %r9
               	movb	%r9b, 0x2(%rbx)
               	imulq	$0xc, %rsi, %r8
               	leaq	(%rdi,%r8), %rbx
               	movq	%rcx, %r9
               	shlq	$0x2, %r9
               	addq	%r9, %rbx
               	addq	%r9, %r8
               	addq	$0x3, %r8
               	movslq	%r8d, %r9
               	movb	%r9b, 0x3(%rbx)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x3, %rcx
               	jl	<addr>
               	leaq	0x1(%rsi), %rdx
               	movslq	%edx, %rsi
               	cmpq	$0x2, %rsi
               	jl	<addr>
               	xorq	%rbx, %rbx
               	jmp	<addr>
               	xorq	%r8, %r8
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	imulq	$0xc, %r12, %rdx
               	leaq	(%rdi,%rdx), %r13
               	movq	%r9, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %r13
               	addq	%rcx, %r13
               	movsbq	(%r13), %r13
               	addq	%rsi, %rdx
               	addq	%rcx, %rdx
               	movslq	%edx, %rsi
               	movsbq	%sil, %rdx
               	cmpq	%rdx, %r13
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x4, %rcx
               	jl	<addr>
               	leaq	0x1(%r9), %r8
               	movslq	%r8d, %r9
               	cmpq	$0x3, %r9
               	jl	<addr>
               	leaq	0x1(%r12), %rbx
               	movslq	%ebx, %r12
               	cmpq	$0x2, %r12
               	jl	<addr>
               	xorq	%rbx, %rbx
               	jmp	<addr>
               	xorq	%r8, %r8
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	imulq	$0xc, %r12, %rdx
               	leaq	(%rdi,%rdx), %r13
               	movq	%r9, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %r13
               	addq	%rcx, %r13
               	movsbq	(%r13), %r13
               	addq	%rsi, %rdx
               	addq	%rcx, %rdx
               	movslq	%edx, %rsi
               	movsbq	%sil, %rdx
               	cmpq	%rdx, %r13
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x4, %rcx
               	jl	<addr>
               	leaq	0x1(%r9), %r8
               	movslq	%r8d, %r9
               	cmpq	$0x3, %r9
               	jl	<addr>
               	leaq	0x1(%r12), %rbx
               	movslq	%ebx, %r12
               	cmpq	$0x2, %r12
               	jl	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	imulq	$0xc, %rbx, %rcx
               	addq	$0x6e, %rcx
               	movq	%r8, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	imulq	$0xc, %rbx, %rcx
               	addq	$0x50, %rcx
               	movq	%r8, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
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
               	movq	0x18(%rsp), %r14
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
               	movq	0x18(%rsp), %r14
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0x1c(%rcx), %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0x14(%rcx), %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
