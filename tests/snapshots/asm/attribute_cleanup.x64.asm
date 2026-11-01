
attribute_cleanup.x64:	file format elf64-x86-64

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

<nested>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movslq	%edi, %rdi
               	movl	$0xa, -0x18(%rbp)
               	movl	$0xb, -0x10(%rbp)
               	movl	$0xc, -0x8(%rbp)
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	-0x8(%rbp), %esi
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %rax # <addr>
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rax)
               	movl	%esi, (%rcx,%rdx,4)
               	movl	-0x10(%rbp), %esi
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rax)
               	movl	%esi, (%rcx,%rdx,4)
               	movl	-0x18(%rbp), %esi
               	leaq	<rip>, %rax # <addr>
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rax)
               	movl	%esi, (%rcx,%rdx,4)
               	movl	$0x3e7, %eax            # imm = 0x3E7
               	leave
               	retq
               	movl	-0x8(%rbp), %esi
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %rax # <addr>
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rax)
               	movl	%esi, (%rcx,%rdx,4)
               	movl	-0x10(%rbp), %esi
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rax)
               	movl	%esi, (%rcx,%rdx,4)
               	movl	-0x18(%rbp), %esi
               	leaq	<rip>, %rax # <addr>
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rax)
               	movl	%esi, (%rcx,%rdx,4)
               	xorl	%eax, %eax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%rbx
               	leaq	<rip>, %rax # <addr>
               	movl	$0x0, (%rax)
               	movl	$0x1, -0x18(%rbp)
               	movl	$0x2, -0x10(%rbp)
               	movl	$0x3, -0x8(%rbp)
               	leaq	<rip>, %rcx # <addr>
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rax)
               	movl	$0x3, (%rcx,%rdx,4)
               	movl	-0x10(%rbp), %esi
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rax)
               	movl	%esi, (%rcx,%rdx,4)
               	movl	-0x18(%rbp), %esi
               	leaq	<rip>, %rax # <addr>
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rax)
               	movl	%esi, (%rcx,%rdx,4)
               	movl	(%rax), %ecx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movl	(%rcx), %edx
               	cmpl	$0x3, %edx
               	jne	<addr>
               	movl	0x4(%rcx), %edx
               	cmpl	$0x2, %edx
               	jne	<addr>
               	movl	0x8(%rcx), %edx
               	cmpl	$0x1, %edx
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x0, (%rax)
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x1, (%rsi)
               	movl	$0x0, -0x8(%rbp)
               	movl	(%rsi), %edi
               	movl	$0x0, (%rsi)
               	movslq	(%rax), %rsi
               	leaq	0x1(%rsi), %r9
               	movl	%r9d, (%rax)
               	movl	$0x2bc, (%rcx,%rsi,4)   # imm = 0x2BC
               	cmpl	$0x1, %edi
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movl	(%rcx), %eax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movl	(%rdi), %eax
               	cmpl	$0x2bc, %eax            # imm = 0x2BC
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x0, (%rcx)
               	movl	$0x32, -0x10(%rbp)
               	leaq	<rip>, %r8 # <addr>
               	leaq	<rip>, %rdx # <addr>
               	xorl	%eax, %eax
               	movl	%eax, -0x8(%rbp)
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	-0x8(%rbp), %r9d
               	movslq	(%rcx), %rsi
               	leaq	0x1(%rsi), %rbx
               	movl	%ebx, (%rcx)
               	movl	%r9d, (%rdi,%rsi,4)
               	jmp	<addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	-0x8(%rbp), %r9d
               	movslq	(%rdx), %rsi
               	leaq	0x1(%rsi), %rbx
               	movl	%ebx, (%rdx)
               	movl	%r9d, (%r8,%rsi,4)
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	movl	-0x10(%rbp), %edx
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rax # <addr>
               	movslq	(%rax), %rcx
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, (%rax)
               	movl	%edx, (%rsi,%rcx,4)
               	movl	(%rax), %eax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	movl	0x4(%rax), %ecx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movl	0x8(%rax), %ecx
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	movl	0xc(%rax), %eax
               	cmpl	$0x32, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	movl	$0x0, (%rax)
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpl	$0x3e7, %eax            # imm = 0x3E7
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movl	(%rcx), %eax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax), %edx
               	cmpl	$0xc, %edx
               	jne	<addr>
               	movl	0x4(%rax), %edx
               	cmpl	$0xb, %edx
               	jne	<addr>
               	movl	0x8(%rax), %eax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%edi, %edi
               	movl	%edi, (%rcx)
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax), %ecx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movl	(%rcx), %edx
               	cmpl	$0xc, %edx
               	jne	<addr>
               	movl	0x4(%rcx), %edx
               	cmpl	$0xb, %edx
               	jne	<addr>
               	movl	0x8(%rcx), %edx
               	cmpl	$0xa, %edx
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x0, (%rax)
               	movl	$0x28, -0x18(%rbp)
               	movl	$0x29, -0x8(%rbp)
               	movslq	(%rax), %rsi
               	leaq	0x1(%rsi), %r8
               	movl	%r8d, (%rax)
               	movl	$0x29, (%rcx,%rsi,4)
               	movl	-0x18(%rbp), %edi
               	movslq	(%rax), %rsi
               	leaq	0x1(%rsi), %r8
               	movl	%r8d, (%rax)
               	movl	%edi, (%rcx,%rsi,4)
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax), %ecx
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movl	(%rcx), %esi
               	cmpl	$0x29, %esi
               	jne	<addr>
               	movl	0x4(%rcx), %esi
               	cmpl	$0x28, %esi
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x0, (%rax)
               	movl	$0x28, -0x18(%rbp)
               	movl	$0x29, -0x8(%rbp)
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rax)
               	movl	$0x29, (%rcx,%rdx,4)
               	movl	-0x18(%rbp), %esi
               	leaq	<rip>, %rax # <addr>
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rax)
               	movl	%esi, (%rcx,%rdx,4)
               	movl	(%rax), %ecx
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movl	(%rcx), %edx
               	cmpl	$0x29, %edx
               	jne	<addr>
               	movl	0x4(%rcx), %edx
               	cmpl	$0x28, %edx
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x0, (%rax)
               	movl	$0x14, -0x10(%rbp)
               	movl	$0x15, -0x8(%rbp)
               	leaq	<rip>, %rax # <addr>
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rax)
               	movl	$0x15, (%rcx,%rdx,4)
               	movl	-0x10(%rbp), %esi
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rax)
               	movl	%esi, (%rcx,%rdx,4)
               	movl	(%rax), %eax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movl	(%rcx), %eax
               	cmpl	$0x15, %eax
               	jne	<addr>
               	movl	0x4(%rcx), %eax
               	cmpl	$0x14, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	movl	$0x0, (%rax)
               	movl	$0x14, -0x10(%rbp)
               	movl	$0x15, -0x8(%rbp)
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rax)
               	movl	$0x15, (%rcx,%rdx,4)
               	movl	-0x10(%rbp), %esi
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %rdi
               	movl	%edi, (%rax)
               	movl	%esi, (%rcx,%rdx,4)
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax), %ecx
               	cmpl	$0x15, %ecx
               	jne	<addr>
               	movl	0x4(%rax), %eax
               	cmpl	$0x14, %eax
               	je	<addr>
               	movl	$0x11, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	-0x8(%rbp), %edx
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rax # <addr>
               	movslq	(%rax), %rcx
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, (%rax)
               	movl	%edx, (%rsi,%rcx,4)
               	jmp	<addr>
