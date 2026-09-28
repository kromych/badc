
goto_cleanup_scopes.x64:	file format elf64-x86-64

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

<exits>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	xorl	%edx, %edx
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rax
               	movq	%rdx, %rsi
               	movl	%edx, -0x8(%rbp)
               	movl	%edx, -0x8(%rbp)
               	movl	%edx, -0x8(%rbp)
               	movl	%edx, -0x8(%rbp)
               	testl	%edi, %edi
               	je	<addr>
               	cmpl	$0x1, %edi
               	je	<addr>
               	cmpl	$0x2, %edi
               	jne	<addr>
               	testl	%esi, %esi
               	jne	<addr>
               	movslq	(%rax), %r8
               	leaq	0x1(%r8), %rbx
               	movl	%ebx, (%rax)
               	movb	$0x64, (%rcx,%r8)
               	movslq	(%rax), %r8
               	movb	$0x0, (%rcx,%r8)
               	movslq	(%rax), %r8
               	leaq	0x1(%r8), %rbx
               	movl	%ebx, (%rax)
               	movb	$0x63, (%rcx,%r8)
               	movslq	(%rax), %r8
               	movb	$0x0, (%rcx,%r8)
               	movslq	(%rax), %r8
               	leaq	0x1(%r8), %rbx
               	movl	%ebx, (%rax)
               	movb	$0x62, (%rcx,%r8)
               	movslq	(%rax), %r8
               	movb	$0x0, (%rcx,%r8)
               	movslq	(%rax), %r8
               	leaq	0x1(%r8), %rbx
               	movl	%ebx, (%rax)
               	movb	$0x61, (%rcx,%r8)
               	movslq	(%rax), %r8
               	movb	$0x0, (%rcx,%r8)
               	jmp	<addr>
               	cmpl	$0x3, %edi
               	je	<addr>
               	movslq	(%rax), %r8
               	leaq	0x1(%r8), %rbx
               	movl	%ebx, (%rax)
               	movb	$0x64, (%rcx,%r8)
               	movslq	(%rax), %r8
               	movb	$0x0, (%rcx,%r8)
               	movslq	(%rax), %r8
               	leaq	0x1(%r8), %rbx
               	movl	%ebx, (%rax)
               	movb	$0x63, (%rcx,%r8)
               	movslq	(%rax), %r8
               	movb	$0x0, (%rcx,%r8)
               	movslq	(%rax), %r8
               	leaq	0x1(%r8), %rbx
               	movl	%ebx, (%rax)
               	movb	$0x2e, (%rcx,%r8)
               	movslq	(%rax), %r8
               	movb	$0x0, (%rcx,%r8)
               	movslq	(%rax), %r8
               	leaq	0x1(%r8), %rbx
               	movl	%ebx, (%rax)
               	movb	$0x62, (%rcx,%r8)
               	movslq	(%rax), %r8
               	movb	$0x0, (%rcx,%r8)
               	movslq	(%rax), %r8
               	leaq	0x1(%r8), %rbx
               	movl	%ebx, (%rax)
               	movb	$0x61, (%rcx,%r8)
               	movslq	(%rax), %r8
               	movb	$0x0, (%rcx,%r8)
               	incq	%rsi
               	cmpl	$0x2, %esi
               	jl	<addr>
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rax)
               	movb	$0x7c, (%rcx,%rdx)
               	movslq	(%rax), %rdx
               	xorl	%eax, %eax
               	movb	%al, (%rcx,%rdx)
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rcx)
               	movb	$0x64, (%rax,%rdx)
               	movslq	(%rcx), %rsi
               	movb	$0x0, (%rax,%rsi)
               	movslq	(%rcx), %rsi
               	leaq	0x1(%rsi), %r8
               	movl	%r8d, (%rcx)
               	movb	$0x63, (%rax,%rsi)
               	movslq	(%rcx), %rcx
               	movb	$0x0, (%rax,%rcx)
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rsi
               	leaq	0x1(%rsi), %r8
               	movl	%r8d, (%rcx)
               	movb	$0x62, (%rax,%rsi)
               	movslq	(%rcx), %rsi
               	movb	$0x0, (%rax,%rsi)
               	leaq	<rip>, %rax
               	movslq	(%rcx), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rcx)
               	movb	$0x61, (%rax,%rdx)
               	movslq	(%rcx), %rcx
               	movb	$0x0, (%rax,%rcx)
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rcx)
               	movb	$0x64, (%rax,%rdx)
               	movslq	(%rcx), %rsi
               	movb	$0x0, (%rax,%rsi)
               	movslq	(%rcx), %rsi
               	leaq	0x1(%rsi), %r8
               	movl	%r8d, (%rcx)
               	movb	$0x63, (%rax,%rsi)
               	movslq	(%rcx), %rcx
               	movb	$0x0, (%rax,%rcx)
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rsi
               	leaq	0x1(%rsi), %r8
               	movl	%r8d, (%rcx)
               	movb	$0x62, (%rax,%rsi)
               	movslq	(%rcx), %rsi
               	movb	$0x0, (%rax,%rsi)
               	leaq	<rip>, %rax
               	movslq	(%rcx), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rcx)
               	movb	$0x61, (%rax,%rdx)
               	movslq	(%rcx), %rcx
               	movb	$0x0, (%rax,%rcx)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rcx)
               	movb	$0x64, (%rax,%rdx)
               	movslq	(%rcx), %rsi
               	movb	$0x0, (%rax,%rsi)
               	movslq	(%rcx), %rsi
               	leaq	0x1(%rsi), %r8
               	movl	%r8d, (%rcx)
               	movb	$0x63, (%rax,%rsi)
               	movslq	(%rcx), %rcx
               	movb	$0x0, (%rax,%rcx)
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rsi
               	leaq	0x1(%rsi), %r8
               	movl	%r8d, (%rcx)
               	movb	$0x62, (%rax,%rsi)
               	movslq	(%rcx), %rsi
               	movb	$0x0, (%rax,%rsi)
               	leaq	<rip>, %rax
               	movslq	(%rcx), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rcx)
               	movb	$0x61, (%rax,%rdx)
               	movslq	(%rcx), %rcx
               	movb	$0x0, (%rax,%rcx)
               	jmp	<addr>

<nested>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %rdi
               	movl	$0x0, -0x8(%rbp)
               	movl	$0x0, -0x8(%rbp)
               	movl	$0x0, -0x8(%rbp)
               	testq	%rdi, %rdi
               	je	<addr>
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rsi
               	leaq	0x1(%rsi), %r8
               	movl	%r8d, (%rcx)
               	movb	$0x63, (%rdx,%rsi)
               	movslq	(%rcx), %rsi
               	movb	$0x0, (%rdx,%rsi)
               	movslq	(%rcx), %rax
               	leaq	0x1(%rax), %rdi
               	movl	%edi, (%rcx)
               	movb	$0x62, (%rdx,%rax)
               	movslq	(%rcx), %rax
               	movb	$0x0, (%rdx,%rax)
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	leaq	0x1(%rsi), %r8
               	movl	%r8d, (%rax)
               	movb	$0x61, (%rdx,%rsi)
               	movslq	(%rax), %rax
               	movb	$0x0, (%rdx,%rax)
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rax)
               	movb	$0x7c, (%rcx,%rdx)
               	movslq	(%rax), %rax
               	movb	$0x0, (%rcx,%rax)
               	leave
               	retq
               	movl	$0x0, -0x8(%rbp)
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rsi
               	leaq	0x1(%rsi), %r8
               	movl	%r8d, (%rcx)
               	movb	$0x64, (%rdx,%rsi)
               	movslq	(%rcx), %rsi
               	movb	$0x0, (%rdx,%rsi)
               	movslq	(%rcx), %rax
               	leaq	0x1(%rax), %rdi
               	movl	%edi, (%rcx)
               	movb	$0x63, (%rdx,%rax)
               	movslq	(%rcx), %rax
               	movb	$0x0, (%rdx,%rax)
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %r8
               	movl	%r8d, (%rax)
               	movb	$0x62, (%rcx,%rdx)
               	movslq	(%rax), %rdx
               	movb	$0x0, (%rcx,%rdx)
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rax)
               	movb	$0x61, (%rcx,%rdx)
               	movslq	(%rax), %rax
               	movb	$0x0, (%rcx,%rax)
               	jmp	<addr>

<from_case>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	cmpl	$0x1, %edi
               	jl	<addr>
               	movl	$0x0, -0x8(%rbp)
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	leaq	0x1(%rsi), %r8
               	movl	%r8d, (%rax)
               	movb	$0x2d, (%rcx,%rsi)
               	movslq	(%rax), %rsi
               	movb	$0x0, (%rcx,%rsi)
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rax)
               	movb	$0x62, (%rcx,%rdx)
               	movslq	(%rax), %rax
               	movb	$0x0, (%rcx,%rax)
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rax)
               	movb	$0x7c, (%rcx,%rdx)
               	movslq	(%rax), %rax
               	movb	$0x0, (%rcx,%rax)
               	leave
               	retq
               	movl	$0x0, -0x8(%rbp)
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	leaq	0x1(%rsi), %r8
               	movl	%r8d, (%rax)
               	movb	$0x61, (%rdx,%rsi)
               	movslq	(%rax), %rax
               	movb	$0x0, (%rdx,%rax)
               	jmp	<addr>

<computed>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	leaq	<rip>, %rdx        # <addr>
               	movl	$0x0, -0x8(%rbp)
               	movl	$0x0, -0x8(%rbp)
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rdi
               	leaq	0x1(%rdi), %r9
               	movl	%r9d, (%rsi)
               	movb	$0x62, (%rcx,%rdi)
               	movslq	(%rsi), %rsi
               	movb	$0x0, (%rcx,%rsi)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	leaq	0x1(%rsi), %r8
               	movl	%r8d, (%rax)
               	movb	$0x61, (%rcx,%rsi)
               	movslq	(%rax), %rdi
               	movb	$0x0, (%rcx,%rdi)
               	jmpq	*%rdx
               	leaq	<rip>, %rcx
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %r8
               	movl	%r8d, (%rax)
               	movb	$0x7c, (%rcx,%rdx)
               	movslq	(%rax), %rax
               	movb	$0x0, (%rcx,%rax)
               	leave
               	retq
               	leaq	<rip>, %rcx
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %r8
               	movl	%r8d, (%rax)
               	movb	$0x21, (%rcx,%rdx)
               	movslq	(%rax), %rax
               	movb	$0x0, (%rcx,%rax)
               	leave
               	retq
               	leaq	-<rip>, %rdx       # <addr>
               	jmp	<addr>

<dispatch>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%r12
               	xorl	%esi, %esi
               	movl	%esi, -0x8(%rbp)
               	leaq	-0x10(%rbp), %r8
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	leaq	<rip>, %r9
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	0x8(%r8), %rdx
               	movq	%rsi, %rcx
               	jmpq	*%rdx
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %r12
               	movl	%r12d, (%rax)
               	movb	$0x78, (%rdi,%rdx)
               	movslq	(%rax), %rdx
               	movb	%sil, (%rdi,%rdx)
               	incq	%rcx
               	movzbq	(%r9,%rcx), %rdx
               	movq	(%r8,%rdx,8), %rdx
               	jmpq	*%rdx
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rax)
               	movb	$0x7c, (%rcx,%rdx)
               	movslq	(%rax), %rsi
               	movb	$0x0, (%rcx,%rsi)
               	movslq	(%rax), %rsi
               	leaq	0x1(%rsi), %r8
               	movl	%r8d, (%rax)
               	movb	$0x61, (%rcx,%rsi)
               	movslq	(%rax), %rax
               	movb	$0x0, (%rcx,%rax)
               	popq	%r12
               	leave
               	retq

<mutex_lock>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	cmpl	$0x0, (%rdi)
               	je	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	movl	$0x1, (%rdi)
               	movslq	0x4(%rdi), %rax
               	incq	%rax
               	movl	%eax, 0x4(%rdi)
               	popq	%rbp
               	retq

<mutex_unlock>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	cmpl	$0x0, (%rdi)
               	jne	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	movl	$0x0, (%rdi)
               	popq	%rbp
               	retq

<__free_kfree>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	(%rdi), %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	popq	%rbp
               	retq

<guarded>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	leaq	<rip>, %rdi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	%rax, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rax
               	cmpq	$0x0, (%rax)
               	testl	%ebx, %ebx
               	jne	<addr>
               	movq	(%rax), %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	callq	<addr>
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	imulq	$0x64, %rcx, %rcx
               	addq	%rcx, %rax
               	popq	%rbx
               	leave
               	retq
               	movq	(%rax), %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	callq	<addr>
               	leaq	<rip>, %rdi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	%rax, -0x18(%rbp)
               	movl	$0x10, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	cmpl	$0x1, %ebx
               	jne	<addr>
               	leaq	-0x10(%rbp), %rdi
               	callq	<addr>
               	movq	-0x18(%rbp), %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	callq	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	movl	$0x10, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, -0x8(%rbp)
               	cmpl	$0x2, %ebx
               	jne	<addr>
               	leaq	-0x8(%rbp), %rdi
               	callq	<addr>
               	leaq	-0x10(%rbp), %rdi
               	callq	<addr>
               	movq	-0x18(%rbp), %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	callq	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rdi
               	callq	<addr>
               	leaq	-0x10(%rbp), %rdi
               	callq	<addr>
               	movq	-0x18(%rbp), %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	callq	<addr>
               	movl	$0x8, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rax
               	movq	(%rax), %rdi
               	movq	$0x0, (%rax)
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpl	$0x3, %ebx
               	jne	<addr>
               	leaq	-0x18(%rbp), %rdi
               	callq	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rdi
               	callq	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	xorl	%eax, %eax
               	movl	%eax, -0x10(%rbp)
               	leaq	<rip>, %rcx
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rdx
               	movl	$0x1, (%rdx)
               	movq	%rdx, -0x8(%rbp)
               	movl	%eax, (%rdx)
               	movslq	(%rcx), %rsi
               	incq	%rsi
               	movl	%esi, (%rcx)
               	cmpl	$0x0, (%rdx)
               	jne	<addr>
               	movslq	(%rcx), %rax
               	cmpl	$0x1, %eax
               	sete	%al
               	movzbq	%al, %rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rdx
               	incq	%rdx
               	movl	%edx, (%rcx)
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	movslq	(%rcx), %rcx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x0, (%rax)
               	leaq	<rip>, %rcx
               	movl	$0x1, (%rcx)
               	movl	$0x0, (%rcx)
               	movslq	(%rax), %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	movl	$0x1, (%rcx)
               	xorl	%eax, %eax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rcx
               	incq	%rcx
               	movl	%ecx, (%rdx)
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movslq	(%rdx), %rsi
               	cmpl	$0x2, %esi
               	sete	%dil
               	movzbq	%dil, %rdi
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %r8
               	incq	%r8
               	movl	%r8d, (%rsi)
               	testl	%edi, %edi
               	jne	<addr>
               	leaq	<rip>, %rdi
               	cmpl	$0x0, (%rdi)
               	jne	<addr>
               	movslq	(%rsi), %rsi
               	movl	%esi, (%rdi)
               	movl	%eax, (%rdx)
               	movq	%rax, %rdx
               	movl	$0x1, (%rcx)
               	movq	%rcx, -0x8(%rbp)
               	incq	%rdx
               	cmpl	$0x2, %eax
               	jge	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x0, (%rsi)
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rdi
               	incq	%rdi
               	movl	%edi, (%rsi)
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x0, (%rsi)
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rdi
               	incq	%rdi
               	movl	%edi, (%rsi)
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x3, %edx
               	setne	%cl
               	movzbq	%cl, %rcx
               	addq	%rax, %rcx
               	xorl	%eax, %eax
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x3, %eax
               	sete	%al
               	movzbq	%al, %rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rdx
               	incq	%rdx
               	movl	%edx, (%rcx)
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	movslq	(%rcx), %rcx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rdx
               	xorl	%ecx, %ecx
               	movl	%ecx, (%rdx)
               	leaq	<rip>, %rax
               	movl	$0x1, (%rax)
               	movq	%rax, -0x8(%rbp)
               	movslq	(%rax), %rsi
               	movl	%esi, -0x10(%rbp)
               	movl	%ecx, (%rax)
               	movslq	(%rdx), %rsi
               	incq	%rsi
               	movl	%esi, (%rdx)
               	movslq	-0x10(%rbp), %rdx
               	cmpl	$0x1, %edx
               	jne	<addr>
               	movslq	(%rax), %rax
               	testl	%eax, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorl	%edx, %edx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x1, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	incq	%rsi
               	movl	%esi, (%rax)
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movslq	(%rax), %rax
               	movl	%eax, (%rcx)
               	movq	%rdx, %rdi
               	callq	<addr>
               	leaq	<rip>, %rdx
               	xorl	%eax, %eax
               	jmp	<addr>
               	movsbq	(%rcx,%rax), %rcx
               	movsbq	(%rdx,%rax), %rsi
               	cmpl	%esi, %ecx
               	jne	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	cmpb	$0x0, (%rcx,%rax)
               	jne	<addr>
               	leaq	<rip>, %rbx
               	movsbq	(%rbx,%rax), %rcx
               	movsbq	(%rdx,%rax), %rax
               	cmpl	%eax, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movslq	(%rax), %rax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rcx
               	movl	$0x0, (%rcx)
               	movb	$0x0, (%rbx)
               	movl	$0x1, %edi
               	callq	<addr>
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rbx,%rax)
               	je	<addr>
               	movsbq	(%rbx,%rax), %rdx
               	movsbq	(%rcx,%rax), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rbx,%rax)
               	jne	<addr>
               	leaq	<rip>, %rbx
               	movsbq	(%rbx,%rax), %rdx
               	movsbq	(%rcx,%rax), %rax
               	cmpl	%eax, %edx
               	sete	%cl
               	movzbq	%cl, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movslq	(%rax), %rax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rcx
               	movl	$0x0, (%rcx)
               	movb	$0x0, (%rbx)
               	movl	$0x2, %edi
               	callq	<addr>
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rbx,%rax)
               	je	<addr>
               	movsbq	(%rbx,%rax), %rdx
               	movsbq	(%rcx,%rax), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rbx,%rax)
               	jne	<addr>
               	leaq	<rip>, %rdx
               	movsbq	(%rdx,%rax), %rsi
               	movsbq	(%rcx,%rax), %rax
               	cmpl	%eax, %esi
               	sete	%cl
               	movzbq	%cl, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	incq	%rsi
               	movl	%esi, (%rax)
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movslq	(%rax), %rax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rcx
               	movl	$0x0, (%rcx)
               	movb	$0x0, (%rdx)
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpl	$0x1, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movslq	(%rax), %rax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rdx
               	xorl	%eax, %eax
               	jmp	<addr>
               	movsbq	(%rcx,%rax), %rcx
               	movsbq	(%rdx,%rax), %rsi
               	cmpl	%esi, %ecx
               	jne	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	cmpb	$0x0, (%rcx,%rax)
               	jne	<addr>
               	leaq	<rip>, %rbx
               	movsbq	(%rbx,%rax), %rcx
               	movsbq	(%rdx,%rax), %rax
               	cmpl	%eax, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movslq	(%rax), %rax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rcx
               	movl	$0x0, (%rcx)
               	movb	$0x0, (%rbx)
               	movl	$0x4, %edi
               	callq	<addr>
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rbx,%rax)
               	je	<addr>
               	movsbq	(%rbx,%rax), %rdx
               	movsbq	(%rcx,%rax), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rbx,%rax)
               	jne	<addr>
               	leaq	<rip>, %rbx
               	movsbq	(%rbx,%rax), %rdx
               	movsbq	(%rcx,%rax), %rax
               	cmpl	%eax, %edx
               	sete	%cl
               	movzbq	%cl, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movslq	(%rax), %rax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rcx
               	movl	$0x0, (%rcx)
               	movb	$0x0, (%rbx)
               	movl	$0x1, %edi
               	callq	<addr>
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rbx,%rax)
               	je	<addr>
               	movsbq	(%rbx,%rax), %rdx
               	movsbq	(%rcx,%rax), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rbx,%rax)
               	jne	<addr>
               	leaq	<rip>, %rbx
               	movsbq	(%rbx,%rax), %rdx
               	movsbq	(%rcx,%rax), %rax
               	cmpl	%eax, %edx
               	sete	%cl
               	movzbq	%cl, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movslq	(%rax), %rax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rax
               	xorl	%edi, %edi
               	movl	%edi, (%rax)
               	movb	%dil, (%rbx)
               	callq	<addr>
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rbx,%rax)
               	je	<addr>
               	movsbq	(%rbx,%rax), %rdx
               	movsbq	(%rcx,%rax), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rbx,%rax)
               	jne	<addr>
               	leaq	<rip>, %rdx
               	movsbq	(%rdx,%rax), %rsi
               	movsbq	(%rcx,%rax), %rax
               	cmpl	%eax, %esi
               	sete	%cl
               	movzbq	%cl, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	incq	%rsi
               	movl	%esi, (%rax)
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movslq	(%rax), %rax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rax
               	movl	$0x0, (%rax)
               	movb	$0x0, (%rdx)
               	movl	$0x78, -0x10(%rbp)
               	movl	$0x79, %esi
               	movl	%esi, -0x8(%rbp)
               	movq	%rsi, %rdi
               	movslq	(%rax), %rsi
               	leaq	0x1(%rsi), %r8
               	movl	%r8d, (%rax)
               	movb	%dil, (%rdx,%rsi)
               	movslq	(%rax), %rsi
               	movb	$0x0, (%rdx,%rsi)
               	movslq	(%rax), %rcx
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, (%rax)
               	movb	$0x7c, (%rdx,%rcx)
               	movslq	(%rax), %rcx
               	xorl	%eax, %eax
               	movb	%al, (%rdx,%rcx)
               	movslq	-0x10(%rbp), %rdi
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rsi
               	leaq	0x1(%rsi), %r8
               	movl	%r8d, (%rdx)
               	movb	%dil, (%rcx,%rsi)
               	movslq	(%rdx), %rdx
               	movb	%al, (%rcx,%rdx)
               	leaq	<rip>, %rdx
               	cmpb	$0x0, (%rcx,%rax)
               	je	<addr>
               	leaq	<rip>, %rsi
               	movsbq	(%rsi,%rax), %rsi
               	movsbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rcx,%rax)
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movsbq	(%rcx,%rax), %rsi
               	movsbq	(%rdx,%rax), %rax
               	cmpl	%eax, %esi
               	sete	%dl
               	movzbq	%dl, %rdx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	incq	%rsi
               	movl	%esi, (%rax)
               	testl	%edx, %edx
               	jne	<addr>
               	leaq	<rip>, %rdx
               	cmpl	$0x0, (%rdx)
               	jne	<addr>
               	movslq	(%rax), %rax
               	movl	%eax, (%rdx)
               	leaq	<rip>, %rax
               	movl	$0x0, (%rax)
               	movb	$0x0, (%rcx)
               	movslq	(%rax), %rdi
               	leaq	0x1(%rdi), %r8
               	movl	%r8d, (%rax)
               	movb	$0x61, (%rcx,%rdi)
               	movslq	(%rax), %rax
               	movb	$0x0, (%rcx,%rax)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rax)
               	movb	$0x61, (%rcx,%rdx)
               	movslq	(%rax), %rsi
               	movb	$0x0, (%rcx,%rsi)
               	leaq	<rip>, %rcx
               	movslq	(%rax), %rsi
               	leaq	0x1(%rsi), %r8
               	movl	%r8d, (%rax)
               	movb	$0x61, (%rcx,%rsi)
               	movslq	(%rax), %rsi
               	movb	$0x0, (%rcx,%rsi)
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rax)
               	movb	$0x7c, (%rcx,%rdx)
               	movslq	(%rax), %rdx
               	xorl	%eax, %eax
               	movb	%al, (%rcx,%rdx)
               	leaq	<rip>, %rdx
               	jmp	<addr>
               	movsbq	(%rcx,%rax), %rcx
               	movsbq	(%rdx,%rax), %rsi
               	cmpl	%esi, %ecx
               	jne	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	cmpb	$0x0, (%rcx,%rax)
               	jne	<addr>
               	leaq	<rip>, %rbx
               	movsbq	(%rbx,%rax), %rcx
               	movsbq	(%rdx,%rax), %rax
               	cmpl	%eax, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movslq	(%rax), %rax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rax
               	xorl	%edi, %edi
               	movl	%edi, (%rax)
               	movb	%dil, (%rbx)
               	callq	<addr>
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rbx,%rax)
               	je	<addr>
               	movsbq	(%rbx,%rax), %rdx
               	movsbq	(%rcx,%rax), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rbx,%rax)
               	jne	<addr>
               	leaq	<rip>, %rbx
               	movsbq	(%rbx,%rax), %rdx
               	movsbq	(%rcx,%rax), %rax
               	cmpl	%eax, %edx
               	sete	%cl
               	movzbq	%cl, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movslq	(%rax), %rax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rcx
               	movl	$0x0, (%rcx)
               	movb	$0x0, (%rbx)
               	movl	$0x1, %edi
               	callq	<addr>
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rbx,%rax)
               	je	<addr>
               	movsbq	(%rbx,%rax), %rdx
               	movsbq	(%rcx,%rax), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rbx,%rax)
               	jne	<addr>
               	leaq	<rip>, %rbx
               	movsbq	(%rbx,%rax), %rdx
               	movsbq	(%rcx,%rax), %rax
               	cmpl	%eax, %edx
               	sete	%cl
               	movzbq	%cl, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movslq	(%rax), %rax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rcx
               	movl	$0x0, (%rcx)
               	movb	$0x0, (%rbx)
               	movl	$0x1, %edi
               	callq	<addr>
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rbx,%rax)
               	je	<addr>
               	movsbq	(%rbx,%rax), %rdx
               	movsbq	(%rcx,%rax), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rbx,%rax)
               	jne	<addr>
               	leaq	<rip>, %rbx
               	movsbq	(%rbx,%rax), %rdx
               	movsbq	(%rcx,%rax), %rax
               	cmpl	%eax, %edx
               	sete	%cl
               	movzbq	%cl, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movslq	(%rax), %rax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rax
               	xorl	%edi, %edi
               	movl	%edi, (%rax)
               	movb	%dil, (%rbx)
               	callq	<addr>
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rbx,%rax)
               	je	<addr>
               	movsbq	(%rbx,%rax), %rdx
               	movsbq	(%rcx,%rax), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rbx,%rax)
               	jne	<addr>
               	leaq	<rip>, %rbx
               	movsbq	(%rbx,%rax), %rdx
               	movsbq	(%rcx,%rax), %rax
               	cmpl	%eax, %edx
               	sete	%cl
               	movzbq	%cl, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movslq	(%rax), %rax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rcx
               	movl	$0x0, (%rcx)
               	movb	$0x0, (%rbx)
               	callq	<addr>
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rbx,%rax)
               	je	<addr>
               	movsbq	(%rbx,%rax), %rdx
               	movsbq	(%rcx,%rax), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpb	$0x0, (%rbx,%rax)
               	jne	<addr>
               	leaq	<rip>, %rdx
               	movsbq	(%rdx,%rax), %rsi
               	movsbq	(%rcx,%rax), %rax
               	cmpl	%eax, %esi
               	sete	%cl
               	movzbq	%cl, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	incq	%rsi
               	movl	%esi, (%rax)
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movslq	(%rax), %rax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rax
               	xorl	%ebx, %ebx
               	movl	%ebx, (%rax)
               	movb	%bl, (%rdx)
               	leaq	<rip>, %rax
               	movl	$0x0, (%rax)
               	movq	%rbx, %rdi
               	callq	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx,%rbx,4), %rcx
               	cmpl	%ecx, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx,%rbx,4), %rcx
               	cmpl	%ecx, %eax
               	sete	%al
               	movzbq	%al, %rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rdx
               	incq	%rdx
               	movl	%edx, (%rcx)
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	movslq	(%rcx), %rcx
               	movl	%ecx, (%rax)
               	incq	%rbx
               	cmpl	$0x5, %ebx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x9, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movslq	(%rax), %rax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	leave
               	retq
               	movq	%rdx, %rcx
               	jmp	<addr>
               	movq	%rax, %rdi
               	jmp	<addr>
